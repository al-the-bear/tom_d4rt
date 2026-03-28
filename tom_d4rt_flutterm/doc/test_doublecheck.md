# Print-Only Batch Audit

Generated: 2026-03-28

## Executive Summary

**Total batches analyzed:** 34 (print-only batches)
**Total files modified across all batches:** ~680 test files

### Issues Found

| Batch | Non-Print-Only Files | Impact |
|-------|---------------------|--------|
| Batch 14 | 20 | 20 dart_ui/ files overwritten with print-only content |
| Batch 15 | 5 | 5 material/ enums (new files, no prior content) |
| Batch 16 | 11 | 11 material/ range/slider classes (mostly new) |
| Batch 31 | 2 | 2 material/ files |
| Batch 32 | 20 | 20 material/ files (new files, no prior content) |
| Batch 34 | 9 | 9 rendering/semantics/ files (new files, no prior content) |
| **TOTAL** | **67** | **67 files not in print-only testplan** |

### Overwrite Analysis

Of the 67 non-print-only files:
- **22 OVERWRITES**: Had existing content (>9 lines) that was replaced
- **45 NEW FILES**: Were 9-line stubs that got filled with content

### Critical Overwrites (lost >30 lines of content)

| File | Lines Before | Lines After | Lost Lines |
|------|--------------|-------------|------------|
| color_tween_test.dart | 78 | 93 | Content replaced |
| key_data_test.dart | 77 | 104 | Content replaced |
| path_metrics_test.dart | 77 | 101 | Content replaced |
| platform_dispatcher_test.dart | 74 | 97 | Content replaced |
| pointer_data_test.dart | 61 | 106 | Content replaced |
| locale_string_attribute_test.dart | 59 | 96 | Content replaced |
| path_metric_iterator_test.dart | 50 | 112 | Content replaced |
| image_filter_engine_layer_test.dart | 48 | 99 | Content replaced |
| immutable_buffer_test.dart | 47 | 96 | Content replaced |
| image_descriptor_test.dart | 43 | 94 | Content replaced |

**Note:** "Batch 34" in this audit corresponds to what was labeled as "Batch 36" in the recent session - the files that triggered this investigation.

---

# Print-Only Batch Audit

Generated: 2026-03-28

## Batch 1

**Commit:** `c381f5ee`

**Message:** feat(d4rt): batch 3 - add 20 print-only test files (painting, rendering)\n\nGenerated 20 hand-crafted print-only D4rt test files:\n- painting: WebHtmlElementStrategy (enum)\n- rendering: const (SliverGeometry, SliverPaintOrder, etc.)\n- rendering: 15 RenderSliver* classes (persistent headers, adapters, etc.)\n- rendering: RenderTreeSliver, RenderViewportBase\n- rendering: RendererBinding, RenderingFlutterBinding\n\nFixed TreeSliverIndentationType (class, not enum) and unnecessary type checks.\nTotal: 61/586 implemented (10.4%)"

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| web_html_element_strategy_test.dart | ✅ Yes | 9 | 93 |
| const_test.dart | ✅ Yes | 9 | 91 |
| render_sliver_floating_persistent_header_test.dart | ✅ Yes | 9 | 84 |
| render_sliver_helpers_test.dart | ✅ Yes | 9 | 82 |
| render_sliver_ignore_pointer_test.dart | ✅ Yes | 9 | 85 |
| render_sliver_main_axis_group_test.dart | ✅ Yes | 9 | 82 |
| render_sliver_multi_box_adaptor_test.dart | ✅ Yes | 9 | 81 |
| render_sliver_offstage_test.dart | ✅ Yes | 9 | 87 |
| render_sliver_persistent_header_test.dart | ✅ Yes | 9 | 84 |
| render_sliver_pinned_persistent_header_test.dart | ✅ Yes | 9 | 83 |
| render_sliver_scrolling_persistent_header_test.dart | ✅ Yes | 9 | 84 |
| render_sliver_semantics_annotations_test.dart | ✅ Yes | 9 | 87 |
| render_sliver_single_box_adapter_test.dart | ✅ Yes | 9 | 82 |
| render_sliver_to_box_adapter_test.dart | ✅ Yes | 9 | 85 |
| render_sliver_varied_extent_list_test.dart | ✅ Yes | 9 | 83 |
| render_sliver_with_keep_alive_mixin_test.dart | ✅ Yes | 9 | 83 |
| render_tree_sliver_test.dart | ✅ Yes | 9 | 91 |
| render_viewport_base_test.dart | ✅ Yes | 9 | 88 |
| renderer_binding_test.dart | ✅ Yes | 9 | 83 |
| rendering_flutter_binding_test.dart | ✅ Yes | 9 | 89 |

## Batch 2

**Commit:** `0b8c667d`

**Message:** Add 20 rendering print-only tests (batch 4)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| revealed_offset_test.dart | ✅ Yes | 9 | 88 |
| select_all_selection_event_test.dart | ✅ Yes | 9 | 82 |
| selectable_test.dart | ✅ Yes | 9 | 86 |
| selected_content_range_test.dart | ✅ Yes | 9 | 80 |
| selected_content_test.dart | ✅ Yes | 9 | 84 |
| selection_edge_update_event_test.dart | ✅ Yes | 9 | 86 |
| selection_event_test.dart | ✅ Yes | 9 | 83 |
| selection_geometry_test.dart | ✅ Yes | 9 | 89 |
| selection_handler_test.dart | ✅ Yes | 9 | 82 |
| selection_point_test.dart | ✅ Yes | 9 | 93 |
| selection_registrant_test.dart | ✅ Yes | 9 | 82 |
| selection_registrar_test.dart | ✅ Yes | 9 | 85 |
| selection_utils_test.dart | ✅ Yes | 9 | 89 |
| semantics_annotations_mixin_test.dart | ✅ Yes | 9 | 88 |
| shader_mask_layer_test.dart | ✅ Yes | 9 | 83 |
| shape_border_clipper_test.dart | ✅ Yes | 9 | 100 |
| sliver_grid_geometry_test.dart | ✅ Yes | 9 | 91 |
| sliver_grid_layout_test.dart | ✅ Yes | 9 | 87 |
| sliver_grid_regular_tile_layout_test.dart | ✅ Yes | 9 | 94 |
| sliver_hit_test_entry_test.dart | ✅ Yes | 9 | 80 |

## Batch 3

**Commit:** `6d0459f7`

**Message:** Add 20 rendering print-only tests (batch 5)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| sliver_hit_test_result_test.dart | ✅ Yes | 9 | 103 |
| sliver_layout_dimensions_test.dart | ✅ Yes | 9 | 100 |
| sliver_logical_container_parent_data_test.dart | ✅ Yes | 9 | 93 |
| sliver_multi_box_adaptor_parent_data_test.dart | ✅ Yes | 9 | 91 |
| sliver_paint_order_test.dart | ✅ Yes | 9 | 91 |
| sliver_physical_container_parent_data_test.dart | ✅ Yes | 9 | 85 |
| sliver_physical_parent_data_test.dart | ✅ Yes | 9 | 86 |
| stack_fit_test.dart | ✅ Yes | 9 | 82 |
| table_border_test.dart | ✅ Yes | 9 | 82 |
| table_cell_parent_data_test.dart | ✅ Yes | 9 | 87 |
| table_cell_vertical_alignment_test.dart | ✅ Yes | 9 | 80 |
| text_parent_data_test.dart | ✅ Yes | 9 | 85 |
| text_selection_handle_type_test.dart | ✅ Yes | 9 | 80 |
| text_selection_point_test.dart | ✅ Yes | 9 | 80 |
| texture_box_test.dart | ✅ Yes | 9 | 80 |
| texture_layer_test.dart | ✅ Yes | 9 | 80 |
| tree_sliver_indentation_type_test.dart | ✅ Yes | 9 | 80 |
| tree_sliver_node_parent_data_test.dart | ✅ Yes | 9 | 80 |
| vertical_caret_movement_run_test.dart | ✅ Yes | 9 | 80 |
| wrap_alignment_test.dart | ✅ Yes | 9 | 80 |

