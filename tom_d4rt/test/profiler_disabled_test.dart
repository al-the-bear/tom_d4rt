import 'package:tom_d4rt/d4rt.dart';
import 'package:test/test.dart';

/// Guard tests for the init-path profiler (PERF step #7 — "trim
/// profiler/timeline instrumentation overhead").
///
/// The interpreter carries no `Timeline.startSync`/`TimelineTask`
/// instrumentation on the hot path; the only timing sites are the
/// [D4rtProfiler] init-path spans, every one of which is written behind an
/// `if (D4rtProfiler.enabled)` guard (or a `D4rtProfiler.enabled ? … : null`
/// ternary). Because [D4rtProfiler.enabled] is a `static const bool`, those
/// guards are constant-folded away (VM TFA / AOT / dart2js) when the flag is
/// `false` — no `Stopwatch` allocation, no `record` call, no map lookup.
///
/// Two invariants lock this in:
///  1. [D4rtProfiler.enabled] is `false` in committed code (never ship the
///     instrumentation live).
///  2. With the flag `false`, executing a real script records **zero** spans —
///     the runtime-observable consequence of the guards being dead-code
///     eliminated. If a future edit added an *unguarded* `record` call, this
///     test would catch it (spans would accumulate even with the flag off).
void main() {
  test('D4rtProfiler.enabled is false (never publish with profiling on)', () {
    expect(
      D4rtProfiler.enabled,
      isFalse,
      reason:
          'D4rtProfiler.enabled must be false in committed code — '
          'revert any local profiling switch before committing.',
    );
  });

  test(
    'no profiler spans accumulate when disabled (guards are compiled out)',
    () {
      D4rtProfiler.reset();
      expect(
        D4rtProfiler.hasData,
        isFalse,
        reason: 'reset clears any spans left by other tests',
      );

      // A full execute exercises every guarded site: finalizeBridges, warmParent,
      // module-loader build, parse, pass1, visitorBuild, pass2.
      D4rt().execute(source: 'int main() => 1;');

      expect(
        D4rtProfiler.hasData,
        isFalse,
        reason:
            'with enabled == false every record() site is dead-code '
            'eliminated, so a real execute records no spans; a non-empty '
            'snapshot here means an unguarded profiler call slipped in.',
      );
      expect(D4rtProfiler.snapshot(), isEmpty);
    },
  );
}
