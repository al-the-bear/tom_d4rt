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
| [Bug-93](#bug-93) | Int not promoted to double return type | Low | Fixed in interpreter_visitor.dart | ✅ Fixed |
| [Bug-94](#bug-94) | Cascade index assignment on property fails | Medium | Fixed in interpreter_visitor.dart | ✅ Fixed |
| [Bug-95](#bug-95) | List.forEach with native function tear-off fails | Medium | Fixed in stdlib/core/list.dart | ✅ Fixed |
| [Bug-96](#bug-96) | super.name constructor parameter forwarding fails | Medium | Fixed in callable.dart | ✅ Fixed |
| [Bug-97](#bug-97) | num not recognized as satisfying Comparable bound | Low | Fixed in runtime_types.dart | ✅ Fixed |
| [Bug-98](#bug-98) | Extension getter on bridged List not resolved | Medium | Type parameterization matching | ⬜ TODO |
| [Bug-99](#bug-99) | Stream.handleError callback receives wrong arg count | Low | May be fixed - needs verification | ⚠️ Verify |
| [Lim-3](#lim-3) | Isolate execution with interpreted code | Fundamental | Dart VM architecture | 🚫 Won't Fix |
| [Bug-14](#bug-14) | Records with named fields or >9 positional fields | High | Dart language limitation | 🚫 Won't Fix |

**Status Legend:**
- ⬜ TODO — Not yet fixed
- ✅ Fixed — Resolved
- ⚠️ Verify — May be fixed, needs verification
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
**Complexity:** Medium

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

#### Detailed Analysis

##### Where It Appears

| File | Location | Description |
|------|----------|-------------|
| `lib/src/d4rt_base.dart` | Lines 258-260 | Only `registerGlobalGetter()` API exists |
| `lib/src/environment.dart` | Lines 17-26 | `GlobalGetter` class only wraps getter, no setter |
| `lib/src/environment.dart` | Lines 306-334 | `assign()` method doesn't handle GlobalGetter specially |
| `lib/src/module_loader.dart` | Line 653 | Wraps getters in `GlobalGetter` during library loading |

##### When It Triggers

1. A bridged library exports a top-level setter (e.g., `set globalValue(int v)`)
2. Interpreted code tries to assign to that setter: `globalValue = 42;`
3. Assignment goes through `Environment.assign()`
4. `assign()` finds `GlobalGetter` in `_values`, but simply replaces it with the new value
5. This breaks the getter (GlobalGetter wrapper is lost) and doesn't call the native setter

##### Why It Happens

**Root Cause:** The API was designed for read-only globals. The architecture assumes:
- Global getters are lazy-evaluated wrappers (`GlobalGetter`)
- Assignment replaces values in `_values` map directly

There's no mechanism to:
1. Register a setter function alongside the getter
2. Detect assignment to a GlobalGetter and call a setter instead of replacing

##### Fix Strategy

**Implementation Approach:**

1. **Extend GlobalGetter to GlobalGetterSetter** (in `environment.dart`):

```dart
class GlobalGetterSetter {
  final Object? Function() getter;
  final void Function(Object? value)? setter;
  GlobalGetterSetter(this.getter, {this.setter});
  
  Object? call() => getter();
}
```

2. **Add `registerGlobalSetter` API** (in `d4rt_base.dart`):

```dart
void registerGlobalSetter(
    String name, 
    void Function(Object?) setter, 
    String library, 
    {String? sourceUri}) {
  // Either:
  // A) Update existing GlobalGetter to GlobalGetterSetter
  // B) Store setters in a separate map _librarySetters
  _librarySetters.add({library: LibrarySetter(name, setter, sourceUri: sourceUri)});
}
```

3. **Update Environment.assign()** (in `environment.dart`):

```dart
Object? assign(String name, Object? value) {
  if (_values.containsKey(name)) {
    final existing = _values[name];
    // Check if it's a GlobalGetterSetter with a setter
    if (existing is GlobalGetterSetter && existing.setter != null) {
      existing.setter!(value);  // Call the native setter
      return value;
    }
    _values[name] = value;  // Normal assignment
    return value;
  }
  // ... rest of method
}
```

4. **Update generator** (in `tom_d4rt_generator`):
   - Emit `registerGlobalSetter()` calls for top-level setters
   - Pair with corresponding `registerGlobalGetter()` calls

**Estimated Effort:** 3-4 hours

**Files to Modify:**
- `tom_d4rt/lib/src/environment.dart` — GlobalGetterSetter class + assign() changes
- `tom_d4rt/lib/src/d4rt_base.dart` — registerGlobalSetter API
- `tom_d4rt/lib/src/module_loader.dart` — Load library setters
- `tom_d4rt_generator/lib/src/*.dart` — Emit setter registration

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
**Complexity:** High

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

#### Detailed Analysis

##### Where It Appears

| File | Location | Description |
|------|----------|-------------|
| `lib/src/interpreter_visitor.dart` | List/collection creation | BridgedInstance wrappers are added to lists |
| `lib/src/stdlib/core/list.dart` | `sort()` method (line ~330) | Calls native `List.sort()` |
| Native Dart List | `sort()` internals | Casts elements to `Comparable<dynamic>` |

##### When It Triggers

1. Interpreted code creates bridged class instances: `SortableItem(3)`
2. Instances are stored as `BridgedInstance<SortableItem>` wrappers in a List
3. Code calls a native method (like `sort()`) that operates on elements
4. Native Dart code tries to cast elements: `element as Comparable<dynamic>`
5. Cast fails because `BridgedInstance` doesn't implement `Comparable`

##### Why It Happens

**Root Cause:** `BridgedInstance<T>` is a wrapper class that holds a reference to the native object but doesn't proxy interface implementations. When native Dart code operates on these wrappers:

- `BridgedInstance` is seen as its own type, not as `T`
- Interface checks fail: `bridgedInstance is Comparable` → false
- Even though `bridgedInstance.nativeObject is Comparable` → true

The interpreter has no control over what happens inside native method calls.

##### Fix Strategy

**Option A: Unwrap elements before native collection method calls** (Recommended)

```dart
// In list.dart sort() bridge:
'sort': (visitor, target, positionalArgs, namedArgs, _) {
  final list = target as List;
  
  // Unwrap all BridgedInstance elements to their native objects
  final unwrappedList = list.map((e) => 
    e is BridgedInstance ? e.nativeObject : e
  ).toList();
  
  // Sort the unwrapped list
  if (positionalArgs.isEmpty) {
    unwrappedList.sort();
  } else {
    // Handle custom comparator...
  }
  
  // Copy results back to original list
  for (var i = 0; i < list.length; i++) {
    if (list[i] is BridgedInstance) {
      // Find the matching native object and update position
      // This is tricky...
    }
  }
}
```

**Challenges with Option A:**
- Sort reorders elements, need to track which wrapper goes where
- All collection methods that pass elements to native code need this
- Performance overhead from copying

**Option B: Store unwrapped objects in collections**

Change how collection creation works:
- Lists store `nativeObject` directly, not `BridgedInstance`
- When accessing elements, wrap on-demand if needed

**Challenges with Option B:**
- Need to track which collections need wrapping behavior
- Breaks when native code modifies collection contents

**Option C: Make BridgedInstance implement common interfaces**

```dart
class BridgedInstance<T> implements Comparable<dynamic> {
  @override
  int compareTo(dynamic other) {
    final otherObj = other is BridgedInstance ? other.nativeObject : other;
    return (nativeObject as Comparable).compareTo(otherObj);
  }
}
```

**Challenges with Option C:**
- Can't know which interfaces `T` implements at compile time
- Would need dynamic proxying (not supported in Dart)

**Recommended Approach:** Option A with careful handling

**Estimated Effort:** 6-8 hours due to complexity

**Files to Modify:**
- `tom_d4rt/lib/src/stdlib/core/list.dart` — `sort()`, `indexOf()`, etc.
- `tom_d4rt/lib/src/stdlib/core/set.dart` — Similar methods
- Consider creating a utility function for unwrap/rewrap operations

---

### Bug-92

**Future factory constructor returns BridgedInstance**

**Status:** ⬜ TODO  
**Relevance:** Medium  
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

#### Detailed Analysis

##### Where It Appears

| File | Location | Description |
|------|----------|-------------|
| `lib/src/stdlib/async/future.dart` | Lines 10-16 | Future factory constructor bridge |
| `lib/src/interpreter_visitor.dart` | Constructor invocation | May wrap return value incorrectly |
| `lib/src/callable.dart` | Async handling | Await expression handling |

##### When It Triggers

1. Interpreted code calls `Future(() => 'Hello')`
2. Bridge constructor in `future.dart` creates: `Future(() => computation.call(visitor, []))`
3. The resulting `Future` is returned from the constructor
4. However, constructor invocation machinery may wrap the result in `BridgedInstance`
5. `await` on `BridgedInstance<Future>` doesn't work as expected

##### Why It Happens

**Root Cause:** Looking at the Future constructor bridge (lines 10-16 in future.dart):

```dart
'': (visitor, positionalArgs, namedArgs) {
  if (positionalArgs.length == 1 && positionalArgs[0] is InterpretedFunction) {
    final computation = positionalArgs[0] as InterpretedFunction;
    return Future(() => computation.call(visitor, []));
  }
  throw RuntimeD4rtException('Invalid arguments for Future constructor.');
},
```

The issue is that this returns a native `Future`, but the **constructor invocation** machinery in `interpreter_visitor.dart` or `runtime_types.dart` may be wrapping the return value in a `BridgedInstance` because it came from a `BridgedClass` constructor.

##### Fix Strategy

**Option A: Mark Future as "unwrapped return"** (Recommended)

Add a flag to `BridgedClass` constructors indicating that the return value should NOT be wrapped:

```dart
constructors: {
  '': BridgedConstructor(
    (visitor, positionalArgs, namedArgs) => ...,
    returnUnwrapped: true,  // Don't wrap in BridgedInstance
  ),
}
```

**Option B: Special-case Future in constructor invocation**

In the code that handles BridgedClass constructor returns, check if the result is already a `Future` and don't wrap it:

```dart
if (result is Future) {
  return result;  // Don't wrap Futures
}
return BridgedInstance(bridgedClass, result);
```

**Option C: Make await handle BridgedInstance<Future>**

In `await` handling code, unwrap if the value is `BridgedInstance<Future>`:

```dart
if (value is BridgedInstance && value.nativeObject is Future) {
  return await (value.nativeObject as Future);
}
```

**Recommended Approach:** Option B or C — they're simpler and handle related cases

**Estimated Effort:** 2-3 hours

**Files to Investigate:**
- `tom_d4rt/lib/src/interpreter_visitor.dart` — Search for BridgedClass constructor invocation
- `tom_d4rt/lib/src/runtime_types.dart` — BridgedClass instantiation
- `tom_d4rt/lib/src/callable.dart` — Await expression handling

---

### Bug-93

**Int not promoted to double return type**

**Status:** ✅ Fixed  
**Relevance:** Low  
**Fixed:** 2026-02-09 — Added int→double promotion in visitReturnStatement

#### Problem Description

When a function declares a `double` return type but returns an `int` value, D4rt rejects this. Dart should implicitly promote int to double.

```dart
double foo(int x) {
  return x;  // ✅ WORKS NOW
}

void main() {
  print(foo(5));  // Prints 5.0
}
```

#### Fix Implementation

**Location:** `tom_d4rt/lib/src/interpreter_visitor.dart` — `visitReturnStatement` (line ~5150)

```dart
// Bug-93 FIX: Dart implicitly promotes int to double when the
// declared return type is double and the value is an int.
if (declaredType.name == 'double' && returnValue is int) {
  showError = false;
  returnValue = returnValue.toDouble();
}
```

---

### Bug-94

**Cascade index assignment on property fails**

**Status:** ✅ Fixed  
**Relevance:** Medium  
**Fixed:** 2026-02-09 — Resolved property chain before index check in _executeCascadeAssignment

#### Problem Description

Cascade expressions with index assignment on a property of the target now work correctly.

```dart
class Request {
  final Map<String, String> headers = {};
}

void main() {
  var request = Request()
    ..headers['Content-Type'] = 'application/json';  // ✅ WORKS NOW
}
```

#### Fix Implementation

**Location:** `tom_d4rt/lib/src/interpreter_visitor.dart` — `_executeCascadeAssignment` (line ~4640)

The cascade handler now resolves the full property chain (`request.headers`) before checking if the target supports index assignment. Previously it was checking the cascade target (`Request`) directly.

---

### Bug-95

**List.forEach with native function tear-off fails**

**Status:** ✅ Fixed  
**Relevance:** Medium  
**Fixed:** 2026-02-09 — Accept both InterpretedFunction and native Function in forEach

#### Problem Description

Calling `forEach` with a native function tear-off (like `print`) now works correctly.

```dart
void main() {
  var numbers = [1, 2, 3];
  numbers.forEach(print);  // ✅ WORKS NOW
}
```

#### Fix Implementation

**Location:** `tom_d4rt/lib/src/stdlib/core/list.dart` — `forEach` method (line ~180)

```dart
'forEach': (visitor, target, positionalArgs, namedArgs, _) {
  final callback = positionalArgs[0];
  // Bug-95 FIX: Accept both InterpretedFunction/Callable and native
  // Dart Function tear-offs (like `print`).
  for (final element in target as List) {
    if (callback is Callable) {
      callback.call(visitor, [element], {});
    } else if (callback is Function) {
      callback(element);  // Native function, call directly
    } else {
      throw RuntimeD4rtException(
          'Expected a function for forEach, got ${callback.runtimeType}');
    }
  }
}
```

---

### Bug-96

**super.name constructor parameter forwarding fails**

**Status:** ✅ Fixed  
**Relevance:** Medium  
**Fixed:** 2026-02-09 — Track super.param forwarding values in callable.dart

#### Problem Description

Dart 3's `super.name` parameter syntax that forwards arguments to the superclass now works.

```dart
class Parent {
  final String name;
  Parent(this.name);
}

class Child extends Parent {
  Child(super.name);  // ✅ WORKS NOW - forwards to Parent
}

void main() {
  print(Child('test').name);  // Prints 'test'
}
```

#### Fix Implementation

**Location:** `tom_d4rt/lib/src/callable.dart` — Constructor parameter processing (lines ~476, ~829)

The fix tracks `SuperFormalParameter` nodes during constructor parameter processing and forwards the values to the superclass constructor call.

---

### Bug-97

**num not recognized as satisfying Comparable bound**

**Status:** ✅ Fixed  
**Relevance:** Low  
**Fixed:** 2026-02-09 — Added num to known Comparable types in runtime_types.dart

#### Problem Description

Using `num` as a type argument for a class with `T extends Comparable<dynamic>` bound now works.

```dart
class Box<T extends Comparable<dynamic>> {
  T value;
  Box(this.value);
}

void main() {
  var b = Box<num>(42);  // ✅ WORKS NOW
  print(b.value);
}
```

#### Fix Implementation

**Location:** `tom_d4rt/lib/src/runtime_types.dart` — `_checkTypeSatisfiesBound` (line ~351)

```dart
if (bound.name == 'Comparable') {
  // Bug-97 FIX: num also implements Comparable<num>
  if (typeArg is BridgedClass) {
    return typeArg.nativeType == String ||
        typeArg.nativeType == int ||
        typeArg.nativeType == double ||
        typeArg.nativeType == num ||  // Added num
        typeArg.nativeType == DateTime;
  }
  return typeArg.name == 'String' ||
      typeArg.name == 'int' ||
      typeArg.name == 'double' ||
      typeArg.name == 'num';  // Added num
}
```

---

### Bug-98

**Extension getter on bridged List not resolved**

**Status:** ⬜ TODO  
**Relevance:** Medium  
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

#### Detailed Analysis

##### Where It Appears

| File | Location | Description |
|------|----------|-------------|
| `lib/src/environment.dart` | Lines 358-405 | `findExtensionMember()` method |
| `lib/src/environment.dart` | Lines 407-445 | `getRuntimeType()` for type matching |
| `lib/src/runtime_types.dart` | `isSubtypeOf()` | Type comparison logic |

##### When It Triggers

1. Interpreted code defines `extension IntListExt on List<int> { ... }`
2. Extension is stored in environment with `onType = List<int>` (a BridgedClass with type args)
3. Code accesses `numbers.sum` where `numbers` is a native `List<int>`
4. `findExtensionMember()` gets the runtime type of `numbers`
5. `getRuntimeType()` returns `List` (without type arguments)
6. Type check: `List.isSubtypeOf(List<int>)` fails because `List` != `List<int>`

##### Why It Happens

**Root Cause:** The `getRuntimeType()` method in `environment.dart` (lines 419-422) returns:

```dart
if (value is List) typeName = 'List';  // No type arguments!
if (value is Map) typeName = 'Map';
```

This loses the type argument information. When comparing:
- Extension `onType`: `List<int>` (RuntimeType with typeArguments)
- Actual `numbers` type: `List` (RuntimeType without typeArguments)
- `List.isSubtypeOf(List<int>)` → false (invariance check fails)

##### Fix Strategy

**Option A: Infer element types from collection contents**

In `getRuntimeType()`, when the value is a List with elements, infer the element type:

```dart
if (value is List) {
  if (value.isNotEmpty) {
    final elementType = getRuntimeType(value.first);
    // Return List<elementType> instead of just List
    return BridgedClassWithTypeArgs('List', [elementType]);
  }
  return get('List') as RuntimeType;
}
```

**Option B: Relax extension matching for raw types**

In `findExtensionMember()`, when matching extensions:
- If target type is `List` (no args) and extension is on `List<T>`, allow match
- The extension itself handles type constraints

```dart
bool matchesExtension(RuntimeType target, RuntimeType extensionOnType) {
  if (target.name == extensionOnType.name) {
    // Same base type, allow if extension has type args but target doesn't
    if (target.typeArguments.isEmpty) return true;
    // Otherwise check subtype normally
    return target.isSubtypeOf(extensionOnType);
  }
  return false;
}
```

**Option C: Track declared type, not runtime type**

When the variable is declared, remember its declared type (including type arguments) and use that for extension matching.

**Recommended Approach:** Option B — simpler and handles most cases

**Estimated Effort:** 3-4 hours

**Files to Modify:**
- `tom_d4rt/lib/src/environment.dart` — `findExtensionMember()` type matching
- `tom_d4rt/lib/src/runtime_types.dart` — Potentially relax `isSubtypeOf()` for extension matching

---

### Bug-99

**Stream.handleError callback receives wrong arg count**

**Status:** ⚠️ Verify  
**Relevance:** Low  
**Complexity:** Low

#### Problem Description

`Stream.handleError()` with a single-argument callback may receive two arguments.

```dart
import 'dart:async';

void main() async {
  var stream = Stream.fromIterable([1, 2, 3]).map((n) {
    if (n == 2) throw 'Error at $n';
    return n;
  });
  var handled = stream.handleError((e) {  // Should only get 1 arg
    print('Handled: $e');
  });
  await for (var n in handled) {
    print('Value: $n');
  }
}
```

**Error:** `Too many positional arguments. Expected at most 1, got 2.`

#### Detailed Analysis

##### Where It Appears

| File | Location | Description |
|------|----------|-------------|
| `lib/src/stdlib/async/stream.dart` | Lines 378-407 | `handleError` bridge implementation |

##### Current Code Review

Looking at the current implementation (lines 386-398 in stream.dart):

```dart
'handleError': (visitor, target, positionalArgs, namedArgs, _) {
  final onError = positionalArgs[0] as InterpretedFunction;
  final test = namedArgs['test'] as InterpretedFunction?;
  // Dart's handleError callback can take 1 or 2 arguments
  // Check the callback arity to pass the correct number of args
  final callbackArity = onError.arity;  // <-- This checks arity!
  return (target as Stream).handleError(
    (error, stackTrace) {
      return callbackArity >= 2
          ? _runAction<void>(visitor, onError, [actualError, stackTrace])
          : _runAction<void>(visitor, onError, [actualError]);  // <-- Only 1 arg
    },
    ...
  );
}
```

**The code already checks arity!** The issue may be:
1. Already fixed in current code
2. Problem with how `arity` is calculated on `InterpretedFunction`
3. Edge case not covered (e.g., callback from different source)

##### Verification Needed

**Status: ⚠️ Needs test verification**

1. Create a test case with single-arg callback:
```dart
stream.handleError((e) { print(e); })
```

2. Create a test case with two-arg callback:
```dart
stream.handleError((e, st) { print('$e\n$st'); })
```

3. Verify both work correctly

##### Potential Issues if Still Broken

If `arity` is not being calculated correctly on `InterpretedFunction`, check:

| File | Location | What to Check |
|------|----------|--------------|
| `lib/src/callable.dart` | `InterpretedFunction.arity` getter | Is it counting parameters correctly? |
| N/A | Optional parameters | Does arity include optional params? |

##### Fix Strategy (if needed)

If `arity` isn't working, change to explicit parameter count:

```dart
final paramCount = onError.parameters?.parameters.length ?? 0;
```

**Estimated Effort:** 1-2 hours (including verification)

**Files to Check:**
- `tom_d4rt/lib/src/stdlib/async/stream.dart` — handleError implementation
- `tom_d4rt/lib/src/callable.dart` — InterpretedFunction.arity getter

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
