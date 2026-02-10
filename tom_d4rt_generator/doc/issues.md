# D4rt Bridge Generator — Known Issues & Limitations

> Last updated: 2026-02-10
> 
> Generated from test baseline analysis comparing tom_d4rt and tom_d4rt_generator test results.

---

## Issue Index

| ID | Description | Complexity | Status |
|----|-------------|------------|--------|
| [G-CB-1](#g-cb-1) | Callback wrapper code expects `_raw` pattern | Low | Fixed |
| [G-CB-2](#g-cb-2) | Void Function() callback pattern mismatch | Low | Fixed |
| [G-CB-3](#g-cb-3) | Multiple callbacks `_raw` pattern mismatch | Low | Fixed |
| [G-GB-1](#g-gb-1) | globalFunctionNames list generation test | Low | Fixed |
| [G-GB-2](#g-gb-2) | globalVariableNames list generation test | Low | Fixed |
| [G-GB-3](#g-gb-3) | getGlobalInitializationScript generation test | Low | Fixed |
| [G-GB-4](#g-gb-4) | Init script variable getters test | Low | Fixed |
| [G-GB-5](#g-gb-5) | Const vars registerGlobalVariable test | Low | Fixed |
| [G-GB-6](#g-gb-6) | Final vars registerGlobalVariable test | Low | Fixed |
| [G-GB-7](#g-gb-7) | Mutable vars registerGlobalVariable test | Low | Fixed |
| [G-GB-8](#g-gb-8) | Getter singleton registerGlobalGetter test | Low | Fixed |
| [G-GB-9](#g-gb-9) | Computed getter registerGlobalGetter test | Low | Fixed |
| [G-GB-10](#g-gb-10) | Nullable getter registerGlobalGetter test | Low | Fixed |
| [G-GB-11](#g-gb-11) | Mutable state getter registerGlobalGetter test | Low | Fixed |
| [G-GB-12](#g-gb-12) | RegisterGlobalVariables separation test | Low | Fixed |
| [G-UB-1](#g-ub-1) | GlobalsUserBridge appName override | Low | TODO |
| [G-UB-2](#g-ub-2) | GlobalsUserBridge maxRetries override | Low | TODO |
| [G-UB-3](#g-ub-3) | GlobalsUserBridge currentTime getter override | Low | TODO |
| [G-UB-4](#g-ub-4) | GlobalsUserBridge globalService getter override | Low | TODO |
| [G-UB-5](#g-ub-5) | GlobalsUserBridge greet function override | Low | TODO |
| [G-UB-6](#g-ub-6) | GlobalsUserBridge add function override | Low | TODO |
| [G-ASYNC-1](#g-async-1) | Async function Future e2e test | Medium | Fixable |
| [G-ASYNC-2](#g-async-2) | Async* generator Stream e2e test | Medium | Fixable |
| [G-ASYNC-3](#g-async-3) | Sync* generator Iterable e2e test | Medium | Fixable |
| [G-ASYNC-4](#g-async-4) | Callback parameter Function e2e test | Medium | Fixable |
| [G-ASYNC-5](#g-async-5) | Instance async method Future e2e test | Medium | Fixable |
| [G-ASYNC-6](#g-async-6) | Instance sync* method Iterable e2e test | Medium | Fixable |
| [G-ASYNC-7](#g-async-7) | Instance async* method Stream e2e test | Medium | Fixable |
| [G-ASYNC-8](#g-async-8) | Static sync*/async* method e2e test | Medium | Fixable |
| [G-COV-7](#g-cov-7) | TOP15: base mixin e2e test | Medium | Fixable |
| [G-COV-42](#g-cov-42) | TOP01: concrete class e2e test | Medium | Fixable |
| [G-TOP-12](#g-top-12) | Enhanced enum with mixin e2e test | Medium | Fixable |
| [G-TOP-13](#g-top-13) | Generic enum N/A Dart limitation test | Low | Fixable |
| [G-TOP-19](#g-top-19) | Typedef function not needed test | Low | Fixable |
| [G-TOP-24](#g-top-24) | Top-level async function e2e test | Medium | Fixable |
| [G-TOP-28](#g-top-28) | Top-level setter e2e test | Medium | Fixable |
| [G-CLS-6](#g-cls-6) | Late field e2e test | Medium | Fixable |
| [G-PAR-6](#g-par-6) | Function-typed parameter | High | Won't Fix |
| [G-GNRC-7](#g-gnrc-7) | F-bounded polymorphism | High | Won't Fix |
| [G-OP-8](#g-op-8) | Operator == equality | Medium | Won't Fix |
| [G-TYPE-1](#g-type-1) | Record parameter type | High | Won't Fix |
| [G-TYPE-2](#g-type-2) | Record return type | High | Won't Fix |
| [G-TE-1](#g-te-1) | Bounded type param erasure | Fundamental | Won't Fix |
| [G-TE-2](#g-te-2) | Static castFrom type erasure | Fundamental | Won't Fix |

---

## Issue Details

### Code Generation Pattern Tests

These tests verify specific patterns in generated bridge code. Failures indicate the generator's output structure changed but tests weren't updated, or there's a generator regression.

---

#### G-CB-1

**Callback wrapper code expects `_raw` pattern**

**a) Problem:**

The test expects generated callback wrapper code to contain `_raw` variable naming pattern and `InterpretedFunction` references. The generated code no longer matches this expectation.

**Test expectation:**
```dart
expect(generatedCode, contains('InterpretedFunction'));
expect(generatedCode, contains('_raw'));
```

**b) Location:**
- Test: `test/callback_wrapping_test.dart`
- Generator: `lib/src/bridge_generator.dart` — callback wrapping code generation

**c) Resolution Strategy:**
1. Inspect current generated callback code to understand new pattern
2. Either update tests to match new pattern, or restore expected pattern if regression

---

#### G-CB-2

**Void Function() callback pattern mismatch**

**a) Problem:**

Test expects `'onComplete':` and `.call(visitor as InterpreterVisitor,` patterns in generated code for void callbacks.

**b) Location:**
- Test: `test/callback_wrapping_test.dart`
- Generator: `lib/src/bridge_generator.dart`

**c) Resolution Strategy:**
Same as G-CB-1 — verify generated code matches expected callback invocation pattern.

---

#### G-CB-3

**Multiple callbacks `_raw` pattern mismatch**

**a) Problem:**

Test expects regex pattern `final \w+_raw =` for multiple callback parameters in generated code.

**b) Location:**
- Test: `test/callback_wrapping_test.dart`

**c) Resolution Strategy:**
Same as G-CB-1.

---

#### G-GB-1

**globalFunctionNames list generation test**

**a) Problem:**

Test expects `static List<String> get globalFunctionNames` in generated bridge code. The test failure indicates this accessor may not be generated or has a different signature.

**Test expectation:**
```dart
expect(generatedCode, contains('static List<String> get globalFunctionNames'));
```

**b) Location:**
- Test: `test/global_bridge_generation_test.dart`
- Generator: Global bridge structure generation section

**c) Resolution Strategy:**
1. Check if globalFunctionNames is still generated
2. Update test or generator as needed

---

#### G-GB-2

**globalVariableNames list generation test**

**a) Problem:**

Test expects `static List<String> get globalVariableNames` in generated bridge code.

**b) Location:**
- Test: `test/global_bridge_generation_test.dart`

**c) Resolution Strategy:**
Same as G-GB-1.

---

#### G-GB-3

**getGlobalInitializationScript generation test**

**a) Problem:**

Test expects `static String getGlobalInitializationScript()` method in generated bridge.

**b) Location:**
- Test: `test/global_bridge_generation_test.dart`

**c) Resolution Strategy:**
Same as G-GB-1.

---

#### G-GB-4

**Init script variable getters test**

**a) Problem:**

Test verifies initialization script contains variable getter definitions.

**b) Location:**
- Test: `test/global_bridge_generation_test.dart`

**c) Resolution Strategy:**
Verify global initialization script content generation.

---

#### G-GB-5

**Const vars registerGlobalVariable test**

**a) Problem:**

Test verifies const variables use `registerGlobalVariable` registration pattern.

**b) Location:**
- Test: `test/global_bridge_generation_test.dart`

**c) Resolution Strategy:**
Check global variable registration code generation.

---

#### G-GB-6

**Final vars registerGlobalVariable test**

**a) Problem:**

Test verifies final variables use `registerGlobalVariable` pattern.

**b) Location:**
- Test: `test/global_bridge_generation_test.dart`

**c) Resolution Strategy:**
Same as G-GB-5.

---

#### G-GB-7

**Mutable vars registerGlobalVariable test**

**a) Problem:**

Test verifies mutable (var) variables use `registerGlobalVariable` pattern.

**b) Location:**
- Test: `test/global_bridge_generation_test.dart`

**c) Resolution Strategy:**
Same as G-GB-5.

---

#### G-GB-8

**Getter singleton registerGlobalGetter test**

**a) Problem:**

Test verifies top-level getters (singleton pattern) use `registerGlobalGetter` pattern.

**b) Location:**
- Test: `test/global_bridge_generation_test.dart`

**c) Resolution Strategy:**
Check getter vs variable registration differentiation.

---

#### G-GB-9

**Computed getter registerGlobalGetter test**

**a) Problem:**

Test verifies computed getters use `registerGlobalGetter` pattern.

**b) Location:**
- Test: `test/global_bridge_generation_test.dart`

**c) Resolution Strategy:**
Same as G-GB-8.

---

#### G-GB-10

**Nullable getter registerGlobalGetter test**

**a) Problem:**

Test verifies nullable getters use `registerGlobalGetter` pattern.

**b) Location:**
- Test: `test/global_bridge_generation_test.dart`

**c) Resolution Strategy:**
Same as G-GB-8.

---

#### G-GB-11

**Mutable state getter registerGlobalGetter test**

**a) Problem:**

Test verifies mutable state getters use `registerGlobalGetter` pattern.

**b) Location:**
- Test: `test/global_bridge_generation_test.dart`

**c) Resolution Strategy:**
Same as G-GB-8.

---

#### G-GB-12

**RegisterGlobalVariables separation test**

**a) Problem:**

Test verifies proper separation between variable and getter registration.

**b) Location:**
- Test: `test/global_bridge_generation_test.dart`

