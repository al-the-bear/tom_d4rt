# D4rt Interpreter Issues

This document tracks D4rt interpreter bugs and limitations discovered during Flutter widget testing.

## Issue #1: Generic Type Inference in Callback Return Types

**Status**: Open  
**Severity**: Medium  
**Discovered**: 2026-04-04  
**Workaround**: Available

### Description

The D4rt interpreter fails to infer generic types correctly for list literals returned from callback functions. When a callback returns a list literal `[...]`, the interpreter infers `List<Object?>` instead of the expected type based on context (e.g., `List<Widget>`).

### Reproduction

```dart
// This fails with: type 'List<Object?>' is not a subtype of type 'List<Widget>'
NestedScrollView(
  headerSliverBuilder: (context, innerBoxIsScrolled) => [
    SliverAppBar(title: Text('Title')),
  ],
  body: Container(),
)
```

### Error Message

```
type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast
```

### Affected Test Files

| File | Line | Construct |
|------|------|-----------|
| [nested_scroll_view_state_test.dart](../test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/nested_scroll_view_state_test.dart) | ~20 | `headerSliverBuilder: (ctx, _) => [...]` |
| [nestedscrollview_test.dart](../test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/nestedscrollview_test.dart) | ~20, ~50, ~76, ~102 | `headerSliverBuilder: (ctx, _) => [...]` |
| [render_nested_scroll_view_viewport_test.dart](../test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/widgets/render_nested_scroll_view_viewport_test.dart) | ~20, ~59, ~87, ~136, ~175 | `headerSliverBuilder: (ctx, _) => [...]` |

### Workaround

Add explicit type annotation to the list literal:

```dart
// Use explicit <Widget>[] type annotation
NestedScrollView(
  headerSliverBuilder: (context, innerBoxIsScrolled) => <Widget>[
    SliverAppBar(title: Text('Title')),
  ],
  body: Container(),
)
```

### Root Cause Analysis

The interpreter appears to:
1. Evaluate the callback body independently
2. Infer the list literal type as `List<Object?>` (most general)
3. Attempt to cast the result to the expected return type
4. Fail because `List<Object?>` is not a subtype of `List<Widget>`

Native Dart handles this correctly by inferring the list type from the callback's expected return type.

### Similar Patterns to Watch

Any callback returning a list literal may exhibit this issue:

```dart
// Potentially affected patterns:
itemBuilder: (context, index) => [Widget1(), Widget2()][index]
children: () => [Widget1(), Widget2()]
tabs: items.map((e) => [Tab(text: e)]).expand((x) => x).toList()
```

---

## Issue #2: Missing `int.roundToDouble()` Method

**Status**: Open  
**Severity**: Medium  
**Discovered**: 2026-04-04  
**Workaround**: None documented yet

### Description

The D4rt interpreter does not resolve the `roundToDouble()` method on `int` types. This is a standard Dart `num` method that should be available on both `int` and `double`.

### Error Message

```
Runtime Error: Bridged class 'int' has no instance method named 'roundToDouble'. 
Error during extension lookup: Bridged class 'int' has no instance method named 'roundToDouble'.
```

### Affected Test Files

| File | Category |
|------|----------|
| material/range_slider_track_shape_test.dart | RangeSlider |
| material/range_slider_value_indicator_shape_test.dart | RangeSlider |
| material/range_values_test.dart | RangeSlider |
| material/spell_check_suggestions_toolbar_test.dart | SpellCheck |
| material/tab_bar_theme_data_test.dart | TabBar |

### Root Cause

The `roundToDouble()` method from `dart:core num` class is not exposed in the D4rt bridged `int` class.

### Potential Workaround

```dart
// Instead of:
someInt.roundToDouble()

// Use:
someInt.toDouble()  // if rounding is not needed
// or
(someInt + 0.0)  // cast to double first
```

---

## Issue #3: Missing `List.whereType<T>()` Method

**Status**: Open  
**Severity**: Medium  
**Discovered**: 2026-04-04  
**Workaround**: None documented yet

### Description

The D4rt interpreter does not resolve the `whereType<T>()` method on `List` (inherited from `Iterable`). This is used to filter list elements by runtime type.

### Error Message

```
Runtime Error: Bridged class 'List' has no instance method named 'whereType'. 
Error during extension lookup: Bridged class 'List' has no instance method named 'whereType'.
```

### Affected Test Files

| File | Category |
|------|----------|
| widgets/animated_cross_fade_test.dart | Animation |
| widgets/animated_switcher_test.dart | Animation |
| widgets/backdrop_filter_test.dart | Effects |
| widgets/physical_model_test.dart | Rendering |

