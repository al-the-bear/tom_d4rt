/// Auto-split extended bridge tests (file 12).
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
  // SERVICES PACKAGE (90 files)
  // ============================================================
  group('services/', () {
    test('restoration_bucket_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/restoration_bucket_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scribble_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/scribble_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_changed_cause_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/selection_changed_cause_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('selection_rect_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/selection_rect_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('sensitive_content_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/sensitive_content_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('services_service_extensions_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/services_service_extensions_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('smart_dashes_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/smart_dashes_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('smart_quotes_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/smart_quotes_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('swipe_edge_test.dart', () async {
      final result = await SendTestRunner.send('services/swipe_edge_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_context_menu_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_context_menu_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_context_menu_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_context_menu_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_sound_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_sound_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_ui_mode_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_ui_mode_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_ui_overlay_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_ui_overlay_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_capitalization_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_capitalization_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_delta_deletion_test.dart', () async {
      // 1944 TODO C.82 (2026-05-31): historical 20260523-1056 §1.6/E30
      // cold-start-contention wrapper REMOVED. Script runs in ~2.4 s
      // under normal load (httpMs=2394, bundleJsonBytes=532372 —
      // 532 KB bundle / 49 KB / 1477-line script).
      final result = await SendTestRunner.send(
        'services/text_editing_delta_deletion_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_delta_insertion_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_delta_insertion_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_delta_non_text_update_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_delta_non_text_update_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_delta_replacement_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_delta_replacement_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_editing_value_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_editing_value_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_connection_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_connection_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_control_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_control_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_test.dart', () async {
      final result = await SendTestRunner.send('services/text_input_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_input_type_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_input_type_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_delegate_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_selection_delegate_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_selection_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_selection_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('undo_direction_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/undo_direction_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
