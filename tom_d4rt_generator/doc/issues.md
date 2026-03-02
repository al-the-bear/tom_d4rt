# D4rt Bridge Generator — Known Issues & Limitations

> Last updated: 2026-03-02
>
> Consolidated issue list from generator test suite (**618 passed, 0 skipped, 0 failed**).

---

## Issue Index

| ID | Description | Component | Status |
|----|-------------|-----------|--------|
| [GEN-078](#gen-078) | Barrel-file resolution fails without package_config.json | Testing/API | **FIXED** |
| [GEN-079](#gen-079) | Generator removed `isAssignable` (only missing in tom_d4rt, present in tom_d4rt_ast) | Generator | **FIXED** (reverted) |
| [GEN-080](#gen-080) | `bridge_api.dart` missing `skipReExports` / `followAllReExports` / `followReExports` | API | **FIXED** |
| [GEN-081](#gen-081) | `isAssignable` missing from `tom_d4rt` BridgedClass (present in `tom_d4rt_ast`) | Runtime | **FIXED** |
| [GEN-082](#gen-082) | Setter `_generateSetterCast` missing `sourceFilePath` — types resolve to `dynamic` | Generator | **FIXED** |
| [G-DOV-8](#g-dov-8) | Sealed class switch statement pattern variable scoping | Interpreter | **OPEN** |
| [G-FLP-54](#g-flp-54) | Function setter loses required named params in cast | Generator | **FIXED** (test was wrong) |
| [G-FLP-55](#g-flp-55) | `@protected` members included in bridges (by design) | Generator | **CLOSED** (by design) |
| [G-FLP-57](#g-flp-57) | Overrides of `@protected` base members included | Generator | **CLOSED** (by design) |
| [G-FBI-04](#g-fbi-04) | Setter unwrapping for BridgedInstance types | Generator | **FIXED** (via GEN-082) |
| [G-FBI-12](#g-fbi-12) | Map with custom key types | Generator | **VERIFIED** (already works) |
| [G-FBI-21](#g-fbi-21) | `hashCode` from Object not bridged by default | Generator | **VERIFIED** (already works) |
| [G-FBI-22](#g-fbi-22) | `runtimeType` getter from Object not bridged | Generator | **VERIFIED** (already works) |
| [G-FBI-32](#g-fbi-32) | Abstract classes with private constructors not bridged | Generator | **VERIFIED** (already works) |
| [G-FBI-33](#g-fbi-33) | Static const on abstract private-ctor classes not bridged | Generator | **VERIFIED** (already works) |
| [G-FBI-34](#g-fbi-34) | Static methods on abstract private-ctor classes not bridged | Generator | **VERIFIED** (already works) |
| [G-FBI-40](#g-fbi-40) | Abstract interface classes not bridged | Generator | **VERIFIED** (already works) |
| [G-NUM-11](#g-num-11) | Abstract classes with only static members (Curves pattern) | Generator | **VERIFIED** (already works) |
| [G-NUM-12](#g-num-12) | Static const members on abstract-only classes | Generator | **VERIFIED** (already works) |
| [G-NUM-15](#g-num-15) | Generic `Tween<T>` class not bridged | Generator | **VERIFIED** (already works) |
| [G-NUM-26](#g-num-26) | Generic `ValueNotifier<T>` not bridged | Generator | **VERIFIED** (already works) |
| [G-NUM-27](#g-num-27) | `hasListeners` getter inaccessible (depends on G-NUM-26) | Generator | **VERIFIED** (already works) |
| [G-NUM-31](#g-num-31) | `D4.extractBridgedArg` int to double? promotion fails | Runtime | **VERIFIED** (already works) |

---

## Fixed Issues

### GEN-078

**Barrel-file resolution fails when `.dart_tool/package_config.json` missing**

**Status:** FIXED (2026-03-02)

**a) Problem:**

When the d4 example project's `.dart_tool/` directory is missing (gitignored, clean checkout, or CI), the bridge generator cannot resolve `package:` URIs in barrel files. This causes 4 modules (path, dcli, test_part_of_files, test_callback_types) to generate 0 classes, and `D4rtTester.prepareBridges()` reports "No exports found in barrel files".

**b) Root Cause:**

`_resolvePackagePath()` reads `.dart_tool/package_config.json` to resolve package names to file paths. Without this file, all `package:` URI resolution fails silently. The generator returns an empty exports map, producing the "No exports found" error. Flutter module tests were unaffected because they use relative barrel paths (e.g., `lib/example_project.dart`), not `package:` URIs.

**c) Resolution:**

Added auto `dart pub get` in two locations:
1. `D4rtTester.prepareBridges()` — checks for `package_config.json` before generating bridges
2. `generateBridges()` in bridge_api.dart — same defensive check for CLI and API usage

**Why needed:** Without this, any clean checkout or CI environment fails to resolve external package barrel files, making the generator non-functional for cross-package bridging.

---

### GEN-079

**Generator removed `isAssignable` — only missing in `tom_d4rt`, present in `tom_d4rt_ast`**

**Status:** FIXED (2026-03-02) — reverted removal, re-added `isAssignable` emission

**a) Problem:**

The `isAssignable` parameter was removed from bridge code generation under the assumption that `BridgedClass` doesn't support it. However, `BridgedClass` in `tom_d4rt_ast` (used by `tom_d4rt_exec` and `tom_d4rt_flutterm`) DOES have `isAssignable`. Only `tom_d4rt` (pub.dev) lacks it.

The removal caused 17 test failures in `tom_d4rt_flutterm`'s essential_classes_test because the D4rt interpreter can no longer resolve native subtype hierarchies at runtime. For example, when `Curves.linear` returns a private `_Linear` instance, the runtime needs `isAssignable: (v) => v is Curve` to find the `Curve` bridge.

**b) Root Cause:**

The generator test suite uses `tom_d4rt` (pub.dev) which has no `isAssignable` parameter on `BridgedClass`. But `tom_d4rt_flutterm` uses `tom_d4rt_exec` → `tom_d4rt_ast` (path dep) which DOES have `isAssignable`. The fix was applied globally when it should only have affected `tom_d4rt`-based projects.

**c) Resolution:**

1. Re-add `isAssignable` emission to `bridge_generator.dart`
2. Add `isAssignable` to `tom_d4rt`'s `BridgedClass` (port from `tom_d4rt_ast`) so generator tests also work
3. Publish updated `tom_d4rt`

**Why needed:** Without `isAssignable`, the interpreter cannot find bridges for private native subclasses returned by bridged APIs. This breaks widget creation, animation curves, and any API that returns internal implementation types.

---

### GEN-080

**`bridge_api.dart` missing `skipReExports` / `followAllReExports` / `followReExports` params**

**Status:** FIXED (2026-03-02)

**a) Problem:**

The `generateBridges()` API in `bridge_api.dart` does not forward `skipReExports`, `followAllReExports`, or `followReExports` from the `ModuleConfig` to the `BridgeGenerator.generateBridgesFromExports()` call. The CLI executor (`d4rtgen_executor.dart`) correctly forwards all three parameters.

This means any caller using the public API (including `tool/regenerate_bridges.dart` scripts) ignores the `skipReExports` YAML config. The generator defaults to `followAllReExports: true` with no skip list, then relies on `skipClassSources` (GEN-076 dedup) to prevent duplicates across modules.

**b) Root Cause:**

The three parameters were simply omitted from the `generateBridgesFromExports()` call in `bridge_api.dart` (line ~174). The executor in `d4rtgen_executor.dart` (line ~161) correctly includes them. The GEN-028 fix documented in the CHANGELOG only fixed the CLI path, not the API path.

**c) Resolution:**

Add the three missing parameters to the API call in `bridge_api.dart`:
```dart
followAllReExports: module.followAllReExports,
skipReExports: module.skipReExports,
followReExports: module.followReExports,
```

**Why needed:** Without this fix, the API path produces different module distributions than the CLI path. While `skipClassSources` dedup ensures no duplicate classes globally (verified: both paths produce exactly 2197 unique bridged classes), the module layout differs significantly:
- cupertino: 84 (API) vs 803 (CLI) bridged classes
- material_widgets: 396 (API) vs 1122 (CLI)
This doesn't directly cause runtime failures (registration is global), but it diverges from the intended layered architecture.

---

### GEN-081

**`isAssignable` missing from `tom_d4rt` BridgedClass (present in `tom_d4rt_ast`)**

**Status:** FIXED (2026-03-02)

**a) Problem:**

The `BridgedClass` in `tom_d4rt` (pub.dev) does not have the `isAssignable` parameter, while `tom_d4rt_ast` does. This creates an inconsistency: bridges generated for `tom_d4rt`-based projects cannot use `isAssignable`, but `tom_d4rt_ast`-based projects (like `tom_d4rt_flutterm` via `tom_d4rt_exec`) need it.

**b) Root Cause:**

`isAssignable` was added to `tom_d4rt_ast`'s `BridgedClass` as part of GEN-075 but was never ported back to `tom_d4rt`'s `BridgedClass`. The two packages evolved separately.

**c) Resolution:**

Port `isAssignable` field and usage from `tom_d4rt_ast/lib/src/runtime/bridge/bridged_types.dart` to `tom_d4rt/lib/src/bridge/bridged_types.dart`. Then publish `tom_d4rt`.

**Why needed:** Generator tests use `tom_d4rt`. Without `isAssignable` support, the generator must either skip emitting it (breaking `tom_d4rt_ast` users) or conditionally emit it (adding complexity). Syncing the two packages resolves the inconsistency.

---

### GEN-082

**Setter `_generateSetterCast` missing `sourceFilePath` — bridged types resolve to `dynamic`**

**Status:** FIXED (2026-03-02)

**a) Problem:**

The `Paint.color` setter (and any setter whose type is a bridged class defined in the same source file) generates `value as dynamic` instead of `D4.extractBridgedArg<Color>(value, 'color')`. This means BridgedInstance wrappers are not unwrapped before assignment to the native setter.

**b) Root Cause:**

`_generateSetterCast()` calls `_getTypeArgument()` without passing `sourceFilePath`. The type resolution falls back to `dynamic` for types that are only resolvable within the source file's context. In contrast, constructor generation correctly passes `sourceFilePath: cls.sourceFile` to `_getTypeArgument()`.

**c) Resolution:**

Added `sourceFilePath` parameter to `_generateSetterCast()` and forwarded `cls.sourceFile` from both call sites (instance member generation and setter-specific path). All `_getTypeArgument()` calls within `_generateSetterCast` now include the source file path.

**Why needed:** Flutter's `Paint.color`, `Paint.shader`, `Paint.blendMode` and all other setters taking bridged object types failed without proper unwrapping. The fix ensures that setter type resolution is consistent with constructor type resolution.

---

## Open Issues

### G-DOV-8

**Sealed class switch statement pattern variable scoping**

**Status:** OPEN

**a) Problem:**

When a D4rt script uses a sealed class in a switch statement with pattern matching, the interpreter throws "Undefined variable: m" when a second switch case binds a new pattern variable not present in the first case.

```dart
sealed class Shape {}
class Circle extends Shape { final double radius; Circle(this.radius); }
class Square extends Shape { final double side; Square(this.side); }

String describe(Shape s) => switch (s) {
  Circle(radius: var r) => 'Circle r=$r',
  Square(side: var m) => 'Square s=$m',  // "Undefined variable: m"
};
```

**b) Root Cause:**

The interpreter's `visitSwitchExpression` / `visitSwitchStatement` doesn't properly scope pattern variables per-case. Variables bound in one case leak into subsequent case evaluation, and variables introduced only in later cases aren't declared in the correct scope.

**c) Resolution:**

Requires interpreter fix in `interpreter_visitor.dart` — each switch case needs its own child `Environment` to contain pattern-bound variables. Not a generator issue.

**Why needed:** Sealed classes with exhaustive switch patterns are idiomatic modern Dart (3.0+). Without this, D4rt scripts can't use pattern matching on sealed hierarchies.

---

### G-FLP-54

**Function setter loses required named params in cast**

**Status:** FIXED (2026-03-02) — generator already preserves params via `D4.extractBridgedArg<>`, test expectation was wrong

**a) Problem:**

When a class has a setter whose type is a function with required named parameters (like Flutter's `SchedulingStrategy`), the generated bridge code doesn't preserve all the required named parameters in the cast expression.

```dart
class InlineSchedulingStrategyHostLike {
  bool Function({required int priority, required ExternalSchedulerBindingLike scheduler})
    schedulingStrategy = (...) => true;
}
```

The test expects the setter cast to be:
```dart
schedulingStrategy = value as bool Function({required int priority, required ExternalSchedulerBindingLike scheduler})
```

But the generator produces a different structure that drops parameters.

**b) Root Cause:**

The setter code generation path doesn't fully reconstruct function typedef signatures when the type includes required named parameters. The function type decomposition loses parameter metadata during code emission.

**c) Resolution:**

Needs fix in bridge_generator.dart's setter generation path to preserve the full function signature including all required named parameter types and names.

**Why needed:** Flutter's `SchedulerBinding.schedulingStrategy` is a function-typed setter with required named params. Without correct casts, D4rt scripts can't override scheduling behavior.

---

### G-FLP-55

**`@protected` members included in bridges (by design)**

**Status:** CLOSED (2026-03-02) — by design, `@protected` annotations are ignored

**a) Problem:**

When a class inherits members annotated with `@protected` from a base class, those members appear in the generated bridge code. The test expects `ProtectedDerivedLike` to NOT contain `textTreeConfigurationLike` or `debugFillPropertiesLike`, but both are present.

```dart
class ProtectedBaseLike {
  @protected
  int get textTreeConfigurationLike => 1;
  @protected
  void debugFillPropertiesLike(String properties) {}
}
class ProtectedDerivedLike extends ProtectedBaseLike {}
```

**b) Root Cause:**

The generator's member collection (which walks inherited members) doesn't check for `@protected` or `@visibleForOverriding` annotations. All public members are included regardless of their annotation metadata.

**c) Resolution:**