### Root Cause

The `whereType<T>()` method from `dart:core Iterable` is not exposed in the D4rt bridged `List` class.

### Potential Workaround

```dart
// Instead of:
myList.whereType<Widget>()

// Use:
myList.where((e) => e is Widget).cast<Widget>()
```

---

## Issue #4: State.widget Property Not Resolved

**Status**: Open  
**Severity**: High  
**Discovered**: 2026-04-04  
**Workaround**: None

### Description

The D4rt interpreter cannot resolve the implicit `widget` getter property on `State<T>` subclasses. This is a fundamental Flutter pattern where State classes access their associated StatefulWidget via `this.widget`.

### Error Message

```
Runtime Error: Undefined variable: widget 
(Original error: Undefined property 'widget' on _VerticalTrackState.)
```

### Affected Test Files

| File | Category |
|------|----------|
| gestures/vertical_multi_drag_gesture_recognizer_test.dart | Gestures |

### Root Cause

The `widget` property is an inherited getter from `State<T>` that returns `T`. The D4rt interpreter's property resolution doesn't follow inheritance chains for implicit getters on bridged classes.

### Impact

This blocks any StatefulWidget test that accesses `widget` in its State class.

---

## Issue #5: layoutChild Property Not Resolved on Delegates

**Status**: Open  
**Severity**: Medium  
**Discovered**: 2026-04-04  
**Workaround**: None

### Description

The D4rt interpreter cannot resolve the `layoutChild` method/property on custom `MultiChildLayoutDelegate` subclasses.

### Error Message

```
Runtime Error: Undefined variable: layoutChild 
(Original error: Undefined property 'layoutChild' on TestMultiChildLayoutDelegate.)
```

### Affected Test Files

| File | Category |
|------|----------|
| widgets/layout_builder_adv_test.dart | Layout |

### Root Cause

Similar to Issue #4 - inherited methods from abstract delegate base classes are not resolved correctly.

---

## Issue #6: Function Type Mismatch with `semanticsBuilder`

**Status**: Open  
**Severity**: Medium  
**Discovered**: 2026-04-04  
**Workaround**: None documented yet

### Description

The D4rt interpreter fails type checking when assigning an interpreted function to the `semanticsBuilder` parameter of `CustomPainter`. The expected type includes a nullable function type that the interpreter doesn't match correctly.

### Error Message

```
Argument Error: Invalid parameter "semanticsBuilder": 
expected ((Size) => List<CustomPainterSemantics>)?, got InterpretedFunction
```

### Affected Test Files

| File | Category |
|------|----------|
| rendering/custom_painter_semantics_test.dart | CustomPainter |

### Root Cause

The D4rt interpreter's `InterpretedFunction` type is not recognized as matching the expected `((Size) => List<CustomPainterSemantics>)?` function type.

---

## Issue #7: Exhaustive Switch on Enums Not Recognized

**Status**: Fixed (test script)
**Severity**: Low  
**Discovered**: 2026-04-04  
**Workaround**: Add default case to switch statements

### Description

The D4rt interpreter does not recognize exhaustive switch statements on enum types. Native Dart guarantees all cases are covered for enum switches without a default case, but D4rt may return null if no case matches.

### Error Message

```
Runtime Error: Cannot invoke method 'withValues' on null. 
Use '?.' for null-aware method invocation.
```

### Root Cause

The `colorForChange(PointerChange)` and `iconForKind(PointerDeviceKind)` functions had exhaustive switch statements covering all enum values, but D4rt didn't recognize this as exhaustive and could return null.

### Solution Applied

Added `default:` case to the switch statements that return a sensible fallback value:

```dart
Color colorForChange(ui.PointerChange value) {
  switch (value) {
    case ui.PointerChange.cancel:
      return const Color(0xFFD32F2F);
    // ... other cases ...
    default:
      // D4rt interpreter may not recognize exhaustive enum switches
      return const Color(0xFF9E9E9E);
  }
}
```

### Affected Test Files

| File | Category | Status |
|------|----------|--------|
| dart_ui/pointer_data_test.dart | Input | ✅ Fixed |

---

## Issue #8: dart:ui/math.dart Assertion Failure

**Status**: Open  
**Severity**: Medium  
**Discovered**: 2026-04-04  
**Workaround**: None

### Description

The D4rt interpreter fails an assertion in `dart:ui/math.dart` during Scene rendering tests. The assertion occurs at line 14 position 10 with an `<optimized out>` placeholder in the error.

### Error Message

