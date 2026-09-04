import 'package:tom_d4rt_ast/runtime.dart';
import 'package:test/test.dart';

/// Guard tests for the init-path profiler (PERF step #7 — "trim
/// profiler/timeline instrumentation overhead"), mirror of `tom_d4rt`'s
/// `profiler_disabled_test.dart`.
///
/// The analyzer-free runtime carries no `Timeline.startSync`/`TimelineTask`
/// instrumentation on the hot path; the only timing sites are the
/// [D4rtProfiler] init-path spans, every one of which is written behind an
/// `if (D4rtProfiler.enabled)` guard (or a `D4rtProfiler.enabled ? … : null`
/// ternary). Because [D4rtProfiler.enabled] is a `static const bool`, those
/// guards are constant-folded away when the flag is `false`.
///
/// Two invariants lock this in:
///  1. [D4rtProfiler.enabled] is `false` in committed code.
///  2. With the flag `false`, executing a real bundle records **zero** spans —
///     the runtime-observable consequence of the guards being dead-code
///     eliminated. An unguarded `record` call would make spans accumulate even
///     with the flag off, and this test would catch it.
void main() {
  /// Minimal bundle: `int main() => 1;` with no imports — enough to drive the
  /// guarded warmParent / pass1 / visitorBuild / pass2 sites.
  AstBundle trivialBundle() {
    final mainFn = SFunctionDeclaration(
      offset: 0,
      length: 0,
      name: SSimpleIdentifier(offset: 0, length: 4, name: 'main'),
      functionExpression: SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: SFormalParameterList(offset: 0, length: 0),
        body: SBlockFunctionBody(
          offset: 0,
          length: 0,
          block: SBlock(
            offset: 0,
            length: 0,
            statements: [
              SReturnStatement(
                offset: 0,
                length: 0,
                expression: SIntegerLiteral(offset: 0, length: 1, value: 1),
              ),
            ],
          ),
        ),
      ),
    );
    final unit = SCompilationUnit(
      offset: 0,
      length: 0,
      directives: [],
      declarations: [mainFn],
    );
    return AstBundle(
      entryPointUri: 'package:t/main.dart',
      modules: {'package:t/main.dart': unit},
    );
  }

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

      D4rtRunner().executeBundleAs<int>(trivialBundle());

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