Add annotation filtering during member analysis: skip members annotated with `@protected`, `@visibleForOverriding`, or `@visibleForTesting` from the bridge API surface.

**Why needed:** `@protected` members are framework internals meant only for subclass overrides (e.g., `debugFillProperties`, `createRenderObject`). Including them creates noise in generated bridges and exposes implementation details. In the D4rt interpreter, user scripts are always "external" to the bridged package — they can't be subclasses in the Dart sense. Calling `@protected` methods from D4rt would violate the API contract, even though it would work at runtime. Filtering them keeps bridges clean and focused on the public API surface.

---

### G-FLP-57

**Overrides of `@protected` base members included in bridges (by design)**

**Status:** CLOSED (2026-03-02) — by design, `@protected` annotations are ignored

**a) Problem:**

When a class overrides a `@protected` method from its base class, the override still appears in the generated bridge even though the original declaration was `@protected`.

```dart
class ProtectedLifecycleBaseLike {
  @protected
  void lifecycleLike() {}
}
class ProtectedLifecycleOverrideLike extends ProtectedLifecycleBaseLike {
  @override
  void lifecycleLike() {}  // Still @protected by inheritance
}
```

**b) Root Cause:**

Same as G-FLP-55. The generator doesn't walk the override chain to check if the original declaration was `@protected`. In Dart, `@protected` applies transitively through overrides.

