/// Auto-split extended bridge tests (file 18).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_18_test.dart';

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
    test('restorable_enum_n_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_enum_n_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_int_n_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_int_n_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_listenable_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_listenable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_num_n_test.dart', () async {
      // 1944 TODO C.102 (2026-06-01): historical 20260523-1056 §1.8/E34
      // cold-start-contention wrapper REMOVED. First entry of §C.viii
      // that uses the §1.8/E-series inline `httpBuildTimeout: 50s` +
      // outer `Timeout: 60s` shape (rather than `_slowTestTimeout`).
      // Script runs in ~2.9 s under isolated retest (httpMs=2456,
      // totalMs=2899, frameworkErrors=0, sourceBytes=56838,
      // sourceChars=56761, bundleJsonBytes=674995 — 57 KB script /
      // 675 KB bundle / 1734-line). Defaults apply.
      final result = await SendTestRunner.send(
        'widgets/restorable_num_n_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_num_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_num_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_route_future_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_route_future_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_string_n_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/restorable_string_n_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('root_back_button_dispatcher_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/root_back_button_dispatcher_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('root_element_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/root_element_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('root_render_object_element_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/root_render_object_element_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_aware_test.dart', () async {
      final result = await SendTestRunner.send('widgets/route_aware_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_information_reporting_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/route_information_reporting_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_information_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/route_information_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_observer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/route_observer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_pop_disposition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/route_pop_disposition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('route_transition_record_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/route_transition_record_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('router_config_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/router_config_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_activity_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_activity_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_activity_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_activity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_aware_image_provider_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_aware_image_provider_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_context_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_deceleration_rate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_deceleration_rate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_drag_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_drag_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_end_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_end_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_hold_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_hold_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_increment_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_increment_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_increment_type_test.dart', () async {
      // 1944 TODO C.103 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` REMOVED. Script runs in ~2.4 s
      // under isolated retest (httpMs=1947, totalMs=2394,
      // frameworkErrors=0, sourceBytes=71635, sourceChars=71543,
      // bundleJsonBytes=882010 — 72 KB / 882 KB bundle). Defaults
      // apply.
      final result = await SendTestRunner.send(
        'widgets/scroll_increment_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_metrics_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_metrics_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_notification_observer_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_notification_observer_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_notification_observer_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_notification_observer_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_position_alignment_policy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_position_alignment_policy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_position_with_single_context_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_position_with_single_context_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_start_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_start_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_to_document_boundary_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_to_document_boundary_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_update_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_update_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_view_keyboard_dismiss_behavior_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scroll_view_keyboard_dismiss_behavior_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scroll_view_test.dart', () async {
      final result = await SendTestRunner.send('widgets/scroll_view_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollable_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollable_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollbar_orientation_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollbar_orientation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scrollbar_painter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/scrollbar_painter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('select_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/select_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('select_all_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/select_all_text_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('select_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/select_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selectable_region_selection_status_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selectable_region_selection_status_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selectable_region_selection_status_test.dart', () async {
      // 1944 TODO C.104 (2026-06-01): historical 20260523-1056 §1.8/E35
      // cold-start-contention wrapper REMOVED. Same shape as C.102
      // (inline `httpBuildTimeout: 50s` + outer `Timeout: 60s`), not
      // the `_slowTestTimeout` shape. Script runs in ~2.3 s under
      // isolated retest (httpMs=1826, totalMs=2320, frameworkErrors=0,
      // sourceBytes=75123, sourceChars=75121, bundleJsonBytes=882140
      // — 75 KB script / 882 KB bundle / 2150-line; outputLines=45 —
      // rich coverage). Defaults apply.
      final result = await SendTestRunner.send(
        'widgets/selectable_region_selection_status_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selectable_region_state_test.dart', () async {
      // 1944 TODO C.105 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` REMOVED. Script runs in ~2.1 s
      // under isolated retest (httpMs=1613, totalMs=2055,
      // frameworkErrors=0, sourceBytes=72013, sourceChars=71935,
      // bundleJsonBytes=825058 — 72 KB / 825 KB bundle; outputLines=
      // 1). Defaults apply.
      final result = await SendTestRunner.send(
        'widgets/selectable_region_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_container_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_container_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_details_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_details_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_listener_notifier_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_listener_notifier_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_registrar_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/selection_registrar_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_debugger_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/semantics_debugger_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('semantics_gesture_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/semantics_gesture_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sensitive_content_host_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sensitive_content_host_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sensitive_content_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/sensitive_content_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shortcut_activator_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcut_activator_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shortcut_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcut_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shortcut_map_property_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcut_map_property_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shortcut_registrar_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcut_registrar_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shortcut_registry_entry_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcut_registry_entry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('shortcut_registry_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/shortcut_registry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