## Batch 4

**Commit:** `850061b4`

**Message:** add 20 print-only send_ast tests batch 0fc0e0bd

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| wrap_cross_alignment_test.dart | ✅ Yes | 9 | 84 |
| wrap_parent_data_test.dart | ✅ Yes | 9 | 84 |
| semantics_binding_test.dart | ✅ Yes | 9 | 84 |
| app_kit_view_controller_test.dart | ✅ Yes | 9 | 84 |
| autofill_client_test.dart | ✅ Yes | 9 | 84 |
| autofill_hints_test.dart | ✅ Yes | 9 | 84 |
| autofill_scope_test.dart | ✅ Yes | 9 | 84 |
| browser_context_menu_test.dart | ✅ Yes | 9 | 84 |
| caching_asset_bundle_test.dart | ✅ Yes | 9 | 84 |
| class_test.dart | ✅ Yes | 9 | 84 |
| delta_text_input_client_test.dart | ✅ Yes | 9 | 84 |
| gtk_key_helper_test.dart | ✅ Yes | 9 | 84 |
| hybrid_android_view_controller_test.dart | ✅ Yes | 9 | 84 |
| i_o_s_system_context_menu_item_data_search_web_test.dart | ✅ Yes | 9 | 84 |
| mouse_cursor_session_test.dart | ✅ Yes | 9 | 84 |
| predictive_back_event_test.dart | ✅ Yes | 9 | 84 |
| raw_key_event_data_mac_os_test.dart | ✅ Yes | 9 | 84 |
| restoration_manager_test.dart | ✅ Yes | 9 | 84 |
| scribe_test.dart | ✅ Yes | 9 | 84 |
| smart_dashes_type_test.dart | ✅ Yes | 9 | 84 |

## Batch 5

**Commit:** `fca88a7e`

**Message:** Add handcrafted print-only tests batch for 20 pending targets

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| class_test.dart | ✅ Yes | 130 | 86 |
| class_test.dart | ✅ Yes | 1061 | 86 |
| class_test.dart | ✅ Yes | 93 | 89 |
| viewport_test.dart | ✅ Yes | 282 | 80 |
| class_test.dart | ✅ Yes | 90 | 81 |
| child_semantics_configurations_result_builder_test.dart | ✅ Yes | 90 | 81 |
| child_semantics_configurations_result_test.dart | ✅ Yes | 92 | 84 |
| class_test.dart | ✅ Yes | 105 | 81 |
| semantics_handle_test.dart | ✅ Yes | 101 | 80 |
| semantics_label_builder_test.dart | ✅ Yes | 92 | 81 |
| android_view_controller_test.dart | ✅ Yes | 93 | 83 |
| asset_manifest_test.dart | ✅ Yes | 91 | 82 |
| autofill_scope_mixin_test.dart | ✅ Yes | 96 | 87 |
| background_isolate_binary_messenger_test.dart | ✅ Yes | 92 | 80 |
| darwin_platform_view_controller_test.dart | ✅ Yes | 90 | 81 |
| deferred_component_test.dart | ✅ Yes | 90 | 80 |
| expensive_android_view_controller_test.dart | ✅ Yes | 91 | 83 |
| g_l_f_w_key_helper_test.dart | ✅ Yes | 95 | 81 |
| i_o_s_system_context_menu_item_data_test.dart | ✅ Yes | 89 | 80 |
| key_event_manager_test.dart | ✅ Yes | 93 | 83 |

## Batch 6

**Commit:** `f1daeb82`

**Message:** Add handcrafted print-only services batch (20 files)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| key_events_adv_test.dart | ✅ Yes | 86 | 101 |
| live_text_test.dart | ✅ Yes | 90 | 100 |
| mouse_cursor_manager_test.dart | ✅ Yes | 95 | 100 |
| platform_asset_bundle_test.dart | ✅ Yes | 91 | 101 |
| platform_view_controller_test.dart | ✅ Yes | 90 | 101 |
| platform_views_service_test.dart | ✅ Yes | 94 | 101 |
| process_text_service_test.dart | ✅ Yes | 90 | 101 |
| raw_key_down_event_test.dart | ✅ Yes | 85 | 100 |
| raw_key_event_data_test.dart | ✅ Yes | 96 | 101 |
| raw_key_up_event_test.dart | ✅ Yes | 88 | 100 |
| restoration_bucket_test.dart | ✅ Yes | 93 | 101 |
| scribble_client_test.dart | ✅ Yes | 90 | 101 |
| sensitive_content_service_test.dart | ✅ Yes | 96 | 101 |
| smart_quotes_type_test.dart | ✅ Yes | 9 | 99 |
| spell_check_service_test.dart | ✅ Yes | 91 | 101 |
| surface_android_view_controller_test.dart | ✅ Yes | 9 | 101 |
| system_context_menu_client_test.dart | ✅ Yes | 97 | 101 |
| system_context_menu_controller_test.dart | ✅ Yes | 91 | 101 |
| text_input_client_test.dart | ✅ Yes | 105 | 100 |
| text_input_connection_test.dart | ✅ Yes | 87 | 101 |

## Batch 7

**Commit:** `2719215a`

**Message:** Add handcrafted print-only batch for services and widgets (20 files)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| text_input_control_test.dart | ✅ Yes | 102 | 90 |
| text_input_test.dart | ✅ Yes | 90 | 89 |
| text_layout_metrics_test.dart | ✅ Yes | 92 | 90 |
| text_selection_delegate_test.dart | ✅ Yes | 100 | 89 |
| textformatter_test.dart | ✅ Yes | 9 | 91 |
| texture_android_view_controller_test.dart | ✅ Yes | 9 | 91 |
| ui_kit_view_controller_test.dart | ✅ Yes | 93 | 91 |
| undo_manager_client_test.dart | ✅ Yes | 107 | 91 |
| undo_manager_test.dart | ✅ Yes | 101 | 91 |
| action_dispatcher_test.dart | ✅ Yes | 9 | 87 |
| activate_action_test.dart | ✅ Yes | 9 | 87 |
| activate_intent_test.dart | ✅ Yes | 9 | 87 |
| always_scrollable_scroll_physics_test.dart | ✅ Yes | 9 | 87 |
| animated_grid_state_test.dart | ✅ Yes | 9 | 87 |
| animated_list_state_test.dart | ✅ Yes | 9 | 87 |
| animated_widget_base_state_test.dart | ✅ Yes | 9 | 87 |
| app_lifecycle_listener_test.dart | ✅ Yes | 9 | 86 |
| async_snapshot_test.dart | ✅ Yes | 9 | 87 |
| autocomplete_first_option_intent_test.dart | ✅ Yes | 9 | 87 |
| autocomplete_last_option_intent_test.dart | ✅ Yes | 9 | 87 |

## Batch 8

**Commit:** `946579c7`

**Message:** Add handcrafted print-only widgets batch (20 files)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| autocomplete_next_option_intent_test.dart | ✅ Yes | 9 | 86 |
| autocomplete_next_page_option_intent_test.dart | ✅ Yes | 9 | 86 |
| autocomplete_previous_option_intent_test.dart | ✅ Yes | 9 | 86 |
| autocomplete_previous_page_option_intent_test.dart | ✅ Yes | 9 | 86 |
| autofill_context_action_test.dart | ✅ Yes | 9 | 86 |
| automatic_keep_alive_client_mixin_test.dart | ✅ Yes | 58 | 86 |
| autovalidate_mode_test.dart | ✅ Yes | 9 | 85 |
| ballistic_scroll_activity_test.dart | ✅ Yes | 9 | 86 |
| banner_location_test.dart | ✅ Yes | 9 | 85 |
| base_window_controller_test.dart | ✅ Yes | 9 | 85 |
| border_radius_tween_test.dart | ✅ Yes | 9 | 85 |
| border_tween_test.dart | ✅ Yes | 9 | 86 |
| bouncing_scroll_physics_test.dart | ✅ Yes | 9 | 86 |
| bouncing_scroll_simulation_test.dart | ✅ Yes | 9 | 86 |
| box_constraints_tween_test.dart | ✅ Yes | 9 | 86 |
| build_owner_test.dart | ✅ Yes | 9 | 86 |
| build_scope_test.dart | ✅ Yes | 9 | 86 |
| button_activate_intent_test.dart | ✅ Yes | 9 | 86 |
| captured_themes_test.dart | ✅ Yes | 9 | 86 |
| change_reporting_behavior_test.dart | ✅ Yes | 9 | 85 |

