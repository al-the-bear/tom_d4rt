# D4rt Interpreter Limitations and Bugs

This document provides a comprehensive reference of all known D4rt interpreter limitations and bugs, their current status, fixability assessment, and solution strategies.

**Last Updated:** 2026-02-05

---

## Table 1: Limitations

Limitations are fundamental constraints or intentionally unsupported features of the D4rt interpreter.

| ID | Description | Fixable? | Complexity | Status |
|----|-------------|----------|------------|--------|
| Lim-1 | Extension types (Dart 3.3+ inline classes) not supported | ⚠️ Major | High | ⬜ TODO |
| Lim-2 | Extensions on bridged types don't work | ✅ Yes | Medium | ⬜ TODO |
| Lim-3 | Isolate execution with interpreted code | ❌ No | Fundamental | 🚫 Won't Fix |
| Lim-4 | Infinite sync* generators hang (eager evaluation) | ⚠️ Major | High | ⬜ TODO |
| Lim-5 | Comparable interface not implemented for interpreted classes | ⚠️ Partial | High | 🚫 Limitation |
| Lim-6 | Labeled continue in switch statements | ✅ Yes | Medium | ⬜ TODO |
| Lim-7 | noSuchMethod getter/setter access (methods work) | ✅ Yes | Medium | ⚠️ Partial |
| Lim-8 | Await in string interpolation (shows raw object) | ⚠️ Partial | Medium | ⚠️ Quirk |

---

## Table 2: Bugs

Bugs are issues that should work but don't. Many have been fixed.

| ID | Description | Fixable? | Complexity | Status |
|----|-------------|----------|------------|--------|
| Bug-1 | List.empty() constructor not bridged | ✅ Yes | Low | ✅ Fixed |
| Bug-2 | Queue.addAll() method not bridged | ✅ Yes | Low | ✅ Fixed |
| Bug-3 | Enum value access via Day.wednesday fails | ✅ Yes | Low | ✅ Fixed |
| Bug-4 | Enum value at top-level const fails | ✅ Yes | Low | ✅ Fixed |
| Bug-5 | Division by zero throws instead of returning infinity | ✅ Yes | Low | ✅ Fixed |
| Bug-6 | Record missing Object methods (hashCode) | ✅ Yes | Low | ✅ Fixed |
| Bug-7 | Digit separators (1_000_000) not parsed | ✅ Yes | Low | ✅ Fixed |
| Bug-8 | List.indexWhere() method not bridged | ✅ Yes | Low | ✅ Fixed |
| Bug-9 | Type Never not found in type resolution | ✅ Yes | Medium | ✅ Fixed |
| Bug-10 | Interface Comparable not found for implements | ✅ Yes | Medium | ✅ Fixed |
| Bug-11 | Sealed class subclasses incorrectly rejected | ✅ Yes | Medium | ✅ Fixed |
| Bug-12 | Interface Exception not found for implements | ✅ Yes | Medium | ✅ Fixed |
| Bug-13 | Pattern \|\| in switch not supported | ⚠️ Major | High | ✅ Fixed |
| Bug-14 | Record type annotation not resolved | ✅ Yes | Medium | ✅ Fixed |
| Bug-15 | base64Encode function not exported from dart:convert | ✅ Yes | Low | ✅ Fixed |
| Bug-16 | Abstract method inheritance false positive | ✅ Yes | Medium | ✅ Fixed |
| Bug-17 | Interface class same-library extension incorrectly rejected | ✅ Yes | Medium | ✅ Fixed |
| Bug-18 | Mixin abstract getter inheritance false positive | ✅ Yes | Medium | ✅ Fixed |
| Bug-20 | identical() function not bridged | ✅ Yes | Low | ✅ Fixed |
| Bug-21 | Set.from() constructor not bridged | ✅ Yes | Low | ✅ Fixed |
| Bug-22 | Error() class constructor not bridged | ✅ Yes | Low | ✅ Fixed |
| Bug-23 | Static const referencing sibling const fails | ✅ Yes | Medium | ✅ Fixed |
| Bug-24 | mixin class declaration not supported | ✅ Yes | Medium | ✅ Fixed |
| Bug-26 | Assert in constructor initializer not supported | ✅ Yes | Medium | ✅ Fixed |
| Bug-27 | Short-circuit && with null check fails | ✅ Yes | Medium | ✅ Fixed |
| Bug-28 | GenericFunctionTypeImpl not implemented | ✅ Yes | Medium | ✅ Fixed |
| Bug-29 | Future.value() returns wrong type | ✅ Yes | Medium | ✅ Fixed |
| Bug-32 | continue with label in switch case (see Lim-6) | ✅ Yes | Medium | ⬜ TODO |
| Bug-40 | List.sort() with Comparable InterpretedInstance (see Lim-5) | ⚠️ Partial | High | 🚫 Limitation |
| Bug-41 | Await in string interpolation (see Lim-9) | ⚠️ Partial | Medium | 🚫 Limitation |
| Bug-42 | noSuchMethod override not invoked for getters (see Lim-7) | ✅ Yes | Medium | ⚠️ Partial |
| Bug-43 | Infinite sync* generators (see Lim-4) | ⚠️ Major | High | ⬜ TODO |
| Bug-44 | Async generators completion detection issues | ✅ Yes | Medium | ✅ Fixed |
| Bug-45 | Labeled continue in sync* generators fails | ✅ Yes | Medium | ✅ Fixed |
| Bug-47 | Future.doWhile type cast issues | ✅ Yes | Medium | ✅ Fixed |
| Bug-48 | await for stream iteration fails | ✅ Yes | Medium | ✅ Fixed |
| Bug-50 | Index assignment operator `[]=` not found | ✅ Yes | Low | ✅ Fixed |
| Bug-51 | Bridged mixins not found during type resolution | ✅ Yes | Medium | ✅ Fixed |
| Bug-52 | Implicit super() fails when superclass has constructors | ✅ Yes | Low | ✅ Fixed |
| Bug-53 | NullAwareElement feature not supported | ✅ Yes | Low | ✅ Fixed |
| Bug-54 | Void return type checking too strict | ✅ Yes | Low | ✅ Fixed |

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

