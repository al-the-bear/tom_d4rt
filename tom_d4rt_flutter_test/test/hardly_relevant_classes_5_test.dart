/// Tests for hardly relevant Flutter bridge classes (part 5 of 5).
///
/// widgets package (p-z, second half)
///
/// These tests use the SendTestRunner to send D4rt scripts to the test app
/// and verify they execute correctly. Each test corresponds to a script
/// in the send_ast_via_http_scripts directory.
///
/// Prerequisites:
/// 1. Run tests: flutter test test/hardly_relevant_classes_5_test.dart
///
/// The test app is started automatically in setUpAll and stopped in tearDownAll
/// when needed.
///
/// Total: 228 test entries
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

/// testlog_20260528-2206 TODO #4 — mirror of flutter_ast. Bumped
/// per-test timeout for scripts that historically trip the Flutter
/// test framework's default 30 s wrapper. The source-direct
/// interpreter's cold-start parse + execute (§U25) is heavier than
/// the AST-bundle path so this project has more candidates.
const _slowTestTimeout = Timeout(Duration(seconds: 60));

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
    test('pop_navigator_router_delegate_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/pop_navigator_router_delegate_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('popup_window_controller_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/popup_window_controller_delegate_test.dart',
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
    }, timeout: _slowTestTimeout);

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

    test(
      'tree_sliver_state_mixin_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/tree_sliver_state_mixin_test.dart',
          // 20260523-1056 baseline §1.8/E36 (= §S/S4). Serial
          // isolated re-run produces 3.2 s with frameworkErrors=0.
          // Original cross-project TimeoutException was cold-start
          // contention, not a real wedge. Same family as
          // E1/E12/E25: 50 s leaves 10 s of headroom under the 60 s
          // dart-test wrapper. Applied symmetrically with the ast
          // variant.
          httpBuildTimeout: const Duration(seconds: 50),
        );
        expect(result.success, isTrue, reason: result.error);
      },
      timeout: const Timeout(Duration(seconds: 60)),
    );

    test(
      'tree_sliver_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/tree_sliver_test.dart',
          // 20260524-2003 baseline §6/T9 (= todo #8): cold-start
          // transport failure in hardly_5. Standard 25 s → 50 s cap +
          // 60 s wrapper.
          httpBuildTimeout: const Duration(seconds: 50),
        );
        expect(result.success, isTrue, reason: result.error);
      },
      timeout: const Timeout(Duration(seconds: 60)),
    );

    test('two_dimensional_child_builder_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_child_builder_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('two_dimensional_child_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_child_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('two_dimensional_child_list_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_child_list_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    }, timeout: _slowTestTimeout);

    test('two_dimensional_child_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_child_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('two_dimensional_scroll_view_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_scroll_view_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('two_dimensional_scrollable_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_scrollable_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('two_dimensional_scrollable_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_scrollable_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('two_dimensional_viewport_parent_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_viewport_parent_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('two_dimensional_viewport_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/two_dimensional_viewport_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('undo_history_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/undo_history_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('undo_history_value_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/undo_history_value_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('undo_text_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/undo_text_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('unfocus_disposition_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/unfocus_disposition_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('unique_widget_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/unique_widget_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('unmanaged_restoration_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/unmanaged_restoration_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test(
      'update_selection_intent_test.dart',
      () async {
        final result = await SendTestRunner.send(
          'widgets/update_selection_intent_test.dart',
          // 20260523-1056 baseline §1.8/E37 (ast) + §2.D contention
          // (test): Transport failure 25s — cold-start contention.
          // 1835-line / 62 KB script builds in ~1.4 s. Same family
          // as E1/E2/E11/E12/E16/E17/E22/E26/E29/E30/E33: 50 s
          // leaves 10 s of headroom under the 60 s dart-test
          // wrapper. Applied symmetrically with the ast variant.
          httpBuildTimeout: const Duration(seconds: 50),
        );
        expect(result.success, isTrue, reason: result.error);
      },
      timeout: const Timeout(Duration(seconds: 60)),
    );

    test('user_scroll_notification_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/user_scroll_notification_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    }, timeout: _slowTestTimeout);

    test('viewport_element_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/viewport_element_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('viewport_notification_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/viewport_notification_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('void_callback_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/void_callback_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('void_callback_intent_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/void_callback_intent_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('weak_map_test.dart', () async {
      final result = await SendTestRunner.send('widgets/weak_map_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('web_browser_detection_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/web_browser_detection_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_inspector_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_inspector_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_inspector_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_inspector_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_order_traversal_policy_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_order_traversal_policy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_state_border_side_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_state_border_side_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_state_color_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_state_color_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_state_mapper_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_state_mapper_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_state_mouse_cursor_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_state_mouse_cursor_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_state_outlined_border_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_state_outlined_border_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_state_property_all_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_state_property_all_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    }, timeout: _slowTestTimeout);

    test('widget_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_state_text_style_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_state_text_style_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_states_constraint_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_states_constraint_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widget_to_render_box_adapter_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widget_to_render_box_adapter_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets_localizations_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widgets_localizations_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('widgets_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/widgets_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('window_positioner_anchor_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/window_positioner_anchor_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('window_positioner_constraint_adjustment_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/window_positioner_constraint_adjustment_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('window_positioner_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/window_positioner_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('window_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/window_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('windowing_owner_linux_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/windowing_owner_linux_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('windowing_owner_mac_o_s_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/windowing_owner_mac_o_s_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('windowing_owner_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/windowing_owner_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('windowing_owner_win32_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/windowing_owner_win32_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