## Batch 9

**Commit:** `31e9681d`

**Message:** Add handcrafted print-only widgets batch (20 files, next set)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| character_activator_test.dart | ✅ Yes | 9 | 85 |
| child_vicinity_test.dart | ✅ Yes | 9 | 85 |
| clamping_scroll_physics_test.dart | ✅ Yes | 9 | 85 |
| clamping_scroll_simulation_test.dart | ✅ Yes | 9 | 85 |
| class_test.dart | ✅ Yes | 9 | 85 |
| clipboard_status_notifier_test.dart | ✅ Yes | 9 | 84 |
| clipboard_status_test.dart | ✅ Yes | 9 | 84 |
| component_element_test.dart | ✅ Yes | 9 | 85 |
| connection_state_test.dart | ✅ Yes | 9 | 84 |
| content_insertion_configuration_test.dart | ✅ Yes | 9 | 85 |
| context_menu_button_item_test.dart | ✅ Yes | 9 | 84 |
| context_menu_button_type_test.dart | ✅ Yes | 9 | 84 |
| copy_selection_text_intent_test.dart | ✅ Yes | 9 | 85 |
| cross_fade_state_test.dart | ✅ Yes | 9 | 84 |
| debug_creator_test.dart | ✅ Yes | 9 | 85 |
| decoration_tween_test.dart | ✅ Yes | 9 | 85 |
| default_platform_menu_delegate_test.dart | ✅ Yes | 9 | 85 |
| default_transition_delegate_test.dart | ✅ Yes | 9 | 85 |
| delete_character_intent_test.dart | ✅ Yes | 9 | 85 |
| delete_to_line_break_intent_test.dart | ✅ Yes | 9 | 85 |

## Batch 10

**Commit:** `dc6145bc`

**Message:** feat: print-only tests batch 12 - 20 widget tests (DeleteToNextWordBoundary through DismissMenuAction), analyzer clean, >=80 lines

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| delete_to_next_word_boundary_intent_test.dart | ✅ Yes | 9 | 88 |
| desktop_text_selection_toolbar_layout_delegate_test.dart | ✅ Yes | 9 | 113 |
| dev_tools_deep_link_property_test.dart | ✅ Yes | 9 | 86 |
| diagonal_drag_behavior_test.dart | ✅ Yes | 9 | 91 |
| dialog_window_controller_delegate_test.dart | ✅ Yes | 54 | 87 |
| dialog_window_controller_linux_test.dart | ✅ Yes | 9 | 89 |
| dialog_window_controller_mac_o_s_test.dart | ✅ Yes | 9 | 88 |
| dialog_window_controller_test.dart | ✅ Yes | 9 | 101 |
| dialog_window_controller_win32_test.dart | ✅ Yes | 9 | 87 |
| dialog_window_test.dart | ✅ Yes | 9 | 91 |
| directional_caret_movement_intent_test.dart | ✅ Yes | 9 | 88 |
| directional_focus_action_test.dart | ✅ Yes | 9 | 87 |
| directional_focus_intent_test.dart | ✅ Yes | 9 | 94 |
| directional_focus_traversal_policy_mixin_test.dart | ✅ Yes | 58 | 84 |
| directional_text_editing_intent_test.dart | ✅ Yes | 9 | 96 |
| disable_widget_inspector_scope_test.dart | ✅ Yes | 9 | 93 |
| dismiss_action_test.dart | ✅ Yes | 9 | 90 |
| dismiss_direction_test.dart | ✅ Yes | 9 | 95 |
| dismiss_intent_test.dart | ✅ Yes | 9 | 89 |
| dismiss_menu_action_test.dart | ✅ Yes | 9 | 95 |

## Batch 11

**Commit:** `0f02f892`

**Message:** feat: print-only tests batch 13 - 20 widget tests (DismissUpdateDetails through EditableTextTapUpOutsideIntent), analyzer clean, >=80 lines

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| dismiss_update_details_test.dart | ✅ Yes | 9 | 106 |
| disposable_build_context_test.dart | ✅ Yes | 9 | 88 |
| do_nothing_action_test.dart | ✅ Yes | 9 | 89 |
| do_nothing_and_stop_propagation_intent_test.dart | ✅ Yes | 9 | 93 |
| do_nothing_and_stop_propagation_text_intent_test.dart | ✅ Yes | 9 | 90 |
| do_nothing_intent_test.dart | ✅ Yes | 9 | 90 |
| drag_boundary_delegate_test.dart | ✅ Yes | 9 | 97 |
| drag_boundary_test.dart | ✅ Yes | 9 | 93 |
| drag_scroll_activity_test.dart | ✅ Yes | 9 | 95 |
| drag_target_details_test.dart | ✅ Yes | 9 | 98 |
| draggable_details_test.dart | ✅ Yes | 9 | 96 |
| draggable_scrollable_controller_test.dart | ✅ Yes | 9 | 105 |
| draggable_scrollable_notification_test.dart | ✅ Yes | 9 | 99 |
| driven_scroll_activity_test.dart | ✅ Yes | 9 | 103 |
| edge_dragging_auto_scroller_test.dart | ✅ Yes | 9 | 91 |
| edge_insets_geometry_tween_test.dart | ✅ Yes | 9 | 98 |
| edge_insets_tween_test.dart | ✅ Yes | 9 | 99 |
| editable_text_state_test.dart | ✅ Yes | 9 | 97 |
| editable_text_tap_outside_intent_test.dart | ✅ Yes | 9 | 97 |
| editable_text_tap_up_outside_intent_test.dart | ✅ Yes | 9 | 94 |

## Batch 12

**Commit:** `46498851`

**Message:** feat: print-only tests batch 14 - 20 widget tests (Element through FixedExtentMetrics), analyzer clean, >=80 lines

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| element_test.dart | ✅ Yes | 9 | 95 |
| empty_text_selection_controls_test.dart | ✅ Yes | 9 | 86 |
| enable_widget_inspector_scope_test.dart | ✅ Yes | 9 | 90 |
| exclude_focus_test.dart | ✅ Yes | 9 | 93 |
| exclude_focus_traversal_test.dart | ✅ Yes | 9 | 93 |
| expand_selection_to_document_boundary_intent_test.dart | ✅ Yes | 9 | 88 |
| expand_selection_to_line_break_intent_test.dart | ✅ Yes | 9 | 88 |
| expansible_controller_test.dart | ✅ Yes | 9 | 103 |
| extend_selection_by_character_intent_test.dart | ✅ Yes | 9 | 88 |
| extend_selection_by_page_intent_test.dart | ✅ Yes | 9 | 88 |
| extend_selection_to_document_boundary_intent_test.dart | ✅ Yes | 9 | 89 |
| extend_selection_to_line_break_intent_test.dart | ✅ Yes | 9 | 88 |
| extend_selection_to_next_paragraph_boundary_intent_test.dart | ✅ Yes | 9 | 92 |
| extend_selection_to_next_paragraph_boundary_or_caret_location_intent_test.dart | ✅ Yes | 9 | 89 |
| extend_selection_to_next_word_boundary_intent_test.dart | ✅ Yes | 9 | 92 |
| extend_selection_to_next_word_boundary_or_caret_location_intent_test.dart | ✅ Yes | 9 | 89 |
| extend_selection_vertically_to_adjacent_line_intent_test.dart | ✅ Yes | 9 | 92 |
| extend_selection_vertically_to_adjacent_page_intent_test.dart | ✅ Yes | 9 | 92 |
| feedback_test.dart | ✅ Yes | 9 | 97 |
| fixed_extent_metrics_test.dart | ✅ Yes | 9 | 101 |