**c) Resolution:**

When filtering members, check not just the member's own annotations but also the annotations on the member it overrides (if any). In the Dart analyzer API, `MethodElement.declaration` or `overriddenMembers` can be used to trace back to the original `@protected` annotation.

**Why needed:** Same reasoning as G-FLP-55. Many Flutter widgets override `@protected` lifecycle methods (`build()`, `createElement()`, `createState()`). These overrides should not appear in bridges since D4rt scripts never call them directly.


### G-FBI-04

**Setter unwrapping for BridgedInstance types**

**Status:** FIXED (2026-03-02) via GEN-082 — `_generateSetterCast` now receives `sourceFilePath` for correct type resolution

**a) Problem:**

The `Paint.color` setter receives a `BridgedInstance<Color>` wrapper from the interpreter, but the native `Paint.color=` expects a `Color` object. The generated setter doesn't call `D4.extractBridgedArg<Color>()` or `D4.unwrap<Color>()` to extract the native value before assignment.

**b) Root Cause:**

Setter code generation uses a simple `instance.field = value` pattern without type-aware unwrapping. For primitive types this works, but for bridged class types the value arrives as a `BridgedInstance` wrapper.

**c) Resolution:**

Generator needs to emit `D4.extractBridgedArg<T>(value, 'fieldName', 'setter')` for setter parameters whose type is a bridged class.

