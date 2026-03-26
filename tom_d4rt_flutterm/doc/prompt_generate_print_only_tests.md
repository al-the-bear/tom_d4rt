# Prompt: Generate Print-Only D4rt Test Files

> **Usage:** Copy this prompt into Copilot Chat. Replace `BATCH_LIST` at the bottom with the next batch of 10 files from the master list. Repeat until all batches are done.
>
> **Batch size:** 10 files per prompt invocation. Expect 80–300 lines per file.
>
> **After each batch:** Run `dart analyze` on the project, fix any issues, then update `doc/testplan_status_report.md` — change each generated entry from `No | No | Print-only` to `No | Yes | No | Created on <date> at <time>`.

---

## Task

Generate print-only D4rt test scripts for the Flutter interpreter project `tom_d4rt_flutterm`. These test files verify that Flutter classes can be instantiated and used correctly from the D4rt interpreter. They use `print()` statements as implicit assertions and return a minimal widget for visual output.

**Project root:** `/home/alexis/tac/tom_ai/d4rt/tom_d4rt_flutterm/`
**Test files location:** `test/tom_d4rt_flutterm_app/test/send_ast_via_http_scripts/{section}/`

Each file already exists as a placeholder/dummy (< 80 lines). You must **replace the entire content** of each file with a proper print-only test. A test is considered implemented when it has **≥ 80 lines**.

---

## File Structure Template

```dart
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests {ClassName} from {section}
import 'package:flutter/{library}.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('{ClassName} test executing');
  print('=' * 50);

  // === Test code here ===

  print('\n' + '=' * 50);
  print('{ClassName} test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        '{ClassName} Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      // Summary widget items here
    ],
  );
}
```

---

## Import Rules by Section

| Section | Primary Import | Always Also Import |
|---------|---------------|--------------------|
| animation | `package:flutter/animation.dart` | `package:flutter/material.dart` |
| cupertino | `package:flutter/cupertino.dart` | `package:flutter/material.dart` |
| dart_ui | `dart:ui` | `package:flutter/material.dart` |
| foundation | `package:flutter/foundation.dart` | `package:flutter/material.dart` |
| gestures | `package:flutter/gestures.dart` | `package:flutter/material.dart` |
| material | `package:flutter/material.dart` | (already included) |
| painting | `package:flutter/painting.dart` | `package:flutter/material.dart` |
| physics | `package:flutter/physics.dart` | `package:flutter/material.dart` |
| rendering | `package:flutter/rendering.dart` | `package:flutter/material.dart` |
| scheduler | `package:flutter/scheduler.dart` | `package:flutter/material.dart` |
| semantics | `package:flutter/semantics.dart` | `package:flutter/material.dart` |
| services | `package:flutter/services.dart` | `package:flutter/material.dart` |
| widgets | `package:flutter/widgets.dart` | `package:flutter/material.dart` |

**Note:** For widgets/ and material/ sections, `package:flutter/material.dart` alone is usually sufficient since it re-exports widgets. Add the specific import only if needed for non-re-exported symbols.

---

## Testing Patterns by Class Type

### Enums

For enum classes, test ALL values, indices, name, and any properties:

```dart
// Enumerate all values
print('{EnumName} values:');
for (final value in {EnumName}.values) {
  print('  ${value.name}: index=${value.index}');
}
print('{EnumName} has ${{EnumName}.values.length} values');

// First and last
final first = {EnumName}.values.first;
final last = {EnumName}.values.last;
print('First: $first (index ${first.index})');
print('Last: $last (index ${last.index})');

// Test specific properties if the enum has them
// e.g., AnimationStatus has isDismissed, isCompleted, isAnimating
```

### Data Classes / Value Objects

Test construction, property access, equality, toString, copying:

```dart
// Construct with various parameter combinations
final obj1 = {ClassName}(param1: value1, param2: value2);
print('Created: $obj1');
print('runtimeType: ${obj1.runtimeType}');
print('param1: ${obj1.param1}');
print('param2: ${obj1.param2}');

// Test with different values
final obj2 = {ClassName}(param1: otherValue1, param2: otherValue2);
print('obj1 == obj2: ${obj1 == obj2}');

// Edge cases
print('Empty/default construction: ...');

// If it has copyWith:
// final copy = obj1.copyWith(param1: newValue);
// print('Copy: $copy');
```

### Abstract Classes / Interfaces

Test via concrete implementations or verify type hierarchy:

```dart
// If abstract, explain purpose and test known subclasses
print('{ClassName} is abstract');
print('Purpose: {describe what it does}');

// Test via a concrete implementation if available
final impl = Concrete{ClassName}(...);
print('Concrete implementation: ${impl.runtimeType}');
print('is {ClassName}: ${impl is {ClassName}}');

// Or if it's an interface used by Flutter widgets:
print('Used by: [list known users]');
```

### Mixins

Test that the mixin's contract is understood:

```dart
print('{MixinName} is a mixin');
print('Purpose: {describe what it provides}');
print('Typically used with: {what classes use this}');
// If possible, create a simple test class that uses the mixin
```

### State Objects

Test the state class properties and lifecycle:

```dart
print('{StateName} is a State class for {WidgetName}');
print('Purpose: Manages state for {WidgetName}');
print('Key methods: {list important methods}');
// Cannot instantiate directly, but document the API
```

### Intent / Action Classes

Test creation and properties:

```dart
// Create the intent
final intent = {IntentName}();
print('{IntentName} created');
print('runtimeType: ${intent.runtimeType}');
print('is Intent: ${intent is Intent}');

// If it has properties, print them
// If it takes parameters:
// final intent2 = {IntentName}(param: value);
// print('param: ${intent2.param}');
```

### Controller Classes

Test creation, initial state, and available API:

```dart
final controller = {ControllerName}();
print('{ControllerName} created');
print('runtimeType: ${controller.runtimeType}');
// Print available properties
// Dispose if needed
controller.dispose();
print('Disposed successfully');
```

### Delegate / Builder Classes

Document the contract and test if concrete:

```dart
print('{DelegateName} purpose: {what it does}');
// If concrete, instantiate and test
// If abstract, document the contract
```

### Restorable Properties (widgets/restorable_*.dart)

```dart
final prop = {RestorableName}(defaultValue);
print('{RestorableName} created with default: ${prop.value}');
prop.value = newValue;
print('After set: ${prop.value}');
print('is RestorableProperty: ${prop is RestorableProperty}');
prop.dispose();
print('Disposed');
```

### Scroll Physics

```dart
final physics = {PhysicsName}();
print('{PhysicsName} created');
print('runtimeType: ${physics.runtimeType}');
print('is ScrollPhysics: ${physics is ScrollPhysics}');
// Test with parent
final withParent = {PhysicsName}(parent: ClampingScrollPhysics());
print('With parent: ${withParent.parent}');
```

### Notification Classes

```dart
final notification = {NotificationName}(...);
print('{NotificationName} created');
print('runtimeType: ${notification.runtimeType}');
print('is Notification: ${notification is Notification}');
// Print properties
```

### Tween Classes

```dart
final tween = {TweenName}(begin: startVal, end: endVal);
print('{TweenName} created');
print('begin: ${tween.begin}');
print('end: ${tween.end}');
print('lerp(0.0): ${tween.lerp(0.0)}');
print('lerp(0.5): ${tween.lerp(0.5)}');
print('lerp(1.0): ${tween.lerp(1.0)}');
```

