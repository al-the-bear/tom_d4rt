/// SCD74 — `onUncaughtError` has to cover BOTH of this package's execution
/// paths, because it has two and they do not share a seam.
///
/// `D4rt` here is a facade over an inner `D4rtRunner`. `executeBundle`
/// delegates to it; the classic `execute()` does not — it carries its own
/// `_executeInEnvironment`, because it runs against the analyzer front end's
/// `ModuleLoader` rather than a pre-resolved bundle. So the execution seam
/// exists in **three** copies (`tom_d4rt`, `tom_d4rt_ast`, here), and the
/// "keep the twins in sync" rule as usually stated names only two of them.
///
/// A hook wired to one path would be a public API that looks covered and is
/// not — the exact failure the SCC23 suite exists to catch, relocated into the
/// API surface. Hence F-SCD74-1 and -2: one test per path, neither of which the
/// other can stand in for.
///
/// ## The one asymmetry, pinned rather than hidden
///
/// SCD73 made the *unwrapping* unconditional, so a no-hook embedder with its own
/// `runZonedGuarded` also receives the thrown value. That change is mirrored
/// into this package's own seam, so the classic path has it today — but the
/// bundle path's seam lives in the **published** `tom_d4rt_ast` this package
/// resolves (DGUC6), currently 0.65.0, which predates SCD73. Measured:
///
/// | path            | hook set        | no hook                            |
/// | --------------- | --------------- | ---------------------------------- |
/// | `execute()`     | `StateError`    | `StateError`                       |
/// | `executeBundle` | `StateError`    | `InternalInterpreterD4rtException` |
///
/// The column this todo is about — the hook — agrees. F-SCD74-4 asserts that
/// agreement, and F-SCD74-5 asserts the remaining difference, so the day the
/// publish lands and the constraint is raised, F-SCD74-5 goes red and says so
/// instead of the divergence closing silently. Tracked as sce119_aiml.
///
/// ## Control
///
/// Measured against this file plus the 16 ported SCC23 cases (21 together).
/// Removing `_runner.onUncaughtError = hook` from the setter: **19 pass, 2
/// fail** — F-SCD74-2 and -4, the two that touch the bundle path. Making
/// `_executeInEnvironment` return `run()` before it forks: **7 pass, 14 fail**.
///
/// **F-SCD74-3 has a blind spot, recorded because it reads like a control and
/// is not one.** With the forwarder removed it still PASSES: no hook ever
/// reaches the runner, so "the hook was cleared" is trivially true. It
/// discriminates a setter that forwards on assignment but not on clear — a
/// stale closure held after the embedder said stop — and nothing else.
library;

import 'dart:async';

import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:test/test.dart';

/// A script whose `Stream.listen` handler throws — an escape the platform
/// invokes, outside the script's own future chain.
const _escapingScript = '''
  import 'dart:async';
  main() async {
    final c = StreamController();
    c.stream.listen((v) { throw StateError('od'); });
    c.sink.add(1);
    await Future.delayed(Duration(milliseconds: 10));
    return 'script-completed';
  }
''';

/// Runs [_escapingScript] through the classic `execute()` path.
Future<(Object? result, List<Object> escapes)> viaExecute({
  void Function(Object, StackTrace)? hook,
}) async {
  final escapes = <Object>[];
  final d4rt = D4rt()..setDebug(false);
  d4rt.onUncaughtError = hook ?? (error, _) => escapes.add(error);
  final raw = d4rt.execute(
    library: 'package:test/main.dart',
    sources: {'package:test/main.dart': _escapingScript},
  );
  final result = raw is Future ? await raw : raw;
  await Future.delayed(const Duration(milliseconds: 60));
  return (result, escapes);
}

/// Runs [_escapingScript] through the bundle path, which delegates to the
/// inner runner.
Future<(Object? result, List<Object> escapes)> viaBundle({
  void Function(Object, StackTrace)? hook,
}) async {
  final escapes = <Object>[];
  final d4rt = D4rt()..setDebug(false);
  d4rt.onUncaughtError = hook ?? (error, _) => escapes.add(error);
  final bundle = await d4rt.createBundleFromSource(_escapingScript);
  final raw = d4rt.executeBundle(bundle);
  final result = raw is Future ? await raw : raw;
  await Future.delayed(const Duration(milliseconds: 60));
  return (result, escapes);
}

