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
    'widgets/restorable_bool_test.dart',
    'widgets/restorable_date_time_test.dart',
    'widgets/restorable_double_test.dart',
    'widgets/restorable_double_n_test.dart',
    'widgets/restorable_int_test.dart',
    'widgets/restorable_int_n_test.dart',
    'widgets/restorable_listenable_test.dart',
    'widgets/restorable_num_test.dart',
    'widgets/restorable_num_n_test.dart',
    'widgets/restorable_route_future_test.dart',
    'widgets/restorable_string_test.dart',
    'widgets/restorable_string_n_test.dart',
    'widgets/restoration_mixin_test.dart',
  ]) {
    test('$script (C10)', () async {
      final result = await SendTestRunner.send(script);
      print('STATUS: ${result.success}');
      print('FRAMEWORK_ERRORS: ${result.frameworkErrors}');
      print('OUTPUT_COUNT: ${result.output.length}');
    });
  }
}
