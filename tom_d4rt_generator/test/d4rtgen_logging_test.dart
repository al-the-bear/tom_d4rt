import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/d4rtgen_logging.dart';

void main() {
  group('d4rtgen invocation logging', () {
    test(
      'G-DLOG-01: Source carries no hardcoded developer log path. '
      '[2026-06-28] (PASS)',
      () {
        // Issue #3 class of defect: the logger used to bake in
        // `/Users/alexiskyaw/.../tom2/d4rtgen_invocations.log`, which failed
        // and printed a warning on every other machine. The source must not
        // contain any absolute developer path.
        final source = File(
          'lib/src/d4rtgen_logging.dart',
        ).readAsStringSync();
        expect(source, isNot(contains('/Users/')));
      },
    );

    test(
      'G-DLOG-02: Logging is disabled (no-op) when the env var is unset. '
      '[2026-06-28] (PASS)',
      () {
        // With D4RTGEN_INVOCATION_LOG unset the summary reports disabled and
        // no file is written. The test process does not set the variable.
        expect(
          Platform.environment.containsKey('D4RTGEN_INVOCATION_LOG'),
          isFalse,
          reason: 'Test must run without the opt-in env var set',
        );
        // These must not throw and must be no-ops.
        clearD4rtgenLog();
        logD4rtgenInvocation(source: 'API', details: 'unit-test');
        expect(getD4rtgenLogSummary(), contains('disabled'));
      },
    );
  });
}