**c) Resolution Strategy:**
Verify registration logic properly categorizes globals.

---

#### G-UB-1

**GlobalsUserBridge appName override**

**a) Problem:**

Test verifies GlobalsUserBridge generates override for global variable `appName`.

**b) Location:**
- Test: `test/user_bridge_test.dart`
- Generator: GlobalsUserBridge generation section

**c) Resolution Strategy:**
Check GlobalsUserBridge override generation for global variables.

---

#### G-UB-2

**GlobalsUserBridge maxRetries override**

**a) Problem:**

Test verifies GlobalsUserBridge generates override for global variable `maxRetries`.

**b) Location:**
- Test: `test/user_bridge_test.dart`

**c) Resolution Strategy:**
Same as G-UB-1.

---

#### G-UB-3

**GlobalsUserBridge currentTime getter override**

**a) Problem:**

Test verifies GlobalsUserBridge generates override for getter `currentTime`.

**b) Location:**
- Test: `test/user_bridge_test.dart`

**c) Resolution Strategy:**
Check GlobalsUserBridge override generation for getters.

---

#### G-UB-4

**GlobalsUserBridge globalService getter override**

**a) Problem:**

Test verifies GlobalsUserBridge generates override for getter `globalService`.

**b) Location:**
- Test: `test/user_bridge_test.dart`

