/// Auto-split base bridge tests (file 17).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
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

  // --- WIDGETS INDIVIDUAL SCRIPTS (172 files) ---
  group('widgets/ individual', () {
    test('sliver_animated_grid_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_grid_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_animated_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_animated_opacity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_opacity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_constrained_cross_axis_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_constrained_cross_axis_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_cross_axis_expanded_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_cross_axis_expanded_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_cross_axis_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_cross_axis_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_floating_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_floating_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_ignore_pointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_ignore_pointer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_layout_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_layout_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_main_axis_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_main_axis_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_offstage_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_offstage_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_prototype_extent_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_prototype_extent_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_reorderable_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_reorderable_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_resizing_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_resizing_header_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_safe_area_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_safe_area_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_semantics_test.dart', () async {
      // 1944 TODO C.45 (2026-05-31): historical 20260523-1056 §1.3/E9
      // (ast) + §2.C contention (test) parallel-driver-contention
      // wrapper REMOVED. Script runs in ~1.6 s under normal load
      // (httpMs=1588, sourceChars=39965 — 40 KB / 1096-line script).
      final result = await SendTestRunner.send(
        'widgets/sliver_semantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_visibility_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_visibility_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('spacer_test.dart', () async {
      final result = await SendTestRunner.send('widgets/spacer_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('spell_check_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/spell_check_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stateful_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stateful_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stateless_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stateless_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stretching_overscroll_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stretching_overscroll_indicator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('table_cell_test.dart', () async {
      final result = await SendTestRunner.send('widgets/table_cell_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('table_row_test.dart', () async {
      final result = await SendTestRunner.send('widgets/table_row_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_region_surface_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tap_region_surface_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_region_test.dart', () async {
      final result = await SendTestRunner.send('widgets/tap_region_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_field_tap_region_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_field_tap_region_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_magnifier_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_magnifier_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_gesture_detector_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_gesture_detector_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_overlay_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_toolbar_anchors_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_toolbar_anchors_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('ticker_mode_test.dart', () async {
      final result = await SendTestRunner.send('widgets/ticker_mode_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('ticker_provider_state_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/ticker_provider_state_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('title_test.dart', () async {
      final result = await SendTestRunner.send('widgets/title_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_trigger_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_trigger_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tween_animation_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tween_animation_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('ui_kit_view_test.dart', () async {
      final result = await SendTestRunner.send('widgets/ui_kit_view_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('undo_history_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/undo_history_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('view_anchor_test.dart', () async {
      final result = await SendTestRunner.send('widgets/view_anchor_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('view_collection_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/view_collection_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('view_test.dart', () async {
      final result = await SendTestRunner.send('widgets/view_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('viewport_test.dart', () async {
      final result = await SendTestRunner.send('widgets/viewport_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_inspector_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_inspector_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_test.dart', () async {
      final result = await SendTestRunner.send('widgets/widget_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets_app_test.dart', () async {
      final result = await SendTestRunner.send('widgets/widgets_app_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets_binding_observer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widgets_binding_observer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widgets_binding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets_flutter_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widgets_flutter_binding_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('will_pop_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/will_pop_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
