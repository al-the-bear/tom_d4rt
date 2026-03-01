# D4rt Flutter Bridge Test Plan

Comprehensive test coverage plan for validating all bridged Flutter classes in tom_d4rt_flutterm.

## Summary Statistics

| Module | Bridge File | Class Count | Priority Tests |
|--------|-------------|-------------|----------------|
| dart:ui | dart_ui_bridges.b.dart | 204 | 25 |
| painting | painting_bridges.b.dart | 184 | 30 |
| foundation | foundation_bridges.b.dart | 92 | 15 |
| animation | animation_bridges.b.dart | 54 | 12 |
| physics | physics_bridges.b.dart | 18 | 6 |
| scheduler | scheduler_bridges.b.dart | 16 | 4 |
| semantics | semantics_bridges.b.dart | 52 | 8 |
| services | services_bridges.b.dart | 190 | 20 |
| gestures | gestures_bridges.b.dart | 142 | 15 |
| rendering | rendering_bridges.b.dart | 738 | 25 |
| widgets | widgets_bridges.b.dart | 1806 | 50 |
| material | material_widgets_bridges.b.dart | 2576 | 60 |
| cupertino | cupertino_bridges.b.dart | 1962 | 30 |
| **TOTAL** | | **8,034** | **300** |

## Priority Tiers

### Tier 1: Core Primitives (Immediate)
Classes that are fundamental building blocks used by almost everything else.

### Tier 2: Common Widgets (High Priority)
Frequently used widgets and classes in typical Flutter applications.

### Tier 3: Specialized (Medium Priority)
Less common but important specialized functionality.

### Tier 4: Advanced (Low Priority)
Advanced features, platform-specific, or rarely used classes.

---

## Module: dart:ui (204 classes)

### Tier 1 - Core Primitives
| Class | Test File | Status |
|-------|-----------|--------|
| Color | dart_ui/color_test.dart | ✅ Exists |
| Offset | dart_ui/offset_test.dart | ⬜ |
| Size | dart_ui/size_test.dart | ⬜ |
| Rect | dart_ui/rect_test.dart | ⬜ |
| Radius | dart_ui/radius_test.dart | ⬜ |
| RRect | dart_ui/rrect_test.dart | ⬜ |
| Paint | dart_ui/paint_test.dart | ⬜ |
| Path | dart_ui/path_test.dart | ⬜ |

### Tier 2 - Commonly Used
| Class | Test File | Status |
|-------|-----------|--------|
| Canvas | dart_ui/canvas_test.dart | ⬜ |
| Picture | dart_ui/picture_test.dart | ⬜ |
| PictureRecorder | dart_ui/picture_recorder_test.dart | ⬜ |
| Gradient | dart_ui/gradient_test.dart | ⬜ |
| Image | dart_ui/image_test.dart | ⬜ |
| TextStyle | dart_ui/text_style_test.dart | ⬜ |
| ParagraphStyle | dart_ui/paragraph_style_test.dart | ⬜ |
| ParagraphBuilder | dart_ui/paragraph_builder_test.dart | ⬜ |
| FontWeight | dart_ui/font_weight_test.dart | ⬜ |

### Tier 3 - Specialized
| Class | Test File | Status |
|-------|-----------|--------|
| ColorFilter | dart_ui/color_filter_test.dart | ⬜ |
| ImageFilter | dart_ui/image_filter_test.dart | ⬜ |
| MaskFilter | dart_ui/mask_filter_test.dart | ⬜ |
| Shader | dart_ui/shader_test.dart | ⬜ |
| FragmentProgram | dart_ui/fragment_program_test.dart | ⬜ |
| Vertices | dart_ui/vertices_test.dart | ⬜ |

---

## Module: painting (184 classes)

### Tier 1 - Core Primitives
| Class | Test File | Status |
|-------|-----------|--------|
| EdgeInsets | painting/edge_insets_test.dart | ⬜ |
| EdgeInsetsDirectional | painting/edge_insets_directional_test.dart | ⬜ |
| BorderRadius | painting/border_radius_test.dart | ⬜ |
| BorderRadiusDirectional | painting/border_radius_directional_test.dart | ⬜ |
| Border | painting/border_test.dart | ⬜ |
| BorderSide | painting/border_side_test.dart | ⬜ |
| BoxDecoration | painting/box_decoration_test.dart | ⬜ |
| BoxShadow | painting/box_shadow_test.dart | ⬜ |