**c) Resolution Strategy:**
Same as G-UB-3.

---

#### G-UB-5

**GlobalsUserBridge greet function override**

**a) Problem:**

Test verifies GlobalsUserBridge generates override for function `greet`.

**b) Location:**
- Test: `test/user_bridge_test.dart`

**c) Resolution Strategy:**
Check GlobalsUserBridge override generation for functions.

---

#### G-UB-6

**GlobalsUserBridge add function override**

**a) Problem:**

Test verifies GlobalsUserBridge generates override for function `add`.

**b) Location:**
- Test: `test/user_bridge_test.dart`

**c) Resolution Strategy:**
Same as G-UB-5.

---

### E2E Coverage Tests — Potentially Fixable

These tests run D4rt scripts using generated bridges. With tom_d4rt interpreter fixes applied, many of these may now pass. Status "Fixable" means they should be re-tested.

---

#### G-ASYNC-1

**Async function Future e2e test**

**a) Problem:**

E2E test for async functions returning Future fails. This was blocked by interpreter async handling issues that may now be fixed in tom_d4rt.

**Test script:** `example/dart_overview/test/async01_async_function.dart`

**b) Location:**
- Test: `test/d4rt_coverage_test.dart`
- Related interpreter code: `tom_d4rt` async/await handling

**c) Resolution Strategy:**
1. Re-run test with latest tom_d4rt
2. If still failing, investigate interpreter async handling

---

#### G-ASYNC-2

**Async* generator Stream e2e test**

**a) Problem:**

E2E test for async* generator methods returning Stream.

**Test script:** `example/dart_overview/test/async02_async_generator.dart`

**c) Resolution Strategy:**
Same as G-ASYNC-1 — re-test with latest interpreter.

