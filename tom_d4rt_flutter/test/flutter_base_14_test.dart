/// Auto-split base bridge tests (file 14).
///
/// Generated from essential/important/secondary corpus; groups kept verbatim,
/// duplicates removed, ~50 tests per file. Each file runs its own test app.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

const String _kTestFileName = 'flutter_base_14_test.dart';

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

  // --- SERVICES INDIVIDUAL SCRIPTS (35 files) ---
  group('services/ individual', () {
    test('android_view_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/android_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('app_kit_view_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/app_kit_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('asset_manifest_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/asset_manifest_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('asset_metadata_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/asset_metadata_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_configuration_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/autofill_configuration_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('autofill_scope_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/autofill_scope_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('browser_context_menu_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/browser_context_menu_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('caching_asset_bundle_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/caching_asset_bundle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('darwin_platform_view_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/darwin_platform_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('default_process_text_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/default_process_text_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('default_spell_check_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/default_spell_check_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('expensive_android_view_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/expensive_android_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('flutter_version_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/flutter_version_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('font_loader_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/font_loader_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('hybrid_android_view_controller_test.dart', () async {
      // 1944 TODO C.40 (2026-05-31): historical 20260523-1056 §1.3/E2
      // (ast) + §2.C contention (test) parallel-driver-contention
      // wrapper REMOVED. Script runs in ~1.6 s under normal load
      // (httpMs=1606, sourceChars=51698 — 52 KB / 1399-line script).
      final result = await SendTestRunner.send(
        'services/hybrid_android_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('live_text_test.dart', () async {
      final result = await SendTestRunner.send('services/live_text_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('network_asset_bundle_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/network_asset_bundle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_asset_bundle_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/platform_asset_bundle_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_view_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/platform_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_views_registry_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/platform_views_registry_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('platform_views_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/platform_views_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('predictive_back_event_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/predictive_back_event_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('process_text_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/process_text_action_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('process_text_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/process_text_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('restoration_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/restoration_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('scribe_test.dart', () async {
      final result = await SendTestRunner.send('services/scribe_test.dart');
      expect(result.success, isTrue, reason: result.error);
    });

    test('spell_check_service_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/spell_check_service_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('suggestion_span_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/suggestion_span_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('surface_android_view_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/surface_android_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('system_channels_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/system_channels_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('text_layout_metrics_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/text_layout_metrics_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('texture_android_view_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/texture_android_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('ui_kit_view_controller_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/ui_kit_view_controller_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('undo_manager_client_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/undo_manager_client_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    test('undo_manager_test.dart', () async {
      final result = await SendTestRunner.send(
        'services/undo_manager_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
