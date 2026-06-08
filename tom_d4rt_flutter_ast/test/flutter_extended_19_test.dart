/// Auto-split extended bridge tests (file 19).
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
  // WIDGETS PACKAGE - continued (228 files)
  // ============================================================
  group('widgets/', () {
    test('shortcut_serialization_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcut_serialization_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('single_activator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/single_activator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('size_changed_layout_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/size_changed_layout_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('size_changed_layout_notifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/size_changed_layout_notifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sized_overflow_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sized_overflow_box_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_animated_grid_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_grid_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_animated_list_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_list_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_child_builder_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_child_builder_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_child_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_child_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_child_list_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_child_list_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_ensure_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_ensure_semantics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_fade_transition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_fade_transition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_multi_box_adaptor_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_multi_box_adaptor_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_multi_box_adaptor_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_multi_box_adaptor_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_overlap_absorber_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_overlap_absorber_handle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_overlap_absorber_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_overlap_absorber_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_overlap_injector_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_overlap_injector_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_persistent_header_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_persistent_header_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_reorderable_list_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_reorderable_list_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sliver_with_keep_alive_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_with_keep_alive_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('slotted_container_render_object_mixin_test.dart', () async {
      // 1944 TODO C.106 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` REMOVED. Script runs in ~2.1 s
      // under isolated retest (httpMs=1600, totalMs=2071,
      // frameworkErrors=0, sourceBytes=75454, sourceChars=75294,
      // bundleJsonBytes=810348 — 75 KB / 810 KB bundle; outputLines=
      // 1). Defaults apply.
      final result = await SendTestRunner.send(
        'widgets/slotted_container_render_object_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('slotted_multi_child_render_object_widget_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/slotted_multi_child_render_object_widget_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('slotted_multi_child_render_object_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/slotted_multi_child_render_object_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('slotted_render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/slotted_render_object_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('snapshot_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/snapshot_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('snapshot_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/snapshot_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('snapshot_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/snapshot_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('snapshot_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/snapshot_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('standard_component_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/standard_component_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('static_selection_container_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/static_selection_container_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('status_transition_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/status_transition_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stream_builder_base_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stream_builder_base_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('stretch_effect_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stretch_effect_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_context_menu_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/system_context_menu_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_text_scaler_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/system_text_scaler_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tap_region_registry_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tap_region_registry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'text_selection_gesture_detector_builder_delegate_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/text_selection_gesture_detector_builder_delegate_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    test('text_selection_gesture_detector_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_gesture_detector_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_handle_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_handle_controls_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_toolbar_layout_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_toolbar_layout_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_style_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_style_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('texture_test.dart', () async {
      final result = await SendTestRunner.send('widgets/texture_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('ticker_mode_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/ticker_mode_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('toggleable_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/toggleable_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('toggleable_state_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/toggleable_state_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('toolbar_items_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/toolbar_items_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('toolbar_options_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/toolbar_options_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_position_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_position_context_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_window_controller_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_window_controller_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_window_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_window_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tooltip_window_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_window_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tracking_scroll_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tracking_scroll_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('transformation_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/transformation_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('transition_delegate_test.dart', () async {
      // 1944 TODO C.107 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` REMOVED. Script runs in ~2.3 s
      // under isolated retest (httpMs=1810, totalMs=2295,
      // frameworkErrors=0, sourceBytes=34960, sourceChars=33755,
      // bundleJsonBytes=396518 — 34 KB / 397 KB bundle;
      // outputLines=4 — rich coverage). First isolated retest hit
      // the U31 LaunchServices "Failed to foreground app" flake;
      // retry #1 PASSED clean — standard U31 retry protocol.
      // Defaults apply.
      final result = await SendTestRunner.send(
        'widgets/transition_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('transition_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/transition_route_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('transpose_characters_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/transpose_characters_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('traversal_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/traversal_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('traversal_edge_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/traversal_edge_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tree_sliver_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tree_sliver_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('tree_sliver_node_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tree_sliver_node_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
