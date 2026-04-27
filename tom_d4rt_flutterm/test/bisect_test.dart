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
    // D6 — Layout cascade (script-only). Each entry should report
    // frameworkErrors=0 after the C22-style ListView/MainAxisSize.min
    // patches land. scrollbar_painter still has 4 RenderFlex overflow
    // FEs (script authoring follow-up, separate from the cascade).
    'widgets/scroll_increment_details_test.dart',
    'widgets/scrollbar_painter_test.dart',
    'widgets/restorable_bool_test.dart',
  ]) {
    test(script, () async {
      final result = await SendTestRunner.send(script);
      print('STATUS: ${result.success}');
      print('FRAMEWORK_ERRORS: ${result.frameworkErrors}');
      print('OUTPUT_COUNT: ${result.output.length}');
    });
  }
}
