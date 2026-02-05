# D4rt Interpreter Limitations and Bugs

This document provides a comprehensive reference of all known D4rt interpreter limitations and bugs, their current status, fixability assessment, and solution strategies.

**Last Updated:** 2026-02-05

---

## Issue Tracker

Combined list of all limitations and bugs, sorted by estimated fix complexity (Low → Medium → High → Won't Fix).

| ID | Description | Complexity | Status |
|----|-------------|------------|--------|
| Bug-1 | [List.empty() constructor not bridged](#bug-1-listempty-constructor-not-bridged) | Low | ✅ Fixed |
| Bug-2 | [Queue.addAll() method not bridged](#bug-2-queueaddall-method-not-bridged) | Low | ✅ Fixed |
| Bug-3 | [Enum value access via Day.wednesday fails](#bug-3-enum-value-access) | Low | ✅ Fixed |
| Bug-4 | [Enum value at top-level const fails](#bug-4-enum-value-at-top-level-const-fails) | Low | ✅ Fixed |
| Bug-5 | [Division by zero throws instead of returning infinity](#bug-5-division-by-zero-throws-instead-of-returning-infinity) | Low | ✅ Fixed |
| Bug-6 | [Record missing Object methods (hashCode)](#bug-6-record-missing-object-methods-hashcode) | Low | ✅ Fixed |
| Bug-7 | [Digit separators (1_000_000) not parsed](#bug-7-digit-separators-1_000_000-not-parsed) | Low | ✅ Fixed |
| Bug-8 | [List.indexWhere() method not bridged](#bug-8-listindexwhere-method-not-bridged) | Low | ✅ Fixed |
| Bug-15 | [base64Encode function not exported from dart:convert](#bug-15-base64encode-function-not-exported-from-dartconvert) | Low | ✅ Fixed |
| Bug-20 | [identical() function not bridged](#bug-20-identical-function-not-bridged) | Low | ✅ Fixed |
| Bug-21 | [Set.from() constructor not bridged](#bug-21-setfrom-constructor-not-bridged) | Low | ✅ Fixed |
| Bug-22 | [Error() class constructor not bridged](#bug-22-error-class-constructor) | Low | ✅ Fixed |
| Bug-50 | [Index assignment operator \[\]= not found](#bug-50-index-assignment-operator) | Low | ✅ Fixed |
| Bug-52 | [Implicit super() fails when superclass has constructors](#bug-52-implicit-super-fails-when-superclass-has-constructors) | Low | ✅ Fixed |
| Bug-53 | [NullAwareElement feature not supported](#bug-53-nullawareelement-feature-not-supported) | Low | ✅ Fixed |
| Bug-54 | [Void return type checking too strict](#bug-54-void-return-type) | Low | ✅ Fixed |
| Bug-55 | [Symbol class not bridged](#bug-55-symbol-class-not-bridged) | Low | ⬜ TODO |
| Bug-65 | [Map.from constructor not bridged](#bug-65-mapfrom-constructor-not-bridged) | Low | ⬜ TODO |
| Bug-71 | [Error class not bridged (undefined variable)](#bug-71-error-class-not-bridged) | Low | ⬜ TODO |
| Lim-2 | [Extensions on bridged types don't work](#lim-2-extensions-on-bridged-types-dont-work) | Medium | ✅ Fixed |
| Lim-5, Bug-40 | [Comparable interface not implemented for interpreted classes](#lim-5-bug-40-comparable-interface-not-implemented) | Medium | ✅ Fixed |
| Lim-6, Bug-32 | [Labeled continue in switch statements](#lim-6-bug-32-labeled-continue-in-switch-statements) | Medium | ✅ Fixed |
| Lim-7, Bug-42 | [noSuchMethod not invoked for getter/setter access](#lim-7-bug-42-nosuchmethod-gettersetter-access) | Medium | ✅ Fixed |
| Lim-9, Bug-41 | [Await in string interpolation shows raw object](#lim-9-bug-41-await-in-string-interpolation) | Medium | ✅ Fixed |
| Bug-56 | [Constructor with positional arguments fails](#bug-56-constructor-positional-arguments) | Medium | ✅ Fixed |
| Bug-57 | [Class with operator override and constructor fails](#bug-57-operator-override-constructor) | Medium | ✅ Fixed |
| Bug-58 | [Functions/classes at end of file not found](#bug-58-declarations-at-file-end) | Medium | ✅ Fixed |
| Bug-59 | [Imported classes have empty constructor maps](#bug-59-imported-classes-have-empty-constructor-maps) | Medium | ✅ Fixed |
| Bug-63 | [Abstract method from interface false positive](#bug-63-abstract-method-interface) | Medium | ✅ Fixed |
| Bug-66 | [Record pattern with named field fails](#bug-66-record-pattern-named-field) | Medium | ✅ Fixed |
| Bug-69 | [Abstract getter from mixin false positive](#bug-69-abstract-getter-mixin) | Medium | ✅ Fixed |
| Bug-70 | [await on Future.value fails](#bug-70-await-future-value) | Medium | ✅ Fixed |
| Bug-9 | [Type Never not found in type resolution](#bug-9-type-never-not-found-in-type-resolution) | Medium | ✅ Fixed |
| Bug-10 | [Interface Comparable not found for implements](#bug-10-interface-comparable-not-found-for-implements) | Medium | ✅ Fixed |
| Bug-11 | [Sealed class subclasses incorrectly rejected](#bug-11-sealed-class-subclasses-incorrectly-rejected) | Medium | ✅ Fixed |
| Bug-12 | [Interface Exception not found for implements](#bug-12-interface-exception-not-found-for-implements) | Medium | ✅ Fixed |
| Bug-16 | [Abstract method inheritance false positive](#bug-16-abstract-method-inheritance) | Medium | ✅ Fixed |
| Bug-17 | [Interface class same-library extension incorrectly rejected](#bug-17-interface-class-extension) | Medium | ✅ Fixed |
| Bug-18 | [Mixin abstract getter inheritance false positive](#bug-18-mixin-abstract-getter) | Medium | ✅ Fixed |
| Bug-23 | [Static const referencing sibling const fails](#bug-23-static-const-referencing-sibling-const-fails) | Medium | ✅ Fixed |
| Bug-24 | [mixin class declaration not supported](#bug-24-mixin-class-declaration-not-supported) | Medium | ✅ Fixed |
| Bug-26 | [Assert in constructor initializer not supported](#bug-26-assert-in-constructor-initializer-not-supported) | Medium | ✅ Fixed |
| Bug-27 | [Short-circuit && with null check fails](#bug-27-short-circuit--with-null-check-fails) | Medium | ✅ Fixed |
| Bug-28 | [GenericFunctionTypeImpl not implemented](#bug-28-genericfunctiontypeimpl) | Medium | ✅ Fixed |
| Bug-29 | [Future.value() returns wrong type](#bug-29-futurevalue-type) | Medium | ✅ Fixed |
| Bug-44 | [Async generators completion detection issues](#bug-44-async-generators) | Medium | ✅ Fixed |
| Bug-48 | [await for stream iteration fails](#bug-48-await-for-stream) | Medium | ✅ Fixed |
| Bug-51 | [Bridged mixins not found during type resolution](#bug-51-bridged-mixins) | Medium | ✅ Fixed |
| Bug-60 | [Null-safe indexing on null throws unclear error](#bug-60-null-safe-indexing) | Medium | ⬜ TODO |
| Bug-61 | [if-case pattern evaluates pattern as condition](#bug-61-if-case-pattern) | Medium | ⬜ TODO |
| Bug-62 | [GenericFunctionType in generic type args fails](#bug-62-genericfunctiontype-in-generics) | Medium | ⬜ TODO |
| Bug-64 | [Interface class same-library extension rejected](#bug-64-interface-class-extension) | Medium | ⬜ TODO |
| Bug-67 | [if-case with int pattern wrong condition type](#bug-67-if-case-int-pattern) | Medium | ⬜ TODO |
| Bug-45 | [Labeled continue in sync* generators fails](#bug-45-labeled-continue-in-sync-generators-fails) | Medium | ⬜ TODO |
| Bug-47 | [Future.doWhile type cast issues](#bug-47-futuredowhile-type-cast-issues) | Medium | ⬜ TODO |
| Bug-14 | [Records with named fields or >9 positional fields return InterpretedRecord](#bug-14-records-with-named-fields-or-9-positional-fields) | High | ⬜ TODO |
| Lim-4, Bug-43 | [Infinite sync* generators hang (eager evaluation)](#lim-4-bug-43-infinite-sync-generators-hang) | High | ⬜ TODO |
| Lim-8, Bug-13, Bug-68 | [Logical OR patterns in switch cases](#lim-8-bug-13-logicalorpattern-in-switch) | High | ⬜ TODO |
| Lim-1 | [Extension types (Dart 3.3+ inline classes) not supported](#lim-1-extension-types-dart-33-not-supported) | High | ⬜ TODO |
| Lim-3 | [Isolate execution with interpreted code](#lim-3-isolate-execution-with-interpreted-code) | Fundamental | 🚫 Won't Fix |

**Status Legend:**
- ⬜ TODO - Not yet fixed
- ✅ Fixed - Confirmed working
- 🚫 Won't Fix - Fundamental limitation or too complex

---

## Detailed Descriptions

---

### Lim-1: Extension Types (Dart 3.3+) Not Supported

**Status:** ⬜ TODO  
**Fixable:** ⚠️ Major effort required  
**Complexity:** High

#### Problem Description

Extension types (introduced in Dart 3.3) are inline class wrappers that provide zero-cost abstraction at compile time. D4rt does not support these.

```dart
extension type UserId(int value) {
  bool get isValid => value > 0;
}

void main() {
  var id = UserId(42);
  print(id.value);    // ❌ FAILS
  print(id.isValid);  // ❌ FAILS
}
```

**Error:** Parse error or undefined variable.

#### Where is the Problem?

- **Location:** AST handling - `visitExtensionTypeDeclaration` does not exist
- **Root Cause:** The analyzer provides `ExtensionTypeDeclaration` nodes, but D4rt has no visitor to handle them

#### Potential Fix Strategies

1. **Strategy A: Implement full extension type support**
   - Add `visitExtensionTypeDeclaration` method
   - Create `InterpretedExtensionType` class
   - Handle representation field and member access
   - Complexity: High - requires understanding full Dart 3.3+ semantics

2. **Strategy B: Document as unsupported**
   - Extension types are relatively new
   - Users can use regular extensions or classes instead
   - Complexity: None

**Test File:** `d4rt_bugs/extensions/test9_extension_types.dart`

---

### Lim-2: Extensions on Bridged Types Don't Work

**Status:** ✅ Fixed  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Extensions defined in interpreted code cannot be used on bridged instances (like `DateTime`, `Duration`, custom bridged classes).

```dart
extension DateTimeExtension on DateTime {
  bool get isWeekend => weekday == DateTime.saturday || weekday == DateTime.sunday;
}

void main() {
  var now = DateTime.now();  // Bridged instance
  print(now.isWeekend);  // ❌ FAILS
}
```

**Error:** `Undefined property or method 'isWeekend' on bridged instance of 'DateTime'.`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` → `visitPrefixedIdentifier()`, `visitPropertyAccess()`
- **Root Cause:** When accessing a property on a bridged instance fails, the interpreter throws immediately instead of checking for applicable extensions

#### Solution

Fixed in 2026-02-06:
1. Modified `toBridgedClass()` in `environment.dart` to search enclosing environments recursively
2. Added missing `DateTime` static getters (`saturday`, `sunday`, `monday`-`friday`, `january`-`december`, `daysPerWeek`, `monthsPerYear`)
3. Extension lookup for bridged types now works correctly via `findExtensionMember()`

**Test File:** `d4rt_bugs/extensions/test10_bridged_extension.dart`

---

### Lim-3: Isolate Execution with Interpreted Code

**Status:** 🚫 Won't Fix (Fundamental)  
**Fixable:** ❌ No  
**Complexity:** Fundamental architectural limitation

#### Problem Description

Interpreted closures cannot be passed to `Isolate.run()` or other isolate APIs because they cannot be serialized and sent across isolate boundaries.

```dart
final result = await Isolate.run(() {
  return expensiveCalculation();  // ❌ Cannot run in isolate
});
```

#### Where is the Problem?

- **Location:** Dart VM architecture
- **Root Cause:** Isolates communicate via message passing. Interpreted closures contain:
  - References to AST nodes (not serializable)
  - References to `Environment` scopes
  - References to `InterpreterVisitor` state

#### Workarounds

1. Move isolate-heavy computation to bridged (compiled) Dart classes
2. Design scripts for single-threaded execution
3. Use external processes instead of isolates

---

### Lim-4, Bug-43: Infinite Sync* Generators Hang

**Status:** ⬜ TODO  
**Fixable:** ⚠️ Major effort  
**Complexity:** High

#### Problem Description

Sync* generators that yield infinitely will hang because D4rt evaluates them eagerly.

```dart
Iterable<int> naturals() sync* {
  int n = 0;
  while (true) {
    yield n++;
  }
}

void main() {
  print(naturals().take(5).toList());  // ❌ Hangs - evaluates entire generator
}
```

#### Where is the Problem?

- **Location:** `callable.dart` → sync* generator implementation
- **Root Cause:** D4rt collects all yielded values into a list before returning. Native Dart uses lazy evaluation.

#### Potential Fix Strategies

1. **Strategy A: Implement true lazy iteration**
   - Create custom `Iterable`/`Iterator` that holds execution state
   - `moveNext()` executes until next yield, then suspends
   - Complexity: High - major refactor of generator handling

**Test File:** `d4rt_bugs/hard_high/bug_43_infinite_generator.dart`

---

### Lim-5, Bug-40: Comparable Interface Not Implemented

**Status:** ✅ Fixed  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Interpreted class instances don't implement Dart interfaces like `Comparable`, so native methods like `List.sort()` fail.

```dart
class Person implements Comparable<Person> {
  final String name;
  Person(this.name);
  
  @override
  int compareTo(Person other) => name.compareTo(other.name);
}

void main() {
  var people = [Person('Bob'), Person('Alice')];
  people.sort();  // ❌ Cast error
}
```

**Error:** `InterpretedInstance` cannot be cast to `Comparable`

#### Where is the Problem?

- **Location:** Native `List.sort()` implementation
- **Root Cause:** `InterpretedInstance` is a wrapper that doesn't implement `Comparable<T>`

#### Solution

Fixed in 2026-02-06:
Modified the `List.sort` bridge in `stdlib/core/list.dart` to detect when list elements are `InterpretedInstance` and use the interpreted `compareTo` method instead of native comparison.

**Test File:** `d4rt_bugs/hard_high/bug_40_comparable_sort.dart`

---

### Lim-6, Bug-32: Labeled Continue in Switch Statements

**Status:** ✅ Fixed  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

`continue labelName;` to jump to another case in a switch statement is not supported.

```dart
void main() {
  switch (1) {
    case 1:
      print('One');
      continue two;  // ❌ Not supported
    two:
    case 2:
      print('Two');
      break;
  }
}
```

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` → switch case handling
- **Root Cause:** Continue with label inside switch cases requires tracking case labels and jumping

#### Solution

Fixed in 2026-02-06:
1. Rewrote `visitSwitchStatement` to track label-to-case-index mapping
2. Added `ContinueSwitchLabel` exception class in `exceptions.dart`
3. When `continue <label>` is caught inside switch, restart execution from the labeled case

**Test File:** `d4rt_bugs/hard_high/bug_32_continue_label.dart`

---

### Lim-7, Bug-42: noSuchMethod Getter/Setter Access

**Status:** ✅ Fixed  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

`noSuchMethod` override is invoked for method calls, but not for getter/setter access.

```dart
class Dynamic {
  @override
  noSuchMethod(Invocation invocation) {
    print('Called: ${invocation.memberName}');
    return 'handled';
  }
}

void main() {
  dynamic d = Dynamic();
  d.anyMethod();      // ✅ Works - calls noSuchMethod
  print(d.someGetter); // ❌ FAILS - throws instead
}
```

#### Where is the Problem?

- **Location:** Property access handling in `interpreter_visitor.dart`
- **Root Cause:** Getter/setter access paths throw `RuntimeError` without checking for `noSuchMethod`

#### Solution

Fixed in 2026-02-06:
1. Modified `InterpretedInstance.get()` in `runtime_types.dart` to check for `noSuchMethod` before throwing
2. Updated `visitPrefixedIdentifier` to pass the visitor to `get()` so `noSuchMethod` can be called
3. When a property is not found, creates an `Invocation.getter(#propertyName)` and calls `noSuchMethod`

**Test File:** `d4rt_bugs/hard_high/bug_42_nosuchmethod.dart`

---

### Lim-8, Bug-13: LogicalOrPattern in Switch

**Status:** ⬜ TODO  
**Fixable:** ⚠️ Major  
**Complexity:** High

#### Problem Description

Logical OR patterns (`||`) in switch cases are not fully supported in all contexts.

```dart
switch (day) {
  case Day.saturday || Day.sunday:  // ❌ May not work in some contexts
    print('Weekend');
}
```

#### Workarounds

Use separate cases:
```dart
switch (day) {
  case Day.saturday:
  case Day.sunday:
    print('Weekend');
}
```

---

### Lim-9, Bug-41: Await in String Interpolation

**Status:** ✅ Fixed  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Await expressions inside string interpolation don't work correctly.

```dart
Future<String> getName() async => 'Alice';

void main() async {
  print('Hello ${await getName()}');  // ❌ May not resolve correctly
}
```

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` → `visitStringInterpolation()`, `callable.dart` → async state machine
- **Root Cause:** When await inside interpolation suspends, the string wasn't being rebuilt on resumption

#### Solution

Fixed in 2026-02-06:
1. Modified `visitStringInterpolation()` to propagate `AsyncSuspensionRequest` upward when encountered
2. Added handling for `ReturnStatement` with nested await in `_determineNextNodeAfterAwait()`
3. On resumption, enables `isInvocationResumptionMode` and re-evaluates the return expression so the await returns the resolved value

**Test File:** `d4rt_bugs/hard_high/bug_41_future_interpolation.dart`

---

## Detailed Bug Descriptions (Open Bugs)

This section provides detailed analysis for all bugs with ⬜ TODO status.

---

### Bug-1: List.empty() Constructor Not Bridged

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

The `List.empty()` constructor is not available in the D4rt bridge.

```dart
void main() {
  var list = List<int>.empty(growable: true);  // ❌ FAILS
  list.add(1);
  print(list);
}
```

**Error:** `Bridged class 'List' does not have a registered constructor named 'empty'.`

#### Where is the Problem?

- **Location:** `lib/src/bridges/dart_core/list_bridge.dart`
- **Root Cause:** The `empty` named constructor was not added to the List bridge registration

#### Potential Fix Strategies

1. **Strategy A: Add empty constructor to List bridge**
   - In `ListBridge`, register `empty` constructor
   - Handle the `growable` parameter
   - Return `List<T>.empty(growable: growable)`
   - Complexity: Low - straightforward constructor addition

---

### Bug-2: Queue.addAll() Method Not Bridged

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

The `Queue.addAll()` method is not bridged.

```dart
import 'dart:collection';

void main() {
  var queue = Queue<int>();
  queue.addAll([1, 2, 3]);  // ❌ FAILS
  print(queue);
}
```

**Error:** `Bridged class 'Queue' has no instance method named 'addAll'.`

#### Where is the Problem?

- **Location:** `lib/src/bridges/dart_collection/queue_bridge.dart`
- **Root Cause:** The `addAll` method was not registered in the Queue bridge

#### Potential Fix Strategies

1. **Strategy A: Add addAll method to Queue bridge**
   - In `QueueBridge`, register `addAll` instance method
   - Unwrap the iterable argument and call native `addAll`
   - Complexity: Low - standard method bridging

---

### Bug-5: Division by Zero Throws Instead of Returning Infinity

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

Floating-point division by zero should return `infinity` or `NaN`, but throws an error.

```dart
void main() {
  var result = 1.0 / 0.0;  // ❌ FAILS - should return infinity
  print(result);
}
```

**Error:** `Division par zéro` (French locale error message)

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` → binary operator handling
- **Root Cause:** There's explicit division-by-zero checking that throws before the native operation can produce infinity

#### Potential Fix Strategies

1. **Strategy A: Remove explicit zero check for floating-point division**
   - Check if operands are `double` - if so, let native division handle it
   - Only throw for integer division by zero
   - Complexity: Low

---

### Bug-6: Record Missing Object Methods (hashCode)

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

Dart records don't expose `hashCode`, `runtimeType`, and other Object methods through the interpreter.

```dart
void main() {
  var r = (1, 2, name: 'test');
  print(r.hashCode);  // ❌ FAILS
}
```

**Error:** `Record has no field named 'hashCode'. Available fields: name`

#### Where is the Problem?

- **Location:** Record property access handling
- **Root Cause:** Record field lookup doesn't fall back to Object methods

#### Potential Fix Strategies

1. **Strategy A: Add Object method fallback for records**
   - When accessing a property on a record, if not a field, check Object methods
   - Handle `hashCode`, `runtimeType`, `toString`, `noSuchMethod`
   - Complexity: Low

---

### Bug-7: Digit Separators (1_000_000) Not Parsed

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

Dart's digit separator feature (underscores in numeric literals) is not parsed.

```dart
void main() {
  var million = 1_000_000;  // ❌ FAILS
  print(million);
}
```

**Error:** `This requires the 'digit-separators' language feature to be enabled.`

#### Where is the Problem?

- **Location:** Parser configuration / language version settings
- **Root Cause:** The language version or feature flags don't include digit separators

#### Potential Fix Strategies

1. **Strategy A: Enable digit-separators language feature**
   - Update the analyzer's language version to Dart 2.6+ where digit separators are stable
   - Ensure feature flags include `digit-separators`
   - Complexity: Low - configuration change

---

### Bug-8: List.indexWhere() Method Not Bridged

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

The `List.indexWhere()` method is not bridged.

```dart
void main() {
  var list = ['a', 'b', 'c', 'd'];
  print(list.indexWhere((e) => e == 'b'));  // ❌ FAILS
}
```

**Error:** `Bridged class 'List' has no instance method named 'indexWhere'.`

#### Where is the Problem?

- **Location:** `lib/src/bridges/dart_core/list_bridge.dart`
- **Root Cause:** The `indexWhere` method was not registered in the List bridge

#### Potential Fix Strategies

1. **Strategy A: Add indexWhere method to List bridge**
   - Register `indexWhere` instance method
   - Handle the function argument (interpreted closure)
   - Wrap interpreted function as native callback
   - Complexity: Low - but requires function unwrapping

---

### Bug-9: Type Never Not Found in Type Resolution

**Status:** 🔍 Confirm Fix  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

The `Never` type is not resolved in type annotations.

```dart
Never throwError() {  // ❌ FAILS
  throw Exception('Error');
}
```

**Error:** `Type 'Never' not found.`

#### Where is the Problem?

- **Location:** Type resolution in `type_resolver.dart` or similar
- **Root Cause:** `Never` is a special type not registered in the type system

#### Potential Fix Strategies

1. **Strategy A: Register Never as a special type**
   - Add `Never` to the built-in types alongside `void`, `dynamic`, etc.
   - Handle Never in function return type validation
   - Complexity: Medium - touches type system

---

### Bug-10: Interface Comparable Not Found for Implements

**Status:** 🔍 Confirm Fix  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Implementing `Comparable<T>` fails because the interface is not found.

```dart
class Value implements Comparable<Value> {  // ❌ FAILS
  final int n;
  Value(this.n);
  
  @override
  int compareTo(Value other) => n.compareTo(other.n);
}
```

**Error:** `Interface 'Comparable' not found for class 'Value'. Ensure it's defined.`

#### Where is the Problem?

- **Location:** Class declaration handling, interface resolution
- **Root Cause:** Dart core interfaces like `Comparable` are not registered as available interfaces

#### Potential Fix Strategies

1. **Strategy A: Register Dart core interfaces**
   - Add `Comparable`, `Iterator`, `Iterable`, etc. to the interface registry
   - These are "marker" interfaces - implementation checking is already done by the bridge
   - Complexity: Medium - need to identify all core interfaces

---

### Bug-11: Sealed Class Subclasses Incorrectly Rejected

**Status:** 🔍 Confirm Fix  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Subclasses of sealed classes are incorrectly rejected even when in the same library.

```dart
sealed class Shape {}
class Circle extends Shape {}  // ❌ FAILS
```

**Error:** `Class 'Circle' cannot extend sealed class 'Shape' outside of its library.`

#### Where is the Problem?

- **Location:** Class modifier checking during class declaration
- **Root Cause:** Library boundary checking is too strict or incorrect

#### Potential Fix Strategies

1. **Strategy A: Fix library boundary detection**
   - When checking if subclass is in same library as sealed parent
   - Ensure interpreted code in the same module is treated as same library
   - Complexity: Medium

---

### Bug-12: Interface Exception Not Found for Implements

**Status:** 🔍 Confirm Fix  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Implementing `Exception` fails because the interface is not found.

```dart
class MyException implements Exception {  // ❌ FAILS
  final String message;
  MyException(this.message);
}
```

**Error:** `Interface 'Exception' not found for class 'MyException'. Ensure it's defined.`

#### Where is the Problem?

- **Location:** Interface resolution
- **Root Cause:** `Exception` is not registered as an available interface

#### Potential Fix Strategies

1. **Strategy A: Register Exception interface**
   - Add `Exception` to the interface registry
   - `Exception` is a simple marker interface in Dart
   - Complexity: Low - same pattern as Bug-10

---

### Bug-14: Records with Named Fields or >9 Positional Fields

**Status:** ⬜ TODO  
**Fixable:** ⚠️ Partial - Dart limitation  
**Complexity:** High

#### Problem Description

D4rt now supports record type annotations and can execute record operations. However, when returning records from `execute()` or `eval()`, there's a limitation:

- **Positional-only records with 1-9 fields**: Converted to native Dart records ✅
- **Records with named fields**: Return as `InterpretedRecord` ❌
- **Records with >9 positional fields**: Return as `InterpretedRecord` ❌

```dart
// ✅ WORKS - returns native (2, 1)
(int, int) swap((int, int) pair) {
  return (pair.$2, pair.$1);
}

// ❌ Returns InterpretedRecord, not native record
({int x, int y}) getPoint() {
  return (x: 10, y: 20);
}

// ❌ Returns InterpretedRecord (>9 elements)
(int, int, int, int, int, int, int, int, int, int) getTen() {
  return (1, 2, 3, 4, 5, 6, 7, 8, 9, 10);
}
```

**Error:** No runtime error, but the returned value is `InterpretedRecord` instead of a native Dart record, which fails equality checks with native records.

#### Where is the Problem?

- **Location:** `D4rt._bridgeInterpreterValueToNative()` in `d4rt_base.dart`
- **Root Cause:** Dart does not support creating record types dynamically at runtime. Records are compile-time constructs, so we can only create them via hardcoded switch cases for each arity.

#### Current Implementation

The interpreter converts positional-only records to native records using a switch on arity:

```dart
switch (pos.length) {
  case 1: return (pos[0],);
  case 2: return (pos[0], pos[1]);
  // ... up to 9
  default: return InterpretedRecord(pos, {});
}
```

#### Potential Fix Strategies

1. **Strategy A: Extend to more arities**
   - Add more cases (10, 11, 12...)
   - Practical limit before code becomes unwieldy
   - Complexity: Low (just more cases)

2. **Strategy B: Named field combinations**
   - Would require generating all possible named field combinations
   - Combinatorial explosion makes this impractical
   - Complexity: Impractical

3. **Strategy C: Code generation**
   - Generate switch cases for common patterns
   - Still limited by what patterns are pre-generated
   - Complexity: Medium

4. **Strategy D: Accept limitation**
   - Document that named records and large positional records return `InterpretedRecord`
   - Users can access fields via `.positionalFields` and `.namedFields`
   - Complexity: None

---

### Bug-20: identical() Function Not Bridged

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

The `identical()` top-level function is not available.

```dart
void main() {
  var a = [1, 2, 3];
  var b = a;
  print(identical(a, b));  // ❌ FAILS
}
```

**Error:** `Undefined variable: identical`

#### Where is the Problem?

- **Location:** Top-level function registration for dart:core
- **Root Cause:** `identical` function was not registered

#### Potential Fix Strategies

1. **Strategy A: Register identical function**
   - Add `identical` to dart:core top-level functions
   - Implementation: `(a, b) => identical(a, b)`
   - Complexity: Low - one function registration

---

### Bug-21: Set.from() Constructor Not Bridged

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

The `Set.from()` constructor is not bridged.

```dart
void main() {
  var set = Set<int>.from([1, 2, 3]);  // ❌ FAILS
  print(set);
}
```

**Error:** `Bridged class 'Set' does not have a registered constructor named 'from'.`

#### Where is the Problem?

- **Location:** `lib/src/bridges/dart_core/set_bridge.dart`
- **Root Cause:** The `from` constructor was not registered

#### Potential Fix Strategies

1. **Strategy A: Add from constructor to Set bridge**
   - Register `from` factory constructor
   - Unwrap the iterable argument
   - Return `Set<T>.from(iterable)`
   - Complexity: Low

---

### Bug-23: Static Const Referencing Sibling Const Fails

**Status:** 🔍 Confirm Fix  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Static const fields cannot reference other static const fields in the same class.

```dart
class Colors {
  static const red = '#FF0000';
  static const blue = '#0000FF';
  static const defaultColor = blue;  // ❌ FAILS
}
```

**Error:** `Undefined variable: blue`

#### Where is the Problem?

- **Location:** Static field initialization order
- **Root Cause:** When initializing `defaultColor`, `blue` isn't yet in scope

#### Potential Fix Strategies

1. **Strategy A: Two-pass static field initialization**
   - First pass: register all static field names
   - Second pass: evaluate initializers with all names available
   - Complexity: Medium

---

### Bug-24: mixin class Declaration Not Supported

**Status:** 🔍 Confirm Fix  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

The `mixin class` declaration (Dart 3.0+) is not supported.

```dart
mixin class Logger {  // ❌ FAILS
  void log(String msg) => print('[LOG] $msg');
}

class Service with Logger {}
```

**Error:** `Class 'Logger' cannot be used as a mixin because it's not declared with 'mixin' or 'class mixin'.`

#### Where is the Problem?

- **Location:** Mixin resolution during `with` clause handling
- **Root Cause:** `mixin class` modifier combination not recognized

#### Potential Fix Strategies

1. **Strategy A: Recognize mixin class modifier**
   - When parsing class declarations, detect `mixin class` syntax
   - Mark such classes as usable both as class and mixin
   - Complexity: Medium

---

### Bug-27: Short-Circuit && with Null Check Fails

**Status:** 🔍 Confirm Fix  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Short-circuit evaluation with `&&` doesn't prevent null access.

```dart
void main() {
  String? name;
  if (name != null && name.isNotEmpty) {  // ❌ FAILS
    print('Has name');
  }
}
```

**Error:** `Cannot access property 'isNotEmpty' on target of type null.`

#### Where is the Problem?

- **Location:** Binary expression evaluation for `&&`
- **Root Cause:** Both sides may be evaluated before short-circuit logic is applied, or type promotion isn't working

#### Potential Fix Strategies

1. **Strategy A: Ensure lazy evaluation of &&**
   - Evaluate left side first
   - If false, don't evaluate right side
   - Also check if type promotion is being applied after null check
   - Complexity: Medium

---

### Bug-4: Enum Value at Top-Level const Fails

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

Accessing enum values in top-level `const` declarations fails, even though accessing them directly (e.g., `Day.wednesday`) works.

```dart
enum Day { monday, tuesday, wednesday, thursday, friday }

const today = Day.wednesday;  // ❌ FAILS

void main() {
  print(today);
}
```

**Error:** `RuntimeError: Cannot call method 'wednesday' on null.`

#### Where is the Problem?

- **Location:** `lib/src/interpreter_visitor.dart` → `visitPrefixedIdentifier` or const evaluation
- **Root Cause:** When evaluating top-level const initializers, enum types are not yet fully resolved

#### Potential Fix Strategies

1. **Strategy A: Ensure enums are resolved before const evaluation**
   - Register enum types and their values early in the compilation phase
   - Const evaluator should have access to enum values
   - Complexity: Low - order of initialization issue

2. **Strategy B: Lazy const evaluation**
   - Defer const evaluation until first access
   - By that time, all enums should be registered
   - Complexity: Medium

---

### Bug-15: base64Encode Function Not Exported from dart:convert

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

The top-level `base64Encode()` function from `dart:convert` is not available.

```dart
import 'dart:convert';

void main() {
  var result = base64Encode([1, 2, 3]);  // ❌ FAILS
  print(result);
}
```

**Error:** `Undefined function 'base64Encode'.`

#### Where is the Problem?

- **Location:** `lib/src/bridges/dart_convert/dart_convert_bridge.dart`
- **Root Cause:** Only the `base64` codec was bridged, not the convenience functions

#### Potential Fix Strategies

1. **Strategy A: Add convenience functions to dart:convert bridge**
   - Register `base64Encode`, `base64Decode`, `base64UrlEncode` as top-level functions
   - These are simple wrappers: `base64Encode(bytes) => base64.encode(bytes)`
   - Complexity: Low - straightforward function addition

---

### Bug-26: Assert in Constructor Initializer Not Supported

**Status:** 🔍 Confirm Fix  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Assert statements in constructor initializer lists are not supported.

```dart
class PositiveNumber {
  final int value;
  
  PositiveNumber(this.value) : assert(value > 0);  // ❌ FAILS
}

void main() {
  var n = PositiveNumber(5);
  print(n.value);
}
```

**Error:** `Bad state: Unsupported constructor initializer: AssertInitializer`

#### Where is the Problem?

- **Location:** `lib/src/interpreter_visitor.dart` → constructor initializer handling
- **Root Cause:** `AssertInitializer` AST node type is not handled in the initializer list processing

#### Potential Fix Strategies

1. **Strategy A: Handle AssertInitializer in constructor processing**
   - Add case for `AssertInitializer` in initializer list visitor
   - Evaluate the assert condition
   - Throw if condition is false (similar to regular assert handling)
   - Complexity: Medium - need to integrate with existing assert logic

---

### Bug-45: Labeled continue in sync* Generators Fails

**Status:** ⚠️ Broken  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Using labeled `continue` statements in `sync*` generators returns an empty list instead of the expected values.

```dart
Iterable<int> gen() sync* {
  outer:
  for (var i = 0; i < 3; i++) {
    if (i == 1) continue outer;
    yield i;
  }
}

void main() {
  print(gen().toList());  // Expected: [0, 2], Got: []
}
```

**Note:** This was previously marked as fixed, but testing shows it returns an empty list rather than the expected `[0, 2]`.

#### Where is the Problem?

- **Location:** `lib/src/interpreter_visitor.dart` → sync* generator handling with labeled continue
- **Root Cause:** The labeled continue breaks out of the generator iteration entirely instead of just skipping to the next iteration

#### Potential Fix Strategies

1. **Strategy A: Fix labeled continue propagation in generators**
   - Ensure `continue` with label is caught at the correct loop level
   - Don't let it propagate beyond the target loop
   - Complexity: Medium - need to track label targets correctly

---

### Bug-47: Future.doWhile Type Cast Issues

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Using `Future.doWhile` fails with a type cast error when the callback returns a Future<bool>.

```dart
void main() async {
  var count = 0;
  await Future.doWhile(() async {
    count++;
    return count < 3;  // ❌ FAILS with type error
  });
  print('Count: $count');
}
```

**Error:** `type 'Future<bool>' is not a subtype of type 'FutureOr<bool>' in type cast`

#### Where is the Problem?

- **Location:** `lib/src/bridges/dart_async/future_bridge.dart` or async handling
- **Root Cause:** The `FutureOr<bool>` return type handling doesn't correctly unwrap `Future<bool>`

#### Potential Fix Strategies

1. **Strategy A: Improve FutureOr handling**
   - When a `FutureOr<T>` is expected, check if the value is a `Future<T>`
   - If so, await it before processing
   - Complexity: Medium

2. **Strategy B: Bridge Future.doWhile with special handling**
   - Override `Future.doWhile` in the bridge
   - Manually handle the async callback and await results
   - Complexity: Medium

---

### Bug-52: Implicit super() Fails When Superclass Has Constructors

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

When a subclass constructor doesn't explicitly call super(), and the superclass has a default constructor, D4rt fails to call it implicitly.

```dart
class Base {
  Base() {
    print('Base constructed');
  }
}

class Child extends Base {
  Child() {  // ❌ FAILS - should implicitly call super()
    print('Child constructed');
  }
}

void main() {
  var c = Child();
}
```

**Error:** `No super constructor call found for class 'Child'` or base constructor not called.

#### Where is the Problem?

- **Location:** `lib/src/interpreter_visitor.dart` → constructor invocation handling
- **Root Cause:** Missing automatic `super()` call insertion when not explicitly provided

#### Potential Fix Strategies

1. **Strategy A: Insert implicit super() call**
   - When processing a constructor without explicit `super()` call
   - Check if superclass has a default (no-args) constructor
   - Insert an implicit call to it at the start of initialization
   - Complexity: Low - straightforward addition

---

### Bug-53: NullAwareElement Feature Not Supported

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

The null-aware element syntax (`?element`) in list/set literals is not supported.

```dart
void main() {
  String? name;
  var list = [?name];  // ❌ FAILS - should be [] when name is null
  print(list);
}
```

**Error:** `Unexpected token '?'` or parser error.

#### Where is the Problem?

- **Location:** Parser configuration or AST handling for collection literals
- **Root Cause:** Dart 3.x null-aware element feature not enabled or not handled

#### Potential Fix Strategies

1. **Strategy A: Enable null-aware element language feature**
   - Update language version to Dart 3.x
   - Enable the `null-aware-elements` feature flag
   - Complexity: Low - configuration change

2. **Strategy B: Handle NullAwareElement in collection processing**
   - When visiting list/set literals, check for `NullAwareElement` nodes
   - If element is null, skip it; otherwise include it
   - Complexity: Low - simple null check

---

### Bug-55: Symbol Class Not Bridged

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

The `Symbol` class from dart:core is not bridged, causing `Type 'Symbol' not found` errors when trying to create symbols.

```dart
var s = Symbol('test');  // ❌ Type 'Symbol' not found
```

#### Where is the Problem?

- **Location:** `lib/src/stdlib/core/`
- **Root Cause:** No bridged class definition for `Symbol`

#### Potential Fix Strategies

1. **Strategy A: Add Symbol bridged class**
   - Create `symbol.dart` with Symbol constructor bridged
   - Register Symbol type in dart:core stdlib
   - Complexity: Low - simple bridged class

---

### Bug-56: Constructor with Positional Arguments (Fixed)

**Status:** ✅ Fixed  
**Complexity:** Medium

#### Problem Description

Classes with constructors using positional arguments failed when defined after their usage point in the file.

```dart
void main() {
  var p = Point(10, 20);  // ❌ Used to fail
}

class Point {
  final int x, y;
  Point(this.x, this.y);
}
```

#### Solution

Fixed by ensuring DeclarationVisitor runs a complete pass before InterpreterVisitor, allowing forward references to work correctly.

---

### Bug-57: Class with Operator Override and Constructor (Fixed)

**Status:** ✅ Fixed  
**Complexity:** Medium

#### Problem Description

Classes with both operator overrides (like `==`) and constructors failed when defined at the bottom of the file.

```dart
void main() {
  var p1 = Point(1, 2);
  var p2 = Point(1, 2);
  print(p1 == p2);  // ❌ Used to fail
}

class Point {
  final int x, y;
  Point(this.x, this.y);
  @override
  bool operator ==(Object other) => other is Point && other.x == x && other.y == y;
}
```

#### Solution

Fixed together with Bug-56 - proper two-pass declaration/interpretation ordering.

---

### Bug-58: Functions/Classes at End of File (Fixed)

**Status:** ✅ Fixed  
**Complexity:** Medium

#### Problem Description

Helper functions and classes defined at the end of a file were not accessible from main().

#### Solution

Fixed together with Bug-56/57 - complete DeclarationVisitor pass before execution.

---

### Bug-59: Imported Classes Have Empty Constructor Maps

**Status:** ✅ Fixed  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

When a class is defined in an imported file, calling its constructor fails with "Class does not have an unnamed constructor that accepts arguments" even when the constructor is properly defined.

```dart
// In file a.dart:
import 'b.dart';
void main() {
  var p = Point(1, 2);  // ❌ Error: Class 'Point' does not have...
}

// In file b.dart:
class Point {
  final int x, y;
  Point(this.x, this.y);  // Constructor exists but not recognized!
}
```

#### Where is the Problem?

- **Location:** `lib/src/module_loader.dart` in `loadModule()`
- **Root Cause:** ModuleLoader was only visiting `TopLevelVariableDeclaration` and `EnumDeclaration` with InterpreterVisitor, not `ClassDeclaration`. The DeclarationVisitor creates placeholder classes with empty constructor maps, but the actual members (methods, constructors, operators) are populated by InterpreterVisitor.visitClassDeclaration.

#### Solution

Added `ClassDeclaration`, `MixinDeclaration`, and `FunctionDeclaration` processing in `ModuleLoader.loadModule()`:

```dart
// Process class and mixin declarations to populate their members
for (final declaration in ast.declarations) {
  if (declaration is ClassDeclaration || declaration is MixinDeclaration) {
    declaration.accept(moduleInterpreter);
  }
}

// Process function declarations
for (final declaration in ast.declarations) {
  if (declaration is FunctionDeclaration) {
    declaration.accept(moduleInterpreter);
  }
}
```

---

### Bug-60: Null-Safe Indexing on Null Throws Unclear Error

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Using null-aware indexing `list?[0]` on a null value throws an unclear error instead of returning null.

```dart
int? main() {
  List<int>? list = null;
  return list?[0];  // ❌ FAILS with "Unsupported target for indexing: null"
}
```

**Expected:** Should return `null`  
**Error:** `Unsupported target for indexing: null`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` → `visitIndexExpression()`
- **Root Cause:** The null-aware operator `?` is not being properly handled before attempting the index operation

---

### Bug-61: if-case Pattern Evaluates Pattern as Condition

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

if-case with pattern matching evaluates the pattern as the condition instead of performing pattern matching.

```dart
String main() {
  String s = 'hello';
  if (s case String x) {  // ❌ FAILS - treats "s" as boolean condition
    return 'matched: $x';
  }
  return 'no match';
}
```

**Error:** `The condition of an 'if' must be a boolean, but was String.`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` → `visitIfStatement()`
- **Root Cause:** The visitor checks if `caseClause` exists but still evaluates the condition as a boolean

---

### Bug-62: GenericFunctionType in Generic Type Arguments Fails

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

When a function type is used as a type argument to a generic type (like `List<int Function(int)>`), type resolution fails.

```dart
int Function(int) compose(List<int Function(int)> functions) {  // ❌ FAILS
  return (value) {
    for (var f in functions) {
      value = f(value);
    }
    return value;
  };
}
```

**Error:** `Type resolution for GenericFunctionTypeImpl not implemented yet.`

**Note:** Simple function types as parameters work fine (`int Function(int) f`). The issue is specifically when function types appear inside generic type arguments.

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` → `_resolveTypeAnnotation()`
- **Root Cause:** `GenericFunctionTypeImpl` handling exists but doesn't work when nested inside `NamedType` type arguments

---

### Bug-63: Abstract Method from Interface (Fixed)

**Status:** ✅ Fixed  
**Complexity:** Medium

#### Problem Description

Classes implementing interfaces with abstract methods were incorrectly flagged as missing implementations.

```dart
abstract class Robot {
  void move();
}
class AdvancedRobot implements Robot {
  @override
  void move() => print('Moving');  // ❌ Used to report "Missing abstract method 'move'"
}
```

#### Solution

Fixed by improving the abstract method inheritance checking to properly recognize implementations.

---

### Bug-64: Interface Class Same-Library Extension Rejected

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Classes extending interface classes in the same library are incorrectly rejected.

```dart
interface class DataSource {
  void load() {}
}
class JsonDataSource extends DataSource {  // ❌ FAILS
  @override
  void load() => print('Loading JSON');
}
```

**Error:** `Class 'JsonDataSource' cannot extend interface class 'DataSource'. Use 'implements'.`

**Note:** In Dart, interface classes can be extended within the same library but only implemented from other libraries.

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` → `visitClassDeclaration()`
- **Root Cause:** The check for interface class extension doesn't verify if both classes are in the same library

---

### Bug-65: Map.from Constructor Not Bridged

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

The `Map.from()` constructor is not registered in the Map bridge.

```dart
void main() {
  var original = {'a': 1, 'b': 2};
  var copy = Map.from(original);  // ❌ FAILS
}
```

**Error:** `Bridged class 'Map' does not have a registered constructor named 'from'.`

#### Solution Strategy

Add `Map.from` constructor to the Map bridge in `bridges/map_bridge.dart`.

---

### Bug-66: Record Pattern with Named Field (Fixed)

**Status:** ✅ Fixed  
**Complexity:** Medium

#### Problem Description

Record patterns with named fields in destructuring were failing with null lexeme errors.

```dart
String main() {
  var record = (name: 'Alice', age: 30);
  var (name: n, age: a) = record;  // ❌ Used to fail with "Named field lexeme is null"
  return '$n is $a years old';
}
```

#### Solution

Fixed by improving named field pattern handling in record destructuring.

---

### Bug-67: if-case with Int Pattern Wrong Condition Type

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

Same root cause as Bug-61 - the if-case pattern handling evaluates the expression as a boolean condition.

```dart
String main() {
  var value = 42;
  if (value case int x when x > 0) {  // ❌ FAILS
    return 'positive: $x';
  }
  return 'not positive';
}
```

**Error:** `The condition of an 'if' must be a boolean, but was int.`

---

### Bug-69: Abstract Getter from Mixin (Fixed)

**Status:** ✅ Fixed  
**Complexity:** Medium

#### Problem Description

Classes mixing in mixins with abstract getters were incorrectly flagged as missing implementations.

```dart
mixin Named {
  String get name;
}
class Bird with Named {
  @override
  String get name => 'Tweety';  // ❌ Used to report "Missing abstract getter 'name'"
}
```

#### Solution

Fixed by improving abstract member inheritance checking to properly recognize mixin implementations.

---

### Bug-70: await on Future.value (Fixed)

**Status:** ✅ Fixed  
**Complexity:** Medium

#### Problem Description

Awaiting `Future.value()` resulted in type errors because the bridged Future wasn't properly unwrapped.

```dart
Future<String> main() async {
  var result = await Future.value('hello');  // ❌ Used to fail
  return result;
}
```

**Error:** `await must be used on a Future, got BridgedInstance.`

#### Solution

Fixed by improving Future unwrapping in await expression handling.

---

### Bug-71: Error Class Not Bridged (Undefined Variable)

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

The `Error` class is not accessible as a type for instantiation.

```dart
bool main() {
  var e = Error();  // ❌ FAILS - "Undefined variable: Error"
  return e is Error;
}
```

**Note:** `Error` works in catch clauses (Bug-22 was fixed) but not for direct instantiation.

#### Solution Strategy

Add `Error` to the environment as an accessible type, similar to how `Exception` is handled.

---

## Best Practices

1. **Test in D4rt**: Always test scripts in D4rt to catch interpreter-specific issues
2. **Use helper functions for bridged types**: Extensions on bridged instances don't work - use regular functions
3. **Use explicit comparators**: Don't rely on `Comparable` interface for sorting
4. **Avoid infinite generators**: Design generators with explicit limits
5. **Assign async results before interpolation**: Avoid `await` inside string interpolation
6. **Extensions work for interpreted types**: Methods, getters, operators, nullable, and enum extensions all work

---

## Related Documentation

- [Limitation and Bug Analysis](limitation_and_bug_analysis.md) - Deep-dive analysis with fix strategies
- [Limitation and Bug TODOs](limitation_and_bug_todos.md) - Implementation tracking
- [Advanced Features Support](advanced_features_support.md) - Feature testing results