---

#### G-ASYNC-3

**Sync* generator Iterable e2e test**

**a) Problem:**

E2E test for sync* generator methods returning Iterable.

**Test script:** `example/dart_overview/test/async03_sync_generator.dart`

**c) Resolution Strategy:**
Same as G-ASYNC-1.

---

#### G-ASYNC-4

**Callback parameter Function e2e test**

**a) Problem:**

E2E test for functions with callback parameters.

**Test script:** `example/dart_overview/test/async04_callback_param.dart`

**c) Resolution Strategy:**
Same as G-ASYNC-1.

---

#### G-ASYNC-5

**Instance async method Future e2e test**

**a) Problem:**

E2E test for instance methods that are async.

**Test script:** `example/dart_overview/test/async05_instance_async_method.dart`

**c) Resolution Strategy:**
Same as G-ASYNC-1.

---

#### G-ASYNC-6

**Instance sync* method Iterable e2e test**

**a) Problem:**

E2E test for instance methods that are sync* generators.

**Test script:** `example/dart_overview/test/async06_instance_sync_generator.dart`

**c) Resolution Strategy:**
Same as G-ASYNC-1.

---

#### G-ASYNC-7

**Instance async* method Stream e2e test**

**a) Problem:**

E2E test for instance methods that are async* generators.

**Test script:** `example/dart_overview/test/async07_instance_async_generator.dart`

**c) Resolution Strategy:**
Same as G-ASYNC-1.

---

#### G-ASYNC-8

**Static sync*/async* method e2e test**

**a) Problem:**

E2E test for static generator methods.

**Test script:** `example/dart_overview/test/async08_static_generators.dart`

**c) Resolution Strategy:**
Same as G-ASYNC-1.

---

#### G-COV-7

**TOP15: base mixin e2e test**

**a) Problem:**

E2E test for base mixin declarations.

**Test script:** `example/dart_overview/test/top15_base_mixin.dart`

**c) Resolution Strategy:**
Re-test with latest interpreter.

---

#### G-COV-42

**TOP01: concrete class e2e test**

**a) Problem:**

E2E test for basic concrete class bridging. Note: This test passed when manually run, suggesting the baseline may be outdated.

**Test script:** `example/dart_overview/test/top01_concrete_class.dart`

**c) Resolution Strategy:**
Re-run test suite to update baseline.

---

#### G-TOP-12

**Enhanced enum with mixin e2e test**

**a) Problem:**

E2E test for enhanced enums that use mixins.

**Test script:** `example/dart_overview/test/top12_enhanced_enum_mixin.dart`

**c) Resolution Strategy:**
Re-test with latest interpreter.

---

#### G-TOP-13

**Generic enum N/A Dart limitation test**

**a) Problem:**

Test for generic enum handling (Dart doesn't support generic enums, this tests the limitation is handled).

**Test script:** `example/dart_overview/test/top13_generic_enum.dart`

**c) Resolution Strategy:**
Verify test correctly handles the limitation.

---

#### G-TOP-19

**Typedef function not needed test**

**a) Problem:**

Test verifies function typedefs don't require bridging.

**Test script:** `example/dart_overview/test/top19_typedef_function.dart`

**c) Resolution Strategy:**
Re-test.

---

#### G-TOP-24

**Top-level async function e2e test**

**a) Problem:**

E2E test for top-level async functions. Related to G-ASYNC-1 interpreter issues.

**Test script:** `example/dart_overview/test/top24_async_function.dart`

**c) Resolution Strategy:**
Same as G-ASYNC-1.

---

#### G-TOP-28

**Top-level setter e2e test**

**a) Problem:**

E2E test for top-level setter assignment.

**Test script:** `example/dart_overview/test/top28_toplevel_setter.dart`

**c) Resolution Strategy:**
Re-test — interpreter setter handling may be fixed.

---

#### G-CLS-6

**Late field e2e test**

**a) Problem:**

E2E test for late field initialization.

**Test script:** `example/dart_overview/test/cls06_late_field.dart`

**c) Resolution Strategy:**
Re-test — late field handling may work now.

---

### Known Limitations (Won't Fix)

These issues have fundamental limitations that prevent fixing without significant architectural changes or are blocked by Dart language constraints.

---

#### G-PAR-6

**Function-typed parameter**

**a) Problem:**

The interpreter creates list literals as `List<Object?>`. When passed to bridged functions expecting `List<int>`, the `D4.getRequiredArg<List<int>>` method fails with type mismatch:

