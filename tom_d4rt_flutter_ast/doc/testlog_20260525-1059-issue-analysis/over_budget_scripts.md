# Over-budget scripts — bisection TODO list

Generated from `testlog_20260525-1059-issue-analysis` result JSONs. Every entry is a script whose `/build` exceeded 30 s. Each is a bisection-and-fix item per §6 step #17c/#17d in the parent `error_analysis.md`.

Format: `kind` is `Transport` (test app `/build` did not respond within its 25 s internal budget) or `Timeout-30s` (harness `Future.timeout` fired). Both mean the script + interpreter combination took > 25 s to produce a Widget.

## flutter_ast

### essential_classes_test (3)

- [ ] `animation/ curve_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ row_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ transform_test.dart` — _Transport_ — _fixed:_

### secondary_classes_test (23)

- [ ] `widgets/ focus_properties_test.dart` — _Transport_ — _fixed:_
- [ ] `gestures/ individual horizontal_multi_drag_gesture_recognizer_test.dart` — _Transport_ — _fixed:_
- [ ] `gestures/ individual tap_drag_start_details_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ individual data_table_source_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ individual material_type_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ individual scaffold_messenger_state_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ individual tooltip_visibility_test.dart` — _Transport_ — _fixed:_
- [ ] `painting/ individual linear_border_edge_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ individual color_filter_layer_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ individual relayout_when_system_fonts_change_mixin_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ individual render_editable_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ individual render_physical_shape_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ individual render_sliver_fixed_extent_list_test.dart` — _Transport_ — _fixed:_
- [ ] `services/ individual autofill_configuration_test.dart` — _Transport_ — _fixed:_
- [ ] `services/ individual process_text_action_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ individual animated_modal_barrier_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ individual context_menu_controller_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ individual inherited_theme_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ individual multi_child_render_object_element_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ individual platform_menu_item_group_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ individual root_element_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ individual single_ticker_provider_state_mixin_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ individual spell_check_configuration_test.dart` — _Transport_ — _fixed:_

### hardly_relevant_classes_1_test (10)

- [ ] `animation/ elastic_out_curve_test.dart` — _Transport_ — _fixed:_
- [ ] `cupertino/ cupertino_list_tile_chevron_test.dart` — _Transport_ — _fixed:_
- [ ] `dart_ui/ channel_buffers_test.dart` — _Transport_ — _fixed:_
- [ ] `dart_ui/ font_style_test.dart` — _Transport_ — _fixed:_
- [ ] `dart_ui/ shader_mask_engine_layer_test.dart` — _Transport_ — _fixed:_
- [ ] `dart_ui/ view_focus_direction_test.dart` — _Transport_ — _fixed:_
- [ ] `foundation/ documentation_icon_test.dart` — _Transport_ — _fixed:_
- [ ] `foundation/ summary_test.dart` — _Transport_ — _fixed:_
- [ ] `gestures/ mac_o_s_scroll_view_fling_velocity_tracker_test.dart` — _Transport_ — _fixed:_
- [ ] `gestures/ pointer_scale_event_test.dart` — _Transport_ — _fixed:_

### hardly_relevant_classes_2_test (9)

- [ ] `material/ carousel_view_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ dropdown_menu_form_field_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ ink_decoration_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ material_state_underline_input_border_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ platform_adaptive_icons_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ restorable_time_of_day_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ slider_interaction_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ time_of_day_format_test.dart` — _Transport_ — _fixed:_
- [ ] `painting/ matrix_utils_test.dart` — _Transport_ — _fixed:_

### hardly_relevant_classes_3_test (11)

- [ ] `rendering/ flow_painting_context_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ render_abstract_viewport_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ render_ui_kit_view_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ sliver_logical_container_parent_data_test.dart` — _Transport_ — _fixed:_
- [ ] `semantics/ announce_semantics_event_test.dart` — _Transport_ — _fixed:_
- [ ] `services/ background_isolate_binary_messenger_test.dart` — _Transport_ — _fixed:_
- [ ] `services/ i_o_s_system_context_menu_item_data_test.dart` — _Transport_ — _fixed:_
- [ ] `services/ method_codec_test.dart` — _Transport_ — _fixed:_
- [ ] `services/ raw_key_event_data_mac_os_test.dart` — _Transport_ — _fixed:_
- [ ] `services/ system_context_menu_client_test.dart` — _Transport_ — _fixed:_
- [ ] `services/ text_input_connection_test.dart` — _Transport_ — _fixed:_