### Window Controller Classes (desktop)

```dart
print('{WindowControllerName} purpose: Desktop window management');
print('Platform: {Linux/MacOS/Win32/cross-platform}');
// These are typically abstract or require platform, so document API
print('Key API: {list methods}');
```

### Key Classes

```dart
final key = {KeyName}(value);
print('{KeyName} created: $key');
print('value: ${key.value}');
// Test equality
final key2 = {KeyName}(value);
print('key1 == key2: ${key == key2}');
```

### Render Object / Element Classes

```dart
print('{ClassName} purpose: {describe role in rendering/element tree}');
print('is RenderObject/Element: true');
// These typically cannot be instantiated standalone
// Document the API and typical usage
```

---

## Quality Requirements

1. **Minimum 80 lines** — Every file must have ≥ 80 lines of meaningful code
2. **Exercise the real API** — Don't just print static strings. Actually create instances, call methods, access properties
3. **Print assertions** — Use print statements that demonstrate correct behavior. If a value should be `true`, print it so the output proves it
4. **Edge cases** — Test boundary conditions, empty/null-like values, different constructor overloads
5. **Type hierarchy** — Print `is` checks to verify inheritance: `print('is ScrollPhysics: ${obj is ScrollPhysics}')`
6. **Must compile** — Code must pass `dart analyze` with no errors. Be careful with:
   - Abstract classes that can't be directly instantiated
   - Platform-specific APIs that may not be available
   - Deprecated APIs (use `deprecated_member_use` ignore)
7. **Return a widget** — Always return a Column or similar widget summarizing the test results
8. **No helpers outside build** — Everything must be inside the `build` function (local functions are OK)

---

## Compile Safety Rules

- If a class is **abstract and has no public concrete subclass**, document its API with print statements rather than trying to instantiate it
- If a class requires a **BuildContext or Element** that can't be obtained in the build function, use the passed `context` parameter or document the limitation
- If a class is **platform-specific** (e.g., WindowControllerLinux), wrap in a try-catch or document what it does
- **Never import `dart:io`** — these are Flutter scripts, not standalone Dart
- Use `try { ... } catch (e) { print('Expected: $e'); }` for operations that may throw in the test environment

---

## Example: Simple Enum (services/device_orientation_test.dart)

```dart
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DeviceOrientation from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DeviceOrientation test executing');

  // Enumerate all DeviceOrientation values
  print('DeviceOrientation values:');
  for (final value in DeviceOrientation.values) {
    print('  ${value.name}: $value');
  }
  print('DeviceOrientation has ${DeviceOrientation.values.length} values');

  final first = DeviceOrientation.values.first;
  final last = DeviceOrientation.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DeviceOrientation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DeviceOrientation Tests'),
      Text('Values: ${DeviceOrientation.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
```

## Example: Data Class (foundation/object_created_test.dart)

```dart
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ObjectCreated event from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ObjectCreated test executing');
  print('=' * 50);

  final testObj = Object();
  final event1 = ObjectCreated(
    library: 'package:test/test.dart',
    className: 'MyClass',
    object: testObj,
  );
  print('\nObjectCreated created:');
  print('runtimeType: ${event1.runtimeType}');
  print('library: ${event1.library}');
  print('className: ${event1.className}');
  print('object: ${event1.object}');
  print('object.runtimeType: ${event1.object.runtimeType}');

  final container = Container(width: 100, height: 100);
  final event2 = ObjectCreated(
    library: 'package:flutter/widgets.dart',
    className: 'Container',
    object: container,
  );
  print('\nWith Flutter widget:');
  print('library: ${event2.library}');
  print('className: ${event2.className}');
  print('object type: ${event2.object.runtimeType}');

  print('\nType hierarchy:');
  print('is ObjectEvent: true');
  print('is Object: true');

  print('\nVarious library formats:');
  final dartCore = ObjectCreated(library: 'dart:core', className: 'List', object: <int>[]);
  final packageLib = ObjectCreated(library: 'package:my_app/src/models/user.dart', className: 'User', object: Object());
  print('dart:core - ${dartCore.library}');
  print('package: - ${packageLib.library}');

  print('\nEdge cases:');
  final emptyLib = ObjectCreated(library: '', className: 'Unknown', object: Object());
  final emptyClass = ObjectCreated(library: 'test', className: '', object: Object());
  print('Empty library: "${emptyLib.library}"');
  print('Empty className: "${emptyClass.className}"');

  print('\nEvent comparison:');
  final sameObj = Object();
  final eventA = ObjectCreated(library: 'test', className: 'Test', object: sameObj);
  final eventB = ObjectCreated(library: 'test', className: 'Test', object: sameObj);
  print('eventA == eventB: ${eventA == eventB}');
  print('identical: ${identical(eventA, eventB)}');
  print('Same object: ${identical(eventA.object, eventB.object)}');

  print('\nObjectCreated purpose:');
  print('- Event fired when a tracked object is created');
  print('- Part of FlutterMemoryAllocations system');
  print('- Used for memory leak detection');
  print('- Carries library, className, and object reference');

  print('\n' + '=' * 50);
  print('ObjectCreated test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ObjectCreated Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: ${event1.runtimeType}'),
      Text('library: ${event1.library}'),
      Text('className: ${event1.className}'),
      Text('Purpose: Memory allocation tracking'),
    ],
  );
}
```

## Example: Painting Enum (painting/alignment_test.dart)

```dart
// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Alignment from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Alignment test executing');

  final custom = Alignment(0.5, -0.5);
  print('Alignment(0.5, -0.5): x=${custom.x}, y=${custom.y}');

  print('Alignment.topLeft: x=${Alignment.topLeft.x}, y=${Alignment.topLeft.y}');
  print('Alignment.topCenter: x=${Alignment.topCenter.x}, y=${Alignment.topCenter.y}');
  print('Alignment.topRight: x=${Alignment.topRight.x}, y=${Alignment.topRight.y}');
  print('Alignment.centerLeft: x=${Alignment.centerLeft.x}, y=${Alignment.centerLeft.y}');
  print('Alignment.center: x=${Alignment.center.x}, y=${Alignment.center.y}');
  print('Alignment.centerRight: x=${Alignment.centerRight.x}, y=${Alignment.centerRight.y}');
  print('Alignment.bottomLeft: x=${Alignment.bottomLeft.x}, y=${Alignment.bottomLeft.y}');
  print('Alignment.bottomCenter: x=${Alignment.bottomCenter.x}, y=${Alignment.bottomCenter.y}');
  print('Alignment.bottomRight: x=${Alignment.bottomRight.x}, y=${Alignment.bottomRight.y}');

  print('Alignment test completed');

  return Container(
    width: 250.0, height: 250.0,
    color: Colors.grey.shade300,
    child: Stack(
      children: [
        Align(alignment: Alignment.topLeft, child: Container(width: 40.0, height: 40.0, color: Colors.red)),
        Align(alignment: Alignment.topRight, child: Container(width: 40.0, height: 40.0, color: Colors.green)),
        Align(alignment: Alignment.center, child: Container(width: 40.0, height: 40.0, color: Colors.blue)),
        Align(alignment: Alignment.bottomLeft, child: Container(width: 40.0, height: 40.0, color: Colors.yellow)),
        Align(alignment: Alignment.bottomRight, child: Container(width: 40.0, height: 40.0, color: Colors.purple)),
        Align(alignment: custom, child: Container(
          width: 60.0, height: 30.0, color: Colors.orange,
          child: Center(child: Text('custom', style: TextStyle(fontSize: 12.0))),
        )),
      ],
    ),
  );
}
```

