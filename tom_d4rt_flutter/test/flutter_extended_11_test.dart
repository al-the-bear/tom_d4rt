/// Auto-split extended bridge tests (file 11).
///
/// Generated from hardly-relevant/timeout/blocking/generator corpus; groups
/// kept verbatim, duplicates removed, ~50 tests per file. Own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_extended_11_test.dart';

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
  // SERVICES PACKAGE (90 files)
  // ============================================================
  group('services/', () {
    test('android_motion_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/android_motion_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('android_pointer_coords_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/android_pointer_coords_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('android_pointer_properties_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/android_pointer_properties_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('application_switcher_description_test.dart', () async {
      // 1944 TODO C.86 (2026-06-01): historical 20260523-1056 §1.6/E27
      // (ast) + §2.D contention (test) cold-start-contention wrapper
      // REMOVED. TEST sibling of C.79 (AST). Script runs in ~2.7 s
      // under isolated retest (httpMs=2422, totalMs=2686,
      // frameworkErrors=0, sourceChars=85583 — 86 KB / 2630-line).
      // Defaults (25 s httpBuildTimeout + 30 s dart-test) apply.
      final result = await SendTestRunner.send(
        'services/application_switcher_description_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/autofill_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_hints_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/autofill_hints_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_scope_mixin_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/autofill_scope_mixin_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('background_isolate_binary_messenger_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/background_isolate_binary_messenger_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('binary_messenger_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/binary_messenger_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('class_test.dart', () async {
      final result = await SendTestRunner.send('services/class_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('content_sensitivity_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/content_sensitivity_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('deferred_component_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/deferred_component_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('delta_text_input_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/delta_text_input_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('device_orientation_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/device_orientation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('floating_cursor_drag_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/floating_cursor_drag_state_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('g_l_f_w_key_helper_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/g_l_f_w_key_helper_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('gtk_key_helper_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/gtk_key_helper_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_copy_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_copy_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_custom_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_custom_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_cut_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_cut_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_live_text_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_live_text_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_look_up_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_look_up_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_paste_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_paste_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_search_web_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_search_web_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_select_all_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_select_all_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_share_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_share_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('i_o_s_system_context_menu_item_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/i_o_s_system_context_menu_item_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_data_transit_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_data_transit_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_down_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_down_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_event_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_event_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_event_test.dart', () async {
      final result = await SendTestRunner.send('services/key_event_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_helper_test.dart', () async {
      final result = await SendTestRunner.send('services/key_helper_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_message_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_message_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_repeat_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_repeat_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('key_up_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/key_up_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyboard_key_test.dart', () async {
      // 1944 TODO C.87 (2026-06-01): historical 20260523-1056 §1.6/E28
      // (ast) + §2.D contention (test) cold-start-contention wrapper
      // REMOVED. TEST sibling of C.80 (AST). Script runs in ~2.2 s
      // under isolated retest (httpMs=1983, totalMs=2220,
      // frameworkErrors=0, sourceChars=56723 — 57 KB / 1803-line).
      // Defaults (25 s httpBuildTimeout + 30 s dart-test) apply.
      final result = await SendTestRunner.send(
        'services/keyboard_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyboard_lock_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/keyboard_lock_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('keyboard_side_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/keyboard_side_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('max_length_enforcement_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/max_length_enforcement_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('message_codec_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/message_codec_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('method_codec_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/method_codec_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('missing_plugin_exception_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/missing_plugin_exception_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('modifier_key_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/modifier_key_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('mouse_cursor_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/mouse_cursor_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('mouse_cursor_session_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/mouse_cursor_session_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('mouse_tracker_annotation_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/mouse_tracker_annotation_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_exception_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/platform_exception_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_floating_cursor_point_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_floating_cursor_point_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_down_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_down_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_android_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_android_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_fuchsia_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_fuchsia_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_ios_test.dart', () async {
      // 1944 TODO C.88 (2026-06-01): historical 20260523-1056 §1.6/E29
      // (ast) + §2.D contention (test) cold-start-contention wrapper
      // REMOVED. TEST sibling of C.81 (AST). Script runs in ~2.3 s
      // under isolated retest (httpMs=2086, totalMs=2317,
      // frameworkErrors=0, sourceChars=64723 — 65 KB / 1939-line).
      // Defaults (25 s httpBuildTimeout + 30 s dart-test) apply.
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_ios_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_linux_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_linux_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_mac_os_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_mac_os_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_web_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_web_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_data_windows_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_data_windows_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_key_up_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_key_up_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('raw_keyboard_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/raw_keyboard_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
