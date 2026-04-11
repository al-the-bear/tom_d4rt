# Error Analysis: 20260411-1207-issue-analysis

## Run Metadata

| Field | Value |
|-------|-------|
| Run ID | `20260411-1207-issue-analysis` |
| Revision | `4ce8091c` |
| Suites | 8 (essential, important, secondary, hr1-hr5) |
| Batches | 2 (Batch 0: suites 0-4, Batch 1: suites 5-7) |
| Total Issues | 551 |
| Categories | 29 |
| Missing Scripts | 0 |
| Stray Scripts | 15 |

## Executive Summary

### Issue Distribution by Group

| Group | Count | % | Top Categories |
|-------|------:|--:|----------------|
| Transport Issues | 251 | 45.6% | TRANSPORT-CASCADE (249), TRANSPORT-ERROR (2) |
| Script Issues | 116 | 21.1% | SCRIPT-LATEINIT (106), SCRIPT-TIMEOUT (9), SCRIPT-GLOBALKEY (1) |
| Bridge/Generator Issues | 84 | 15.2% | BRIDGE-INTERPRETED-INSTANCE (28), BRIDGE-MISSING-CONSTRUCTOR (15), BRIDGE-NATIVE-ERROR (11) |
| Interpreter Issues | 33 | 6.0% | INTERPRETER-STATE-ACCESS (17), INTERPRETER-NULL-INVOKE (4), INTERPRETER-SWITCH (4) |
| Framework Noise | 67 | 12.2% | FW-LAYOUT-CONSTRAINT (30), FW-LAYOUT-OVERFLOW (27), FW-ASSERTION (4) |

### Key Findings

1. **Transport cascades dominate (45%)**:  249 tests failed due to cascade effects from 2 transport errors. Fixing the 2 transport errors would eliminate ~45% of all issues.
2. **Script late-init issues (19%)**:  106 scripts use `late` variables that the D4rt interpreter cannot resolve. Refactoring scripts to avoid `late` fields or use nullable + null-check patterns would fix these.
3. **Bridge gaps (14%)**:  84 issues from missing constructors, type mismatches, or InterpretedInstance returns. These need bridge generator improvements or UserBridge overrides.
4. **Framework noise (12%)**:  67 issues are layout constraint errors, overflow, or framework assertions. Most are non-critical and can be fixed by adjusting script layout constraints.
5. **Interpreter issues (5%)**:  32 issues from State property access, generic inference, switch expressions, or null handling. Some have known workarounds.

### Category Reference

| Category | Count | Fix | Description |
|----------|------:|-----|-------------|
| `TRANSPORT-CASCADE` | 249 | No - fix upstream transport error first | Cascade: earlier transport error caused downstream failures |
| `SCRIPT-LATEINIT` | 106 | Yes - refactor script to avoid late fields or use nullable + null-check | Script uses late variables; interpreter cannot resolve late initialization |
| `FW-LAYOUT-CONSTRAINT` | 30 | Maybe - fix layout in script | Layout constraint error (framework noise) |
| `BRIDGE-INTERPRETED-INSTANCE` | 28 | Yes - fix bridge type resolution or add UserBridge | Bridge returns InterpretedInstance instead of typed widget |
| `FW-LAYOUT-OVERFLOW` | 27 | Maybe - adjust script layout constraints | Layout overflow or unbounded flex (framework noise) |
| `INTERPRETER-STATE-ACCESS` | 17 | Maybe - add explicit getter in script or UserBridge override | Interpreter cannot resolve State/Delegate/Controller property access |
| `BRIDGE-MISSING-CONSTRUCTOR` | 15 | Yes - add constructor to bridge generator | Bridge missing constructor for class |
| `BRIDGE-NATIVE-ERROR` | 11 | Maybe - add UserBridge override for method | Native error during bridged method call |
| `BRIDGE-GENERIC-CONSTRUCTOR` | 9 | Yes - add UserBridge generic constructor override | Bridge generic constructor factory error |
| `SCRIPT-TIMEOUT` | 9 | Yes - simplify script or add timeout handling | Build timed out (script too complex or has infinite loop) |
| `BRIDGE-MISSING-TYPE` | 6 | Yes - add to bridge generator or UserBridge | Bridge missing type/class definition |
| `BRIDGE-MISSING-METHOD` | 4 | Yes - add method to bridge or UserBridge override | Bridge missing method implementation |
| `FW-ASSERTION` | 4 | Maybe - investigate assertion context | Flutter framework assertion failure |
| `INTERPRETER-NULL-INVOKE` | 4 | Maybe - check null safety in script | Method invocation on null |
| `BRIDGE-NOT-CALLABLE` | 4 | Yes - add constructor to bridge | Bridge missing constructor (type is not callable) |
| `INTERPRETER-SWITCH` | 4 | Yes - add default/wildcard case in script | Non-exhaustive switch expression |
| `FW-OTHER` | 4 | Needs investigation | Uncategorized framework error |
| `BRIDGE-TYPE-MISMATCH-FW` | 3 | Yes - add D4.coerceList/coerceMap or UserBridge | Type mismatch in framework error (bridge coercion gap) |
| `INTERPRETER-GENERIC-INFERENCE` | 2 | Yes - add explicit type annotations in script | Known issue #1: generic type inference (List<Object?> vs List<Widget>) |
| `BRIDGE-TYPE-MISMATCH` | 2 | Yes - add D4.coerceList/coerceMap or UserBridge | Type mismatch (bridge type coercion gap) |
| `TRANSPORT-ERROR` | 2 | No - infrastructure issue | Transport error (HTTP failure) |
| `INTERPRETER-UNSUPPORTED` | 2 | Maybe - platform-specific or missing bridge | Unsupported operation in interpreter |
| `FW-PROGRESS-BAR` | 2 | Yes - fix script progress bar value | Progress bar invalid value (framework noise) |
| `BRIDGE-MISSING-PROPERTY` | 2 | Yes - add to bridge generator or UserBridge | Bridge missing property/method on native class |
| `SCRIPT-GLOBALKEY` | 1 | Yes - fix script to use unique keys | Duplicate GlobalKey in script widget tree |
| `INTERPRETER-BAD-STATE` | 1 | Needs investigation | Bad state error |
| `INTERPRETER-UNDEFINED` | 1 | Maybe - check bridge coverage or script patterns | Interpreter cannot resolve variable/property |
| `INTERPRETER-INDEX-ERROR` | 1 | Yes - fix script bounds checking | Index out of range error |
| `INTERPRETER-NULL-ACCESS` | 1 | Maybe - check script null safety patterns | Null property access in interpreter |

### Known D4rt Limitations Affecting Tests

| ID | Limitation | Impact on Tests | Workaround |
|------|-----------|-----------------|------------|
| #1 | Generic type inference (`List<Object?>` vs `List<Widget>`) | 2 FW errors | Add explicit type annotations |
| #2 | `int.roundToDouble()` not bridged | Minor | Use `.toDouble()` instead |
| Bug-79 | Non-exhaustive switch on sealed subclass | 4 failures (FIXED in interpreter) | Add default/wildcard case in script |
| Lim-3 | Isolates not supported | Scripts using isolates will fail | Remove isolate usage from scripts |
| Bug-14 | Records not supported | Minor | Avoid Dart 3 records in scripts |

### Stray Test Scripts (15)

These scripts exist on disk but are not referenced by any test suite:

| Package | Script | Action Needed |
|---------|--------|---------------|
| dart_ui | `display_feature_test.dart` | Add to appropriate suite or remove |
| dart_ui | `point_mode_test.dart` | Add to appropriate suite or remove |
| material | `button_styles_misc_test.dart` | Add to appropriate suite or remove |
| material | `button_types_test.dart` | Add to appropriate suite or remove |
| material | `list_tile_style_test.dart` | Add to appropriate suite or remove |
| material | `showbottomsheet_test.dart` | Add to appropriate suite or remove |
| material | `showdatepicker_test.dart` | Add to appropriate suite or remove |
| material | `showdialog_test.dart` | Add to appropriate suite or remove |
| material | `showmenu_test.dart` | Add to appropriate suite or remove |
| material | `showtimepicker_test.dart` | Add to appropriate suite or remove |
| material | `stepper_state_test.dart` | Add to appropriate suite or remove |
| material | `toggle_segmented_test.dart` | Add to appropriate suite or remove |
| rendering | `child_layout_helper_test.dart` | Add to appropriate suite or remove |
| rendering | `diagnostics_debug_creator_test.dart` | Add to appropriate suite or remove |
| widgets | `platform_menu_widgets_test.dart` | Add to appropriate suite or remove |

---

## Batch 0 — Detailed Analysis

| Metric | Value |
|--------|-------|
| Total Issues | 265 |
| Failures | 179 |
| FW-Error-Only | 86 |
| Top Category | TRANSPORT-CASCADE (144) |

### Batch 0 Category Distribution

| Category | Count |
|----------|------:|
| `TRANSPORT-CASCADE` | 144 |
| `FW-LAYOUT-CONSTRAINT` | 27 |
| `FW-LAYOUT-OVERFLOW` | 22 |
| `BRIDGE-INTERPRETED-INSTANCE` | 9 |
| `SCRIPT-TIMEOUT` | 9 |
| `BRIDGE-NATIVE-ERROR` | 7 |
| `INTERPRETER-STATE-ACCESS` | 6 |
| `BRIDGE-MISSING-METHOD` | 4 |
| `FW-ASSERTION` | 4 |
| `INTERPRETER-SWITCH` | 4 |
| `SCRIPT-LATEINIT` | 3 |
| `BRIDGE-GENERIC-CONSTRUCTOR` | 3 |
| `INTERPRETER-NULL-INVOKE` | 3 |
| `BRIDGE-NOT-CALLABLE` | 3 |
| `BRIDGE-MISSING-TYPE` | 2 |
| `BRIDGE-TYPE-MISMATCH` | 2 |
| `INTERPRETER-UNSUPPORTED` | 2 |
| `FW-PROGRESS-BAR` | 2 |
| `SCRIPT-GLOBALKEY` | 1 |
| `INTERPRETER-GENERIC-INFERENCE` | 1 |
| `INTERPRETER-BAD-STATE` | 1 |
| `INTERPRETER-UNDEFINED` | 1 |
| `INTERPRETER-INDEX-ERROR` | 1 |
| `BRIDGE-MISSING-CONSTRUCTOR` | 1 |
| `TRANSPORT-ERROR` | 1 |
| `INTERPRETER-NULL-ACCESS` | 1 |
| `FW-OTHER` | 1 |

