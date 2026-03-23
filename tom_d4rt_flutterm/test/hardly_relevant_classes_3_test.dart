/// Tests for hardly relevant Flutter bridge classes (part 3 of 5).
///
/// rendering, scheduler, semantics, services packages
///
/// These tests use the SendTestRunner to send D4rt scripts to the test app
/// and verify they execute correctly. Each test corresponds to a script
/// in the send_ast_via_http_scripts directory.
///
/// Prerequisites:
/// 1. Run tests: flutter test test/hardly_relevant_classes_3_test.dart
///
/// The test app is started automatically in setUpAll and stopped in tearDownAll
/// when needed.
///
/// Total: 200 test entries
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp();
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  group('Test App Health', () {
    test('app is running', () async {
      final isRunning = await SendTestRunner.isAppRunning();
      expect(
        isRunning,
        isTrue,
        reason: 'Test app should be running (managed by setUpAll).',
      );
    });
  });

  // ============================================================
  // RENDERING PACKAGE (96 files)
  // ============================================================
  group('rendering/', () {
    test('alignment_geometry_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/alignment_geometry_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('alignment_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/alignment_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('annotated_region_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/annotated_region_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('annotation_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/annotation_entry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('annotation_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/annotation_result_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('backdrop_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/backdrop_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cache_extent_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/cache_extent_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('child_layout_helper_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/child_layout_helper_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('rendering/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('clear_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/clear_selection_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('const_test.dart', () async {
      final result = await SendTestRunner.send('rendering/const_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('container_parent_data_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/container_parent_data_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('cross_axis_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/cross_axis_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('decoration_position_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/decoration_position_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('diagnostics_debug_creator_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/diagnostics_debug_creator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('directionally_extend_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/directionally_extend_selection_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flex_fit_test.dart', () async {
      final result = await SendTestRunner.send('rendering/flex_fit_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('floating_header_snap_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/floating_header_snap_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flow_painting_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/flow_painting_context_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flow_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/flow_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fraction_column_width_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/fraction_column_width_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('fractional_offset_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/fractional_offset_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('granularly_extend_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/granularly_extend_selection_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('growth_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/growth_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hit_test_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/hit_test_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_filter_config_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/image_filter_config_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('image_filter_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/image_filter_context_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('list_wheel_child_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/list_wheel_child_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('main_axis_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/main_axis_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('main_axis_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/main_axis_size_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('max_column_width_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/max_column_width_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('min_column_width_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/min_column_width_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_child_layout_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/multi_child_layout_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('over_scroll_header_stretch_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/over_scroll_header_stretch_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overflow_box_fit_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/overflow_box_fit_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('performance_overlay_option_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/performance_overlay_option_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('persistent_header_show_on_screen_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/persistent_header_show_on_screen_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pipeline_manifold_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/pipeline_manifold_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('placeholder_span_index_semantics_tag_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/placeholder_span_index_semantics_tag_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_view_hit_test_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/platform_view_hit_test_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_view_render_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/platform_view_render_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_abstract_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_abstract_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_android_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_android_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_animated_opacity_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_animated_opacity_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_animated_size_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_animated_size_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_app_kit_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_app_kit_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_clip_r_superellipse_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_clip_r_superellipse_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_darwin_platform_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_darwin_platform_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_decorated_sliver_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_decorated_sliver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_editable_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_editable_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_inline_children_container_defaults_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_inline_children_container_defaults_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_object_with_layout_callback_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_object_with_layout_callback_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_performance_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_performance_overlay_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_proxy_sliver_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_proxy_sliver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_box_child_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_box_child_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_constrained_cross_axis_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_constrained_cross_axis_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_cross_axis_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_cross_axis_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_edge_insets_padding_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_edge_insets_padding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_fill_remaining_and_overscroll_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_fill_remaining_and_overscroll_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_fill_remaining_with_scrollable_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_fill_remaining_with_scrollable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_fixed_extent_box_adaptor_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_fixed_extent_box_adaptor_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_floating_pinned_persistent_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_floating_pinned_persistent_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_main_axis_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_main_axis_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_semantics_annotations_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_semantics_annotations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_single_box_adapter_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_single_box_adapter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_ui_kit_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_ui_kit_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/rendering_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('revealed_offset_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/revealed_offset_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/scroll_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('select_all_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/select_all_selection_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('select_paragraph_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/select_paragraph_selection_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('select_word_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/select_word_selection_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selected_content_range_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selected_content_range_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_edge_update_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_edge_update_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_event_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_event_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_extend_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_extend_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_handler_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_handler_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_registrant_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_registrant_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_result_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_status_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_utils_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_utils_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_logical_container_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_logical_container_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_paint_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_paint_order_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_physical_container_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_physical_container_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stack_fit_test.dart', () async {
      final result = await SendTestRunner.send('rendering/stack_fit_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('table_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/table_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('table_cell_vertical_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/table_cell_vertical_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_granularity_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/text_granularity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_handle_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/text_selection_handle_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('texture_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/texture_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tree_sliver_indentation_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/tree_sliver_indentation_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tree_sliver_node_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/tree_sliver_node_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('vertical_caret_movement_run_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/vertical_caret_movement_run_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('wrap_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/wrap_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('wrap_cross_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/wrap_cross_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // SCHEDULER PACKAGE (4 files)
  // ============================================================
  group('scheduler/', () {
    test('class_test.dart', () async {
      final result = await SendTestRunner.send('scheduler/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('priority_test.dart', () async {
      final result = await SendTestRunner.send('scheduler/priority_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('scheduler_phase_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/scheduler_phase_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scheduler_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/scheduler_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // SEMANTICS PACKAGE (10 files)
  // ============================================================
  group('semantics/', () {
    test('accessibility_focus_block_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/accessibility_focus_block_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('announce_semantics_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/announce_semantics_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('assertiveness_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/assertiveness_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('attributed_string_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/attributed_string_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('semantics/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('debug_semantics_dump_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/debug_semantics_dump_order_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('focus_semantic_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/focus_semantic_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('long_press_semantics_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/long_press_semantics_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_semantic_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/tap_semantic_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_semantics_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/tooltip_semantics_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // ============================================================
  // SERVICES PACKAGE (90 files)
  // ============================================================
  group('services/', () {
    test('android_motion_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/android_motion_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('android_pointer_coords_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/android_pointer_coords_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('android_pointer_properties_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/android_pointer_properties_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('application_switcher_description_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/application_switcher_description_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/autofill_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_hints_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/autofill_hints_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_scope_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/autofill_scope_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('background_isolate_binary_messenger_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/background_isolate_binary_messenger_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('binary_messenger_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/binary_messenger_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('services/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('content_sensitivity_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/content_sensitivity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('deferred_component_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/deferred_component_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('delta_text_input_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/delta_text_input_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('device_orientation_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/device_orientation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('floating_cursor_drag_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/floating_cursor_drag_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('g_l_f_w_key_helper_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/g_l_f_w_key_helper_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gtk_key_helper_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/gtk_key_helper_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_copy_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_copy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_custom_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_custom_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_cut_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_cut_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_live_text_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_live_text_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_look_up_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_look_up_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_paste_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_paste_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_search_web_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_search_web_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_select_all_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_select_all_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_share_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_share_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_data_transit_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_data_transit_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_down_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_down_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_event_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_event_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_event_test.dart', () async {
      final result = await SendTestRunner.send('services/key_event_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_helper_test.dart', () async {
      final result = await SendTestRunner.send('services/key_helper_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_message_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_message_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_repeat_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_repeat_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_up_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_up_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyboard_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/keyboard_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyboard_lock_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/keyboard_lock_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyboard_side_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/keyboard_side_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('max_length_enforcement_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/max_length_enforcement_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('message_codec_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/message_codec_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('method_codec_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/method_codec_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('missing_plugin_exception_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/missing_plugin_exception_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('modifier_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/modifier_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('mouse_cursor_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/mouse_cursor_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('mouse_cursor_session_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/mouse_cursor_session_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('mouse_tracker_annotation_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/mouse_tracker_annotation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_exception_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/platform_exception_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_floating_cursor_point_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_floating_cursor_point_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_down_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_down_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_android_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_android_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_fuchsia_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_fuchsia_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_ios_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_ios_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_linux_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_linux_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_mac_os_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_mac_os_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_web_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_web_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_windows_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_windows_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_up_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_up_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_keyboard_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_keyboard_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restoration_bucket_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/restoration_bucket_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scribble_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/scribble_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_changed_cause_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/selection_changed_cause_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_rect_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/selection_rect_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sensitive_content_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/sensitive_content_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/services_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('smart_dashes_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/smart_dashes_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('smart_quotes_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/smart_quotes_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('swipe_edge_test.dart', () async {
      final result = await SendTestRunner.send('services/swipe_edge_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_context_menu_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_context_menu_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_context_menu_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_context_menu_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_sound_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_sound_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_ui_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_ui_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_ui_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_ui_overlay_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_capitalization_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_capitalization_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_delta_deletion_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_delta_deletion_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_delta_insertion_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_delta_insertion_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_delta_non_text_update_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_delta_non_text_update_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_delta_replacement_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_delta_replacement_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_value_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_value_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_connection_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_connection_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_control_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_control_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_test.dart', () async {
      final result = await SendTestRunner.send('services/text_input_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_selection_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_selection_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('undo_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/undo_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

}