---

## Post-Generation Checklist (per batch)

1. Run `dart analyze` from project root — fix all errors
2. Verify each file has ≥ 80 lines: `wc -l {file}`
3. Update `doc/testplan_status_report.md` — change each entry from:
   `| No | No | Print-only |` to `| No | Yes | No | Created on {YYYY-MM-DD} at {HH:MM} |`
4. Commit: `git add -A && git commit -m "print-only tests: {section} batch {N}"`

---

## Master List — 586 Remaining Files

### cupertino/ (1 file)
- class_test.dart -> Class

### dart_ui/ (2 files)
- semantics_update_test.dart -> SemanticsUpdate
- singleton_flutter_window_test.dart -> SingletonFlutterWindow

### foundation/ (4 files)
- diagnostic_level_test.dart -> DiagnosticLevel
- factory_test.dart -> Factory
- flags_summary_test.dart -> FlagsSummary
- target_platform_test.dart -> TargetPlatform

### gestures/ (2 files)
- class_test.dart -> Class
- i_o_s_scroll_view_fling_velocity_tracker_test.dart -> IOSScrollViewFlingVelocityTracker

### material/ (21 files)
- button_bar_layout_behavior_test.dart -> ButtonBarLayoutBehavior
- button_text_theme_test.dart -> ButtonTextTheme
- dropdown_menu_close_behavior_test.dart -> DropdownMenuCloseBehavior
- dynamic_scheme_variant_test.dart -> DynamicSchemeVariant
- material_banner_closed_reason_test.dart -> MaterialBannerClosedReason
- material_tap_target_size_test.dart -> MaterialTapTargetSize
- navigation_destination_label_behavior_test.dart -> NavigationDestinationLabelBehavior
- navigation_rail_label_type_test.dart -> NavigationRailLabelType
- popup_menu_position_test.dart -> PopupMenuPosition
- refresh_indicator_status_test.dart -> RefreshIndicatorStatus
- refresh_indicator_trigger_mode_test.dart -> RefreshIndicatorTriggerMode
- script_category_test.dart -> ScriptCategory
- show_value_indicator_test.dart -> ShowValueIndicator
- slider_interaction_test.dart -> SliderInteraction
- stretch_mode_test.dart -> StretchMode
- tab_alignment_test.dart -> TabAlignment
- tab_indicator_animation_test.dart -> TabIndicatorAnimation
- theme_mode_test.dart -> ThemeMode
- thumb_test.dart -> Thumb
- time_of_day_format_test.dart -> TimeOfDayFormat
- time_picker_entry_mode_test.dart -> TimePickerEntryMode

### painting/ (14 files)
- axis_direction_test.dart -> AxisDirection
- axis_test.dart -> Axis
- border_style_test.dart -> BorderStyle
- box_fit_test.dart -> BoxFit
- box_shape_test.dart -> BoxShape
- class_test.dart -> Class
- flutter_logo_style_test.dart -> FlutterLogoStyle
- image_repeat_test.dart -> ImageRepeat
- render_comparison_test.dart -> RenderComparison
- resize_image_policy_test.dart -> ResizeImagePolicy
- text_overflow_test.dart -> TextOverflow
- text_width_basis_test.dart -> TextWidthBasis
- vertical_direction_test.dart -> VerticalDirection
- web_html_element_strategy_test.dart -> WebHtmlElementStrategy

### physics/ (1 file)
- class_test.dart -> Class

### rendering/ (64 files)
- const_test.dart -> const
- render_sliver_floating_persistent_header_test.dart -> RenderSliverFloatingPersistentHeader
- render_sliver_floating_pinned_persistent_header_test.dart -> RenderSliverFloatingPinnedPersistentHeader
- render_sliver_helpers_test.dart -> RenderSliverHelpers
- render_sliver_ignore_pointer_test.dart -> RenderSliverIgnorePointer
- render_sliver_main_axis_group_test.dart -> RenderSliverMainAxisGroup
- render_sliver_multi_box_adaptor_test.dart -> RenderSliverMultiBoxAdaptor
- render_sliver_offstage_test.dart -> RenderSliverOffstage
- render_sliver_persistent_header_test.dart -> RenderSliverPersistentHeader
- render_sliver_pinned_persistent_header_test.dart -> RenderSliverPinnedPersistentHeader
- render_sliver_scrolling_persistent_header_test.dart -> RenderSliverScrollingPersistentHeader
- render_sliver_semantics_annotations_test.dart -> RenderSliverSemanticsAnnotations
- render_sliver_single_box_adapter_test.dart -> RenderSliverSingleBoxAdapter
- render_sliver_to_box_adapter_test.dart -> RenderSliverToBoxAdapter
- render_sliver_varied_extent_list_test.dart -> RenderSliverVariedExtentList
- render_sliver_with_keep_alive_mixin_test.dart -> RenderSliverWithKeepAliveMixin
- render_tree_sliver_test.dart -> RenderTreeSliver
- render_ui_kit_view_test.dart -> RenderUiKitView
- render_viewport_base_test.dart -> RenderViewportBase
- renderer_binding_test.dart -> RendererBinding
- rendering_flutter_binding_test.dart -> RenderingFlutterBinding
- revealed_offset_test.dart -> RevealedOffset
- select_all_selection_event_test.dart -> SelectAllSelectionEvent
- selectable_test.dart -> Selectable
- selected_content_range_test.dart -> SelectedContentRange
- selected_content_test.dart -> SelectedContent
- selection_edge_update_event_test.dart -> SelectionEdgeUpdateEvent
- selection_event_test.dart -> SelectionEvent
- selection_geometry_test.dart -> SelectionGeometry
- selection_handler_test.dart -> SelectionHandler
- selection_point_test.dart -> SelectionPoint
- selection_registrant_test.dart -> SelectionRegistrant
- selection_registrar_test.dart -> SelectionRegistrar
- selection_utils_test.dart -> SelectionUtils
- semantics_annotations_mixin_test.dart -> SemanticsAnnotationsMixin
- shader_mask_layer_test.dart -> ShaderMaskLayer
- shape_border_clipper_test.dart -> ShapeBorderClipper
- sliver_grid_geometry_test.dart -> SliverGridGeometry
- sliver_grid_layout_test.dart -> SliverGridLayout
- sliver_grid_regular_tile_layout_test.dart -> SliverGridRegularTileLayout
- sliver_hit_test_entry_test.dart -> SliverHitTestEntry
- sliver_hit_test_result_test.dart -> SliverHitTestResult
- sliver_layout_dimensions_test.dart -> SliverLayoutDimensions
- sliver_logical_container_parent_data_test.dart -> SliverLogicalContainerParentData
- sliver_multi_box_adaptor_parent_data_test.dart -> SliverMultiBoxAdaptorParentData
- sliver_paint_order_test.dart -> SliverPaintOrder
- sliver_physical_container_parent_data_test.dart -> SliverPhysicalContainerParentData
- sliver_physical_parent_data_test.dart -> SliverPhysicalParentData
- stack_fit_test.dart -> StackFit
- table_border_test.dart -> TableBorder
- table_cell_parent_data_test.dart -> TableCellParentData
- table_cell_vertical_alignment_test.dart -> TableCellVerticalAlignment
- text_parent_data_test.dart -> TextParentData
- text_selection_handle_type_test.dart -> TextSelectionHandleType
- text_selection_point_test.dart -> TextSelectionPoint
- texture_box_test.dart -> TextureBox
- texture_layer_test.dart -> TextureLayer
- tree_sliver_indentation_type_test.dart -> TreeSliverIndentationType
- tree_sliver_node_parent_data_test.dart -> TreeSliverNodeParentData
- vertical_caret_movement_run_test.dart -> VerticalCaretMovementRun
- viewport_test.dart -> viewport
- wrap_alignment_test.dart -> WrapAlignment
- wrap_cross_alignment_test.dart -> WrapCrossAlignment
- wrap_parent_data_test.dart -> WrapParentData

