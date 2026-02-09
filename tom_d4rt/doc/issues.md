# D4rt Interpreter — Open Issues

> Last updated: 2026-02-09

This document tracks **open interpreter issues** that require changes to `tom_d4rt`. Fixed bugs and limitations are documented in [d4rt_limitations.md](d4rt_limitations.md).

---

## Issue Index

| ID | Description | Relevance | Comment/Reason | Status |
|----|-------------|-----------|----------------|--------|
| [INTER-001](#inter-001) | Callable class call() method not invoked | Medium | Fixed in interpreter_visitor.dart | ✅ Fixed |
| [INTER-002](#inter-002) | Top-level setter assignment fails | Medium | Missing `registerGlobalSetter` API | ⬜ TODO |
| [INTER-003](#inter-003) | Int-to-double promotion in `extractBridgedArg` | Medium | Fixed in d4.dart | ✅ Fixed |
| [INTER-004](#inter-004) | Collection type casting in method parameters | Medium | Fixed in d4.dart | ✅ Fixed |
| [INTER-005](#inter-005) | BridgedInstance unwrapping for native calls | Medium | Affects sorted collections | ⬜ TODO |
| [Bug-92](#bug-92) | Future factory constructor returns BridgedInstance | Medium | Async bridging issue | ⬜ TODO |
| [Bug-93](#bug-93) | Int not promoted to double return type | Low | Missing implicit promotion | ⬜ TODO |
| [Bug-94](#bug-94) | Cascade index assignment on property fails | Medium | Cascade target resolution | ⬜ TODO |
| [Bug-95](#bug-95) | List.forEach with native function tear-off fails | Medium | InterpretedFunction check too strict | ⬜ TODO |
| [Bug-96](#bug-96) | super.name constructor parameter forwarding fails | Medium | Dart 3 super parameter syntax | ⬜ TODO |
| [Bug-97](#bug-97) | num not recognized as satisfying Comparable bound | Low | Missing interface knowledge | ⬜ TODO |
| [Bug-98](#bug-98) | Extension getter on bridged List not resolved | Medium | Type parameterization matching | ⬜ TODO |
| [Bug-99](#bug-99) | Stream.handleError callback receives wrong arg count | Low | Callback arity checking | ⬜ TODO |
| [Lim-3](#lim-3) | Isolate execution with interpreted code | Fundamental | Dart VM architecture | 🚫 Won't Fix |
| [Bug-14](#bug-14) | Records with named fields or >9 positional fields | High | Dart language limitation | 🚫 Won't Fix |

**Status Legend:**
- ⬜ TODO — Not yet fixed
- ✅ Fixed — Resolved
- 🚫 Won't Fix — Fundamental limitation

---

## Issue Details

---

### INTER-001

**Callable class call() method not invoked**

**Status:** ✅ Fixed  
**Relevance:** Medium — Affects callable class pattern  
**Original ID:** GEN-054  
**Fixed:** 2026-02-09 — Added BridgedInstance.call() check in visitMethodInvocation and visitFunctionExpressionInvocation

#### Problem Description

Classes that implement `call()` to make instances callable don't work correctly. When using `instance(args)` syntax, the interpreter doesn't invoke the `call()` method.

```dart
class Multiplier {
  final int factor;
  Multiplier(this.factor);
  int call(int value) => value * factor;
}

void main() {
  var mult = Multiplier(3);
  var result = mult(5);  // ❌ Returns Multiplier(3) instead of 15
  print(result);
}
```

**Expected:** `15`  
**Actual:** Returns the `Multiplier` instance itself

#### What Goes Wrong

The generator correctly generates the `call()` method in the bridge's methods map. However, when the interpreter evaluates `instance(args)` expressions, it treats the instance as a function reference but doesn't check if the instance has a `call()` method to invoke.

#### Where is the Problem

**Location:** `tom_d4rt/lib/src/interpreter_visitor.dart`

When evaluating a function invocation expression where the function target is an object (not a function), the interpreter should:
1. Check if the object has a `call()` method (either native or bridged)
2. Invoke that method with the provided arguments

The current implementation skips this check for bridged instances.

#### How to Fix

In `interpreter_visitor.dart`, in the method that handles function invocations (likely `visitMethodInvocation` or similar):

```dart
// When target is a BridgedInstance, check for call() method
if (target is BridgedInstance) {
  final callMethod = target.getMethod('call');
  if (callMethod != null) {
    return callMethod(visitor, target, positionalArgs, namedArgs);
  }
}
```

---

### INTER-002

**Top-level setter assignment fails**

**Status:** ⬜ TODO  
**Relevance:** Medium — Affects mutable global state  
**Original ID:** GEN-056

#### Problem Description

Top-level setters cannot be assigned to because the interpreter only has APIs to register global getters, not setters.

```dart
// In a bridged library:
int _value = 0;
int get globalValue => _value;
set globalValue(int v) => _value = v;

// In interpreted code:
void main() {
  print(globalValue);      // ✅ Works - getter is bridged
  globalValue = 42;        // ❌ FAILS - setter not supported
}
```

**Error:** Assignment fails silently or throws "undefined variable"

#### What Goes Wrong

The generator can only call `registerGlobalGetter()` because there is no `registerGlobalSetter()` API. The `GlobalGetter` class only wraps a getter function, not a setter.

When the interpreter encounters an assignment to a global variable:
1. It looks up the name in the environment
2. Finds a `GlobalGetter` object
3. Cannot assign to it because `GlobalGetter` has no setter

#### Where is the Problem

**Location:** Multiple files in `tom_d4rt`:
- `lib/src/d4rt.dart` — Missing `registerGlobalSetter()` API
- `lib/src/environment.dart` — `GlobalGetter` class lacks setter support
- `lib/src/module_loader.dart` — Doesn't load library setters

#### How to Fix

1. **Create `GlobalGetterSetter` class** (or extend `GlobalGetter`):

```dart
class GlobalGetterSetter {
  final dynamic Function() getter;
  final void Function(dynamic value)? setter;
  GlobalGetterSetter(this.getter, this.setter);
}
```

2. **Add `registerGlobalSetter` API** to `D4rt` class:

```dart
void registerGlobalSetter(String name, void Function(dynamic) setter, String library) {
  // Register setter alongside getter
}
```

3. **Update `Environment.assign()`** to detect and call the setter:

```dart
if (value is GlobalGetterSetter && value.setter != null) {
  value.setter!(newValue);
  return;
}
```

4. **Update generator** to emit `registerGlobalSetter()` calls for top-level setters.

---

### INTER-003

**Int-to-double promotion in `extractBridgedArg`**

**Status:** ✅ Fixed  
**Relevance:** Medium — Affects all double parameters  
**Original ID:** GEN-058  
**Fixed:** 2026-02-09 — Added int→double promotion in D4.extractBridgedArg

#### Problem Description

When passing integer literals to bridged functions expecting `double` parameters, the bridge's `D4.extractBridgedArg<double>` method fails because Dart doesn't consider `int` a subtype of `double` at runtime.

```dart
// Bridged class:
class NumberWrapper {
  final double value;
  NumberWrapper(this.value);
}

// Interpreted code:
void main() {
  var w = NumberWrapper(10);  // ❌ FAILS - 10 is int, not double
  print(w.value);
}
```

**Error:** `Invalid parameter "value": expected double, got int`

#### What Goes Wrong

The interpreter evaluates `10` as an `int`. When passed to the bridged constructor, `D4.extractBridgedArg<double>` does a strict type check:

```dart
if (arg is T) {  // When T=double and arg is int → false
  return arg;
}
// Throws: Invalid parameter
```

Dart allows implicit int→double promotion at compile time, but this doesn't apply to runtime `is T` checks.

#### Where is the Problem

**Location:** `tom_d4rt/lib/src/generator/d4.dart` — `extractBridgedArg<T>` method

#### How to Fix

Add int-to-double promotion logic in `extractBridgedArg`:

```dart
static T extractBridgedArg<T>(dynamic arg, String paramName) {
  // Handle int-to-double promotion (Dart implicit behavior)
  if (T == double && arg is int) {
    return arg.toDouble() as T;
  }
  
  if (arg is T) {
    return arg;
  }
  
  throw RuntimeError('Invalid parameter "$paramName": expected $T, got ${arg.runtimeType}');
}
```

---

### INTER-004

**Collection type casting in method parameters**

**Status:** ✅ Fixed  
**Relevance:** Medium — Affects collection-typed parameters  
**Original ID:** GEN-061  
**Fixed:** 2026-02-09 — Added List/Set/Map casting in D4.extractBridgedArg

#### Problem Description

When passing list literals to bridged functions expecting typed collections like `List<int>`, the call fails. The interpreter creates list literals as `List<Object?>`, which doesn't match `List<int>`.

```dart
// Bridged function:
int sum(List<int> numbers) => numbers.reduce((a, b) => a + b);

// Interpreted code:
void main() {
  var result = sum([1, 2, 3, 4, 5]);  // ❌ FAILS
  print(result);
}
```

**Error:** `Invalid parameter "numbers": expected List<int>, got List<Object?>`

#### What Goes Wrong

Same root cause as INTER-003. The `extractBridgedArg<List<int>>` check fails because:
- Interpreter creates `[1, 2, 3, 4, 5]` as `List<Object?>`
- `List<Object?>` is not `List<int>` at runtime (invariance)
- D4.extractBridgedArg throws type mismatch error

#### Where is the Problem

**Location:** `tom_d4rt/lib/src/generator/d4.dart` — `extractBridgedArg<T>` method

Note: GEN-057 fixed this for **setters** in generated bridges by using `.cast<T>().toList()`. This issue requires the same fix in the interpreter's argument extraction.

#### How to Fix

Add collection type casting in `extractBridgedArg`:

```dart
static T extractBridgedArg<T>(dynamic arg, String paramName) {
  // Handle int-to-double promotion
  if (T == double && arg is int) {
    return arg.toDouble() as T;
  }
  
  // Handle List type casting
  if (arg is List && T.toString().startsWith('List<')) {
    // Extract element type from T and cast
    return (arg).cast<dynamic>().toList() as T;
  }
  
  // Handle Set type casting
  if (arg is Set && T.toString().startsWith('Set<')) {
    return (arg).cast<dynamic>().toSet() as T;
  }
  
  // Handle Map type casting
  if (arg is Map && T.toString().startsWith('Map<')) {
    return (arg).cast<dynamic, dynamic>() as T;
  }
  
  if (arg is T) {
    return arg;
  }
  
  throw RuntimeError('Invalid parameter "$paramName": expected $T, got ${arg.runtimeType}');
}
```

**Alternative approach:** Use runtime type reflection to extract actual element types from `T`.

---

### INTER-005

**BridgedInstance unwrapping for native calls**

**Status:** ⬜ TODO  
**Relevance:** Medium — Affects native method calls with bridged objects  
**Original ID:** GEN-062

#### Problem Description

When calling native Dart methods on collections containing bridged objects, the elements remain wrapped as `BridgedInstance<Object>`. Native methods that expect specific types fail.

```dart
// Bridged class implementing Comparable:
class SortableItem implements Comparable<SortableItem> {
  final int value;
  SortableItem(this.value);
  int compareTo(SortableItem other) => value.compareTo(other.value);
}

// Interpreted code:
void main() {
  var items = [SortableItem(3), SortableItem(1), SortableItem(2)];
  items.sort();  // ❌ FAILS
  print(items);
}
```

**Error:** `type 'BridgedInstance<Object>' is not a subtype of type 'Comparable<dynamic>' in type cast`

#### What Goes Wrong

1. Interpreter creates list elements as `BridgedInstance<SortableItem>` wrappers
2. When `sort()` is called, Dart's native `List.sort()` method runs
3. Native sort tries to cast elements to `Comparable<dynamic>`
4. `BridgedInstance` doesn't implement `Comparable`, even though the wrapped object does
5. Cast fails

#### Where is the Problem

**Location:** How bridged instances are stored and passed to native methods

The core issue is that `BridgedInstance` wrappers aren't transparent to native Dart code. When native methods operate on collections:
- They see `BridgedInstance` wrappers, not the actual objects
- The wrappers don't forward interface implementations

#### How to Fix

**Option A: Unwrap before native calls**

When calling native methods on collections with bridged content:
1. Detect that we're calling a native method (not a bridged one)
2. Unwrap all `BridgedInstance` elements to their `nativeObject`
3. Call the native method
4. Re-wrap results if needed

**Option B: Make BridgedInstance proxy interfaces**

Make `BridgedInstance<T>` forward common interface implementations:
- `Comparable.compareTo` → delegate to wrapped object
- `Iterable` methods → delegate to wrapped object

This is more complex but more transparent.

**Option C: Don't wrap in lists**

Store unwrapped native objects in lists, only wrapping on access. This requires tracking which containers need wrapping behavior.

---

### Bug-92

**Future factory constructor returns BridgedInstance**

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Creating a Future with the `Future(() => computation)` factory constructor doesn't return a properly awaitable Future. The result is a `BridgedInstance<Object>` instead of `Future<T>`.

```dart
void main() async {
  var future = Future(() => 'Hello');  // ❌ Returns BridgedInstance
  var result = await future;           // Fails or returns wrong value
  print(result);
}
```

#### Where is the Problem

**Location:** `dart_async_bridge.dart` — Future constructor bridging

The `Future(() => ...)` factory constructor isn't properly bridged to return a Future type that the interpreter can await.

#### How to Fix

Bridge the `Future(() => computation)` factory constructor to:
1. Accept an interpreted function as the computation
2. Create a real Dart `Future` that executes the computation
3. Return the Future (not wrapped in `BridgedInstance`)

---

### Bug-93

**Int not promoted to double return type**

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

When a function declares a `double` return type but returns an `int` value, D4rt rejects this. Dart should implicitly promote int to double.

```dart
double foo(int x) {
  return x;  // ❌ FAILS - should auto-promote int to double
}

void main() {
  print(foo(5));  // Should print 5.0
}
```

**Error:** `A value of type 'int' can't be returned from the function 'foo' because it has a return type of 'double'.`

#### Where is the Problem

**Location:** `interpreter_visitor.dart` — `visitReturnStatement`

The return type check doesn't handle implicit int→double promotion.

#### How to Fix

In `visitReturnStatement`, add promotion logic:

```dart
if (declaredReturnType == double && actualValue is int) {
  return actualValue.toDouble();
}
```

---

### Bug-94

**Cascade index assignment on property fails**

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Cascade expressions with index assignment on a property of the target fail.

```dart
class Request {
  final Map<String, String> headers = {};
}

void main() {
  var request = Request()
    ..headers['Content-Type'] = 'application/json';  // ❌ FAILS
}
```

**Error:** `Index assignment target must be List or Map in cascade.`

#### Where is the Problem

**Location:** `interpreter_visitor.dart` — `_executeCascadeAssignment`

The cascade handler checks if the cascade target (`Request`) is a List/Map, but should resolve the property chain first to check `headers`, which IS a Map.

#### How to Fix

In `_executeCascadeAssignment`, when processing an index expression in a cascade:
1. Resolve the full property chain (`request.headers`)
2. Check if THAT value supports index assignment
3. Perform the assignment on the resolved target

---

### Bug-95

**List.forEach with native function tear-off fails**

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Calling `forEach` with a native function tear-off (like `print`) fails because the bridge expects an `InterpretedFunction`.

```dart
void main() {
  var numbers = [1, 2, 3];
  numbers.forEach(print);  // ❌ FAILS - print is native
}
```

**Error:** `Native error during bridged method call 'forEach' on List: Runtime Error: Expected a InterpretedFunction for forEach`

Note: `numbers.forEach((n) => print(n))` works because the lambda is interpreted.

#### Where is the Problem

**Location:** `dart_core_bridge.dart` — List bridge `forEach` implementation

The forEach bridge only accepts `InterpretedFunction` but should also handle native Dart `Function` objects.

#### How to Fix

Check the callback type and handle both cases:

```dart
'forEach': (visitor, target, positional, named) {
  final callback = positional[0];
  final list = target.nativeObject as List;
  
  if (callback is InterpretedFunction) {
    for (var element in list) {
      visitor.invokeInterpretedFunction(callback, [element]);
    }
  } else if (callback is Function) {
    list.forEach(callback);  // Native function, use directly
  }
}
```

---

### Bug-96

**super.name constructor parameter forwarding fails**

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Dart 3's `super.name` parameter syntax that forwards arguments to the superclass isn't handled.

```dart
class Parent {
  final String name;
  Parent(this.name);
}

class Child extends Parent {
  Child(super.name);  // ❌ FAILS - should forward to Parent
}

void main() {
  print(Child('test').name);
}
```

**Error:** `Missing required argument for 'name' in function ''.`

#### Where is the Problem

**Location:** `runtime_types.dart` — Constructor execution / super parameter handling

The `super.name` syntax (SuperFormalParameter in AST) isn't recognized as forwarding the argument.

#### How to Fix

When processing constructor parameters:
1. Detect `SuperFormalParameter` nodes in the AST
2. Extract the parameter name and value
3. Forward the value to the superclass constructor's matching parameter

---

### Bug-97

**num not recognized as satisfying Comparable bound**

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

Using `num` as a type argument for a class with `T extends Comparable<dynamic>` bound is rejected.

```dart
class Box<T extends Comparable<dynamic>> {
  T value;
  Box(this.value);
}

void main() {
  var b = Box<num>(42);  // ❌ FAILS
  print(b.value);
}
```

**Error:** `Type argument 'num' for type parameter 'T' does not satisfy bound 'Comparable' in class 'Box'`

#### Where is the Problem

**Location:** `runtime_types.dart` — `_getValidatedTypeArguments`

The type bound checker doesn't know that `num` implements `Comparable<num>`.

#### How to Fix

Add knowledge of core type interfaces:

```dart
// Known Comparable implementations
const _comparableTypes = {'num', 'int', 'double', 'String', 'Duration'};

bool _satisfiesComparableBound(String typeName) {
  return _comparableTypes.contains(typeName);
}
```

---

### Bug-98

**Extension getter on bridged List not resolved**

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Extension getters on parameterized bridged types (like `List<int>`) aren't found.

```dart
extension IntListExt on List<int> {
  int get sum => fold(0, (a, b) => a + b);
}

void main() {
  var numbers = [1, 2, 3, 4, 5];
  print(numbers.sum);  // ❌ FAILS
}
```

**Error:** `Undefined property or method 'sum' on bridged instance of 'List'.`

#### Where is the Problem

**Location:** `interpreter_visitor.dart` — Extension lookup for bridged types

The extension matcher doesn't match `List<int>` extensions against native List instances with compatible type arguments.

#### How to Fix

Enhance extension lookup to:
1. Check if the target is a bridged collection
2. Extract the actual type arguments of the collection elements
3. Match against extensions with compatible type parameterization

---

### Bug-99

**Stream.handleError callback receives wrong arg count**

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

`Stream.handleError()` with a single-argument callback receives two arguments.

```dart
import 'dart:async';

void main() async {
  var stream = Stream.fromIterable([1, 2, 3]).map((n) {
    if (n == 2) throw 'Error at $n';
    return n;
  });
  var handled = stream.handleError((e) {  // ❌ FAILS - gets 2 args
    print('Handled: $e');
  });
  await for (var n in handled) {
    print('Value: $n');
  }
}
```

**Error:** `Too many positional arguments. Expected at most 1, got 2.`

#### Where is the Problem

**Location:** `stdlib/async/stream.dart` — `handleError` bridge

The bridge always passes both error and stack trace, without checking callback arity.

#### How to Fix

Check the callback's parameter count before invoking:

```dart
final paramCount = callback.parameters.length;
if (paramCount == 1) {
  callback.invoke(visitor, [error]);
} else {
  callback.invoke(visitor, [error, stackTrace]);
}
```

---

### Lim-3

**Isolate execution with interpreted code**

**Status:** 🚫 Won't Fix (Fundamental)  
**Complexity:** Fundamental architectural limitation

#### Problem Description

Interpreted closures cannot be passed to `Isolate.run()` or other isolate APIs.

```dart
final result = await Isolate.run(() {
  return expensiveCalculation();  // ❌ Cannot run in isolate
});
```

#### Why This Cannot Be Fixed

Isolates communicate via message passing. Interpreted closures contain:
- References to AST nodes (not serializable)
- References to `Environment` scopes
- References to `InterpreterVisitor` state

None of these can be serialized and sent across isolate boundaries. This is a fundamental Dart VM architecture limitation.

#### Workarounds

1. Move isolate-heavy computation to bridged (compiled) Dart classes
2. Design scripts for single-threaded execution
3. Use external processes instead of isolates

---

### Bug-14

**Records with named fields or >9 positional fields**

**Status:** 🚫 Won't Fix  
**Complexity:** High — Dart language limitation

#### Problem Description

Records returned from interpreted code have limitations:
- **Positional-only records with 1-9 fields**: Converted to native Dart records ✅
- **Records with named fields**: Return as `InterpretedRecord` ❌
- **Records with >9 positional fields**: Return as `InterpretedRecord` ❌

```dart
// ✅ WORKS - returns native (2, 1)
(int, int) swap((int, int) pair) => (pair.$2, pair.$1);

// ❌ Returns InterpretedRecord, not native record
({int x, int y}) getPoint() => (x: 10, y: 20);

// ❌ Returns InterpretedRecord (>9 elements)
(int,int,int,int,int,int,int,int,int,int) getTen() => (1,2,3,4,5,6,7,8,9,10);
```

#### Why This Cannot Be Fixed

Dart does not support creating record types dynamically at runtime. Records are compile-time constructs determined by the compiler. There is no way to programmatically construct a native record with named fields or arbitrary arity.

This is a fundamental language limitation.

#### Workarounds

- Use positional-only records with ≤9 fields for interpreter ↔ native interop
- Access named record fields via `.positionalFields` and `.namedFields` on `InterpretedRecord`
- Use classes instead of complex records when native interop is required

---

## Related Documentation

- [D4rt Limitations and Bugs](d4rt_limitations.md) — All fixed bugs and limitations
- [Limitation and Bug Analysis](limitation_and_bug_analysis.md) — Deep-dive analysis with fix strategies