### Suite: essential_classes_test

**4 issues** — Top: `FW-LAYOUT-CONSTRAINT` (3), `FW-LAYOUT-OVERFLOW` (1)

#### FW-LAYOUT-CONSTRAINT (3)

> Layout constraint error (framework noise)
> **Fix**: Maybe - fix layout in script

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 1 | `cupertino/controls_test.dart` | success | BoxConstraints has a negative minimum height. |
| 2 | `cupertino/form_test.dart` | success | BoxConstraints has a negative minimum height. |
| 3 | `cupertino/textfield_test.dart` | success | BoxConstraints has a negative minimum height. |

#### FW-LAYOUT-OVERFLOW (1)

> Layout overflow or unbounded flex (framework noise)
> **Fix**: Maybe - adjust script layout constraints

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 4 | `rendering/viewport_test.dart` | success | A RenderFlex overflowed by 20 pixels on the right. |

### Suite: hardly_relevant_classes_1_test

**16 issues** — Top: `FW-LAYOUT-CONSTRAINT` (5), `BRIDGE-NATIVE-ERROR` (4), `BRIDGE-NOT-CALLABLE` (3)

#### BRIDGE-GENERIC-CONSTRUCTOR (1)

> Bridge generic constructor factory error
> **Fix**: Yes - add UserBridge generic constructor override

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 212 | `animation/reverse_tween_test.dart` | error | Expected: true |

#### BRIDGE-NATIVE-ERROR (4)

> Native error during bridged method call
> **Fix**: Maybe - add UserBridge override for method

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 220 | `dart_ui/placeholder_alignment_test.dart` | error | Expected: true |
| 222 | `dart_ui/vertex_mode_test.dart` | success | Runtime Error: Native error during default bridged constructor for 'Vertices': Argument Error: Invalid parameter "positions": expected List<Offset>, g |
| 226 | `foundation/target_platform_test.dart` | error | Expected: true |
| 227 | `gestures/class_test.dart` | error | Expected: true |

#### BRIDGE-NOT-CALLABLE (3)

> Bridge missing constructor (type is not callable)
> **Fix**: Yes - add constructor to bridge

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 223 | `foundation/object_created_test.dart` | error | Expected: true |
| 224 | `foundation/object_disposed_test.dart` | error | Expected: true |
| 225 | `foundation/object_event_test.dart` | error | Expected: true |

#### FW-LAYOUT-CONSTRAINT (5)

> Layout constraint error (framework noise)
> **Fix**: Maybe - fix layout in script

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 213 | `cupertino/cupertino_desktop_text_selection_controls_test.dart` | success | BoxConstraints has a negative minimum height. |
| 214 | `cupertino/cupertino_focus_halo_test.dart` | success | BoxConstraints has a negative minimum height. |
| 215 | `cupertino/cupertino_text_selection_handle_controls_test.dart` | success | BoxConstraints has a negative minimum height. |
| 216 | `cupertino/inherited_cupertino_theme_test.dart` | success | BoxConstraints has a negative minimum height. |
| 217 | `cupertino/overlay_visibility_mode_test.dart` | success | BoxConstraints has a negative minimum height. |

#### FW-LAYOUT-OVERFLOW (1)

> Layout overflow or unbounded flex (framework noise)
> **Fix**: Maybe - adjust script layout constraints

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 218 | `dart_ui/blur_style_test.dart` | success | A RenderFlex overflowed by 2.0 pixels on the bottom. |

#### INTERPRETER-UNSUPPORTED (2)

> Unsupported operation in interpreter
> **Fix**: Maybe - platform-specific or missing bridge

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 219 | `dart_ui/color_space_test.dart` | error | Expected: true |
| 221 | `dart_ui/system_color_palette_test.dart` | error | Expected: true |

### Suite: hardly_relevant_classes_2_test

**38 issues** — Top: `SCRIPT-TIMEOUT` (9), `FW-LAYOUT-CONSTRAINT` (9), `FW-LAYOUT-OVERFLOW` (4)

#### BRIDGE-GENERIC-CONSTRUCTOR (1)

> Bridge generic constructor factory error
> **Fix**: Yes - add UserBridge generic constructor override

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 253 | `material/popup_menu_position_test.dart` | error | Expected: true |

#### BRIDGE-INTERPRETED-INSTANCE (1)

> Bridge returns InterpretedInstance instead of typed object
> **Fix**: Yes - fix bridge type resolution or add UserBridge

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 237 | `material/button_bar_theme_test.dart` | success | Argument Error: Invalid parameter "build": expected Widget, got InterpretedInstance(ButtonBarTheme) |

#### BRIDGE-NATIVE-ERROR (2)

> Native error during bridged method call
> **Fix**: Maybe - add UserBridge override for method

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 239 | `material/collapse_mode_test.dart` | error | Expected: true |
| 256 | `material/theme_extension_test.dart` | success | Runtime Error: Native error during bridged method call 'copyWith' on ThemeData: Argument Error: Invalid parameter "extensions": cannot convert List to |

#### FW-ASSERTION (2)

> Flutter framework assertion failure
> **Fix**: Maybe - investigate assertion context

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 244 | `material/gapped_slider_track_shape_test.dart` | success | 'package:flutter/src/material/slider_parts.dart': Failed assertion: line 1080 pos 12: 'sliderTheme.trackGap != null': is not true. |
| 263 | `material/tooltip_state_test.dart` | success | Runtime Error: Native error during default bridged constructor for 'Tooltip': 'package:flutter/src/material/tooltip.dart': Failed assertion: line 140  |

#### FW-LAYOUT-CONSTRAINT (9)

> Layout constraint error (framework noise)
> **Fix**: Maybe - fix layout in script

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 242 | `material/end_drawer_button_test.dart` | success | RenderParagraph object was given an infinite size during layout. |
| 248 | `material/menu_accelerator_callback_binding_test.dart` | success | RenderParagraph object was given an infinite size during layout. |
| 252 | `material/paginated_data_table_state_test.dart` | success | BoxConstraints forces an infinite width. |
| 257 | `material/theme_mode_test.dart` | success | RenderParagraph object was given an infinite size during layout. |
| 258 | `material/thumb_test.dart` | success | RenderParagraph object was given an infinite size during layout. |
| 259 | `material/time_of_day_format_test.dart` | success | RenderParagraph object was given an infinite size during layout. |
| 260 | `material/time_picker_entry_mode_test.dart` | success | RenderParagraph object was given an infinite size during layout. |
| 261 | `material/toggle_buttons_theme_data_test.dart` | success | Runtime Error: Native error during bridged operator '==' on BoxConstraints: Argument Error: Invalid parameter "other": expected Object, got Null |
| 262 | `material/toggle_buttons_theme_test.dart` | success | Runtime Error: Native error during bridged operator '==' on BoxConstraints: Argument Error: Invalid parameter "other": expected Object, got Null |

#### FW-LAYOUT-OVERFLOW (4)

> Layout overflow or unbounded flex (framework noise)
> **Fix**: Maybe - adjust script layout constraints

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 240 | `material/drawer_controller_state_test.dart` | success | A RenderFlex overflowed by 46 pixels on the right. |
| 246 | `material/list_tile_title_alignment_test.dart` | success | A RenderFlex overflowed by 1.00 pixels on the bottom. |
| 250 | `material/navigation_drawer_theme_test.dart` | success | A RenderFlex overflowed by 29 pixels on the bottom. |
| 265 | `painting/axis_test.dart` | success | A RenderFlex overflowed by 56 pixels on the right. |

#### FW-OTHER (1)

> Uncategorized framework error
> **Fix**: Needs investigation

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 243 | `material/gapped_range_slider_track_shape_test.dart` | success | Null check operator used on a null value |

#### FW-PROGRESS-BAR (2)

> Progress bar invalid value (framework noise)
> **Fix**: Yes - fix script progress bar value

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 254 | `material/progress_indicator_test.dart` | success | Progress bar value, minValue, and maxValue must be valid numbers. value: "67%", minValue: "0", maxValue: "100" |
| 255 | `material/refresh_progress_indicator_test.dart` | success | Progress bar value, minValue, and maxValue must be valid numbers. value: "50%", minValue: "0", maxValue: "100" |

#### INTERPRETER-NULL-ACCESS (1)

> Null property access in interpreter
> **Fix**: Maybe - check script null safety patterns

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 238 | `material/button_text_theme_test.dart` | error | Expected: true |

#### INTERPRETER-NULL-INVOKE (2)

> Method invocation on null
> **Fix**: Maybe - check null safety in script

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 245 | `material/hour_format_test.dart` | success | Runtime Error: Cannot invoke method 'withValues' on null. Use '?.' for null-aware method invocation. |
| 264 | `painting/axis_direction_test.dart` | error | Expected: true |

#### INTERPRETER-SWITCH (4)

> Non-exhaustive switch expression
> **Fix**: Yes - add default/wildcard case in script

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 241 | `material/dropdown_menu_close_behavior_test.dart` | error | Expected: true |
| 247 | `material/material_banner_closed_reason_test.dart` | error | Expected: true |
| 249 | `material/navigation_destination_label_behavior_test.dart` | error | Expected: true |
| 251 | `material/navigation_rail_label_type_test.dart` | error | Expected: true |

#### SCRIPT-TIMEOUT (9)

> Build timed out (script too complex or has infinite loop)
> **Fix**: Yes - simplify script or add timeout handling

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 228 | `material/autocomplete_test.dart` | error | Expected: true |
| 229 | `material/back_button_icon_test.dart` | error | Expected: true |
| 230 | `material/back_button_test.dart` | error | Expected: true |
| 231 | `material/bottom_navigation_bar_landscape_layout_test.dart` | error | Expected: true |
| 232 | `material/bottom_navigation_bar_theme_data_test.dart` | error | Expected: true |
| 233 | `material/bottom_navigation_bar_theme_test.dart` | error | Expected: true |
| 234 | `material/bottom_navigation_bar_type_test.dart` | error | Expected: true |
| 235 | `material/button_bar_layout_behavior_test.dart` | error | Expected: true |
| 236 | `material/button_bar_test.dart` | error | Expected: true |