```
'dart:ui/math.dart': Failed assertion: line 14 pos 10: '<optimized out>': is not true.
```

### Affected Test Files

| File | Category |
|------|----------|
| dart_ui/scene_test.dart | Rendering |

### Root Cause

The dart:ui math library has internal assertions that fail during interpretation—likely related to matrix or transform calculations used in Scene composition.

---

## Issue #9: Vertices Constructor Bridge Error

**Status**: Open  
**Severity**: Medium  
**Discovered**: 2026-04-04  
**Workaround**: None

### Description

The D4rt bridge for the `Vertices` constructor throws an error when the `positions` parameter is null. This occurs even when creating valid Vertices objects with proper parameters.

### Error Message

```
Runtime Error: Native error during default bridged constructor for 'Vertices': 
Argument Error: Invalid parameter "positions": expected List<Offset>, got null
```

### Affected Test Files

| File | Category |
|------|----------|
| dart_ui/vertex_mode_test.dart | Rendering |

### Root Cause

The D4rt bridge code for the `Vertices` class may have issues with parameter passing or null checking before invoking the native constructor.

---

## Issue #10: Bridged Mixins Cannot Be Used as Mixins

**Status**: Open  
**Severity**: High  
**Discovered**: 2026-04-04  
**Workaround**: Available (remove mixin, replace AnimationController with static value)

### Description

Bridged classes like `SingleTickerProviderStateMixin`, `TickerProviderStateMixin`, `ChangeNotifier`, `DiagnosticableTreeMixin`, `ContainerRenderObjectMixin`, `AutomaticKeepAliveClientMixin`, and `RouteAware` cannot be used as mixins in interpreted code. The bridge does not have `canBeUsedAsMixin=true` set.

### Error Message

```
Bridged class 'SingleTickerProviderStateMixin' cannot be used as a mixin. Set canBeUsedAsMixin=true when registering the bridge.
```

### Affected Files (15 in dart_ui/ — fixed by removing mixin)

- clip_rect_engine_layer_test.dart
- image_filter_engine_layer_test.dart
- image_sampler_slot_test.dart
- image_descriptor_test.dart
- immutable_buffer_test.dart
- key_data_test.dart
- locale_string_attribute_test.dart
- path_metric_iterator_test.dart
- path_metrics_test.dart
- platform_dispatcher_test.dart
- isolate_name_server_test.dart
- key_event_device_type_test.dart
- key_event_type_test.dart
- picture_rasterization_exception_test.dart
- plugin_utilities_test.dart

### Additional Affected Files (batch 14 — fixed by removing mixin)

- material/scaffold_messenger_test.dart (SingleTickerProviderStateMixin)
- material/no_splash_test.dart (SingleTickerProviderStateMixin)
- foundation/diagnosticable_tree_mixin_test.dart (DiagnosticableTreeMixin)
- rendering/container_render_object_mixin_test.dart (ContainerRenderObjectMixin)

### Workaround

Remove `with SingleTickerProviderStateMixin` from the State class, remove the `AnimationController`, replace `controller.value` with a static `double _animValue = 0.0`, and inline `AnimatedBuilder` children into `Builder` or the parent widget.

### Proper Fix

Set `canBeUsedAsMixin=true` in the bridge registration for all classes intended to be used as mixins.

---

## Issue #11: Deprecated ButtonBar/ButtonBarThemeData Classes Not Bridged

**Status**: Open  
**Severity**: Low  
**Discovered**: 2026-04-04  
**Workaround**: Available (local shim classes using OverflowBar)

### Description

The deprecated `ButtonBar`, `ButtonBarThemeData`, and `ButtonBarTheme` classes from Flutter's material library are not available in the D4rt bridge. These classes were deprecated in Flutter 3.0 and replaced with `OverflowBar`.

### Error Message

```
Undefined variable: ButtonBar
Undefined variable: ButtonBarThemeData
```

### Affected Test Files

- button_bar_test.dart
- button_bar_theme_data_test.dart
- button_bar_theme_test.dart

### Workaround

Add local shim classes at the top of the script that delegate to `OverflowBar`:

```dart
Widget ButtonBar({
  MainAxisAlignment alignment = MainAxisAlignment.end,
  List<Widget> children = const [],
}) {
  return OverflowBar(alignment: alignment, spacing: 8.0, children: children);
}
```

---

## Issue #12: ui.window (SingletonFlutterWindow) Not Available

**Status**: Open  
**Severity**: Low  
**Discovered**: 2026-04-04  
**Workaround**: Available (use View.of(context) instead)

### Description

