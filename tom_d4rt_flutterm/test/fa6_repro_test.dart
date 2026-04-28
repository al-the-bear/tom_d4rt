/// Fa6 isolation harness — composite render-object proxy reproducer.
/// See `doc/testlog_20260428-1333-issue-analysis/error_analysis.md` (Fa6).
///
/// Three scripts:
///   - canary_must_fail.dart           : verifies harness records FE>0 for
///                                       child build throws (calibration).
///   - two_mixin_container_render_box  : exercises hand-written
///                                       `_InterpretedRenderBoxContainer`
///                                       (Container + Defaults — Option 1
///                                       coverage).
///   - three_mixin_relayout_container  : extends the 2-mixin shape with
///                                       `RelayoutWhenSystemFontsChangeMixin`
///                                       and asserts the proxy still
///                                       satisfies `is
///                                       RelayoutWhenSystemFontsChangeMixin`.
///                                       This is the Option-2 motivator:
///                                       hardcoded proxies don't compose
///                                       arbitrary mixins.
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
    'repro_fa6/canary_must_fail.dart',
    'repro_fa6/two_mixin_container_render_box.dart',
    'repro_fa6/three_mixin_relayout_container.dart',
  ]) {
    test('[fa6] $script', () async {
      final result = await SendTestRunner.send(script);
      print(
        'FA6 STATUS: ${result.success}  FE: ${result.frameworkErrors.length}  SCRIPT: $script',
      );
      for (final err in result.frameworkErrors) {
        print('  ERR: $err');
      }
      for (final line in result.output) {
        if (line.contains('[fa6-')) {
          print('  STDOUT: $line');
        }
      }
    });
  }
}
