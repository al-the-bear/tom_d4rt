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
    // C6b — ThemeExtension nested generic coercion in relaxer
    // (`Iterable<ThemeExtension<ThemeExtension<dynamic>>>` parameter).
    'retest/material/theme_extension_test.dart',
  ]) {
    test(script, () async {
      final result = await SendTestRunner.send(script);
      print('STATUS: ${result.success}');
      print('FRAMEWORK_ERRORS: ${result.frameworkErrors}');
      print('OUTPUT_COUNT: ${result.output.length}');
    });
  }
}