The deprecated `ui.window` getter (returning `SingletonFlutterWindow`) is not available in the D4rt bridge. This was deprecated in Flutter 3.7 and replaced with `View.of(context)` and `PlatformDispatcher.instance`.

### Error Message

```
Erreur lors de la récupération du membre 'window' de l'import préfixé 'SSimpleIdentifier(ui)': Undefined variable: window
```

### Affected Test Files

- dart_ui/singleton_flutter_window_test.dart

### Workaround

Replace `ui.window` with `View.of(context)`:

```dart
// Before:
final window = ui.window;
// After:
final view = View.of(context);
```

---

## Issue #13: Factory.constructor Property Not Accessible

**Status**: Open  
**Severity**: Low  
**Discovered**: 2026-04-04  
**Workaround**: Available (use local wrapper class)

### Description

The `constructor` getter on Flutter's `Factory<T>` class is not accessible in the D4rt bridge. The property name `constructor` likely conflicts with the bridge's internal method resolution.

### Error Message

```
Bridged class 'Factory' has no instance method named 'constructor'. Error during extension lookup: Bridged class 'Factory' has no instance method named 'constructor'.
```

### Affected Test Files

- foundation/factory_test.dart

### Workaround

Use a local wrapper class instead of Flutter's `Factory`:

```dart
class FactoryWrapper<T> {
  final T Function() builder;
  FactoryWrapper(this.builder);
  T call() => builder();
}
```

---

## Issue #14: Deprecated RawKeyboard API Classes Not Bridged

**Status**: Open  
**Severity**: Low  
**Discovered**: 2026-04-04  
**Workaround**: Available (local shim classes/enums)

### Description

The deprecated RawKeyboard API from `package:flutter/services.dart` is not bridged in D4rt. This includes enums (`KeyDataTransitMode`, `KeyboardSide`, `ModifierKey`), helper classes (`KeyHelper`, `KeyMessage`), platform-specific data classes (`RawKeyEventDataAndroid`, `RawKeyEventDataFuchsia`, `RawKeyEventDataIos`, `RawKeyEventDataLinux`, `RawKeyEventDataWeb`, `RawKeyEventDataWindows`), and the `RawKeyboard` singleton service.

These classes were deprecated in Flutter 3.18+ in favor of the new `KeyEvent` / `HardwareKeyboard` system.

### Error Messages

```
Undefined variable: KeyDataTransitMode
Undefined variable: KeyHelper
Undefined variable: KeyMessage
Undefined variable: KeyboardSide
Undefined variable: ModifierKey
Undefined variable: RawKeyEventDataAndroid
Undefined variable: RawKeyEventDataFuchsia
Undefined variable: RawKeyEventDataIos
Undefined variable: RawKeyEventDataLinux
Undefined variable: RawKeyEventDataWeb
Undefined variable: RawKeyEventDataWindows
Undefined variable: RawKeyboard
```

### Affected Test Files

- services/key_data_transit_mode_test.dart
- services/key_helper_test.dart
- services/key_message_test.dart
- services/keyboard_side_test.dart
- services/modifier_key_test.dart
- services/raw_key_event_data_android_test.dart
- services/raw_key_event_data_fuchsia_test.dart
- services/raw_key_event_data_ios_test.dart
- services/raw_key_event_data_linux_test.dart
- services/raw_key_event_data_web_test.dart
- services/raw_key_event_data_windows_test.dart
- services/raw_keyboard_test.dart

### Workaround

Add local shim classes/enums that shadow the missing types. For enums, define matching enum values. For data classes, create minimal classes with the same constructor parameters and property getters as accessed in the script.

```dart
// Enum shim example:
enum KeyDataTransitMode { keyDataChannel, rawKeyData }

// Data class shim example:
class RawKeyEventDataAndroid {
  final int flags, codePoint, keyCode, scanCode, metaState;
  RawKeyEventDataAndroid({required this.flags, required this.codePoint,
    required this.keyCode, required this.scanCode, required this.metaState});
  PhysicalKeyboardKey get physicalKey => PhysicalKeyboardKey(scanCode + 0x70000);
  LogicalKeyboardKey get logicalKey => LogicalKeyboardKey(codePoint);
  bool get isControlPressed => (metaState & 4096) != 0;
  // ...
}

// Singleton shim example:
class RawKeyboard {
  static final RawKeyboard instance = RawKeyboard._();
  RawKeyboard._();
  Set<LogicalKeyboardKey> get keysPressed => <LogicalKeyboardKey>{};
}
```

---

## Issue #15: Uint8List Not Available in D4rt Bridge