### Tier 2 - Commonly Used
| Class | Test File | Status |
|-------|-----------|--------|
| Alignment | painting/alignment_test.dart | ⬜ |
| AlignmentDirectional | painting/alignment_directional_test.dart | ⬜ |
| TextStyle | painting/text_style_test.dart | ⬜ |
| TextSpan | painting/text_span_test.dart | ⬜ |
| TextPainter | painting/text_painter_test.dart | ⬜ |
| ImageProvider | painting/image_provider_test.dart | ⬜ |
| AssetImage | painting/asset_image_test.dart | ⬜ |
| NetworkImage | painting/network_image_test.dart | ⬜ |
| LinearGradient | painting/linear_gradient_test.dart | ⬜ |
| RadialGradient | painting/radial_gradient_test.dart | ⬜ |

### Tier 3 - Shapes
| Class | Test File | Status |
|-------|-----------|--------|
| RoundedRectangleBorder | painting/rounded_rectangle_border_test.dart | ⬜ |
| CircleBorder | painting/circle_border_test.dart | ⬜ |
| StadiumBorder | painting/stadium_border_test.dart | ⬜ |
| BeveledRectangleBorder | painting/beveled_rectangle_border_test.dart | ⬜ |
| ContinuousRectangleBorder | painting/continuous_rectangle_border_test.dart | ⬜ |

---

## Module: foundation (92 classes)

### Tier 1 - Core
| Class | Test File | Status |
|-------|-----------|--------|
| ChangeNotifier | foundation/change_notifier_test.dart | ⬜ |
| ValueNotifier | foundation/value_notifier_test.dart | ⬜ |
| Listenable | foundation/listenable_test.dart | ⬜ |
| Key | foundation/key_test.dart | ⬜ |
| LocalKey | foundation/local_key_test.dart | ⬜ |
| UniqueKey | foundation/unique_key_test.dart | ⬜ |
| ValueKey | foundation/value_key_test.dart | ⬜ |
| ObjectKey | foundation/object_key_test.dart | ⬜ |

### Tier 2 - Diagnostics
| Class | Test File | Status |
|-------|-----------|--------|
| DiagnosticsNode | foundation/diagnostics_node_test.dart | ⬜ |
| DiagnosticPropertiesBuilder | foundation/diagnostic_properties_builder_test.dart | ⬜ |
| FlutterError | foundation/flutter_error_test.dart | ⬜ |
| FlutterErrorDetails | foundation/flutter_error_details_test.dart | ⬜ |

---

## Module: animation (54 classes)

### Tier 1 - Core Animation
| Class | Test File | Status |
|-------|-----------|--------|
| Animation | animation/animation_test.dart | ⬜ |
| AnimationController | animation/animation_controller_test.dart | ⬜ |
| Tween | animation/tween_test.dart | ⬜ |
| CurvedAnimation | animation/curved_animation_test.dart | ⬜ |
| Curve | animation/curve_test.dart | ⬜ |

### Tier 2 - Animation Utilities
| Class | Test File | Status |
|-------|-----------|--------|
| AlwaysStoppedAnimation | animation/always_stopped_animation_test.dart | ⬜ |
| ProxyAnimation | animation/proxy_animation_test.dart | ⬜ |
| ReverseAnimation | animation/reverse_animation_test.dart | ⬜ |
| TweenSequence | animation/tween_sequence_test.dart | ⬜ |
| SpringDescription | animation/spring_description_test.dart | ⬜ |

---

## Module: physics (18 classes)

### All Classes (Small Module)
| Class | Test File | Status |
|-------|-----------|--------|
| Simulation | physics/simulation_test.dart | ⬜ |
| SpringSimulation | physics/spring_simulation_test.dart | ⬜ |
| SpringDescription | physics/spring_description_test.dart | ⬜ |
| FrictionSimulation | physics/friction_simulation_test.dart | ⬜ |
| GravitySimulation | physics/gravity_simulation_test.dart | ⬜ |
| Tolerance | physics/tolerance_test.dart | ⬜ |

---

## Module: widgets (1806 classes)

### Tier 1 - Layout Widgets
| Class | Test File | Status |
|-------|-----------|--------|
| Container | widgets/container_test.dart | ⬜ |
| Center | widgets/center_test.dart | ⬜ |
| Padding | widgets/padding_test.dart | ⬜ |
| Align | widgets/align_test.dart | ⬜ |
| SizedBox | widgets/sized_box_test.dart | ⬜ |
| ConstrainedBox | widgets/constrained_box_test.dart | ⬜ |
| AspectRatio | widgets/aspect_ratio_test.dart | ⬜ |
| FittedBox | widgets/fitted_box_test.dart | ⬜ |
| LimitedBox | widgets/limited_box_test.dart | ⬜ |
| Expanded | widgets/expanded_test.dart | ⬜ |
| Flexible | widgets/flexible_test.dart | ⬜ |
| Spacer | widgets/spacer_test.dart | ⬜ |

### Tier 1 - Flex Widgets
| Class | Test File | Status |
|-------|-----------|--------|
| Row | widgets/row_test.dart | ⬜ |
| Column | widgets/column_test.dart | ⬜ |
| Wrap | widgets/wrap_test.dart | ⬜ |
| Stack | widgets/stack_test.dart | ⬜ |
| Positioned | widgets/positioned_test.dart | ⬜ |
| IndexedStack | widgets/indexed_stack_test.dart | ⬜ |

