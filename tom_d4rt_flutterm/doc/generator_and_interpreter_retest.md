# Generator and Interpreter Retest Summary

This document catalogs tests that require retesting after bridge generator or interpreter fixes are implemented.

## Section 1: Tests Modified with Script-Side Workarounds

Tests that were stabilized with script-level workarounds while deeper generator/interpreter follow-up is documented separately.

| # | Filename | Analysis Location |
|---|----------|-------------------|
| 1 | test_scripts/animation/reverse_tween_test.dart | generator_issues.md (batch 1, idx 6) |
| 2 | dart_ui/key_event_type_test.dart | generator_issues.md (batch 2, idx 14) |
| 3 | dart_ui/vertex_mode_test.dart | generator_issues.md (batch 3, idx 17) |
| 4 | foundation/object_created_test.dart | generator_issues.md (batch 3, idx 18) |
| 5 | foundation/object_disposed_test.dart | generator_issues.md (batch 3, idx 19) |
| 6 | foundation/object_event_test.dart | generator_issues.md (batch 4, idx 20) |
| 7 | material/bottom_navigation_bar_type_test.dart | generator_issues.md (batch 4, idx 24) |
| 8 | material/button_bar_theme_test.dart | generator_issues.md (batch 5, idx 26) |
| 9 | material/popup_menu_position_test.dart | generator_issues.md (batch 8, idx 42) |
| 10 | material/theme_extension_test.dart | generator_issues.md (batch 9, idx 45) |
| 11 | material/toggle_buttons_theme_data_test.dart | generator_issues.md (batch 10, idx 50) |
| 12 | material/toggle_buttons_theme_test.dart | generator_issues.md (batch 10, idx 51) |
| 13 | rendering/over_scroll_header_stretch_configuration_test.dart | generator_issues.md (batch 11, idx 58) |
| 14 | rendering/render_animated_size_state_test.dart | generator_issues.md (batch 13, idx 65) |
| 15 | rendering/render_sliver_box_child_manager_test.dart | generator_issues.md (batch 13, idx 68) |
| 16 | services/message_codec_test.dart | generator_issues.md (batch 14, idx 71) |
| 17 | services/method_codec_test.dart | generator_issues.md (batch 14, idx 72) |
| 18 | widgets/android_view_surface_test.dart | generator_issues.md (batch 15, idx 77) |
| 19 | widgets/app_kit_view_test.dart | generator_issues.md (batch 15, idx 79) |
| 20 | widgets/back_button_listener_test.dart | generator_issues.md (batch 16, idx 83) |
| 21 | widgets/box_scroll_view_test.dart | generator_issues.md (batch 17, idx 86) |
| 22 | widgets/context_action_test.dart | generator_issues.md (batch 18, idx 90) |
| 23 | widgets/default_selection_style_test.dart | generator_issues.md (batch 18, idx 91) |
| 24 | widgets/default_text_editing_shortcuts_test.dart | generator_issues.md (batch 18, idx 92) |
| 25 | widgets/nested_scroll_view_state_test.dart | generator_issues.md (batch 23, idx 116) |
| 26 | widgets/next_focus_intent_test.dart | generator_issues.md (batch 23, idx 118) |
| 27 | widgets/object_key_test.dart | generator_issues.md (batch 24, idx 120) |
| 28 | widgets/raw_dialog_route_test.dart | generator_issues.md (batch 25, idx 125) |
| 29 | widgets/raw_keyboard_listener_test.dart | generator_issues.md (batch 25, idx 126) |
| 30 | widgets/raw_menu_overlay_info_test.dart | generator_issues.md (batch 25, idx 127) |
| 31 | widgets/raw_radio_test.dart | generator_issues.md (batch 25, idx 128) |
| 32 | widgets/redo_text_intent_test.dart | generator_issues.md (batch 25, idx 129) |
| 33 | widgets/regular_window_controller_delegate_test.dart | generator_issues.md (batch 26, idx 130) |
| 34 | widgets/regular_window_controller_linux_test.dart | generator_issues.md (batch 26, idx 131) |
| 35 | widgets/regular_window_controller_mac_o_s_test.dart | generator_issues.md (batch 26, idx 132) |
| 36 | widgets/regular_window_controller_test.dart | generator_issues.md (batch 26, idx 133) |
| 37 | widgets/regular_window_controller_win32_test.dart | generator_issues.md (batch 26, idx 134) |
| 38 | widgets/regular_window_test.dart | generator_issues.md (batch 27, idx 135) |
| 39 | widgets/render_abstract_layout_builder_mixin_test.dart | generator_issues.md (batch 27, idx 137) |
| 40 | widgets/render_nested_scroll_view_viewport_test.dart | generator_issues.md (batch 27, idx 138) |
| 41 | widgets/render_tap_region_surface_test.dart | generator_issues.md (batch 28, idx 140) |
| 42 | widgets/replace_text_intent_test.dart | generator_issues.md (batch 29, idx 146) |
| 43 | widgets/request_focus_action_test.dart | generator_issues.md (batch 29, idx 147) |
| 44 | dart_ui/color_space_test.dart | interpreter_issues.md (batch 2, idx 13) |
| 45 | dart_ui/system_color_palette_test.dart | interpreter_issues.md (batch 3, idx 16) |
| 46 | material/button_bar_layout_behavior_test.dart | interpreter_issues.md (batch 5, idx 25) |
| 47 | material/button_text_theme_test.dart | interpreter_issues.md (batch 5, idx 27) |
| 48 | material/dropdown_menu_close_behavior_test.dart | interpreter_issues.md (batch 6, idx 30) |
| 49 | material/gapped_range_slider_track_shape_test.dart | interpreter_issues.md (batch 6, idx 32) |
| 50 | material/hour_format_test.dart | interpreter_issues.md (batch 6, idx 34) |
| 51 | material/material_banner_closed_reason_test.dart | interpreter_issues.md (batch 7, idx 36) |
| 52 | material/navigation_destination_label_behavior_test.dart | interpreter_issues.md (batch 7, idx 38) |
| 53 | material/navigation_rail_label_type_test.dart | interpreter_issues.md (batch 8, idx 40) |
| 54 | painting/axis_direction_test.dart | interpreter_issues.md (batch 10, idx 53) |
| 55 | rendering/hit_test_behavior_test.dart | interpreter_issues.md (batch 11, idx 57) |
| 56 | rendering/render_android_view_test.dart | interpreter_issues.md (batch 12, idx 63) |
| 57 | widgets/live_text_input_status_test.dart | interpreter_issues.md (batch 21, idx 108) |
| 58 | widgets/lock_state_test.dart | interpreter_issues.md (batch 21, idx 109) |