## Batch 13

**Commit:** `2d7e4dbf`

**Message:** feat: print-only tests batch 15 - 20 widget tests (FixedExtentScrollController through IOSSystemContextMenuItemLiveText), analyzer clean, >=80 lines

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| fixed_extent_scroll_controller_test.dart | ✅ Yes | 9 | 98 |
| fixed_extent_scroll_physics_test.dart | ✅ Yes | 9 | 89 |
| fixed_scroll_metrics_test.dart | ✅ Yes | 9 | 99 |
| floating_header_snap_mode_test.dart | ✅ Yes | 9 | 85 |
| focus_attachment_test.dart | ✅ Yes | 9 | 92 |
| focus_highlight_mode_test.dart | ✅ Yes | 9 | 88 |
| focus_highlight_strategy_test.dart | ✅ Yes | 9 | 86 |
| focus_order_test.dart | ✅ Yes | 9 | 92 |
| focus_properties_test.dart | ✅ Yes | 67 | 91 |
| focus_scope_node_test.dart | ✅ Yes | 9 | 92 |
| focus_traversal_order_test.dart | ✅ Yes | 9 | 92 |
| gesture_recognizer_factory_test.dart | ✅ Yes | 9 | 94 |
| gesture_recognizer_factory_with_handlers_test.dart | ✅ Yes | 9 | 96 |
| global_object_key_test.dart | ✅ Yes | 9 | 91 |
| hero_flight_direction_test.dart | ✅ Yes | 9 | 93 |
| hold_scroll_activity_test.dart | ✅ Yes | 9 | 98 |
| i_o_s_system_context_menu_item_copy_test.dart | ✅ Yes | 9 | 87 |
| i_o_s_system_context_menu_item_custom_test.dart | ✅ Yes | 9 | 98 |
| i_o_s_system_context_menu_item_cut_test.dart | ✅ Yes | 9 | 88 |
| i_o_s_system_context_menu_item_live_text_test.dart | ✅ Yes | 9 | 88 |

## Batch 14

**Commit:** `704ee22b`

**Message:** feat: print-only tests batch 16 - 20 tests (ColorTween + dart_ui classes), analyzer clean, >=80 lines

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| color_tween_test.dart | ❌ No | 78 | 93 |
| clip_r_superellipse_engine_layer_test.dart | ❌ No | 41 | 106 |
| clip_rect_engine_layer_test.dart | ❌ No | 33 | 92 |
| image_descriptor_test.dart | ❌ No | 43 | 94 |
| image_filter_engine_layer_test.dart | ❌ No | 48 | 99 |
| image_sampler_slot_test.dart | ❌ No | 34 | 89 |
| immutable_buffer_test.dart | ❌ No | 47 | 96 |
| isolate_name_server_test.dart | ❌ No | 42 | 114 |
| key_data_test.dart | ❌ No | 77 | 104 |
| key_event_device_type_test.dart | ❌ No | 31 | 86 |
| key_event_type_test.dart | ❌ No | 31 | 86 |
| locale_string_attribute_test.dart | ❌ No | 59 | 96 |
| path_metric_iterator_test.dart | ❌ No | 50 | 112 |
| path_metrics_test.dart | ❌ No | 77 | 101 |
| picture_rasterization_exception_test.dart | ❌ No | 41 | 92 |
| platform_dispatcher_test.dart | ❌ No | 74 | 97 |
| plugin_utilities_test.dart | ❌ No | 42 | 102 |
| pointer_data_test.dart | ❌ No | 61 | 106 |
| scene_test.dart | ❌ No | 38 | 110 |
| semantics_action_event_test.dart | ❌ No | 37 | 103 |

## Batch 15

**Commit:** `89e2d7ee`

**Message:** feat: print-only tests batch 17 - 20 tests (SemanticsUpdate, SingletonFlutterWindow, DiagnosticLevel, Factory, FlagsSummary, TargetPlatform, IOSScrollViewFlingVelocityTracker, 13 material enums), analyzer clean, >=80 lines

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| semantics_update_test.dart | ✅ Yes | 9 | 103 |
| singleton_flutter_window_test.dart | ✅ Yes | 9 | 81 |
| diagnostic_level_test.dart | ✅ Yes | 9 | 101 |
| factory_test.dart | ✅ Yes | 9 | 93 |
| flags_summary_test.dart | ✅ Yes | 9 | 103 |
| target_platform_test.dart | ✅ Yes | 9 | 103 |
| i_o_s_scroll_view_fling_velocity_tracker_test.dart | ✅ Yes | 9 | 92 |
| button_bar_layout_behavior_test.dart | ✅ Yes | 9 | 91 |
| button_text_theme_test.dart | ✅ Yes | 9 | 99 |
| day_period_test.dart | ❌ No | 9 | 102 |
| dropdown_menu_close_behavior_test.dart | ✅ Yes | 9 | 106 |
| dynamic_scheme_variant_test.dart | ✅ Yes | 9 | 108 |
| floating_label_behavior_test.dart | ❌ No | 9 | 108 |
| hour_format_test.dart | ❌ No | 9 | 100 |
| icon_alignment_test.dart | ❌ No | 9 | 120 |
| list_tile_control_affinity_test.dart | ❌ No | 9 | 114 |
| material_banner_closed_reason_test.dart | ✅ Yes | 9 | 110 |
| material_tap_target_size_test.dart | ✅ Yes | 9 | 114 |
| navigation_destination_label_behavior_test.dart | ✅ Yes | 9 | 110 |
| navigation_rail_label_type_test.dart | ✅ Yes | 9 | 114 |

## Batch 16

**Commit:** `c0a31ede`

**Message:** feat: print-only tests batch 18 - 20 tests (RangeSlider, RangeValues, RangeLabels, RadioListTile, PopupMenuPosition, RefreshIndicator enums, SliderInteraction, StretchMode, TabAlignment, RangeSlider shapes), analyzer clean, >=80 lines

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| popup_menu_position_test.dart | ✅ Yes | 9 | 93 |
| radio_list_tile_test.dart | ❌ No | 9 | 132 |
| range_labels_test.dart | ❌ No | 9 | 101 |
| range_slider_test.dart | ❌ No | 9 | 136 |
| range_slider_thumb_shape_test.dart | ❌ No | 9 | 97 |
| range_slider_tick_mark_shape_test.dart | ❌ No | 9 | 96 |
| range_slider_track_shape_test.dart | ❌ No | 9 | 97 |
| range_slider_value_indicator_shape_test.dart | ❌ No | 9 | 98 |
| range_values_test.dart | ❌ No | 9 | 112 |
| rectangular_range_slider_track_shape_test.dart | ❌ No | 9 | 92 |
| rectangular_range_slider_value_indicator_shape_test.dart | ❌ No | 9 | 93 |
| refresh_indicator_status_test.dart | ✅ Yes | 9 | 99 |
| refresh_indicator_trigger_mode_test.dart | ✅ Yes | 9 | 91 |
| script_category_test.dart | ✅ Yes | 9 | 102 |
| show_value_indicator_test.dart | ✅ Yes | 9 | 99 |
| slider_interaction_test.dart | ✅ Yes | 9 | 99 |
| spell_check_suggestions_toolbar_layout_delegate_test.dart | ❌ No | 9 | 103 |
| stretch_mode_test.dart | ✅ Yes | 9 | 101 |
| tab_alignment_test.dart | ✅ Yes | 9 | 102 |
| tab_indicator_animation_test.dart | ✅ Yes | 9 | 98 |

## Batch 17

**Commit:** `0f7e2980`