### scheduler/ (1 file)
- class_test.dart -> Class

### semantics/ (6 files)
- child_semantics_configurations_result_builder_test.dart -> ChildSemanticsConfigurationsResultBuilder
- child_semantics_configurations_result_test.dart -> ChildSemanticsConfigurationsResult
- class_test.dart -> Class
- semantics_binding_test.dart -> SemanticsBinding
- semantics_handle_test.dart -> SemanticsHandle
- semantics_label_builder_test.dart -> SemanticsLabelBuilder

### services/ (56 files)
- android_view_controller_test.dart -> AndroidViewController
- app_kit_view_controller_test.dart -> AppKitViewController
- asset_manifest_test.dart -> AssetManifest
- autofill_client_test.dart -> AutofillClient
- autofill_hints_test.dart -> AutofillHints
- autofill_scope_mixin_test.dart -> AutofillScopeMixin
- autofill_scope_test.dart -> AutofillScope
- background_isolate_binary_messenger_test.dart -> BackgroundIsolateBinaryMessenger
- browser_context_menu_test.dart -> BrowserContextMenu
- caching_asset_bundle_test.dart -> CachingAssetBundle
- class_test.dart -> Class
- darwin_platform_view_controller_test.dart -> DarwinPlatformViewController
- deferred_component_test.dart -> DeferredComponent
- delta_text_input_client_test.dart -> DeltaTextInputClient
- expensive_android_view_controller_test.dart -> ExpensiveAndroidViewController
- g_l_f_w_key_helper_test.dart -> GLFWKeyHelper
- gtk_key_helper_test.dart -> GtkKeyHelper
- hybrid_android_view_controller_test.dart -> HybridAndroidViewController
- i_o_s_system_context_menu_item_data_search_web_test.dart -> IOSSystemContextMenuItemDataSearchWeb
- i_o_s_system_context_menu_item_data_test.dart -> IOSSystemContextMenuItemData
- key_event_manager_test.dart -> KeyEventManager
- key_events_adv_test.dart -> TextInputConnection
- live_text_test.dart -> LiveText
- mouse_cursor_manager_test.dart -> MouseCursorManager
- mouse_cursor_session_test.dart -> MouseCursorSession
- platform_asset_bundle_test.dart -> PlatformAssetBundle
- platform_view_controller_test.dart -> PlatformViewController
- platform_views_service_test.dart -> PlatformViewsService
- predictive_back_event_test.dart -> PredictiveBackEvent
- process_text_service_test.dart -> ProcessTextService
- raw_key_down_event_test.dart -> RawKeyDownEvent
- raw_key_event_data_mac_os_test.dart -> RawKeyEventDataMacOs
- raw_key_event_data_test.dart -> RawKeyEventData
- raw_key_up_event_test.dart -> RawKeyUpEvent
- restoration_bucket_test.dart -> RestorationBucket
- restoration_manager_test.dart -> RestorationManager
- scribble_client_test.dart -> ScribbleClient
- scribe_test.dart -> Scribe
- sensitive_content_service_test.dart -> SensitiveContentService
- smart_dashes_type_test.dart -> SmartDashesType
- smart_quotes_type_test.dart -> SmartQuotesType
- spell_check_service_test.dart -> SpellCheckService
- surface_android_view_controller_test.dart -> SurfaceAndroidViewController
- system_context_menu_client_test.dart -> SystemContextMenuClient
- system_context_menu_controller_test.dart -> SystemContextMenuController
- text_input_client_test.dart -> TextInputClient
- text_input_connection_test.dart -> TextInputConnection
- text_input_control_test.dart -> TextInputControl
- text_input_test.dart -> TextInput
- text_layout_metrics_test.dart -> TextLayoutMetrics
- text_selection_delegate_test.dart -> TextSelectionDelegate
- textformatter_test.dart -> Textformatter
- texture_android_view_controller_test.dart -> TextureAndroidViewController
- ui_kit_view_controller_test.dart -> UiKitViewController
- undo_manager_client_test.dart -> UndoManagerClient
- undo_manager_test.dart -> UndoManager