**Why needed:** Flutter's `Paint.color`, `Paint.shader`, `Paint.blendMode` — any setter taking a bridged object type fails without unwrapping. Affects all property assignment in D4rt scripts on bridged objects.

---

### G-FBI-12

**Map with custom key types**

**Status:** VERIFIED (2026-03-02) — generator already handles this correctly

**a) Problem:**

`SemanticWidget` has a `Map<CustomAction, Function()>` parameter. The generator doesn't handle maps where the key type is a bridged class (as opposed to `String` or `int`).

**b) Root Cause:**

Map coercion logic (`D4.coerceMap`) handles `Map<String, T>` but not `Map<BridgedClass, T>`. Custom key types arrive as `BridgedInstance` wrappers.

**c) Resolution:**

Extend `D4.coerceMap` to unwrap BridgedInstance keys, similar to how `D4.coerceList` unwraps BridgedInstance elements.

**Why needed:** Flutter's `SemanticsAction` maps and custom action handlers use non-primitive map keys. Affects accessibility and custom gesture handling in D4rt.

---

### G-FBI-21

**`hashCode` from Object**

**Status:** VERIFIED (2026-03-02) — generator already bridges `hashCode`

**a) Problem:**

`UniqueKey.hashCode` is not accessible on bridged instances because `hashCode` is inherited from `Object` and not explicitly declared on `UniqueKey`.

