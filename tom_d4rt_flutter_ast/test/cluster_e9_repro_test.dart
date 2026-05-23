/// Cluster E #9 reproduction — `foundation/key_test.dart` failed with
/// `Native error during static bridged method call Timer.run: RangeError
/// (length): Invalid value: Only valid value is 0: 1` because the
/// `Timer.run` bridge in `stdlib/async/timer.dart` indexed
/// `positionalArgs[1]` for a single-argument static method.
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

  test('[Cluster E #9] foundation/key_test.dart Timer.run bridge', () async {
    final result = await SendTestRunner.send('foundation/key_test.dart');
    print('STATUS: ${result.success}  FE: ${result.frameworkErrors.length}');
    print('ERROR: ${result.error}');
    if (result.frameworkErrors.isNotEmpty) {
      for (final fe in result.frameworkErrors) {
        print('FW: $fe');
      }
    }
    expect(result.success, isTrue,
        reason: 'Timer.run should accept its single callback arg');
  });
}