## Section 2: Tests Skipped (Not Modified) — Require Generator/Interpreter Fix

Tests that were NOT modified because they require generator or interpreter changes before they can pass.

### Bridge Generator Issues

| # | Filename | Issue Index | Issue Type | Analysis Location |
|---|----------|-------------|------------|-------------------|
| 1 | widgets/render_object_to_widget_adapter_test.dart | 139 | BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT | generator_issues.md (batch 27) |
| 2 | widgets/render_tree_root_element_test.dart | 142 | BRIDGE-LIFECYCLE-TIMING | generator_issues.md (batch 28) |
| 3 | widgets/restorable_enum_n_test.dart | 152 | BRIDGE-MISSING-SYMBOL (`Enum`) | generator_issues.md (batch 30) |
| 4 | widgets/route_information_test.dart | 162 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 32) |
| 5 | widgets/route_pop_disposition_test.dart | 163 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 32) |
| 6 | widgets/router_config_test.dart | 165 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 33) |
| 7 | widgets/scroll_activity_test.dart | 167 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 33) |
| 8 | widgets/scroll_position_alignment_policy_test.dart | 178 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 35) |
| 9 | widgets/scroll_view_keyboard_dismiss_behavior_test.dart | 183 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 36) |
| 10 | widgets/select_action_test.dart | 188 | BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT | generator_issues.md (batch 37) |
| 11 | widgets/shortcut_registry_entry_test.dart | 198 | BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT | generator_issues.md (batch 39) |
| 12 | widgets/shortcut_serialization_test.dart | 199 | BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT | generator_issues.md (batch 39) |
| 13 | widgets/single_activator_test.dart | 200 | BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT | generator_issues.md (batch 40) |
| 14 | widgets/toolbar_items_parent_data_test.dart | 217 | BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT | generator_issues.md (batch 43) |
| 15 | widgets/toolbar_options_test.dart | 218 | BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT | generator_issues.md (batch 43) |
| 16 | widgets/tooltip_position_context_test.dart | 219 | BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT | generator_issues.md (batch 43) |
| 17 | widgets/tooltip_window_controller_delegate_test.dart | 220 | BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT | generator_issues.md (batch 44) |
| 18 | widgets/tooltip_window_controller_test.dart | 221 | BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT | generator_issues.md (batch 44) |
| 19 | widgets/transition_delegate_test.dart | 223 | BRIDGE-MISSING-STATE-WIDGET-ACCESSOR + BRIDGE-WIDGET-COERCION | generator_issues.md (batch 44) |
| 20 | widgets/traversal_direction_test.dart | 225 | BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT | generator_issues.md (batch 45) |
| 21 | widgets/traversal_edge_behavior_test.dart | 226 | BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT | generator_issues.md (batch 45) |
| 22 | widgets/window_positioner_anchor_test.dart | 258 | BRIDGE-GENERIC-TYPE-COERCION | generator_issues.md (batch 51) |
| 23 | widgets/window_positioner_constraint_adjustment_test.dart | 259 | BRIDGE-GENERIC-TYPE-COERCION | generator_issues.md (batch 51) |
| 24 | widgets/window_positioner_test.dart | 260 | BRIDGE-GENERIC-TYPE-COERCION | generator_issues.md (batch 52) |
| 25 | widgets/window_scope_test.dart | 261 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 52) |
| 26 | widgets/windowing_owner_linux_test.dart | 262 | BRIDGE-GENERIC-TYPE-COERCION | generator_issues.md (batch 52) |
| 27 | widgets/windowing_owner_mac_o_s_test.dart | 263 | BRIDGE-GENERIC-TYPE-COERCION | generator_issues.md (batch 52) |
| 28 | widgets/windowing_owner_test.dart | 264 | BRIDGE-GENERIC-TYPE-COERCION | generator_issues.md (batch 52) |
| 29 | widgets/slidetransition_test.dart | 267 | BRIDGE-MISSING-METHOD-DISPATCH | generator_issues.md (batch 53) |
| 30 | widgets/nestedscrollview_test.dart | 269 | BRIDGE-WIDGET-LIST-COERCION | generator_issues.md (batch 53) |
| 31 | animation/tweensequence_test.dart | 278 | BRIDGE-GENERIC-CONSTRUCTOR-NULL-HANDLING | generator_issues.md (batch 55) |
| 32 | services/codecs_test.dart | 279 | BRIDGE-SDK-SYMBOL-RESOLUTION | generator_issues.md (batch 55) |
| 33 | services/channels_test.dart | 280 | BRIDGE-CALLBACK-TYPE-COERCION | generator_issues.md (batch 56) |
| 34 | semantics/semantics_config_test.dart | 290 | BRIDGE-CALLBACK-TYPE-COERCION | generator_issues.md (batch 58) |
| 35 | widgets/layout_builder_adv_test.dart | 292 | BRIDGE-MISSING-METHOD-DISPATCH + layout | generator_issues.md (batch 58) |
| 36 | material/scaffold_messenger_test.dart | 303 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 60) |
| 37 | rendering/box_hit_test_result_test.dart | 309 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 61) |
| 38 | rendering/custom_painter_semantics_test.dart | 310 | BRIDGE-CALLBACK-TYPE-COERCION + overflow | generator_issues.md (batch 62) |
| 39 | rendering/relayout_when_system_fonts_change_mixin_test.dart | 312 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 62) |
| 40 | rendering/render_absorb_pointer_test.dart | 313 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 62) |
| 41 | rendering/render_aligning_shifted_box_test.dart | 314 | BRIDGE-MISSING-MEMBER | generator_issues.md (batch 62) |
| 42 | rendering/render_box_container_defaults_mixin_test.dart | 317 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 63) |
| 43 | rendering/render_custom_multi_child_layout_box_test.dart | 318 | BRIDGE-DELEGATE-TYPE-COERCION | generator_issues.md (batch 63) |
| 44 | rendering/render_custom_paint_test.dart | 319 | BRIDGE-MIXIN-TARGET-COERCION | generator_issues.md (batch 63) |
| 45 | rendering/render_custom_single_child_layout_box_test.dart | 320 | BRIDGE-DELEGATE-TYPE-COERCION | generator_issues.md (batch 64) |
| 46 | rendering/render_physical_shape_test.dart | 323 | BRIDGE-CLIPPER-TYPE-COERCION | generator_issues.md (batch 64) |
| 47 | rendering/render_shrink_wrapping_viewport_test.dart | 325 | BRIDGE-SUPER-CONSTRUCTOR-RESOLUTION | generator_issues.md (batch 65) |
| 48 | widgets/android_view_test.dart | 329 | BRIDGE-STATIC-MEMBER-EXPOSURE | generator_issues.md (batch 65) |
| 49 | widgets/animated_cross_fade_test.dart | 330 | BRIDGE-MISSING-INSTANCE-METHOD | generator_issues.md (batch 66) |
| 50 | widgets/animated_switcher_test.dart | 332 | BRIDGE-MISSING-INSTANCE-METHOD | generator_issues.md (batch 66) |
| 51 | widgets/autofill_group_test.dart | 333 | BRIDGE-STATE-PROPERTY-EXPOSURE | generator_issues.md (batch 66) |
| 52 | widgets/backdrop_filter_test.dart | 334 | BRIDGE-MISSING-INSTANCE-METHOD | generator_issues.md (batch 66) |
| 53 | widgets/composited_transform_follower_test.dart | 336 | BRIDGE-STATE-PROPERTY-EXPOSURE | generator_issues.md (batch 67) |
| 54 | widgets/fixed_extent_metrics_test.dart | 340 | BRIDGE-TYPE-CAST-FAILURE | generator_issues.md (batch 68) |
| 55 | widgets/glowing_overscroll_indicator_test.dart | 341 | BRIDGE-OPERATOR-COERCION + STATE-PROPERTY + WIDGET-COERCION | generator_issues.md (batch 68) |
| 56 | widgets/html_element_view_test.dart | 342 | BRIDGE-STATE-PROPERTY-EXPOSURE | generator_issues.md (batch 68) |
| 57 | widgets/image_filtered_test.dart | 343 | BRIDGE-STATE-PROPERTY-EXPOSURE | generator_issues.md (batch 68) |
| 58 | widgets/indexed_stack_test.dart | 344 | BRIDGE-STATE-PROPERTY-EXPOSURE | generator_issues.md (batch 68) |
| 59 | widgets/inherited_theme_test.dart | 346 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 69) |
| 60 | widgets/inherited_widget_test.dart | 347 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 69) |
| 61 | widgets/list_wheel_scroll_view_test.dart | 348 | BRIDGE-STATE-PROPERTY-EXPOSURE | generator_issues.md (batch 69) |
| 62 | widgets/list_wheel_viewport_test.dart | 349 | BRIDGE-STATE-PROPERTY-EXPOSURE | generator_issues.md (batch 69) |
| 63 | widgets/magnifier_decoration_test.dart | 350 | BRIDGE-STATE-PROPERTY-EXPOSURE | generator_issues.md (batch 70) |
| 64 | widgets/navigation_toolbar_test.dart | 351 | BRIDGE-STATE-PROPERTY-EXPOSURE | generator_issues.md (batch 70) |
| 65 | widgets/overflow_bar_test.dart | 352 | BRIDGE-STATE-PROPERTY-EXPOSURE | generator_issues.md (batch 70) |
| 66 | widgets/overflow_box_test.dart | 353 | BRIDGE-STATE-PROPERTY-EXPOSURE | generator_issues.md (batch 70) |
| 67 | widgets/page_storage_bucket_test.dart | 354 | BRIDGE-STATE-PROPERTY-EXPOSURE | generator_issues.md (batch 70) |
| 68 | widgets/page_storage_test.dart | 355 | BRIDGE-STATE-PROPERTY-EXPOSURE | generator_issues.md (batch 71) |
| 69 | widgets/parent_data_widget_test.dart | 356 | BRIDGE-MISSING-METHOD-DISPATCH + layout | generator_issues.md (batch 71) |
| 70 | widgets/physical_model_test.dart | 358 | BRIDGE-MISSING-INSTANCE-METHOD | generator_issues.md (batch 71) |
| 71 | widgets/render_object_element_test.dart | 359 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 71) |
| 72 | widgets/render_object_widget_test.dart | 360 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 72) |
| 73 | widgets/restorable_enum_test.dart | 364 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 72) |
| 74 | widgets/restorable_text_editing_controller_test.dart | 368 | BRIDGE-WIDGET-COERCION | generator_issues.md (batch 73) |
| 75 | widgets/root_widget_test.dart | 372 | BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT | generator_issues.md (batch 74) |
| 76 | widgets/shader_mask_test.dart | 375 | BRIDGE-MISSING-INSTANCE-METHOD | generator_issues.md (batch 75) |
| 77 | widgets/single_child_render_object_element_test.dart | 376 | BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT | generator_issues.md (batch 75) |
| 78 | widgets/single_child_render_object_widget_test.dart | 377 | BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT | generator_issues.md (batch 75) |
| 79 | widgets/stateful_element_test.dart | 380 | BRIDGE-STATE-PROPERTY-EXPOSURE | generator_issues.md (batch 76) |
| 80 | widgets/stateless_element_test.dart | 381 | BRIDGE-STATE-PROPERTY-EXPOSURE | generator_issues.md (batch 76) |