### Suite: important_classes_test

**10 issues** — Top: `BRIDGE-MISSING-METHOD` (1), `SCRIPT-GLOBALKEY` (1), `FW-ASSERTION` (1)

#### BRIDGE-GENERIC-CONSTRUCTOR (1)

> Bridge generic constructor factory error
> **Fix**: Yes - add UserBridge generic constructor override

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 12 | `animation/tweensequence_test.dart` | error | Expected: true |

#### BRIDGE-MISSING-METHOD (1)

> Bridge missing method implementation
> **Fix**: Yes - add method to bridge or UserBridge override

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 5 | `widgets/slidetransition_test.dart` | success | NoSuchMethodError: Class '$RelaxedAnimation<Offset>' has no instance method 'addListener' with matching arguments. |

#### BRIDGE-MISSING-TYPE (1)

> Bridge missing type/class definition
> **Fix**: Yes - add to bridge generator or UserBridge

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 13 | `services/codecs_test.dart` | error | Expected: true |

#### BRIDGE-TYPE-MISMATCH (1)

> Type mismatch (bridge type coercion gap)
> **Fix**: Yes - add D4.coerceList/coerceMap or UserBridge

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 14 | `services/channels_test.dart` | error | Expected: true |

#### FW-ASSERTION (1)

> Flutter framework assertion failure
> **Fix**: Maybe - investigate assertion context

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 7 | `widgets/table_test.dart` | success | 'package:flutter/src/widgets/framework.dart': Failed assertion: line 2168 pos 12: '_elements.contains(element)': is not true. |

#### FW-LAYOUT-CONSTRAINT (1)

> Layout constraint error (framework noise)
> **Fix**: Maybe - fix layout in script

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 10 | `material/animatedicon_test.dart` | success | RenderBox was not laid out: RenderTransform#b351d |

#### FW-LAYOUT-OVERFLOW (1)

> Layout overflow or unbounded flex (framework noise)
> **Fix**: Maybe - adjust script layout constraints

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 9 | `material/refreshindicator_test.dart` | success | RenderFlex children have non-zero flex but incoming height constraints are unbounded. |

#### INTERPRETER-GENERIC-INFERENCE (1)

> Known issue #1: generic type inference (List<Object?> vs List<Widget>)
> **Fix**: Yes - add explicit type annotations in script

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 8 | `widgets/nestedscrollview_test.dart` | success | type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast |

#### SCRIPT-GLOBALKEY (1)

> Duplicate GlobalKey in script widget tree
> **Fix**: Yes - fix script to use unique keys

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 6 | `widgets/sliverlist_test.dart` | success | 'package:flutter/src/widgets/framework.dart': Failed assertion: line 2134 pos 12: 'element._lifecycleState == _ElementLifecycle.active': is not true. |

#### SCRIPT-LATEINIT (1)

> Script uses late variables; interpreter cannot resolve late initialization
> **Fix**: Yes - refactor script to avoid late fields or use nullable + null-check

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 11 | `widgets/actions_test.dart` | success | Runtime Error: Undefined variable: _dispatcher (Original error: LateInitializationError: Late variable '_dispatcher' without initializer is accessed b |

### Suite: secondary_classes_test

**197 issues** — Top: `TRANSPORT-CASCADE` (144), `FW-LAYOUT-OVERFLOW` (15), `FW-LAYOUT-CONSTRAINT` (9)

#### BRIDGE-INTERPRETED-INSTANCE (8)

> Bridge returns InterpretedInstance instead of typed widget
> **Fix**: Yes - fix bridge type resolution or add UserBridge

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 32 | `material/scaffold_messenger_test.dart` | error | Expected: true |
| 38 | `rendering/box_hit_test_result_test.dart` | error | Expected: true |
| 41 | `rendering/relayout_when_system_fonts_change_mixin_test.dart` | success | Runtime Error: Native error during bridged constructor 'fill' for class 'Positioned': Argument Error: Invalid parameter "child": expected Widget, got  |
| 42 | `rendering/render_absorb_pointer_test.dart` | success | Runtime Error: Native error during bridged constructor 'fill' for class 'Positioned': Argument Error: Invalid parameter "child": expected Widget, got  |
| 46 | `rendering/render_box_container_defaults_mixin_test.dart` | success | Argument Error: Invalid parameter "build": expected Widget, got InterpretedInstance(_DefaultsContainer) |
| 47 | `rendering/render_custom_multi_child_layout_box_test.dart` | success | Runtime Error: Native error during default bridged constructor for 'CustomMultiChildLayout': Argument Error: Invalid parameter "delegate": expected Mu |
| 49 | `rendering/render_custom_single_child_layout_box_test.dart` | success | Runtime Error: Native error during default bridged constructor for 'CustomSingleChildLayout': Argument Error: Invalid parameter "delegate": expected S |
| 52 | `rendering/render_physical_shape_test.dart` | success | Runtime Error: Native error during default bridged constructor for 'PhysicalShape': Argument Error: Invalid parameter "clipper": expected CustomClippe |

#### BRIDGE-MISSING-CONSTRUCTOR (1)

> Bridge missing constructor for class
> **Fix**: Yes - add constructor to bridge generator

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 54 | `rendering/render_shrink_wrapping_viewport_test.dart` | success | Runtime Error: Error during constructor execution for class '_SizeReporter': Bridged superclass 'SingleChildRenderObjectWidget' does not have a constr |

#### BRIDGE-MISSING-METHOD (3)

> Bridge missing method implementation
> **Fix**: Yes - add method to bridge or UserBridge override

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 59 | `widgets/animated_cross_fade_test.dart` | success | Runtime Error: Bridged class 'List' has no instance method named 'whereType'. Error during extension lookup: Bridged class 'List' has no instance meth |
| 61 | `widgets/animated_switcher_test.dart` | success | Runtime Error: Bridged class 'List' has no instance method named 'whereType'. Error during extension lookup: Bridged class 'List' has no instance meth |
| 63 | `widgets/backdrop_filter_test.dart` | success | Runtime Error: Bridged class 'List' has no instance method named 'whereType'. Error during extension lookup: Bridged class 'List' has no instance meth |

#### BRIDGE-MISSING-TYPE (1)

> Bridge missing type/class definition
> **Fix**: Yes - add to bridge generator or UserBridge

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 58 | `widgets/android_view_test.dart` | success | Runtime Error: Undefined static member 'new' on bridged class 'EagerGestureRecognizer'. |

#### BRIDGE-NATIVE-ERROR (1)

> Native error during bridged method call
> **Fix**: Maybe - add UserBridge override for method

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 36 | `painting/decoration_image_painter_test.dart` | error | Expected: true |

#### BRIDGE-TYPE-MISMATCH (1)

> Type mismatch (bridge type coercion gap)
> **Fix**: Yes - add D4.coerceList/coerceMap or UserBridge

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 20 | `semantics/semantics_config_test.dart` | error | Expected: true |

#### FW-ASSERTION (1)

> Flutter framework assertion failure
> **Fix**: Maybe - investigate assertion context

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 27 | `dart_ui/scene_test.dart` | success | 'dart:ui/math.dart': Failed assertion: line 14 pos 10: '<optimized out>': is not true. |

#### FW-LAYOUT-CONSTRAINT (9)

> Layout constraint error (framework noise)
> **Fix**: Maybe - fix layout in script

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 15 | `cupertino/cupertino_secondary_test.dart` | success | BoxConstraints has a negative minimum height. |
| 16 | `cupertino/cupertino_form_scroll_test.dart` | success | BoxConstraints has a negative minimum height. |
| 17 | `cupertino/cupertino_controls_advanced_test.dart` | success | BoxConstraints has a negative minimum height. |
| 18 | `cupertino/cupertino_sections_test.dart` | success | BoxConstraints has a negative minimum height. |
| 19 | `cupertino/cupertino_tabbar_scaffold_test.dart` | success | BoxConstraints has a negative minimum height. |
| 25 | `cupertino/cupertino_text_selection_controls_test.dart` | success | BoxConstraints has a negative minimum height. |
| 34 | `material/text_selection_toolbar_test.dart` | success | RenderCustomSingleChildLayoutBox object was given an infinite size during layout. |
| 35 | `material/text_selection_toolbar_text_button_test.dart` | success | RenderCustomSingleChildLayoutBox object was given an infinite size during layout. |
| 50 | `rendering/render_editable_test.dart` | success | BoxConstraints has a negative minimum height. |

#### FW-LAYOUT-OVERFLOW (15)

> Layout overflow or unbounded flex (framework noise)
> **Fix**: Maybe - adjust script layout constraints

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 23 | `widgets/scroll_position_types_test.dart` | success | RenderFlex children have non-zero flex but incoming height constraints are unbounded. |
| 24 | `widgets/scroll_controllers_types_test.dart` | success | RenderFlex children have non-zero flex but incoming height constraints are unbounded. |
| 28 | `dart_ui/semantics_action_event_test.dart` | success | A RenderFlex overflowed by 24 pixels on the right. |
| 29 | `dart_ui/string_attribute_test.dart` | success | A RenderFlex overflowed by 4.0 pixels on the bottom. |
| 30 | `dart_ui/target_image_size_test.dart` | success | A RenderFlex overflowed by 16 pixels on the bottom. |
| 37 | `painting/image_info_test.dart` | success | A RenderFlex overflowed by 27 pixels on the bottom. |
| 39 | `rendering/custom_painter_semantics_test.dart` | success | Argument Error: Invalid parameter "semanticsBuilder": expected ((Size) => List<CustomPainterSemantics>)?, got InterpretedFunction |
| 40 | `rendering/platform_view_layer_test.dart` | success | A RenderFlex overflowed by 53 pixels on the right. |
| 45 | `rendering/render_block_semantics_test.dart` | success | A RenderFlex overflowed by 56 pixels on the bottom. |
| 51 | `rendering/render_ignore_pointer_test.dart` | success | A RenderFlex overflowed by 4.0 pixels on the bottom. |
| 55 | `rendering/render_sliver_pinned_persistent_header_test.dart` | success | A RenderFlex overflowed by 3.0 pixels on the bottom. |
| 56 | `rendering/sliver_hit_test_result_test.dart` | success | A RenderFlex overflowed by 4.0 pixels on the bottom. |
| 57 | `rendering/sliver_layout_dimensions_test.dart` | success | A RenderFlex overflowed by 4.0 pixels on the bottom. |
| 60 | `widgets/animated_fractionally_sized_box_test.dart` | success | A RenderFlex overflowed by 8.0 pixels on the bottom. |
| 64 | `widgets/color_filtered_test.dart` | success | RenderFlex children have non-zero flex but incoming height constraints are unbounded. |

#### INTERPRETER-BAD-STATE (1)

> Bad state error
> **Fix**: Needs investigation

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 26 | `dart_ui/ztmp_path_metrics_access_test.dart` | error | Expected: true |

#### INTERPRETER-INDEX-ERROR (1)

> Index out of range error
> **Fix**: Yes - fix script bounds checking

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 53 | `rendering/render_shader_mask_test.dart` | success | Runtime Error: Index out of range: 3 |

#### INTERPRETER-NULL-INVOKE (1)

> Method invocation on null
> **Fix**: Maybe - check null safety in script

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 33 | `material/text_button_theme_data_test.dart` | success | Runtime Error: Cannot invoke method 'toStringAsFixed' on null. Use '?.' for null-aware method invocation. |

#### INTERPRETER-STATE-ACCESS (6)

> Interpreter cannot resolve State/Delegate/Controller property access
> **Fix**: Maybe - add explicit getter in script or UserBridge override

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 21 | `widgets/gesture_detector_adv_test.dart` | success | Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ArenaSceneState.) |
| 22 | `widgets/layout_builder_adv_test.dart` | success | Runtime Error: Undefined variable: layoutChild (Original error: Undefined property 'layoutChild' on TestMultiChildLayoutDelegate.) |
| 31 | `gestures/vertical_multi_drag_gesture_recognizer_test.dart` | success | Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _VerticalTrackState.) |
| 48 | `rendering/render_custom_paint_test.dart` | success | Runtime Error: Undefined variable: mounted (Original error: Native error in bridged mixin getter 'mounted': Argument Error: Invalid target: expected S |
| 62 | `widgets/autofill_group_test.dart` | success | Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _AutofillGroupLaneState.) |
| 65 | `widgets/composited_transform_follower_test.dart` | success | Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _LinkPrimerState.) |

