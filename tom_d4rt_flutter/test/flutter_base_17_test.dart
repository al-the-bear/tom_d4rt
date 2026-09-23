/// Auto-split base bridge tests (file 17).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_base_17_test.dart';

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

  // --- WIDGETS INDIVIDUAL SCRIPTS (172 files) ---
  group('widgets/ individual', () {
    test('sliver_animated_grid_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_grid_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_animated_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_list_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_animated_opacity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_opacity_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_constrained_cross_axis_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_constrained_cross_axis_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_cross_axis_expanded_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_cross_axis_expanded_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_cross_axis_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_cross_axis_group_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_floating_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_floating_header_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_ignore_pointer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_ignore_pointer_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_layout_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_layout_builder_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_main_axis_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_main_axis_group_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_offstage_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_offstage_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_prototype_extent_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_prototype_extent_list_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_reorderable_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_reorderable_list_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_resizing_header_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_resizing_header_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_safe_area_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_safe_area_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_semantics_test.dart', () async {
      // 1944 TODO C.45 (2026-05-31): historical 20260523-1056 §1.3/E9
      // (ast) + §2.C contention (test) parallel-driver-contention
      // wrapper REMOVED. Script runs in ~1.6 s under normal load
      // (httpMs=1588, sourceChars=39965 — 40 KB / 1096-line script).
      final result = await SendTestRunner.send(
        'widgets/sliver_semantics_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_visibility_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_visibility_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('spacer_test.dart', () async {
      final result = await SendTestRunner.send('widgets/spacer_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('spell_check_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/spell_check_configuration_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('stateful_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stateful_element_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('stateless_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stateless_element_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('stretching_overscroll_indicator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stretching_overscroll_indicator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('table_cell_test.dart', () async {
      final result = await SendTestRunner.send('widgets/table_cell_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('table_row_test.dart', () async {
      final result = await SendTestRunner.send('widgets/table_row_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('tap_region_surface_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tap_region_surface_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tap_region_test.dart', () async {
      final result = await SendTestRunner.send('widgets/tap_region_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('text_field_tap_region_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_field_tap_region_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_magnifier_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_magnifier_configuration_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_selection_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_controls_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_selection_gesture_detector_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_gesture_detector_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_selection_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_overlay_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_selection_toolbar_anchors_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_toolbar_anchors_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('ticker_mode_test.dart', () async {
      final result = await SendTestRunner.send('widgets/ticker_mode_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('ticker_provider_state_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/ticker_provider_state_mixin_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('title_test.dart', () async {
      final result = await SendTestRunner.send('widgets/title_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('tooltip_trigger_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_trigger_mode_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tween_animation_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tween_animation_builder_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('ui_kit_view_test.dart', () async {
      final result = await SendTestRunner.send('widgets/ui_kit_view_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('undo_history_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/undo_history_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('view_anchor_test.dart', () async {
      final result = await SendTestRunner.send('widgets/view_anchor_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('view_collection_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/view_collection_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('view_test.dart', () async {
      final result = await SendTestRunner.send('widgets/view_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('viewport_test.dart', () async {
      final result = await SendTestRunner.send('widgets/viewport_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('widget_inspector_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_inspector_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('widget_test.dart', () async {
      final result = await SendTestRunner.send('widgets/widget_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('widgets_app_test.dart', () async {
      final result = await SendTestRunner.send('widgets/widgets_app_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('widgets_binding_observer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widgets_binding_observer_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('widgets_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widgets_binding_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('widgets_flutter_binding_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widgets_flutter_binding_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('will_pop_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/will_pop_scope_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}