**Message:** feat: print-only tests batch 19 - 20 widgets/ classes (1000 ≥80L milestone)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| i_o_s_system_context_menu_item_look_up_test.dart | ✅ Yes | 9 | 91 |
| i_o_s_system_context_menu_item_paste_test.dart | ✅ Yes | 9 | 86 |
| i_o_s_system_context_menu_item_search_web_test.dart | ✅ Yes | 9 | 90 |
| i_o_s_system_context_menu_item_select_all_test.dart | ✅ Yes | 9 | 92 |
| i_o_s_system_context_menu_item_share_test.dart | ✅ Yes | 9 | 99 |
| i_o_s_system_context_menu_item_test.dart | ✅ Yes | 9 | 100 |
| icon_data_property_test.dart | ✅ Yes | 9 | 122 |
| idle_scroll_activity_test.dart | ✅ Yes | 9 | 96 |
| implicitly_animated_widget_state_test.dart | ✅ Yes | 9 | 99 |
| implicitly_animated_widget_test.dart | ✅ Yes | 9 | 124 |
| indexed_slot_test.dart | ✅ Yes | 9 | 110 |
| inherited_element_test.dart | ✅ Yes | 9 | 95 |
| inherited_model_element_test.dart | ✅ Yes | 9 | 108 |
| inspector_button_test.dart | ✅ Yes | 9 | 96 |
| inspector_button_variant_test.dart | ✅ Yes | 9 | 109 |
| inspector_reference_data_test.dart | ✅ Yes | 9 | 97 |
| inspector_selection_test.dart | ✅ Yes | 9 | 109 |
| inspector_serialization_delegate_test.dart | ✅ Yes | 9 | 101 |
| keep_alive_handle_test.dart | ✅ Yes | 9 | 113 |
| keep_alive_notification_test.dart | ✅ Yes | 9 | 106 |

## Batch 18

**Commit:** `f8c5e5e8`

**Message:** Batch 20: 20 print-only tests for KeyEventResult through Matrix4Tween (1020 implemented)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| key_event_result_test.dart | ✅ Yes | 9 | 87 |
| key_set_test.dart | ✅ Yes | 9 | 102 |
| labeled_global_key_test.dart | ✅ Yes | 9 | 83 |
| leaf_render_object_element_test.dart | ✅ Yes | 9 | 80 |
| leaf_render_object_widget_test.dart | ✅ Yes | 9 | 84 |
| lexical_focus_order_test.dart | ✅ Yes | 9 | 92 |
| list_wheel_child_builder_delegate_test.dart | ✅ Yes | 9 | 87 |
| list_wheel_child_delegate_test.dart | ✅ Yes | 9 | 81 |
| list_wheel_child_list_delegate_test.dart | ✅ Yes | 9 | 85 |
| list_wheel_child_looping_list_delegate_test.dart | ✅ Yes | 9 | 89 |
| list_wheel_element_test.dart | ✅ Yes | 9 | 93 |
| live_text_input_status_notifier_test.dart | ✅ Yes | 9 | 83 |
| live_text_input_status_test.dart | ✅ Yes | 9 | 84 |
| local_history_entry_test.dart | ✅ Yes | 9 | 85 |
| localizations_resolver_test.dart | ✅ Yes | 9 | 83 |
| lock_state_test.dart | ✅ Yes | 9 | 84 |
| logical_key_set_test.dart | ✅ Yes | 9 | 97 |
| magnifier_controller_test.dart | ✅ Yes | 9 | 85 |
| magnifier_info_test.dart | ✅ Yes | 9 | 89 |
| matrix4_tween_test.dart | ✅ Yes | 9 | 95 |

## Batch 19

**Commit:** `2644327a`

**Message:** Batch 21: Generate 20 print-only test files (widgets/)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| menu_controller_test.dart | ✅ Yes | 9 | 92 |
| multi_child_render_object_element_test.dart | ✅ Yes | 9 | 93 |
| multi_child_render_object_widget_test.dart | ✅ Yes | 9 | 92 |
| multi_selectable_selection_container_delegate_test.dart | ✅ Yes | 9 | 82 |
| navigation_mode_test.dart | ✅ Yes | 9 | 81 |
| navigation_notification_test.dart | ✅ Yes | 9 | 81 |
| nested_scroll_view_state_test.dart | ✅ Yes | 9 | 90 |
| never_scrollable_scroll_physics_test.dart | ✅ Yes | 9 | 87 |
| next_focus_action_test.dart | ✅ Yes | 9 | 84 |
| next_focus_intent_test.dart | ✅ Yes | 9 | 85 |
| notifiable_element_mixin_test.dart | ✅ Yes | 54 | 91 |
| notification_test.dart | ✅ Yes | 9 | 94 |
| numeric_focus_order_test.dart | ✅ Yes | 9 | 86 |
| object_key_test.dart | ✅ Yes | 9 | 91 |
| options_view_open_direction_test.dart | ✅ Yes | 9 | 86 |
| ordered_traversal_policy_test.dart | ✅ Yes | 9 | 94 |
| orientation_test.dart | ✅ Yes | 9 | 85 |
| overflow_bar_alignment_test.dart | ✅ Yes | 9 | 88 |
| overlay_child_layout_info_test.dart | ✅ Yes | 9 | 91 |
| overlay_child_location_test.dart | ✅ Yes | 9 | 89 |

## Batch 20

**Commit:** `f2f5d2e4`

**Message:** Batch 22: Generate 20 print-only test files (widgets/)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| overlay_portal_controller_test.dart | ✅ Yes | 9 | 89 |
| overlay_route_test.dart | ✅ Yes | 9 | 80 |
| overscroll_indicator_notification_test.dart | ✅ Yes | 9 | 84 |
| overscroll_notification_test.dart | ✅ Yes | 9 | 82 |
| page_metrics_test.dart | ✅ Yes | 9 | 87 |
| page_route_builder_test.dart | ✅ Yes | 9 | 89 |
| page_scroll_physics_test.dart | ✅ Yes | 9 | 83 |
| page_storage_key_test.dart | ✅ Yes | 9 | 82 |
| page_test.dart | ✅ Yes | 9 | 82 |
| pan_axis_test.dart | ✅ Yes | 9 | 92 |
| parent_data_element_test.dart | ✅ Yes | 9 | 93 |
| parent_data_widget_test.dart | ✅ Yes | 9 | 84 |
| paste_text_intent_test.dart | ✅ Yes | 9 | 83 |
| platform_menu_delegate_test.dart | ✅ Yes | 9 | 87 |
| platform_provided_menu_item_test.dart | ✅ Yes | 9 | 85 |
| platform_provided_menu_item_type_test.dart | ✅ Yes | 9 | 84 |
| platform_route_information_provider_test.dart | ✅ Yes | 9 | 86 |
| platform_selectable_region_context_menu_test.dart | ✅ Yes | 9 | 81 |
| platform_view_creation_params_test.dart | ✅ Yes | 9 | 83 |
| platform_view_link_test.dart | ✅ Yes | 9 | 87 |

## Batch 21

**Commit:** `eba3f417`

**Message:** Batch 23: Generate 20 print-only test files (widgets/PlatformViewSurface through RegularWindowControllerLinux)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| platform_view_surface_test.dart | ✅ Yes | 9 | 91 |
| pop_navigator_router_delegate_mixin_test.dart | ✅ Yes | 60 | 82 |
| popup_window_controller_delegate_test.dart | ✅ Yes | 54 | 90 |
| popup_window_controller_test.dart | ✅ Yes | 9 | 87 |
| popup_window_test.dart | ✅ Yes | 9 | 92 |
| predictive_back_route_test.dart | ✅ Yes | 9 | 85 |
| previous_focus_action_test.dart | ✅ Yes | 9 | 84 |
| previous_focus_intent_test.dart | ✅ Yes | 9 | 85 |
| proxy_element_test.dart | ✅ Yes | 9 | 87 |
| proxy_widget_test.dart | ✅ Yes | 9 | 90 |
| radio_client_test.dart | ✅ Yes | 54 | 93 |
| radio_group_registry_test.dart | ✅ Yes | 9 | 89 |
| range_maintaining_scroll_physics_test.dart | ✅ Yes | 9 | 86 |
| raw_gesture_detector_state_test.dart | ✅ Yes | 9 | 89 |
| raw_menu_overlay_info_test.dart | ✅ Yes | 9 | 89 |
| raw_scrollbar_state_test.dart | ✅ Yes | 9 | 89 |
| reading_order_traversal_policy_test.dart | ✅ Yes | 9 | 91 |
| redo_text_intent_test.dart | ✅ Yes | 9 | 84 |
| regular_window_controller_delegate_test.dart | ✅ Yes | 54 | 90 |
| regular_window_controller_linux_test.dart | ✅ Yes | 9 | 82 |

