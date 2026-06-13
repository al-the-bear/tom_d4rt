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
      // 1944 TODO C.115 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` REMOVED. No AST sibling —
      // TEST-only entry. Script runs in ~1.6 s under isolated retest
      // (httpMs=1406, totalMs=1636, frameworkErrors=0, sourceChars=
      // 40489 — 40 KB restorable-listenable widget test;
      // outputLines=2 — rich coverage). Defaults apply.
      final result = await SendTestRunner.send(
        'widgets/restorable_listenable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restorable_num_n_test.dart', () async {
      // 1944 TODO C.116 (2026-06-01): historical 20260523-1056 §1.8/E34
      // (ast) + §2.D contention (test) cold-start-contention wrapper
      // REMOVED. TEST sibling of C.102 (AST). Inline `httpBuildTimeout:
      // 50s` + outer `Timeout: 60s` shape — first TEST entry of
      // §C.viii that uses the inline-E-series wrapper rather than
      // `_slowTestTimeout`. Script runs in ~2.6 s under isolated
      // retest (httpMs=2415, totalMs=2643, frameworkErrors=0,
      // sourceChars=56761 — 57 KB / 1734-line; outputLines=1).
      // Defaults (25 s httpBuildTimeout + 30 s dart-test) apply,
      // matching the AST sibling C.102.
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
      // 1944 TODO C.117 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` REMOVED. No AST sibling —
      // TEST-only entry. Script runs in ~2.1 s under isolated retest
      // (httpMs=1910, totalMs=2128, frameworkErrors=0, sourceChars=
      // 67991 — 68 KB scroll-activity-delegate widget test).
      // Defaults apply.
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
      // 1944 TODO C.118 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` REMOVED. No AST sibling —
      // TEST-only entry. Script runs in ~2.5 s under isolated retest
      // (httpMs=2309, totalMs=2542, frameworkErrors=0,
      // sourceChars=67760 — 68 KB scroll-to-document-boundary-intent
      // widget test). Defaults apply.
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
      // 1944 TODO C.119 (2026-06-01): historical 20260523-1056 §1.8/E35
      // (ast) + §2.D contention (test) cold-start-contention wrapper
      // REMOVED. TEST sibling of C.104 (AST). Inline `httpBuildTimeout:
      // 50s` + outer `Timeout: 60s` shape — second TEST entry of
      // §C.viii that uses the inline-E-series shape after C.116.
      // Script runs in ~2.2 s under isolated retest (httpMs=1944,
      // totalMs=2174, frameworkErrors=0, sourceChars=75121 — 75 KB
      // / 2150-line; outputLines=45 — rich coverage). Defaults
      // apply, matching the AST sibling C.104.
      final result = await SendTestRunner.send(
        'widgets/selectable_region_selection_status_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selectable_region_state_test.dart', () async {
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
      // 1944 TODO C.120 (2026-06-01): historical 20260528-2206 TODO #4
      // follow-up `_slowTestTimeout` REMOVED. No AST sibling —
      // TEST-only entry. Script runs in ~2.0 s under isolated retest
      // (httpMs=1742, totalMs=1975, frameworkErrors=0,
      // sourceChars=39540 — 40 KB semantics-debugger widget test;
      // outputLines=14 — rich coverage). Defaults apply.
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
