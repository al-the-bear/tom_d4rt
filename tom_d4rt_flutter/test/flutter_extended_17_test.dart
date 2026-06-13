/// Auto-split extended bridge tests (file 17).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_17_test.dart';

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
    test('pop_navigator_router_delegate_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/pop_navigator_router_delegate_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('popup_window_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/popup_window_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('popup_window_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/popup_window_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('predictive_back_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/predictive_back_route_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('preferred_size_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/preferred_size_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('preferred_size_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/preferred_size_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('previous_focus_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/previous_focus_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('previous_focus_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/previous_focus_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('prioritized_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/prioritized_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('prioritized_intents_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/prioritized_intents_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('radio_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/radio_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('radio_group_registry_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/radio_group_registry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_autocomplete_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_autocomplete_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_dialog_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_dialog_route_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_gesture_detector_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_gesture_detector_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_gesture_detector_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_gesture_detector_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_image_test.dart', () async {
      // 1944 TODO C.113 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` REMOVED. First entry of TEST
      // half of §C.viii. No AST sibling (AST half does not include
      // raw_image — the closest AST entry is C.99 raw_keyboard_listener).
      // Script runs in ~1.9 s under isolated retest (httpMs=1692,
      // totalMs=1931, frameworkErrors=0, sourceChars=60026 — 60 KB
      // raw-image widget test; outputLines=23 — rich coverage).
      // Defaults apply.
      final result = await SendTestRunner.send('widgets/raw_image_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_keyboard_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_keyboard_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_menu_anchor_group_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_menu_anchor_group_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_menu_anchor_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_menu_anchor_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_menu_overlay_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_menu_overlay_info_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_radio_test.dart', () async {
      final result = await SendTestRunner.send('widgets/raw_radio_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_scrollbar_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_scrollbar_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_tooltip_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_tooltip_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_tooltip_test.dart', () async {
      final result = await SendTestRunner.send('widgets/raw_tooltip_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_web_image_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/raw_web_image_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('reading_order_traversal_policy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/reading_order_traversal_policy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('redo_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/redo_text_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('regular_window_controller_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/regular_window_controller_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('regular_window_controller_linux_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/regular_window_controller_linux_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('regular_window_controller_mac_o_s_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/regular_window_controller_mac_o_s_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('regular_window_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/regular_window_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('regular_window_controller_win32_test.dart', () async {
      // 1944 TODO C.114 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` REMOVED. No AST sibling — TEST-only
      // entry. Script runs in ~2.2 s under isolated retest
      // (httpMs=1979, totalMs=2209, frameworkErrors=0,
      // sourceChars=97856 — 98 KB regular-window-controller-win32
      // widget test). Defaults apply.
      final result = await SendTestRunner.send(
        'widgets/regular_window_controller_win32_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('regular_window_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/regular_window_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('relative_positioned_transition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/relative_positioned_transition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('relative_rect_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/relative_rect_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_abstract_layout_builder_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_abstract_layout_builder_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_nested_scroll_view_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_nested_scroll_view_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_object_to_widget_adapter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_object_to_widget_adapter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_object_to_widget_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_object_to_widget_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_overlap_absorber_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_sliver_overlap_absorber_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_sliver_overlap_injector_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_sliver_overlap_injector_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_tap_region_surface_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_tap_region_surface_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_tap_region_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_tap_region_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_tree_root_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_tree_root_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_two_dimensional_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_two_dimensional_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('render_web_image_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/render_web_image_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('reorderable_delayed_drag_start_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/reorderable_delayed_drag_start_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('reorderable_drag_start_listener_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/reorderable_drag_start_listener_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('reorderable_list_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/reorderable_list_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('reorderable_list_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/reorderable_list_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('repeat_mode_test.dart', () async {
      final result = await SendTestRunner.send('widgets/repeat_mode_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('repeating_animation_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/repeating_animation_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('replace_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/replace_text_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('request_focus_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/request_focus_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('request_focus_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/request_focus_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_bool_n_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_bool_n_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_change_notifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_change_notifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_date_time_n_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_date_time_n_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_double_n_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_double_n_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
