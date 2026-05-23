/// Cluster F #11 reproduction — `foundation/text_tree_configuration_test.dart`
/// raised `Runtime Error: Cannot invoke method 'toStringDeep' on null`
/// because `_SampleScene extends DiagnosticableTree` and the bridged
/// `toDiagnosticsNode` validates its receiver via `D4.validateTarget`,
/// which rejects an `InterpretedInstance` even when the script class
/// declares `extends DiagnosticableTree`. Same architectural family as
/// U10 in `doc/interpreter_unfixable.md`. The script-side fix replaces
/// `toDiagnosticsNode().toStringDeep()` with a manual sparse-tree
/// renderer.
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

  test('[Cluster F #11] foundation/text_tree_configuration_test.dart',
      () async {
    final result =
        await SendTestRunner.send('foundation/text_tree_configuration_test.dart');
    print('STATUS: ${result.success}  FE: ${result.frameworkErrors.length}');
    print('ERROR: ${result.error}');
    if (result.frameworkErrors.isNotEmpty) {
      for (final fe in result.frameworkErrors) {
        print('FW: $fe');
      }
    }
    expect(result.success, isTrue,
        reason: 'Script should render with manual sparse fallback per U10');
    expect(result.frameworkErrors, isEmpty,
        reason: 'No framework errors expected after manual-renderer rewrite');
  });
}
