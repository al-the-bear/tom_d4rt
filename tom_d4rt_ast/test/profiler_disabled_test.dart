import 'package:tom_d4rt_ast/runtime.dart';
import 'package:test/test.dart';

/// Guard test: [D4rtProfiler.enabled] MUST be `false` in any committed /
/// published version. The init-path instrumentation is compile-time gated on
/// this flag; leaving it `true` would ship the profiling overhead. Flip it to
/// `true` only for a local profiling session and revert before committing.
void main() {
  test('D4rtProfiler.enabled is false (never publish with profiling on)', () {
    expect(D4rtProfiler.enabled, isFalse,
        reason: 'D4rtProfiler.enabled must be false in committed code — '
            'revert any local profiling switch before committing.');
  });
}
