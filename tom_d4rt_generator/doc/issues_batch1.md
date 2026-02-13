# D4rt Bridge Generator — Issue Analysis (Batch 1)

> Last updated: 2026-02-13
>
> This document provides comprehensive explanations for all 7 issues originally marked "Won't Fix" in the D4rt Bridge Generator. Each decision is documented with full technical context including the root cause, the architectural constraints that prevent a fix, code-level analysis, reproduction details, and rationale.

---

## Table of Contents

| ID | Description | Category |
|----|-------------|----------|
| [G-PAR-6](#g-par-6--interpreter-collection-type-erasure) | Interpreter collection type erasure | Runtime Type System |
| [G-GNRC-7](#g-gnrc-7--f-bounded-polymorphism-and-bridgedinstance-sort) | F-bounded polymorphism and BridgedInstance sort | Runtime Type System |
| [G-OP-8](#g-op-8--operator--equality-on-bridged-instances) | Operator == equality on bridged instances | Bridge Semantics |
| [G-TYPE-1](#g-type-1--record-parameter-type-conversion) | Record parameter type conversion | Record Types |
| [G-TYPE-2](#g-type-2--record-return-type-property-access) | Record return type property access | Record Types |
| [G-TE-1](#g-te-1--bounded-type-parameter-erasure-in-nested-generics) | Bounded type parameter erasure in nested generics | Code Generation |
| [G-TE-2](#g-te-2--static-method-constrained-type-parameter-erasure) | Static method constrained type parameter erasure | Code Generation |

---

## Issue Details

---

### G-PAR-6 — Interpreter Collection Type Erasure

**Status:** TODO (with partial workaround in place)
**Category:** Runtime Type System
**Test:** `test/d4rt_coverage_test.dart` (line ~596)
**Script:** `example/d4_test_scripts/bin/dart_overview/par06_function_typed_param.dart`

#### The Problem

When the D4rt interpreter evaluates a list literal like `[1, 2, 3, 4, 5]`, it creates a `List<Object?>` — not a `List<int>`. This is because the interpreter has no way to infer the intended element type of a list literal at evaluation time. All values are stored as `Object?` in the interpreter's internal representation.

When this list is then passed to a bridged function that expects a typed list, the bridge's type-checking mechanism rejects it:

```dart
// Source library function
List<int> transform(List<int> numbers, int Function(int) transformer) {
  return numbers.map(transformer).toList();
}

// Generated bridge code
'transform': (visitor, positional, named, typeArgs) {
  final numbers = D4.getRequiredArg<List<int>>(positional, 0, 'numbers', 'transform');
  // ...
}
```

The call `D4.getRequiredArg<List<int>>()` invokes `extractBridgedArg<List<int>>()`, which performs the type check `unwrapped is List<int>`. Since the interpreter produced a `List<Object?>`, this check fails and throws:

```
Invalid parameter "numbers": expected List<int>, got List<Object?>
```

#### Current Workaround

The `extractBridgedArg` method in `d4.dart` (lines 145–226) includes string-based type introspection as a workaround for primitive element types:

```dart
if (unwrapped is List && T.toString().startsWith('List<')) {
  final elementType = T.toString().substring(5, T.toString().length - 1);
  if (elementType == 'int') {
    return (unwrapped.cast<int>().toList()) as T;
  } else if (elementType == 'double') {
    return (unwrapped.map((e) => e is int ? e.toDouble() : e)
        .cast<double>().toList()) as T;
  } else if (elementType == 'String') {
    return (unwrapped.cast<String>().toList()) as T;
  } else if (elementType == 'num') {
    return (unwrapped.cast<num>().toList()) as T;
  } else if (elementType == 'bool') {
    return (unwrapped.cast<bool>().toList()) as T;
  }
  // Falls through for non-primitive element types
  return unwrapped as T;
}
```

This workaround handles `List<int>`, `List<double>`, `List<String>`, `List<num>`, `List<bool>`, and `List<Object>`. The same pattern exists for `Set<T>` and `Map<K, V>`.

**The specific G-PAR-6 test currently passes** because of this workaround (`List<int>` is one of the handled primitive types).

#### Original Analysis (Previously Won't Fix)

The fundamental problem remains unsolvable for **non-primitive element types**:

1. **`List<MyClass>`** — When a list contains bridged objects, each element is a `BridgedInstance<MyClass>`. The runtime `T.toString()` produces `List<MyClass>`, but `cast<MyClass>()` would need to unwrap each `BridgedInstance` first. The `extractBridgedArg` method cannot generically unwrap `BridgedInstance` objects inside collections because it doesn't know the bridged class type at compile time.

2. **Nested generics** — `List<List<int>>`, `Map<String, List<int>>`, etc. require recursive introspection of the type string, which is fragile and impossible to do correctly for all cases through string parsing alone.

3. **The underlying issue is architectural** — Dart's reified generics mean that a `List<Object?>` and a `List<int>` are genuinely different types at runtime. The interpreter would need to track intended collection element types through the entire evaluation pipeline, which would require fundamental changes to how the interpreter creates and passes collections.

4. **String-based type introspection** (`T.toString()`) is inherently fragile. It depends on Dart's `Type.toString()` format, which is not guaranteed to be stable and cannot handle complex types like `List<Map<String, int>>` or `List<Comparable<SortablePerson>>`.

#### Possible Solutions

**Solution A: Dynamic-mode parameter extraction (RECOMMENDED — Fixable)**

Instead of `D4.getRequiredArg<List<int>>(...)` which enforces strict type checking, the generator could produce a "dynamic-mode" extraction for collection parameters that unwraps `BridgedInstance` elements:

```dart
// Current generated code (strict):
final numbers = D4.getRequiredArg<List<int>>(positional, 0, 'numbers', 'transform');

// Dynamic-mode generated code:
final numbers = D4.getListArg<int>(positional, 0, 'numbers', 'transform');
```

Where `D4.getListArg<T>` would be a new method that:
1. Takes the raw `List<Object?>` from the interpreter
2. Unwraps any `BridgedInstance` elements to their `nativeObject`
3. Attempts `.cast<T>()` inside a try-catch
4. On failure, passes the list `as dynamic` and lets the native function fail with a meaningful error

```dart
static List<T> getListArg<T>(List<Object?> positional, int index, String paramName, String methodName) {
  final raw = positional[index];
  if (raw is! List) throw ArgumentD4rtException('$methodName: "$paramName" expected List, got ${raw.runtimeType}');
  try {
    // Unwrap BridgedInstance elements and cast
    final unwrapped = raw.map((e) => e is BridgedInstance ? e.nativeObject : e).toList();
    return unwrapped.cast<T>();
  } catch (e) {
    throw ArgumentD4rtException('$methodName: "$paramName" element type mismatch: $e');
  }
}
```

This would handle `List<MyBridgedClass>` correctly because each `BridgedInstance<MyClass>` gets unwrapped to its `MyClass` native object before the cast. Similar methods for `Set<T>` and `Map<K, V>`.

**Effort:** Low-Medium. Add 3 helper methods to `D4`, update generator to emit them for collection parameters.
**Risk:** Low. The try-catch ensures failures produce meaningful errors rather than cryptic type cast exceptions.

**Solution B: Universal dynamic fallback in `extractBridgedArg`**

Add a final fallback before the `throw` that tries `unwrapped as dynamic` and wraps it in a try-catch:

```dart
// Last resort before throwing — try dynamic cast
try {
  return unwrapped as T;
} catch (_) {
  // Original error
  throw ArgumentD4rtException('Invalid parameter "$paramName": expected $T, got $actualType');
}
```

This already exists for the Map case (`return unwrapped as T` inside try-catch). Extending it to all types would make the method more forgiving. If the underlying Dart runtime can perform the cast, it succeeds; otherwise, we get a clean error.

**Effort:** Minimal. One-line change.
**Risk:** Low. The existing `as T` ALREADY fails for `List<Object?>` → `List<int>` (Dart reified generics), so this won't help for the collection case specifically. But it catches edge cases where the type IS assignable but the `is T` check fails due to inference differences.

**Solution C: Generator emits `dynamic` for collection type arguments**

Instead of `D4.getRequiredArg<List<int>>(...)`, generate `D4.getRequiredArg<List<dynamic>>(...)` and let the native function's own type system handle element type enforcement. The native `transform(List<int> numbers, ...)` would receive a `List<dynamic>` and fail naturally at the `.map()` call if element types don't match.

**Effort:** Low. Change type resolution for collection parameters.
**Risk:** Medium. The native function might NOT fail gracefully — it could produce incorrect results silently if elements happen to be the right type wrapped in `Object?`. Also, `List<dynamic>` is NOT assignable to `List<int>` in Dart's reified generics, so this actually won't compile without a `.cast()` or `as List<int>` at the call site.

**Verdict:** Solution A is the clearest path. It handles the BridgedInstance unwrapping within collections that the current code lacks, produces clean errors, and is a modest code change.

#### Affected Scenarios

- `List<MyBridgedClass>` parameters to bridged methods
- `Map<String, MyBridgedClass>` parameters
- `Set<MyBridgedClass>` parameters
- Any nested generic collection types with non-primitive elements

---

### G-GNRC-7 — F-Bounded Polymorphism and BridgedInstance Sort

**Status:** TODO
**Category:** Runtime Type System
**Test:** `test/d4rt_coverage_test.dart` (line ~663)
**Script:** `example/d4_test_scripts/bin/dart_overview/gnrc07_fbounded_polymorphism.dart`

#### The Problem

This issue manifests in two related failures when working with bridged classes that implement `Comparable<T>`:

**Failure 1: `runtimeType` comparison**

The test script compares `cmp.runtimeType != int`, where `cmp` is the result of `compareTo()`:

```dart
var cmp = alice.compareTo(bob);
if (cmp.runtimeType != int) {
  errors.add('compareTo should return int, got ${cmp.runtimeType}');
}
```

The actual error output is paradoxical:

```
GNRC07_FAILED
  - compareTo should return int, got int
```

The value IS an `int`, and `runtimeType` does return `int`, but the `!=` comparison against the `int` type literal evaluates incorrectly in the interpreter. This happens because the interpreter's handling of `Type` object comparison with type literals doesn't match native Dart semantics — in the interpreter, `runtimeType` returns the Dart host's `Type` object, and comparing it with the interpreted `int` type literal may produce a different object reference rather than the same `Type` instance.

**Failure 2: `List.sort()` with BridgedInstances**

The more fundamental failure is calling `people.sort()` on a list of bridged `SortablePerson` objects:

```dart
class SortablePerson implements Comparable<SortablePerson> {
  final String name;
  final int age;

  @override
  int compareTo(SortablePerson other) {
    int result = age.compareTo(other.age);
    if (result != 0) return result;
    return name.compareTo(other.name);
  }
}
```

When the interpreter creates `SortablePerson` instances via the bridge, they are wrapped in `BridgedInstance<Object>`. When `people.sort()` is called, Dart's native `List.sort()` implementation tries to cast elements to `Comparable<dynamic>`:

```
type 'BridgedInstance<Object>' is not a subtype of type 'Comparable<dynamic>' in type cast
```

#### Original Analysis (Previously Won't Fix)

1. **BridgedInstance wrapping is fundamental to the bridge architecture.** Every bridged object in the interpreter is wrapped in `BridgedInstance<T>` so the interpreter can track it, resolve method calls on it, and manage its lifecycle. Unwrapping all `BridgedInstance` objects before native collection operations would require:
   - Detecting when a native method expects `Comparable` elements
   - Unwrapping all elements in the list before the call
   - Re-wrapping them afterward
   - This creates a complex interception layer for every native collection method

2. **F-bounded polymorphism (`T extends Comparable<T>`)** creates a type relationship that cannot be expressed through the bridge. The bridge generates `SortablePerson` as a `BridgedClass` with `nativeType: SortablePerson`, but the `BridgedInstance` wrapper hides the `Comparable` interface from Dart's type system.

3. **The `runtimeType` issue** requires the interpreter to maintain a consistent `Type` object identity for each Dart type, matching the exact object references that native Dart uses. This is a deep interpreter semantics issue that would require a comprehensive `Type` system rewrite.

4. **Scope of impact** — Fixing this would require automatic BridgedInstance unwrapping/rewrapping for all native methods that use interface-based operations (sort, contains, indexOf, remove, etc.), which is a large surface area with many edge cases.

#### Source Code References

- Bridge class definition: `dart_overview_bridges.b.dart` (SortablePerson bridge, lines ~3019–3055)
- Interpreter `==`/`!=` handling: `interpreter_visitor.dart` (lines 1193–1243)
- No dedicated BridgedInstance-to-Comparable unwrapping exists in the interpreter

#### Possible Solutions

**Failure 1: `runtimeType != int` — Solution: Fix Type comparison (Fixable)**

The `runtimeType` comparison fails because the interpreter returns the Dart host `Type` object for `runtimeType`, but when comparing with the `int` type literal the interpreter may produce a different `Type` representation. This is a `runtimeType` comparison issue that likely exists broadly, not just for this test.

The fix would be to ensure the interpreter's `!=` operator properly handles `Type` objects: when comparing `value.runtimeType != int`, both sides should resolve to the same `Type` instance. This likely requires the interpreter's `visitSimpleIdentifier` to return the SAME `Type` object for `int` that Dart's runtime uses for `runtimeType`.

**Effort:** Medium. Requires understanding how the interpreter resolves type literals and ensuring consistency with `runtimeType` return values.
**Risk:** Low. This is a correctness fix for a specific comparison pattern.

**Failure 2: `List.sort()` with BridgedInstances — Solution: Unwrap-sort-rewrap (Fixable)**

The `people.sort()` call fails because `BridgedInstance<Object>` doesn't implement `Comparable<dynamic>`. The interpreter already intercepts method calls on lists — when it encounters `sort()` on a list containing `BridgedInstance` objects, it could:

1. **Detect the sort call** — the interpreter already handles list methods natively
2. **Provide a custom comparator** that unwraps `BridgedInstance` elements:

```dart
// In the interpreter's list method handling:
case 'sort':
  if (list.isNotEmpty && list.first is BridgedInstance) {
    // Sort by dispatching compareTo through the bridge
    list.sort((a, b) {
      final bridgedA = a as BridgedInstance;
      final bridgedB = b as BridgedInstance;
      final compareTo = bridgedA.bridgedClass.findInstanceMethodAdapter('compareTo');
      if (compareTo != null) {
        return compareTo(visitor, bridgedA.nativeObject, [bridgedB.nativeObject], {}, null) as int;
      }
      // Fallback: unwrap and use native sort
      return (bridgedA.nativeObject as Comparable).compareTo(bridgedB.nativeObject);
    });
    return null;
  }
  // Existing sort handling...
```

Alternatively, a simpler approach: unwrap ALL `BridgedInstance` elements to their `nativeObject` values before calling `sort()`, then re-wrap. Since the list already holds references to the bridge instances, the native objects can be sorted in-place:

```dart
// Simpler approach: unwrap, sort natively, rebuild
final nativeList = list.map((e) => e is BridgedInstance ? e.nativeObject : e).toList();
nativeList.sort();
list.clear();
list.addAll(nativeList.map((e) => /* re-wrap if needed */));
```

**Effort:** Medium. The interpreter already has list method interception; adding a special sort path is feasible.
**Risk:** Medium. Re-wrapping after sort may be tricky — the `BridgedInstance` wrappers hold specific bridge class references. However, since `sort()` is in-place and doesn't create new objects, the bridge instances' native objects are the same ones being sorted. If we can sort the BridgedInstances themselves using a comparator that delegates to the native `compareTo`, we avoid re-wrapping entirely.

**Overall Verdict:** Both sub-issues are independently fixable. The `runtimeType` issue is a general interpreter correctness issue; the sort issue requires a targeted interception in list method handling. Combined effort: Medium.

---

### G-OP-8 — Operator == Equality on Bridged Instances

**Status:** TODO
**Category:** Bridge Semantics
**Test:** `test/d4rt_coverage_test.dart` (line ~784)
**Script:** `example/d4_test_scripts/bin/dart_overview/op08_operator_equals.dart`

#### The Problem

Custom `operator ==` on bridged classes does not work correctly. The test creates two `Point` objects with the same values and expects them to be equal:

```dart
var p1 = Point(1, 2);
var p2 = Point(1, 2);
if (!(p1 == p2)) {
  errors.add('Point(1,2) == Point(1,2) expected true, got false');
}
```

The actual error:

```
OP08_FAILED
  - Point(1,2) == Point(1,2) expected true, got false
```

The `Point` class has a custom `operator ==`:

```dart
class Point {
  final int x;
  final int y;

  Point(this.x, this.y);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Point &&
          runtimeType == other.runtimeType &&
          x == other.x &&
          y == other.y;

  @override
  int get hashCode => Object.hash(x, y);
}
```

#### The Failure Chain

When the interpreter evaluates `p1 == p2`, it follows this path in `visitBinaryExpression` (lines 1037–1050 of `interpreter_visitor.dart`):

```dart
// Step 1: Unwrap BridgedInstance to native object
final leftBridgedInstance = toBridgedInstance(leftOperandValue);
final left = leftBridgedInstance.$2
    ? leftBridgedInstance.$1!.nativeObject
    : leftOperandValue;

final rightBridgedInstance = toBridgedInstance(rightOperandValue);
final right = rightBridgedInstance.$2
    ? rightBridgedInstance.$1!.nativeObject
    : rightOperandValue;
```

```dart
// Step 2: Fall through to native == (after enum checks don't match)
case '==':
  // ... BridgedEnumValue special cases (don't apply to Point) ...
  return left == right;
```

The problem is that `left` and `right` are now the unwrapped native `Point` objects. The native `Point.operator==` IS called, and it checks:

```dart
identical(this, other)  // false — two different instances
other is Point          // true
runtimeType == other.runtimeType  // should be true
x == other.x && y == other.y     // should be true
```

However, the `runtimeType == other.runtimeType` check may fail because the bridge creates `Point` objects through different constructor paths, or the `runtimeType` comparison in the native Dart context doesn't work as expected when objects were created via bridge constructors vs regular constructors. The exact failure point depends on how the bridge constructor creates the native `Point` instance and whether the `runtimeType` matches between two bridge-created instances.

An alternative explanation: the interpreter may not be correctly unwrapping BOTH operands — if one side remains a `BridgedInstance` while the other is unwrapped, the native `operator ==` would fail at `other is Point` because a `BridgedInstance<Object>` is not a `Point`.

#### Original Analysis (Previously Won't Fix)

1. **Operator == bridging is architecturally complex.** The generated bridge does NOT include `operator ==` as a bridged method. The bridge class definition for `Point` has constructors, getters, and methods, but operators are not bridged:

   ```dart
   BridgedClass _createPointBridge() {
     return BridgedClass(
       nativeType: $pkg.Point,
       name: 'Point',
       constructors: { /* ... */ },
       getters: { /* x, y */ },
       // NOTE: No operators section
     );
   }
   ```

2. **The interpreter's `==` handling** goes through a generic path that unwraps BridgedInstances and delegates to native `==`. But this unwrapping may not be symmetric, or the bridge constructor creates objects with subtle differences in type identity.

3. **Fixing this properly** would require either:
   - **Bridge all operator == implementations** — The generator would need to detect custom `operator ==` overrides and bridge them, then the interpreter would need to intercept `==` and dispatch to the bridged operator method. This is complex because `operator ==` is defined on `Object` and overridden per class, requiring the interpreter to check for bridged overrides before falling through to native `==`.
   - **Ensure perfect BridgedInstance unwrapping** — The interpreter would need guaranteed symmetric unwrapping of both operands, correct `runtimeType` handling, and correct `is` type check behavior for unwrapped bridge-created objects.

4. **Edge cases are numerous** — operator `==` interacts with hashCode, collection lookups (HashMap, HashSet), pattern matching, and switch statements. Getting it right for all cases requires comprehensive changes across the interpreter.

#### Possible Solutions

**Solution A: Bridge `operator ==` and dispatch through bridge methods (RECOMMENDED — Fixable)**

Investigation reveals that the generator DOES bridge `operator ==` for some classes (e.g., `NumberWrapper` has `'=='` in its `methods` map) but NOT for `Point`. This suggests a generator bug where `operator ==` is skipped for certain classes.

The fix has two parts:

**Part 1: Generator — ensure all classes with custom `operator ==` get it bridged**

The generator already has the infrastructure to bridge operators as methods. `NumberWrapper` proves this works:
```dart
// Already generated for NumberWrapper:
'==': (visitor, target, positional, named, typeArgs) {
  final t = D4.validateTarget<$pkg.NumberWrapper>(target, 'NumberWrapper');
  final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
  return t == other;
},
```

The fix is to ensure the same generation happens for `Point` and all other classes that override `operator ==`. This may be a filter/exclusion bug in the generator that skips `operator ==` for classes that don't have other operator declarations.

**Part 2: Interpreter — fix the `==` dispatch path for bridged classes**

Looking at the interpreter's `visitBinaryExpression` (lines 1100-1125), it ALREADY checks for bridged operator methods:
```dart
if (toBridgedInstance(leftOperandValue).$2) {
  final methodAdapter = bridgedClass.findInstanceMethodAdapter('==');
  if (methodAdapter != null) {
    // Calls the bridged == operator
    return methodAdapter(this, bridgedInstance.nativeObject, [rightArg], {}, null);
  }
}
```

And it correctly unwraps the right operand for the method call:
```dart
final rightArg = toBridgedInstance(rightOperandValue).$2
    ? toBridgedInstance(rightOperandValue).$1!.nativeObject
    : rightOperandValue;
```

So both native `Point` objects would be passed to the native `operator ==`. The `other is Point` check would succeed because both are actual `Point` instances. The `runtimeType` comparison would succeed because both are the same class.

**This means the fix is primarily a generator issue — ensure all classes with custom `operator ==` get it bridged.** The interpreter path already works correctly.

**Effort:** Low. Investigate why the generator skips `operator ==` for `Point` (likely a method-filtering condition), fix the filter.
**Risk:** Low. The runtime dispatch path is already tested and working for `NumberWrapper`.

**Solution B: Fallback unwrapping in the `==` case**

If the bridged operator is not found, the code falls through to `return left == right` where `left` and `right` are unwrapped native objects. This SHOULD work for `Point` since both are native `Point` instances with correct `is Point`, `runtimeType`, and field equality checks.

If it still fails, add explicit debug logging to trace the exact failure point. The `runtimeType == other.runtimeType` check inside `Point.operator==` might fail due to a Dart runtime edge case when both objects are created through bridge constructors.

**Effort:** Low. Add logging, verify the unwrap path.
**Risk:** Minimal.

**Verdict:** G-OP-8 is likely fixable by fixing the generator to bridge `operator ==` for Point. The interpreter already handles bridged `==` correctly for NumberWrapper. Estimated effort: Low.

---

### G-TYPE-1 — Record Parameter Type Conversion

**Status:** TODO
**Category:** Record Types
**Test:** `test/d4rt_coverage_test.dart` (line ~891)
**Script:** `example/d4_test_scripts/bin/dart_overview/type01_record_param.dart`

#### The Problem

Functions that accept Dart record types as parameters fail at runtime. When the interpreter parses a record literal like `(10, 20)`, it creates an `InterpretedRecord` object — the interpreter's own internal representation — NOT a native Dart record `(int, int)`.

The test:

```dart
void main() {
  var result = swap((10, 20));
  // ...
}
```

The source library function:

```dart
(int, int) swap((int, int) pair) {
  return (pair.$2, pair.$1);
}
```

The generated bridge:

```dart
'swap': (visitor, positional, named, typeArgs) {
  D4.requireMinArgs(positional, 1, 'swap');
  final pair = D4.getRequiredArg<(int, int)>(positional, 0, 'pair', 'swap');
  return $pkg.swap(pair);
},
```

The actual error:

```
Runtime Error: Unexpected error: Argument Error: Invalid parameter "pair":
  expected (int, int), got InterpretedRecord
```

#### Detailed Technical Analysis

1. **`InterpretedRecord` vs native Dart records:** The D4rt interpreter represents record expressions internally using `InterpretedRecord`, which stores positional fields as `List<Object?>` and named fields as `Map<String, Object?>`. This is fundamentally different from Dart's native record types, which are compiler-generated value types with specific runtime types like `(int, int)` or `({int min, int max})`.

2. **No conversion path exists:** The `extractBridgedArg<T>` method has no handler for converting `InterpretedRecord` to native Dart records. Unlike collections (where `List<Object?>` can be `.cast<int>()`), there is no generic Dart API to construct a record from positional/named field values at runtime. Records in Dart are compile-time constructs — there is no `Record.fromFields(positional, named)` factory.

3. **The type check `unwrapped is (int, int)`** fails because `InterpretedRecord` is a completely different class from the native record type. Dart cannot coerce between them.

#### Original Analysis (Previously Won't Fix)

1. **Dart records have no runtime construction API.** Unlike classes (which can be constructed via `Function.apply` or similar mechanisms), there is no way to programmatically create a Dart record `(int, int)` from a list of values at runtime. The record creation syntax `(value1, value2)` is purely compile-time.

2. **The generator cannot generate conversion code for all possible record shapes.** Record types can be:
   - Positional: `(int, int)`, `(String, int, bool)`
   - Named: `({int x, int y})`, `({String name, int age, bool active})`
   - Mixed: `(int, {String name})`
   - Nested: `(int, (String, bool))`
   
   Each shape would need a dedicated converter function generated at bridge time. The number of possible record shapes is infinite.

3. **Would require a fundamental change to the interpreter's record implementation.** The interpreter would need to abandon `InterpretedRecord` and create actual native Dart records for all record expressions. But this is impossible at runtime because:
   - Dart records are structural types determined at compile time
   - There is no `dartrecord` constructor or factory method
   - `dart:mirrors` is deprecated and unavailable on most platforms
   - Code generation at runtime is not supported in AOT-compiled Dart

4. **Impact:** Any bridged function with a record parameter will fail. This includes both positional `(int, int)` and named `({int x, int y})` record parameter types.

#### Possible Solutions

**Solution A: Generator emits `InterpretedRecord`-to-native-record converter per function (Fixable)**

The key insight is that Dart records CAN be created at compile time — and the bridge code IS compiled. The generator knows the exact record shape from the AST at code-generation time. It can generate a conversion function for each record parameter:

```dart
// Current generated code (fails):
final pair = D4.getRequiredArg<(int, int)>(positional, 0, 'pair', 'swap');
return $pkg.swap(pair);

// Fixed generated code:
final pairRaw = positional[0];
final pair = pairRaw is InterpretedRecord
    ? (pairRaw.positionalFields[0] as int, pairRaw.positionalFields[1] as int)
    : D4.getRequiredArg<(int, int)>(positional, 0, 'pair', 'swap');
return $pkg.swap(pair);
```

For named records:
```dart
// ({int min, int max}) parameter:
final resultRaw = positional[0];
final result = resultRaw is InterpretedRecord
    ? (min: resultRaw.namedFields['min'] as int, max: resultRaw.namedFields['max'] as int)
    : D4.getRequiredArg<({int min, int max})>(positional, 0, 'result', 'processMinMax');
```

The generator has full access to the record's shape (positional field types, named field names and types) from the Dart AST's `RecordType` node. It can emit the exact record literal construction with field extraction from `InterpretedRecord`.

**Effort:** Medium. The generator needs to:
1. Detect when a parameter type is a record type (already done — `_resolveRecordTypeWithPrefixes` exists at line 7041)
2. Parse the record shape to extract positional and named field types
3. Generate `InterpretedRecord`-to-native conversion code per parameter
4. Import `InterpretedRecord` from `tom_d4rt` in generated bridge files

**Risk:** Low-Medium. The conversion code is straightforward compiled Dart. The try-catch wrap ensures failures produce meaningful errors. Nested records would need recursive conversion (e.g., `(int, (String, bool))`), adding complexity but still tractable.

**Solution B: `D4.extractRecordArg` helper with shape descriptor**

Create a generic helper that takes a record shape descriptor and converts `InterpretedRecord` to a native record:

```dart
// Helper (can't be truly generic for records, but can handle common arities):
static (T1, T2) extractRecord2<T1, T2>(Object? arg, String paramName) {
  if (arg is InterpretedRecord) {
    return (arg.positionalFields[0] as T1, arg.positionalFields[1] as T2);
  }
  throw ArgumentD4rtException('Expected record (T1, T2), got ${arg.runtimeType}');
}
```

This requires a family of methods: `extractRecord2`, `extractRecord3`, `extractNamedRecord`, etc. Dart doesn't support variadic generics, so each arity needs a separate method. Named records add combinatorial explosion.

**Effort:** High (many methods needed for all combinations).
**Risk:** Medium. Arity/name combinations are bounded in practice but messy.

**Verdict:** Solution A is the clear winner. The generator already knows the exact record shape; it just needs to emit inline conversion code. This is fully fixable.

---

### G-TYPE-2 — Record Return Type Property Access

**Status:** TODO
**Category:** Record Types
**Test:** `test/d4rt_coverage_test.dart` (line ~900)
**Script:** `example/d4_test_scripts/bin/dart_overview/type02_record_return.dart`

#### The Problem

This is the complement of G-TYPE-1. When a bridged function RETURNS a native Dart record, the interpreter cannot access its fields. The return value is a real Dart record (e.g., `({int min, int max})`), but the interpreter's property access system only understands `InterpretedRecord`, not native Dart records.

The test:

```dart
void main() {
  var mm = findMinMax([5, 2, 8, 1, 9, 3]);
  if (mm.min != 1) { errors.add('...'); }
}
```

The source library function returns a native Dart record:

```dart
({int min, int max}) findMinMax(List<int> numbers) {
  var min = numbers.first;
  var max = numbers.first;
  for (var n in numbers) {
    if (n < min) min = n;
    if (n > max) max = n;
  }
  return (min: min, max: max);
}
```

The generated bridge correctly calls the function:

```dart
'findMinMax': (visitor, positional, named, typeArgs) {
  D4.requireMinArgs(positional, 1, 'findMinMax');
  final numbers = D4.getRequiredArg<List<int>>(positional, 0, 'numbers', 'findMinMax');
  return $pkg.findMinMax(numbers);  // Returns native ({int min, int max})
},
```

The actual error:

```
Runtime Error: Cannot access property 'min' on target of type ({int max, int min}).
```

Stack trace points to `InterpreterVisitor.visitPrefixedIdentifier` line 954.

#### Detailed Technical Analysis

The interpreter's `visitPrefixedIdentifier` method handles property access by checking the target's type. It has explicit handling for:

- `BridgedInstance` — dispatches to bridged getters/methods
- `InterpretedRecord` — accesses positional (`$1`, `$2`) and named fields
- `InterpretedClassInstance` — accesses interpreter-created class fields
- Various built-in types (Map, List, String, etc.)

But when the target is a **native Dart record** (the actual runtime type `({int max, int min})`), none of these checks match. The code falls through to the final `else` clause:

```dart
} else {
  throw RuntimeD4rtException(
      "Cannot access property '$memberName' on target of type "
      "${prefixValue?.runtimeType}.");
}
```

The interpreter sees the runtime type as `({int max, int min})` but has no handler for native `Record` types.

#### Original Analysis (Previously Won't Fix)

1. **Dart provides no runtime API for record field access.** Unlike classes where you could theoretically use `dart:mirrors` (deprecated), Dart records have no reflection support. There is no `record.getField('min')` or `record.getNamedField('min')` API.

2. **Record field access is purely compile-time syntax.** The expressions `mm.min` and `mm.$1` are resolved at compile time by the Dart compiler, not at runtime. The interpreter would need to:
   - Detect that a value is a native Dart record (not an `InterpretedRecord`)
   - Determine the record's shape (which named/positional fields it has)
   - Access those fields programmatically
   
   None of this is possible through standard Dart APIs.

3. **Potential workaround — convert native records to InterpretedRecord:** The bridge code could convert the return value:

   ```dart
   final result = $pkg.findMinMax(numbers);
   // Would need to convert to InterpretedRecord:
   return InterpretedRecord([], {'min': result.min, 'max': result.max});
   ```

   But this would require the generator to know the exact record shape for every function return type and generate per-function conversion code. This is technically possible but extremely complex:
   - The generator would need to parse record type syntax `({int min, int max})` from the AST
   - Generate field accessors for each record shape
   - Handle nested records, mixed positional/named fields
   - Add `InterpretedRecord` as a dependency in generated bridge code
   
   This represents significant generator complexity for a feature that is still relatively uncommon in bridged Dart libraries.

4. **G-TYPE-1 and G-TYPE-2 are symmetric problems.** Even if G-TYPE-2 were fixed (converting return records to `InterpretedRecord`), G-TYPE-1 would still fail (converting `InterpretedRecord` to native records for parameters). Both would need to be solved simultaneously for record types to work end-to-end, and G-TYPE-1 is fundamentally impossible as explained above.

#### Possible Solutions

**Solution A: Generator emits native-record-to-`InterpretedRecord` converter on return (RECOMMENDED — Fixable)**

This is the complement of G-TYPE-1 Solution A. The generator knows the return type's record shape from the AST. It can generate a post-call conversion from the native Dart record back to `InterpretedRecord`, which the interpreter can then handle with its existing field access logic:

```dart
// Current generated code (returns native record, interpreter can't access fields):
'findMinMax': (visitor, positional, named, typeArgs) {
  final numbers = D4.getRequiredArg<List<int>>(positional, 0, 'numbers', 'findMinMax');
  return $pkg.findMinMax(numbers);  // Returns native ({int min, int max})
},

// Fixed generated code (converts to InterpretedRecord):
'findMinMax': (visitor, positional, named, typeArgs) {
  final numbers = D4.getRequiredArg<List<int>>(positional, 0, 'numbers', 'findMinMax');
  final _result = $pkg.findMinMax(numbers);
  return InterpretedRecord([], {'min': _result.min, 'max': _result.max});
},
```

For positional records:
```dart
// (String, int) return type:
final _result = $pkg.parseUserString(input);
return InterpretedRecord([_result.$1, _result.$2], {});
```

The generator already has record type parsing capabilities (`_resolveRecordTypeWithPrefixes`). It just needs to detect record return types and generate the conversion wrapper.

**Effort:** Medium. Similar to G-TYPE-1 — parse the record shape from the AST, generate field extraction code.
**Risk:** Low. The conversion is straightforward compiled Dart code. Nested records need recursive conversion.

**Solution B: Interpreter handles native `Record` in `visitPropertyAccess` (Alternative — Fixable but complex)**

Instead of converting at the bridge level, teach the interpreter to handle native Dart `Record` objects in `visitPropertyAccess` and `visitPrefixedIdentifier`. Dart's `Record` base class is sealed with no field access API, BUT the interpreter could use pattern matching:

```dart
// In visitPropertyAccess:
} else if (target is Record) {
  // Native Dart record from a bridged function return
  // Use noSuchMethod or try/catch with dynamic access
  try {
    return (target as dynamic).propertyName;  // Won't work — no dynamic dispatch on records
  } catch (_) { ... }
}
```

**Problem:** Native Dart records do NOT support dynamic property access. `(target as dynamic).$1` would work for positional fields via Dart's dynamic dispatch, BUT `(target as dynamic).min` for named fields is NOT supported — named record fields are NOT regular properties and cannot be accessed dynamically.

Actually, let me reconsider: in Dart, `(target as dynamic).$1` DOES work for positional fields because `$1` is a real getter. And `(target as dynamic).min` should ALSO work if the record has a named field `min` — Dart records do expose named fields as regular getters for dynamic dispatch.

If dynamic dispatch on records works, the interpreter could add a generic handler:

```dart
} else if (target is Record) {
  try {
    // Use Dart's noSuchMethod/dynamic dispatch to access record fields
    final result = (target as dynamic);
    switch (propertyName) {
      case r'$1': return result.$1;
      case r'$2': return result.$2;
      // ... but we can't enumerate all possible named fields
      default:
        // Try dynamic access — this works for named record fields!
        return Function.apply(() => (target as dynamic), [], {Symbol(propertyName): null});
    }
  } catch (e) {
    throw RuntimeD4rtException("Cannot access '$propertyName' on record: $e");
  }
}
```

This doesn't work because `Function.apply` isn't the right tool. However, `dart:mirrors` COULD do it — but mirrors are deprecated and unavailable in AOT.

**Verdict:** Solution A (generator-level conversion) is the clear winner. Combined with G-TYPE-1 Solution A, both record parameter and return type handling would be fully functional. The generator already has the record shape information; it just needs to emit conversion wrappers for both directions.

**Note:** G-TYPE-1 and G-TYPE-2 should be fixed together as they form a complete record round-trip.

---

### G-TE-1 — Bounded Type Parameter Erasure in Nested Generics

**Status:** TODO
**Category:** Code Generation
**Test:** `test/type_erasure_test.dart` (line ~68)
**Fixture:** `test/fixtures/type_erasure_test_source.dart`

#### The Problem

When the bridge generator encounters a method with bounded type parameters, it should substitute the type parameter's bound into nested generic types. Currently, it substitutes correctly for **direct** parameter types but NOT for type parameters **nested inside other generic types**.

The source class:

```dart
class GenericMethodClass {
  E findFirst<E extends BaseEntity>(List<E> items) {
    return items.first;
  }

  Map<K, V> createMap<K extends Comparable, V extends BaseEntity>(
    List<K> keys, List<V> values,
  ) {
    final map = <K, V>{};
    for (var i = 0; i < keys.length && i < values.length; i++) {
      map[keys[i]] = values[i];
    }
    return map;
  }
}
```

The test expects the generator to produce:

```dart
// For findFirst<E extends BaseEntity>(List<E> items):
D4.getRequiredArg<List<$pkg.BaseEntity>>(positional, 0, 'items', 'findFirst')

// Because E → BaseEntity (the bound), so List<E> → List<BaseEntity>
```

But the generator actually produces:

```dart
D4.getRequiredArg<List<dynamic>>(positional, 0, 'entities', 'findEntity')
```

The type parameter `E` inside `List<E>` is resolved to `dynamic` instead of `BaseEntity`.

#### Detailed Technical Analysis

The generator's type resolution pipeline works as follows:

1. **Type parameter extraction** (lines 8853–8867 of `bridge_generator.dart`):
   ```dart
   final methodTypeParams = <String, String?>{};
   for (final typeParam in node.typeParameters!.typeParameters) {
     final paramName = typeParam.name.lexeme;  // 'E'
     final bound = typeParam.bound?.toSource().replaceFirst('extends ', '');  // 'BaseEntity'
     methodTypeParams[paramName] = bound;
   }
   ```
   This correctly extracts `{'E': 'BaseEntity'}`.

2. **Type resolution** (`_resolveTypeArgument`, lines 7008–7095):
   ```dart
   // Check if type is a class type parameter
   if (classTypeParams.containsKey(baseType)) {
     final bound = classTypeParams[baseType];
     if (bound != null) {
       return _getTypeArgument(bound, ...);
     }
     return 'dynamic';
   }
   ```
   When the parameter type is directly `E`, it correctly resolves to `BaseEntity`.

3. **The problem: nested generic types.** When the parameter type is `List<E>`, the resolver processes the outer type `List` first, then needs to resolve the inner type argument `E`. The `_isGenericTypeParameter` check (lines 7637–7665) recognizes single uppercase letters as generic type parameters:
   ```dart
   bool _isGenericTypeParameter(String type) {
     if (type.length == 1 && type.toUpperCase() == type) return true;
     // ...
   }
   ```
   When `E` is encountered as a type argument inside `List<E>`, it matches as a "generic type parameter" and gets resolved to `dynamic` BEFORE the method's type parameter map is consulted for the bound.

The resolution order is:
1. Parse `List<E>` → outer type `List`, inner type argument `E`
2. Resolve `E` → check `_isGenericTypeParameter('E')` → true → return `'dynamic'`
3. Result: `List<dynamic>` ❌

What it should do:
1. Parse `List<E>` → outer type `List`, inner type argument `E`
2. Resolve `E` → check method type params `{'E': 'BaseEntity'}` → found → return `'BaseEntity'`
3. Result: `List<BaseEntity>` ✅

#### Original Analysis (Previously Won't Fix)

1. **The fix requires rearchitecting the type resolution pipeline.** The `_resolveTypeArgument` method needs to receive method-level type parameter maps and check them BEFORE falling through to the generic `_isGenericTypeParameter` check. This is not a simple change because:
   - The resolution pipeline is shared between class-level and method-level type parameters
   - Class type parameters (like `E` in `class MyList<E>`) are handled separately from method type parameters (`E` in `<E extends BaseEntity>`)
   - The resolution has recursive cases (resolving `Map<K, List<V>>` requires resolving `K` and `V` at different depths)

2. **Recursive/circular bounds create infinite resolution chains.** For `<T extends Comparable<T>>`, resolving `T` → `Comparable<T>` → inner `T` → `Comparable<T>` → ... The current code handles this with `_containsTypeParameter` checks, but adding nested generic resolution would make circular bound detection much more complex.

3. **The impact is limited to methods with bounded generic type parameters where those parameters appear inside collection types.** Most bridged methods use concrete types. The workaround for affected methods is to manually create a bridge override with the correct type.

4. **Related tests G-TE-12 (unbounded type params) and G-TE-13 (multiple bounds) pass** — the issue is specifically with nested occurrences of bounded type parameters.

#### Actual Test Output

```
Expected: contains 'D4.getRequiredArg<List<$pkg.BaseEntity>>'
Actual: generated code uses D4.coerceList<$pkg.BaseEntity> for instance method (correct API)
        and D4.getRequiredArg<List<dynamic>> for global function findEntity (wrong type)
```

#### Revised Analysis (after source code verification)

**The original analysis was incorrect.** Detailed code tracing reveals that the type erasure **actually works correctly** for instance methods. The test fails for a different reason:

1. **Instance method `findFirst`** (on `GenericMethodClass`): Generated code is `D4.coerceList<$pkg.BaseEntity>(positional[0], 'items')`. The type `E` IS correctly resolved to `$pkg.BaseEntity`. The test fails because it expects `D4.getRequiredArg<List<$pkg.BaseEntity>>` but the generator correctly uses `D4.coerceList<...>` for List-typed parameters (not `getRequiredArg`). **This is a test expectation bug.**

2. **Global function `findEntity`**: Generated code is `D4.getRequiredArg<List<dynamic>>(...)`. Here the type erasure genuinely fails — `E` resolves to `dynamic` instead of `BaseEntity`.

**Root cause for global function failure**: At line 4295 of `bridge_generator.dart`, the global function parameter resolution does NOT pass `sourceFilePath`:

```dart
final resolvedType = _getTypeArgument(
    param.type,
    typeToUri: param.typeToUri,
    classTypeParams: funcTypeParams,
    // sourceFilePath NOT passed!
);
```

When `E → BaseEntity` is resolved, the bound `BaseEntity` must then be resolved to `$pkg.BaseEntity`. But without `sourceFilePath`, the resolver can't find `BaseEntity` in auxiliary imports. It's not in `typeToUri` (which only has types from the parameter declaration `List<E>`, not from the type parameter bound). Without `sourceFilePath` and without a `typeToUri` entry, it falls through to `_globalTypeToUri` and then to `'dynamic'`.

Compare with instance methods (line 5836), which DO pass `sourceFilePath: cls.sourceFile`.

#### Possible Solutions

**Solution A: Fix test expectations + pass `sourceFilePath` for global functions (RECOMMENDED — Fixable)**

Two changes needed:

1. **Fix test G-TE-1a**: Change expectation from `D4.getRequiredArg<List<$pkg.BaseEntity>>` to `D4.coerceList<$pkg.BaseEntity>` (matching actual correct output for instance methods).

2. **Fix global function type resolution**: Pass `sourceFilePath: func.sourceFile` at line 4295:

```dart
final resolvedType = _getTypeArgument(
    param.type,
    typeToUri: param.typeToUri,
    classTypeParams: funcTypeParams,
    sourceFilePath: func.sourceFile,  // ADD THIS
);
```

This allows `_resolveTypeFromSourceImports` to find `BaseEntity` and resolve it with the correct import prefix.

**Effort:** Trivial. One added parameter + one test fix.
**Risk:** Very low. The instance method path already passes `sourceFilePath` and works correctly.

**Verdict:** Both the code bug and the test bug are trivial fixes. The type erasure pipeline itself works correctly — the issue is a missing `sourceFilePath` parameter in the global function code path and incorrect test expectations. Estimated effort: Minimal.

---

### G-TE-2 — Static Method Constrained Type Parameter Erasure

**Status:** TODO
**Category:** Code Generation
**Test:** `test/type_erasure_test.dart` (line ~104)
**Fixture:** `test/fixtures/type_erasure_test_source.dart`

#### The Problem

This is the same fundamental issue as G-TE-1, but for static methods with constrained type parameters. The generator fails to substitute type parameter bounds into complex nested parameter types in static method bridge code.

The source class:

```dart
class ObservableList<E extends Observable> {
  final List<E> _items = [];

  void add(E item) => _items.add(item);

  static ObservableList<E> castFrom<S extends Observable, E extends Observable>(
    ObservableList<S> source,
  ) {
    final result = ObservableList<E>();
    for (final item in source._items) {
      result.add(item as E);
    }
    return result;
  }
}
```

The test expects:

```dart
// castFrom<S extends Observable, E extends Observable>(ObservableList<S> source)
// S → Observable (bound), so ObservableList<S> → ObservableList<Observable>
expect(generatedCode, contains(r"$pkg.ObservableList<$pkg.Observable>"));
```

But the generated code does NOT contain `$pkg.ObservableList<$pkg.Observable>` — instead, the type parameter `S` inside `ObservableList<S>` is resolved to `dynamic` (the same nested type parameter erasure issue as G-TE-1).

#### Detailed Technical Analysis

The resolution path is the same as G-TE-1 but with an additional complication: **static methods exist at the class level but have their own type parameters separate from the class's type parameters.**

For `ObservableList<E extends Observable>`:
- **Class-level** type parameter: `E extends Observable`
- **Static method** type parameters: `S extends Observable`, `E extends Observable` (shadows the class-level `E`)

The generator correctly extracts both:
```dart
methodTypeParams = {'S': 'Observable', 'E': 'Observable'}
```

But when resolving `ObservableList<S>`:
1. The outer type `ObservableList` is correctly resolved as a known class type
2. The inner type argument `S` is checked — `_isGenericTypeParameter('S')` → true → `'dynamic'`
3. Result: `ObservableList<dynamic>` instead of `ObservableList<Observable>`

#### Original Analysis (Previously Won't Fix)

The same fundamental reasons as G-TE-1 apply:

1. **Same root cause** — The type resolution pipeline resolves single-letter type parameters to `dynamic` before checking method-level type parameter bounds in nested type argument positions.

2. **Static methods add complexity** — Static methods have independent type parameter scopes that shadow class-level type parameters. The resolution system would need separate scope management for class-level vs method-level type parameters.

3. **The `castFrom` pattern is particularly challenging** because it involves TWO type parameters (`S` and `E`), both bounded, appearing in both the parameter type and the return type. Correctly resolving both while avoiding circular references is non-trivial.

4. **Limited real-world impact** — Static factory methods with constrained type parameters (like `castFrom`) are uncommon in bridged libraries. The workaround is to manually bridge these methods with correct type specifications.

#### Actual Test Output

```
Expected: contains '$pkg.ObservableList<$pkg.Observable>'
Actual: generated code contains $type_erasure_test_source.ObservableList<$pkg.Observable>
        (correct type erasure S→Observable, but different import prefix for ObservableList)
```

#### Revised Analysis (after source code verification)

**The original analysis was incorrect.** The generated code for `castFrom` is:

```dart
final source = D4.getRequiredArg<$type_erasure_test_source.ObservableList<$pkg.Observable>>(
    positional, 0, 'source', 'castFrom');
```

Key findings:
1. **Type erasure IS working correctly**: `S extends Observable` → `Observable` → `$pkg.Observable` ✅
2. **The test fails because of an import prefix mismatch**: `ObservableList` uses `$type_erasure_test_source` instead of `$pkg`
3. `ObservableList` gets an auxiliary import prefix because it's defined in the test fixture file, not exported from the package barrel

This is NOT a type erasure issue at all — it's an import prefix resolution issue specific to the test fixture setup. In production code where types ARE exported from the package barrel, the prefix would be `$pkg` as expected.

#### Possible Solutions

**Solution A: Fix the test expectation (RECOMMENDED — Trivial)**

The test should match the actual generated import prefix. Since `ObservableList` is defined in the test fixture (not a barrel-exported type), the correct expectation is:

```dart
expect(generatedCode, contains(r"$type_erasure_test_source.ObservableList<$pkg.Observable>"));
```

Or use a regex/looser matcher that checks the type erasure result regardless of prefix:

```dart
expect(generatedCode, contains(r"ObservableList<$pkg.Observable>"));
```

**Effort:** Trivial. One test assertion change.
**Risk:** None.

**Verdict:** This is a test expectations issue, not a code bug. The type erasure itself works correctly — `S extends Observable` resolves to `$pkg.Observable` as expected. The only issue is that the `ObservableList` class gets a non-`$pkg` import prefix because it's not barrel-exported in the test setup. Estimated effort: Trivial.

#### Relationship to G-TE-1

G-TE-1 and G-TE-2 were originally documented as sharing the same root cause (nested type parameter erasure to `dynamic`). **This is now known to be incorrect.** After source code verification:

- **G-TE-1**: The instance method code path works correctly; the test fails because it checks for `getRequiredArg` but the generator uses `coerceList`. The global function path has a real (but trivial) bug: missing `sourceFilePath` parameter.
- **G-TE-2**: The static method code path works correctly; the test fails because it expects `$pkg.ObservableList` but gets `$type_erasure_test_source.ObservableList` (auxiliary import prefix for non-barrel-exported types).

Both issues are **test expectation mismatches**, not fundamental code generation limitations. The type erasure pipeline itself works correctly for all code paths that pass `sourceFilePath`.

---

## Summary

| ID | Root Cause | Original Verdict | Revised Verdict | Fix Effort |
|----|-----------|-----------------|----------------|------------|
| G-PAR-6 | Interpreter creates `List<Object?>` not `List<int>` | TODO | **Fixable** | Medium — new `D4.getListArg<T>` helper that unwraps `BridgedInstance` elements |
| G-GNRC-7 | `BridgedInstance` hides `Comparable` from `sort()` | TODO | **Fixable** | Medium — runtimeType fix + sort interception with bridge `compareTo` dispatch |
| G-OP-8 | Custom `operator ==` not bridged for `Point` | TODO | **Fixable** | Low — generator bug: `operator ==` bridged for `NumberWrapper` but not `Point` |
| G-TYPE-1 | `InterpretedRecord` ≠ native Dart record (param) | TODO | **Fixable** | Medium — generator emits inline `InterpretedRecord`→native record conversion |
| G-TYPE-2 | Native record → `InterpretedRecord` (return) | TODO | **Fixable** | Medium — generator emits inline native record→`InterpretedRecord` conversion |
| G-TE-1 | Test expects `getRequiredArg` but generator uses `coerceList`; global function missing `sourceFilePath` | TODO | **Fixable** | Trivial — fix test expectation + add `sourceFilePath` parameter |
| G-TE-2 | Test expects `$pkg` prefix but gets auxiliary import prefix | TODO | **Fixable** | Trivial — fix test expectation to match actual import prefix |

### Revised Categorization

**All 7 issues are fixable.** None are fundamental Dart language limitations as originally categorized.

**Generator bugs (trivial to fix):**
- **G-OP-8** — Generator inconsistency: `operator ==` bridged for some classes but not others
- **G-TE-1** — Missing `sourceFilePath` parameter in global function code path + wrong test API expectation
- **G-TE-2** — Test expectations don't match actual (correct) import prefix resolution

**Generator enhancements (medium effort):**
- **G-PAR-6** — New helper method to unwrap `BridgedInstance` elements in collections
- **G-GNRC-7** — Sort interception + runtimeType identity fix for bridged instances
- **G-TYPE-1, G-TYPE-2** — Inline record conversion code generation (generator knows exact record shape from AST)
