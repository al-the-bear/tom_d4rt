/// Cluster E #10 reproduction — `services/codecs_test.dart` raised
/// `Runtime Error: Native error during bridged method call
/// 'decodeEnvelope' on StandardMethodCodec: PlatformException(
/// CAMERA_UNAVAILABLE, …)` because the d4rt interpreter wraps every
/// native exception in `RuntimeD4rtException`, defeating the script's
/// `on PlatformException catch (e)` clause (U13 in
/// `doc/interpreter_unfixable.md`). The script-side fix broadens the
/// catch and surfaces the wrapped message string.
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

  test('[Cluster E #10] services/codecs_test.dart error-envelope catch',
      () async {
    final result = await SendTestRunner.send('services/codecs_test.dart');
    print('STATUS: ${result.success}  FE: ${result.frameworkErrors.length}');
    print('ERROR: ${result.error}');
    if (result.frameworkErrors.isNotEmpty) {
      for (final fe in result.frameworkErrors) {
        print('FW: $fe');
      }
    }
    expect(result.success, isTrue,
        reason:
            'Error-envelope decode should be caught broadly per U13 workaround');
    expect(result.frameworkErrors, isEmpty,
        reason: 'No framework errors expected after script-side broad catch');
  });
}