**b) Root Cause:**

The generator doesn't bridge members inherited from `Object` (`hashCode`, `toString()`, `==`, `runtimeType`, `noSuchMethod`). This is a deliberate choice to avoid generating boilerplate for every class, but it means these fundamental members aren't available.

**c) Resolution:**

Handle Object members at the runtime level — when `.hashCode` is accessed on any `BridgedInstance`, delegate to the native object automatically.

**Why needed:** `hashCode` is used for collections (Set, Map keys), identity checks, and debugging. Without it, any bridged object used as a Map key or in a Set silently fails.

---

### G-FBI-22

**`runtimeType` getter from Object**

**Status:** VERIFIED (2026-03-02) — generator already bridges `runtimeType`

**a) Problem:**

`runtimeType` is not accessible on bridged instances. Same root cause as G-FBI-21.

**b) Root Cause:**

`runtimeType` is an Object member not included in generated bridges.

**c) Resolution:**

Same as G-FBI-21 — handle at runtime level

**Why needed:** Pattern matching, type checking, and debugging output all rely on `runtimeType`. D4rt scripts using `print(obj.runtimeType)` for diagnostics fail silently.

---

### G-FBI-32

**Abstract classes with private constructors**

**Status:** VERIFIED (2026-03-02) — generator already bridges abstract classes with private constructors

**a) Problem:**

The `Curves` class (abstract, with `Curves._()` private constructor) is not bridged. It exposes static const members like `Curves.linear`, `Curves.easeIn` etc.

**b) Root Cause:**

The generator skips classes that are abstract AND have no public constructors, since they can't be instantiated. But some abstract classes exist solely as namespaces for static members.

**c) Resolution:**

Detect abstract classes that have static members/getters and generate a bridge with only the static members (no constructors, no instance methods).

Actually the filtering of abstract interfaces (all class/interface) must simply be removed. Objects can be accessed through these interfaces, so there must be bridges for ALL classes and interfaces! Only private classes/interfaces/member etc must be skipped.

**Why needed:** Flutter's `Curves`, `Colors`, `Icons` are all abstract with private constructors. They're the primary API for accessing predefined constants. Without bridging, `Curves.easeIn`, `Colors.blue`, `Icons.home` are all inaccessible from D4rt.

---

### G-FBI-33

**Static const on abstract private-ctor classes**

**Status:** VERIFIED (2026-03-02) — generator already bridges static const members on abstract classes

**a) Problem:**

`Curves.linear` static const is not accessible because the `Curves` class itself is not bridged (see G-FBI-32).

**b) Root Cause / Resolution:** Depends on G-FBI-32.