## Batch 22

**Commit:** `279e9150`

**Message:** Batch 24: Generate 20 print-only test files (widgets/RegularWindowControllerMacOS through RestorableBool)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| regular_window_controller_mac_o_s_test.dart | ✅ Yes | 9 | 84 |
| regular_window_controller_test.dart | ✅ Yes | 9 | 80 |
| regular_window_controller_win32_test.dart | ✅ Yes | 9 | 81 |
| regular_window_test.dart | ✅ Yes | 9 | 85 |
| relative_rect_tween_test.dart | ✅ Yes | 9 | 81 |
| render_abstract_layout_builder_mixin_test.dart | ✅ Yes | 59 | 83 |
| render_object_element_test.dart | ✅ Yes | 64 | 85 |
| render_object_to_widget_adapter_test.dart | ✅ Yes | 61 | 83 |
| render_object_widget_test.dart | ✅ Yes | 64 | 82 |
| render_tap_region_surface_test.dart | ✅ Yes | 54 | 85 |
| render_tap_region_test.dart | ✅ Yes | 55 | 82 |
| render_two_dimensional_viewport_test.dart | ✅ Yes | 60 | 83 |
| render_web_image_test.dart | ✅ Yes | 53 | 84 |
| reorderable_list_state_test.dart | ✅ Yes | 9 | 84 |
| repeat_mode_test.dart | ✅ Yes | 9 | 83 |
| replace_text_intent_test.dart | ✅ Yes | 9 | 81 |
| request_focus_action_test.dart | ✅ Yes | 9 | 85 |
| request_focus_intent_test.dart | ✅ Yes | 9 | 82 |
| restorable_bool_n_test.dart | ✅ Yes | 9 | 84 |
| restorable_bool_test.dart | ✅ Yes | 9 | 83 |

## Batch 23

**Commit:** `68ad4974`

**Message:** Batch 25: Generate 20 print-only test files (widgets/RestorableChangeNotifier through RootElementMixin)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| restorable_change_notifier_test.dart | ✅ Yes | 9 | 81 |
| restorable_date_time_n_test.dart | ✅ Yes | 9 | 82 |
| restorable_date_time_test.dart | ✅ Yes | 9 | 86 |
| restorable_double_n_test.dart | ✅ Yes | 9 | 95 |
| restorable_double_test.dart | ✅ Yes | 9 | 91 |
| restorable_enum_n_test.dart | ✅ Yes | 9 | 92 |
| restorable_enum_test.dart | ✅ Yes | 9 | 90 |
| restorable_int_n_test.dart | ✅ Yes | 9 | 85 |
| restorable_int_test.dart | ✅ Yes | 9 | 92 |
| restorable_listenable_test.dart | ✅ Yes | 9 | 85 |
| restorable_num_n_test.dart | ✅ Yes | 9 | 89 |
| restorable_num_test.dart | ✅ Yes | 9 | 87 |
| restorable_property_test.dart | ✅ Yes | 9 | 87 |
| restorable_route_future_test.dart | ✅ Yes | 9 | 88 |
| restorable_string_n_test.dart | ✅ Yes | 9 | 85 |
| restorable_string_test.dart | ✅ Yes | 9 | 87 |
| restorable_text_editing_controller_test.dart | ✅ Yes | 9 | 89 |
| restorable_value_test.dart | ✅ Yes | 9 | 81 |
| restoration_mixin_test.dart | ✅ Yes | 64 | 93 |
| root_element_mixin_test.dart | ✅ Yes | 22 | 87 |

## Batch 24

**Commit:** `f2ce3cdf`

**Message:** Batch 26: Generate 20 print-only test files (widgets/RootRenderObjectElement through ScrollMetricsNotification)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| root_render_object_element_test.dart | ✅ Yes | 9 | 90 |
| root_widget_test.dart | ✅ Yes | 9 | 81 |
| route_aware_test.dart | ✅ Yes | 54 | 95 |
| route_information_reporting_type_test.dart | ✅ Yes | 9 | 80 |
| route_information_test.dart | ✅ Yes | 9 | 82 |
| route_pop_disposition_test.dart | ✅ Yes | 9 | 86 |
| route_transition_record_test.dart | ✅ Yes | 9 | 91 |
| router_config_test.dart | ✅ Yes | 9 | 89 |
| scroll_action_test.dart | ✅ Yes | 9 | 81 |
| scroll_activity_delegate_test.dart | ✅ Yes | 9 | 92 |
| scroll_activity_test.dart | ✅ Yes | 9 | 81 |
| scroll_context_test.dart | ✅ Yes | 9 | 80 |
| scroll_deceleration_rate_test.dart | ✅ Yes | 9 | 85 |
| scroll_drag_controller_test.dart | ✅ Yes | 9 | 83 |
| scroll_end_notification_test.dart | ✅ Yes | 9 | 86 |
| scroll_hold_controller_test.dart | ✅ Yes | 9 | 81 |
| scroll_increment_details_test.dart | ✅ Yes | 9 | 90 |
| scroll_increment_type_test.dart | ✅ Yes | 9 | 86 |
| scroll_intent_test.dart | ✅ Yes | 9 | 95 |
| scroll_metrics_notification_test.dart | ✅ Yes | 9 | 89 |

## Batch 25

**Commit:** `29dcf21e`

**Message:** Batch 27: 20 print-only test files (widgets/)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| scroll_notification_observer_state_test.dart | ✅ Yes | 9 | 80 |
| scroll_physics_test.dart | ✅ Yes | 9 | 85 |
| scroll_position_alignment_policy_test.dart | ✅ Yes | 9 | 82 |
| scroll_position_test.dart | ✅ Yes | 9 | 85 |
| scroll_position_with_single_context_test.dart | ✅ Yes | 9 | 84 |
| scroll_start_notification_test.dart | ✅ Yes | 9 | 87 |
| scroll_to_document_boundary_intent_test.dart | ✅ Yes | 9 | 82 |
| scroll_update_notification_test.dart | ✅ Yes | 9 | 85 |
| scroll_view_keyboard_dismiss_behavior_test.dart | ✅ Yes | 9 | 82 |
| scrollable_details_test.dart | ✅ Yes | 9 | 83 |
| scrollable_state_test.dart | ✅ Yes | 9 | 85 |
| scrollbar_orientation_test.dart | ✅ Yes | 9 | 89 |
| select_action_test.dart | ✅ Yes | 9 | 88 |
| select_all_text_intent_test.dart | ✅ Yes | 9 | 91 |
| select_intent_test.dart | ✅ Yes | 9 | 95 |
| selectable_region_state_test.dart | ✅ Yes | 9 | 90 |
| selection_container_delegate_test.dart | ✅ Yes | 9 | 95 |
| selection_details_test.dart | ✅ Yes | 9 | 90 |
| semantics_gesture_delegate_test.dart | ✅ Yes | 9 | 96 |
| shortcut_activator_test.dart | ✅ Yes | 9 | 98 |

## Batch 26

**Commit:** `4709873d`

