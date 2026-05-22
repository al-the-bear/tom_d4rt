/// Cluster B #6 reproduction — confirm `material/materialapp_test.dart`
/// (`_SimpleRouteParser extends RouteInformationParser`) and
/// `retest/widgets/app_kit_view_test.dart`
/// (`Set<Factory<OneSequenceGestureRecognizer>>` coercion) fail with the
/// "InterpretedInstance not accepted" / "cannot convert" symptoms, and
/// capture the exact error strings.
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

  test('[Cluster B #6 leg 1] material/materialapp_test.dart', () async {
    final result = await SendTestRunner.send('material/materialapp_test.dart');
    print('STATUS: ${result.success}  FE: ${result.frameworkErrors.length}');
    print('ERROR: ${result.error}');
    if (result.frameworkErrors.isNotEmpty) {
      for (final fe in result.frameworkErrors) {
        print('FW: $fe');
      }
    }
  });

  test('[Cluster B #6 leg 2] retest/widgets/app_kit_view_test.dart', () async {
    final result = await SendTestRunner.send(
      'retest/widgets/app_kit_view_test.dart',
    );
    print('STATUS: ${result.success}  FE: ${result.frameworkErrors.length}');
    print('ERROR: ${result.error}');
    if (result.frameworkErrors.isNotEmpty) {
      for (final fe in result.frameworkErrors) {
        print('FW: $fe');
      }
    }
  });
}
