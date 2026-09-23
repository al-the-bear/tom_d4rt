/// Auto-split extended bridge tests (file 10).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_10_test.dart';

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

  // ============================================================
  // RENDERING PACKAGE (96 files)
  // ============================================================
  group('rendering/', () {
    test('render_sliver_floating_pinned_persistent_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_floating_pinned_persistent_header_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_sliver_main_axis_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_main_axis_group_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_sliver_semantics_annotations_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_semantics_annotations_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_sliver_single_box_adapter_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_sliver_single_box_adapter_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('render_ui_kit_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/render_ui_kit_view_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('rendering_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/rendering_service_extensions_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('revealed_offset_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/revealed_offset_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('scroll_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/scroll_direction_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('select_all_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/select_all_selection_event_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('select_paragraph_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/select_paragraph_selection_event_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('select_word_selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/select_word_selection_event_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('selected_content_range_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selected_content_range_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('selection_edge_update_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_edge_update_event_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('selection_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_event_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('selection_event_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_event_type_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('selection_extend_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_extend_direction_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('selection_handler_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_handler_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('selection_registrant_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_registrant_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('selection_result_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_result_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('selection_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_status_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('selection_utils_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/selection_utils_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_logical_container_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_logical_container_parent_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_paint_order_test.dart', () async {
      // 1944 TODO C.78 (2026-05-31): historical 20260523-1056 §1.6/E26
      // cold-start-contention wrapper REMOVED. Script runs in ~2.4 s
      // under normal load (httpMs=2399, bundleJsonBytes=775156 —
      // 775 KB bundle / 73 KB / 2233-line script).
      final result = await SendTestRunner.send(
        'rendering/sliver_paint_order_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_physical_container_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/sliver_physical_container_parent_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('stack_fit_test.dart', () async {
      final result = await SendTestRunner.send('rendering/stack_fit_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('table_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/table_border_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('table_cell_vertical_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/table_cell_vertical_alignment_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_granularity_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/text_granularity_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_selection_handle_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/text_selection_handle_type_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('texture_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/texture_box_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tree_sliver_indentation_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/tree_sliver_indentation_type_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tree_sliver_node_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/tree_sliver_node_parent_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('vertical_caret_movement_run_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/vertical_caret_movement_run_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('wrap_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/wrap_alignment_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('wrap_cross_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'rendering/wrap_cross_alignment_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });

  // ============================================================
  // SCHEDULER PACKAGE (4 files)
  // ============================================================
  group('scheduler/', () {
    test('class_test.dart', () async {
      final result = await SendTestRunner.send('scheduler/class_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('priority_test.dart', () async {
      final result = await SendTestRunner.send('scheduler/priority_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('scheduler_phase_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/scheduler_phase_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('scheduler_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'scheduler/scheduler_service_extensions_test.dart',
      );
      SendTestRunner.expectSuccess(result);
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
      SendTestRunner.expectSuccess(result);
    });

    test('announce_semantics_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/announce_semantics_event_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('assertiveness_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/assertiveness_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('attributed_string_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/attributed_string_property_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('semantics/class_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('debug_semantics_dump_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/debug_semantics_dump_order_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('focus_semantic_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/focus_semantic_event_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('long_press_semantics_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/long_press_semantics_event_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tap_semantic_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/tap_semantic_event_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tooltip_semantics_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'semantics/tooltip_semantics_event_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}
