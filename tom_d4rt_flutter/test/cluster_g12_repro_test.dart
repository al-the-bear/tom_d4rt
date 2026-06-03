/// Cluster G #12 reproduction — `foundation/notifier_test.dart` raised
/// `BridgedInstance<Object> not Color` under the source-based
/// (tom_d4rt) runner used by flutter_test, while the AST-based
/// (tom_d4rt_ast) runner in flutter_ast passes the same script.
///
/// Root cause: when assigning `colorNotifier.value = c` where the
/// right-hand side is a `Color` wrapped in a `BridgedInstance`,
/// tom_d4rt's interpreter forwards `rhsValue` directly to the bridged
/// setter adapter without unwrapping the `BridgedInstance` to the
/// native `Color`. The native `ValueNotifier<Color>.value` setter
/// then sees a `BridgedInstance<Object>` and the covariant store
/// throws.
///
/// tom_d4rt_ast applies the GEN-079 unwrap
/// (`rhsValue is BridgedInstance → rhsValue.nativeObject`) before
/// invoking the setter; tom_d4rt does not. This reproducer expects
/// the failure pre-fix; once the back-port lands, it must pass.
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

  test('[Cluster G #12] foundation/notifier_test.dart on flutter_test runner',
      () async {
    final result =
        await SendTestRunner.send('foundation/notifier_test.dart');
    print('STATUS: ${result.success}  FE: ${result.frameworkErrors.length}');
    print('ERROR: ${result.error}');
    if (result.frameworkErrors.isNotEmpty) {
      for (final fe in result.frameworkErrors) {
        print('FW: $fe');
      }
    }
    expect(result.success, isTrue,
        reason:
            'tom_d4rt must unwrap BridgedInstance for native setter calls (GEN-079 back-port)');
    expect(result.frameworkErrors, isEmpty,
        reason: 'No framework errors expected after GEN-079 back-port');
  });
}