void main() {
  group('SCD74: the hook reaches both execution paths', () {
    test(
      'F-SCD74-1: an escape from the classic execute() path reaches the hook '
      '[2026-09-13]',
      () async {
        final (result, escapes) = await viaExecute();
        expect(result, 'script-completed');
        expect(escapes, hasLength(1));
        expect(escapes.single, isA<StateError>());
        expect((escapes.single as StateError).message, 'od');
      },
    );

    test('F-SCD74-2: an escape from the executeBundle() path reaches the hook '
        '[2026-09-13]', () async {
      // The forwarder. Before SCD74 the setter did not exist at all; wiring
      // it to only this package's own seam would have left this case silent,
      // because the bundle path never enters that seam.
      final (result, escapes) = await viaBundle();
      expect(result, 'script-completed');
      expect(
        escapes,
        hasLength(1),
        reason:
            'the setter assigns the inner runneric hook too — this path has '
            'no other way to reach an embedder',
      );
      expect(escapes.single, isA<StateError>());
      expect((escapes.single as StateError).message, 'od');
    });

    test(
      'F-SCD74-3: clearing the hook clears it on both paths [2026-09-13]',
      () async {
        // A setter that forwarded on assignment but not on clear would leave
        // the runner holding a stale closure — the embedder's, after the
        // embedder said to stop. Asserted behaviourally because the inner
        // runner is private: with no hook the escape reaches the enclosing
        // zone instead.
        final zoneErrors = <Object>[];
        final finished = Completer<Object?>();
        runZonedGuarded(() async {
          final d4rt = D4rt()..setDebug(false);
          d4rt.onUncaughtError = (_, _) => fail('hook was not cleared');
          d4rt.onUncaughtError = null;
          expect(d4rt.onUncaughtError, isNull);
          final bundle = await d4rt.createBundleFromSource(_escapingScript);
          final raw = d4rt.executeBundle(bundle);
          finished.complete(raw is Future ? await raw : raw);
        }, (error, _) => zoneErrors.add(error));

        expect(await finished.future, 'script-completed');
        await Future.delayed(const Duration(milliseconds: 60));
        expect(zoneErrors, hasLength(1));
      },
    );

    test(
      'F-SCD74-4: both paths hand the hook the identical shape [2026-09-13]',
      () async {
        // The property that makes the hook usable at all: an embedder writes
        // one handler and must not have to ask which entry point produced the
        // error. This is what "two-part, one commit" in the todo was protecting.
        final (_, fromExecute) = await viaExecute();
        final (_, fromBundle) = await viaBundle();

        expect(fromExecute.single.runtimeType, fromBundle.single.runtimeType);
        expect(
          '${fromExecute.single}',
          '${fromBundle.single}',
          reason: 'same script, same failure, same rendering',
        );
      },
    );

    test('F-SCD74-5: the no-hook paths do NOT yet agree, and this is why '
        '[2026-09-13]', () async {
      // PUBLISH-PIN(sce119_aiml-exec-carries-a-fourth-unwrap-copy-until-the-ast-publish-lands): the bundle
      // path's seam lives in the PUBLISHED tom_d4rt_ast (0.65.0, which
      // predates SCD73), while this package's own seam carries the fix. So the
      // two paths disagree for as long as the constraint names 0.65.0, and
      // this case asserts the disagreement rather than the contract.
      //
      // SCD103 turned the prose that used to sit here into that marker. The
      // difference is not cosmetic: F-SCD103-1 now reads the named todo's
      // STATUS, so the day sce119 is marked complete this file goes red and
      // names itself, instead of relying on somebody remembering. Invert the
      // assertion then.
      Future<List<Object>> noHook(Future<Object?> Function(D4rt) run) async {
        final zoneErrors = <Object>[];
        final finished = Completer<Object?>();
        runZonedGuarded(() async {
          finished.complete(await run(D4rt()..setDebug(false)));
        }, (error, _) => zoneErrors.add(error));
        await finished.future;
        await Future.delayed(const Duration(milliseconds: 60));
        return zoneErrors;
      }

      final classic = await noHook((d4rt) async {
        final raw = d4rt.execute(
          library: 'package:test/main.dart',
          sources: {'package:test/main.dart': _escapingScript},
        );
        return raw is Future ? await raw : raw;
      });
      final bundle = await noHook((d4rt) async {
        final b = await d4rt.createBundleFromSource(_escapingScript);
        final raw = d4rt.executeBundle(b);
        return raw is Future ? await raw : raw;
      });

      expect(
        classic.single,
        isA<StateError>(),
        reason: "this package's own seam carries SCD73",
      );
      expect(
        bundle.single,
        isA<InternalInterpreterD4rtException>(),
        reason:
            'the bundle path runs the interpreter this package RESOLVES, not '
            'the one in the sibling working tree — DGUC6, and the reason exec '
            'exists',
      );
    });
  });
}
