# Script Issues

batch: 0

- No non-immediate batch-0 script issues remained after immediate fixes.
- Immediate batch-0 script fixes were applied and validated for:
  - cupertino/controls_test.dart
  - cupertino/form_test.dart
  - cupertino/textfield_test.dart
  - rendering/viewport_test.dart

batch: 1

- No non-immediate batch-1 script issues remained after immediate fixes.
- Immediate batch-1 script fixes were applied and validated for:
  - animation/reverse_tween_test.dart
  - cupertino/cupertino_desktop_text_selection_controls_test.dart
  - cupertino/cupertino_focus_halo_test.dart
  - cupertino/cupertino_text_selection_handle_controls_test.dart

batch: 2

- No non-immediate batch-2 script issues remained after immediate fixes.
- Immediate batch-2 script fixes were applied and validated for:
  - cupertino/inherited_cupertino_theme_test.dart
  - cupertino/overlay_visibility_mode_test.dart
  - dart_ui/blur_style_test.dart
  - dart_ui/color_space_test.dart
  - dart_ui/key_event_type_test.dart
- Notes:
  - `color_space_test.dart` and `key_event_type_test.dart` were stabilized with script-level mitigations while related interpreter/bridge follow-up analysis was documented in `interpreter_issues.md` and `generator_issues.md`.

batch: 3

- No non-immediate batch-3 script issues remained after immediate fixes.
- Immediate batch-3 script fixes were applied and validated for:
  - dart_ui/placeholder_alignment_test.dart
  - dart_ui/system_color_palette_test.dart
  - dart_ui/vertex_mode_test.dart
  - foundation/object_created_test.dart
  - foundation/object_disposed_test.dart
- Notes:
  - `system_color_palette_test.dart` was stabilized with unsupported-platform fallback rendering while interpreter platform capability follow-up was documented in `interpreter_issues.md`.
  - `vertex_mode_test.dart`, `object_created_test.dart`, and `object_disposed_test.dart` include script-level mitigations with bridge follow-up items documented in `generator_issues.md`.

batch: 4

- No non-immediate batch-4 script issues remained after immediate fixes.
- Immediate batch-4 script/harness fixes were applied and validated for:
  - foundation/object_event_test.dart
  - foundation/target_platform_test.dart
  - gestures/class_test.dart
  - test/hardly_relevant_classes_2_test.dart (setUpAll log-only indexing mitigation)
  - material/bottom_navigation_bar_type_test.dart
- Notes:
  - `object_event_test.dart` and `bottom_navigation_bar_type_test.dart` were stabilized with script-level mitigations while related bridge follow-up analysis was documented in `generator_issues.md`.

batch: 5

- No non-immediate batch-5 script issues remained after immediate fixes.
- Immediate batch-5 script fixes were applied and validated for:
  - material/button_bar_layout_behavior_test.dart
  - material/button_bar_theme_test.dart
  - material/button_text_theme_test.dart
  - material/collapse_mode_test.dart
  - material/drawer_controller_state_test.dart
- Notes:
  - `collapse_mode_test.dart` and `drawer_controller_state_test.dart` were direct script-level contract/layout fixes.
  - `button_bar_layout_behavior_test.dart`, `button_bar_theme_test.dart`, and `button_text_theme_test.dart` are stabilized script-side while deeper interpreter/bridge follow-up is documented in `interpreter_issues.md` and `generator_issues.md`.

batch: 6

- No non-immediate batch-6 script issues remained after immediate fixes.
- Immediate batch-6 script fixes were applied and validated for:
  - material/dropdown_menu_close_behavior_test.dart
  - material/end_drawer_button_test.dart
  - material/gapped_range_slider_track_shape_test.dart
  - material/gapped_slider_track_shape_test.dart
  - material/hour_format_test.dart
- Notes:
  - `end_drawer_button_test.dart` and `gapped_slider_track_shape_test.dart` were direct script-level layout/theme-contract stabilizations.
  - `dropdown_menu_close_behavior_test.dart`, `gapped_range_slider_track_shape_test.dart`, and `hour_format_test.dart` are stabilized script-side while deeper interpreter follow-up is documented in `interpreter_issues.md`.

batch: 7

- No non-immediate batch-7 script issues remained after immediate fixes.
- Immediate batch-7 script fixes were applied and validated for:
  - material/list_tile_title_alignment_test.dart
  - material/material_banner_closed_reason_test.dart
  - material/menu_accelerator_callback_binding_test.dart
  - material/navigation_destination_label_behavior_test.dart
  - material/navigation_drawer_theme_test.dart
- Notes:
  - `list_tile_title_alignment_test.dart`, `menu_accelerator_callback_binding_test.dart`, and `navigation_drawer_theme_test.dart` were direct script-level layout/constraint stabilizations.
  - `material_banner_closed_reason_test.dart` and `navigation_destination_label_behavior_test.dart` are stabilized script-side while deeper interpreter follow-up is documented in `interpreter_issues.md`.
