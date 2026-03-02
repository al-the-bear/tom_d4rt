# D4rt Bridge Generator — Known Issues & Limitations

> Last updated: 2026-03-02
>
> Consolidated issue list from generator test suite (507 passed, 14 skipped, 4 failed).

---

## Issue Index

| ID | Description | Component | Status |
|----|-------------|-----------|--------|
| [GEN-078](#gen-078) | Barrel-file resolution fails without package_config.json | Testing/API | **FIXED** |
| [GEN-079](#gen-079) | Generator emits non-existent `isAssignable` constructor param | Generator | **FIXED** |
| [G-DOV-8](#g-dov-8) | Sealed class switch statement pattern variable scoping | Interpreter | **OPEN** |
| [G-FLP-54](#g-flp-54) | Function setter loses required named params in cast | Generator | **OPEN** |
| [G-FLP-55](#g-flp-55) | Inherited `@protected` members not skipped from bridges | Generator | **OPEN** |
| [G-FLP-57](#g-flp-57) | Overrides of `@protected` base members not skipped | Generator | **OPEN** |
| [G-FBI-04](#g-fbi-04) | Setter unwrapping for BridgedInstance types | Generator | **SKIP** |
| [G-FBI-12](#g-fbi-12) | Map with custom key types needs special handling | Generator | **SKIP** |
| [G-FBI-21](#g-fbi-21) | `hashCode` from Object not bridged by default | Generator | **SKIP** |
| [G-FBI-22](#g-fbi-22) | `runtimeType` getter from Object not bridged | Generator | **SKIP** |
| [G-FBI-32](#g-fbi-32) | Abstract classes with private constructors not bridged | Generator | **SKIP** |
| [G-FBI-33](#g-fbi-33) | Static const on abstract private-ctor classes not bridged | Generator | **SKIP** |
| [G-FBI-34](#g-fbi-34) | Static methods on abstract private-ctor classes not bridged | Generator | **SKIP** |
| [G-FBI-40](#g-fbi-40) | Abstract interface classes not bridged | Generator | **SKIP** |
| [G-NUM-11](#g-num-11) | Abstract classes with only static members (Curves pattern) | Generator | **SKIP** |
| [G-NUM-12](#g-num-12) | Static const members on abstract-only classes | Generator | **SKIP** |
| [G-NUM-15](#g-num-15) | Generic `Tween<T>` class not bridged | Generator | **SKIP** |
| [G-NUM-26](#g-num-26) | Generic `ValueNotifier<T>` not bridged | Generator | **SKIP** |
| [G-NUM-27](#g-num-27) | `hasListeners` getter inaccessible (depends on G-NUM-26) | Generator | **SKIP** |
| [G-NUM-31](#g-num-31) | `D4.extractBridgedArg` int to double? promotion fails | Runtime | **SKIP** |

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

**Generator emits non-existent `isAssignable` constructor parameter**

**Status:** FIXED (2026-03-02)

**a) Problem:**

The bridge generator emitted `isAssignable: (v) => v is $prefixedName,` in every `_create<ClassName>Bridge()` function, but `BridgedClass` has no `isAssignable` named parameter. This caused AOT compilation failure:

```
Error: No named parameter with the name 'isAssignable'.
```

**b) Root Cause:**

The `isAssignable` parameter was added to bridge codegen but never implemented in the `BridgedClass` constructor in `tom_d4rt`. The error was previously hidden by GEN-078 — the barrel-file failure prevented these modules from being generated and compiled.

**c) Resolution:**

Removed the `isAssignable` emission from `bridge_generator.dart`. The intended supertype lookup behavior (e.g., `Curves.linear` returns `_Linear` which should use the `Curve` bridge) is already handled by `BridgedClass.nativeNames` and `Environment.toBridgedClass()` prefix matching.

**Why needed:** Without this fix, any bridge generated for external packages fails AOT compilation.

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

**Status:** OPEN

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

**Inherited `@protected` members not skipped from bridges**

**Status:** OPEN

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

**Overrides of `@protected` base members not skipped from bridges**

**Status:** OPEN

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

---

## Skipped Issues (Known Limitations)

These tests are intentionally skipped with documented reasons. They represent known limitations of the current generator that would require significant feature work to resolve.

### G-FBI-04

**Setter unwrapping for BridgedInstance types**

**Status:** SKIP — "Setter unwrapping may not be implemented"

**a) Problem:**

The `Paint.color` setter receives a `BridgedInstance<Color>` wrapper from the interpreter, but the native `Paint.color=` expects a `Color` object. The generated setter doesn't call `D4.extractBridgedArg<Color>()` or `D4.unwrap<Color>()` to extract the native value before assignment.

**b) Root Cause:**

Setter code generation uses a simple `instance.field = value` pattern without type-aware unwrapping. For primitive types this works, but for bridged class types the value arrives as a `BridgedInstance` wrapper.

**c) Resolution:**

Generator needs to emit `D4.extractBridgedArg<T>(value, 'fieldName', 'setter')` for setter parameters whose type is a bridged class.

**Why needed:** Flutter's `Paint.color`, `Paint.shader`, `Paint.blendMode` — any setter taking a bridged object type fails without unwrapping. Affects all property assignment in D4rt scripts on bridged objects.

---

### G-FBI-12

**Map with custom key types needs special handling**

**Status:** SKIP — "Map with custom key types may need special handling"

**a) Problem:**

`SemanticWidget` has a `Map<CustomAction, Function()>` parameter. The generator doesn't handle maps where the key type is a bridged class (as opposed to `String` or `int`).

**b) Root Cause:**

Map coercion logic (`D4.coerceMap`) handles `Map<String, T>` but not `Map<BridgedClass, T>`. Custom key types arrive as `BridgedInstance` wrappers.

**c) Resolution:**

Extend `D4.coerceMap` to unwrap BridgedInstance keys, similar to how `D4.coerceList` unwraps BridgedInstance elements.

**Why needed:** Flutter's `SemanticsAction` maps and custom action handlers use non-primitive map keys. Affects accessibility and custom gesture handling in D4rt.

---

### G-FBI-21

**`hashCode` from Object not bridged by default**

**Status:** SKIP — "hashCode from Object may not be bridged by default"

**a) Problem:**

`UniqueKey.hashCode` is not accessible on bridged instances because `hashCode` is inherited from `Object` and not explicitly declared on `UniqueKey`.

**b) Root Cause:**

The generator doesn't bridge members inherited from `Object` (`hashCode`, `toString()`, `==`, `runtimeType`, `noSuchMethod`). This is a deliberate choice to avoid generating boilerplate for every class, but it means these fundamental members aren't available.

**c) Resolution:**

Option A: Auto-generate `hashCode`/`toString()`/`==` getters for all bridged classes by delegating to `nativeInstance.hashCode` etc.
Option B: Handle Object members at the runtime level — when `.hashCode` is accessed on any `BridgedInstance`, delegate to the native object automatically.

**Why needed:** `hashCode` is used for collections (Set, Map keys), identity checks, and debugging. Without it, any bridged object used as a Map key or in a Set silently fails.

---

### G-FBI-22

**`runtimeType` getter from Object not bridged**

**Status:** SKIP — "runtimeType from Object may not be bridged by default"

**a) Problem:**

`runtimeType` is not accessible on bridged instances. Same root cause as G-FBI-21.

**b) Root Cause:**

`runtimeType` is an Object member not included in generated bridges.

**c) Resolution:**

Same as G-FBI-21 — handle at runtime level or generate for all classes.

**Why needed:** Pattern matching, type checking, and debugging output all rely on `runtimeType`. D4rt scripts using `print(obj.runtimeType)` for diagnostics fail silently.

---

### G-FBI-32

**Abstract classes with private constructors not bridged**

**Status:** SKIP — "Abstract classes with private constructors may not be bridged"

**a) Problem:**

The `Curves` class (abstract, with `Curves._()` private constructor) is not bridged. It exposes static const members like `Curves.linear`, `Curves.easeIn` etc.

**b) Root Cause:**

The generator skips classes that are abstract AND have no public constructors, since they can't be instantiated. But some abstract classes exist solely as namespaces for static members.

**c) Resolution:**

Detect abstract classes that have static members/getters and generate a bridge with only the static members (no constructors, no instance methods).

**Why needed:** Flutter's `Curves`, `Colors`, `Icons` are all abstract with private constructors. They're the primary API for accessing predefined constants. Without bridging, `Curves.easeIn`, `Colors.blue`, `Icons.home` are all inaccessible from D4rt.

---

### G-FBI-33

**Static const on abstract private-ctor classes not bridged**

**Status:** SKIP — "Static const on abstract classes may not be bridged"

**a) Problem:**

`Curves.linear` static const is not accessible because the `Curves` class itself is not bridged (see G-FBI-32).

**b) Root Cause / Resolution:** Depends on G-FBI-32.

