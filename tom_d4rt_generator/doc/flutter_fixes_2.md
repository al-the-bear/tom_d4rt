# Flutter Fixes 2 — Fix Plan for 37 D4rt Flutter Test Failures (Important + Secondary)

**Status:** Plan  
**Date:** 2026-03-25  
**Context:** After implementing all fixes from flutter_fixes_1.md, the essential tests are **108/0** (perfect). This document covers the remaining 37 failures across important_classes (3 failures) and secondary_classes (34 failures). Total test results: 1776 passed / 215 failed / 9 skipped out of 2000.

---

## 1. Failures Overview

### 1.1 Important Failures (3)

| # | Suite | Test File | Widget/Class | Error Summary |
|---|-------|-----------|-------------|---------------|
| I-1 | Important | segmentedbutton_test.dart | `SegmentedButton<String>` | `ButtonSegment<dynamic>` → `ButtonSegment<String>` cast fails in list coercion |
| I-2 | Important | tweensequence_test.dart | `TweenSequenceItem` | `Null check operator used on a null value` in generic constructor factory |
| I-3 | Important | channels_test.dart | `BasicMessageChannel<String>` | `(dynamic) => Future<dynamic>` not subtype of `((String?) => Future<String>)?` |

### 1.2 Secondary Failures (34)

| # | Suite | Test File | Error Summary |
|---|-------|-----------|---------------|
| S-1 | dart_ui | enums_ui_test.dart | Cannot access property `name` on AppLifecycleState |
| S-2 | dart_ui | dart_ui_paint_canvas_test.dart | Undefined property `name` on bridged Paint |
| S-3 | dart_ui | dart_ui_misc_adv_test.dart | Undefined property `entries` on bridged View |
| S-4 | painting | enums_painting_test.dart | Undefined property `name` on bridged Image |
| S-5 | animation | animation_mean_test.dart | Undefined property `name` on bridged Animation (in Map literal) |
| S-6 | animation | animation_with_parent_mixin_test.dart | Undefined property `name` on bridged Animation (in Map literal) |
| S-7 | dart_ui | brightness_test.dart | Cannot access property `name` on Brightness |
| S-8 | dart_ui | ztmp_path_metrics_access_test.dart | Bad state: No element |
| S-9 | dart_ui | pointer_data_packet_test.dart | Undefined property `entries` on bridged View |
| S-10 | material | calendar_delegate_test.dart | Bridged class `Map` has no method `contains` |
| S-11 | material | desktop_text_selection_controls_test.dart | Undefined property `entries` on bridged View |
| S-12 | material | desktop_text_selection_toolbar_test.dart | Undefined property `entries` on bridged View |
| S-13 | material | disabled_chip_attributes_test.dart | Undefined property `entries` on bridged View |
| S-14 | material | menu_style_test.dart | Undefined property `entries` on bridged View |
| S-15 | material | round_slider_thumb_shape_test.dart | Undefined variable: `build` |
| S-16 | material | rounded_rect_slider_track_shape_test.dart | Undefined variable: `build` |
| S-17 | material | scaffold_messenger_state_test.dart | operator `==` error: expected SnackBar, got SnackBarBehavior |
| S-18 | material | scaffold_messenger_test.dart | SingleTickerProviderStateMixin cannot be used as mixin |
| S-19 | material | snack_bar_action_test.dart | Undefined variable: `build` |
| S-20 | material | visual_density_test.dart | Undefined variable: `build` |
| S-21 | painting | decoration_image_painter_test.dart | Text constructor: expected String, got Null |
| S-22 | physics | gravity_simulation_test.dart | `endDistance >= 0` assertion failure |
| S-23 | rendering | box_hit_test_entry_test.dart | `_InteractiveHitTestArea` can't be returned as Widget |
| S-24 | rendering | box_hit_test_result_test.dart | Undefined variable: `build` |
| S-25 | rendering | clip_r_superellipse_layer_test.dart | `_CornerComparisonWidget` can't be returned as Widget |
| S-26 | rendering | container_box_parent_data_test.dart | `_InteractiveOffsetWidget` can't be returned as Widget |
| S-27 | rendering | container_render_object_mixin_test.dart | ContainerRenderObjectMixin cannot be used as mixin |
| S-28 | rendering | debug_overflow_indicator_mixin_test.dart | Cannot resolve `flutter_test` import |
| S-29 | rendering | list_body_parent_data_test.dart | Undefined property `entries` on bridged View |
| S-30 | rendering | performance_overlay_layer_test.dart | `build` function accepts 0 args, 1 provided |
| S-31 | rendering | render_aligning_shifted_box_test.dart | operator `==` error: expected Text, got TextDirection |
| S-32 | rendering | render_backdrop_filter_test.dart | TextStyle type mismatch (dart:ui vs painting) |
| S-33 | rendering | render_custom_paint_test.dart | CustomPaint assertion: painter != null |
| S-34 | rendering | render_editable_test.dart | Cannot convert List to `List<TextInputFormatter>` — InterpretedInstance not a TextInputFormatter |

---

## 2. Root Cause Analysis

