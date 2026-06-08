/// Auto-split extended bridge tests (file 16).
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
  // WIDGETS PACKAGE (456 files)
  // ============================================================
  group('widgets/', () {
    test('localizations_resolver_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/localizations_resolver_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('lock_state_test.dart', () async {
      final result = await SendTestRunner.send('widgets/lock_state_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('logical_key_set_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/logical_key_set_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('lookup_boundary_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/lookup_boundary_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('matrix4_tween_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/matrix4_tween_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('matrix_transition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/matrix_transition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menu_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/menu_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('menu_serializable_shortcut_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/menu_serializable_shortcut_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('meta_data_test.dart', () async {
      final result = await SendTestRunner.send('widgets/meta_data_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('modal_barrier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/modal_barrier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('multi_selectable_selection_container_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/multi_selectable_selection_container_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigation_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigation_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigation_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('navigator_pop_handler_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/navigator_pop_handler_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('nested_scroll_view_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/nested_scroll_view_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('nested_scroll_view_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/nested_scroll_view_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('next_focus_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/next_focus_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('next_focus_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/next_focus_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('notifiable_element_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/notifiable_element_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('numeric_focus_order_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/numeric_focus_order_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('object_key_test.dart', () async {
      final result = await SendTestRunner.send('widgets/object_key_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('options_view_open_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/options_view_open_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('ordered_traversal_policy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/ordered_traversal_policy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('orientation_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/orientation_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('orientation_test.dart', () async {
      final result = await SendTestRunner.send('widgets/orientation_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('overflow_bar_alignment_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overflow_bar_alignment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_child_layout_info_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_child_layout_info_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_child_location_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_child_location_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_portal_controller_test.dart', () async {
      // 1944 TODO C.92 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` (Timeout(Duration(seconds: 60)))
      // REMOVED. Script runs in ~1.9 s under isolated retest
      // (httpMs=1516, totalMs=1903, frameworkErrors=0, sourceChars=
      // 51459 — 51 KB / overlay_portal controller test with rich
      // controller-lifecycle output: outputLines=23). Defaults apply.
      final result = await SendTestRunner.send(
        'widgets/overlay_portal_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_portal_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_portal_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_route_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_route_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overlay_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overlay_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overscroll_indicator_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/overscroll_indicator_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('overscroll_notification_test.dart', () async {
      // 1944 TODO C.93 (2026-06-01): historical 20260523-1056 §1.7/E33
      // cold-start-contention wrapper REMOVED. Script runs in ~2.0 s
      // under isolated retest (httpMs=1559, totalMs=1974,
      // frameworkErrors=0, sourceChars=53631 — 54 KB / 1278-line /
      // 510 KB bundle; outputLines=25 — rich coverage preserved).
      // Closes AST half of §C.vii. Defaults apply.
      final result = await SendTestRunner.send(
        'widgets/overscroll_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_metrics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_route_builder_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/page_route_builder_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('page_test.dart', () async {
      final result = await SendTestRunner.send('widgets/page_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('pan_axis_test.dart', () async {
      final result = await SendTestRunner.send('widgets/pan_axis_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('paste_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/paste_text_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_menu_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_menu_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_provided_menu_item_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_provided_menu_item_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_route_information_provider_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_route_information_provider_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_selectable_region_context_menu_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_selectable_region_context_menu_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_view_creation_params_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/platform_view_creation_params_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('pop_entry_test.dart', () async {
      final result = await SendTestRunner.send('widgets/pop_entry_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