**Status**: Open  
**Severity**: Medium  
**Discovered**: 2026-04-04  
**Workaround**: Available (use ByteData directly)

### Description

`Uint8List` from `dart:typed_data` is not available in the D4rt bridge. Scripts that use `Uint8List.fromList(...)` for byte manipulation fail with an undefined variable error.

### Error Message

```
Undefined variable: Uint8List
```

### Affected Test Files

- services/codecs_test.dart

### Workaround

Replace `Uint8List` usage with `ByteData` which is available:

```dart
// Before:
final bytes = Uint8List.fromList([1, 2, 3, 4, 5]);
final binaryEncoded = binaryCodec.encodeMessage(bytes.buffer.asByteData());

// After:
final byteData = ByteData(5);
for (var i = 0; i < 5; i++) {
  byteData.setUint8(i, i + 1);
}
final binaryEncoded = binaryCodec.encodeMessage(byteData);
```

---

## Issue #10 — Additional Affected Files (Batch 15)

- rendering/render_sliver_box_child_manager_test.dart (AutomaticKeepAliveClientMixin)

## Issue #10 — Additional Affected Files (Batch 16)

Workaround: added `import 'package:flutter/scheduler.dart';` and local `_TickerProviderShim` mixin (already present from prior generation), or local `_ChangeNotifierShim` mixin. No animation code removed — shim replaces unbridgeable mixin.

- widgets/align_transition_test.dart (SingleTickerProviderStateMixin — scheduler import added)
- widgets/clip_r_superellipse_test.dart (SingleTickerProviderStateMixin — scheduler import added)
- widgets/default_text_style_transition_test.dart (TickerProviderStateMixin — scheduler import added)
- widgets/fractional_translation_test.dart (SingleTickerProviderStateMixin — scheduler import added)
- widgets/icon_theme_data_test.dart (SingleTickerProviderStateMixin — scheduler import added)
- widgets/animated_modal_barrier_test.dart (TickerProviderStateMixin — scheduler import added)
- widgets/color_filtered_test.dart (SingleTickerProviderStateMixin — scheduler import added)
- widgets/dual_transition_builder_test.dart (SingleTickerProviderStateMixin — scheduler import added)
- widgets/image_filtered_test.dart (SingleTickerProviderStateMixin — scheduler import added)
- widgets/performance_overlay_test.dart (SingleTickerProviderStateMixin — scheduler import added)
- widgets/back_button_listener_test.dart (ChangeNotifier — local _ChangeNotifierShim mixin)

## Issue #10 — Additional Affected Files (Batch 17)

Workaround: added `import 'package:flutter/scheduler.dart';` and local `_TickerProviderShim` mixin with `createTicker` implementation. Replaced `with SingleTickerProviderStateMixin` / `with TickerProviderStateMixin` with `with _TickerProviderShim`.

- widgets/shader_mask_test.dart (SingleTickerProviderStateMixin)
- widgets/single_ticker_provider_state_mixin_test.dart (SingleTickerProviderStateMixin + runApp→build conversion)
- widgets/ticker_provider_state_mixin_test.dart (TickerProviderStateMixin)
- widgets/matrix_transition_test.dart (SingleTickerProviderStateMixin)
- widgets/nested_scroll_view_viewport_test.dart (SingleTickerProviderStateMixin)

## Issue #10 — Additional Affected Files (Batch 18)

Workaround: added local `_RouteAwareShim` mixin (stubs for `didPopNext`, `didPush`, `didPop`, `didPushNext`) and local `_ChangeNotifierShim` mixin (stubs for `addListener`, `removeListener`, `notifyListeners`, `dispose`).

- widgets/route_aware_test.dart (RouteAware → _RouteAwareShim)
- widgets/router_config_test.dart (ChangeNotifier → _ChangeNotifierShim)

---

## Issue #16 — ToolbarOptions Not Bridged (Batch 21)

- **Status:** Open
- **Severity:** Low (deprecated API)
- **Discovered:** Batch 21
- **Workaround:** None — script is valid Dart but `ToolbarOptions` is not available in D4rt runtime

The `ToolbarOptions` class (deprecated in Flutter) is not bridged in D4rt. The test script compiles fine with `dart analyze` but fails at runtime with "undefined var: ToolbarOptions".

**Affected files:**
- widgets/toolbar_options_test.dart

---

## Issue #17 — Assertion Failure in Animation Constructors (Batch 21)

- **Status:** Open
- **Severity:** Medium
- **Discovered:** Batch 21
- **Workaround:** None — runtime assertion failures in constructors