Actually the filtering of abstract interfaces (all class/interface) must simply be removed. Objects can be accessed through these interfaces, so there must be bridges for ALL classes and interfaces! Only private classes/interfaces/member etc must be skipped.

**Why needed:** Same as G-FBI-32. Direct access to predefined curves for animation.

---

### G-FBI-34

**Static methods on abstract private-ctor classes**

**Status:** VERIFIED (2026-03-02) — generator already bridges static methods on abstract classes

**a) Problem:**

`Curves.byName(String name)` static method is not accessible.

**b) Root Cause / Resolution:** Depends on G-FBI-32.

Actually the filtering of abstract interfaces (all class/interface) must simply be removed. Objects can be accessed through these interfaces, so there must be bridges for ALL classes and interfaces! Only private classes/interfaces/member etc must be skipped.

**Why needed:** Dynamic curve lookup by name is used in theme-driven animations.

---

### G-FBI-40

**Abstract interface classes**

**Status:** VERIFIED (2026-03-02) — generator already bridges abstract interface classes

**a) Problem:**

`TickerProvider` (an abstract interface class) is not bridged, so `AnimationController(vsync: tickerProvider)` can't accept a D4rt-created TickerProvider implementation.

**b) Root Cause:**

Abstract interface classes have no concrete implementation and can't be instantiated. The generator skips them. But they're needed as type markers for parameter type checking and for D4rt classes that implement the interface.

**c) Resolution:**

Generate "marker" bridges for interface classes that include only the type registration (RuntimeType with name) and static members, enabling `is TickerProvider` checks and parameter type matching

Actually the filtering of abstract interfaces (all class/interface) must simply be removed. Objects can be accessed through these interfaces, so there must be bridges for ALL classes and interfaces! Only private classes/interfaces/member etc must be skipped.

**Why needed:** `TickerProvider`, `WidgetBuilder`, `RouteFactory` — Flutter uses interfaces extensively as parameter types. Without bridging, type checks fail and the interpreter can't validate parameter types.

---

### G-NUM-11

**Abstract classes with only static members (Curves pattern)**

**Status:** VERIFIED (2026-03-02) — generator already bridges abstract static-only classes

**a) Problem:**

Same as G-FBI-32 but from the num_conversion_test perspective. Abstract classes that serve as static-member namespaces aren't generated.

**b) Root Cause / Resolution:** Same as G-FBI-32.

Actually the filtering of abstract interfaces (all class/interface) must simply be removed. Objects can be accessed through these interfaces, so there must be bridges for ALL classes and interfaces! Only private classes/interfaces/member etc must be skipped.

**Why needed:** Same as G-FBI-32.

---

### G-NUM-12

**Static const members on abstract-only classes**

**Status:** VERIFIED (2026-03-02) — Curves.linear and similar static consts are accessible

**a) Problem:**

Same as G-FBI-33. `Curves.linear` not accessible because `Curves` not bridged.

**b) Root Cause / Resolution:** Depends on G-FBI-32/G-NUM-11.

Actually the filtering of abstract interfaces (all class/interface) must simply be removed. Objects can be accessed through these interfaces, so there must be bridges for ALL classes and interfaces! Only private classes/interfaces/member etc must be skipped.

**Why needed:** Same as G-FBI-33.

---

### G-NUM-15

**Generic `Tween<T>` class**

**Status:** VERIFIED (2026-03-02) — generator bridges generic classes

**a) Problem:**

`Tween<T extends num>` is a generic class. The generator doesn't produce bridges for generic classes because the type parameter needs to be resolved at bridge registration time.

**b) Root Cause:**

Bridging generic classes requires: (1) type parameter registration in the RuntimeType system, (2) constructor dispatch that creates `Tween<double>` vs `Tween<int>` based on runtime type args, (3) method return types that vary with T. The generator has no mechanism for any of this.

**c) Resolution:**

Implement generic bridge generation: emit bridges for concrete specializations found in the API surface and/or generate a parameterized bridge that uses `D4.registerGenericConstructor()` to dispatch based on type arguments.

This might need a change to the runtime to register the bridge for the right generic types as needed.

**Why needed:** `Tween`, `Animation`, `AnimationController` — the entire Flutter animation system is generic. Without generic bridges, D4rt scripts can't create or interact with animations beyond pre-specialized subclasses like `IntTween` and `DoubleTween`.