### Tier 1 - Text Widgets
| Class | Test File | Status |
|-------|-----------|--------|
| Text | widgets/text_test.dart | ⬜ |
| RichText | widgets/rich_text_test.dart | ⬜ |
| DefaultTextStyle | widgets/default_text_style_test.dart | ⬜ |

### Tier 2 - Scrolling
| Class | Test File | Status |
|-------|-----------|--------|
| ListView | widgets/list_view_test.dart | ⬜ |
| GridView | widgets/grid_view_test.dart | ⬜ |
| SingleChildScrollView | widgets/single_child_scroll_view_test.dart | ⬜ |
| CustomScrollView | widgets/custom_scroll_view_test.dart | ⬜ |
| ScrollController | widgets/scroll_controller_test.dart | ⬜ |
| PageView | widgets/page_view_test.dart | ⬜ |

### Tier 2 - Interactive
| Class | Test File | Status |
|-------|-----------|--------|
| GestureDetector | widgets/gesture_detector_test.dart | ⬜ |
| InkWell | widgets/ink_well_test.dart | ⬜ |
| Dismissible | widgets/dismissible_test.dart | ⬜ |
| Draggable | widgets/draggable_test.dart | ⬜ |
| DragTarget | widgets/drag_target_test.dart | ⬜ |

### Tier 2 - Decoration
| Class | Test File | Status |
|-------|-----------|--------|
| DecoratedBox | widgets/decorated_box_test.dart | ⬜ |
| ClipRRect | widgets/clip_rrect_test.dart | ⬜ |
| ClipOval | widgets/clip_oval_test.dart | ⬜ |
| ClipPath | widgets/clip_path_test.dart | ⬜ |
| Opacity | widgets/opacity_test.dart | ⬜ |
| Transform | widgets/transform_test.dart | ⬜ |

### Tier 3 - Navigation
| Class | Test File | Status |
|-------|-----------|--------|
| Navigator | widgets/navigator_test.dart | ⬜ |
| NavigatorState | widgets/navigator_state_test.dart | ⬜ |
| Route | widgets/route_test.dart | ⬜ |
| PageRoute | widgets/page_route_test.dart | ⬜ |

---

## Module: material (2576 classes)

### Tier 1 - App Structure
| Class | Test File | Status |
|-------|-----------|--------|
| MaterialApp | material/material_app_test.dart | ⬜ |
| Scaffold | material/scaffold_test.dart | ⬜ |
| AppBar | material/app_bar_test.dart | ⬜ |
| BottomNavigationBar | material/bottom_navigation_bar_test.dart | ⬜ |
| Drawer | material/drawer_test.dart | ⬜ |
| NavigationRail | material/navigation_rail_test.dart | ⬜ |
| TabBar | material/tab_bar_test.dart | ⬜ |
| TabBarView | material/tab_bar_view_test.dart | ⬜ |

### Tier 1 - Buttons
| Class | Test File | Status |
|-------|-----------|--------|
| ElevatedButton | material/elevated_button_test.dart | ⬜ |
| TextButton | material/text_button_test.dart | ⬜ |
| OutlinedButton | material/outlined_button_test.dart | ⬜ |
| IconButton | material/icon_button_test.dart | ⬜ |
| FloatingActionButton | material/floating_action_button_test.dart | ⬜ |
| FilledButton | material/filled_button_test.dart | ⬜ |

### Tier 1 - Input
| Class | Test File | Status |
|-------|-----------|--------|
| TextField | material/text_field_test.dart | ⬜ |
| TextFormField | material/text_form_field_test.dart | ⬜ |
| Checkbox | material/checkbox_test.dart | ⬜ |
| Radio | material/radio_test.dart | ⬜ |
| Switch | material/switch_test.dart | ⬜ |
| Slider | material/slider_test.dart | ⬜ |
| DropdownButton | material/dropdown_button_test.dart | ⬜ |

### Tier 1 - Display
| Class | Test File | Status |
|-------|-----------|--------|
| Card | material/card_test.dart | ⬜ |
| ListTile | material/list_tile_test.dart | ⬜ |
| Divider | material/divider_test.dart | ⬜ |
| Chip | material/chip_test.dart | ⬜ |
| CircularProgressIndicator | material/circular_progress_indicator_test.dart | ⬜ |
| LinearProgressIndicator | material/linear_progress_indicator_test.dart | ⬜ |
| Icon | material/icon_test.dart | ⬜ |