#### INTERPRETER-UNDEFINED (1)

> Interpreter cannot resolve variable/property
> **Fix**: Maybe - check bridge coverage or script patterns

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 43 | `rendering/render_aligning_shifted_box_test.dart` | success | Runtime Error: Native error during bridged method call 'toList' on Iterable: Runtime Error: Undefined property or method 'characters' on bridged insta |

#### SCRIPT-LATEINIT (2)

> Script uses late variables; interpreter cannot resolve late initialization
> **Fix**: Yes - refactor script to avoid late fields or use nullable + null-check

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 44 | `rendering/render_animated_opacity_test.dart` | success | Runtime Error: Undefined variable: _controller (Original error: LateInitializationError: Late variable '_controller' without initializer is accessed b |
| 66 | `widgets/default_asset_bundle_test.dart` | success | Runtime Error: Undefined variable: _oceanBundle (Original error: LateInitializationError: Late variable '_oceanBundle' without initializer is accessed |

#### TRANSPORT-CASCADE (144)

> Cascade: earlier transport error caused downstream failures
> **Fix**: No - fix upstream transport error first

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 68 | `widgets/display_feature_sub_screen_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/display_feature_sub_screen_test.dart" |
| 69 | `widgets/dual_transition_builder_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/dual_transition_builder_test.dart" |
| 70 | `widgets/editable_text_state_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/editable_text_state_test.dart" |
| 71 | `widgets/element_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/element_test.dart" |
| 72 | `widgets/fade_in_image_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/fade_in_image_test.dart" |
| 73 | `widgets/fixed_extent_metrics_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/fixed_extent_metrics_test.dart" |
| 74 | `widgets/fixed_extent_scroll_controller_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/fixed_extent_scroll_controller_test.dart" |
| 75 | `widgets/fixed_extent_scroll_physics_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/fixed_extent_scroll_physics_test.dart" |
| 76 | `widgets/glowing_overscroll_indicator_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/glowing_overscroll_indicator_test.dart" |
| 77 | `widgets/html_element_view_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/html_element_view_test.dart" |
| 78 | `widgets/image_filtered_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/image_filtered_test.dart" |
| 79 | `widgets/implicitly_animated_widget_state_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/implicitly_animated_widget_state_test.dart" |
| 80 | `widgets/implicitly_animated_widget_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/implicitly_animated_widget_test.dart" |
| 81 | `widgets/indexed_stack_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/indexed_stack_test.dart" |
| 82 | `widgets/inherited_element_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/inherited_element_test.dart" |
| 83 | `widgets/inherited_notifier_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/inherited_notifier_test.dart" |
| 84 | `widgets/inherited_theme_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/inherited_theme_test.dart" |
| 85 | `widgets/inherited_widget_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/inherited_widget_test.dart" |
| 86 | `widgets/leaf_render_object_element_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/leaf_render_object_element_test.dart" |
| 87 | `widgets/leaf_render_object_widget_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/leaf_render_object_widget_test.dart" |
| 88 | `widgets/list_wheel_child_builder_delegate_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/list_wheel_child_builder_delegate_test.dart" |
| 89 | `widgets/list_wheel_child_delegate_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/list_wheel_child_delegate_test.dart" |
| 90 | `widgets/list_wheel_child_list_delegate_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/list_wheel_child_list_delegate_test.dart" |
| 91 | `widgets/list_wheel_child_looping_list_delegate_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/list_wheel_child_looping_list_delegate_test.dart" |
| 92 | `widgets/list_wheel_element_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/list_wheel_element_test.dart" |
| 93 | `widgets/list_wheel_scroll_view_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/list_wheel_scroll_view_test.dart" |
| 94 | `widgets/list_wheel_viewport_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/list_wheel_viewport_test.dart" |
| 95 | `widgets/magnifier_controller_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/magnifier_controller_test.dart" |
| 96 | `widgets/magnifier_decoration_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/magnifier_decoration_test.dart" |
| 97 | `widgets/magnifier_info_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/magnifier_info_test.dart" |
| 98 | `widgets/multi_child_render_object_element_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/multi_child_render_object_element_test.dart" |
| 99 | `widgets/multi_child_render_object_widget_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/multi_child_render_object_widget_test.dart" |
| 100 | `widgets/navigation_toolbar_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/navigation_toolbar_test.dart" |
| 101 | `widgets/never_scrollable_scroll_physics_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/never_scrollable_scroll_physics_test.dart" |
| 102 | `widgets/overflow_bar_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/overflow_bar_test.dart" |
| 103 | `widgets/overflow_box_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/overflow_box_test.dart" |
| 104 | `widgets/page_scroll_physics_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/page_scroll_physics_test.dart" |
| 105 | `widgets/page_storage_bucket_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/page_storage_bucket_test.dart" |
| 106 | `widgets/page_storage_key_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/page_storage_key_test.dart" |
| 107 | `widgets/page_storage_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/page_storage_test.dart" |
| 108 | `widgets/parent_data_element_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/parent_data_element_test.dart" |
| 109 | `widgets/parent_data_widget_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/parent_data_widget_test.dart" |
| 110 | `widgets/performance_overlay_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/performance_overlay_test.dart" |
| 111 | `widgets/physical_model_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/physical_model_test.dart" |
| 112 | `widgets/physical_shape_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/physical_shape_test.dart" |
| 113 | `widgets/pinned_header_sliver_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/pinned_header_sliver_test.dart" |
| 114 | `widgets/platform_menu_bar_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/platform_menu_bar_test.dart" |
| 115 | `widgets/platform_menu_item_group_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/platform_menu_item_group_test.dart" |
| 116 | `widgets/platform_menu_item_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/platform_menu_item_test.dart" |
| 117 | `widgets/platform_menu_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/platform_menu_test.dart" |
| 118 | `widgets/platform_provided_menu_item_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/platform_provided_menu_item_test.dart" |
| 119 | `widgets/platform_view_link_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/platform_view_link_test.dart" |
| 120 | `widgets/platform_view_surface_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/platform_view_surface_test.dart" |
| 121 | `widgets/pop_scope_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/pop_scope_test.dart" |
| 122 | `widgets/positioned_directional_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/positioned_directional_test.dart" |
| 123 | `widgets/primary_scroll_controller_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/primary_scroll_controller_test.dart" |
| 124 | `widgets/proxy_element_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/proxy_element_test.dart" |
| 125 | `widgets/proxy_widget_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/proxy_widget_test.dart" |
| 126 | `widgets/radio_group_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/radio_group_test.dart" |
| 127 | `widgets/range_maintaining_scroll_physics_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/range_maintaining_scroll_physics_test.dart" |
| 128 | `widgets/raw_magnifier_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/raw_magnifier_test.dart" |
| 129 | `widgets/raw_view_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/raw_view_test.dart" |
| 130 | `widgets/render_object_element_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/render_object_element_test.dart" |
| 131 | `widgets/render_object_widget_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/render_object_widget_test.dart" |
| 132 | `widgets/restorable_bool_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/restorable_bool_test.dart" |
| 133 | `widgets/restorable_date_time_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/restorable_date_time_test.dart" |
| 134 | `widgets/restorable_double_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/restorable_double_test.dart" |
| 135 | `widgets/restorable_enum_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/restorable_enum_test.dart" |
| 136 | `widgets/restorable_int_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/restorable_int_test.dart" |
| 137 | `widgets/restorable_property_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/restorable_property_test.dart" |
| 138 | `widgets/restorable_string_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/restorable_string_test.dart" |
| 139 | `widgets/restorable_text_editing_controller_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/restorable_text_editing_controller_test.dart" |
| 140 | `widgets/restorable_value_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/restorable_value_test.dart" |
| 141 | `widgets/restoration_mixin_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/restoration_mixin_test.dart" |
| 142 | `widgets/root_element_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/root_element_test.dart" |
| 143 | `widgets/root_restoration_scope_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/root_restoration_scope_test.dart" |
| 144 | `widgets/root_widget_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/root_widget_test.dart" |
| 145 | `widgets/scroll_action_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/scroll_action_test.dart" |
| 146 | `widgets/scroll_configuration_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/scroll_configuration_test.dart" |
| 147 | `widgets/scroll_intent_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/scroll_intent_test.dart" |
| 148 | `widgets/scroll_physics_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/scroll_physics_test.dart" |
| 149 | `widgets/scroll_position_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/scroll_position_test.dart" |
| 150 | `widgets/scrollable_state_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/scrollable_state_test.dart" |
| 151 | `widgets/scrollable_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/scrollable_test.dart" |
| 152 | `widgets/selectable_region_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/selectable_region_test.dart" |
| 153 | `widgets/selection_container_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/selection_container_test.dart" |
| 154 | `widgets/selection_listener_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/selection_listener_test.dart" |
| 155 | `widgets/selection_overlay_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/selection_overlay_test.dart" |
| 156 | `widgets/shader_mask_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/shader_mask_test.dart" |
| 157 | `widgets/shared_app_data_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/shared_app_data_test.dart" |
| 158 | `widgets/shrink_wrapping_viewport_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/shrink_wrapping_viewport_test.dart" |
| 159 | `widgets/single_child_render_object_element_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/single_child_render_object_element_test.dart" |
| 160 | `widgets/single_child_render_object_widget_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/single_child_render_object_widget_test.dart" |
| 161 | `widgets/single_ticker_provider_state_mixin_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/single_ticker_provider_state_mixin_test.dart" |
| 162 | `widgets/sliver_animated_grid_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/sliver_animated_grid_test.dart" |
| 163 | `widgets/sliver_animated_list_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/sliver_animated_list_test.dart" |
| 164 | `widgets/sliver_animated_opacity_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/sliver_animated_opacity_test.dart" |
| 165 | `widgets/sliver_constrained_cross_axis_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/sliver_constrained_cross_axis_test.dart" |
| 166 | `widgets/sliver_cross_axis_expanded_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/sliver_cross_axis_expanded_test.dart" |
| 167 | `widgets/sliver_cross_axis_group_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/sliver_cross_axis_group_test.dart" |
| 168 | `widgets/sliver_floating_header_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/sliver_floating_header_test.dart" |
| 169 | `widgets/sliver_ignore_pointer_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/sliver_ignore_pointer_test.dart" |
| 170 | `widgets/sliver_layout_builder_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/sliver_layout_builder_test.dart" |
| 171 | `widgets/sliver_main_axis_group_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/sliver_main_axis_group_test.dart" |
| 172 | `widgets/sliver_offstage_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/sliver_offstage_test.dart" |
| 173 | `widgets/sliver_prototype_extent_list_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/sliver_prototype_extent_list_test.dart" |
| 174 | `widgets/sliver_reorderable_list_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/sliver_reorderable_list_test.dart" |
| 175 | `widgets/sliver_resizing_header_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/sliver_resizing_header_test.dart" |
| 176 | `widgets/sliver_safe_area_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/sliver_safe_area_test.dart" |
| 177 | `widgets/sliver_semantics_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/sliver_semantics_test.dart" |
| 178 | `widgets/sliver_visibility_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/sliver_visibility_test.dart" |
| 179 | `widgets/spacer_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/spacer_test.dart" |
| 180 | `widgets/spell_check_configuration_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/spell_check_configuration_test.dart" |
| 181 | `widgets/stateful_element_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/stateful_element_test.dart" |
| 182 | `widgets/stateless_element_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/stateless_element_test.dart" |
| 183 | `widgets/stretching_overscroll_indicator_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/stretching_overscroll_indicator_test.dart" |
| 184 | `widgets/table_cell_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/table_cell_test.dart" |
| 185 | `widgets/table_row_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/table_row_test.dart" |
| 186 | `widgets/tap_region_surface_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/tap_region_surface_test.dart" |
| 187 | `widgets/tap_region_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/tap_region_test.dart" |
| 188 | `widgets/text_field_tap_region_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/text_field_tap_region_test.dart" |
| 189 | `widgets/text_magnifier_configuration_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/text_magnifier_configuration_test.dart" |
| 190 | `widgets/text_selection_controls_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/text_selection_controls_test.dart" |
| 191 | `widgets/text_selection_gesture_detector_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/text_selection_gesture_detector_test.dart" |
| 192 | `widgets/text_selection_overlay_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/text_selection_overlay_test.dart" |
| 193 | `widgets/text_selection_toolbar_anchors_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/text_selection_toolbar_anchors_test.dart" |
| 194 | `widgets/ticker_mode_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/ticker_mode_test.dart" |
| 195 | `widgets/ticker_provider_state_mixin_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/ticker_provider_state_mixin_test.dart" |
| 196 | `widgets/title_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/title_test.dart" |
| 197 | `widgets/tooltip_trigger_mode_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/tooltip_trigger_mode_test.dart" |
| 198 | `widgets/tween_animation_builder_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/tween_animation_builder_test.dart" |
| 199 | `widgets/ui_kit_view_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/ui_kit_view_test.dart" |
| 200 | `widgets/undo_history_controller_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/undo_history_controller_test.dart" |
| 201 | `widgets/view_anchor_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/view_anchor_test.dart" |
| 202 | `widgets/view_collection_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/view_collection_test.dart" |
| 203 | `widgets/view_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/view_test.dart" |
| 204 | `widgets/viewport_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/viewport_test.dart" |
| 205 | `widgets/widget_inspector_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/widget_inspector_test.dart" |
| 206 | `widgets/widget_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/widget_test.dart" |
| 207 | `widgets/widgets_app_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/widgets_app_test.dart" |
| 208 | `widgets/widgets_binding_observer_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/widgets_binding_observer_test.dart" |
| 209 | `widgets/widgets_binding_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/widgets_binding_test.dart" |
| 210 | `widgets/widgets_flutter_binding_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/widgets_flutter_binding_test.dart" |
| 211 | `widgets/will_pop_scope_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/will_pop_scope_test.dart" |

#### TRANSPORT-ERROR (1)

> Transport error (HTTP failure)
> **Fix**: No - infrastructure issue

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 67 | `widgets/directionality_test.dart` | transport_error | Bad state: Transport failure while running "widgets/directionality_test.dart" |


---

## Batch 1 — Detailed Analysis

| Metric | Value |
|--------|-------|
| Total Issues | 286 |
| Failures | 150 |
| FW-Error-Only | 136 |
| Top Category | TRANSPORT-CASCADE (105) |

### Batch 1 Category Distribution

| Category | Count |
|----------|------:|
| `TRANSPORT-CASCADE` | 105 |
| `SCRIPT-LATEINIT` | 103 |
| `BRIDGE-INTERPRETED-INSTANCE` | 19 |
| `BRIDGE-MISSING-CONSTRUCTOR` | 14 |
| `INTERPRETER-STATE-ACCESS` | 11 |
| `BRIDGE-GENERIC-CONSTRUCTOR` | 6 |
| `FW-LAYOUT-OVERFLOW` | 5 |
| `BRIDGE-NATIVE-ERROR` | 4 |
| `BRIDGE-MISSING-TYPE` | 4 |
| `FW-LAYOUT-CONSTRAINT` | 3 |
| `BRIDGE-TYPE-MISMATCH-FW` | 3 |
| `FW-OTHER` | 3 |
| `BRIDGE-MISSING-PROPERTY` | 2 |
| `INTERPRETER-NULL-INVOKE` | 1 |
| `TRANSPORT-ERROR` | 1 |
| `BRIDGE-NOT-CALLABLE` | 1 |
| `INTERPRETER-GENERIC-INFERENCE` | 1 |

### Suite: hardly_relevant_classes_3_test

**18 issues** — Top: `SCRIPT-LATEINIT` (4), `FW-LAYOUT-OVERFLOW` (3), `BRIDGE-NATIVE-ERROR` (2)

#### BRIDGE-INTERPRETED-INSTANCE (1)

> Bridge returns InterpretedInstance instead of typed widget
> **Fix**: Yes - fix bridge type resolution or add UserBridge

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 268 | `rendering/over_scroll_header_stretch_configuration_test.dart` | error | Expected: true |

#### BRIDGE-MISSING-PROPERTY (2)

> Bridge missing property/method on native class
> **Fix**: Yes - add to bridge generator or UserBridge

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 281 | `services/message_codec_test.dart` | error | Expected: true |
| 282 | `services/method_codec_test.dart` | error | Expected: true |

#### BRIDGE-NATIVE-ERROR (2)

> Native error during bridged constructor/method
> **Fix**: Maybe - add UserBridge override

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 273 | `rendering/render_android_view_test.dart` | success | Runtime Error: Native error during bridged method call 'toList' on Iterable: Runtime Error: Switch expression was not exhaustive for value: PlatformVi |
| 276 | `rendering/render_clip_r_superellipse_test.dart` | success | Runtime Error: Native error during default bridged constructor for 'Text': Argument Error: Invalid parameter "data": expected String, got Null |

#### BRIDGE-TYPE-MISMATCH-FW (1)

> Type mismatch in framework error (bridge coercion gap)
> **Fix**: Yes - add D4.coerceList/coerceMap or UserBridge

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 278 | `rendering/render_sliver_box_child_manager_test.dart` | success | type 'InterpretedInstance' is not a subtype of type 'Widget?' in type cast |

#### FW-LAYOUT-CONSTRAINT (2)

> Layout constraint error (framework noise)
> **Fix**: Maybe - fix layout in script

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 277 | `rendering/render_editable_painter_test.dart` | success | BoxConstraints has a negative minimum height. |
| 283 | `services/raw_key_up_event_test.dart` | success | RenderParagraph object was given an infinite size during layout. |

#### FW-LAYOUT-OVERFLOW (3)

> Layout overflow or unbounded flex (framework noise)
> **Fix**: Maybe - adjust script layout constraints

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 266 | `rendering/floating_header_snap_configuration_test.dart` | success | A RenderFlex overflowed by 2.0 pixels on the bottom. |
| 272 | `rendering/render_abstract_viewport_test.dart` | success | A RenderFlex overflowed by 70 pixels on the right. |
| 275 | `rendering/render_animated_size_state_test.dart` | success | Runtime Error: Native error during default bridged constructor for 'ConstrainedBox': Argument Error: Invalid parameter "child": expected Widget?, got  |

#### INTERPRETER-NULL-INVOKE (1)

> Method invocation on null
> **Fix**: Maybe - check null safety in script

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 267 | `rendering/hit_test_behavior_test.dart` | error | Expected: true |

#### INTERPRETER-STATE-ACCESS (2)

> Interpreter cannot resolve State/Delegate/Controller property access
> **Fix**: Maybe - add explicit getter in script or UserBridge override

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 279 | `rendering/render_sliver_floating_pinned_persistent_header_test.dart` | success | Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PrimerSceneState.) |
| 280 | `rendering/render_ui_kit_view_test.dart` | success | Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _PrimerSceneState.) |