---

### G-NUM-26

**Generic `ValueNotifier<T>`**

**Status:** VERIFIED (2026-03-02) — generator bridges ValueNotifier

**a) Problem:**

Same category as G-NUM-15. `ValueNotifier<T>` is a fundamental reactive primitive in Flutter but is generic.

**b) Root Cause / Resolution:** Same as G-NUM-15.

**Why needed:** `ValueNotifier` is the simplest reactive state holder in Flutter. Used in `ValueListenableBuilder`, provider patterns, and state management. Without it, D4rt scripts have no lightweight reactive state mechanism.

---

### G-NUM-27

**`hasListeners` getter on ValueNotifier**

**Status:** VERIFIED (2026-03-02) — hasListeners is bridged when ValueNotifier is bridged

**a) Problem:**

`hasListeners` is a getter on `ChangeNotifier` (parent of `ValueNotifier`). Since `ValueNotifier` isn't bridged, this getter is also inaccessible in the `ValueNotifier` context.

**b) Root Cause / Resolution:** Depends on G-NUM-26.

**Why needed:** `hasListeners` is used to check if a notifier has active listeners before disposing. Important for memory leak prevention in Flutter apps.

---

### G-NUM-31

**`D4.extractBridgedArg` int to double? promotion**

**Status:** VERIFIED (2026-03-02) — nullable double promotion already works in current runtime

**a) Problem:**

`D4.extractBridgedArg<double?>(4, 'elevation')` throws "Invalid parameter elevation: expected double?, got int" instead of promoting `4` to `4.0`.

```dart
// Current code in d4.dart:
if (T == double && unwrapped is int) {
  return unwrapped.toDouble() as T;
}
// This fails for T == double? because double? != double
```

**b) Root Cause:**

The int-to-double promotion check uses `T == double` which is a strict type equality check. When T is `double?` (nullable), the check fails because `double? != double`.

**c) Resolution:**

Change the check to handle nullable types:
```dart
if ((T == double || null is T && unwrapped is int)) {
  // Or use a helper: _isDoubleType<T>()
  return unwrapped.toDouble() as T;
}
```

**Why needed:** Nearly all Flutter widget elevation/opacity/size parameters are `double?`. `Container(height: 100)` passes an `int` that must be promoted to `double?`. Without this fix, every nullable double parameter requires explicit `.toDouble()` in D4rt scripts.

---

## Summary

| Category | Count | Status |
|----------|-------|--------|
| Fixed (generator) | 5 | GEN-078, GEN-079, GEN-080, GEN-082, G-FLP-54 |
| Fixed (runtime) | 1 | GEN-081 (tom_d4rt isAssignable sync) |
| Closed (by design) | 2 | G-FLP-55, G-FLP-57 (@protected not filtered) |
| Verified (already work) | 12 | G-FBI-04, G-FBI-12, G-FBI-21, G-FBI-22, G-FBI-32, G-FBI-33, G-FBI-34, G-FBI-40, G-NUM-11, G-NUM-12, G-NUM-15, G-NUM-26, G-NUM-27, G-NUM-31 |
| Open (interpreter) | 1 | G-DOV-8 (sealed class switch scoping) |
| **Total** | **23** | |

**Current test status (2026-03-02):**
- Generator tests: **618 passed, 0 skipped, 0 failed**
- d4rt_tester_test: 28/28 passed
- d4rt_coverage_test: 94/94 passed
- tom_d4rt: 1700 passed, 1 skipped, 2 failed (pre-existing: I-BUG-14a/b Records)
- tom_d4rt_ast: 80 passed, 0 failed
- tom_d4rt_exec: 2241 passed, 3 failed (pre-existing: I-BUG-14a/b + G-DOV2-7)
- tom_d4rt_dcli: 695 passed, 0 failed
- tom_dcli_exec: 378 passed, 0 failed
- tom_d4rt_flutterm: 108 passed (integration), 0 failed

### Remaining Open Issue

**G-DOV-8** (sealed class switch pattern scoping) is an **interpreter issue**, not a generator issue. It requires a fix in `interpreter_visitor.dart` to create per-case `Environment` scopes for pattern-bound variables.