### Tier 2 - Dialogs & Overlays
| Class | Test File | Status |
|-------|-----------|--------|
| AlertDialog | material/alert_dialog_test.dart | ⬜ |
| SimpleDialog | material/simple_dialog_test.dart | ⬜ |
| BottomSheet | material/bottom_sheet_test.dart | ⬜ |
| SnackBar | material/snack_bar_test.dart | ⬜ |
| PopupMenuButton | material/popup_menu_button_test.dart | ⬜ |
| Tooltip | material/tooltip_test.dart | ⬜ |

### Tier 2 - Theming
| Class | Test File | Status |
|-------|-----------|--------|
| Theme | material/theme_test.dart | ⬜ |
| ThemeData | material/theme_data_test.dart | ⬜ |
| ColorScheme | material/color_scheme_test.dart | ⬜ |
| TextTheme | material/text_theme_test.dart | ⬜ |

---

## Module: cupertino (1962 classes)

### Tier 1 - Core iOS Widgets
| Class | Test File | Status |
|-------|-----------|--------|
| CupertinoApp | cupertino/cupertino_app_test.dart | ⬜ |
| CupertinoPageScaffold | cupertino/cupertino_page_scaffold_test.dart | ⬜ |
| CupertinoNavigationBar | cupertino/cupertino_navigation_bar_test.dart | ⬜ |
| CupertinoTabBar | cupertino/cupertino_tab_bar_test.dart | ⬜ |
| CupertinoTabScaffold | cupertino/cupertino_tab_scaffold_test.dart | ⬜ |

### Tier 1 - Buttons & Controls
| Class | Test File | Status |
|-------|-----------|--------|
| CupertinoButton | cupertino/cupertino_button_test.dart | ⬜ |
| CupertinoSwitch | cupertino/cupertino_switch_test.dart | ⬜ |
| CupertinoSlider | cupertino/cupertino_slider_test.dart | ⬜ |
| CupertinoTextField | cupertino/cupertino_text_field_test.dart | ⬜ |
| CupertinoSegmentedControl | cupertino/cupertino_segmented_control_test.dart | ⬜ |

### Tier 2 - Dialogs & Pickers
| Class | Test File | Status |
|-------|-----------|--------|
| CupertinoAlertDialog | cupertino/cupertino_alert_dialog_test.dart | ⬜ |
| CupertinoActionSheet | cupertino/cupertino_action_sheet_test.dart | ⬜ |
| CupertinoDatePicker | cupertino/cupertino_date_picker_test.dart | ⬜ |
| CupertinoPicker | cupertino/cupertino_picker_test.dart | ⬜ |

---

## Implementation Order

### Phase 1: Core Foundation (Week 1)
1. dart_ui/offset_test.dart
2. dart_ui/size_test.dart
3. dart_ui/rect_test.dart
4. painting/edge_insets_test.dart
5. painting/border_radius_test.dart
6. painting/alignment_test.dart
7. painting/box_decoration_test.dart

### Phase 2: Basic Widgets (Week 2)
1. widgets/container_test.dart
2. widgets/center_test.dart
3. widgets/padding_test.dart
4. widgets/row_test.dart
5. widgets/column_test.dart
6. widgets/text_test.dart
7. widgets/sized_box_test.dart
8. widgets/expanded_test.dart

### Phase 3: Material Widgets (Week 3)
1. material/scaffold_test.dart
2. material/app_bar_test.dart
3. material/elevated_button_test.dart
4. material/text_button_test.dart
5. material/card_test.dart
6. material/list_tile_test.dart
7. material/text_field_test.dart
8. material/icon_test.dart

### Phase 4: Animation & More (Week 4)
1. animation/animation_test.dart
2. animation/tween_test.dart
3. animation/curve_test.dart
4. foundation/change_notifier_test.dart
5. physics/spring_simulation_test.dart
6. widgets/list_view_test.dart
7. widgets/gesture_detector_test.dart

### Phase 5: Cupertino (Optional)
1. cupertino/cupertino_button_test.dart
2. cupertino/cupertino_page_scaffold_test.dart
3. cupertino/cupertino_text_field_test.dart

---

## Test Script Template

```dart
// D4rt test script: Tests <ClassName> from <module>
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // Test marker for validation
  print('<ClassName> test executing');
  
  // Create and configure the widget/object
  final widget = <ConstructorCall>();
  
  // Print validation markers
  print('<ClassName> created successfully');
  
  return widget;
}
```

## Validation Criteria

Each test should verify:
1. ✅ Class is accessible (can be referenced)
2. ✅ Constructor(s) work without errors
3. ✅ Basic properties can be set
4. ✅ Widget renders (for widget classes)
5. ✅ Print output is captured correctly

## Status Legend

| Symbol | Meaning |
|--------|---------|
| ⬜ | Not started |
| 🔄 | In progress |
| ✅ | Complete |
| ❌ | Failed / Blocked |
| ⏭️ | Skipped (not testable via script) |
