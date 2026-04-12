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

batch: 8

- No non-immediate batch-8 script issues remained after immediate fixes.
- Immediate batch-8 script fixes were applied and validated for:
  - material/navigation_rail_label_type_test.dart
  - material/paginated_data_table_state_test.dart
  - material/popup_menu_position_test.dart
  - material/progress_indicator_test.dart
  - material/refresh_progress_indicator_test.dart
- Notes:
  - `paginated_data_table_state_test.dart`, `progress_indicator_test.dart`, and `refresh_progress_indicator_test.dart` were direct script-level layout/value-contract stabilizations.
  - `navigation_rail_label_type_test.dart` and `popup_menu_position_test.dart` are stabilized script-side while deeper interpreter/generator follow-up is documented in `interpreter_issues.md` and `generator_issues.md`.

batch: 9

- No non-immediate batch-9 script issues remained after immediate fixes.
- Immediate batch-9 script fixes were applied and validated for:
  - material/theme_extension_test.dart
  - material/theme_mode_test.dart
  - material/thumb_test.dart
  - material/time_of_day_format_test.dart
  - material/time_picker_entry_mode_test.dart
- Notes:
  - `theme_mode_test.dart`, `thumb_test.dart`, and `time_picker_entry_mode_test.dart` were direct script-level layout-bounding stabilizations.
  - `theme_extension_test.dart` is stabilized script-side while deeper bridge-generator follow-up is documented in `generator_issues.md`.
  - Complex script deep analysis (issue-index: 48, `time_of_day_format_test.dart`):
    - The prior script produced a high-volume cascade of infinite-size errors (47) across multiple render layers, indicating broad unbounded composition rather than a single widget misuse.
    - Repeated failure signatures across adjacent time-related scripts suggest a shared scaffold pattern with missing size constraints in interactive sections.
    - Immediate mitigation moved the scenario to a bounded `ListView`-based summary flow, eliminating framework errors, but long-term script quality should enforce reusable bounded-layout helpers for material time demos.

batch: 10

- No non-immediate batch-10 script issues remained after immediate fixes.
- Immediate batch-10 script fixes were applied and validated for:
  - material/toggle_buttons_theme_data_test.dart
  - material/toggle_buttons_theme_test.dart
  - material/tooltip_state_test.dart
  - painting/axis_direction_test.dart
  - painting/axis_test.dart
- Notes:
  - `tooltip_state_test.dart` and `axis_test.dart` were direct script-level constructor/layout contract stabilizations.
  - `toggle_buttons_theme_data_test.dart`, `toggle_buttons_theme_test.dart`, and `axis_direction_test.dart` are stabilized script-side while deeper bridge/interpreter follow-up is documented in `generator_issues.md` and `interpreter_issues.md`.

batch: 11

- No non-immediate batch-11 script issues remained after immediate fixes.
- Immediate batch-11 script/harness fixes were applied and validated for:
  - test/hardly_relevant_classes_3_test.dart (setUpAll log-only indexing mitigation)
  - rendering/floating_header_snap_configuration_test.dart
  - rendering/hit_test_behavior_test.dart
  - rendering/over_scroll_header_stretch_configuration_test.dart
  - rendering/pipeline_manifold_test.dart
- Notes:
  - `floating_header_snap_configuration_test.dart` and `pipeline_manifold_test.dart` were direct script-level layout/state-initialization stabilizations.
  - `hit_test_behavior_test.dart` and `over_scroll_header_stretch_configuration_test.dart` are stabilized script-side while deeper interpreter/bridge follow-up is documented in `interpreter_issues.md` and `generator_issues.md`.

batch: 12

- No non-immediate batch-12 script issues remained after immediate fixes.
- Immediate batch-12 script fixes were applied and validated for:
  - rendering/placeholder_span_index_semantics_tag_test.dart
  - rendering/platform_view_render_box_test.dart
  - rendering/render_abstract_viewport_test.dart
  - rendering/render_android_view_test.dart
  - rendering/render_animated_opacity_mixin_test.dart
- Notes:
  - `placeholder_span_index_semantics_tag_test.dart`, `platform_view_render_box_test.dart`, `render_abstract_viewport_test.dart`, and `render_animated_opacity_mixin_test.dart` were direct script-level state/layout stabilizations.
  - `render_android_view_test.dart` is stabilized script-side while deeper interpreter follow-up is documented in `interpreter_issues.md`.

batch: 13

- No non-immediate batch-13 script issues remained after immediate fixes.
- Immediate batch-13 script fixes were applied and validated for:
  - rendering/render_animated_size_state_test.dart
  - rendering/render_clip_r_superellipse_test.dart
  - rendering/render_editable_painter_test.dart
  - rendering/render_sliver_box_child_manager_test.dart
  - rendering/render_sliver_floating_pinned_persistent_header_test.dart
- Notes:
  - `render_clip_r_superellipse_test.dart`, `render_editable_painter_test.dart`, and `render_sliver_floating_pinned_persistent_header_test.dart` were direct script-level null-contract/layout/state-context stabilizations.
  - `render_animated_size_state_test.dart` and `render_sliver_box_child_manager_test.dart` are stabilized script-side while deeper bridge-generator follow-up is documented in `generator_issues.md`.