### Interpreter Issues

| # | Filename | Issue Index | Issue Type | Analysis Location |
|---|----------|-------------|------------|-------------------|
| 1 | widgets/scrollbar_orientation_test.dart | 186 | INTERPRETER-INHERITED-STATE-ACCESSOR | interpreter_issues.md (batch 37) |
| 2 | widgets/sliver_animated_list_state_test.dart | 203 | INTERPRETER-INHERITED-STATE-ACCESSOR | interpreter_issues.md (batch 40) |
| 3 | widgets/sliver_child_builder_delegate_test.dart | 204 | INTERPRETER-COLLECTION-TYPE-RESOLUTION | interpreter_issues.md (batch 40) |

## Summary Statistics

- Tests with workarounds (Section 1): 58
- Tests requiring generator fix (Section 2 - Bridge): 80
- Tests requiring interpreter fix (Section 2 - Interpreter): 3
- **Total tests needing generator/interpreter attention: 141**

## Issue Type Distribution (Skipped Tests)

| Issue Type | Count |
|------------|-------|
| BRIDGE-STATE-PROPERTY-EXPOSURE | 17 |
| BRIDGE-WIDGET-COERCION | 16 |
| BRIDGE-MISSING-DEFAULT-CONSTRUCTOR-SUPPORT | 15 |
| BRIDGE-GENERIC-TYPE-COERCION | 7 |
| BRIDGE-MISSING-INSTANCE-METHOD (`whereType`) | 5 |
| BRIDGE-CALLBACK-TYPE-COERCION | 4 |
| BRIDGE-MISSING-METHOD-DISPATCH | 3 |
| BRIDGE-DELEGATE-TYPE-COERCION | 2 |
| INTERPRETER-INHERITED-STATE-ACCESSOR | 2 |
| Other (various single-instance types) | 12 |