#### SCRIPT-LATEINIT (4)

> Script uses late variables; interpreter cannot resolve late initialization
> **Fix**: Yes - refactor script to avoid late fields or use nullable + null-check

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 269 | `rendering/pipeline_manifold_test.dart` | success | Runtime Error: Undefined variable: _manifold (Original error: LateInitializationError: Late variable '_manifold' without initializer is accessed befor |
| 270 | `rendering/placeholder_span_index_semantics_tag_test.dart` | success | Runtime Error: Undefined variable: _tags (Original error: LateInitializationError: Late variable '_tags' without initializer is accessed before being  |
| 271 | `rendering/platform_view_render_box_test.dart` | success | Runtime Error: Undefined variable: _controller (Original error: LateInitializationError: Late variable '_controller' without initializer is accessed b |
| 274 | `rendering/render_animated_opacity_mixin_test.dart` | success | Runtime Error: Undefined variable: _curvedAnimation (Original error: LateInitializationError: Late variable '_curvedAnimation' without initializer is  |

### Suite: hardly_relevant_classes_4_test

**127 issues** — Top: `TRANSPORT-CASCADE` (105), `INTERPRETER-STATE-ACCESS` (7), `SCRIPT-LATEINIT` (4)

#### BRIDGE-INTERPRETED-INSTANCE (2)

> Bridge returns InterpretedInstance instead of typed object
> **Fix**: Yes - fix bridge type resolution or add UserBridge

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 295 | `widgets/box_scroll_view_test.dart` | success | Runtime Error: Native error during default bridged constructor for 'SizedBox': Argument Error: Invalid parameter "child": expected Widget?, got Interp |
| 299 | `widgets/context_action_test.dart` | error | Expected: true |

#### BRIDGE-MISSING-TYPE (2)

> Bridge missing type/class definition
> **Fix**: Yes - add to bridge generator or UserBridge

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 286 | `widgets/android_view_surface_test.dart` | success | Runtime Error: Undefined static member 'new' on bridged class 'EagerGestureRecognizer'. |
| 288 | `widgets/app_kit_view_test.dart` | success | Runtime Error: Undefined static member 'new' on bridged class 'EagerGestureRecognizer'. |

#### BRIDGE-NATIVE-ERROR (1)

> Native error during bridged constructor/method
> **Fix**: Maybe - add UserBridge override

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 301 | `widgets/default_text_editing_shortcuts_test.dart` | success | Runtime Error: Native error during default bridged constructor for 'Shortcuts': Argument Error: Invalid parameter "shortcuts": cannot convert Map to M |

#### FW-LAYOUT-CONSTRAINT (1)

> Layout constraint error (framework noise)
> **Fix**: Maybe - fix layout in script

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 291 | `widgets/automatic_keep_alive_client_mixin_test.dart` | success | RenderParagraph object was given an infinite size during layout. |

#### FW-LAYOUT-OVERFLOW (1)

> Layout overflow or unbounded flex (framework noise)
> **Fix**: Maybe - adjust script layout constraints

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 297 | `widgets/constrained_layout_builder_test.dart` | success | A RenderFlex overflowed by 14 pixels on the bottom. |

#### FW-OTHER (3)

> Uncategorized framework error
> **Fix**: Needs investigation

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 292 | `widgets/back_button_listener_test.dart` | success | Runtime Error: Error in generic constructor factory for 'Router': Null check operator used on a null value |
| 294 | `widgets/border_tween_test.dart` | success | A borderRadius can only be given on borders with uniform colors. |
| 298 | `widgets/constraints_transform_box_test.dart` | success | A RenderConstraintsTransformBox overflowed by 11 pixels on the left, 8.5 pixels on the top, 8.5 pixels on the bottom, and 11 pixels on the right. |

#### INTERPRETER-STATE-ACCESS (7)

> Interpreter cannot resolve State/Delegate/Controller property access
> **Fix**: Maybe - add explicit getter in script or UserBridge override

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 287 | `widgets/animated_positioned_directional_test.dart` | success | Runtime Error: Undefined variable: context (Original error: Undefined property 'context' on _AnimatedPositionedDirectionalDemoState.) |
| 289 | `widgets/autocomplete_highlighted_option_test.dart` | success | Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _HighlightLaneState.) |
| 290 | `widgets/autofill_group_state_test.dart` | success | Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _AutofillLaneState.) |
| 293 | `widgets/backdrop_group_test.dart` | success | Runtime Error: Undefined variable: setState (Original error: Undefined property 'setState' on _BackdropGroupDeepDemoState.) |
| 300 | `widgets/default_selection_style_test.dart` | success | Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ZonePanelState.) |
| 303 | `widgets/draggable_scrollable_actuator_test.dart` | success | Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _SingleActuatorSceneState.) |
| 304 | `widgets/expansible_test.dart` | success | Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _ControllerApiSceneState.) |

