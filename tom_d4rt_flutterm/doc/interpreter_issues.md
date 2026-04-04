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

## Non-Interpreter Issues

### Cupertino Widget Constraint Issues

Several Cupertino widget tests have layout constraint errors. These are related to how CupertinoTextField and related widgets handle bounded height constraints, not D4rt interpreter bugs.

**Applied Fix**: Added `ConstrainedBox(constraints: BoxConstraints(minHeight: 44))` wrappers around CupertinoTextFormFieldRow, CupertinoFormRow, CupertinoSearchTextField, and CupertinoTextField widgets.

**Result**: Tests now pass (status: success), but some framework errors still occur due to deep internal layout calculations in `_RenderEditableCustomPaint`. The constraint wrapper doesn't fully propagate to the internal editable component.

| File | Status | Remaining Errors |
|------|--------|------------------|
| cupertino/cupertino_form_scroll_test.dart | ✅ Pass | 1 framework error |
| cupertino/cupertino_controls_advanced_test.dart | ✅ Pass | 1 framework error |
| cupertino/cupertino_secondary_test.dart | ✅ Pass | 1 framework error |
| cupertino/cupertino_sections_test.dart | ✅ Pass | 1 framework error |
| cupertino/cupertino_tabbar_scaffold_test.dart | ✅ Pass | 1 framework error |
| cupertino/cupertino_text_selection_controls_test.dart | ✅ Pass | 1 framework error |
| cupertino/cupertino_sheet_transition_test.dart | ✅ Pass | 0 framework errors |

**Root Cause**: CupertinoTextField's `_RenderEditableCustomPaint` internally calculates constraints that can become negative when the parent doesn't provide enough space. The ConstrainedBox wrapper helps but doesn't fully prevent internal constraint issues.

**Further Investigation**: May need to modify test harness constraints or use different layout strategies.

---

## Issue Tracking Notes

When adding new issues:

1. Assign sequential issue numbers (#1, #2, etc.)
2. Include: Status, Severity, Discovered date, Workaround availability
3. Provide minimal reproduction code
4. List all affected test files with line numbers
5. Document the workaround clearly
6. Add root cause analysis if known