Animation curve constructors (e.g., `CatmullRomCurve`, `CatmullRomSpline`, `Curve2DSample`) throw assertion errors when constructed in the D4rt interpreter, likely due to missing or incorrect parameter handling during bridge invocation.

**Affected files:**
- animation/catmull_rom_curve_test.dart
- animation/catmull_rom_spline_test.dart
- animation/curve2_d_sample_test.dart
- animation/curve2_d_test.dart

---

## Issue #18 — Bridged Method 'reduce' Error on Iterable (Batch 21)

- **Status:** Open
- **Severity:** Medium
- **Discovered:** Batch 21
- **Workaround:** None — native function type mismatch during `reduce` call

Calling `reduce` on bridged `Iterable` instances fails with "type 'NativeFunction' is not a subtype of type expected". This affects animation tests that iterate over curve data.

**Affected files:**
- animation/curve_tween_test.dart
- animation/elastic_in_out_curve_test.dart
- animation/elastic_out_curve_test.dart
- animation/flipped_curve_test.dart

---

## Issue #19 — Null Check Failed in Animation Tests (Batch 21)

- **Status:** Open
- **Severity:** Medium
- **Discovered:** Batch 21
- **Workaround:** None — null check operator used on null value during bridge execution

Animation tests using `ReverseTween` and `TweenSequence` fail with null check errors, likely due to incomplete bridging of tween/animation state.

**Affected files:**
- animation/reverse_tween_test.dart
- animation/tweensequence_test.dart

---

## Issue #20 — Unsupported Target for Indexing: null (Batch 21)

- **Status:** Open
- **Severity:** Medium
- **Discovered:** Batch 21
- **Workaround:** None — indexing operation on null target

The `dart_ui/color_space_test.dart` fails with "Unsupported target for indexing: null", suggesting the interpreter cannot resolve enum values or indexed access for `ColorSpace`.

**Affected files:**
- dart_ui/color_space_test.dart

---

## Issue #21 — Enum hashCode Not Available (Batch 21)

- **Status:** Open
- **Severity:** Medium
- **Discovered:** Batch 21
- **Workaround:** None — enum `hashCode` property not accessible in interpreter

Bridged enums like `DisplayFeatureState` do not expose `hashCode` correctly in the D4rt interpreter, causing test failures when comparing enum instances.

**Affected files:**
- dart_ui/display_feature_state_test.dart

---

## Issue #21 — Additional Affected Files (Batch 22)

8 more enum hashCode failures:

- dart_ui/display_feature_type_test.dart (DisplayFeatureType)
- dart_ui/filter_quality_test.dart (FilterQuality)
- dart_ui/font_style_test.dart (FontStyle)
- dart_ui/semantics_hit_test_behavior_test.dart (SemanticsHitTestBehavior)
- dart_ui/semantics_input_type_test.dart (SemanticsInputType)
- dart_ui/semantics_role_test.dart (SemanticsRole)
- dart_ui/semantics_validation_result_test.dart (SemanticsValidationResult)
- dart_ui/stroke_join_test.dart (StrokeJoin)

---

## Issue #22 — Undefined Property 'name' on Bridged Instances (Batch 22)

- **Status:** Open
- **Severity:** Medium
- **Discovered:** Batch 22
- **Workaround:** None — runtime property access failure

Accessing the `name` property on bridged enum/class instances fails with "undefined: name on bridged instance". The `.name` getter is not exposed through the bridge for certain types.

**Affected files:**
- dart_ui/image_byte_format_test.dart (bridged instance of 'Image')
- dart_ui/path_fill_type_test.dart (bridged instance of 'Path')
- dart_ui/path_operation_test.dart (bridged instance of 'Path')
- dart_ui/placeholder_alignment_test.dart (bridged instance of 'Placeholder')

---

## Issue #23 — Undefined 'toString' on Bridged Enum (Batch 22)

- **Status:** Open
- **Severity:** Medium
- **Discovered:** Batch 22
- **Workaround:** None — toString not accessible on bridged enum

The `toString` method on bridged enums like `StrokeCap` is not properly forwarded through the bridge, causing "undefined: toString on StrokeCap" errors.

**Affected files:**
- dart_ui/painting_style_test.dart

---

## Issue #24 — Test Assertion Mismatch (Expected: true) (Batch 22)

- **Status:** Open
- **Severity:** Low
- **Discovered:** Batch 22
- **Workaround:** None — runtime behavior differs from expected

Test assertions return unexpected values, likely due to incomplete bridging of underlying APIs. The scripts are valid Dart but produce different results in D4rt.

**Affected files:**
- dart_ui/individual_ztmp_path_metrics_access_test.dart