### widgets/ (414 files)
- action_dispatcher_test.dart -> ActionDispatcher
- activate_action_test.dart -> ActivateAction
- activate_intent_test.dart -> ActivateIntent
- always_scrollable_scroll_physics_test.dart -> AlwaysScrollableScrollPhysics
- animated_grid_state_test.dart -> AnimatedGridState
- animated_list_state_test.dart -> AnimatedListState
- animated_widget_base_state_test.dart -> AnimatedWidgetBaseState
- app_lifecycle_listener_test.dart -> AppLifecycleListener
- async_snapshot_test.dart -> AsyncSnapshot
- autocomplete_first_option_intent_test.dart -> AutocompleteFirstOptionIntent
- autocomplete_last_option_intent_test.dart -> AutocompleteLastOptionIntent
- autocomplete_next_option_intent_test.dart -> AutocompleteNextOptionIntent
- autocomplete_next_page_option_intent_test.dart -> AutocompleteNextPageOptionIntent
- autocomplete_previous_option_intent_test.dart -> AutocompletePreviousOptionIntent
- autocomplete_previous_page_option_intent_test.dart -> AutocompletePreviousPageOptionIntent
- autofill_context_action_test.dart -> AutofillContextAction
- automatic_keep_alive_client_mixin_test.dart -> AutomaticKeepAliveClientMixin
- autovalidate_mode_test.dart -> AutovalidateMode
- ballistic_scroll_activity_test.dart -> BallisticScrollActivity
- banner_location_test.dart -> BannerLocation
- base_window_controller_test.dart -> BaseWindowController
- border_radius_tween_test.dart -> BorderRadiusTween
- border_tween_test.dart -> BorderTween
- bouncing_scroll_physics_test.dart -> BouncingScrollPhysics
- bouncing_scroll_simulation_test.dart -> BouncingScrollSimulation
- box_constraints_tween_test.dart -> BoxConstraintsTween
- build_owner_test.dart -> BuildOwner
- build_scope_test.dart -> BuildScope
- button_activate_intent_test.dart -> ButtonActivateIntent
- captured_themes_test.dart -> CapturedThemes
- change_reporting_behavior_test.dart -> ChangeReportingBehavior
- character_activator_test.dart -> CharacterActivator
- child_vicinity_test.dart -> ChildVicinity
- clamping_scroll_physics_test.dart -> ClampingScrollPhysics
- clamping_scroll_simulation_test.dart -> ClampingScrollSimulation
- class_test.dart -> Class
- clipboard_status_notifier_test.dart -> ClipboardStatusNotifier
- clipboard_status_test.dart -> ClipboardStatus
- component_element_test.dart -> ComponentElement
- connection_state_test.dart -> ConnectionState
- content_insertion_configuration_test.dart -> ContentInsertionConfiguration
- context_menu_button_item_test.dart -> ContextMenuButtonItem
- context_menu_button_type_test.dart -> ContextMenuButtonType
- copy_selection_text_intent_test.dart -> CopySelectionTextIntent
- cross_fade_state_test.dart -> CrossFadeState
- debug_creator_test.dart -> DebugCreator
- decoration_tween_test.dart -> DecorationTween
- default_platform_menu_delegate_test.dart -> DefaultPlatformMenuDelegate
- default_transition_delegate_test.dart -> DefaultTransitionDelegate
- delete_character_intent_test.dart -> DeleteCharacterIntent
- delete_to_line_break_intent_test.dart -> DeleteToLineBreakIntent
- delete_to_next_word_boundary_intent_test.dart -> DeleteToNextWordBoundaryIntent
- desktop_text_selection_toolbar_layout_delegate_test.dart -> DesktopTextSelectionToolbarLayoutDelegate
- dev_tools_deep_link_property_test.dart -> DevToolsDeepLinkProperty
- diagonal_drag_behavior_test.dart -> DiagonalDragBehavior
- dialog_window_controller_delegate_test.dart -> DialogWindowControllerDelegate
- dialog_window_controller_linux_test.dart -> DialogWindowControllerLinux
- dialog_window_controller_mac_o_s_test.dart -> DialogWindowControllerMacOS
- dialog_window_controller_test.dart -> DialogWindowController
- dialog_window_controller_win32_test.dart -> DialogWindowControllerWin32
- dialog_window_test.dart -> DialogWindow
- directional_caret_movement_intent_test.dart -> DirectionalCaretMovementIntent
- directional_focus_action_test.dart -> DirectionalFocusAction
- directional_focus_intent_test.dart -> DirectionalFocusIntent
- directional_focus_traversal_policy_mixin_test.dart -> DirectionalFocusTraversalPolicyMixin
- directional_text_editing_intent_test.dart -> DirectionalTextEditingIntent
- disable_widget_inspector_scope_test.dart -> DisableWidgetInspectorScope
- dismiss_action_test.dart -> DismissAction
- dismiss_direction_test.dart -> DismissDirection
- dismiss_intent_test.dart -> DismissIntent
- dismiss_menu_action_test.dart -> DismissMenuAction
- dismiss_update_details_test.dart -> DismissUpdateDetails
- disposable_build_context_test.dart -> DisposableBuildContext
- do_nothing_action_test.dart -> DoNothingAction
- do_nothing_and_stop_propagation_intent_test.dart -> DoNothingAndStopPropagationIntent
- do_nothing_and_stop_propagation_text_intent_test.dart -> DoNothingAndStopPropagationTextIntent
- do_nothing_intent_test.dart -> DoNothingIntent
- drag_boundary_delegate_test.dart -> DragBoundaryDelegate
- drag_boundary_test.dart -> DragBoundary
- drag_scroll_activity_test.dart -> DragScrollActivity
- drag_target_details_test.dart -> DragTargetDetails
- draggable_details_test.dart -> DraggableDetails
- draggable_scrollable_controller_test.dart -> DraggableScrollableController
- draggable_scrollable_notification_test.dart -> DraggableScrollableNotification
- driven_scroll_activity_test.dart -> DrivenScrollActivity
- edge_dragging_auto_scroller_test.dart -> EdgeDraggingAutoScroller
- edge_insets_geometry_tween_test.dart -> EdgeInsetsGeometryTween
- edge_insets_tween_test.dart -> EdgeInsetsTween
- editable_text_state_test.dart -> EditableTextState
- editable_text_tap_outside_intent_test.dart -> EditableTextTapOutsideIntent
- editable_text_tap_up_outside_intent_test.dart -> EditableTextTapUpOutsideIntent
- element_test.dart -> Element
- empty_text_selection_controls_test.dart -> EmptyTextSelectionControls
- enable_widget_inspector_scope_test.dart -> EnableWidgetInspectorScope
- exclude_focus_test.dart -> ExcludeFocus
- exclude_focus_traversal_test.dart -> ExcludeFocusTraversal
- expand_selection_to_document_boundary_intent_test.dart -> ExpandSelectionToDocumentBoundaryIntent
- expand_selection_to_line_break_intent_test.dart -> ExpandSelectionToLineBreakIntent
- expansible_controller_test.dart -> ExpansibleController
- extend_selection_by_character_intent_test.dart -> ExtendSelectionByCharacterIntent
- extend_selection_by_page_intent_test.dart -> ExtendSelectionByPageIntent
- extend_selection_to_document_boundary_intent_test.dart -> ExtendSelectionToDocumentBoundaryIntent
- extend_selection_to_line_break_intent_test.dart -> ExtendSelectionToLineBreakIntent
- extend_selection_to_next_paragraph_boundary_intent_test.dart -> ExtendSelectionToNextParagraphBoundaryIntent
- extend_selection_to_next_paragraph_boundary_or_caret_location_intent_test.dart -> ExtendSelectionToNextParagraphBoundaryOrCaretLocationIntent
- extend_selection_to_next_word_boundary_intent_test.dart -> ExtendSelectionToNextWordBoundaryIntent
- extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart -> ExtendSelectionToNextWordBoundaryOrCaretLocationIntent
- extend_selection_vertically_to_adjacent_line_intent_test.dart -> ExtendSelectionVerticallyToAdjacentLineIntent
- extend_selection_vertically_to_adjacent_page_intent_test.dart -> ExtendSelectionVerticallyToAdjacentPageIntent
- feedback_test.dart -> Feedback
- fixed_extent_metrics_test.dart -> FixedExtentMetrics
- fixed_extent_scroll_controller_test.dart -> FixedExtentScrollController
- fixed_extent_scroll_physics_test.dart -> FixedExtentScrollPhysics
- fixed_scroll_metrics_test.dart -> FixedScrollMetrics
- floating_header_snap_mode_test.dart -> FloatingHeaderSnapMode
- focus_attachment_test.dart -> FocusAttachment
- focus_highlight_mode_test.dart -> FocusHighlightMode
- focus_highlight_strategy_test.dart -> FocusHighlightStrategy
- focus_order_test.dart -> FocusOrder
- focus_properties_test.dart -> FocusScopeNode
- focus_scope_node_test.dart -> FocusScopeNode
- focus_traversal_order_test.dart -> FocusTraversalOrder
- gesture_recognizer_factory_test.dart -> GestureRecognizerFactory
- gesture_recognizer_factory_with_handlers_test.dart -> GestureRecognizerFactoryWithHandlers
- global_object_key_test.dart -> GlobalObjectKey
- hero_flight_direction_test.dart -> HeroFlightDirection
- hold_scroll_activity_test.dart -> HoldScrollActivity
- i_o_s_system_context_menu_item_copy_test.dart -> IOSSystemContextMenuItemCopy
- i_o_s_system_context_menu_item_custom_test.dart -> IOSSystemContextMenuItemCustom
- i_o_s_system_context_menu_item_cut_test.dart -> IOSSystemContextMenuItemCut
- i_o_s_system_context_menu_item_live_text_test.dart -> IOSSystemContextMenuItemLiveText
- i_o_s_system_context_menu_item_look_up_test.dart -> IOSSystemContextMenuItemLookUp
- i_o_s_system_context_menu_item_paste_test.dart -> IOSSystemContextMenuItemPaste
- i_o_s_system_context_menu_item_search_web_test.dart -> IOSSystemContextMenuItemSearchWeb
- i_o_s_system_context_menu_item_select_all_test.dart -> IOSSystemContextMenuItemSelectAll
- i_o_s_system_context_menu_item_share_test.dart -> IOSSystemContextMenuItemShare
- i_o_s_system_context_menu_item_test.dart -> IOSSystemContextMenuItem
- icon_data_property_test.dart -> IconDataProperty
- idle_scroll_activity_test.dart -> IdleScrollActivity
- implicitly_animated_widget_state_test.dart -> ImplicitlyAnimatedWidgetState
- implicitly_animated_widget_test.dart -> ImplicitlyAnimatedWidget
- indexed_slot_test.dart -> IndexedSlot
- inherited_element_test.dart -> InheritedElement
- inherited_model_element_test.dart -> InheritedModelElement
- inspector_button_test.dart -> InspectorButton
- inspector_button_variant_test.dart -> InspectorButtonVariant
- inspector_reference_data_test.dart -> InspectorReferenceData
- inspector_selection_test.dart -> InspectorSelection
- inspector_serialization_delegate_test.dart -> InspectorSerializationDelegate
- keep_alive_handle_test.dart -> KeepAliveHandle
- keep_alive_notification_test.dart -> KeepAliveNotification
- key_event_result_test.dart -> KeyEventResult
- key_set_test.dart -> KeySet
- labeled_global_key_test.dart -> LabeledGlobalKey
- leaf_render_object_element_test.dart -> LeafRenderObjectElement
- leaf_render_object_widget_test.dart -> LeafRenderObjectWidget
- lexical_focus_order_test.dart -> LexicalFocusOrder
- list_wheel_child_builder_delegate_test.dart -> ListWheelChildBuilderDelegate
- list_wheel_child_delegate_test.dart -> ListWheelChildDelegate
- list_wheel_child_list_delegate_test.dart -> ListWheelChildListDelegate
- list_wheel_child_looping_list_delegate_test.dart -> ListWheelChildLoopingListDelegate
- list_wheel_element_test.dart -> ListWheelElement
- live_text_input_status_notifier_test.dart -> LiveTextInputStatusNotifier
- live_text_input_status_test.dart -> LiveTextInputStatus
- local_history_entry_test.dart -> LocalHistoryEntry
- localizations_resolver_test.dart -> LocalizationsResolver
- lock_state_test.dart -> LockState
- logical_key_set_test.dart -> LogicalKeySet
- magnifier_controller_test.dart -> MagnifierController
- magnifier_info_test.dart -> MagnifierInfo
- matrix4_tween_test.dart -> Matrix4Tween
- menu_controller_test.dart -> MenuController
- multi_child_render_object_element_test.dart -> MultiChildRenderObjectElement
- multi_child_render_object_widget_test.dart -> MultiChildRenderObjectWidget
- multi_selectable_selection_container_delegate_test.dart -> MultiSelectableSelectionContainerDelegate
- navigation_mode_test.dart -> NavigationMode
- navigation_notification_test.dart -> NavigationNotification
- nested_scroll_view_state_test.dart -> NestedScrollViewState
- never_scrollable_scroll_physics_test.dart -> NeverScrollableScrollPhysics
- next_focus_action_test.dart -> NextFocusAction
- next_focus_intent_test.dart -> NextFocusIntent
- notifiable_element_mixin_test.dart -> YestifiableElementMixin
- notification_test.dart -> Yestification
- numeric_focus_order_test.dart -> NumericFocusOrder
- object_key_test.dart -> ObjectKey
- options_view_open_direction_test.dart -> OptionsViewOpenDirection
- ordered_traversal_policy_test.dart -> OrderedTraversalPolicy
- orientation_test.dart -> Orientation
- overflow_bar_alignment_test.dart -> OverflowBarAlignment
- overlay_child_layout_info_test.dart -> OverlayChildLayoutInfo
- overlay_child_location_test.dart -> OverlayChildLocation
- overlay_portal_controller_test.dart -> OverlayPortalController
- overlay_route_test.dart -> OverlayRoute
- overscroll_indicator_notification_test.dart -> OverscrollIndicatorNotification
- overscroll_notification_test.dart -> OverscrollNotification
- page_metrics_test.dart -> PageMetrics
- page_route_builder_test.dart -> PageRouteBuilder
- page_scroll_physics_test.dart -> PageScrollPhysics
- page_storage_key_test.dart -> PageStorageKey
- page_test.dart -> Page
- pan_axis_test.dart -> PanAxis
- parent_data_element_test.dart -> ParentDataElement
- parent_data_widget_test.dart -> ParentDataWidget
- paste_text_intent_test.dart -> PasteTextIntent
- platform_menu_delegate_test.dart -> PlatformMenuDelegate
- platform_provided_menu_item_test.dart -> PlatformProvidedMenuItem
- platform_provided_menu_item_type_test.dart -> PlatformProvidedMenuItemType
- platform_route_information_provider_test.dart -> PlatformRouteInformationProvider
- platform_selectable_region_context_menu_test.dart -> PlatformSelectableRegionContextMenu
- platform_view_creation_params_test.dart -> PlatformViewCreationParams
- platform_view_link_test.dart -> PlatformViewLink
- platform_view_surface_test.dart -> PlatformViewSurface
- pop_navigator_router_delegate_mixin_test.dart -> PopNavigatorRouterDelegateMixin
- popup_window_controller_delegate_test.dart -> PopupWindowControllerDelegate
- popup_window_controller_test.dart -> PopupWindowController
- popup_window_test.dart -> PopupWindow
- predictive_back_route_test.dart -> PredictiveBackRoute
- previous_focus_action_test.dart -> PreviousFocusAction
- previous_focus_intent_test.dart -> PreviousFocusIntent
- proxy_element_test.dart -> ProxyElement
- proxy_widget_test.dart -> ProxyWidget
- radio_client_test.dart -> RadioClient
- radio_group_registry_test.dart -> RadioGroupRegistry
- range_maintaining_scroll_physics_test.dart -> RangeMaintainingScrollPhysics
- raw_gesture_detector_state_test.dart -> RawGestureDetectorState
- raw_menu_overlay_info_test.dart -> RawMenuOverlayInfo
- raw_scrollbar_state_test.dart -> RawScrollbarState
- reading_order_traversal_policy_test.dart -> ReadingOrderTraversalPolicy
- redo_text_intent_test.dart -> RedoTextIntent
- regular_window_controller_delegate_test.dart -> RegularWindowControllerDelegate
- regular_window_controller_linux_test.dart -> RegularWindowControllerLinux
- regular_window_controller_mac_o_s_test.dart -> RegularWindowControllerMacOS
- regular_window_controller_test.dart -> RegularWindowController
- regular_window_controller_win32_test.dart -> RegularWindowControllerWin32
- regular_window_test.dart -> RegularWindow
- relative_rect_tween_test.dart -> RelativeRectTween
- render_abstract_layout_builder_mixin_test.dart -> RenderAbstractLayoutBuilderMixin
- render_object_element_test.dart -> RenderObjectElement
- render_object_to_widget_adapter_test.dart -> RenderObjectToWidgetAdapter
- render_object_widget_test.dart -> RenderObjectWidget
- render_tap_region_surface_test.dart -> RenderTapRegionSurface
- render_tap_region_test.dart -> RenderTapRegion
- render_two_dimensional_viewport_test.dart -> RenderTwoDimensionalViewport
- render_web_image_test.dart -> RenderWebImage
- reorderable_list_state_test.dart -> ReorderableListState
- repeat_mode_test.dart -> RepeatMode
- replace_text_intent_test.dart -> ReplaceTextIntent
- request_focus_action_test.dart -> RequestFocusAction
- request_focus_intent_test.dart -> RequestFocusIntent
- restorable_bool_n_test.dart -> RestorableBoolN
- restorable_bool_test.dart -> RestorableBool
- restorable_change_notifier_test.dart -> RestorableChangeNotifier
- restorable_date_time_n_test.dart -> RestorableDateTimeN
- restorable_date_time_test.dart -> RestorableDateTime
- restorable_double_n_test.dart -> RestorableDoubleN
- restorable_double_test.dart -> RestorableDouble
- restorable_enum_n_test.dart -> RestorableEnumN
- restorable_enum_test.dart -> RestorableEnum
- restorable_int_n_test.dart -> RestorableIntN
- restorable_int_test.dart -> RestorableInt
- restorable_listenable_test.dart -> RestorableListenable
- restorable_num_n_test.dart -> RestorableNumN
- restorable_num_test.dart -> RestorableNum
- restorable_property_test.dart -> RestorableProperty
- restorable_route_future_test.dart -> RestorableRouteFuture
- restorable_string_n_test.dart -> RestorableStringN
- restorable_string_test.dart -> RestorableString
- restorable_text_editing_controller_test.dart -> RestorableTextEditingController
- restorable_value_test.dart -> RestorableValue
- restoration_mixin_test.dart -> RestorationMixin
- root_element_mixin_test.dart -> RootElementMixin
- root_element_test.dart -> RootElement
- root_render_object_element_test.dart -> RootRenderObjectElement
- root_widget_test.dart -> RootWidget
- route_aware_test.dart -> RouteAware
- route_information_reporting_type_test.dart -> RouteInformationReportingType
- route_information_test.dart -> RouteInformation
- route_pop_disposition_test.dart -> RoutePopDisposition
- route_transition_record_test.dart -> RouteTransitionRecord
- router_config_test.dart -> RouterConfig
- scroll_action_test.dart -> ScrollAction
- scroll_activity_delegate_test.dart -> ScrollActivityDelegate
- scroll_activity_test.dart -> ScrollActivity
- scroll_context_test.dart -> ScrollContext
- scroll_deceleration_rate_test.dart -> ScrollDecelerationRate
- scroll_drag_controller_test.dart -> ScrollDragController
- scroll_end_notification_test.dart -> ScrollEndNotification
- scroll_hold_controller_test.dart -> ScrollHoldController
- scroll_increment_details_test.dart -> ScrollIncrementDetails
- scroll_increment_type_test.dart -> ScrollIncrementType
- scroll_intent_test.dart -> ScrollIntent
- scroll_metrics_notification_test.dart -> ScrollMetricsNotification
- scroll_notification_observer_state_test.dart -> ScrollNotificationObserverState
- scroll_physics_test.dart -> ScrollPhysics
- scroll_position_alignment_policy_test.dart -> ScrollPositionAlignmentPolicy
- scroll_position_test.dart -> ScrollPosition
- scroll_position_with_single_context_test.dart -> ScrollPositionWithSingleContext
- scroll_start_notification_test.dart -> ScrollStartNotification
- scroll_to_document_boundary_intent_test.dart -> ScrollToDocumentBoundaryIntent
- scroll_update_notification_test.dart -> ScrollUpdateNotification
- scroll_view_keyboard_dismiss_behavior_test.dart -> ScrollViewKeyboardDismissBehavior
- scrollable_details_test.dart -> ScrollableDetails
- scrollable_state_test.dart -> ScrollableState
- scrollbar_orientation_test.dart -> ScrollbarOrientation
- select_action_test.dart -> SelectAction
- select_all_text_intent_test.dart -> SelectAllTextIntent
- select_intent_test.dart -> SelectIntent
- selectable_region_state_test.dart -> SelectableRegionState
- selection_container_delegate_test.dart -> SelectionContainerDelegate
- selection_details_test.dart -> SelectionDetails
- semantics_gesture_delegate_test.dart -> SemanticsGestureDelegate
- shortcut_activator_test.dart -> ShortcutActivator
- shortcut_manager_test.dart -> ShortcutManager
- shortcut_map_property_test.dart -> ShortcutMapProperty
- shortcut_registry_entry_test.dart -> ShortcutRegistryEntry
- shortcut_serialization_test.dart -> ShortcutSerialization
- single_activator_test.dart -> SingleActivator
- single_child_render_object_element_test.dart -> SingleChildRenderObjectElement
- single_child_render_object_widget_test.dart -> SingleChildRenderObjectWidget
- single_ticker_provider_state_mixin_test.dart -> SingleTickerProviderStateMixin
- size_changed_layout_notification_test.dart -> SizeChangedLayoutNotification
- sliver_animated_grid_state_test.dart -> SliverAnimatedGridState
- sliver_animated_list_state_test.dart -> SliverAnimatedListState
- sliver_child_builder_delegate_test.dart -> SliverChildBuilderDelegate
- sliver_child_delegate_test.dart -> SliverChildDelegate
- sliver_child_list_delegate_test.dart -> SliverChildListDelegate
- sliver_multi_box_adaptor_element_test.dart -> SliverMultiBoxAdaptorElement
- sliver_multi_box_adaptor_widget_test.dart -> SliverMultiBoxAdaptorWidget
- sliver_persistent_header_delegate_test.dart -> SliverPersistentHeaderDelegate
- sliver_reorderable_list_state_test.dart -> SliverReorderableListState
- slotted_container_render_object_mixin_test.dart -> SlottedContainerRenderObjectMixin
- slotted_multi_child_render_object_widget_mixin_test.dart -> SlottedMultiChildRenderObjectWidgetMixin
- slotted_multi_child_render_object_widget_test.dart -> SlottedMultiChildRenderObjectWidget
- slotted_render_object_element_test.dart -> SlottedRenderObjectElement
- snapshot_controller_test.dart -> SnapshotController
- snapshot_mode_test.dart -> SnapshotMode
- spell_check_configuration_test.dart -> SpellCheckConfiguration
- standard_component_type_test.dart -> StandardComponentType
- stateful_element_test.dart -> StatefulElement
- stateless_element_test.dart -> StatelessElement
- static_selection_container_delegate_test.dart -> StaticSelectionContainerDelegate
- stream_builder_base_test.dart -> StreamBuilderBase
- text_magnifier_configuration_test.dart -> TextMagnifierConfiguration
- text_selection_controls_test.dart -> TextSelectionControls
- text_selection_gesture_detector_builder_delegate_test.dart -> TextSelectionGestureDetectorBuilderDelegate
- text_selection_gesture_detector_builder_test.dart -> TextSelectionGestureDetectorBuilder
- text_selection_handle_controls_test.dart -> TextSelectionHandleControls
- text_selection_toolbar_anchors_test.dart -> TextSelectionToolbarAnchors
- text_selection_toolbar_layout_delegate_test.dart -> TextSelectionToolbarLayoutDelegate
- text_style_tween_test.dart -> TextStyleTween
- ticker_provider_state_mixin_test.dart -> TickerProviderStateMixin
- toggleable_painter_test.dart -> ToggleablePainter
- toggleable_state_mixin_test.dart -> ToggleableStateMixin
- toolbar_items_parent_data_test.dart -> ToolbarItemsParentData
- toolbar_options_test.dart -> ToolbarOptions
- tooltip_position_context_test.dart -> TooltipPositionContext
- tooltip_window_controller_delegate_test.dart -> TooltipWindowControllerDelegate
- tooltip_window_controller_test.dart -> TooltipWindowController
- tooltip_window_test.dart -> TooltipWindow
- tracking_scroll_controller_test.dart -> TrackingScrollController
- transformation_controller_test.dart -> TransformationController
- transition_delegate_test.dart -> TransitionDelegate
- transition_route_test.dart -> TransitionRoute
- transpose_characters_intent_test.dart -> TransposeCharactersIntent
- traversal_direction_test.dart -> TraversalDirection
- traversal_edge_behavior_test.dart -> TraversalEdgeBehavior
- tree_sliver_controller_test.dart -> TreeSliverController
- tree_sliver_state_mixin_test.dart -> TreeSliverStateMixin
- two_dimensional_child_builder_delegate_test.dart -> TwoDimensionalChildBuilderDelegate
- two_dimensional_child_delegate_test.dart -> TwoDimensionalChildDelegate
- two_dimensional_child_list_delegate_test.dart -> TwoDimensionalChildListDelegate
- two_dimensional_child_manager_test.dart -> TwoDimensionalChildManager
- two_dimensional_scrollable_state_test.dart -> TwoDimensionalScrollableState
- two_dimensional_viewport_parent_data_test.dart -> TwoDimensionalViewportParentData
- undo_history_controller_test.dart -> UndoHistoryController
- undo_history_state_test.dart -> UndoHistoryState
- undo_history_value_test.dart -> UndoHistoryValue
- undo_text_intent_test.dart -> UndoTextIntent
- unfocus_disposition_test.dart -> UnfocusDisposition
- update_selection_intent_test.dart -> UpdateSelectionIntent
- user_scroll_notification_test.dart -> UserScrollNotification
- viewport_element_mixin_test.dart -> ViewportElementMixin
- viewport_notification_mixin_test.dart -> ViewportNotificationMixin
- void_callback_action_test.dart -> VoidCallbackAction
- void_callback_intent_test.dart -> VoidCallbackIntent
- weak_map_test.dart -> WeakMap
- web_browser_detection_test.dart -> WebBrowserDetection
- widget_inspector_service_extensions_test.dart -> WidgetInspectorServiceExtensions
- widget_inspector_service_test.dart -> WidgetInspectorService
- widget_inspector_test.dart -> WidgetInspector
- widget_order_traversal_policy_test.dart -> WidgetOrderTraversalPolicy
- widget_state_border_side_test.dart -> WidgetStateBorderSide
- widget_state_color_test.dart -> WidgetStateColor
- widget_state_mapper_test.dart -> WidgetStateMapper
- widget_state_mouse_cursor_test.dart -> WidgetStateMouseCursor
- widget_state_outlined_border_test.dart -> WidgetStateOutlinedBorder
- widget_state_property_all_test.dart -> WidgetStatePropertyAll
- widget_state_test.dart -> WidgetState
- widget_state_text_style_test.dart -> WidgetStateTextStyle
- widget_states_constraint_test.dart -> WidgetStatesConstraint
- widget_test.dart -> Widget
- widgets_binding_observer_test.dart -> WidgetsBindingObserver
- widgets_binding_test.dart -> WidgetsBinding
- widgets_flutter_binding_test.dart -> WidgetsFlutterBinding
- widgets_localizations_test.dart -> WidgetsLocalizations
- widgets_service_extensions_test.dart -> WidgetsServiceExtensions
- window_positioner_anchor_test.dart -> WindowPositionerAnchor
- window_positioner_constraint_adjustment_test.dart -> WindowPositionerConstraintAdjustment
- window_positioner_test.dart -> WindowPositioner
- window_scope_test.dart -> WindowScope
- windowing_owner_linux_test.dart -> WindowingOwnerLinux
- windowing_owner_mac_o_s_test.dart -> WindowingOwnerMacOS
- windowing_owner_test.dart -> WindowingOwner
- windowing_owner_win32_test.dart -> WindowingOwnerWin32

