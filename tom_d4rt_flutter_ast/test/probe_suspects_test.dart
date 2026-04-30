/// Probe suspect retest scripts individually to capture exact errors.
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

  for (final script in [
    'retest/widgets/box_scroll_view_test.dart',
    'retest/widgets/context_action_test.dart',
    'retest/widgets/default_selection_style_test.dart',
    'retest/widgets/default_text_editing_shortcuts_test.dart',
    'retest/widgets/live_text_input_status_test.dart',
  ]) {
    test('probe: $script', () async {
      final result = await SendTestRunner.send(
        script,
        waitBeforeClear: const Duration(seconds: 5),
      );
      // Always print full details — we want to see the errors.
      print('--- $script ---');
      print('success: ${result.success}');
      print('error: ${result.error}');
      print('frameworkErrors: ${result.frameworkErrors}');
      // Don't assert success — just collect info.
    });
  }
}
