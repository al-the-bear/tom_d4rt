/// Fa5 isolation harness — InheritedWidget / InheritedModel runtimeType
/// collapse reproducer. See
/// `doc/testlog_20260428-1333-issue-analysis/error_analysis.md` (Fa5).
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

  for (final script in const <String>[
    'repro_fa5/canary_must_fail.dart',
    'repro_fa5/inherited_widget_exact_type.dart',
    'repro_fa5/inherited_model_inherit_from.dart',
  ]) {
    test('[fa5] $script', () async {
      final result = await SendTestRunner.send(script);
      print(
        'FA5 STATUS: ${result.success}  FE: ${result.frameworkErrors.length}  SCRIPT: $script',
      );
      for (final err in result.frameworkErrors) {
        print('  ERR: $err');
      }
      for (final line in result.output) {
        if (line.contains('[fa5-')) {
          print('  STDOUT: $line');
        }
      }
    });
  }
}
