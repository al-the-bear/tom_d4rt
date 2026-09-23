/// Auto-split extended bridge tests (file 19).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_19_test.dart';

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
  // WIDGETS PACKAGE - continued (228 files)
  // ============================================================
  group('widgets/', () {
    test('shortcut_serialization_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcut_serialization_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('single_activator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/single_activator_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('size_changed_layout_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/size_changed_layout_notification_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('size_changed_layout_notifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/size_changed_layout_notifier_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sized_overflow_box_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sized_overflow_box_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_animated_grid_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_grid_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_animated_list_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_animated_list_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_child_builder_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_child_builder_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_child_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_child_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_child_list_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_child_list_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_ensure_semantics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_ensure_semantics_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_fade_transition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_fade_transition_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_multi_box_adaptor_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_multi_box_adaptor_element_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_multi_box_adaptor_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_multi_box_adaptor_widget_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_overlap_absorber_handle_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_overlap_absorber_handle_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_overlap_absorber_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_overlap_absorber_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_overlap_injector_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_overlap_injector_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_persistent_header_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_persistent_header_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_reorderable_list_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_reorderable_list_state_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('sliver_with_keep_alive_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sliver_with_keep_alive_widget_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('slotted_container_render_object_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/slotted_container_render_object_mixin_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('slotted_multi_child_render_object_widget_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/slotted_multi_child_render_object_widget_mixin_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('slotted_multi_child_render_object_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/slotted_multi_child_render_object_widget_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('slotted_render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/slotted_render_object_element_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('snapshot_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/snapshot_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('snapshot_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/snapshot_mode_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('snapshot_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/snapshot_painter_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('snapshot_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/snapshot_widget_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('standard_component_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/standard_component_type_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('static_selection_container_delegate_test.dart', () async {
      // 1944 TODO C.121 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` REMOVED. No AST sibling —
      // TEST-only entry. Script runs in ~2.9 s under isolated retest
      // (httpMs=2687, totalMs=2915, frameworkErrors=0, sourceChars=
      // 69126 — 69 KB static-selection-container-delegate widget
      // test; outputLines=1). First pre-fix retest hit the U31
      // LaunchServices flake; retry #1 PASSED clean — standard U31
      // retry protocol. Defaults apply.
      final result = await SendTestRunner.send(
        'widgets/static_selection_container_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('status_transition_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/status_transition_widget_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('stream_builder_base_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stream_builder_base_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('stretch_effect_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/stretch_effect_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('system_context_menu_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/system_context_menu_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('system_text_scaler_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/system_text_scaler_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tap_region_registry_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tap_region_registry_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test(
      'text_selection_gesture_detector_builder_delegate_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/text_selection_gesture_detector_builder_delegate_test.dart',
        );
        SendTestRunner.expectSuccess(result);
      },
    );

    test('text_selection_gesture_detector_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_gesture_detector_builder_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_selection_handle_controls_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_handle_controls_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_selection_toolbar_layout_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_selection_toolbar_layout_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('text_style_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/text_style_tween_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('texture_test.dart', () async {
      final result = await SendTestRunner.send('widgets/texture_test.dart');
      SendTestRunner.expectSuccess(result);
    });

    test('ticker_mode_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/ticker_mode_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('toggleable_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/toggleable_painter_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('toggleable_state_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/toggleable_state_mixin_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('toolbar_items_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/toolbar_items_parent_data_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('toolbar_options_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/toolbar_options_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tooltip_position_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_position_context_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tooltip_window_controller_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_window_controller_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tooltip_window_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_window_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tooltip_window_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tooltip_window_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tracking_scroll_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tracking_scroll_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('transformation_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/transformation_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('transition_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/transition_delegate_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('transition_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/transition_route_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('transpose_characters_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/transpose_characters_intent_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('traversal_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/traversal_direction_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('traversal_edge_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/traversal_edge_behavior_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tree_sliver_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tree_sliver_controller_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });

    test('tree_sliver_node_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/tree_sliver_node_test.dart',
      );
      SendTestRunner.expectSuccess(result);
    });
  });
}
