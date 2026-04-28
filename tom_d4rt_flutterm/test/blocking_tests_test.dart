/// Blocking Tests — W1-W5 wedger isolation harness.
///
/// This test file groups the 5 scripts that have been skipped from
/// `generator_interpreter_retest_test.dart` (W1-W4) and
/// `generator_interpreter_issues_test.dart` (W5) because each of
/// them wedges the test-app process and causes a cascade of
/// timeouts in the surrounding suite.
///
/// Purpose: run the 5 wedgers together in their own dedicated
/// suite to see whether they pass when not embedded in a larger
/// run. If the suite-level cascade does not reproduce here, the
/// scripts are individually viable and the cascade is a
/// scaling/ordering artefact rather than a per-script bug.
///
/// W1: retest/widgets/context_action_test.dart
/// W2: retest/widgets/default_text_editing_shortcuts_test.dart
/// W3: retest/widgets/live_text_input_status_test.dart
/// W4: retest/widgets/lock_state_test.dart
/// W5: widgets/animated_switcher_test.dart  (NOT in retest/)
///
/// See doc/interpreter_issues.md (W1-W5 entries) and
/// doc/testlog_20260428-1333-issue-analysis/error_analysis.md
/// (cluster R / fix-clusters F1-F5) for the upstream diagnoses.
@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';

import 'send_test_runner.dart';

/// Helper to check that a test truly passes (success AND no framework errors).
void expectSuccess(SendResult result) {
  final errors = result.frameworkErrors.isNotEmpty
      ? result.frameworkErrors.join('; ')
      : null;
  final reason = result.error ?? errors;
  expect(result.success && !result.hasFrameworkErrors, isTrue, reason: reason);
}

void main() {
  setUpAll(() async {
    await SendTestRunner.setUp();
  });

  tearDownAll(() async {
    await SendTestRunner.tearDown();
  });

  group('Blocking tests - W1-W5 isolated', () {
    test('W1: retest/widgets/context_action_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/context_action_test.dart',
      );
      expectSuccess(result);
    });

    test('W2: retest/widgets/default_text_editing_shortcuts_test.dart',
        () async {
      final result = await SendTestRunner.send(
        'retest/widgets/default_text_editing_shortcuts_test.dart',
        waitBeforeClear: const Duration(seconds: 10),
      );
      expectSuccess(result);
    });

    test('W3: retest/widgets/live_text_input_status_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/live_text_input_status_test.dart',
        waitBeforeClear: const Duration(seconds: 10),
      );
      expectSuccess(result);
    });

    test('W4: retest/widgets/lock_state_test.dart', () async {
      final result = await SendTestRunner.send(
        'retest/widgets/lock_state_test.dart',
      );
      expectSuccess(result);
    });

    test('W5: widgets/animated_switcher_test.dart', () async {
      final result = await SendTestRunner.send(
        'widgets/animated_switcher_test.dart',
      );
      expectSuccess(result);
    });
  });
}