**Why needed:** Same as G-FBI-32. Direct access to predefined curves for animation.

---

### G-FBI-34

**Static methods on abstract private-ctor classes not bridged**

**Status:** SKIP — "Static methods on abstract classes may not be bridged"

**a) Problem:**

`Curves.byName(String name)` static method is not accessible.

**b) Root Cause / Resolution:** Depends on G-FBI-32.

**Why needed:** Dynamic curve lookup by name is used in theme-driven animations.

---

### G-FBI-40

**Abstract interface classes not bridged**

**Status:** SKIP — "Abstract interface classes may not be bridged"

**a) Problem:**

`TickerProvider` (an abstract interface class) is not bridged, so `AnimationController(vsync: tickerProvider)` can't accept a D4rt-created TickerProvider implementation.

**b) Root Cause:**

Abstract interface classes have no concrete implementation and can't be instantiated. The generator skips them. But they're needed as type markers for parameter type checking and for D4rt classes that implement the interface.

**c) Resolution:**

Generate "marker" bridges for interface classes that include only the type registration (RuntimeType with name) and static members, enabling `is TickerProvider` checks and parameter type matching.

**Why needed:** `TickerProvider`, `WidgetBuilder`, `RouteFactory` — Flutter uses interfaces extensively as parameter types. Without bridging, type checks fail and the interpreter can't validate parameter types.