#### SCRIPT-LATEINIT (4)

> Script uses late variables; interpreter cannot resolve late initialization
> **Fix**: Yes - refactor script to avoid late fields or use nullable + null-check

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 284 | `widgets/action_listener_test.dart` | success | Runtime Error: Undefined variable: _dispatcher (Original error: LateInitializationError: Late variable '_dispatcher' without initializer is accessed b |
| 285 | `widgets/align_transition_test.dart` | success | Runtime Error: Undefined variable: _alignmentAnimation (Original error: LateInitializationError: Late variable '_alignmentAnimation' without initializ |
| 296 | `widgets/clip_r_superellipse_test.dart` | success | Runtime Error: Undefined variable: _pulse (Original error: LateInitializationError: Late variable '_pulse' without initializer is accessed before bein |
| 302 | `widgets/default_text_style_transition_test.dart` | success | Runtime Error: Undefined variable: _heroStyle (Original error: LateInitializationError: Late variable '_heroStyle' without initializer is accessed bef |

#### TRANSPORT-CASCADE (105)

> Cascade: earlier transport error caused downstream failures
> **Fix**: No - fix upstream transport error first

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 306 | `widgets/extend_selection_to_next_paragraph_boundary_intent_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/extend_selection_to_next_paragraph_boundary_intent_test.dart" |
| 307 | `widgets/extend_selection_to_next_paragraph_boundary_or_caret_location_intent_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/extend_selection_to_next_paragraph_boundary_or_caret_location_intent_test.dart" |
| 308 | `widgets/extend_selection_to_next_word_boundary_intent_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/extend_selection_to_next_word_boundary_intent_test.dart" |
| 309 | `widgets/extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart" |
| 310 | `widgets/extend_selection_vertically_to_adjacent_line_intent_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/extend_selection_vertically_to_adjacent_line_intent_test.dart" |
| 311 | `widgets/extend_selection_vertically_to_adjacent_page_intent_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/extend_selection_vertically_to_adjacent_page_intent_test.dart" |
| 312 | `widgets/feedback_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/feedback_test.dart" |
| 313 | `widgets/fixed_scroll_metrics_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/fixed_scroll_metrics_test.dart" |
| 314 | `widgets/flex_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/flex_test.dart" |
| 315 | `widgets/floating_header_snap_mode_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/floating_header_snap_mode_test.dart" |
| 316 | `widgets/focus_attachment_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/focus_attachment_test.dart" |
| 317 | `widgets/focus_highlight_mode_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/focus_highlight_mode_test.dart" |
| 318 | `widgets/focus_highlight_strategy_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/focus_highlight_strategy_test.dart" |
| 319 | `widgets/focus_order_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/focus_order_test.dart" |
| 320 | `widgets/focus_scope_node_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/focus_scope_node_test.dart" |
| 321 | `widgets/focus_traversal_order_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/focus_traversal_order_test.dart" |
| 322 | `widgets/fractional_translation_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/fractional_translation_test.dart" |
| 323 | `widgets/gesture_recognizer_factory_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/gesture_recognizer_factory_test.dart" |
| 324 | `widgets/gesture_recognizer_factory_with_handlers_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/gesture_recognizer_factory_with_handlers_test.dart" |
| 325 | `widgets/global_object_key_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/global_object_key_test.dart" |
| 326 | `widgets/hero_controller_scope_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/hero_controller_scope_test.dart" |
| 327 | `widgets/hero_controller_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/hero_controller_test.dart" |
| 328 | `widgets/hero_flight_direction_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/hero_flight_direction_test.dart" |
| 329 | `widgets/hold_scroll_activity_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/hold_scroll_activity_test.dart" |
| 330 | `widgets/i_o_s_system_context_menu_item_copy_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/i_o_s_system_context_menu_item_copy_test.dart" |
| 331 | `widgets/i_o_s_system_context_menu_item_custom_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/i_o_s_system_context_menu_item_custom_test.dart" |
| 332 | `widgets/i_o_s_system_context_menu_item_cut_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/i_o_s_system_context_menu_item_cut_test.dart" |
| 333 | `widgets/i_o_s_system_context_menu_item_live_text_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/i_o_s_system_context_menu_item_live_text_test.dart" |
| 334 | `widgets/i_o_s_system_context_menu_item_look_up_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/i_o_s_system_context_menu_item_look_up_test.dart" |
| 335 | `widgets/i_o_s_system_context_menu_item_paste_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/i_o_s_system_context_menu_item_paste_test.dart" |
| 336 | `widgets/i_o_s_system_context_menu_item_search_web_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/i_o_s_system_context_menu_item_search_web_test.dart" |
| 337 | `widgets/i_o_s_system_context_menu_item_select_all_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/i_o_s_system_context_menu_item_select_all_test.dart" |
| 338 | `widgets/i_o_s_system_context_menu_item_share_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/i_o_s_system_context_menu_item_share_test.dart" |
| 339 | `widgets/i_o_s_system_context_menu_item_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/i_o_s_system_context_menu_item_test.dart" |
| 340 | `widgets/icon_data_property_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/icon_data_property_test.dart" |
| 341 | `widgets/icon_data_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/icon_data_test.dart" |
| 342 | `widgets/icon_theme_data_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/icon_theme_data_test.dart" |
| 343 | `widgets/idle_scroll_activity_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/idle_scroll_activity_test.dart" |
| 344 | `widgets/ignore_baseline_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/ignore_baseline_test.dart" |
| 345 | `widgets/image_icon_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/image_icon_test.dart" |
| 346 | `widgets/img_element_platform_view_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/img_element_platform_view_test.dart" |
| 347 | `widgets/indexed_slot_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/indexed_slot_test.dart" |
| 348 | `widgets/inherited_model_element_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/inherited_model_element_test.dart" |
| 349 | `widgets/inspector_button_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/inspector_button_test.dart" |
| 350 | `widgets/inspector_button_variant_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/inspector_button_variant_test.dart" |
| 351 | `widgets/inspector_reference_data_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/inspector_reference_data_test.dart" |
| 352 | `widgets/inspector_selection_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/inspector_selection_test.dart" |
| 353 | `widgets/inspector_serialization_delegate_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/inspector_serialization_delegate_test.dart" |
| 354 | `widgets/keep_alive_handle_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/keep_alive_handle_test.dart" |
| 355 | `widgets/keep_alive_notification_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/keep_alive_notification_test.dart" |
| 356 | `widgets/key_event_result_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/key_event_result_test.dart" |
| 357 | `widgets/key_set_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/key_set_test.dart" |
| 358 | `widgets/keyboard_listener_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/keyboard_listener_test.dart" |
| 359 | `widgets/labeled_global_key_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/labeled_global_key_test.dart" |
| 360 | `widgets/layout_id_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/layout_id_test.dart" |
| 361 | `widgets/lexical_focus_order_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/lexical_focus_order_test.dart" |
| 362 | `widgets/live_text_input_status_notifier_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/live_text_input_status_notifier_test.dart" |
| 363 | `widgets/live_text_input_status_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/live_text_input_status_test.dart" |
| 364 | `widgets/local_history_entry_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/local_history_entry_test.dart" |
| 365 | `widgets/localizations_resolver_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/localizations_resolver_test.dart" |
| 366 | `widgets/lock_state_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/lock_state_test.dart" |
| 367 | `widgets/logical_key_set_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/logical_key_set_test.dart" |
| 368 | `widgets/lookup_boundary_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/lookup_boundary_test.dart" |
| 369 | `widgets/matrix4_tween_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/matrix4_tween_test.dart" |
| 370 | `widgets/matrix_transition_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/matrix_transition_test.dart" |
| 371 | `widgets/menu_controller_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/menu_controller_test.dart" |
| 372 | `widgets/menu_serializable_shortcut_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/menu_serializable_shortcut_test.dart" |
| 373 | `widgets/meta_data_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/meta_data_test.dart" |
| 374 | `widgets/modal_barrier_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/modal_barrier_test.dart" |
| 375 | `widgets/multi_selectable_selection_container_delegate_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/multi_selectable_selection_container_delegate_test.dart" |
| 376 | `widgets/navigation_mode_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/navigation_mode_test.dart" |
| 377 | `widgets/navigation_notification_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/navigation_notification_test.dart" |
| 378 | `widgets/navigator_pop_handler_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/navigator_pop_handler_test.dart" |
| 379 | `widgets/nested_scroll_view_state_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/nested_scroll_view_state_test.dart" |
| 380 | `widgets/nested_scroll_view_viewport_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/nested_scroll_view_viewport_test.dart" |
| 381 | `widgets/next_focus_action_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/next_focus_action_test.dart" |
| 382 | `widgets/next_focus_intent_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/next_focus_intent_test.dart" |
| 383 | `widgets/notifiable_element_mixin_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/notifiable_element_mixin_test.dart" |
| 384 | `widgets/notification_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/notification_test.dart" |
| 385 | `widgets/numeric_focus_order_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/numeric_focus_order_test.dart" |
| 386 | `widgets/object_key_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/object_key_test.dart" |
| 387 | `widgets/options_view_open_direction_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/options_view_open_direction_test.dart" |
| 388 | `widgets/ordered_traversal_policy_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/ordered_traversal_policy_test.dart" |
| 389 | `widgets/orientation_builder_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/orientation_builder_test.dart" |
| 390 | `widgets/orientation_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/orientation_test.dart" |
| 391 | `widgets/overflow_bar_alignment_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/overflow_bar_alignment_test.dart" |
| 392 | `widgets/overlay_child_layout_info_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/overlay_child_layout_info_test.dart" |
| 393 | `widgets/overlay_child_location_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/overlay_child_location_test.dart" |
| 394 | `widgets/overlay_portal_controller_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/overlay_portal_controller_test.dart" |
| 395 | `widgets/overlay_portal_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/overlay_portal_test.dart" |
| 396 | `widgets/overlay_route_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/overlay_route_test.dart" |
| 397 | `widgets/overlay_state_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/overlay_state_test.dart" |
| 398 | `widgets/overscroll_indicator_notification_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/overscroll_indicator_notification_test.dart" |
| 399 | `widgets/overscroll_notification_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/overscroll_notification_test.dart" |
| 400 | `widgets/page_metrics_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/page_metrics_test.dart" |
| 401 | `widgets/page_route_builder_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/page_route_builder_test.dart" |
| 402 | `widgets/page_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/page_test.dart" |
| 403 | `widgets/pan_axis_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/pan_axis_test.dart" |
| 404 | `widgets/paste_text_intent_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/paste_text_intent_test.dart" |
| 405 | `widgets/platform_menu_delegate_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/platform_menu_delegate_test.dart" |
| 406 | `widgets/platform_provided_menu_item_type_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/platform_provided_menu_item_type_test.dart" |
| 407 | `widgets/platform_route_information_provider_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/platform_route_information_provider_test.dart" |
| 408 | `widgets/platform_selectable_region_context_menu_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/platform_selectable_region_context_menu_test.dart" |
| 409 | `widgets/platform_view_creation_params_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/platform_view_creation_params_test.dart" |
| 410 | `widgets/pop_entry_test.dart` | clear_failed | Bad state: Transport failure while running "widgets/pop_entry_test.dart" |

#### TRANSPORT-ERROR (1)

> Transport error (HTTP failure)
> **Fix**: No - infrastructure issue

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 305 | `widgets/extend_selection_to_line_break_intent_test.dart` | transport_error | Bad state: Transport failure while running "widgets/extend_selection_to_line_break_intent_test.dart" |

### Suite: hardly_relevant_classes_5_test

**141 issues** — Top: `SCRIPT-LATEINIT` (95), `BRIDGE-INTERPRETED-INSTANCE` (16), `BRIDGE-MISSING-CONSTRUCTOR` (14)

#### BRIDGE-GENERIC-CONSTRUCTOR (6)

> Bridge generic constructor factory error
> **Fix**: Yes - add UserBridge generic constructor override

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 544 | `widgets/window_positioner_anchor_test.dart` | error | Expected: true |
| 545 | `widgets/window_positioner_constraint_adjustment_test.dart` | error | Expected: true |
| 546 | `widgets/window_positioner_test.dart` | error | Expected: true |
| 548 | `widgets/windowing_owner_linux_test.dart` | error | Expected: true |
| 549 | `widgets/windowing_owner_mac_o_s_test.dart` | error | Expected: true |
| 550 | `widgets/windowing_owner_test.dart` | error | Expected: true |

#### BRIDGE-INTERPRETED-INSTANCE (16)

> Bridge returns InterpretedInstance instead of typed widget
> **Fix**: Yes - fix bridge type resolution or add UserBridge

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 415 | `widgets/redo_text_intent_test.dart` | error | Expected: true |
| 416 | `widgets/regular_window_controller_delegate_test.dart` | error | Expected: true |
| 417 | `widgets/regular_window_controller_linux_test.dart` | error | Expected: true |
| 418 | `widgets/regular_window_controller_mac_o_s_test.dart` | error | Expected: true |
| 419 | `widgets/regular_window_controller_test.dart` | error | Expected: true |
| 420 | `widgets/regular_window_controller_win32_test.dart` | error | Expected: true |
| 421 | `widgets/regular_window_test.dart` | error | Expected: true |
| 423 | `widgets/render_abstract_layout_builder_mixin_test.dart` | error | Expected: true |
| 426 | `widgets/render_tap_region_surface_test.dart` | error | Expected: true |
| 432 | `widgets/replace_text_intent_test.dart` | error | Expected: true |
| 433 | `widgets/request_focus_action_test.dart` | error | Expected: true |
| 448 | `widgets/route_information_test.dart` | error | Expected: true |
| 449 | `widgets/route_pop_disposition_test.dart` | error | Expected: true |
| 461 | `widgets/scroll_metrics_notification_test.dart` | error | Expected: true |
| 464 | `widgets/scroll_position_alignment_policy_test.dart` | error | Expected: true |
| 469 | `widgets/scroll_view_keyboard_dismiss_behavior_test.dart` | error | Expected: true |

#### BRIDGE-MISSING-CONSTRUCTOR (14)

> Bridge missing constructor for class
> **Fix**: Yes - add constructor to bridge generator

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 425 | `widgets/render_object_to_widget_adapter_test.dart` | error | Expected: true |
| 451 | `widgets/router_config_test.dart` | error | Expected: true |
| 453 | `widgets/scroll_activity_test.dart` | error | Expected: true |
| 474 | `widgets/select_action_test.dart` | error | Expected: true |
| 484 | `widgets/shortcut_registry_entry_test.dart` | error | Expected: true |
| 485 | `widgets/shortcut_serialization_test.dart` | error | Expected: true |
| 486 | `widgets/single_activator_test.dart` | error | Expected: true |
| 503 | `widgets/toolbar_items_parent_data_test.dart` | error | Expected: true |
| 504 | `widgets/toolbar_options_test.dart` | error | Expected: true |
| 505 | `widgets/tooltip_position_context_test.dart` | error | Expected: true |
| 506 | `widgets/tooltip_window_controller_delegate_test.dart` | error | Expected: true |
| 507 | `widgets/tooltip_window_controller_test.dart` | error | Expected: true |
| 511 | `widgets/traversal_direction_test.dart` | error | Expected: true |
| 512 | `widgets/traversal_edge_behavior_test.dart` | error | Expected: true |

#### BRIDGE-MISSING-TYPE (2)

> Bridge missing type/class definition
> **Fix**: Yes - add to bridge generator or UserBridge

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 412 | `widgets/raw_keyboard_listener_test.dart` | error | Expected: true |
| 438 | `widgets/restorable_enum_n_test.dart` | error | Expected: true |

#### BRIDGE-NATIVE-ERROR (1)

> Native error during bridged constructor/method
> **Fix**: Maybe - add UserBridge override

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 414 | `widgets/raw_radio_test.dart` | success | Runtime Error: Native error during bridged method call 'toList' on Iterable: Runtime Error: Error in generic constructor factory for 'RawRadio': 'pack |

#### BRIDGE-NOT-CALLABLE (1)

> Bridge missing constructor (type is not callable)
> **Fix**: Yes - add constructor to bridge

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 413 | `widgets/raw_menu_overlay_info_test.dart` | error | Expected: true |

#### BRIDGE-TYPE-MISMATCH-FW (2)

> Type mismatch in framework error (bridge coercion gap)
> **Fix**: Yes - add D4.coerceList/coerceMap or UserBridge

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 411 | `widgets/raw_dialog_route_test.dart` | success | Runtime Error: Error in generic constructor factory for 'RawDialogRoute': type 'InterpretedFunction' is not a subtype of type '((BuildContext, Animati |
| 547 | `widgets/window_scope_test.dart` | success | type 'InterpretedInstance' is not a subtype of type 'Widget' in type cast |

#### FW-LAYOUT-OVERFLOW (1)

> Layout overflow or unbounded flex (framework noise)
> **Fix**: Maybe - adjust script layout constraints

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 422 | `widgets/relative_positioned_transition_test.dart` | success | A RenderFlex overflowed by 4.0 pixels on the bottom. |

#### INTERPRETER-GENERIC-INFERENCE (1)

> Known issue #1: generic type inference (List<Object?> vs List<Widget>)
> **Fix**: Yes - add explicit type annotations in script

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 424 | `widgets/render_nested_scroll_view_viewport_test.dart` | success | type 'List<Object?>' is not a subtype of type 'List<Widget>' in type cast |

#### INTERPRETER-STATE-ACCESS (2)

> Interpreter cannot resolve State/Delegate/Controller property access
> **Fix**: Maybe - add explicit getter in script or UserBridge override

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 472 | `widgets/scrollbar_orientation_test.dart` | success | Runtime Error: Undefined variable: widget (Original error: Undefined property 'widget' on _OrientedPanelState.) |
| 509 | `widgets/transition_delegate_test.dart` | success | Runtime Error: Undefined variable: setState (Original error: Undefined property 'setState' on _DefaultDemoPageState.) |

#### SCRIPT-LATEINIT (95)

> Script uses late variables; interpreter cannot resolve late initialization
> **Fix**: Yes - refactor script to avoid late fields or use nullable + null-check

| # | Script | Status | Details |
|--:|--------|--------|---------|
| 427 | `widgets/render_tap_region_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 428 | `widgets/render_tree_root_element_test.dart` | success | Runtime Error: Native error during bridged method call 'visitAncestorElements' on StatelessElement: LateInitializationError: Field '_children@24042623 |
| 429 | `widgets/render_two_dimensional_viewport_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 430 | `widgets/render_web_image_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 431 | `widgets/repeat_mode_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 434 | `widgets/request_focus_intent_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 435 | `widgets/restorable_bool_n_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 436 | `widgets/restorable_date_time_n_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 437 | `widgets/restorable_double_n_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 439 | `widgets/restorable_int_n_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 440 | `widgets/restorable_listenable_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 441 | `widgets/restorable_num_n_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 442 | `widgets/restorable_num_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 443 | `widgets/restorable_route_future_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 444 | `widgets/restorable_string_n_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 445 | `widgets/root_element_mixin_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 446 | `widgets/root_render_object_element_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 447 | `widgets/route_information_reporting_type_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 450 | `widgets/route_transition_record_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 452 | `widgets/scroll_activity_delegate_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 454 | `widgets/scroll_context_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 455 | `widgets/scroll_deceleration_rate_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 456 | `widgets/scroll_drag_controller_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 457 | `widgets/scroll_end_notification_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 458 | `widgets/scroll_hold_controller_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 459 | `widgets/scroll_increment_details_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 460 | `widgets/scroll_increment_type_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 462 | `widgets/scroll_notification_observer_state_test.dart` | success | Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before  |
| 463 | `widgets/scroll_notification_observer_test.dart` | success | Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before  |
| 465 | `widgets/scroll_position_with_single_context_test.dart` | success | Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before  |
| 466 | `widgets/scroll_start_notification_test.dart` | success | Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before  |
| 467 | `widgets/scroll_to_document_boundary_intent_test.dart` | success | Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before  |
| 468 | `widgets/scroll_update_notification_test.dart` | success | Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before  |
| 470 | `widgets/scroll_view_test.dart` | success | Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before  |
| 471 | `widgets/scrollable_details_test.dart` | success | Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before  |
| 473 | `widgets/scrollbar_painter_test.dart` | success | Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before  |
| 475 | `widgets/select_all_text_intent_test.dart` | success | Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before  |
| 476 | `widgets/select_intent_test.dart` | success | Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before  |
| 477 | `widgets/selectable_region_state_test.dart` | success | Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before  |
| 478 | `widgets/selection_container_delegate_test.dart` | success | Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before  |
| 479 | `widgets/selection_details_test.dart` | success | Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before  |
| 480 | `widgets/semantics_gesture_delegate_test.dart` | success | Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before  |
| 481 | `widgets/shortcut_activator_test.dart` | success | Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before  |
| 482 | `widgets/shortcut_manager_test.dart` | success | Runtime Error: Undefined variable: _loggingManager (Original error: LateInitializationError: Late variable '_loggingManager' without initializer is ac |
| 483 | `widgets/shortcut_map_property_test.dart` | success | Runtime Error: Undefined variable: _tabCtrl (Original error: LateInitializationError: Late variable '_tabCtrl' without initializer is accessed before  |
| 487 | `widgets/size_changed_layout_notification_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 488 | `widgets/sliver_animated_grid_state_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 489 | `widgets/sliver_animated_list_state_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 490 | `widgets/sliver_child_builder_delegate_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 491 | `widgets/sliver_child_delegate_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 492 | `widgets/sliver_multi_box_adaptor_element_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 493 | `widgets/sliver_multi_box_adaptor_widget_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 494 | `widgets/sliver_reorderable_list_state_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 495 | `widgets/slotted_container_render_object_mixin_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 496 | `widgets/slotted_multi_child_render_object_widget_mixin_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 497 | `widgets/slotted_multi_child_render_object_widget_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 498 | `widgets/slotted_render_object_element_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 499 | `widgets/snapshot_mode_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 500 | `widgets/standard_component_type_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 501 | `widgets/static_selection_container_delegate_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 502 | `widgets/text_selection_gesture_detector_builder_delegate_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 508 | `widgets/tooltip_window_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 510 | `widgets/transpose_characters_intent_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 513 | `widgets/tree_sliver_state_mixin_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 514 | `widgets/two_dimensional_child_builder_delegate_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 515 | `widgets/two_dimensional_child_delegate_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 516 | `widgets/two_dimensional_child_list_delegate_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 517 | `widgets/two_dimensional_child_manager_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 518 | `widgets/two_dimensional_scrollable_state_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 519 | `widgets/two_dimensional_viewport_parent_data_test.dart` | success | Runtime Error: Undefined variable: _tabController (Original error: LateInitializationError: Late variable '_tabController' without initializer is acce |
| 520 | `widgets/undo_history_state_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 521 | `widgets/undo_history_value_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 522 | `widgets/undo_text_intent_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 523 | `widgets/unfocus_disposition_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 524 | `widgets/update_selection_intent_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 525 | `widgets/user_scroll_notification_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 526 | `widgets/viewport_element_mixin_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 527 | `widgets/viewport_notification_mixin_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 528 | `widgets/void_callback_action_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 529 | `widgets/void_callback_intent_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 530 | `widgets/weak_map_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 531 | `widgets/web_browser_detection_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 532 | `widgets/widget_inspector_service_extensions_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 533 | `widgets/widget_inspector_service_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 534 | `widgets/widget_order_traversal_policy_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 535 | `widgets/widget_state_border_side_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 536 | `widgets/widget_state_color_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 537 | `widgets/widget_state_mapper_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 538 | `widgets/widget_state_mouse_cursor_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 539 | `widgets/widget_state_outlined_border_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 540 | `widgets/widget_state_property_all_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 541 | `widgets/widget_state_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 542 | `widgets/widget_state_text_style_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 543 | `widgets/widget_states_constraint_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |
| 551 | `widgets/windowing_owner_win32_test.dart` | success | Runtime Error: Undefined variable: _tabs (Original error: LateInitializationError: Late variable '_tabs' without initializer is accessed before being  |