**Status:** ⬜ TODO  
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

#### Potential Fix Strategies

1. **Strategy A: Extension fallback for bridged instances**
   - In property access error paths, before throwing, check `findExtensionMember(bridgedInstance, name)`
   - If found, call the extension member
   - Complexity: Medium

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

### Lim-4: Infinite Sync* Generators Hang

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

### Lim-5: Comparable Interface Not Implemented

**Status:** 🚫 Limitation  
**Fixable:** ⚠️ Partial  
**Complexity:** High

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

#### Workarounds

Use explicit comparator functions:
```dart
people.sort((a, b) => a.name.compareTo(b.name));  // ✅ Works
```

**Test File:** `d4rt_bugs/hard_high/bug_40_comparable_sort.dart`

---

### Lim-6: Labeled Continue in Switch Statements

**Status:** ⬜ TODO  
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

#### Potential Fix Strategies

1. **Strategy A: Case label tracking**
   - Track labeled cases in switch statements
   - Implement continue-to-label as case jump
   - Complexity: Medium

**Test File:** `d4rt_bugs/hard_high/bug_32_continue_label.dart`

---

### Lim-7: noSuchMethod Getter/Setter Access

**Status:** ⚠️ Partial  
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

#### Potential Fix Strategies

1. **Strategy A: Check noSuchMethod for property access**
   - Before throwing "property not found", check if class overrides `noSuchMethod`
   - Create getter/setter `Invocation` and call the override
   - Complexity: Medium

**Test File:** `d4rt_bugs/hard_high/bug_42_nosuchmethod.dart`

---

### Lim-8: LogicalOrPattern in Switch

**Status:** 🚫 Limitation  
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

### Lim-9: Await in String Interpolation

**Status:** 🚫 Limitation  
**Fixable:** ⚠️ Partial  
**Complexity:** Medium

#### Problem Description

Await expressions inside string interpolation don't work correctly.

```dart
Future<String> getName() async => 'Alice';

void main() async {
  print('Hello ${await getName()}');  // ❌ May not resolve correctly
}
```

#### Workarounds

Assign to variable first:
```dart
final name = await getName();
print('Hello $name');  // ✅ Works
```

**Test File:** `d4rt_bugs/hard_high/bug_41_future_interpolation.dart`

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