---

### G-NUM-11

**Abstract classes with only static members (Curves pattern)**

**Status:** SKIP — "Abstract classes with only static members may not be bridged currently"

**a) Problem:**

Same as G-FBI-32 but from the num_conversion_test perspective. Abstract classes that serve as static-member namespaces aren't generated.

**b) Root Cause / Resolution:** Same as G-FBI-32.

**Why needed:** Same as G-FBI-32.

---

### G-NUM-12

**Static const members on abstract-only classes**

**Status:** SKIP — "Static const members on abstract classes may not be bridged"

**a) Problem:**

Same as G-FBI-33. `Curves.linear` not accessible because `Curves` not bridged.

**b) Root Cause / Resolution:** Depends on G-FBI-32/G-NUM-11.

**Why needed:** Same as G-FBI-33.

---

### G-NUM-15

**Generic `Tween<T>` class not bridged**

**Status:** SKIP — "Generic classes may not be bridged currently"

**a) Problem:**

`Tween<T extends num>` is a generic class. The generator doesn't produce bridges for generic classes because the type parameter needs to be resolved at bridge registration time.

**b) Root Cause:**

Bridging generic classes requires: (1) type parameter registration in the RuntimeType system, (2) constructor dispatch that creates `Tween<double>` vs `Tween<int>` based on runtime type args, (3) method return types that vary with T. The generator has no mechanism for any of this.

**c) Resolution:**

Implement generic bridge generation: emit bridges for concrete specializations found in the API surface and/or generate a parameterized bridge that uses `D4.registerGenericConstructor()` to dispatch based on type arguments.

**Why needed:** `Tween`, `Animation`, `AnimationController` — the entire Flutter animation system is generic. Without generic bridges, D4rt scripts can't create or interact with animations beyond pre-specialized subclasses like `IntTween` and `DoubleTween`.

---

### G-NUM-26

**Generic `ValueNotifier<T>` not bridged**

**Status:** SKIP — "Generic class ValueNotifier<T> may not be bridged"

**a) Problem:**

Same category as G-NUM-15. `ValueNotifier<T>` is a fundamental reactive primitive in Flutter but is generic.

**b) Root Cause / Resolution:** Same as G-NUM-15.

**Why needed:** `ValueNotifier` is the simplest reactive state holder in Flutter. Used in `ValueListenableBuilder`, provider patterns, and state management. Without it, D4rt scripts have no lightweight reactive state mechanism.

---

### G-NUM-27

**`hasListeners` getter inaccessible (depends on ValueNotifier bridging)**

**Status:** SKIP — "If ValueNotifier is not bridged, hasListeners won't be either"

**a) Problem:**

`hasListeners` is a getter on `ChangeNotifier` (parent of `ValueNotifier`). Since `ValueNotifier` isn't bridged, this getter is also inaccessible in the `ValueNotifier` context.

**b) Root Cause / Resolution:** Depends on G-NUM-26.

**Why needed:** `hasListeners` is used to check if a notifier has active listeners before disposing. Important for memory leak prevention in Flutter apps.

---

### G-NUM-31

**`D4.extractBridgedArg` int to double? promotion fails for nullable types**

**Status:** SKIP — "Runtime bug in D4.extractBridgedArg - needs fix in d4.dart"

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
| Fixed this session | 2 | GEN-078, GEN-079 |
| Open failures | 4 | G-DOV-8, G-FLP-54, G-FLP-55, G-FLP-57 |
| Known limitations (skipped) | 14 | See above |
| **Total** | **20** | |

**Current test status (2026-03-02):**
- Generator tests: **507 passed, 14 skipped, 4 failed** (was 479/14/5)
- d4rt_tester_test: 28/28 passed (was 0 — setUpAll failure)
- d4rt_coverage_test: 94/94 passed (was 0 — setUpAll failure)

### Priority Recommendations

1. **G-FBI-32 + G-NUM-11** (abstract static-only classes) — High impact. Unlocks `Curves`, `Colors`, `Icons` in D4rt. Relatively straightforward: generate bridges with only static members.
2. **G-NUM-15 + G-NUM-26** (generic classes) — High impact but complex. Unlocks `Tween`, `ValueNotifier`, `Animation`. Needs type parameter machinery.
3. **G-FLP-55 + G-FLP-57** (@protected filtering) — Medium impact. Keeps bridges clean but doesn't block functionality.
4. **G-NUM-31** (int-to-double? promotion) — Small fix, high impact. One-line change in `d4.dart`.
5. **G-FBI-21 + G-FBI-22** (Object members) — Medium impact. Best handled at runtime level.
