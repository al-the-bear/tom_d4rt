/// Cluster B reproduction — confirm `widgets/decoratedbox_test.dart`
/// (DiagonalStripesDecoration extends Decoration) fails with the
/// "InterpretedInstance not accepted by Flutter constructor" symptom,
/// and capture the exact error string.
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

  test('[Cluster B] widgets/decoratedbox_test.dart', () async {
    final result = await SendTestRunner.send('widgets/decoratedbox_test.dart');
    print('STATUS: ${result.success}  FE: ${result.frameworkErrors.length}');
    print('ERROR: ${result.error}');
    if (result.frameworkErrors.isNotEmpty) {
      for (final fe in result.frameworkErrors) {
        print('FW: $fe');
      }
    }
  });
}