**Message:** Batch 28: 20 print-only tests (widgets: Shortcut*, Single*, Sliver*, Slotted*)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| shortcut_manager_test.dart | ✅ Yes | 9 | 146 |
| shortcut_map_property_test.dart | ✅ Yes | 9 | 138 |
| shortcut_registry_entry_test.dart | ✅ Yes | 9 | 113 |
| shortcut_serialization_test.dart | ✅ Yes | 9 | 136 |
| single_activator_test.dart | ✅ Yes | 9 | 154 |
| single_child_render_object_element_test.dart | ✅ Yes | 9 | 143 |
| single_child_render_object_widget_test.dart | ✅ Yes | 9 | 132 |
| single_ticker_provider_state_mixin_test.dart | ✅ Yes | 57 | 152 |
| size_changed_layout_notification_test.dart | ✅ Yes | 9 | 140 |
| sliver_animated_grid_state_test.dart | ✅ Yes | 9 | 155 |
| sliver_animated_list_state_test.dart | ✅ Yes | 9 | 155 |
| sliver_child_builder_delegate_test.dart | ✅ Yes | 9 | 140 |
| sliver_child_delegate_test.dart | ✅ Yes | 9 | 143 |
| sliver_child_list_delegate_test.dart | ✅ Yes | 9 | 150 |
| sliver_multi_box_adaptor_element_test.dart | ✅ Yes | 9 | 140 |
| sliver_multi_box_adaptor_widget_test.dart | ✅ Yes | 9 | 142 |
| sliver_persistent_header_delegate_test.dart | ✅ Yes | 9 | 142 |
| sliver_reorderable_list_state_test.dart | ✅ Yes | 9 | 169 |
| slotted_container_render_object_mixin_test.dart | ✅ Yes | 60 | 149 |
| slotted_multi_child_render_object_widget_mixin_test.dart | ✅ Yes | 61 | 145 |

## Batch 27

**Commit:** `8a752966`

**Message:** Batch 29: 20 print-only tests (widgets: Slotted*, Snapshot*, Text*, Ticker*, etc.)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| slotted_multi_child_render_object_widget_test.dart | ✅ Yes | 9 | 86 |
| slotted_render_object_element_test.dart | ✅ Yes | 9 | 83 |
| snapshot_controller_test.dart | ✅ Yes | 9 | 80 |
| snapshot_mode_test.dart | ✅ Yes | 9 | 82 |
| spell_check_configuration_test.dart | ✅ Yes | 9 | 85 |
| standard_component_type_test.dart | ✅ Yes | 9 | 85 |
| stateful_element_test.dart | ✅ Yes | 9 | 95 |
| stateless_element_test.dart | ✅ Yes | 9 | 96 |
| static_selection_container_delegate_test.dart | ✅ Yes | 9 | 88 |
| stream_builder_base_test.dart | ✅ Yes | 9 | 102 |
| text_magnifier_configuration_test.dart | ✅ Yes | 9 | 87 |
| text_selection_controls_test.dart | ✅ Yes | 9 | 82 |
| text_selection_gesture_detector_builder_delegate_test.dart | ✅ Yes | 9 | 80 |
| text_selection_gesture_detector_builder_test.dart | ✅ Yes | 9 | 88 |
| text_selection_handle_controls_test.dart | ✅ Yes | 58 | 91 |
| text_selection_toolbar_anchors_test.dart | ✅ Yes | 9 | 85 |
| text_selection_toolbar_layout_delegate_test.dart | ✅ Yes | 9 | 92 |
| text_style_tween_test.dart | ✅ Yes | 9 | 92 |
| ticker_provider_state_mixin_test.dart | ✅ Yes | 59 | 116 |
| toggleable_painter_test.dart | ✅ Yes | 9 | 97 |

## Batch 28

**Commit:** `52e441ad`

**Message:** Batch 30: 20 print-only tests (widgets: Toggleable*, Tooltip*, Transition*, TwoDimensional*, etc.)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| toggleable_state_mixin_test.dart | ✅ Yes | 59 | 95 |
| toolbar_items_parent_data_test.dart | ✅ Yes | 9 | 87 |
| toolbar_options_test.dart | ✅ Yes | 9 | 87 |
| tooltip_position_context_test.dart | ✅ Yes | 9 | 92 |
| tooltip_window_controller_delegate_test.dart | ✅ Yes | 54 | 83 |
| tooltip_window_controller_test.dart | ✅ Yes | 9 | 89 |
| tooltip_window_test.dart | ✅ Yes | 9 | 89 |
| tracking_scroll_controller_test.dart | ✅ Yes | 9 | 90 |
| transformation_controller_test.dart | ✅ Yes | 9 | 97 |
| transition_delegate_test.dart | ✅ Yes | 9 | 92 |
| transition_route_test.dart | ✅ Yes | 9 | 95 |
| transpose_characters_intent_test.dart | ✅ Yes | 9 | 95 |
| traversal_direction_test.dart | ✅ Yes | 9 | 93 |
| traversal_edge_behavior_test.dart | ✅ Yes | 9 | 94 |
| tree_sliver_controller_test.dart | ✅ Yes | 9 | 92 |
| tree_sliver_state_mixin_test.dart | ✅ Yes | 54 | 95 |
| two_dimensional_child_builder_delegate_test.dart | ✅ Yes | 9 | 96 |
| two_dimensional_child_delegate_test.dart | ✅ Yes | 9 | 97 |
| two_dimensional_child_list_delegate_test.dart | ✅ Yes | 9 | 106 |
| two_dimensional_child_manager_test.dart | ✅ Yes | 9 | 103 |

## Batch 29

**Commit:** `635d5386`

**Message:** Batch 31: 20 print-only tests (widgets: RootElement, Undo*, Viewport*, Widget*, etc.)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| root_element_test.dart | ✅ Yes | 9 | 82 |
| two_dimensional_scrollable_state_test.dart | ✅ Yes | 9 | 82 |
| two_dimensional_viewport_parent_data_test.dart | ✅ Yes | 9 | 82 |
| undo_history_controller_test.dart | ✅ Yes | 9 | 81 |
| undo_history_state_test.dart | ✅ Yes | 9 | 82 |
| undo_history_value_test.dart | ✅ Yes | 9 | 80 |
| undo_text_intent_test.dart | ✅ Yes | 9 | 84 |
| unfocus_disposition_test.dart | ✅ Yes | 9 | 85 |
| update_selection_intent_test.dart | ✅ Yes | 9 | 90 |
| user_scroll_notification_test.dart | ✅ Yes | 9 | 84 |
| viewport_element_mixin_test.dart | ✅ Yes | 53 | 87 |
| viewport_notification_mixin_test.dart | ✅ Yes | 54 | 88 |
| void_callback_action_test.dart | ✅ Yes | 9 | 92 |
| void_callback_intent_test.dart | ✅ Yes | 9 | 94 |
| weak_map_test.dart | ✅ Yes | 9 | 89 |
| web_browser_detection_test.dart | ✅ Yes | 9 | 92 |
| widget_inspector_service_extensions_test.dart | ✅ Yes | 9 | 88 |
| widget_inspector_service_test.dart | ✅ Yes | 59 | 89 |
| widget_inspector_test.dart | ✅ Yes | 9 | 94 |
| widget_order_traversal_policy_test.dart | ✅ Yes | 9 | 93 |

## Batch 30

**Commit:** `15575e41`

**Message:** Batch 32: 20 print-only tests (widgets: WidgetState*, Widget, WidgetsBinding*, Window*)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| widget_state_border_side_test.dart | ✅ Yes | 9 | 83 |
| widget_state_color_test.dart | ✅ Yes | 9 | 85 |
| widget_state_mapper_test.dart | ✅ Yes | 9 | 84 |
| widget_state_mouse_cursor_test.dart | ✅ Yes | 9 | 83 |
| widget_state_outlined_border_test.dart | ✅ Yes | 9 | 94 |
| widget_state_property_all_test.dart | ✅ Yes | 9 | 87 |
| widget_state_test.dart | ✅ Yes | 9 | 81 |
| widget_state_text_style_test.dart | ✅ Yes | 9 | 85 |
| widget_states_constraint_test.dart | ✅ Yes | 9 | 95 |
| widget_test.dart | ✅ Yes | 9 | 88 |
| widgets_binding_observer_test.dart | ✅ Yes | 57 | 89 |
| widgets_binding_test.dart | ✅ Yes | 9 | 81 |
| widgets_flutter_binding_test.dart | ✅ Yes | 9 | 87 |
| widgets_localizations_test.dart | ✅ Yes | 9 | 86 |
| widgets_service_extensions_test.dart | ✅ Yes | 9 | 85 |
| window_positioner_anchor_test.dart | ✅ Yes | 56 | 95 |
| window_positioner_constraint_adjustment_test.dart | ✅ Yes | 9 | 86 |
| window_positioner_test.dart | ✅ Yes | 9 | 89 |
| window_scope_test.dart | ✅ Yes | 9 | 86 |
| windowing_owner_linux_test.dart | ✅ Yes | 9 | 84 |

