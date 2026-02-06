# D4rt Interpreter Limitations and Bugs

This document provides a comprehensive reference of all known D4rt interpreter limitations and bugs, their current status, fixability assessment, and solution strategies.

**Last Updated:** 2026-02-07

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
| Bug-55 | [Symbol class not bridged](#bug-55-symbol-class-not-bridged) | Low | ✅ Fixed |
| Bug-65 | [Map.from constructor not bridged](#bug-65-mapfrom-constructor-not-bridged) | Low | ✅ Fixed |
| Bug-71 | [Error class not bridged (undefined variable)](#bug-71-error-class-not-bridged) | Low | ✅ Fixed |
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
| Bug-60 | [Null-safe indexing on null throws unclear error](#bug-60-null-safe-indexing) | Medium | ✅ Fixed |
| Bug-61 | [if-case pattern evaluates pattern as condition](#bug-61-if-case-pattern) | Medium | ✅ Fixed |
| Bug-62 | [GenericFunctionType in generic type args fails](#bug-62-genericfunctiontype-in-generics) | Medium | ✅ Fixed |
| Bug-64 | [Interface class same-library extension rejected](#bug-64-interface-class-extension) | Medium | ✅ Fixed |
| Bug-67 | [if-case with int pattern wrong condition type](#bug-67-if-case-int-pattern) | Medium | ✅ Fixed |
| Bug-45 | [Labeled continue in sync* generators fails](#bug-45-labeled-continue-in-sync-generators-fails) | Medium | ✅ Fixed |
| Bug-47 | [Future.doWhile type cast issues](#bug-47-futuredowhile-type-cast-issues) | Medium | ✅ Fixed |
| Bug-72 | [Bridged mixins not found during class declaration](#bug-72-bridged-mixins-class-declaration) — `bridged_mixin_test` (5) + `complex_bridged_mixin_test` (5) | Medium | ✅ Fixed |
| Bug-73, Bug-74 | [Async nested loops/return type error with anonymous name](#bug-73-async-nested-loops-return-type) — `async_nested_loops_test` (20 tests) | Medium | ✅ Fixed |
| Bug-75 | [Division by zero returns Infinity instead of throwing](#bug-75-division-by-zero-returns-infinity) — `eval_method_test: should handle division by zero` | Low | ✅ Fixed |
| Bug-76 | [Introspection API returns globals for empty source](#bug-76-introspection-empty-source) — `introspection_api_test: empty source, imports only` (2) | Low | ✅ Fixed |
| Bug-77 | [File.parent test flaky in full test suite](#bug-77-file-parent-flaky) — `file_test: comprehensive parent` (1) | Low | ✅ Fixed |
| Bug-78 | [noSuchMethod not invoked for method calls](#bug-78-nosuchmethod-method-calls) — `limitations_and_bugs_test: Lim-7` (1) | Medium | ✅ Fixed |
| Bug-79 | [Switch expression not exhaustive for sealed subclass](#bug-79-switch-expression-not-exhaustive-for-sealed-subclass) — `dart_overview_bugs_test: Bug-79` | Medium | ⬜ TODO |
| Bug-80 | [Cascade on property access fails](#bug-80-cascade-on-property-access-fails) — `dart_overview_bugs_test: Bug-80` | Medium | ⬜ TODO |
| Bug-81 | [Pattern with when guard fails (LogicalAndPatternImpl)](#bug-81-pattern-with-when-guard-fails) — `dart_overview_bugs_test: Bug-81` | Medium | ⬜ TODO |
| Bug-82 | [Function.call method not found](#bug-82-function-call-method-not-found) — `dart_overview_bugs_test: Bug-82` | Medium | ⬜ TODO |
| Bug-83 | [Nullable function?.call() fails](#bug-83-nullable-function-call-fails) — `dart_overview_bugs_test: Bug-83` | Medium | ⬜ TODO |
| Bug-84 | [Mixin abstract method satisfaction false positive](#bug-84-mixin-abstract-method-satisfaction-false-positive) — `dart_overview_bugs_test: Bug-84` | Medium | ⬜ TODO |
| Bug-85 | [Cannot extend abstract final class in same library](#bug-85-cannot-extend-abstract-final-class-in-same-library) — `dart_overview_bugs_test: Bug-85` | Low | ⬜ TODO |
| Bug-86 | [runtimeType not accessible via PrefixedIdentifier](#bug-86-runtimetype-not-accessible-via-prefixedidentifier) — `dart_overview_bugs_test: Bug-86` | Medium | ⬜ TODO |
| Bug-87 | [Map for-in comprehension fails with MapLiteralEntry error](#bug-87-map-for-in-comprehension-fails-with-mapliteralentry-error) — `dart_overview_bugs_test: Bug-87` | Medium | ⬜ TODO |
| Bug-88 | [Record pattern with :name shorthand fails](#bug-88-record-pattern-with-name-shorthand-fails) — `dart_overview_bugs_test: Bug-88` | Medium | ⬜ TODO |
| Bug-89 | [Enum.values.byName (List.byName) not bridged](#bug-89-enumvaluesbyname-listbyname-not-bridged) — `dart_overview_bugs_test: Bug-89` | Low | ⬜ TODO |
| Bug-90 | [Mixin on constraint abstract getter false positive](#bug-90-mixin-on-constraint-abstract-getter-false-positive) — `dart_overview_bugs_test: Bug-90` | Medium | ⬜ TODO |
| Bug-91 | [Imported extensions on bridged types fail](#bug-91-imported-extensions-on-bridged-types-fail) — `dart_overview_bugs_test: Bug-91` | Medium | ✅ Fixed |
| Bug-92 | [Future factory constructor returns BridgedInstance&lt;Object&gt;](#bug-92-future-factory-constructor-returns-bridgedinstanceobject) — `dart_overview_bugs_test: Bug-92` | Medium | ✅ Fixed |
| Bug-93 | [Int not implicitly promoted to double return type](#bug-93-int-not-implicitly-promoted-to-double-return-type) — `dart_overview_bugs_test: Bug-93` | Low | ⬜ TODO |
| Bug-94 | [Cascade index assignment on property fails](#bug-94-cascade-index-assignment-on-property-fails) — `dart_overview_bugs_test: Bug-94` | Medium | ⬜ TODO |
| Bug-95 | [List.forEach with native function tear-off fails](#bug-95-listforeach-with-native-function-tear-off-fails) — `dart_overview_bugs_test: Bug-95` | Medium | ⬜ TODO |
| Bug-96 | [super.name constructor parameter forwarding fails](#bug-96-supername-constructor-parameter-forwarding-fails) — `dart_overview_bugs_test: Bug-96` | Medium | ⬜ TODO |
| Bug-97 | [num not recognized as satisfying Comparable bound](#bug-97-num-not-recognized-as-satisfying-comparable-bound) — `dart_overview_bugs_test: Bug-97` | Low | ⬜ TODO |
| Bug-98 | [Extension getter on bridged List not resolved](#bug-98-extension-getter-on-bridged-list-not-resolved) — `dart_overview_bugs_test: Bug-98` | Medium | ⬜ TODO |
| Bug-99 | [Stream.handleError callback receives wrong argument count](#bug-99-streamhandleerror-callback-receives-wrong-argument-count) — `dart_overview_bugs_test: Bug-99` | Low | ⬜ TODO |
| Lim-1 | [Extension types (Dart 3.3+ inline classes)](#lim-1-extension-types-dart-33) | High | ✅ Fixed |
| Lim-4, Bug-43 | [Infinite sync* generators hang (eager evaluation)](#lim-4-bug-43-infinite-sync-generators-hang) | High | ✅ Fixed |
| Lim-8, Bug-13, Bug-68 | [Logical OR patterns in switch cases](#lim-8-bug-13-logicalorpattern-in-switch) | High | ✅ Fixed |
| Bug-14 | [Records with named fields or >9 positional fields return InterpretedRecord](#bug-14-records-with-named-fields-or-9-positional-fields) — `limitations_and_bugs_test: Bug-14` (2) | High | 🚫 Won't Fix |
| Lim-3 | [Isolate execution with interpreted code](#lim-3-isolate-execution-with-interpreted-code) — `limitations_and_bugs_test: Lim-3` (1) | Fundamental | 🚫 Won't Fix |

**Status Legend:**
- ⬜ TODO - Not yet fixed
- ✅ Fixed - Confirmed working
- 🚫 Won't Fix - Fundamental limitation or too complex

---

## Detailed Descriptions

---

### Lim-1: Extension Types (Dart 3.3+)

**Status:** ✅ Fixed  
**Fixed:** 2026-02-05  
**Complexity:** High

#### Problem Description

Extension types (introduced in Dart 3.3) are inline class wrappers that provide zero-cost abstraction at compile time.

```dart
extension type UserId(int value) {
  bool get isValid => value > 0;
}

void main() {
  var id = UserId(42);
  print(id.value);    // ✅ Works
  print(id.isValid);  // ✅ Works
}
```

#### Solution

Fixed in 2026-02-05:
1. Added `visitExtensionTypeDeclaration` method to `InterpreterVisitor`
2. Created `InterpretedExtensionType` class in `runtime_types.dart`
3. Created `InterpretedExtensionTypeInstance` class for instance wrapping
4. Handle representation field access and member methods

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

**Status:** ✅ Fixed  
**Fixed:** 2026-02-05  
**Complexity:** High

#### Problem Description

Sync* generators that yield infinitely now work correctly with lazy evaluation.

```dart
Iterable<int> naturals() sync* {
  int n = 0;
  while (true) {
    yield n++;
  }
}

void main() {
  print(naturals().take(5).toList());  // ✅ Works - returns [0, 1, 2, 3, 4]
}
```

#### Solution

Fixed in 2026-02-05:
1. Created `_SyncGeneratorIterable` class that returns `_LazySyncGeneratorIterator`
2. `_LazySyncGeneratorIterator` uses native Dart `sync*` to produce values lazily
3. Added `SyncGeneratorYieldSuspension` exception to pause execution at yield points
4. Added `isLazySyncGeneratorContext` flag to `InterpreterVisitor`
5. Special handling for `WhileStatement`, `ForStatement`, and `Block` in lazy execution context
6. `_executeBlockWithYieldSuspension` and related methods handle control flow lazily

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

**Status:** ✅ Fixed  
**Fixed:** 2026-02-05  
**Complexity:** High

#### Problem Description

Logical OR patterns (`||`) in switch cases now work correctly.

```dart
switch (day) {
  case Day.saturday || Day.sunday:  // ✅ Works
    print('Weekend');
}

// Switch expression also works:
var result = switch (day) {
  'Saturday' || 'Sunday' => 'Weekend',
  _ => 'Weekday',
};
```

#### Solution

Fixed in 2026-02-05:
1. Added `LogicalOrPattern` handling to `_matchAndBind` method in `interpreter_visitor.dart`
2. When matching, tries left pattern first; if it fails, tries right pattern
3. Collects bindings from whichever pattern matches

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

**Status:** 🚫 Won't Fix  
**Fixable:** ❌ No - Dart language limitation  
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

#### Why Won't Fix

Dart does not support creating record types dynamically at runtime. Records are compile-time constructs with their types determined by the compiler. There is no way to programmatically construct a native record with named fields or arbitrary arity without hardcoding every possible combination.

This is a fundamental language limitation that cannot be worked around in an interpreter.

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

**Status:** ✅ Fixed  
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

### Bug-72: Bridged Mixins Not Found During Class Declaration

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

When using bridged mixins in interpreted classes, the mixin lookup fails during class declaration. The error occurs even when the bridged mixin is properly defined and registered.

```dart
// Bridged mixin (defined in Dart)
mixin EventMixin {
  void emit(String event) => print('Event: $event');
}

// Interpreted code
class DataProcessor with EventMixin {  // ❌ FAILS
  void process() => emit('processing');
}
```

**Error:** `Mixin 'EventMixin' not found during lookup for class 'DataProcessor'. Ensure it's defined (as a mixin or class mixin).`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` line 5987 - `visitClassDeclaration`
- **Root Cause:** The mixin lookup during class declaration doesn't properly search bridged class definitions that are marked as mixins

#### Affected Tests

- `bridged_mixin_test.dart` - 5 tests
- `complex_bridged_mixin_test.dart` - 5 tests

#### Solution Strategy

Improve mixin lookup in `visitClassDeclaration` to also search bridged classes that have `isMixin: true`.

---

### Bug-73: Async Nested Loops Fail with Return Type Error

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Async code inside nested loops incorrectly triggers a return type checking error, treating the async callback's return as if it were returning from a void function.

```dart
Future<int> main() async {
  var result = 0;
  for (var i = 0; i < 3; i++) {
    for (var j = 0; j < 3; j++) {
      await Future.delayed(Duration(milliseconds: 1));  // ❌ FAILS
      result += i * j;
    }
  }
  return result;
}
```

**Error:** `A value of type 'Future' can't be returned from the function '<anonymous>' because it has a return type of 'void'.`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` line 4836 - `visitReturnStatement`
- **Root Cause:** The async state machine incorrectly identifies the return type context when executing inside nested loops

#### Affected Tests

- `async_nested_loops_test.dart` - 11 tests covering various nested loop patterns

#### Solution Strategy

Review the async state machine's handling of return types when inside nested loop constructs. The `currentFunction` context may be lost or incorrect.

---

### Bug-74: Return Type Error Shows Anonymous Instead of Function Name

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

When a return type mismatch error occurs, the error message shows `<anonymous>` instead of the actual function name.

```dart
int getNumber() {
  return 'hello';  // ❌ Type error
}
```

**Expected Error:** `A value of type 'String' can't be returned from the function 'getNumber' because it has a return type of 'int'.`

**Actual Error:** `A value of type 'String' can't be returned from the function '<anonymous>' because it has a return type of 'int'.`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` - return type checking logic
- **Root Cause:** The function name resolution in the error message construction uses `<anonymous>` as a fallback when the function declaration context is not properly tracked

#### Affected Tests

- `interpreter_test.dart` - 7 "Return Type Checking Tests"

#### Solution Strategy

Ensure the function name is properly extracted from the current function context (`currentFunction`) when generating the error message.

---

### Bug-75: Division by Zero Returns Infinity Instead of Throwing

**Status:** ⬜ TODO  
**Fixable:** ⚠️ Deliberate behavior  
**Complexity:** Low

#### Problem Description

Division by zero returns `Infinity` instead of throwing an exception, which matches Dart's native behavior but differs from some test expectations.

```dart
void main() {
  var result = 1 / 0;  // Returns Infinity (not an error)
  print(result);  // Prints: Infinity
}
```

#### Note

This is actually **correct Dart behavior**. In Dart, integer and double division by zero returns `Infinity` (or `-Infinity` for negative numerators), not an exception. The test expectation may be incorrect.

#### Affected Tests

- `eval_method_test.dart` - "Error handling should handle division by zero"

#### Solution Strategy

Review whether the test expectation is correct. Dart's behavior:
- `1 / 0` → `Infinity`
- `1 ~/ 0` → throws `IntegerDivisionByZeroException`

The test may need to be updated rather than the interpreter.

---

### Bug-76: Introspection API Returns Globals for Empty Source

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

When analyzing empty source code or source with only imports, the introspection API incorrectly includes global functions (like `identical`) in the results.

```dart
// Empty source
var result = d4rt.analyze('');
print(result.all);  // ❌ Returns [VariableInfo:var identical: NativeFunction]
```

**Expected:** Empty list for empty source
**Actual:** List containing global definitions

#### Where is the Problem?

- **Location:** Introspection API implementation
- **Root Cause:** The analysis doesn't filter out pre-defined globals from the result

#### Affected Tests

- `introspection_api_test.dart` - "should handle empty source"
- `introspection_api_test.dart` - "should handle source with imports only"

#### Solution Strategy

Filter the analysis results to exclude pre-defined global symbols when returning user-defined declarations.

---

### Bug-77: File.parent Test Flaky in Full Test Suite

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

The File.parent test in `file_test.dart` fails intermittently when running the full test suite but passes when run individually. This suggests a race condition or test isolation issue.

```dart
// Test: File methods - comprehensive parent
void main() {
  var file = File('/path/to/file.txt');
  var parent = file.parent;  // Sometimes fails in full suite
}
```

#### Where is the Problem?

- **Location:** Test isolation or File bridge implementation
- **Root Cause:** Possible state leakage between tests or resource contention when running in parallel

#### Affected Tests

- `stdlib/io/file_test.dart` - "File methods - comprehensive parent" (flaky)

#### Solution Strategy

1. Investigate test isolation - ensure each test has clean state
2. Check for shared mutable state in File bridge
3. Consider adding proper cleanup in test teardown

---

### Bug-78: noSuchMethod Not Invoked for Method Calls

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

When calling a non-existent method on an object that implements `noSuchMethod`, the interpreter throws an error instead of invoking `noSuchMethod`.

```dart
class Dynamic {
  @override
  dynamic noSuchMethod(Invocation invocation) {
    return 'intercepted: ${invocation.memberName}';
  }
}

void main() {
  var d = Dynamic();
  print(d.anyMethod());  // ❌ FAILS - should call noSuchMethod
}
```

**Error:** `Instance of 'Dynamic' has no method named 'anyMethod'.`

**Note:** This is different from Bug-42 (noSuchMethod for getter/setter) which is fixed. This bug is specifically about method calls.

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` - `visitMethodInvocation`
- **Root Cause:** Method lookup doesn't fall back to `noSuchMethod` when the method is not found

#### Affected Tests

- `limitations_and_bugs_test.dart` - "Lim-7: noSuchMethod for methods should work"

#### Solution Strategy

When a method is not found on an InterpretedInstance, check if the class implements `noSuchMethod` and call it with an appropriate `Invocation` object.

---

### Bug-79: Switch Expression Not Exhaustive for Sealed Subclass

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

When using a switch expression with object pattern destructuring on sealed class subclasses, the interpreter incorrectly reports the switch as not exhaustive.

```dart
sealed class Shape {}
class Circle extends Shape {
  final double radius;
  Circle(this.radius);
}
class Square extends Shape {
  final double side;
  Square(this.side);
}

double calculateArea(Shape shape) {
  return switch (shape) {
    Circle(:var radius) => 3.14159 * radius * radius,
    Square(:var side) => side * side,
  };
}

void main() {
  var circle = Circle(5.0);
  print(calculateArea(circle));  // ❌ FAILS
}
```

**Error:** `Switch expression was not exhaustive for value: <instance of Circle> (InterpretedInstance)`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` - `visitSwitchExpression`
- **Root Cause:** Pattern matching with object destructuring patterns on sealed class instances isn't matching correctly

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-79: Switch expression should match sealed subclass"

#### Solution Strategy

Fix the object pattern matching logic to correctly match InterpretedInstance against declared class types with field destructuring.

---

### Bug-80: Cascade on Property Access Fails

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Cascade operators (`..`) that access a property and then call a method on that property fail to resolve the method.

```dart
class Team {
  String name = '';
  List<String> members = [];
}

void main() {
  var team = Team()
    ..name = 'Engineering'
    ..members.add('Alice')  // ❌ FAILS
    ..members.add('Bob');
  print(team.members);
}
```

**Error:** `Undefined property 'add' on Team.`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` - `_executeCascadeMethodInvocation`
- **Root Cause:** The cascade is looking for `add` on the Team class instead of on the `members` property

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-80: Cascade should work on property access"

#### Solution Strategy

When processing cascade method invocations, correctly resolve the target when the cascade target is a property access (e.g., `..members.add` should look up `add` on the result of `members`).

---

### Bug-81: Pattern with When Guard Fails

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Using when guards with patterns in switch cases fails with "LogicalAndPatternImpl not supported".

```dart
void main() {
  var person = (name: 'Charlie', age: 25);
  var result = switch (person) {
    (name: var n, age: var a) when a >= 18 => 'Adult: $n',
    _ => 'Minor',
  };
  print(result);  // ❌ Should print "Adult: Charlie" but returns "Minor"
}
```

**Error:** Returns wrong result - pattern with when guard doesn't match correctly.

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` - pattern matching logic
- **Root Cause:** LogicalAndPatternImpl (pattern && condition) handling issues

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-81: Pattern with when guard should work"

#### Solution Strategy

Implement proper when guard evaluation in pattern matching.

---

### Bug-82: Function.call Method Not Found

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Calling `.call()` explicitly on an interpreted function fails.

```dart
void main() {
  var fn = (int x) => x * 2;
  print(fn.call(5));  // ❌ FAILS - should print 10
}
```

**Error:** `Undefined property or method 'call' on InterpretedFunction.`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` - `visitMethodInvocation`
- **Root Cause:** InterpretedFunction doesn't expose a `call` method, even though all Dart functions have an implicit `call` method

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-82: Function.call() should work on interpreted functions"

#### Solution Strategy

When looking up method `call` on an InterpretedFunction, invoke the function directly with the provided arguments.

---

### Bug-83: Nullable Function?.call() Fails

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Calling `?.call()` on a nullable function type fails.

```dart
void main() {
  void Function()? onClick = () => print('Clicked');
  onClick?.call();  // ❌ FAILS
}
```

**Error:** `Undefined property or method 'call' on InterpretedFunction.`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` - `visitMethodInvocation` 
- **Root Cause:** Same as Bug-82 - null-aware variant also fails

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-83: Nullable function?.call() should work"

#### Solution Strategy

Same fix as Bug-82, with proper null-aware handling.

---

### Bug-84: Mixin Abstract Method Satisfaction False Positive

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

When a mixin provides an override for an abstract method from its superclass constraint, the interpreter incorrectly reports the concrete class as missing the implementation.

```dart
abstract class Movable {
  void move();
}

mixin CanWalk on Movable {
  @override
  void move() => print('Walking');  // ✅ Provides implementation
}

class Robot extends Movable with CanWalk {}  // ❌ FAILS

void main() {
  var robot = Robot();
  robot.move();
}
```

**Error:** `Missing concrete implementation for inherited abstract method 'move' in class 'Robot'.`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` - `visitClassDeclaration`
- **Root Cause:** Abstract method checking doesn't account for implementations provided by mixins that override constraint methods

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-84: Mixin should satisfy abstract method from superclass"

#### Solution Strategy

When checking for missing abstract method implementations, include methods provided by mixins (with `@override`) in the list of available implementations.

---

### Bug-85: Cannot Extend Abstract Final Class in Same Library

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

The `abstract final` class modifier combination should allow the class to be extended only within the same library. The interpreter incorrectly blocks this.

```dart
abstract final class AbstractFinalClass {
  void doSomething();
}

class ConcreteImpl extends AbstractFinalClass {  // ❌ FAILS
  @override
  void doSomething() => print('Done');
}

void main() {
  var impl = ConcreteImpl();
  impl.doSomething();
}
```

**Error:** `Class 'ConcreteImpl' cannot extend final class 'AbstractFinalClass'.`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` - `visitClassDeclaration`
- **Root Cause:** The check for `final` modifier doesn't account for `abstract final` combination which allows same-library extension

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-85: Should extend abstract final class in same library"

#### Solution Strategy

When checking class modifier restrictions, allow extending `abstract final` classes within the same library.

---

### Bug-86: runtimeType Not Accessible via PrefixedIdentifier

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Accessing `runtimeType` on an interpreted instance in string interpolation fails.

```dart
class Wrapper<T> {
  final T value;
  Wrapper(this.value);
}

void main() {
  var w = Wrapper<int>(42);
  print('Type: ${w.runtimeType}');  // ❌ FAILS
}
```

**Error:** `Undefined property 'runtimeType' on Wrapper. (accessing property via PrefixedIdentifier 'runtimeType')`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` - `visitPrefixedIdentifier`
- **Root Cause:** The `runtimeType` property (inherited from Object) isn't being resolved for InterpretedInstances in prefixed identifier context

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-86: runtimeType should be accessible on generic instance"

#### Solution Strategy

Add special handling for `runtimeType` in visitPrefixedIdentifier to return the runtime type of InterpretedInstances.

---

### Bug-87: Map For-In Comprehension Fails with MapLiteralEntry Error

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Using a for-in loop to create map entries in a map literal comprehension fails.

```dart
void main() {
  var items = ['a', 'b', 'c'];
  var indexed = {for (var i = 0; i < items.length; i++) i: items[i]};
  print(indexed);  // ❌ FAILS
}
```

**Error:** `Unexpected MapLiteralEntry ('key: value') in a non-map literal. (in Set literal)`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` - `visitSetOrMapLiteral`
- **Root Cause:** The literal type detection is incorrectly identifying the collection as a Set instead of a Map when using for-in with MapLiteralEntry elements

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-87: Map for-in comprehension should work"

#### Solution Strategy

Improve the Set/Map literal type detection to consider MapLiteralEntry elements generated from for-in expressions.

---

### Bug-88: Record Pattern with :name Shorthand Fails

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Using the `:name` shorthand in record patterns fails with a null lexeme error.

```dart
void main() {
  var point = (x: 10, y: 20);
  var (:x, :y) = point;  // ❌ FAILS
  print('x=$x, y=$y');
}
```

**Error:** `Error during pattern binding: State Error: Internal error: Named field detected but name lexeme is null.`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` - pattern binding logic
- **Root Cause:** The `:name` shorthand pattern doesn't extract the name lexeme correctly

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-88: Record pattern with :name shorthand should work"

#### Solution Strategy

Handle the shorthand pattern syntax where `:name` means both the pattern variable name and the field name.

---

### Bug-89: Enum.values.byName (List.byName) Not Bridged

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

The `byName` method on enum values list (which is a List extension) is not available.

```dart
enum Color { red, green, blue }

void main() {
  var color = Color.values.byName('green');  // ❌ FAILS
  print(color.name);
}
```

**Error:** `Bridged class 'List' has no instance method named 'byName'. Error during extension lookup: Bridged class 'List' has no instance method named 'byName'.`

#### Where is the Problem?

- **Location:** `dart_core_bridge.dart` - List bridge
- **Root Cause:** The `byName` extension method from `dart:core` on `List<T extends Enum>` isn't bridged

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-89: Enum.values.byName should find enum value"

#### Solution Strategy

Add the `byName` method to the List bridge for enum value lists, or implement the extension method lookup for bridged types.

---

### Bug-90: Mixin on Constraint Abstract Getter False Positive

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

When a class extends an abstract class and uses a mixin with an `on` constraint that declares an abstract getter, the interpreter incorrectly reports the getter as unimplemented even when the class provides the implementation.

```dart
abstract class Named {
  String get name;
}

mixin Greetable on Named {
  String greet() => 'Hello, $name';
}

class Person extends Named with Greetable {
  @override
  final String name;  // ✅ Provides implementation
  Person(this.name);
}

void main() {
  var p = Person('Alice');
  print(p.greet());  // ❌ FAILS
}
```

**Error:** `Missing concrete implementation for inherited abstract getter 'name' in class 'Person'.`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` - `visitClassDeclaration`
- **Root Cause:** The abstract member check looks at the mixin's `on` constraint and sees `name` as abstract, but doesn't recognize that Person provides the implementation

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-90: Mixin on constraint with getter should not require impl"

#### Solution Strategy

When checking for unimplemented abstract members, properly resolve which members the concrete class actually provides, including those inherited from mixins and those explicitly overridden.

---

### Bug-91: Imported Extensions on Bridged Types Fail

**Status:** ✅ Fixed  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Extensions on bridged types work when defined in the same file, but fail when imported from another file.

```dart
// string_ext.dart
extension StringExtension on String {
  String capitalize() => this[0].toUpperCase() + substring(1);
}

// main.dart
import 'string_ext.dart';

void main() {
  print('hello'.capitalize());  // ❌ FAILS when imported
}
```

**Error:** `Bridged class 'String' has no instance method named 'capitalize'. Error during extension lookup: Bridged class 'String' has no instance method named 'capitalize'.`

#### Where is the Problem?

- **Location:** `environment.dart` - extension lookup for bridged types
- **Root Cause:** Extension lookup doesn't search imported modules for extensions on bridged types

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-91: Imported extensions on bridged types should work"

#### Solution Strategy

Extend the extension lookup mechanism to search imported modules, not just the current file's scope.

---

### Bug-92: Future Factory Constructor Returns BridgedInstance&lt;Object&gt;

**Status:** ✅ Fixed  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Using `Future(() => ...)` factory constructor returns a `BridgedInstance<Object>` instead of a proper Future, causing await to fail.

```dart
void main() async {
  var computed = Future(() {
    return 'Computed value';
  });
  print(await computed);  // ❌ FAILS
}
```

**Error:** `The argument to 'await' must be a Future, but received type: BridgedInstance<Object>`

Note: `Future.value(42)` works correctly; it's specifically the `Future(() => ...)` factory constructor that fails.

#### Where is the Problem?

- **Location:** `dart_async_bridge.dart` - Future constructor bridging
- **Root Cause:** The `Future(() => ...)` factory constructor isn't properly bridged to return a Future type

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-92: await on Future factory constructor should work"

#### Solution Strategy

Bridge the `Future(() => computation)` factory constructor to properly return a Future that can be awaited.

---

### Bug-93: Int Not Implicitly Promoted to Double Return Type

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

When a function has a `double` return type and returns an `int` value, Dart should implicitly promote the int to double. D4rt rejects this with a type error.

```dart
double foo(int x) {
  return x;  // ❌ FAILS - should auto-promote int to double
}

void main() {
  print(foo(5));  // Should print 5.0
}
```

**Error:** `A value of type 'int' can't be returned from the function 'foo' because it has a return type of 'double'.`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` - `visitReturnStatement`
- **Root Cause:** The return type check doesn't handle the implicit int→double promotion that Dart performs automatically

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-93: Int should be implicitly promoted to double return type"

#### Solution Strategy

Add int→double promotion logic in `visitReturnStatement` when the declared return type is `double` and the actual value is `int`.

---

### Bug-94: Cascade Index Assignment on Property Fails

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Cascade expressions that use index assignment (`[]=`) on a property of the cascade target fail. The interpreter only checks if the cascade target itself is a List or Map, not the property being indexed.

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

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` - `_executeCascadeAssignment`
- **Root Cause:** The cascade assignment handler checks if the cascade target (Request) is a List/Map, but should look at the intermediate property (headers) which IS a Map

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-94: Cascade index assignment on property should work"

#### Solution Strategy

In `_executeCascadeAssignment`, when processing an index expression in a cascade, resolve the full property chain before checking if the target supports index assignment.

---

### Bug-95: List.forEach with Native Function Tear-off Fails

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Calling `forEach` on a bridged List with a native (non-interpreted) function tear-off like `print` fails. The bridge expects an `InterpretedFunction` but receives a native Dart function.

```dart
void main() {
  var numbers = [1, 2, 3];
  numbers.forEach(print);  // ❌ FAILS - print is a native function
}
```

**Error:** `Native error during bridged method call 'forEach' on List: Runtime Error: Expected a InterpretedFunction for forEach`

Note: `numbers.forEach((n) => print(n))` works because the lambda is an interpreted function.

#### Where is the Problem?

- **Location:** `dart_core_bridge.dart` - List bridge `forEach` implementation
- **Root Cause:** The `forEach` bridge method only accepts `InterpretedFunction` but should also handle native Dart functions (like `print`)

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-95: List.forEach with native function tear-off should work"

#### Solution Strategy

Modify the `forEach` bridge to accept both `InterpretedFunction` and native Dart `Function` objects. Check the argument type and call it appropriately.

---

### Bug-96: super.name Constructor Parameter Forwarding Fails

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Dart 3's super parameter syntax (`Child(super.name)`) that automatically forwards parameters to the superclass constructor is not handled. The interpreter fails to pass the argument to the parent constructor.

```dart
class Parent {
  final String name;
  Parent(this.name);
}

class Child extends Parent {
  Child(super.name);  // ❌ FAILS - should forward 'name' to Parent
}

void main() {
  print(Child('test').name);
}
```

**Error:** `Error during constructor execution for class 'Child': Missing required argument for 'name' in function ''.`

#### Where is the Problem?

- **Location:** `runtime_types.dart` - Constructor execution / super parameter handling
- **Root Cause:** The `super.name` parameter syntax is not recognized as forwarding the argument to the superclass constructor

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-96: super.name constructor parameter forwarding should work"

#### Solution Strategy

When processing constructor parameters, detect `super.name` syntax (SuperFormalParameter in the AST) and forward the argument value to the corresponding superclass constructor parameter.

---

### Bug-97: num Not Recognized as Satisfying Comparable Bound

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

When a generic class has a type bound `T extends Comparable<dynamic>`, using `num` as the type argument is rejected. In Dart, `num` implements `Comparable<num>`, so it should satisfy this bound.

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

#### Where is the Problem?

- **Location:** `runtime_types.dart` - `_getValidatedTypeArguments`
- **Root Cause:** The type bound checker doesn't recognize that `num` implements `Comparable<num>` since `num` is a bridged type and its interface hierarchy isn't fully checked

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-97: num should satisfy Comparable type bound"

#### Solution Strategy

In the type bound validation, add knowledge that core Dart types (`num`, `int`, `double`, `String`) implement `Comparable`. Either hardcode these known relationships or check the bridged type's interface chain.

---

### Bug-98: Extension Getter on Bridged List Not Resolved

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Medium

#### Problem Description

Extension getters defined on `List<int>` (or other specific bridged type parameterizations) are not found when called on a native List instance.

```dart
extension IntListExt on List<int> {
  int get sum => fold(0, (a, b) => a + b);
  double get average => isEmpty ? 0.0 : sum / length;
}

void main() {
  var numbers = [1, 2, 3, 4, 5];
  print(numbers.average);  // ❌ FAILS
}
```

**Error:** `Undefined property or method 'average' on bridged instance of 'List'.`

#### Where is the Problem?

- **Location:** `interpreter_visitor.dart` - Extension lookup for bridged types
- **Root Cause:** The extension matcher doesn't match `List<int>` extensions against native List instances. The type parameterization check may be too strict or missing for bridged types.

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-98: Extension getter on bridged List should work"

#### Solution Strategy

Enhance the extension lookup to match extensions on parameterized bridged types (like `List<int>`) against actual bridged instances, checking that the type arguments are compatible.

---

### Bug-99: Stream.handleError Callback Receives Wrong Argument Count

**Status:** ⬜ TODO  
**Fixable:** ✅ Yes  
**Complexity:** Low

#### Problem Description

When using `Stream.handleError()` with a single-argument error handler, the interpreter passes too many arguments to the callback (error + stack trace), but the user's callback only expects one argument.

```dart
import 'dart:async';

void main() async {
  var stream = Stream.fromIterable([1, 2, 3]).map((n) {
    if (n == 2) throw 'Error at $n';
    return n;
  });
  var handled = stream.handleError((e) {  // ❌ FAILS - receives 2 args
    print('Handled: $e');
  });
  await for (var n in handled) {
    print('Value: $n');
  }
}
```

**Error:** `Too many positional arguments. Expected at most 1, got 2.`

Note: Dart's `handleError` accepts `Function(error)` OR `Function(error, stackTrace)`. The implementation should check the callback's parameter count.

#### Where is the Problem?

- **Location:** `stdlib/async/stream.dart` - `handleError` bridge implementation
- **Root Cause:** The bridge always passes both the error and stack trace to the callback, without checking if the callback accepts 1 or 2 arguments

#### Affected Tests

- `dart_overview_bugs_test.dart` - "Bug-99: Stream handleError callback should receive correct args"

#### Solution Strategy

Check the number of parameters the user's callback function accepts. If it accepts 1, pass only the error. If it accepts 2, pass both error and stack trace.

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
