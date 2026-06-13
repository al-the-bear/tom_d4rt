/// Auto-split base bridge tests (file 13).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_base_13_test.dart';

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp(suite: _kTestFileName);
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

  // --- RENDERING INDIVIDUAL SCRIPTS (107 files) ---
  group('rendering/ individual', () {
    test('render_rotated_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_rotated_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_semantics_annotations_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_semantics_annotations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_semantics_gesture_handler_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_semantics_gesture_handler_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_shader_mask_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_shader_mask_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_shrink_wrapping_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_shrink_wrapping_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sized_overflow_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sized_overflow_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_animated_opacity_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_animated_opacity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_fill_remaining_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_fill_remaining_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_fill_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_fill_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_fixed_extent_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_fixed_extent_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_floating_persistent_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_floating_persistent_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_helpers_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_helpers_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_ignore_pointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_ignore_pointer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_multi_box_adaptor_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_multi_box_adaptor_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_offstage_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_offstage_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_persistent_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_persistent_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_pinned_persistent_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_pinned_persistent_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_scrolling_persistent_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_scrolling_persistent_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_to_box_adapter_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_to_box_adapter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_varied_extent_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_varied_extent_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_with_keep_alive_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_with_keep_alive_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_tree_sliver_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_tree_sliver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_viewport_base_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_viewport_base_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('renderer_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/renderer_binding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('rendering_flutter_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/rendering_flutter_binding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selectable_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selectable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selected_content_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selected_content_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_geometry_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_geometry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_point_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_point_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_annotations_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/semantics_annotations_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shader_mask_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/shader_mask_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shape_border_clipper_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/shape_border_clipper_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_grid_geometry_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_grid_geometry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_grid_layout_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_grid_layout_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_grid_regular_tile_layout_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_grid_regular_tile_layout_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_hit_test_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_hit_test_entry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_hit_test_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_hit_test_result_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_layout_dimensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_layout_dimensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_logical_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_logical_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_multi_box_adaptor_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_multi_box_adaptor_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_physical_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_physical_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('table_cell_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/table_cell_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/text_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_point_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/text_selection_point_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('texture_layer_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/texture_layer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('wrap_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/wrap_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // --- SCHEDULER INDIVIDUAL SCRIPTS (1 files) ---
  group('scheduler/ individual', () {
    test('performance_mode_request_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/performance_mode_request_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });

  // --- SEMANTICS INDIVIDUAL SCRIPTS (6 files) ---
  group('semantics/ individual', () {
    test('child_semantics_configurations_result_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/child_semantics_configurations_result_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('child_semantics_configurations_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/child_semantics_configurations_result_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_binding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_label_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/semantics_label_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