---

## Issue #21 — Additional Affected Files (Batch 23)

4 more enum hashCode failures:

- dart_ui/target_pixel_format_test.dart (TargetPixelFormat)
- dart_ui/text_align_test.dart (TextAlign)
- dart_ui/text_direction_test.dart (TextDirection)
- dart_ui/tile_mode_test.dart (TileMode)

---

## Issue #22 — Additional Affected Files (Batch 23)

5 more undefined 'name' on bridged instance failures:

- dart_ui/text_affinity_test.dart (bridged instance of 'Text')
- dart_ui/text_baseline_test.dart (bridged instance of 'Text')
- dart_ui/text_decoration_style_test.dart (bridged instance of 'TextDecoration')
- dart_ui/view_focus_direction_test.dart (bridged instance of 'View')
- dart_ui/view_focus_state_test.dart (bridged instance of 'View')

---

## Issue #24 — Additional Affected Files (Batch 23)

1 more Expected: true assertion mismatch:

- dart_ui/system_color_palette_test.dart

---

## Issue #25 — Native Error During Bridged Constructor (Batch 23)

- **Status:** Open
- **Severity:** Medium
- **Discovered:** Batch 23
- **Workaround:** None — constructor argument errors in bridge

Bridged constructors for certain classes fail with "Native error during default bridged constructor" due to argument type mismatches or missing parameter handling.

**Affected files:**
- foundation/diagnostics_stack_trace_test.dart (DiagnosticsStackTrace)
- gestures/flutter_error_details_for_pointer_event_dispatcher_test.dart (FlutterErrorDetailsForPointerEventDispatcher)

---

## Issue #26 — Not Callable: Object (Batch 23)

- **Status:** Open
- **Severity:** Medium
- **Discovered:** Batch 23
- **Workaround:** None — Object constructor not callable in interpreter

Attempting to create instances of classes extending `Object` fails with "not callable: Object". The D4rt interpreter does not properly handle explicit `Object()` constructor calls.

**Affected files:**
- foundation/object_created_test.dart
- foundation/object_disposed_test.dart
- foundation/object_event_test.dart

---

## Issue #17 — Additional Affected Files (Batch 24)

**Affected files:**
- gestures/tap_move_details_test.dart (assertion failure in constructor)

---

## Issue #19 — Additional Affected Files (Batch 24)

**Affected files:**
- material/collapse_mode_test.dart (null check failed)
- material/floating_label_behavior_test.dart (null check failed)

---

## Issue #22 — Additional Affected Files (Batch 24)

**Affected files:**
- painting/enums_painting_test.dart (undefined: name on bridged instance of 'Image')
- rendering/decoration_position_test.dart (undefined: name on bridged instance of 'Decoration')

---

## Issue #23 — Additional Affected Files (Batch 24)

**Affected files:**
- rendering/cross_axis_alignment_test.dart (undefined: toString on CrossAxisAlignment)

---

## Issue #24 — Additional Affected Files (Batch 24)

**Affected files:**
- material/bottom_navigation_bar_type_test.dart (Expected: true)

---

## Issue #25 — Additional Affected Files (Batch 24)

**Affected files:**
- painting/decoration_image_painter_test.dart (Native error during default bridged constructor for 'Text')

---

## Issue #27 — Private Class Constructor Not Resolved (Batch 24)

- **Status:** Open
- **Severity:** Medium
- **Discovered:** Batch 24
- **Workaround:** None — D4rt cannot resolve constructors for private classes

The D4rt interpreter fails to resolve constructors for private classes (prefixed with `_`). When a script defines a private class and attempts to instantiate it, the interpreter reports "no constructor" for the class.

**Affected files:**
- material/text_button_theme_data_test.dart (no constructor: _ThemeRecipe)
- material/text_selection_toolbar_test.dart (no constructor: _ScenarioCard)
- material/text_selection_toolbar_text_button_test.dart (no constructor: _ButtonFamily)

---

## Issue #28 — Undefined 'map' on _ConstSet (Batch 24)

- **Status:** Open
- **Severity:** Medium
- **Discovered:** Batch 24
- **Workaround:** None — bridged Set iteration methods not available

The D4rt interpreter does not expose the `map` method on `_ConstSet<T>` (the internal Set implementation). When calling `.map()` on a constant Set returned from a bridged API, the interpreter reports the method as undefined.

**Affected files:**
- material/material_scroll_behavior_test.dart (undefined: map on _ConstSet<PointerDeviceKind>)

---

## Issue #29 — Private Class Type Cannot Be Returned from Function (Batch 24)