### hardly_relevant_classes_4_test (8)

- [ ] `widgets/ autocomplete_highlighted_option_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ bottom_navigation_bar_item_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ constraints_transform_box_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ diagonal_drag_behavior_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ drag_scroll_activity_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ expansible_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ inspector_selection_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ orientation_test.dart` — _Transport_ — _fixed:_

### hardly_relevant_classes_5_test (12)

- [ ] `widgets/ raw_menu_anchor_group_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ render_tree_root_element_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ restorable_int_n_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ scroll_aware_image_provider_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ selection_registrar_scope_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ sliver_child_builder_delegate_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ snapshot_controller_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ transition_route_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ two_dimensional_scrollable_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ web_browser_detection_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ widget_inspector_service_extensions_test.dart` — _Other_ — _fixed:_
- [ ] `widgets/ widget_inspector_service_test.dart` — _Transport_ — _fixed:_

### timeout_tests_test (2)

- [ ] `rendering/ render_darwin_platform_view_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/app_kit_view_test.dart` — _Transport_ — _fixed:_

### generator_interpreter_issues_test (1)

- [ ] `rendering/render_physical_shape_test.dart` — _Transport_ — _fixed:_

### generator_interpreter_retest_test (2)

- [ ] `rendering/render_animated_size_state_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/app_kit_view_test.dart` — _Transport_ — _fixed:_

**flutter_ast total over-budget scripts: 81**

## flutter_test

### important_classes_test (1)

- [ ] `material/ selectabletext_test.dart` — _Transport_ — _fixed:_

### secondary_classes_test (31)

- [ ] `widgets/ scrollbar_layout_misc_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ context_menu_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ form_field_test.dart` — _Transport_ — _fixed:_
- [ ] `animation/ individual animation_mean_test.dart` — _Transport_ — _fixed:_
- [ ] `dart_ui/ individual brightness_test.dart` — _Transport_ — _fixed:_
- [ ] `dart_ui/ individual platform_dispatcher_test.dart` — _Transport_ — _fixed:_
- [ ] `dart_ui/ individual target_image_size_test.dart` — _Transport_ — _fixed:_
- [ ] `gestures/ individual delayed_multi_drag_gesture_recognizer_test.dart` — _Transport_ — _fixed:_
- [ ] `gestures/ individual tap_drag_down_details_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ individual colors_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ individual input_decoration_theme_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ individual scaffold_state_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ individual typography_test.dart` — _Transport_ — _fixed:_
- [ ] `painting/ individual linear_border_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ individual container_render_object_mixin_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ individual render_aligning_shifted_box_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ individual render_editable_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ individual render_physical_model_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ individual render_semantics_gesture_handler_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ individual selectable_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ individual text_selection_point_test.dart` — _Transport_ — _fixed:_
- [ ] `services/ individual darwin_platform_view_controller_test.dart` — _Transport_ — _fixed:_
- [ ] `services/ individual scribe_test.dart` — _Transport_ — _fixed:_
- [ ] `services/ individual undo_manager_client_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ individual color_filtered_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ individual image_filtered_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ individual list_wheel_element_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ individual navigation_toolbar_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ individual platform_menu_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ individual text_selection_controls_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ individual widgets_binding_observer_test.dart` — _Transport_ — _fixed:_

### hardly_relevant_classes_1_test (11)

- [ ] `cupertino/ cupertino_text_selection_handle_controls_test.dart` — _Transport_ — _fixed:_
- [ ] `dart_ui/ channel_buffers_test.dart` — _Transport_ — _fixed:_
- [ ] `dart_ui/ key_event_device_type_test.dart` — _Transport_ — _fixed:_
- [ ] `dart_ui/ root_isolate_token_test.dart` — _Transport_ — _fixed:_
- [ ] `dart_ui/ text_leading_distribution_test.dart` — _Transport_ — _fixed:_
- [ ] `foundation/ diagnosticable_test.dart` — _Transport_ — _fixed:_
- [ ] `foundation/ flags_summary_test.dart` — _Transport_ — _fixed:_
- [ ] `foundation/ string_property_test.dart` — _Transport_ — _fixed:_
- [ ] `gestures/ i_o_s_scroll_view_fling_velocity_tracker_test.dart` — _Transport_ — _fixed:_
- [ ] `gestures/ pointer_event_test.dart` — _Transport_ — _fixed:_
- [ ] `gestures/ sampling_clock_test.dart` — _Transport_ — _fixed:_