## Batch 31

**Commit:** `e66c7704`

**Message:** Batch 33: 20 print-only tests (widgets: WindowingOwner*; material: enums + Range*)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| button_bar_layout_behavior_test.dart | ✅ Yes | 91 | 87 |
| button_text_theme_test.dart | ✅ Yes | 99 | 86 |
| dropdown_menu_close_behavior_test.dart | ✅ Yes | 106 | 100 |
| dynamic_scheme_variant_test.dart | ✅ Yes | 108 | 86 |
| material_banner_closed_reason_test.dart | ✅ Yes | 110 | 86 |
| material_tap_target_size_test.dart | ✅ Yes | 114 | 83 |
| navigation_destination_label_behavior_test.dart | ✅ Yes | 110 | 89 |
| navigation_rail_label_type_test.dart | ✅ Yes | 114 | 89 |
| popup_menu_position_test.dart | ✅ Yes | 93 | 88 |
| range_labels_test.dart | ❌ No | 101 | 86 |
| range_values_test.dart | ❌ No | 112 | 85 |
| refresh_indicator_status_test.dart | ✅ Yes | 99 | 92 |
| refresh_indicator_trigger_mode_test.dart | ✅ Yes | 91 | 80 |
| script_category_test.dart | ✅ Yes | 102 | 82 |
| show_value_indicator_test.dart | ✅ Yes | 99 | 87 |
| slider_interaction_test.dart | ✅ Yes | 99 | 87 |
| stretch_mode_test.dart | ✅ Yes | 101 | 86 |
| windowing_owner_mac_o_s_test.dart | ✅ Yes | 9 | 85 |
| windowing_owner_test.dart | ✅ Yes | 9 | 87 |
| windowing_owner_win32_test.dart | ✅ Yes | 9 | 94 |

## Batch 32

**Commit:** `c55482bd`

**Message:** Batch 34: 20 print-only material tests (RawChip, SwitchListTile, Tab*, TextButton*, Theme*, Toggle*, Tooltip*, Typography)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| raw_chip_test.dart | ❌ No | 9 | 103 |
| raw_material_button_test.dart | ❌ No | 9 | 105 |
| spell_check_suggestions_toolbar_test.dart | ❌ No | 9 | 99 |
| switch_list_tile_test.dart | ❌ No | 9 | 108 |
| tab_bar_theme_data_test.dart | ❌ No | 9 | 93 |
| tab_page_selector_indicator_test.dart | ❌ No | 9 | 90 |
| tab_page_selector_test.dart | ❌ No | 9 | 80 |
| table_row_ink_well_test.dart | ❌ No | 9 | 93 |
| tappable_chip_attributes_test.dart | ❌ No | 9 | 92 |
| text_button_theme_data_test.dart | ❌ No | 9 | 95 |
| text_magnifier_test.dart | ❌ No | 9 | 85 |
| text_selection_toolbar_test.dart | ❌ No | 9 | 82 |
| text_selection_toolbar_text_button_test.dart | ❌ No | 9 | 90 |
| theme_data_tween_test.dart | ❌ No | 9 | 84 |
| theme_extension_test.dart | ❌ No | 9 | 99 |
| toggle_buttons_theme_data_test.dart | ❌ No | 9 | 88 |
| toggle_buttons_theme_test.dart | ❌ No | 9 | 84 |
| tooltip_state_test.dart | ❌ No | 9 | 83 |
| tooltip_visibility_test.dart | ❌ No | 9 | 87 |
| typography_test.dart | ❌ No | 9 | 86 |

## Batch 33

**Commit:** `1de901a9`

**Message:** Batch 35: 20 print-only tests (Thumb, ThemeMode, TimeOfDayFormat, TimePickerEntryMode, Axis*, BorderStyle, BoxFit, BoxShape, FlutterLogoStyle, ImageRepeat, RenderComparison, ResizeImagePolicy, TextOverflow, TextWidthBasis, VerticalDirection, WebHtmlElementStrategy, PerformanceOverlayOption, PersistentHeaderShowOnScreenConfiguration, PictureLayer)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| theme_mode_test.dart | ✅ Yes | 9 | 97 |
| thumb_test.dart | ✅ Yes | 9 | 91 |
| time_of_day_format_test.dart | ✅ Yes | 9 | 87 |
| time_picker_entry_mode_test.dart | ✅ Yes | 9 | 96 |
| axis_direction_test.dart | ✅ Yes | 9 | 82 |
| axis_test.dart | ✅ Yes | 9 | 94 |
| border_style_test.dart | ✅ Yes | 9 | 90 |
| box_fit_test.dart | ✅ Yes | 9 | 88 |
| box_shape_test.dart | ✅ Yes | 9 | 92 |
| flutter_logo_style_test.dart | ✅ Yes | 9 | 93 |
| image_repeat_test.dart | ✅ Yes | 9 | 100 |
| render_comparison_test.dart | ✅ Yes | 9 | 100 |
| resize_image_policy_test.dart | ✅ Yes | 9 | 92 |
| text_overflow_test.dart | ✅ Yes | 9 | 96 |
| text_width_basis_test.dart | ✅ Yes | 9 | 93 |
| vertical_direction_test.dart | ✅ Yes | 9 | 92 |
| web_html_element_strategy_test.dart | ✅ Yes | 9 | 90 |
| performance_overlay_option_test.dart | ✅ Yes | 9 | 94 |
| persistent_header_show_on_screen_configuration_test.dart | ✅ Yes | 9 | 86 |
| picture_layer_test.dart | ✅ Yes | 9 | 91 |

## Batch 34

**Commit:** `020db2ea`

**Message:** Batch 36: 20 print-only tests (SmartDashesType, SmartQuotesType, Autofill*, BrowserContextMenu, DeltaTextInputClient, RestorationManager, RenderBackdrop/Android/Animated/Clip/Proxy/Sliver*, WrapCrossAlignment, TableBorder, RenderBoxContainerDefaultsMixin, Semantics*)

| Filename | In Print-Only Testplan | Lines Before | Lines After |
|----------|------------------------|--------------|-------------|
| render_android_view_test.dart | ❌ No | 9 | 82 |
| render_animated_opacity_test.dart | ❌ No | 9 | 82 |
| render_backdrop_filter_test.dart | ❌ No | 9 | 86 |
| render_box_container_defaults_mixin_test.dart | ❌ No | 9 | 85 |
| render_clip_r_superellipse_test.dart | ❌ No | 9 | 85 |
| render_proxy_sliver_test.dart | ❌ No | 9 | 82 |
| render_sliver_fill_remaining_test.dart | ❌ No | 9 | 86 |
| table_border_test.dart | ✅ Yes | 9 | 86 |
| wrap_cross_alignment_test.dart | ✅ Yes | 9 | 99 |
| semantics_binding_test.dart | ✅ Yes | 9 | 84 |
| semantics_config_test.dart | ❌ No | 9 | 94 |
| semantics_test.dart | ❌ No | 9 | 87 |
| autofill_client_test.dart | ✅ Yes | 9 | 84 |
| autofill_hints_test.dart | ✅ Yes | 9 | 86 |
| autofill_scope_test.dart | ✅ Yes | 9 | 84 |
| browser_context_menu_test.dart | ✅ Yes | 9 | 87 |
| delta_text_input_client_test.dart | ✅ Yes | 9 | 88 |
| restoration_manager_test.dart | ✅ Yes | 9 | 85 |
| smart_dashes_type_test.dart | ✅ Yes | 9 | 88 |
| smart_quotes_type_test.dart | ✅ Yes | 9 | 88 |

