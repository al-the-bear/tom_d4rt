# D4rt Bridge Generator — Test Coverage

This document tracks bridge generator features and the tests that verify them. It serves as a living inventory to identify coverage gaps and guide future test development.

**Test infrastructure:** See `_copilot_guidelines/testing.md` for the D4rtTester architecture and test conventions.

**Test files:**
- `test/d4rt_tester_test.dart` — end-to-end tests using D4rtTester (per-example-project)
- `test/d4rt_coverage_test.dart` — feature-level coverage tests (per-feature, using dart_overview)

**D4rt test scripts:** `example/dart_overview/test/` — individual D4rt scripts per feature (named `<feature-id>_<description>.dart`)

---

## Feature ID Scheme

Each feature has a stable ID for cross-referencing between this document, test scripts, and issue reports.

| Prefix | Category |
|--------|----------|
| TOP | Top-Level Exportables |
| CLS | Class Members |
| CTOR | Constructors |
| OP | Operators |
| PAR | Parameters |
| GNRC | Generics |
| INH | Inheritance |
| UBR | User Bridges |
| ASYNC | Async & Streams |
| TYPE | Special Types |
| VIS | Visibility & Exports |
| GEN | Generator Features |

---

## Overview Tables

**Status legend:**

| Symbol | Meaning |
|--------|---------|
| ✅ | Tested and passing |
| ⚠️ | Tested but failing (known bug) |
| ❌ | Not yet tested |
| 🔲 | Not yet relevant (prerequisite missing — e.g., interpreter support needed first) |
| — | Not applicable for this column (permanent — e.g., no UB test needed for this feature) |

### Column Value Explanations

**Why is UB Test "not needed" for top-level consts (TOP26)?**
Constants are compile-time values inlined by the Dart compiler. They cannot be reassigned at runtime. A user bridge override would have no effect because the value is baked into the code at compile time. The bridge simply exposes the constant's value — there is no behavior to intercept or modify.

**Why is UB Test "not needed" for static const fields (CLS08)?**
Same reasoning as top-level consts. Static const fields are compile-time constants that are inlined. They cannot be overridden because there is no runtime accessor to intercept — the value is resolved at compile time. The bridge registers the constant value directly.

