/// Bisect test harness
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

  for (final script in <String>[
    'retest/widgets/default_text_editing_shortcuts_test.dart',
    'widgets/shortcut_activator_test.dart',
    'widgets/shortcut_manager_test.dart',
    'widgets/shortcut_map_property_test.dart',
  ]) {
    test('$script (C5)', () async {
      final result = await SendTestRunner.send(script);
      print('STATUS: ${result.success}');
      print('FRAMEWORK_ERRORS: ${result.frameworkErrors}');
      print('OUTPUT_COUNT: ${result.output.length}');
    });
  }
}