- **Status:** Open
- **Severity:** Medium
- **Discovered:** Batch 24
- **Workaround:** None — D4rt type system rejects private class return types

The D4rt interpreter rejects returning instances of private classes from functions, reporting "A value of type '_ClassName' can't be returned from the function". This occurs even though the private class extends a public class (e.g., StatefulWidget) and the function's return type is compatible.

**Affected files:**
- rendering/annotation_entry_test.dart (return _InteractiveAnnotationDemo)
- rendering/annotation_result_test.dart (return _MultipleEntriesWidget)
- rendering/cache_extent_style_test.dart (return _InteractiveComparisonWidget)

---

## Issue #22 — Additional Affected Files (Batch 25)

**Affected files:**
- rendering/flex_fit_test.dart (undefined: name on bridged instance of 'Flex')

---

## Issue #24 — Additional Affected Files (Batch 25)

**Affected files:**
- rendering/box_hit_test_result_test.dart (Expected: true)
- rendering/platform_view_layer_test.dart (Expected: true)

---

## Issue #27 — Additional Affected Files (Batch 25)

**Affected files:**
- rendering/relayout_when_system_fonts_change_mixin_test.dart (no constructor: _Profile)
- rendering/render_absorb_pointer_test.dart (no constructor: _Profile)
- rendering/render_aligning_shifted_box_test.dart (no constructor: _ThemePreset)
- rendering/render_animated_opacity_test.dart (no constructor: _ThemeTrack)
- rendering/render_animated_size_test.dart (no constructor: _ThemePreset)
- rendering/render_annotated_region_test.dart (no constructor: _ThemePreset)
- rendering/render_backdrop_filter_test.dart (no constructor: _ThemePreset)
- rendering/render_baseline_test.dart (no constructor: _ThemePreset)

---

## Issue #29 — Additional Affected Files (Batch 25)

**Affected files:**
- rendering/box_hit_test_entry_test.dart (return _InteractiveHitTestArea)
- rendering/clip_r_superellipse_layer_test.dart (return _CornerComparisonWidget)
- rendering/container_box_parent_data_test.dart (return _InteractiveOffsetWidget)

---

## Issue #30 — Null Method Invocation on Bridged Const Color (Batch 25)

- **Status:** Open
- **Severity:** Medium
- **Discovered:** Batch 25
- **Workaround:** None — const Color values resolve to null at runtime

The D4rt interpreter fails to resolve top-level `const Color(...)` declarations, resulting in null values at runtime. When methods like `withAlpha()` are invoked on these null references, the interpreter reports "Cannot invoke method 'withAlpha' on null".

**Affected files:**
- rendering/hit_test_behavior_test.dart (Cannot invoke method 'withAlpha' on null — _kPink800 is `const Color(0xFF9D174D)`)

---

## Issue #24 — Additional Affected Files (Batch 26)

**Affected files:**
- rendering/render_semantics_annotations_test.dart (Expected: true)
- rendering/render_semantics_gesture_handler_test.dart (Expected: true)

---

## Issue #27 — Additional Affected Files (Batch 26)

**Affected files:**
- rendering/render_block_semantics_test.dart (no constructor: _ThemePreset)
- rendering/render_box_container_defaults_mixin_test.dart (no constructor: _ThemeProfile)
- rendering/render_constrained_overflow_box_test.dart (no constructor: _ThemePreset)
- rendering/render_custom_multi_child_layout_box_test.dart (no constructor: _ThemePreset)
- rendering/render_custom_paint_test.dart (no constructor: _PaintThemePreset)
- rendering/render_custom_single_child_layout_box_test.dart (no constructor: _ThemePreset)
- rendering/render_physical_model_test.dart (no constructor: _ThemePreset)
- rendering/render_physical_shape_test.dart (no constructor: _ThemeProfile)
- rendering/render_pointer_listener_test.dart (no constructor: _ThemePreset)
- rendering/render_proxy_box_mixin_test.dart (no constructor: _ThemePack)
- rendering/render_proxy_box_with_hit_test_behavior_test.dart (no constructor: _ThemeProfile)
- rendering/render_repaint_boundary_test.dart (no constructor: _ThemePalette)
- rendering/render_rotated_box_test.dart (no constructor: _ThemePack)

---

## Issue Tracking Notes

When adding new issues:

1. Assign sequential issue numbers (#1, #2, etc.)
2. Include: Status, Severity, Discovered date, Workaround availability
3. Provide minimal reproduction code
4. List all affected test files with line numbers
5. Document the workaround clearly
6. Add root cause analysis if known