### hardly_relevant_classes_2_test (9)

- [ ] `material/ drawer_button_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ expand_icon_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ ink_sparkle_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ paginated_data_table_state_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ refresh_indicator_status_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ standard_fab_location_test.dart` — _Transport_ — _fixed:_
- [ ] `material/ time_picker_entry_mode_test.dart` — _Transport_ — _fixed:_
- [ ] `painting/ asset_bundle_image_key_test.dart` — _Transport_ — _fixed:_
- [ ] `painting/ matrix_utils_test.dart` — _Transport_ — _fixed:_

### hardly_relevant_classes_3_test (12)

- [ ] `rendering/ flex_fit_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ min_column_width_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ render_clip_r_superellipse_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ render_sliver_constrained_cross_axis_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ select_all_selection_event_test.dart` — _Transport_ — _fixed:_
- [ ] `rendering/ table_border_test.dart` — _Transport_ — _fixed:_
- [ ] `semantics/ class_test.dart` — _Transport_ — _fixed:_
- [ ] `services/ deferred_component_test.dart` — _Transport_ — _fixed:_
- [ ] `services/ key_event_manager_test.dart` — _Transport_ — _fixed:_
- [ ] `services/ mouse_cursor_manager_test.dart` — _Transport_ — _fixed:_
- [ ] `services/ raw_keyboard_test.dart` — _Transport_ — _fixed:_
- [ ] `services/ text_editing_value_test.dart` — _Transport_ — _fixed:_

### hardly_relevant_classes_4_test (12)

- [ ] `widgets/ android_view_surface_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ autovalidate_mode_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ change_reporting_behavior_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ default_selection_style_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ dialog_window_controller_win32_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ drag_boundary_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ floating_header_snap_mode_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ i_o_s_system_context_menu_item_paste_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ keep_alive_notification_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ modal_barrier_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ overflow_bar_alignment_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ pop_entry_test.dart` — _Transport_ — _fixed:_

### hardly_relevant_classes_5_test (3)

- [ ] `widgets/ raw_menu_overlay_info_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ render_object_to_widget_element_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/ request_focus_action_test.dart` — _Transport_ — _fixed:_

### timeout_tests_test (2)

- [ ] `rendering/ render_darwin_platform_view_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/app_kit_view_test.dart` — _Transport_ — _fixed:_

### generator_interpreter_issues_test (1)

- [ ] `rendering/render_physical_shape_test.dart` — _Transport_ — _fixed:_

### generator_interpreter_retest_test (2)

- [ ] `rendering/render_animated_size_state_test.dart` — _Transport_ — _fixed:_
- [ ] `widgets/app_kit_view_test.dart` — _Transport_ — _fixed:_

**flutter_test total over-budget scripts: 84**

---

## Cross-cutting scripts (over-budget in BOTH projects — interpreter / bridge bottleneck candidates)

Sorted by appearance count (most cross-cutting first). These are the highest-priority targets for §6 step #17c.

- [ ] `widgets/app_kit_view_test.dart` — appears 4× (flutter_ast: timeout_tests_test=Transport, generator_interpreter_retest_test=Transport; flutter_test: timeout_tests_test=Transport, generator_interpreter_retest_test=Transport) — _fixed:_
- [ ] `rendering/render_physical_shape_test.dart` — appears 2× (flutter_ast: generator_interpreter_issues_test=Transport; flutter_test: generator_interpreter_issues_test=Transport) — _fixed:_
- [ ] `rendering/render_animated_size_state_test.dart` — appears 2× (flutter_ast: generator_interpreter_retest_test=Transport; flutter_test: generator_interpreter_retest_test=Transport) — _fixed:_
- [ ] `rendering/ render_darwin_platform_view_test.dart` — appears 2× (flutter_ast: timeout_tests_test=Transport; flutter_test: timeout_tests_test=Transport) — _fixed:_
- [ ] `rendering/ individual render_editable_test.dart` — appears 2× (flutter_ast: secondary_classes_test=Transport; flutter_test: secondary_classes_test=Transport) — _fixed:_
- [ ] `painting/ matrix_utils_test.dart` — appears 2× (flutter_ast: hardly_relevant_classes_2_test=Transport; flutter_test: hardly_relevant_classes_2_test=Transport) — _fixed:_
- [ ] `dart_ui/ channel_buffers_test.dart` — appears 2× (flutter_ast: hardly_relevant_classes_1_test=Transport; flutter_test: hardly_relevant_classes_1_test=Transport) — _fixed:_