### 2.1 `List.asMap()` → View Bridge False Match (S-3, S-9, S-11, S-12, S-13, S-14, S-29)

**Affected tests:** 7 secondary failures

**What happens:**

1. D4rt script calls `someList.asMap().entries.map((e) { ... })` — a common Dart idiom for indexed iteration.
2. `List.asMap()` is bridged and returns a native `Map` (runtime type: `ListMapView<int>`).
3. D4rt's bridge resolution in `toBridgedClass` (environment.dart ~line 235) looks up the runtime type `ListMapView<int>`:
   - Primary lookup by type name `ListMapView` fails (not registered as a Map native name).
   - Falls through to the **generic type branch**: `nativeTypeName.contains('${e.value.name}<')`.
   - `"ListMapView<int>".contains("View<")` → **TRUE** because `View<` appears inside `ListMap**View<**int`.
   - The Flutter widget `View` bridge is selected as the match.
4. The return value of `asMap()` is wrapped as `BridgedInstance(viewBridge, nativeMap)`.
5. `.entries` is called → View bridge has no `entries` getter → error.

**Root cause chain:**
- **Primary:** `ListMapView` (the Dart SDK's implementation of the Map returned by `List.asMap()`) is not listed in the Map bridge's `nativeNames`.
- **Secondary:** The generic type matching in `toBridgedClass` uses `String.contains()` — a **substring** match — which is overly broad. `ListMapView` contains the substring `View`, causing a false match with the Flutter `View` widget bridge.

**Code trace:**

```
environment.dart ~line 235:
  } else if (bridgedClass == null && nativeTypeName.contains('<')) {
    bridgedClass = current._bridgedClassesLookupByType.entries
        .firstWhereOrNull(
            (e) => nativeTypeName.contains('${e.value.name}<'))
        ?.value;
  }
```

`nativeTypeName = "ListMapView<int>"`, `e.value.name = "View"` → `"ListMapView<int>".contains("View<")` = true.

---

### 2.2 Enum `.name` Property Not Accessible (S-1, S-2, S-4, S-5, S-6, S-7)

**Affected tests:** 6 secondary failures

**What happens:**

1. Script accesses `.name` on an enum value: e.g., `appLifecycleState.name`, `brightness.name`, `animationStatus.name`.
2. D4rt's interpreter dispatches property access:
   - If the value is a `BridgedEnumValue`, `bridgedEnumValue.get('name')` IS implemented and returns the name.
   - If the value is a **raw native enum** (returned by a bridge getter or property), the interpreter calls `environment.getBridgedEnumValue(target)` to find the BridgedEnum registration.
   - If the enum type's bridge is not loaded, `getBridgedEnumValue` returns null.
   - The property access falls through to the generic "Undefined property" error.

**Two distinct sub-patterns:**

- **S-1, S-7** (`AppLifecycleState`, `Brightness`): Error is `Cannot access property 'name' on target of type X`. These are **native enum instances** not wrapped in BridgedEnumValue. The enum bridge may not be registered, OR the value was returned from a native getter as a raw Dart enum rather than through the bridge.

- **S-2, S-4, S-5, S-6** (`Paint`, `Image`, `Animation`): Error is `Undefined property or method 'name' on bridged instance of 'X'`. Here `name` is accessed on a non-enum BridgedInstance. The script does `.name` on enum values obtained through properties of these classes (e.g., `paint.blendMode.name`), but the intermediate property returns the enum as a property of the BridgedInstance, and `.name` is dispatched against the wrong bridge.

**Root cause:** The D4rt interpreter lacks a generic `Enum.name` getter that works for ALL Dart enums regardless of bridge registration. When a native bridge getter returns a raw enum value (e.g., `Paint.blendMode` returns `BlendMode.srcOver`), the result should be a BridgedEnumValue, but if not bridged, `.name` fails.

---

### 2.3 Missing `build(BuildContext context)` Entry Point (S-15, S-16, S-19, S-20, S-24, S-28, S-30)

**Affected tests:** 7 secondary failures

**What happens:**

The test runner expects each D4rt script to define a top-level `dynamic build(BuildContext context)` function. These scripts either:

| Failure | Script Problem |
|---------|---------------|
| S-15, S-16, S-19, S-20 | Only define helper functions like `buildSectionHeader(...)`, `buildSliderWithRoundThumb(...)` — **no top-level `build(BuildContext)`** |
| S-24 | Has `Widget build(BuildContext context)` only inside a State class, not at top level |
| S-28 | Script uses `import 'package:flutter_test/flutter_test.dart'` with `void main()` — it's a unit test, not a `build()` script |
| S-30 | Defines `Widget build()` (no `BuildContext` parameter), so runner calls it with 1 arg but function accepts 0 |

**Root cause:** These are **script authoring errors**. The scripts were generated without the required `dynamic build(BuildContext context)` top-level entry point.

---

### 2.4 Enum `==` Comparison Failure (S-17, S-21, S-31, and downstream S-21)

**Affected tests:** 3 direct failures + 1 downstream (S-21)

**What happens:**

1. Script uses `behavior == SnackBarBehavior.fixed` (S-17) or `direction == TextDirection.ltr` (S-31).
2. D4rt's binary expression evaluator resolves the left operand via `toBridgedInstance()`.
3. For raw native enum values (function parameters or local variables), `toBridgedInstance()` may wrap them as a `BridgedInstance` of the **wrong class** due to `isAssignable` scan fallback in `environment.toBridgedInstance()`.
4. The generated `operator ==` adapter uses `D4.validateTarget<SnackBar>(target, 'SnackBar')`, which fails because the target's native object is a `SnackBarBehavior` enum value, not a `SnackBar` widget.

**Code trace for S-17:**
```
interpreter_visitor.dart ~line 1283:
  if (toBridgedInstance(leftOperandValue).$2) {
    // leftOperandValue = SnackBarBehavior.floating (raw native enum)
    // toBridgedInstance wraps it → BridgedInstance(snackBarBridge?, snackBarBehaviorValue)
    // bridgedClass.findInstanceMethodAdapter('==') → finds SnackBar's == adapter
    // adapter calls D4.validateTarget<SnackBar>(target) → FAILS: target is SnackBarBehavior
```

**S-21 (downstream):** The `decoration_image_painter_test.dart` uses `switch (fit) { case BoxFit.fill: ... }` — switch-case matching on enums. D4rt's switch implementation internally uses equality comparison. When enum `==` fails, none of the cases match, the function returns `null`, and `Text(null)` triggers the "expected String, got Null" error.

**Root cause:** D4rt's `toBridgedInstance` for native enum values finds the wrong bridge class. Enum equality should use `BridgedEnumValue` comparison (which IS implemented at interpreter_visitor.dart ~line 1389), but the `toBridgedInstance` path at line 1283 fires first and takes precedence because the raw enum value passes the `toBridgedInstance().$2 == true` check.

---

### 2.5 Interpreted Class Instances as Native Types (S-23, S-25, S-26, S-33, S-34)

**Affected tests:** 5 secondary failures

**What happens:**

Scripts define custom classes extending native Flutter types and instantiate them:

| Failure | Script Class | Extends | Used As |
|---------|-------------|---------|---------|
| S-23 | `_InteractiveHitTestArea` | `StatefulWidget` | Returned from helper as Widget |
| S-25 | `_CornerComparisonWidget` | `StatefulWidget` | Returned from helper as Widget |
| S-26 | `_InteractiveOffsetWidget` | `StatefulWidget` | Returned from helper as Widget |
| S-33 | `GeometricShapesPainter` etc. | `CustomPainter` | Passed to `CustomPaint(painter: ...)` |
| S-34 | `UpperCaseTextFormatter` | `TextInputFormatter` | Passed in `inputFormatters: [...]` |

D4rt's interpreter creates `InterpretedInstance` objects for user-defined classes. These are NOT native Dart instances — they don't extend the actual native class at runtime. When an `InterpretedInstance` is passed where the framework expects a real `Widget`, `CustomPainter`, or `TextInputFormatter`, the type check fails.

**S-34 has a second issue:** Even for the non-interpreted `FilteringTextInputFormatter.digitsOnly` (a bridge static member), the list literal `[FilteringTextInputFormatter.digitsOnly]` is typed as `List<dynamic>` by D4rt, which can't be cast to `List<TextInputFormatter>`.

**Root cause:** D4rt's interpreted class system cannot produce real native subclass instances. This is an architectural limitation — full native subclass bridging would require code generation for each script-defined class. S-34's secondary issue duplicates the list type coercion pattern from flutter_fixes_1.md category 2.1.

---

### 2.6 Missing `registerGenericTypeWrapper` for ButtonSegment (I-1)

**Affected tests:** 1 important failure

**What happens:**

1. Script creates `SegmentedButton<String>(segments: [ButtonSegment(...), ButtonSegment(...)])`.
2. The bridge constructor for `ButtonSegment` creates `ButtonSegment<dynamic>` (no type dispatch).
3. The `SegmentedButton` RC-2 factory calls `D4.coerceList<ButtonSegment<String>>(segments, 'segments')`.
4. `coerceList` unwraps each element → `ButtonSegment<dynamic>` → cast `as ButtonSegment<String>` fails.
5. GEN-079 wrapper resolution looks for `_genericTypeWrappers['ButtonSegment']` — **not registered**.

**Verification:**
- No `$RelaxedButtonSegment` class in `flutter_relaxers.b.dart`.
- No `registerGenericTypeWrapper('ButtonSegment', ...)` in `d4rt_runtime_registrations.dart`.
- `DropdownMenuItem` and `DropdownMenuEntry` have re-creation factories, but `ButtonSegment` was missed.

**Root cause:** `ButtonSegment` was omitted from `_registerGenericWidgetReCreators()` in `d4rt_runtime_registrations.dart`. Same pattern as the DropdownMenuItem fix from the previous session.

---

### 2.7 TweenSequenceItem Generic Constructor Null Check (I-2)

**Affected tests:** 1 important failure

**What happens:**

1. Script creates `TweenSequenceItem<double>(tween: Tween<double>(...), weight: 50)`.
2. D4rt resolves the generic type argument `<double>` and attempts to use the generic constructor factory for `TweenSequenceItem`.
3. The generic constructor factory (registered via `D4.registerGenericConstructor`) performs a null-check (`!`) on the resolved type argument.
4. The type argument resolution returns `null` → null check fails.

**Note:** The wrapper machinery for `TweenSequenceItem` works (`$RelaxedTweenSequenceItem` class and `registerGenericTypeWrapper` both exist). The issue is specifically in the **construction** path — the generic constructor factory (not the wrapper factory) fails during type argument resolution.

**Root cause:** The generic constructor factory for `TweenSequenceItem` expects a non-null type argument name but receives `null`. This could be because:
- The constructor is invoked through a code path that doesn't propagate explicit type arguments.
- The `evaluatedTypeArguments` from the interpreter visitor are not reaching the factory.

This needs further debugging to identify the exact null-check site.

---

### 2.8 Generic Class Method Function Typing (I-3)

**Affected tests:** 1 important failure

**What happens:**

1. Script creates `BasicMessageChannel<String>('test', StringCodec())` via RC-2 factory.
2. Script calls `channel.setMessageHandler((String? msg) async => 'reply')`.
3. The bridge method adapter generates a wrapper closure:
   ```dart
   (dynamic p0) { return D4.callInterpreterCallback(visitor!, handlerRaw, [p0]) as Future<dynamic>; }
   ```
4. The native `BasicMessageChannel<String>.setMessageHandler` expects `((String?) => Future<String>)?`.
5. `(dynamic) => Future<dynamic>` is NOT a subtype of `(String?) => Future<String>` in Dart.

**Root cause chain:**
- The bridge generator erases all class-level type parameter `T` to `dynamic` in method adapters.
- `BridgedInstance.typeArguments` is never populated — the instance doesn't know it was constructed with `<String>`.
- Without class-level type information, the method adapter can't generate correctly typed function wrappers.
- This was identified as fixes E + F in flutter_fixes_1.md. Those fixes were listed but NOT implemented in that session (they were the most complex changes).

---

### 2.9 Mixin Application Not Supported (S-18, S-27)

**Affected tests:** 2 secondary failures

**What happens:**

1. S-18: Script defines a class `with SingleTickerProviderStateMixin`.
2. S-27: Script defines a class `with ContainerRenderObjectMixin<...>`.
3. D4rt encounters the `with` clause and tries to apply the mixin.
4. D4rt checks `bridgedClass.canBeUsedAsMixin` on the mixin bridge — it's `false`.
5. Error: `Bridged class 'X' cannot be used as a mixin`.

**Root cause:** The bridges for `SingleTickerProviderStateMixin` and `ContainerRenderObjectMixin` don't have `canBeUsedAsMixin: true` set. Even if they did, D4rt's mixin application for interpreted classes extending native types is an architectural limitation — the interpreter cannot create a real native class that mixes in a native mixin.

---

### 2.10 `Set.contains` Resolved as Map Method (S-10)

**Affected tests:** 1 secondary failure

**What happens:**

1. Script uses `highlighted.contains(day)` where `highlighted` is a `Set<int>`.
2. D4rt resolves the Set to a `BridgedInstance` but misidentifies it as a `Map`.
3. The Map bridge has no `contains` method → error.

**Root cause:** Similar to 2.1 — `toBridgedInstance` uses `isAssignable` scan which may match Set to the Map bridge. Alternatively, D4rt's parser interprets `{}` Set literals as Maps in some contexts (`{1, 2, 3}` vs `{1: 'a'}`). `Set.contains` IS bridged, so if the Set were correctly identified, it would work.

---

### 2.11 TextStyle Type Ambiguity — dart:ui vs painting (S-32)

**Affected tests:** 1 secondary failure

**What happens:**

1. Script creates or obtains a `dart:ui.TextStyle` (perhaps from a bridge getter).
2. Passed to a native constructor expecting `package:flutter/painting.dart TextStyle`.
3. Cast fails: `dart:ui.TextStyle` is a completely different class from `painting.TextStyle`.

**Root cause:** D4rt has a coercion registered for `painting.TextStyle → dart:ui.TextStyle` but **not the reverse** (`dart:ui.TextStyle → painting.TextStyle`). When a bridge getter returns a `dart:ui.TextStyle`, it cannot be used where a `painting.TextStyle` is expected. The reverse coercion is harder to implement since `dart:ui.TextStyle` is opaque.

---

### 2.12 PathMetrics Empty Iterable (S-8)

**Affected tests:** 1 secondary failure

**What happens:**

1. Script calls `path.computeMetrics().first`.
2. The path is empty or `computeMetrics()` returns an empty iterable.
3. `.first` throws `Bad state: No element`.

**Root cause:** Likely a **script issue** — the path was constructed without any path operations (lines/curves), so `computeMetrics()` produces an empty iterable. In a real Flutter app, `path.computeMetrics().first` on an empty path would also fail.

---

### 2.13 GravitySimulation Wrong Parameter Order (S-22)

**Affected tests:** 1 secondary failure

**What happens:**

1. Script creates `GravitySimulation(9.8, 100.0, -50.0, 500.0)`.
2. The actual Flutter constructor signature is `GravitySimulation(acceleration, distance, endDistance, velocity)`.
3. The script's 3rd argument (-50.0) maps to `endDistance`.
4. Flutter asserts `endDistance >= 0` → fails.

**Root cause:** **Script bug** — the argument order is wrong. The script author confused `distance/endDistance/velocity` ordering.

---

## 3. Error Category Summary

| Category | Failures | Count | Fix Type |
|----------|----------|-------|----------|
| 2.1 ListMapView → View false match | S-3, S-9, S-11, S-12, S-13, S-14, S-29 | 7 | Runtime fix |
| 2.2 Enum `.name` not accessible | S-1, S-2, S-4, S-5, S-6, S-7 | 6 | Runtime fix |
| 2.3 Missing `build(BuildContext)` | S-15, S-16, S-19, S-20, S-24, S-28, S-30 | 7 | Script fix |
| 2.4 Enum `==` comparison failure | S-17, S-21, S-31 | 3 | Runtime fix |
| 2.5 Interpreted class as native type | S-23, S-25, S-26, S-33, S-34 | 5 | Architectural / Script fix |
| 2.6 ButtonSegment wrapper missing | I-1 | 1 | Registration fix |
| 2.7 TweenSequenceItem null check | I-2 | 1 | Runtime / Generator fix |
| 2.8 Generic class method typing | I-3 | 1 | Generator fix (E + F from fixes_1) |
| 2.9 Mixin application blocked | S-18, S-27 | 2 | Architectural / Script fix |
| 2.10 Set resolved as Map | S-10 | 1 | Runtime fix |
| 2.11 TextStyle dart:ui vs painting | S-32 | 1 | Registration fix |
| 2.12 PathMetrics empty iterable | S-8 | 1 | Script fix |
| 2.13 GravitySimulation wrong args | S-22 | 1 | Script fix |
| **Total** | | **37** | |

---

## 4. Fix Plan

### Fix H — Register `ListMapView` in Map Bridge NativeNames

**Component:** `tom_d4rt_ast` — `lib/src/runtime/stdlib/core/map.dart` (and `tom_d4rt` copy)  
**Fixes failures:** S-3, S-9, S-11, S-12, S-13, S-14, S-29  
**Priority:** HIGH — fixes 7 failures with a single change  
**Estimated effort:** Small  

**What to change:**

Add `'ListMapView'` to the Map bridge's `nativeNames` list. This ensures `List.asMap()` return values are correctly identified as Map instances instead of falling through to the substring-match heuristic.

```dart
// In map.dart, the BridgedClass registration:
nativeNames: [
  'UnmodifiableMapView',
  '_UnmodifiableMapView',
  '_CompactLinkedHashMap',
  'ListMapView',        // ← Add this
],
```

**Complementary hardening:** Also fix the generic type matching in `toBridgedClass` to use **base-type extraction** instead of `String.contains()`:

```dart
// Instead of: nativeTypeName.contains('${e.value.name}<')
// Use:
final baseTypeName = nativeTypeName.contains('<')
    ? nativeTypeName.substring(0, nativeTypeName.indexOf('<'))
    : nativeTypeName;
// Then match:
baseTypeName == e.value.name || e.value.nativeNames.contains(baseTypeName)
```

This prevents ALL future false matches from substring collisions (not just `ListMapView`/`View`).

**Why this works:** Direct name registration takes priority over the generic fallback. `List.asMap()` → `ListMapView<int>` → Map bridge → `.entries` works.

---

### Fix I — Generic Enum `.name` Getter in Runtime

**Component:** `tom_d4rt_ast` — `lib/src/runtime/interpreter_visitor.dart`  
**Fixes failures:** S-1, S-2, S-4, S-5, S-6, S-7  
**Priority:** HIGH — fixes 6 failures  
**Estimated effort:** Small  

**What to change:**

In the property access dispatcher, add a generic handler for `.name` on ANY Dart `Enum` value, not just registered `BridgedEnumValue` instances:

```dart
// In visitPropertyAccess, after the BridgedEnumValue check and before the "Undefined property" error:
if (target is Enum && propertyName == 'name') {
  return target.name;
}
if (target is Enum && propertyName == 'index') {
  return target.index;
}
```

This handles the case where a native bridge getter returns a raw Dart enum value (e.g., `Paint.blendMode` returns `BlendMode.srcOver`) that isn't wrapped in a BridgedEnumValue.

**Why this works:** All Dart enums implement the `Enum` interface with `name` and `index` getters. This catch-all handler works regardless of whether the specific enum type has a bridge registered.

**Note:** The errors S-2 and S-4 say "on bridged instance of 'Paint'" / "of 'Image'" — meaning `.name` is called on a property chain like `paint.blendMode.name`. The intermediate `.blendMode` returns a raw enum, then `.name` fails. Fix I handles this by catching raw `Enum` instances.

---

### Fix J — Enum `==` Comparison Priority Fix

**Component:** `tom_d4rt_ast` — `lib/src/runtime/interpreter_visitor.dart`  
**Fixes failures:** S-17, S-21, S-31  
**Priority:** HIGH — fixes 3 direct failures + 1 downstream  
**Estimated effort:** Medium  

**What to change:**

In the binary expression evaluator for `==`, the `toBridgedInstance` path at ~line 1283 fires before the `BridgedEnumValue` comparison at ~line 1389. When the left operand is a raw native enum value, `toBridgedInstance()` wraps it as the wrong BridgedInstance, causing the operator adapter to fail.

**Fix approach — check enums first:**

```dart
// In visitBinaryExpression for '==' operator:
// BEFORE checking toBridgedInstance, check if either operand is an enum:
if (leftOperandValue is Enum || leftOperandValue is BridgedEnumValue) {
  // Use enum-specific equality
  final leftEnum = leftOperandValue is BridgedEnumValue
      ? leftOperandValue.nativeValue
      : leftOperandValue;
  final rightEnum = rightOperandValue is BridgedEnumValue
      ? rightOperandValue.nativeValue
      : rightOperandValue;
  return leftEnum == rightEnum;
}
```

Insert this block before the existing `toBridgedInstance` block.

**Why this works:** Raw native enums and BridgedEnumValues are intercepted before `toBridgedInstance` can mis-wrap them. Direct Dart `==` on the native enum values works correctly.

**Downstream fix for S-21:** Once enum `==` works, `switch (fit) { case BoxFit.fill: ... }` will match correctly, the helper function will return a String instead of null, and `Text(string)` will succeed.

---

### Fix K — Register `ButtonSegment` Re-Creation Factory

**Component:** `tom_d4rt_flutterm` — `lib/src/d4rt_runtime_registrations.dart`  
**Fixes failures:** I-1  
**Priority:** HIGH  
**Estimated effort:** Small  

**What to change:**

Add `registerGenericTypeWrapper('ButtonSegment', ...)` in `_registerGenericWidgetReCreators()`, following the exact same pattern as `DropdownMenuItem` and `DropdownMenuEntry`:

```dart
D4.registerGenericTypeWrapper('ButtonSegment', (value, typeArg) {
  if (value is! ButtonSegment) return null;
  final v = value.value;
  final icon = value.icon;
  final label = value.label;
  final enabled = value.enabled;
  final tooltip = value.tooltip;
  switch (typeArg) {
    case 'String':
      return ButtonSegment<String>(
        value: v as String, icon: icon, label: label,
        enabled: enabled, tooltip: tooltip,
      );
    case 'int':
      return ButtonSegment<int>(
        value: v as int, icon: icon, label: label,
        enabled: enabled, tooltip: tooltip,
      );
    // ... cases for bool, double, num, dynamic, Object
    default:
      return null;
  }
});
```

**Import needed:** Add `ButtonSegment` to the material import in d4rt_runtime_registrations.dart.

---

### Fix L — Fix Scripts with Missing `build(BuildContext)` Entry Point

**Component:** `tom_d4rt_flutterm` — test scripts  
**Fixes failures:** S-15, S-16, S-19, S-20, S-24, S-28, S-30  
**Priority:** MEDIUM — fixes 7 failures  
**Estimated effort:** Small per script  

**What to change per script:**

| Script | Fix |
|--------|-----|
| round_slider_thumb_shape_test.dart | Add top-level `dynamic build(BuildContext context)` that calls existing helpers |
| rounded_rect_slider_track_shape_test.dart | Same — add entry point |
| snack_bar_action_test.dart | Same — add entry point |
| visual_density_test.dart | Same — add entry point |
| box_hit_test_result_test.dart | Move `build(BuildContext)` from State class to top level |
| debug_overflow_indicator_mixin_test.dart | Remove `flutter_test` import, restructure as `build()` script |
| performance_overlay_layer_test.dart | Change `Widget build()` to `dynamic build(BuildContext context)` |

Each script needs a top-level function:
```dart
dynamic build(BuildContext context) {
  return MaterialApp(
    home: Scaffold(body: /* compose existing helpers */),
  );
}
```

---

### Fix M — Fix Scripts with Interpreted Native Subclasses

**Component:** `tom_d4rt_flutterm` — test scripts  
**Fixes failures:** S-23, S-25, S-26, S-33  
**Priority:** LOW — requires architectural changes or script rewrite  
**Estimated effort:** Medium  

**What to change:**

These scripts define classes like `_InteractiveHitTestArea extends StatefulWidget` or `GeometricShapesPainter extends CustomPainter` inside the D4rt script. D4rt cannot create native instances of interpreted class declarations.

**Approach A — Rewrite scripts** to avoid custom class declarations:
- Replace custom StatefulWidget subclasses with StatefulBuilder or built-in widgets
- Replace custom CustomPainter subclasses with pre-bridged painter variants
- Remove `UpperCaseTextFormatter extends TextInputFormatter` and use only bridged formatters

**Approach B — Add interpreter support** for `StatefulWidget` and `CustomPainter` subclasses:
- Create proxy factories that generate real native subclass instances backed by D4rt callbacks
- This is a large architectural change, similar to how `callInterpreterCallback` works for Function parameters

**Recommendation:** Approach A for now. These are secondary test scripts that demonstrate advanced patterns not yet supported by D4rt's interpreter.

---

### Fix N — Fix Set Resolution / `Set.contains` (S-10)

**Component:** `tom_d4rt_ast` — `lib/src/runtime/stdlib/core/set.dart` or `environment.dart`  
**Fixes failures:** S-10  
**Priority:** LOW  
**Estimated effort:** Small  

**What to change:**

Verify that the Set literal `{1, 2, 3}` in D4rt is parsed as a `Set`, not a `Map`. If the parser interprets `{}` ambiguously, the internal Set implementation type may not match the Set bridge's `nativeNames`.

Add the Dart SDK Set implementation types to the Set bridge's `nativeNames`:
```dart
nativeNames: [
  '_CompactLinkedHashSet',
  '_UnmodifiableSet',
  'LinkedHashSet',
],
```

Also verify that D4rt's set literal evaluation creates actual `Set` objects (not `Map`).

---

### Fix O — Register Reverse TextStyle Coercion (S-32)

**Component:** `tom_d4rt_flutterm` — `lib/src/d4rt_runtime_registrations.dart`  
**Fixes failures:** S-32  
**Priority:** LOW  
**Estimated effort:** Medium  

**What to change:**

Register a `dart:ui.TextStyle → painting.TextStyle` coercion. Since `dart:ui.TextStyle` is opaque (doesn't expose its fields), the approach is:
- Intercept at the bridge level: when a `dart:ui.TextStyle` is encountered where a `painting.TextStyle` is expected, create a default `painting.TextStyle()` or try to match it using available properties
- Alternatively, ensure the D4rt interpreter always routes `TextStyle()` constructor calls through the painting bridge (higher priority), and flag `dart:ui.TextStyle` as a non-constructable type

**Simpler alternative:** Rewrite the script to avoid the ambiguity (use `import 'package:flutter/material.dart'` exclusively for TextStyle).

---

### Fix P — Fix Remaining Script Bugs (S-8, S-22)

**Component:** `tom_d4rt_flutterm` — test scripts  
**Fixes failures:** S-8, S-22  
**Priority:** LOW  
**Estimated effort:** Small  

| Script | Fix |
|--------|-----|
| ztmp_path_metrics_access_test.dart (S-8) | Add path operations before calling `computeMetrics().first` |
| gravity_simulation_test.dart (S-22) | Fix parameter order: `GravitySimulation(acceleration, distance, endDistance, velocity)` — swap 3rd and 4th args |

---

### Fix Deferred: E + F from flutter_fixes_1.md (I-3)

**Component:** `tom_d4rt` interpreter + `tom_d4rt_generator`  
**Fixes failures:** I-3  
**Priority:** MEDIUM (complex, only 1 failure)  

The `BasicMessageChannel.setMessageHandler` function typing failure requires:
- **Fix E** (from fixes_1): Store class-level type arguments on `BridgedInstance`
- **Fix F** (from fixes_1): Generate type-dispatched method wrappers for generic class methods

These were planned but not implemented in the previous session due to complexity. See flutter_fixes_1.md sections 3.5 and 3.6 for the complete implementation plan.

---

### Fix Deferred: I-2 Deep Investigation

**Component:** `tom_d4rt_ast` / `tom_d4rt_generator`  
**Fixes failures:** I-2  

The `TweenSequenceItem` null-check error needs targeted debugging to identify the exact null-check site. Steps:
1. Run the script in isolation with verbose logging
2. Trace through `D4.findGenericConstructor('TweenSequenceItem')` to see why type args are null
3. The relaxer wrapper and type wrapper machinery exist — the issue is in the construction path, not the re-wrapping path

---

## 5. Implementation Order and Dependencies

```
Phase 1 — High-Impact Runtime Fixes (tom_d4rt_ast)
├─ Fix H: Register ListMapView + harden generic matching     [Small, 7 failures]
├─ Fix I: Generic Enum.name getter                           [Small, 6 failures]
└─ Fix J: Enum == comparison priority                        [Medium, 3+1 failures]

Phase 2 — Registration + Script Fixes (tom_d4rt_flutterm)
├─ Fix K: ButtonSegment registerGenericTypeWrapper           [Small, 1 failure]
├─ Fix L: Fix 7 scripts with missing build()                 [Small, 7 failures]
└─ Fix P: Fix 2 script bugs (path metrics, gravity sim)      [Small, 2 failures]

Phase 3 — Lower Priority
├─ Fix N: Set resolution                                     [Small, 1 failure]
├─ Fix O: TextStyle reverse coercion                         [Medium, 1 failure]
└─ Fix M: Script rewrite for interpreted subclasses          [Medium, 4 failures]

Phase 4 — Complex / Deferred
├─ Fix E+F: Generic class method typing (from fixes_1)       [Large, 1 failure]
└─ Debug I-2: TweenSequenceItem null check                   [Unknown, 1 failure]
```

---

## 6. Expected Outcome by Fix

| Fix | Failures Fixed | Count | Cumulative (of 37) |
|-----|---------------|-------|---------------------|
| H | S-3, S-9, S-11, S-12, S-13, S-14, S-29 | 7 | 7 |
| I | S-1, S-2, S-4, S-5, S-6, S-7 | 6 | 13 |
| J | S-17, S-21, S-31 | 3 | 16 |
| K | I-1 | 1 | 17 |
| L | S-15, S-16, S-19, S-20, S-24, S-28, S-30 | 7 | 24 |
| P | S-8, S-22 | 2 | 26 |
| N | S-10 | 1 | 27 |
| O | S-32 | 1 | 28 |
| M | S-23, S-25, S-26, S-33 | 4 | 32 |
| E+F | I-3 | 1 | 33 |
| I-2 debug | I-2 | 1 | 34 |
| S-34 (list coercion + interpreted class) | S-34 | 1 | 35 |
| S-18, S-27 (mixin support) | S-18, S-27 | 2 | 37 |

**Phase 1 alone (H + I + J):** 16 of 37 failures fixed (43%) — all runtime changes, no regeneration needed.  
**Phase 1 + 2 (H + I + J + K + L + P):** 26 of 37 failures fixed (70%).  
**All actionable fixes:** 32–35 of 37 failures fixed (86–95%).  
**Remaining 2–5:** Require architectural changes (interpreted native subclass support, mixin application) or complex generator work.

---

## 7. Component Change Summary

### tom_d4rt_ast (runtime — THE REAL D4 class)

| File | Change | Fix |
|------|--------|-----|
| `lib/src/runtime/stdlib/core/map.dart` | Add `'ListMapView'` to `nativeNames` | H |
| `lib/src/runtime/environment.dart` | Fix generic type matching to use base-type extraction instead of `contains()` | H |
| `lib/src/runtime/interpreter_visitor.dart` | Add generic `Enum.name` and `Enum.index` handler in property access | I |
| `lib/src/runtime/interpreter_visitor.dart` | Prioritize enum equality over `toBridgedInstance` in `==` operator | J |

### tom_d4rt (pub cache copy — mirror changes)

Same changes as tom_d4rt_ast, mirrored in the local `tom_d4rt` copy.

### tom_d4rt_flutterm (Flutter integration)

| File | Change | Fix |
|------|--------|-----|
| `lib/src/d4rt_runtime_registrations.dart` | Add `registerGenericTypeWrapper('ButtonSegment', ...)` | K |
| 7 test scripts | Add/fix `dynamic build(BuildContext context)` entry point | L |
| 2 test scripts | Fix script bugs (path metrics, gravity sim args) | P |
| 4 test scripts | Rewrite to avoid interpreted native subclasses | M |

### tom_d4rt_generator (code generator)

No generator changes needed for Phase 1+2. Fix E+F (Phase 4) would require generator changes — see flutter_fixes_1.md.

---

## 8. Risk Assessment

| Fix | Risk | Mitigation |
|-----|------|------------|
| H (ListMapView) | Adding nativeNames might clash with other bridges | Verify no other bridge claims `ListMapView`; the hardened matching prevents collisions |
| H (generic matching) | Changing `contains()` to base-type extraction might break valid matches | Test with full regression suite; the new logic is strictly more correct |
| I (Enum.name) | `target is Enum` check adds minor overhead to property access | Only triggers when no other handler matches; minimal overhead path |
| J (enum ==) | Changing operator priority could break non-enum `==` comparisons | Only applies when one operand `is Enum` or `is BridgedEnumValue`; non-enum paths unchanged |
| K (ButtonSegment) | New wrapper factory must match ButtonSegment's actual getter API | ButtonSegment has simple getters (value, icon, label, enabled, tooltip); straightforward |
| L (scripts) | Rewritten scripts might not cover original test intent | Review each script's class coverage goals and ensure `build()` exercises the target class |
| M (interpreted classes) | Rewriting scripts may reduce test coverage depth | Document which patterns are "not yet supported" and create issue for future interpreter support |

---

## 9. Testing Strategy

1. **After Fix H:** Re-run secondary_classes tests — expect S-3, S-9, S-11, S-12, S-13, S-14, S-29 to pass (7 green)
2. **After Fix I:** Re-run secondary_classes — expect S-1, S-2, S-4, S-5, S-6, S-7 to pass (6 green)
3. **After Fix J:** Re-run secondary_classes — expect S-17, S-21, S-31 to pass (3 green)
4. **After Fix K:** Re-run important_classes — expect I-1 (segmentedbutton) to pass
5. **After Fix L+P:** Re-run secondary_classes — expect 9 script-fix failures to pass
6. **Full regression after all Phase 1+2 fixes:**
   - essential_classes: should remain 108/0
   - important_classes: expect 162+/2-
   - secondary_classes: expect 644+/8-
   - hardly_relevant_4 and _5: should remain 228/0 and 230/0