**Difference between 🔲 and `—`:**
- **🔲 (black square)** means the feature **cannot be tested yet** because a prerequisite is missing (e.g., the interpreter doesn't support the feature, or a generator capability is blocked). Once the prerequisite is implemented, the status should change to ❌ (not yet tested) or be tested directly. This is a **temporary** blocker.
- **`—` (em dash)** means the column **does not apply** to this feature. For example, a feature that has no user-overridable behavior will have `—` in the UB Test column permanently. Parameters are tested via the method/constructor UB tests, not separately. This is a **structural** "not applicable".

---

### Top-Level Exportables (29 features)

| ID | Feature | Status | Coverage Test | UB Test | Issue | Details |
|----|---------|--------|---------------|---------|-------|---------|
| TOP01 | Class (concrete) | ✅ | `top01_concrete_class` | — | | [→](#top01-class-concrete) |
| TOP02 | Abstract class | ⚠️ | `top02_abstract_class` | — | GEN-042 | [→](#top02-abstract-class) |
| TOP03 | Sealed class | ✅ | `top03_sealed_class` | — | | [→](#top03-sealed-class) |
| TOP04 | Base class | ✅ | `top04_base_class` | — | | [→](#top04-base-class) |
| TOP05 | Interface class | ⚠️ | `top05_interface_class` | — | GEN-042 | [→](#top05-interface-class) |
| TOP06 | Final class | ✅ | `top06_final_class` | — | | [→](#top06-final-class) |
| TOP07 | Mixin class | ⚠️ | `top07_mixin_class` | — | GEN-042 | [→](#top07-mixin-class) |
| TOP08 | Simple enum | ⚠️ | `top08_simple_enum` | not needed | GEN-044 | [→](#top08-simple-enum) |
| TOP09 | Enhanced enum (fields) | ⚠️ | `top09_enhanced_enum_fields` | — | GEN-041 | [→](#top09-enhanced-enum-fields) |
| TOP10 | Enhanced enum (methods) | ⚠️ | `top10_enhanced_enum_methods` | — | GEN-041 | [→](#top10-enhanced-enum-methods) |
| TOP11 | Enhanced enum (implements) | ⚠️ | `top11_enhanced_enum_implements` | — | GEN-041 | [→](#top11-enhanced-enum-implements) |
| TOP12 | Enhanced enum (with mixin) | ⚠️ | `top12_enhanced_enum_mixin` | — | GEN-041 | [→](#top12-enhanced-enum-with-mixin) |
| TOP13 | Generic enum | ❌ | — | — | | [→](#top13-generic-enum) |
| TOP14 | Mixin | ✅ | `top14_mixin` | — | | [→](#top14-mixin) |
| TOP15 | Base mixin | ❌ | — | — | | [→](#top15-base-mixin) |
| TOP16 | Named extension | ❌ | — | not supported | | [→](#top16-named-extension) |
| TOP17 | Anonymous extension | ❌ | — | not supported | | [→](#top17-anonymous-extension) |
| TOP18 | Extension type | ❌ | — | not supported | | [→](#top18-extension-type) |
| TOP19 | Typedef (function) | ❌ | — | not needed | | [→](#top19-typedef-function) |
| TOP20 | Typedef (type alias) | ❌ | — | not needed | | [→](#top20-typedef-type-alias) |
| TOP21 | Typedef (generic) | ❌ | — | not needed | | [→](#top21-typedef-generic) |
| TOP22 | Top-level function | ✅ | `top22_toplevel_function` | `e2e: userbridge_override` | | [→](#top22-top-level-function) |
| TOP23 | Top-level generic function | ❌ | — | — | | [→](#top23-top-level-generic-function) |
| TOP24 | Top-level async function | ❌ | — | 🔲 | | [→](#top24-top-level-async-function) |
| TOP25 | Top-level variable (var/final) | ✅ | `top25_toplevel_variable` | `e2e: userbridge_override` | | [→](#top25-top-level-variable) |
| TOP26 | Top-level const | ✅ | `top26_toplevel_const` | not needed | | [→](#top26-top-level-const) |
| TOP27 | Top-level getter | ✅ | `top27_toplevel_getter` | `e2e: userbridge_override` | | [→](#top27-top-level-getter) |
| TOP28 | Top-level setter | ❌ | — | — | | [→](#top28-top-level-setter) |
| TOP29 | Mixin application (`class = with`) | ❌ | — | — | | [→](#top29-mixin-application) |

### Class Members (17 features)

| ID | Feature | Status | Coverage Test | UB Test | Issue | Details |
|----|---------|--------|---------------|---------|-------|---------|
| CLS01 | Instance field (getter) | ✅ | `cls01_field_getter` | — | | [→](#cls01-instance-field-getter) |
| CLS02 | Instance field (setter) | ✅ | `cls02_field_setter` | — | | [→](#cls02-instance-field-setter) |
| CLS03 | Final field | ✅ | `cls03_final_field` | — | | [→](#cls03-final-field) |
| CLS04 | Private field with public getter | ✅ | `cls04_private_field_getter` | — | | [→](#cls04-private-field-with-public-getter) |
| CLS05 | Nullable field | ❌ | — | — | | [→](#cls05-nullable-field) |
| CLS06 | Late field | ❌ | — | — | | [→](#cls06-late-field) |
| CLS07 | Static field (mutable) | ✅ | `cls07_static_field` | — | | [→](#cls07-static-field-mutable) |
| CLS08 | Static const field | ✅ | `cls08_static_const` | not needed | | [→](#cls08-static-const-field) |
| CLS09 | Computed getter | ✅ | `cls09_computed_getter` | — | | [→](#cls09-computed-getter) |
| CLS10 | Explicit setter (`set x`) | ✅ | `cls10_explicit_setter` | — | | [→](#cls10-explicit-setter) |
| CLS11 | Static method | ✅ | `cls11_static_method` | — | | [→](#cls11-static-method) |
| CLS12 | Static getter | ❌ | — | — | | [→](#cls12-static-getter) |
| CLS13 | Static setter | ❌ | — | — | | [→](#cls13-static-setter) |
| CLS14 | Instance method | ✅ | `cls14_instance_method` | — | | [→](#cls14-instance-method) |
| CLS15 | Abstract method | ⚠️ | `cls15_abstract_method` | — | GEN-042 | [→](#cls15-abstract-method) |
| CLS16 | `toString()` override | ✅ | `cls16_tostring` | — | | [→](#cls16-tostring-override) |
| CLS17 | `call()` method | ❌ | — | — | | [→](#cls17-call-method) |

### Constructors (8 features)

| ID | Feature | Status | Coverage Test | UB Test | Issue | Details |
|----|---------|--------|---------------|---------|-------|---------|
| CTOR01 | Unnamed (default, explicit) | ✅ | `ctor01_unnamed` | `e2e: userbridge_user_guide` | | [→](#ctor01-unnamed-constructor) |
| CTOR02 | Implicit default (no ctor) | ⚠️ | `ctor02_implicit_default` | — | GEN-042 | [→](#ctor02-implicit-default-constructor) |
| CTOR03 | Named constructor | ✅ | `ctor03_named` | — | | [→](#ctor03-named-constructor) |
| CTOR04 | Factory constructor | ✅ | `ctor04_factory` | — | | [→](#ctor04-factory-constructor) |
| CTOR05 | Const constructor | ✅ | `ctor05_const` | — | | [→](#ctor05-const-constructor) |
| CTOR06 | Redirecting constructor | ✅ | `ctor06_redirecting` | — | | [→](#ctor06-redirecting-constructor) |
| CTOR07 | Private constructor | ✅ | `ctor07_private` | — | | [→](#ctor07-private-constructor) |
| CTOR08 | Super parameters (`super.x`) | ✅ | `ctor08_super_params` | — | | [→](#ctor08-super-parameters) |

### Operators (12 features)

| ID | Feature | Status | Coverage Test | UB Test | Issue | Details |
|----|---------|--------|---------------|---------|-------|---------|
| OP01 | `operator +` | ✅ | e2e: userbridge_user_guide | `e2e: userbridge_user_guide` | | [→](#op01-operator-plus) |
| OP02 | `operator -` (binary) | ✅ | e2e: userbridge_user_guide | `e2e: userbridge_user_guide` | | [→](#op02-operator-minus-binary) |
| OP03 | `operator -` (unary) | ✅ | e2e: userbridge_user_guide | `e2e: userbridge_user_guide` | | [→](#op03-operator-minus-unary) |
| OP04 | `operator *` | ✅ | e2e: userbridge_user_guide | `e2e: userbridge_user_guide` | | [→](#op04-operator-multiply) |
| OP05 | `operator /` | ❌ | — | — | | [→](#op05-operator-divide) |
| OP06 | `operator ~/` | ❌ | — | — | | [→](#op06-operator-integer-divide) |
| OP07 | `operator %` | ❌ | — | — | | [→](#op07-operator-modulo) |
| OP08 | `operator ==` | ❌ | — | — | | [→](#op08-operator-equals) |
| OP09 | `operator <` / `>` / `<=` / `>=` | ❌ | — | — | | [→](#op09-comparison-operators) |
| OP10 | `operator []` | ✅ | e2e: userbridge_user_guide | `e2e: userbridge_user_guide` | | [→](#op10-operator-index) |
| OP11 | `operator []=` | ✅ | e2e: userbridge_user_guide | `e2e: userbridge_user_guide` | | [→](#op11-operator-index-assign) |
| OP12 | Bitwise operators | ❌ | — | — | | [→](#op12-bitwise-operators) |

### Parameters (6 features)

| ID | Feature | Status | Coverage Test | UB Test | Issue | Details |
|----|---------|--------|---------------|---------|-------|---------|
| PAR01 | Required positional | ✅ | `par01_required_positional` | not needed | | [→](#par01-required-positional) |
| PAR02 | Optional positional | ✅ | e2e: example_project | not needed | | [→](#par02-optional-positional) |
| PAR03 | Named parameters | ✅ | `par03_named_params` | not needed | | [→](#par03-named-parameters) |
| PAR04 | Required named (`required`) | ✅ | e2e: user_reference | not needed | | [→](#par04-required-named) |
| PAR05 | Default values | ✅ | e2e: example_project | not needed | | [→](#par05-default-values) |
| PAR06 | Function-typed parameter | ❌ | — | not needed | | [→](#par06-function-typed-parameter) |

### Generics (7 features)

| ID | Feature | Status | Coverage Test | UB Test | Issue | Details |
|----|---------|--------|---------------|---------|-------|---------|
| GNRC01 | Generic class (single type param) | ✅ | `gnrc01_single_type_param` | — | | [→](#gnrc01-generic-class-single) |
| GNRC02 | Generic class (two type params) | ✅ | `gnrc02_two_type_params` | — | | [→](#gnrc02-generic-class-two-params) |
| GNRC03 | Upper bound (`T extends X`) | ❌ | — | — | | [→](#gnrc03-upper-bound) |
| GNRC04 | Generic method | ✅ | `gnrc04_generic_method` | — | | [→](#gnrc04-generic-method) |
| GNRC05 | Generic static factory | ❌ | — | — | | [→](#gnrc05-generic-static-factory) |
| GNRC06 | Generic collection (implicit default ctor) | ⚠️ | `gnrc06_generic_collection` | — | GEN-042 | [→](#gnrc06-generic-collection-implicit-default-ctor) |
| GNRC07 | F-bounded polymorphism | ❌ | — | — | | [→](#gnrc07-f-bounded-polymorphism) |

### Inheritance (6 features)

| ID | Feature | Status | Coverage Test | UB Test | Issue | Details |
|----|---------|--------|---------------|---------|-------|---------|
| INH01 | Single-level extends | ✅ | `inh01_single_extends` | — | | [→](#inh01-single-level-extends) |
| INH02 | Multi-level extends | ⚠️ | `inh02_multi_extends` | — | GEN-042 | [→](#inh02-multi-level-extends) |
| INH03 | Implements (interface) | ⚠️ | `inh03_implements` | — | GEN-042 | [→](#inh03-implements-interface) |
| INH04 | Mixin with (`with`) | ⚠️ | `inh04_mixin_with` | — | GEN-042 | [→](#inh04-mixin-with) |
| INH05 | Super constructor call | ✅ | `inh05_super_ctor` | — | | [→](#inh05-super-constructor-call) |
| INH06 | Method override | ✅ | `inh06_method_override` | — | | [→](#inh06-method-override) |

### User Bridges (6 features)

| ID | Feature | Status | Coverage Test | UB Test | Issue | Details |
|----|---------|--------|---------------|---------|-------|---------|
| UBR01 | User bridge class (basic) | ✅ | e2e: userbridge_user_guide | `e2e: userbridge_user_guide` | | [→](#ubr01-user-bridge-class-basic) |
| UBR02 | User bridge method override | ✅ | e2e: userbridge_override | `e2e: userbridge_override` | | [→](#ubr02-user-bridge-method-override) |
| UBR03 | User bridge field override | ✅ | e2e: userbridge_override | `e2e: userbridge_override` | | [→](#ubr03-user-bridge-field-override) |
| UBR04 | User bridge operator | ✅ | e2e: userbridge_user_guide | `e2e: userbridge_user_guide` | | [→](#ubr04-user-bridge-operator) |
| UBR05 | User bridge constructor | ✅ | e2e: userbridge_user_guide | `e2e: userbridge_user_guide` | | [→](#ubr05-user-bridge-constructor) |
| UBR06 | User bridge import prefix | ✅ | e2e: userbridge_user_guide | `e2e: userbridge_user_guide` | GEN-043 (fixed) | [→](#ubr06-user-bridge-import-prefix) |

### Async & Streams (4 features)

| ID | Feature | Status | Coverage Test | UB Test | Issue | Details |
|----|---------|--------|---------------|---------|-------|---------|
| ASYNC01 | Async function (Future) | ⚠️ | `async01_async_function` | 🔲 | | [→](#async01-async-function-future) |
| ASYNC02 | Async* generator (Stream) | ⚠️ | `async02_async_generator` | 🔲 | | [→](#async02-async-generator-stream) |
| ASYNC03 | Sync* generator (Iterable) | ⚠️ | `async03_sync_generator` | 🔲 | | [→](#async03-sync-generator-iterable) |
| ASYNC04 | Callback parameter (Function) | ⚠️ | `async04_callback_param` | — | GEN-005 | [→](#async04-callback-parameter-function) |

### Special Types (5 features)

| ID | Feature | Status | Coverage Test | UB Test | Issue | Details |
|----|---------|--------|---------------|---------|-------|---------|
| TYPE01 | Record type parameter | ❌ | — | not needed | | [→](#type01-record-type-parameter) |
| TYPE02 | Record type return | ❌ | — | not needed | | [→](#type02-record-type-return) |
| TYPE03 | Nullable parameter | ❌ | — | not needed | | [→](#type03-nullable-parameter) |
| TYPE04 | Nullable return | ❌ | — | not needed | | [→](#type04-nullable-return) |
| TYPE05 | `dynamic` parameter / return | ✅ | e2e: dart_overview | not needed | | [→](#type05-dynamic-parameter--return) |

### Visibility & Exports (4 features)

| ID | Feature | Status | Coverage Test | UB Test | Issue | Details |
|----|---------|--------|---------------|---------|-------|---------|
| VIS01 | Barrel export filtering | ✅ | e2e: dart_overview | not needed | | [→](#vis01-barrel-export-filtering) |
| VIS02 | Private member exclusion | ✅ | e2e: dart_overview | not needed | | [→](#vis02-private-member-exclusion) |
| VIS03 | Show/hide combinators | ❌ | — | not needed | | [→](#vis03-showhide-combinators) |
| VIS04 | Multi-barrel modules | ✅ | e2e: dart_overview | not needed | GEN-030 (fixed) | [→](#vis04-multi-barrel-modules) |

### Generator Features (18 features)

Generator-level features cover configuration, type resolution, output generation, and diagnostics — independent of which Dart language constructs are bridged.

| ID | Feature | Status | Test | Issue | Details |
|----|---------|--------|------|-------|---------|
| GFEAT01 | Single barrel analysis | ✅ | e2e: all projects | | [→](#gfeat01-single-barrel-analysis) |
| GFEAT02 | Multi-barrel modules | ✅ | e2e: dart_overview | GEN-030 (fixed) | [→](#gfeat02-multi-barrel-modules) |
| GFEAT03 | Re-export following (`followAllReExports`) | ❌ | — | | [→](#gfeat03-re-export-following) |
| GFEAT04 | Selective re-export (`skipReExports` / `followReExports`) | ❌ | — | GEN-028 (fixed) | [→](#gfeat04-selective-re-export) |
| GFEAT05 | Class/enum/function/variable exclusion | ❌ | — | | [→](#gfeat05-element-exclusion) |
| GFEAT06 | Source pattern exclusion (`excludeSourcePatterns`) | ❌ | — | | [→](#gfeat06-source-pattern-exclusion) |
| GFEAT07 | Deprecated element filtering | ❌ | — | | [→](#gfeat07-deprecated-element-filtering) |
| GFEAT08 | Import show/hide clauses | ❌ | — | | [→](#gfeat08-import-showhide-clauses) |
| GFEAT09 | Cross-package type resolution | ❌ | — | | [→](#gfeat09-cross-package-type-resolution) |
| GFEAT10 | External bridge imports (`importedBridges`) | ❌ | — | | [→](#gfeat10-external-bridge-imports) |
| GFEAT11 | Library path deduplication (`libraryPath`) | ❌ | — | | [→](#gfeat11-library-path-deduplication) |
| GFEAT12 | Config precedence (CLI > project > build > legacy) | ❌ | — | GEN-024 | [→](#gfeat12-config-precedence) |
| GFEAT13 | User bridge scanner | ✅ | e2e: userbridge_* | GEN-043 (fixed) | [→](#gfeat13-user-bridge-scanner) |
| GFEAT14 | Barrel name collision detection | ❌ | — | GEN-045 | [→](#gfeat14-barrel-name-collision) |
| GFEAT15 | Recursive type bound dispatch | ❌ | — | GEN-002 | [→](#gfeat15-recursive-type-bound-dispatch) |
| GFEAT16 | Missing export / type downgrade warnings | ❌ | — | GEN-017 | [→](#gfeat16-missing-export-warnings) |
| GFEAT17 | `.b.dart` extension normalization | ❌ | — | GEN-037 (fixed) | [→](#gfeat17-bdart-extension-normalization) |
| GFEAT18 | Test runner generation | ✅ | e2e: all projects | | [→](#gfeat18-test-runner-generation) |

---

## Coverage Summary

| Category | Total | ✅ | ⚠️ | ❌ | 🔲 |
|----------|-------|-----|------|-----|------|
| Top-Level Exportables | 29 | 9 | 8 | 12 | 0 |
| Class Members | 17 | 11 | 1 | 5 | 0 |
| Constructors | 8 | 7 | 1 | 0 | 0 |
| Operators | 12 | 6 | 0 | 6 | 0 |
| Parameters | 6 | 5 | 0 | 1 | 0 |
| Generics | 7 | 3 | 1 | 3 | 0 |
| Inheritance | 6 | 3 | 3 | 0 | 0 |
| User Bridges | 6 | 6 | 0 | 0 | 0 |
| Async & Streams | 4 | 0 | 4 | 0 | 0 |
| Special Types | 5 | 1 | 0 | 4 | 0 |
| Visibility & Exports | 4 | 3 | 0 | 1 | 0 |
| Generator Features | 18 | 4 | 0 | 14 | 0 |
| **Total** | **122** | **58** | **18** | **46** | **0** |

---

## Feature Details

### Top-Level Exportables

#### TOP01: Class (concrete)

Concrete classes with explicit constructors are bridged and accessible from D4rt scripts.

**Coverage test:** `top01_concrete_class.dart` — PASSED
- Creates `Dog('Rex', 5)` and `Circle(3.0)`, verifies field access.

**Tested in:** example_project, user_guide, user_reference, dart_overview, userbridge_user_guide

---

#### TOP02: Abstract class

Abstract classes should be registerable but not directly constructible. Subclass constructors should work through the abstract type.

**Coverage test:** `top02_abstract_class.dart` — FAILED
- Tests abstract class registration and subclass construction through the abstract type.
- **Failure:** Implicit default constructor on concrete subclass not bridged.
- **Issue:** GEN-042

---

#### TOP03: Sealed class

Sealed classes restrict the type hierarchy. Bridge generator should handle sealed modifier and exhaustive switch patterns.

**Coverage test:** `top03_sealed_class.dart` — PASSED
- Tests sealed class registration and subclass usage.

---

#### TOP04: Base class

Base classes restrict `implements` outside their library. Bridge generator should handle the `base` modifier.

**Coverage test:** `top04_base_class.dart` — PASSED
- Tests base class registration, construction, and field/method access.

---

#### TOP05: Interface class

Interface classes restrict `extends` outside their library. Bridge generator should handle the `interface` modifier.

**Coverage test:** `top05_interface_class.dart` — FAILED
- Tests interface class registration and implementation via concrete subclass.
- **Failure:** Implicit default constructor on implementing class not bridged.
- **Issue:** GEN-042

---

#### TOP06: Final class

Final classes prevent both `extends` and `implements` outside their library. Bridge generator should handle the `final` modifier.

**Coverage test:** `top06_final_class.dart` — PASSED
- Tests final class registration, construction, and member access.

---

#### TOP07: Mixin class

Mixin classes can be used as both classes and mixins. Bridge generator should handle the `mixin class` declaration.

**Coverage test:** `top07_mixin_class.dart` — FAILED
- Tests mixin class registration and usage both as class and mixin.
- **Failure:** Implicit default constructor on class using mixin not bridged.
- **Issue:** GEN-042

---

#### TOP08: Simple enum

Simple enums (no fields/methods) should have all values accessible and support `.name`, `.index`, and `.values`.

**Coverage test:** `top08_simple_enum.dart` — FAILED
- Tests `Day.monday.name`, `Day.monday.index`, `Day.values.length`
- **Failure:** `Day.values` is not accessible via bridge — the `.values` static getter on enums is not bridged/supported.
- **Issue:** GEN-044

---

#### TOP09: Enhanced enum (fields)

Enhanced enums with custom fields (e.g., `Planet` with `mass`, `radius`) should expose field getters via bridges.

**Coverage test:** `top09_enhanced_enum_fields.dart` — FAILED
- Tests `Planet.earth.mass`, `Planet.earth.radius`
- **Failure:** Enhanced enum fields not accessible at runtime.
- **Issue:** GEN-041

**Tested in:** example_project, dart_overview

---

#### TOP10: Enhanced enum (methods)

Enhanced enums with methods should expose those methods via bridges.

**Coverage test:** `top10_enhanced_enum_methods.dart` — FAILED
- Tests enum methods like `Planet.earth.surfaceGravity()`
- **Failure:** Enhanced enum methods not accessible at runtime.
- **Issue:** GEN-041

---

#### TOP11: Enhanced enum (implements)

Enhanced enums that implement interfaces should have their interface methods bridged.

**Coverage test:** `top11_enhanced_enum_implements.dart` — FAILED
- Tests enum implementing an interface.
- **Failure:** Enhanced enum fields/methods not accessible at runtime.
- **Issue:** GEN-041

---

#### TOP12: Enhanced enum (with mixin)

Enhanced enums using mixins should have the mixed-in members accessible.

**Coverage test:** `top12_enhanced_enum_mixin.dart` — FAILED
- Tests enum with mixin.
- **Failure:** Enhanced enum members not accessible at runtime.
- **Issue:** GEN-041

---

#### TOP13: Generic enum

Enums with generic type parameters (if supported by Dart). Rare use case.

**Coverage test:** —
**Status:** Not yet tested.

---

#### TOP14: Mixin

Standard mixin declarations should be registerable and their members accessible when mixed into bridged classes.

**Coverage test:** `top14_mixin.dart` — PASSED
- Tests mixin registration and member access on classes that use the mixin.

---

#### TOP15: Base mixin

Base mixins restrict usage outside their library. Bridge generator should handle the `base mixin` declaration.

**Coverage test:** —
**Status:** Not yet tested.

---

#### TOP16: Named extension

Named extensions add methods to existing types. Bridge generator should expose extension methods on the target type.

**Coverage test:** —
**Status:** Not yet tested.

---

#### TOP17: Anonymous extension

Anonymous extensions (no name) add methods but cannot be explicitly referenced. Generator behavior may differ.

**Coverage test:** —
**Status:** Not yet tested.

---

#### TOP18: Extension type

Extension types (Dart 3.3+) provide zero-cost wrappers. Bridge generator should handle the `extension type` declaration.

**Coverage test:** —
**Status:** Not yet tested.

---

#### TOP19: Typedef (function)

Function typedefs like `typedef Compare = int Function(Object a, Object b)` should be recognized for parameter type resolution.

**Coverage test:** —
**Status:** Not yet tested.

---

#### TOP20: Typedef (type alias)

Type aliases like `typedef StringList = List<String>` should resolve to their underlying types during bridging.

**Coverage test:** —
**Status:** Not yet tested.

---

#### TOP21: Typedef (generic)

Generic typedefs like `typedef Json<T> = Map<String, T>` should resolve with concrete type arguments.

**Coverage test:** —
**Status:** Not yet tested.

---

#### TOP22: Top-level function

Top-level functions are bridged as global callables in D4rt.

**Coverage test:** `top22_toplevel_function.dart` — PASSED
- Tests calling top-level functions and verifying return values.

**Tested in:** userbridge_override, dart_overview

---

#### TOP23: Top-level generic function

Top-level functions with generic type parameters are subject to type erasure (GEN-001).

**Coverage test:** —
**Status:** Not yet tested.

---

#### TOP24: Top-level async function

Top-level `async` functions returning `Future<T>`. Requires async bridge support.

**Coverage test:** —
**Status:** Not yet tested.

---

#### TOP25: Top-level variable

Top-level `var` and `final` variables are bridged as readable/writable globals.

**Coverage test:** `top25_toplevel_variable.dart` — PASSED
- Tests reading and writing top-level variables from D4rt scripts.

**Tested in:** userbridge_override (via e2e test)

---

#### TOP26: Top-level const

Top-level `const` values are bridged as read-only globals.

**Coverage test:** `top26_toplevel_const.dart` — PASSED
- Tests reading top-level const values from D4rt scripts.

**Tested in:** userbridge_override (via e2e test)

---

#### TOP27: Top-level getter

Explicit top-level getters (`get x => ...`).

**Coverage test:** `top27_toplevel_getter.dart` — PASSED
- Tests reading explicit top-level getters from D4rt scripts.

---

#### TOP28: Top-level setter

Explicit top-level setters (`set x(value) => ...`).

**Coverage test:** —
**Status:** Not yet tested.

**UB design gap:** The user bridge override design (`userbridge_override_design.md`) defines `overrideGlobalVariable`, `overrideGlobalGetter`, and `overrideGlobalFunction` but does **not** define an `overrideGlobalSetter{Name}` pattern. This is a design gap — top-level setter overrides should be added to the design.

---

#### TOP29: Mixin application

Mixin application shorthand: `class C = S with M;`

**Coverage test:** —
**Status:** Not yet tested.

---

### Class Members

#### CLS01: Instance field (getter)

Instance fields on bridged classes are readable via getter bridges.

**Coverage test:** `cls01_field_getter.dart` — PASSED
- Reads fields like `dog.name`, `circle.radius` after construction.

**Tested in:** example_project, user_guide, user_reference, dart_overview, userbridge_user_guide

---

#### CLS02: Instance field (setter)

Mutable instance fields are writable via setter bridges.

**Coverage test:** `cls02_field_setter.dart` — PASSED
- Sets fields and verifies the new values.

**Tested in:** dart_overview

---

#### CLS03: Final field

Final fields are readable but not writable. Setter should not be generated.

**Coverage test:** `cls03_final_field.dart` — PASSED
- Reads final fields, confirms values match constructor arguments.

**Tested in:** user_guide, dart_overview, userbridge_user_guide

---

#### CLS04: Private field with public getter

Private fields (`_x`) with explicit public getters (`get x => _x`) should only expose the getter.

**Coverage test:** `cls04_private_field_getter.dart` — PASSED
- Reads value via public getter, confirms private field is not directly accessible.

**Tested in:** dart_overview

---

#### CLS05: Nullable field

Fields declared with nullable types (`String? name`).

**Coverage test:** —
**Status:** Not yet tested.

---

#### CLS06: Late field

Fields declared with `late` modifier.

**Coverage test:** —
**Status:** Not yet tested.

---

#### CLS07: Static field (mutable)

Static fields that can be read and written.

**Coverage test:** `cls07_static_field.dart` — PASSED
- Tests reading and writing static fields on bridged classes.

**UB override:** `overrideStaticGetter{Name}` / `overrideStaticSetter{Name}` — static fields are bridged as getter/setter pairs and can be overridden via the static getter/setter override pattern.

---

#### CLS08: Static const field

Static const fields are bridged as read-only class-level values.

**Coverage test:** `cls08_static_const.dart` — PASSED
- Reads `ClassName.constField` and verifies value.

**Tested in:** example_project, dart_overview

---

#### CLS09: Computed getter

Computed getters (`get area => radius * radius * pi`) return derived values.

**Coverage test:** `cls09_computed_getter.dart` — PASSED
- Calls computed getter and verifies the calculated result.

**Tested in:** user_reference, dart_overview, userbridge_user_guide

---

#### CLS10: Explicit setter

Explicit setters (`set x(value)`) distinct from field setters.

**Coverage test:** `cls10_explicit_setter.dart` — PASSED
- Sets value via explicit setter, reads back via getter.

**Tested in:** dart_overview

---

#### CLS11: Static method

Static methods are callable on the class without an instance.

**Coverage test:** `cls11_static_method.dart` — PASSED
- Tests calling static methods on bridged classes.

**UB override:** `overrideStaticMethod{Name}` — static methods can be overridden via the static method override pattern.

**Tested in:** example_project, user_guide, user_reference (via e2e tests)

---

#### CLS12: Static getter

Explicit static getters on classes.

**Coverage test:** —
**Status:** Not yet tested.

**UB override:** `overrideStaticGetter{Name}` — static getters can be overridden via the static getter override pattern.

---

#### CLS13: Static setter

Explicit static setters on classes.

**Coverage test:** —
**Status:** Not yet tested.

**UB override:** `overrideStaticSetter{Name}` — static setters can be overridden via the static setter override pattern.

---

#### CLS14: Instance method

Instance methods are the most common bridge target.

**Coverage test:** `cls14_instance_method.dart` — PASSED
- Calls instance methods with various argument types, verifies return values.

**Tested in:** all projects, dart_overview

---

#### CLS15: Abstract method

Abstract methods on abstract classes — verified through concrete subclass instances.

**Coverage test:** `cls15_abstract_method.dart` — FAILED
- Tests abstract method invocation via concrete subclass.
- **Failure:** Implicit default constructor on concrete subclass not bridged.
- **Issue:** GEN-042

---

#### CLS16: toString() override

Custom `toString()` overrides should be callable and return the expected string.

**Coverage test:** `cls16_tostring.dart` — PASSED
- Calls `toString()` on bridged instances, verifies custom formatting.

**Tested in:** dart_overview, userbridge_user_guide

---

#### CLS17: call() method

Classes with a `call()` method should be callable as functions.

**Coverage test:** —
**Status:** Not yet tested.

---

### Constructors

#### CTOR01: Unnamed constructor

Explicit unnamed constructors (`ClassName(args)`) are the most common pattern.

**Coverage test:** `ctor01_unnamed.dart` — PASSED
- Constructs instances using unnamed constructor, verifies field values.

**Tested in:** example_project, user_guide, dart_overview, userbridge_user_guide

---

#### CTOR02: Implicit default constructor

Classes with no explicit constructor should still be constructible. The generator currently does not emit a bridge for implicit default constructors.

**Coverage test:** `ctor02_implicit_default.dart` — FAILED
- Attempts `Stack()` and `Queue()` — fails because no constructor bridge is generated.
- **Issue:** GEN-042

---

#### CTOR03: Named constructor

Named constructors (`ClassName.fromX(args)`) provide alternative construction paths.

**Coverage test:** `ctor03_named.dart` — PASSED
- Constructs instances using named constructors, verifies field values.

**Tested in:** example_project, user_guide, dart_overview, userbridge_user_guide

---

#### CTOR04: Factory constructor

Factory constructors (`factory ClassName(args)`) may return cached instances or subtypes.

**Coverage test:** `ctor04_factory.dart` — PASSED
- Calls factory constructor, verifies the returned instance.

**Tested in:** dart_overview

---

#### CTOR05: Const constructor

Const constructors allow compile-time constant creation. Bridge behavior with const may differ.

**Coverage test:** `ctor05_const.dart` — PASSED
- Tests const constructor invocation and field access on the resulting instance.

---

#### CTOR06: Redirecting constructor

Redirecting constructors (`ClassName.x() : this(args)`) delegate to another constructor.

**Coverage test:** `ctor06_redirecting.dart` — PASSED
- Tests redirecting constructor invocation and verifies fields are set correctly.

---

#### CTOR07: Private constructor

Private constructors (`ClassName._()`) should not be bridged.

**Coverage test:** `ctor07_private.dart` — PASSED
- Tests that private constructors are not exposed in the bridge and public factory alternatives work.

---

#### CTOR08: Super parameters

Dart 3.0 super parameters (`super.x`) in subclass constructors.

**Coverage test:** `ctor08_super_params.dart` — PASSED
- Tests subclass construction with super parameters and verifies inherited fields.

---

### Operators

#### OP01: Operator plus

`operator +` bridged via user bridge.

**Coverage test:** —
**Tested in:** userbridge_user_guide (via e2e test, user bridge)

---

#### OP02: Operator minus (binary)

`operator -` (binary subtraction) bridged via user bridge.

**Coverage test:** —
**Tested in:** userbridge_user_guide (via e2e test, user bridge)

---

#### OP03: Operator minus (unary)

Unary negation (`operator -()` with no parameters).

**Coverage test:** —
**Tested in:** userbridge_user_guide (via e2e test, user bridge)

---

#### OP04: Operator multiply

`operator *` bridged via user bridge.

**Coverage test:** —
**Tested in:** userbridge_user_guide (via e2e test, user bridge)

---

#### OP05: Operator divide

`operator /` (double division).

**Coverage test:** —
**Status:** Not yet tested.

---

#### OP06: Operator integer divide

`operator ~/` (integer division).

**Coverage test:** —
**Status:** Not yet tested.

---

#### OP07: Operator modulo

`operator %` (modulo).

**Coverage test:** —
**Status:** Not yet tested.

---

#### OP08: Operator equals

`operator ==` (equality). May interact with `hashCode`.

**Coverage test:** —
**Status:** Not yet tested.

---

#### OP09: Comparison operators

`operator <`, `>`, `<=`, `>=`. Typically seen on `Comparable` types.

**Coverage test:** —
**Status:** Not yet tested.

---

#### OP10: Operator index

`operator []` (index access) bridged via user bridge.

**Coverage test:** —
**Tested in:** userbridge_user_guide (via e2e test, user bridge)

---

#### OP11: Operator index assign

`operator []=` (index assignment) bridged via user bridge.

**Coverage test:** —
**Tested in:** userbridge_user_guide (via e2e test, user bridge)

---

#### OP12: Bitwise operators

`operator &`, `|`, `^`, `<<`, `>>`, `>>>`.

**Coverage test:** —
**Status:** Not yet tested.

---

### Parameters

#### PAR01: Required positional

Required positional parameters are the most basic parameter type.

**Coverage test:** `par01_required_positional.dart` — PASSED
- Calls methods/constructors with required positional args, verifies behavior.

**Tested in:** example_project, user_guide, dart_overview

---

#### PAR02: Optional positional

Optional positional parameters (`[int x = 0]`).

**Coverage test:** —
**Tested in:** example_project (via e2e test)

---

#### PAR03: Named parameters

Named parameters (`{String name = 'default'}`).

**Coverage test:** `par03_named_params.dart` — PASSED
- Calls methods with named params, verifies defaults and overrides.

**Tested in:** user_reference, userbridge_override, dart_overview

---

#### PAR04: Required named

Required named parameters (`{required String name}`).

**Coverage test:** —
**Tested in:** user_reference (via e2e test)

---

#### PAR05: Default values

Default values for optional and named parameters.

**Coverage test:** —
**Tested in:** example_project, userbridge_override (via e2e tests)

**Note:** Complex default values cannot be represented in generated code (GEN-003).

---

#### PAR06: Function-typed parameter

Parameters with function types (`void Function(int) callback`).

**Coverage test:** —
**Status:** Not yet tested. Related to GEN-005 (function types inside collections).

---

### Generics

#### GNRC01: Generic class (single)

Generic classes with a single type parameter (e.g., `Box<T>`).

**Coverage test:** `gnrc01_single_type_param.dart` — PASSED
- Creates `Box<int>`, `Box<String>`, verifies generic field access.

**Tested in:** dart_overview, userbridge_override

---

#### GNRC02: Generic class (two params)

Generic classes with two type parameters (e.g., `Pair<A, B>`).

**Coverage test:** `gnrc02_two_type_params.dart` — PASSED
- Creates `Pair<int, String>`, verifies both fields.

**Tested in:** dart_overview

---

#### GNRC03: Upper bound

Generic type with upper bound (`T extends Comparable<T>`).

**Coverage test:** —
**Status:** Not yet tested. Related to GEN-002 (recursive bound dispatch).

---

#### GNRC04: Generic method

Methods with their own type parameters (`T convert<T>(value)`).

**Coverage test:** `gnrc04_generic_method.dart` — PASSED
- Calls generic methods, verifies return values (type-erased to dynamic per GEN-001).

**Tested in:** dart_overview

---

#### GNRC05: Generic static factory

Static factory methods with generic return types.

**Coverage test:** —
**Status:** Not yet tested.

---

#### GNRC06: Generic collection (implicit default ctor)

Generic collection classes (e.g., `Stack<T>`, `Queue<T>`) that rely on implicit default constructors. Tests the intersection of generics and implicit constructor bridging.

**Coverage test:** `gnrc06_generic_collection.dart` — FAILED
- Attempts `Stack()` and `Queue()` — fails because implicit default constructors are not bridged.
- **Issue:** GEN-042 (same root cause as CTOR02)

**Note:** This test exercises the combination of GNRC01 (single-type-param generic class) and CTOR02 (implicit default constructor). The failure is due to CTOR02/GEN-042, not a generics issue.

---

#### GNRC07: F-bounded polymorphism

F-bounded types like `class Comparable<T extends Comparable<T>>`. Related to GEN-002 (recursive type bounds).

**Coverage test:** —
**Status:** Not yet tested.

---

### Inheritance

#### INH01: Single-level extends

Simple single-level `extends` (e.g., `class Dog extends Animal`).

**Coverage test:** `inh01_single_extends.dart` — PASSED
- Tests subclass construction, field access, and inherited method calls.

**Tested in:** example_project, dart_overview (via e2e tests — subclass fields/methods work)

---

#### INH02: Multi-level extends

Multi-level inheritance chain (e.g., `GrandChild extends Child extends Parent`).

**Coverage test:** `inh02_multi_extends.dart` — FAILED
- Tests multi-level inheritance chain with field and method access at each level.
- **Failure:** Implicit default constructor on intermediate class not bridged.
- **Issue:** GEN-042

---

#### INH03: Implements (interface)

Classes implementing interfaces (`class X implements Y`).

**Coverage test:** `inh03_implements.dart` — FAILED
- Tests class implementing interface with method access.
- **Failure:** Implicit default constructor on implementing class not bridged.
- **Issue:** GEN-042

---

#### INH04: Mixin with

Classes using mixins (`class X with M`).

**Coverage test:** `inh04_mixin_with.dart` — FAILED
- Tests class with mixin, verifying mixin member access.
- **Failure:** Implicit default constructor on class using mixin not bridged.
- **Issue:** GEN-042

---

#### INH05: Super constructor call

Subclass constructors calling `super(args)` or `super.named(args)`.

**Coverage test:** `inh05_super_ctor.dart` — PASSED
- Tests subclass construction with super constructor call and verifies inherited fields.

---

#### INH06: Method override

Subclass overriding a parent method (`@override`).

**Coverage test:** `inh06_method_override.dart` — PASSED
- Tests that overridden method returns subclass-specific behavior.

---

### User Bridges

#### UBR01: User bridge class (basic)

User bridge classes provide custom D4rt bindings for types the generator cannot fully handle.

**Coverage test:** —
**Tested in:** userbridge_user_guide (via e2e test)

---

#### UBR02: User bridge method override

User bridges can override generated method bridges with custom implementations.

**Coverage test:** —
**Tested in:** userbridge_override (via e2e test)

---

#### UBR03: User bridge field override

User bridges can override generated field getters/setters.

**Coverage test:** —
**Tested in:** userbridge_override (via e2e test)

---

#### UBR04: User bridge operator

User bridges can define operators (e.g., `+`, `-`, `[]`, `[]=`) on bridged types.

**Coverage test:** —
**Tested in:** userbridge_user_guide (via e2e test)

---

#### UBR05: User bridge constructor

User bridges can define constructors for bridged types.

**Coverage test:** —
**Tested in:** userbridge_user_guide (via e2e test)

---

#### UBR06: User bridge import prefix

User bridge generated references must use the correct import prefix (`$pkg.`). Previously broken (GEN-043, now fixed).

**Coverage test:** —
**Tested in:** userbridge_user_guide (via e2e test)
**Issue:** GEN-043 (fixed)

---

### Async & Streams

#### ASYNC01: Async function (Future)

Functions returning `Future<T>`. The D4rt **interpreter** supports `async`/`await` natively. The question is whether the **generator** correctly bridges async functions so they can be called from D4rt scripts.

**Generator requirement:** The generator needs to emit bridge adapters that return `Future<T>` and allow the interpreter's `await` to resolve them. Since async functions return a `Future` on the host side, the bridge adapter must either:
- Return the `Future` directly (letting D4rt's interpreter `await` it), or
- Wrap the host call in an async adapter that the interpreter can `await`.

**Coverage test:** `async01_async_function` — FAILED
- Tests `fetchGreeting('World')` and `computeSum([10, 20, 30])` with `await`.
- **Failure:** The bridge does not properly handle `List<int>` parameter coercion (interpreter passes `List<Object?>` instead of `List<int>`).
- **Root cause:** Parameter type coercion issue, not async-specific. The async call mechanism itself may work if parameter types are resolved.
**Status:** ⚠️ Tested, failing (parameter coercion issue)

---

#### ASYNC02: Async generator (Stream)

Functions using `async*` yielding `Stream<T>`. The D4rt **interpreter** supports `await for` loops. The **generator** needs to bridge `async*` functions so they return `Stream<T>` that the interpreter can consume.

**Generator requirement:** The bridge adapter for an `async*` function must return a `Stream` that the interpreter can iterate with `await for`. Since the host function already returns `Stream<T>`, the bridge adapter should pass it through.

**Coverage test:** `async02_async_generator` — FAILED
- Tests `countAsyncTo(3)` with `await for` loop.
- **Failure:** Similar parameter type issue — the bridge may not correctly handle the function or the `await for` consumption of the stream result.
**Status:** ⚠️ Tested, failing

---

#### ASYNC03: Sync generator (Iterable)

Functions using `sync*` yielding `Iterable<T>`. The D4rt **interpreter** supports `for-in` loops over iterables. The **generator** needs to bridge `sync*` functions so they return `Iterable<T>` that the interpreter can iterate.

**Generator requirement:** The bridge adapter for a `sync*` function must return an `Iterable` that the interpreter can iterate with `for-in`. Since the host function already returns `Iterable<T>`, the bridge adapter should pass it through.

**Coverage test:** `async03_sync_generator` — FAILED
- Tests `countTo(5)`, `range(3, 7)`, `naturalNumbers` (take 5), `fibonacci` (take 8).
- **Failure:** The bridge does not properly handle generator functions. Likely the return type or lazy iteration semantics are not bridged correctly.
**Status:** ⚠️ Tested, failing

---

#### ASYNC04: Callback parameter (Function)

Passing callback functions from D4rt into bridged host methods. This requires the bridge adapter to accept an `InterpretedFunction` from the D4rt interpreter and convert it to a native Dart function type that the host method expects.

**Generator requirement:** When a bridged function has a `Function` parameter (e.g., `void transform(List<int> items, int Function(int) mapper)`), the bridge must wrap the interpreter's callback so the host can call it. This is a known limitation (GEN-005).

**Coverage test:** `async04_callback_param` — FAILED
- Tests `transform([1,2,3], (x) => x * 2)` and `fetchData('url', (data) => ...)` with callback parameters.
- **Failure:** Function-typed parameters are not bridgeable (GEN-005).
**Status:** ⚠️ Tested, failing. Related to GEN-005.

---

### Special Types

#### TYPE01: Record type parameter

Methods/constructors accepting record types as parameters.

**Coverage test:** —
**Status:** Not yet tested. Related to GEN-025.

---

#### TYPE02: Record type return

Methods returning record types.

**Coverage test:** —
**Status:** Not yet tested. Related to GEN-025.

---

#### TYPE03: Nullable parameter

Parameters with nullable types (`String? name`).

**Coverage test:** —
**Status:** Not yet tested.

---

#### TYPE04: Nullable return

Methods returning nullable types (`String? find()`).

**Coverage test:** —
**Status:** Not yet tested.

---

#### TYPE05: Dynamic parameter / return

Methods using `dynamic` parameters or return types.

**Coverage test:** —
**Tested in:** dart_overview (implicit through type-erased generics)

---

### Visibility & Exports

#### VIS01: Barrel export filtering

Only symbols exported through barrel files should be bridged. Non-exported symbols are excluded.

**Coverage test:** —
**Tested in:** dart_overview (barrel file controls what's bridged)

---

#### VIS02: Private member exclusion

Private members (`_x`) are never bridged, only their public accessors.

**Coverage test:** —
**Tested in:** dart_overview (CLS04 verifies private field is not directly accessible)

---

#### VIS03: Show/hide combinators

Export statements with `show` or `hide` combinators should be respected by the generator.

**Coverage test:** —
**Status:** Not yet tested.

---

#### VIS04: Multi-barrel modules

Packages exporting through multiple barrel files. Previously had a bug where symbols were only registered under the primary barrel (GEN-030, now fixed).

**Coverage test:** —
**Tested in:** dart_overview (module structure uses barrel exports)
**Issue:** GEN-030 (fixed)

---

### Generator Features

#### GFEAT01: Single barrel analysis

The generator analyzes a single barrel file (e.g., `lib/pkg.dart`) and bridges all exported symbols — classes, enums, top-level functions, variables, getters, setters.

**Test:** All example projects use single-barrel analysis. Implicitly tested in every e2e run.
**Status:** ✅ Passing

---

#### GFEAT02: Multi-barrel modules

A module can specify multiple `barrelFiles`. Each barrel's exports are bridged and registered under prefixed names (`$pkg`, `$pkg2`, etc.). Previously had a bug where only the primary barrel's symbols were registered (GEN-030, now fixed).

**Test:** dart_overview (module structure with multi-barrel exports)
**Issue:** GEN-030 (fixed)
**Status:** ✅ Passing

---

#### GFEAT03: Re-export following

When `followAllReExports: true` (the default), the generator recursively follows all `export` directives from the barrel file, bridging symbols from re-exported packages. This is the standard mode used by all existing example projects.

**Test:** — (no dedicated test isolating re-export following behavior)
**Status:** ❌ Not yet tested

---

#### GFEAT04: Selective re-export

When `followAllReExports: false`, only packages listed in `followReExports` are followed. Alternatively, `skipReExports` blacklists specific packages while following all others. Previously broken (GEN-028, now fixed).

**Test:** — (no test exercises whitelist/blacklist mode)
**Issue:** GEN-028 (fixed)
**Status:** ❌ Not yet tested

---

#### GFEAT05: Element exclusion

Per-module `excludeClasses`, `excludeEnums`, `excludeFunctions`, and `excludeVariables` lists allow specific symbols to be excluded from bridging. Config parsing is tested, but generation-time filtering is not.

**Test:** —
**Status:** ❌ Not yet tested

---

#### GFEAT06: Source pattern exclusion

`excludeSourcePatterns` takes glob patterns on source URIs (e.g., `**/generated/**`), optionally with `#symbol` selectors for fine-grained filtering. Config parsing is tested, but glob matching behavior is not.

**Test:** —
**Status:** ❌ Not yet tested

---

#### GFEAT07: Deprecated element filtering

`generateDeprecatedElements: false` (the default) causes the generator to skip elements annotated with `@deprecated`. Setting it to `true` includes them.

**Test:** —
**Status:** ❌ Not yet tested

---

#### GFEAT08: Import show/hide clauses

`importShowClause` and `importHideClause` control which symbols the generated barrel import exposes to D4rt scripts. Useful for restricting the visible API surface.

**Test:** —
**Status:** ❌ Not yet tested

---

#### GFEAT09: Cross-package type resolution

When a bridged class uses a type from an external package (listed in `followPackages`), the generator records it as an `ExternalTypeDependency` and attempts to resolve it via `package_config.json`, sibling directories, or pubspec path dependencies.

This is a critical feature for producing a **complete, working closure** of bridged types: the generator should ideally trace all types it encounters, follow them to their source packages, and include the needed types so the bridge set is self-contained. Current limitations:

- **No configurable recursion depth** — tracing follows `followPackages` one level deep, but doesn't recursively trace into those packages' own dependencies.
- **No transitive closure** — the generator doesn't compute a full transitive closure of all reachable types. Types used only in deeply nested generic arguments may be missed.
- **Hardcoded external package list** (GEN-010) — `_complexExternalPackages` is fixed, not configurable.
- **Missing export fallback** (GEN-017) — types not in the barrel and not resolvable via auxiliary imports silently become `dynamic`.

**Ideal behavior:** The generator should automatically detect all types needed for a complete bridge closure by following types to their packages, with a configurable recursion depth limit and warnings when the closure captures too many types.

**Test:** —
**Status:** ❌ Not yet tested

---

#### GFEAT10: External bridge imports

`importedBridges` lists external bridge packages to import and register. This allows composing bridges from multiple generator runs (e.g., `tom_dartscript_bridges` importing bridges from `tom_core`).

**Test:** — (used in production but no dedicated test)
**Status:** ❌ Not yet tested

---

#### GFEAT11: Library path deduplication

`libraryPath` specifies a central directory for per-package bridge files, eliminating duplication when multiple modules bridge the same package.

**Test:** —
**Status:** ❌ Not yet tested

---

#### GFEAT12: Config precedence

Configuration comes from four sources with a defined precedence order: CLI arguments > `tom_project.yaml` > `build.yaml` (`d4rtgen:` section) > `d4rt_bridging.json` (legacy). Higher-precedence sources override lower ones.

**Test:** —
**Issue:** GEN-024
**Status:** ❌ Not yet tested

---

#### GFEAT13: User bridge scanner

The generator detects classes extending `D4UserBridge` with the `@D4rtUserBridge` annotation and wires their override methods into the generated bridge code. Print markers verify user bridge code runs instead of generated code.

**Test:** e2e: userbridge_user_guide, userbridge_override
**Issue:** GEN-043 (fixed — import prefix)
**Status:** ✅ Passing

---

#### GFEAT14: Barrel name collision

When two classes with the same name come from different source files (e.g., `Animal` from both `mixins/basics` and `classes/inheritance`), the generator should detect the collision and either use import aliasing or emit a warning. Currently one of the classes is silently dropped.

**Test:** — (GEN-045 test is skipped)
**Issue:** GEN-045
**Status:** ❌ Not yet tested (blocked)

---

#### GFEAT15: Recursive type bound dispatch

Types like `T extends Comparable<T>` (F-bounded polymorphism) need special runtime dispatch. The generator creates combinatorial dispatch for a configurable set of `recursiveBoundTypes` (default: `[num, String, DateTime]`).

**Test:** —
**Issue:** GEN-002
**Status:** ❌ Not yet tested

---

#### GFEAT16: Missing export warnings

When a type is used in a bridged class but isn't exported from the barrel, the generator emits a warning and downgrades the type to `dynamic`. The warnings are collected in `_missingExportWarnings` and `externalTypeWarnings`.

**Test:** — (no test validates that warnings are emitted correctly)
**Issue:** GEN-017
**Status:** ❌ Not yet tested

---

#### GFEAT17: `.b.dart` extension normalization

The `ensureBDartExtension()` helper ensures all generated output files use the `.b.dart` extension convention.

**Test:** —
**Issue:** GEN-037 (fixed)
**Status:** ❌ Not yet tested

---

#### GFEAT18: Test runner generation

`generateTestRunner: true` produces a `d4rtrun.b.dart` file with `--test`, `--eval`, and `--run` modes for executing D4rt scripts against the generated bridges.

**Test:** All example projects generate and use test runners. Implicitly tested in every e2e run.
**Status:** ✅ Passing

---

## Referenced Issues

| Issue | Description | Features Affected |
|-------|-------------|-------------------|
| GEN-001 | Generic methods lose type parameters (type erasure) | GNRC04, TOP23 |
| GEN-002 | Recursive type bounds dispatched to only 3 types | GNRC03, GNRC07 |
| GEN-003 | Complex default values cannot be represented | PAR05 |
| GEN-005 | Function types inside collections are unbridgeable | PAR06, ASYNC04 |
| GEN-025 | Record types with nested functions may have edge cases | TYPE01, TYPE02 |
| GEN-030 | Multi-barrel modules only registered under primary barrel (fixed) | VIS04 |
| GEN-041 | Enhanced enum fields not accessible via bridges at runtime | TOP09, TOP10, TOP11, TOP12 |
| GEN-042 | Classes with implicit default constructors are not bridged | CTOR02, GNRC06, TOP02, TOP05, TOP07, CLS15, INH02, INH03, INH04 |
| GEN-043 | Generated user bridge references lack import prefix (fixed) | UBR06 |
| GEN-044 | Simple enum `.values` static getter not bridged | TOP08 |