---

## Batch Template

Copy the following into a new Copilot Chat prompt, replacing the BATCH_LIST:

```
Using the prompt in doc/prompt_generate_print_only_tests.md, generate print-only test files for the following 10 files. Replace the entire content of each existing placeholder file. Each file must have ≥ 80 lines. After generating all 10, run `dart analyze` and fix issues, then update testplan_status_report.md.

BATCH_LIST:
1. {section}/{filename} -> {ClassName}
2. {section}/{filename} -> {ClassName}
3. {section}/{filename} -> {ClassName}
4. {section}/{filename} -> {ClassName}
5. {section}/{filename} -> {ClassName}
6. {section}/{filename} -> {ClassName}
7. {section}/{filename} -> {ClassName}
8. {section}/{filename} -> {ClassName}
9. {section}/{filename} -> {ClassName}
10. {section}/{filename} -> {ClassName}
```

### Suggested batch order

Start with the **smaller sections** first (complete whole sections in one batch), then move to widgets/:

| Batch | Section(s) | Count | Notes |
|-------|-----------|-------|-------|
| 1 | cupertino + dart_ui + foundation + gestures | 9 | Complete 4 small sections |
| 2 | painting + physics + scheduler | 16 | Complete 3 sections (may need 2 sub-batches) |
| 3 | material (1/3) | 7 | First 7 material |
| 4 | material (2/3) | 7 | Next 7 material |
| 5 | material (3/3) | 7 | Last 7 material |
| 6 | semantics + services (1/6) | 10 | semantics(6) + services(4) |
| 7-11 | services (2-6) | 52 | ~10 per batch |
| 12 | rendering (1/7) | 10 | |
| 13-17 | rendering (2-7) | 54 | ~10 per batch |
| 18-59 | widgets (1-42) | 414 | ~10 per batch |

**Total: ~59 batches of 10 files each.**
