/// Auto-split extended bridge tests (file 10).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
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
      // 1944 TODO C.85 (2026-06-01): historical 20260523-1056 §1.6/E26
      // (ast) + §2.D contention (test) cold-start-contention wrapper
      // REMOVED. TEST sibling of C.78 (AST). Script runs in ~2.9 s
      // under isolated retest (httpMs=2617, totalMs=2853,
      // frameworkErrors=0, sourceChars=73217 — 73 KB / 2233-line).
      // Defaults (25 s httpBuildTimeout + 30 s dart-test) apply.
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
}
