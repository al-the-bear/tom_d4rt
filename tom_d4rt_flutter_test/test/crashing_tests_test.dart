/// Tests that crash the test app.
///
/// These tests have been moved here because they cause the Flutter test app
/// to crash (Lost connection to device), which prevents subsequent tests from
/// running.
///
/// These tests use the SendTestRunner to send D4rt scripts to the test app
/// and verify they execute correctly. Each test corresponds to a script
/// in the send_ast_via_http_scripts directory.
///
/// Prerequisites:
/// 1. Run tests: flutter test test/crashing_tests_test.dart
///
/// The test app is started automatically in setUpAll and stopped in tearDownAll
/// when needed.
///
/// Total: 2 test entries (moved from other test files due to crashes)
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

  group('widgets/ individual (crashing)', () {
    // Moved from secondary_classes_test.dart - crashes the test app
    test('directionality_test.dart (from secondary_classes)', () async {
      final result = await SendTestRunner.send(
        'widgets/directionality_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });

    // Moved from hardly_relevant_classes_4_test.dart - crashes the test app
    test(
      'extend_selection_to_line_break_intent_test.dart (from hardly_relevant_classes_4)',
      () async {
        final result = await SendTestRunner.send(
          'widgets/extend_selection_to_line_break_intent_test.dart',
        );
        expect(result.success, isTrue, reason: result.error);
      },
    );

    // Moved from secondary_classes_test.dart - crashes the test app
    test('display_feature_sub_screen_test.dart (from secondary_classes)', () async {
      final result = await SendTestRunner.send(
        'widgets/display_feature_sub_screen_test.dart',
      );
      expect(result.success, isTrue, reason: result.error);
    });
  });
}
