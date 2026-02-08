# D4rt Bridge Generator — Test Coverage

This document tracks bridge generator features and the tests that verify them. It serves as a living inventory to identify coverage gaps and guide future test development.

**Test infrastructure:** See `_copilot_guidelines/testing_d4rt_bridges.md` for the D4rtTester architecture and test conventions.

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

---

## Overview Tables

**Status legend:**

| Symbol | Meaning |
|--------|---------|
| ✅ | Tested and passing |
| ⚠️ | Tested but failing (known bug) |
| ❌ | Not yet tested |
| 🔲 | Not yet relevant (interpreter support needed first) |

---

### Top-Level Exportables (29 features)

| ID | Feature | Status | Test Project | Issue | Details |
|----|---------|--------|--------------|-------|---------|
| TOP01 | Class (concrete) | ✅ | example_project, user_guide, user_reference, dart_overview, userbridge_user_guide | | [→](#top01-class-concrete) |
| TOP02 | Abstract class | ❌ | — | | [→](#top02-abstract-class) |
| TOP03 | Sealed class | ❌ | — | | [→](#top03-sealed-class) |
| TOP04 | Base class | ❌ | — | | [→](#top04-base-class) |
| TOP05 | Interface class | ❌ | — | | [→](#top05-interface-class) |
| TOP06 | Final class | ❌ | — | | [→](#top06-final-class) |
| TOP07 | Mixin class | ❌ | — | | [→](#top07-mixin-class) |
| TOP08 | Simple enum | ⚠️ | dart_overview | GEN-044 | [→](#top08-simple-enum) |
| TOP09 | Enhanced enum (fields) | ⚠️ | example_project, dart_overview | GEN-041 | [→](#top09-enhanced-enum-fields) |
| TOP10 | Enhanced enum (methods) | ⚠️ | dart_overview | GEN-041 | [→](#top10-enhanced-enum-methods) |
| TOP11 | Enhanced enum (implements) | ⚠️ | dart_overview | GEN-041 | [→](#top11-enhanced-enum-implements) |
| TOP12 | Enhanced enum (with mixin) | ⚠️ | dart_overview | GEN-041 | [→](#top12-enhanced-enum-with-mixin) |
| TOP13 | Generic enum | ❌ | — | | [→](#top13-generic-enum) |
| TOP14 | Mixin | ❌ | — | | [→](#top14-mixin) |
| TOP15 | Base mixin | ❌ | — | | [→](#top15-base-mixin) |
| TOP16 | Named extension | ❌ | — | | [→](#top16-named-extension) |
| TOP17 | Anonymous extension | ❌ | — | | [→](#top17-anonymous-extension) |
| TOP18 | Extension type | ❌ | — | | [→](#top18-extension-type) |
| TOP19 | Typedef (function) | ❌ | — | | [→](#top19-typedef-function) |
| TOP20 | Typedef (type alias) | ❌ | — | | [→](#top20-typedef-type-alias) |
| TOP21 | Typedef (generic) | ❌ | — | | [→](#top21-typedef-generic) |
| TOP22 | Top-level function | ✅ | userbridge_override, dart_overview | | [→](#top22-top-level-function) |
| TOP23 | Top-level generic function | ❌ | — | | [→](#top23-top-level-generic-function) |
| TOP24 | Top-level async function | ❌ | — | | [→](#top24-top-level-async-function) |
| TOP25 | Top-level variable (var/final) | ✅ | userbridge_override | | [→](#top25-top-level-variable) |
| TOP26 | Top-level const | ✅ | userbridge_override | | [→](#top26-top-level-const) |
| TOP27 | Top-level getter | ❌ | — | | [→](#top27-top-level-getter) |
| TOP28 | Top-level setter | ❌ | — | | [→](#top28-top-level-setter) |
| TOP29 | Mixin application (`class = with`) | ❌ | — | | [→](#top29-mixin-application) |

### Class Members (17 features)

| ID | Feature | Status | Test Project | Issue | Details |
|----|---------|--------|--------------|-------|---------|
| CLS01 | Instance field (getter) | ✅ | example_project, user_guide, user_reference, dart_overview, userbridge_user_guide | | [→](#cls01-instance-field-getter) |
| CLS02 | Instance field (setter) | ✅ | dart_overview | | [→](#cls02-instance-field-setter) |
| CLS03 | Final field | ✅ | user_guide, dart_overview, userbridge_user_guide | | [→](#cls03-final-field) |
| CLS04 | Private field with public getter | ✅ | dart_overview | | [→](#cls04-private-field-with-public-getter) |
| CLS05 | Nullable field | ❌ | — | | [→](#cls05-nullable-field) |
| CLS06 | Late field | ❌ | — | | [→](#cls06-late-field) |
| CLS07 | Static field (mutable) | ❌ | — | | [→](#cls07-static-field-mutable) |
| CLS08 | Static const field | ✅ | example_project, dart_overview | | [→](#cls08-static-const-field) |
| CLS09 | Computed getter | ✅ | user_reference, dart_overview, userbridge_user_guide | | [→](#cls09-computed-getter) |
| CLS10 | Explicit setter (`set x`) | ✅ | dart_overview | | [→](#cls10-explicit-setter) |
| CLS11 | Static method | ✅ | example_project, user_guide, user_reference | | [→](#cls11-static-method) |
| CLS12 | Static getter | ❌ | — | | [→](#cls12-static-getter) |
| CLS13 | Static setter | ❌ | — | | [→](#cls13-static-setter) |
| CLS14 | Instance method | ✅ | all projects, dart_overview | | [→](#cls14-instance-method) |
| CLS15 | Abstract method | ❌ | — | | [→](#cls15-abstract-method) |
| CLS16 | `toString()` override | ✅ | dart_overview, userbridge_user_guide | | [→](#cls16-tostring-override) |
| CLS17 | `call()` method | ❌ | — | | [→](#cls17-call-method) |

### Constructors (8 features)

| ID | Feature | Status | Test Project | Issue | Details |
|----|---------|--------|--------------|-------|---------|
| CTOR01 | Unnamed (default, explicit) | ✅ | example_project, user_guide, dart_overview, userbridge_user_guide | | [→](#ctor01-unnamed-constructor) |
| CTOR02 | Implicit default (no ctor) | ⚠️ | dart_overview | GEN-042 | [→](#ctor02-implicit-default-constructor) |
| CTOR03 | Named constructor | ✅ | example_project, user_guide, dart_overview, userbridge_user_guide | | [→](#ctor03-named-constructor) |
| CTOR04 | Factory constructor | ✅ | dart_overview | | [→](#ctor04-factory-constructor) |
| CTOR05 | Const constructor | ❌ | — | | [→](#ctor05-const-constructor) |
| CTOR06 | Redirecting constructor | ❌ | — | | [→](#ctor06-redirecting-constructor) |
| CTOR07 | Private constructor | ❌ | — | | [→](#ctor07-private-constructor) |
| CTOR08 | Super parameters (`super.x`) | ❌ | — | | [→](#ctor08-super-parameters) |

### Operators (12 features)

| ID | Feature | Status | Test Project | Issue | Details |
|----|---------|--------|--------------|-------|---------|
| OP01 | `operator +` | ✅ | userbridge_user_guide (user bridge) | | [→](#op01-operator-plus) |
| OP02 | `operator -` (binary) | ✅ | userbridge_user_guide (user bridge) | | [→](#op02-operator-minus-binary) |
| OP03 | `operator -` (unary) | ✅ | userbridge_user_guide (user bridge) | | [→](#op03-operator-minus-unary) |
| OP04 | `operator *` | ✅ | userbridge_user_guide (user bridge) | | [→](#op04-operator-multiply) |
| OP05 | `operator /` | ❌ | — | | [→](#op05-operator-divide) |
| OP06 | `operator ~/` | ❌ | — | | [→](#op06-operator-integer-divide) |
| OP07 | `operator %` | ❌ | — | | [→](#op07-operator-modulo) |
| OP08 | `operator ==` | ❌ | — | | [→](#op08-operator-equals) |
| OP09 | `operator <` / `>` / `<=` / `>=` | ❌ | — | | [→](#op09-comparison-operators) |
| OP10 | `operator []` | ✅ | userbridge_user_guide (user bridge) | | [→](#op10-operator-index) |
| OP11 | `operator []=` | ✅ | userbridge_user_guide (user bridge) | | [→](#op11-operator-index-assign) |
| OP12 | Bitwise operators | ❌ | — | | [→](#op12-bitwise-operators) |

### Parameters (6 features)

| ID | Feature | Status | Test Project | Issue | Details |
|----|---------|--------|--------------|-------|---------|
| PAR01 | Required positional | ✅ | example_project, user_guide, dart_overview | | [→](#par01-required-positional) |
| PAR02 | Optional positional | ✅ | example_project | | [→](#par02-optional-positional) |
| PAR03 | Named parameters | ✅ | user_reference, userbridge_override, dart_overview | | [→](#par03-named-parameters) |
| PAR04 | Required named (`required`) | ✅ | user_reference | | [→](#par04-required-named) |
| PAR05 | Default values | ✅ | example_project, userbridge_override | | [→](#par05-default-values) |
| PAR06 | Function-typed parameter | ❌ | — | | [→](#par06-function-typed-parameter) |

### Generics (7 features)

| ID | Feature | Status | Test Project | Issue | Details |
|----|---------|--------|--------------|-------|---------|
| GNRC01 | Generic class (single type param) | ✅ | dart_overview, userbridge_override | | [→](#gnrc01-generic-class-single) |
| GNRC02 | Generic class (two type params) | ✅ | dart_overview | | [→](#gnrc02-generic-class-two-params) |
| GNRC03 | Upper bound (`T extends X`) | ❌ | — | | [→](#gnrc03-upper-bound) |
| GNRC04 | Generic method | ✅ | dart_overview | | [→](#gnrc04-generic-method) |
| GNRC05 | Generic static factory | ❌ | — | | [→](#gnrc05-generic-static-factory) |
| GNRC06 | Generic collection (implicit default ctor) | ⚠️ | dart_overview | GEN-042 | [→](#gnrc06-generic-collection-implicit-default-ctor) |
| GNRC07 | F-bounded polymorphism | ❌ | — | | [→](#gnrc07-f-bounded-polymorphism) |

### Inheritance (6 features)

| ID | Feature | Status | Test Project | Issue | Details |
|----|---------|--------|--------------|-------|---------|
| INH01 | Single-level extends | ✅ | example_project, dart_overview | | [→](#inh01-single-level-extends) |
| INH02 | Multi-level extends | ❌ | — | | [→](#inh02-multi-level-extends) |
| INH03 | Implements (interface) | ❌ | — | | [→](#inh03-implements-interface) |
| INH04 | Mixin with (`with`) | ❌ | — | | [→](#inh04-mixin-with) |
| INH05 | Super constructor call | ❌ | — | | [→](#inh05-super-constructor-call) |
| INH06 | Method override | ❌ | — | | [→](#inh06-method-override) |

### User Bridges (6 features)

| ID | Feature | Status | Test Project | Issue | Details |
|----|---------|--------|--------------|-------|---------|
| UBR01 | User bridge class (basic) | ✅ | userbridge_user_guide | | [→](#ubr01-user-bridge-class-basic) |
| UBR02 | User bridge method override | ✅ | userbridge_override | | [→](#ubr02-user-bridge-method-override) |
| UBR03 | User bridge field override | ✅ | userbridge_override | | [→](#ubr03-user-bridge-field-override) |
| UBR04 | User bridge operator | ✅ | userbridge_user_guide | | [→](#ubr04-user-bridge-operator) |
| UBR05 | User bridge constructor | ✅ | userbridge_user_guide | | [→](#ubr05-user-bridge-constructor) |
| UBR06 | User bridge import prefix | ✅ | userbridge_user_guide | GEN-043 (fixed) | [→](#ubr06-user-bridge-import-prefix) |

### Async & Streams (4 features)

| ID | Feature | Status | Test Project | Issue | Details |
|----|---------|--------|--------------|-------|---------|
| ASYNC01 | Async function (Future) | 🔲 | — | | [→](#async01-async-function-future) |
| ASYNC02 | Async* generator (Stream) | 🔲 | — | | [→](#async02-async-generator-stream) |
| ASYNC03 | Sync* generator (Iterable) | 🔲 | — | | [→](#async03-sync-generator-iterable) |
| ASYNC04 | Callback parameter (Function) | ❌ | — | | [→](#async04-callback-parameter-function) |

### Special Types (5 features)

| ID | Feature | Status | Test Project | Issue | Details |
|----|---------|--------|--------------|-------|---------|
| TYPE01 | Record type parameter | ❌ | — | | [→](#type01-record-type-parameter) |
| TYPE02 | Record type return | ❌ | — | | [→](#type02-record-type-return) |
| TYPE03 | Nullable parameter | ❌ | — | | [→](#type03-nullable-parameter) |
| TYPE04 | Nullable return | ❌ | — | | [→](#type04-nullable-return) |
| TYPE05 | `dynamic` parameter / return | ✅ | dart_overview | | [→](#type05-dynamic-parameter--return) |

### Visibility & Exports (4 features)

| ID | Feature | Status | Test Project | Issue | Details |
|----|---------|--------|--------------|-------|---------|
| VIS01 | Barrel export filtering | ✅ | dart_overview | | [→](#vis01-barrel-export-filtering) |
| VIS02 | Private member exclusion | ✅ | dart_overview | | [→](#vis02-private-member-exclusion) |
| VIS03 | Show/hide combinators | ❌ | — | | [→](#vis03-showhide-combinators) |
| VIS04 | Multi-barrel modules | ✅ | dart_overview | GEN-030 (fixed) | [→](#vis04-multi-barrel-modules) |

---

## Coverage Summary

| Category | Total | ✅ | ⚠️ | ❌ | 🔲 |
|----------|-------|-----|------|-----|------|
| Top-Level Exportables | 29 | 4 | 5 | 20 | 0 |
| Class Members | 17 | 10 | 0 | 7 | 0 |
| Constructors | 8 | 3 | 1 | 4 | 0 |
| Operators | 12 | 6 | 0 | 6 | 0 |
| Parameters | 6 | 5 | 0 | 1 | 0 |
| Generics | 7 | 3 | 1 | 3 | 0 |
| Inheritance | 6 | 1 | 0 | 5 | 0 |
| User Bridges | 6 | 6 | 0 | 0 | 0 |
| Async & Streams | 4 | 0 | 0 | 1 | 3 |
| Special Types | 5 | 1 | 0 | 4 | 0 |
| Visibility & Exports | 4 | 3 | 0 | 1 | 0 |
| **Total** | **104** | **42** | **7** | **52** | **3** |

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

**Coverage test:** —
**Status:** Not yet tested.

---

#### TOP03: Sealed class

Sealed classes restrict the type hierarchy. Bridge generator should handle sealed modifier and exhaustive switch patterns.

**Coverage test:** —
**Status:** Not yet tested.

---

#### TOP04: Base class

Base classes restrict `implements` outside their library. Bridge generator should handle the `base` modifier.

**Coverage test:** —
**Status:** Not yet tested.

---

#### TOP05: Interface class

Interface classes restrict `extends` outside their library. Bridge generator should handle the `interface` modifier.

**Coverage test:** —
**Status:** Not yet tested.

---

#### TOP06: Final class

Final classes prevent both `extends` and `implements` outside their library. Bridge generator should handle the `final` modifier.

**Coverage test:** —
**Status:** Not yet tested.

---

#### TOP07: Mixin class

Mixin classes can be used as both classes and mixins. Bridge generator should handle the `mixin class` declaration.

**Coverage test:** —
**Status:** Not yet tested.

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

**Coverage test:** —
**Status:** Not yet tested.

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

**Coverage test:** —
**Tested in:** userbridge_override (via e2e test)

---

#### TOP26: Top-level const

Top-level `const` values are bridged as read-only globals.

**Coverage test:** —
**Tested in:** userbridge_override (via e2e test)

---

#### TOP27: Top-level getter

Explicit top-level getters (`get x => ...`).

**Coverage test:** —
**Status:** Not yet tested.

---

#### TOP28: Top-level setter

Explicit top-level setters (`set x(value) => ...`).

**Coverage test:** —
**Status:** Not yet tested.

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

**Coverage test:** —
**Status:** Not yet tested.

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

**Coverage test:** —
**Tested in:** example_project, user_guide, user_reference (via e2e tests)

---

#### CLS12: Static getter

Explicit static getters on classes.

**Coverage test:** —
**Status:** Not yet tested.

---

#### CLS13: Static setter

Explicit static setters on classes.

**Coverage test:** —
**Status:** Not yet tested.

---

#### CLS14: Instance method

Instance methods are the most common bridge target.

**Coverage test:** `cls14_instance_method.dart` — PASSED
- Calls instance methods with various argument types, verifies return values.

**Tested in:** all projects, dart_overview

---

#### CLS15: Abstract method

Abstract methods on abstract classes — verified through concrete subclass instances.

**Coverage test:** —
**Status:** Not yet tested.

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

**Coverage test:** —
**Status:** Not yet tested.

---

#### CTOR06: Redirecting constructor

Redirecting constructors (`ClassName.x() : this(args)`) delegate to another constructor.

**Coverage test:** —
**Status:** Not yet tested.

---

#### CTOR07: Private constructor

Private constructors (`ClassName._()`) should not be bridged.

**Coverage test:** —
**Status:** Not yet tested.

---

#### CTOR08: Super parameters

Dart 3.0 super parameters (`super.x`) in subclass constructors.

**Coverage test:** —
**Status:** Not yet tested.

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

**Coverage test:** —
**Tested in:** example_project, dart_overview (via e2e tests — subclass fields/methods work)

---

#### INH02: Multi-level extends

Multi-level inheritance chain (e.g., `GrandChild extends Child extends Parent`).

**Coverage test:** —
**Status:** Not yet tested.

---

#### INH03: Implements (interface)

Classes implementing interfaces (`class X implements Y`).

**Coverage test:** —
**Status:** Not yet tested.

---

#### INH04: Mixin with

Classes using mixins (`class X with M`).

**Coverage test:** —
**Status:** Not yet tested.

---

#### INH05: Super constructor call

Subclass constructors calling `super(args)` or `super.named(args)`.

**Coverage test:** —
**Status:** Not yet tested.

---

#### INH06: Method override

Subclass overriding a parent method (`@override`).

**Coverage test:** —
**Status:** Not yet tested.

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

Functions returning `Future<T>`. Requires D4rt interpreter async support.

**Coverage test:** —
**Status:** 🔲 Interpreter support needed first.

---

#### ASYNC02: Async generator (Stream)

Functions using `async*` yielding `Stream<T>`.

**Coverage test:** —
**Status:** 🔲 Interpreter support needed first.

---

#### ASYNC03: Sync generator (Iterable)

Functions using `sync*` yielding `Iterable<T>`.

**Coverage test:** —
**Status:** 🔲 Interpreter support needed first.

---

#### ASYNC04: Callback parameter (Function)

Passing callback functions from D4rt into bridged host methods.

**Coverage test:** —
**Status:** Not yet tested. Related to GEN-005.

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
| GEN-042 | Classes with implicit default constructors are not bridged | CTOR02, GNRC06 |
| GEN-043 | Generated user bridge references lack import prefix (fixed) | UBR06 |
| GEN-044 | Simple enum `.values` static getter not bridged | TOP08 |