```
Invalid parameter "numbers": expected List<int>, got List<Object?>
```

**b) Location:**
- Interpreter: `tom_d4rt/lib/src/generator/d4.dart` — `extractBridgedArg<T>` method

**c) Reason for Won't Fix:**

This requires deep changes to interpreter collection type handling. The same underlying issue affects multiple scenarios:
- List parameters to bridged methods
- Map parameters with typed values
- Set parameters

**Related:** Same root cause as the former GEN-057, GEN-061.

---

#### G-GNRC-7

**F-bounded polymorphism**

**a) Problem:**

When calling `list.sort()` on a list containing bridged objects, elements are wrapped as `BridgedInstance<Object>`. Dart's `List.sort()` tries to cast them to `Comparable<dynamic>`, which fails:

```
type 'BridgedInstance<Object>' is not a subtype of type 'Comparable<dynamic>' in type cast
```

**b) Location:**
- Interpreter: BridgedInstance unwrapping during native method calls

**c) Reason for Won't Fix:**

Requires automatic unwrapping of BridgedInstance when calling native Dart methods on collections. This is complex and has edge cases.

**Related:** Former GEN-062.

---

#### G-OP-8

**Operator == equality**

**a) Problem:**

Operator methods on bridged instances may not correctly handle int-to-double promotion or other implicit type conversions that Dart performs automatically.

**b) Location:**
- Interpreter: Operator resolution and type promotion logic

**c) Reason for Won't Fix:**

Interpreter would need comprehensive type promotion rules matching Dart's behavior.

**Related:** Former GEN-058.

---

#### G-TYPE-1

**Record parameter type**

**a) Problem:**

Functions that take record types as parameters fail at runtime. Dart records `(int, String)` or `({int x, int y})` are not understood by the bridge system.

**Example:**
```dart
void processPoint(({int x, int y}) point) {
  print(point.x + point.y);
}
```

**b) Location:**
- Generator: Parameter type analysis
- Interpreter: Record expression handling

**c) Reason for Won't Fix:**

Record types are a Dart 3.0 feature requiring substantial work to support:
1. Record literal parsing in interpreter
2. Record field access (`.$1`, `.fieldName`)
3. Bridge wrapper generation for record parameters

**Related:** Former GEN-060.

---

#### G-TYPE-2

**Record return type**

**a) Problem:**

Functions that return record types fail. The bridge can't properly wrap or unwrap record values.

**Example:**
```dart
(int min, int max) findMinMax(List<int> numbers) {
  return (numbers.reduce(min), numbers.reduce(max));
}
```

**c) Reason for Won't Fix:**

Same as G-TYPE-1 — requires comprehensive record type support.

---

#### G-TE-1

**Bounded type param erasure**

**a) Problem:**

Generic methods with bounded type parameters lose type information due to type erasure at runtime. The interpreter cannot determine the actual type parameter value.

**Example:**
```dart
T clamp<T extends Comparable<T>>(T value, T min, T max) {
  if (value.compareTo(min) < 0) return min;
  if (value.compareTo(max) > 0) return max;
  return value;
}
```

**c) Reason for Won't Fix:**

Dart language limitation. Generic type parameters are erased at runtime and not available for reflection.

**Related:** Former GEN-001.

---

#### G-TE-2

**Static castFrom type erasure**

**a) Problem:**

Static methods with constrained type parameters (like `List.castFrom<S, T>`) lose type information.

**c) Reason for Won't Fix:**

Same fundamental Dart limitation as G-TE-1.

---

## Summary

**Total issues:** 44

| Status | Count | Description |
|--------|-------|-------------|
| TODO | 21 | Code generation pattern tests needing investigation |
| Fixable | 16 | E2E tests that may pass with tom_d4rt fixes |
| Won't Fix | 7 | Fundamental interpreter/Dart limitations |

**Recommended next steps:**
1. Re-run e2e test suite to update baseline after tom_d4rt fixes
2. Investigate code generation pattern tests (G-CB-*, G-GB-*, G-UB-*) to determine if tests or generator need updating
3. Update this document after re-testing

---

## Prompt

This document was generated by the request:

> Please compare the test result of tom_d4rt and tom_d4rt_generator and determine which issues (failing tests that should succeed) should be fixable based on the current status of tom_d4rt. We fixed pretty much all issues in tom_d4rt earlier today. Create a fresh issues.md document for this result, with the format as the current one, but with the new test id as issue id and only with the failed test.
