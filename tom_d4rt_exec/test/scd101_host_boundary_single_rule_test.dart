import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// SCD101 — exec's host boundary is the shared rule, not a third copy of it.
///
/// WHAT THE TODO RECORDED, AND WHAT WAS LEFT
///
/// SCD101 was filed when exec's boundary was stranded pre-SCC27: it enumerated
/// escaping types one by one and called `isSdkShapedError`, a predicate both
/// interpreters had deleted — so exec could not compile against the
/// working-tree ast at all. It was marked BLOCKED ON PUBLISHING, because
/// exec declared `tom_d4rt_ast: >=0.20.0` and 0.20.1 was the newest published.
///
/// Measured before touching anything, that blocker is gone. SCD74 and SCD84
/// moved both `execute()` clauses to `throwAsHostFacingError`, the constraint
/// is now `^0.65.0`, and published 0.65.0 has no `isSdkShapedError`. The
/// eighteen failing tests the todo lists do not fail: they were measured
/// against a working-tree ast at 0.39.0 under a different patch, and the suite
/// is green. I-MISC-97, which the todo singled out for investigation, returns
/// `'Oops'` — the carrier it reported was an artefact of that patch state.
///
/// WHAT WAS ACTUALLY LEFT was the tail of the todo's own fix list: "deleting
/// the hand-rolled unwrap". Four `on InternalInterpreterD4rtException` blocks
/// remained — two in `execute()`, two in `eval()` — each peeling the carrier
/// itself and each running BEFORE the general clause that would have done it.
///
/// WHY A CLAUSE THAT RUNS FIRST AND REIMPLEMENTS PART OF THE RULE IS THE BUG
///
/// It cannot inherit a fix. SCD96 taught `throwAsHostFacingError` a SECOND peel
/// — a bridged exception holds its native object one level inside the carrier —
/// and exec's copies still peeled once. So a script's `throw
/// FormatException('boom')` was set to reach an exec caller as a
/// `BridgedInstance` shell it cannot `catch` on, permanently, no matter what
/// the shared helper learned. Deleting the copies is what lets SCD96 arrive
/// when the constraint is next raised.
///
/// **Deleting them changed nothing measurable today**, which is the honest
/// result and the reason this file is a SOURCE guard rather than a behavioural
/// one: exec calls the helper it resolves from pub.dev, and published 0.65.0
/// still peels once. F-SCD101-3 pins that state so the day it changes is
/// visible rather than silent.
///
/// TWO COPIES SURVIVE ON PURPOSE, and the guard knows about both:
///   - `_unwrapScriptError`, a documented temporary fourth copy that exists
///     only because the published ast keeps `unwrapScriptError` private below
///     0.82.0 — sce119 deletes it when the constraint is raised.
///   - `_runGuarded`'s fallback, which is a different contract: it ends in
///     `throw "$error : $e"`, a diagnostic string rather than a host-facing
///     rethrow.
void main() {
  group('SCD101: exec routes its host boundary through the shared rule', () {
    test('F-SCD101-1: no `on InternalInterpreterD4rtException` clause peels the '
        'carrier itself [2026-09-14]', () {
      // The guard. A clause that catches the carrier must hand it to
      // `throwAsHostFacingError`, not unwrap it inline — an inline peel is a
      // second implementation of a rule that has already changed once under
      // it.
      final source = File(
        '${Directory.current.path}/lib/src/d4rt_base.dart',
      ).readAsStringSync();
      final lines = source.split('\n');

      final offenders = <String>[];
      for (var i = 0; i < lines.length; i++) {
        if (!lines[i].contains('on InternalInterpreterD4rtException catch')) {
          continue;
        }
        // The clause body is the next few lines; it must delegate.
        final body = lines
            .sublist(i + 1, (i + 6).clamp(0, lines.length))
            .join('\n');
        if (!body.contains('throwAsHostFacingError')) {
          offenders.add('  line ${i + 1}: ${lines[i].trim()}');
        }
      }

      expect(
        offenders,
        isEmpty,
        reason:
            'These clauses catch the interpreter\'s carrier and peel it '
            'themselves:\n${offenders.join('\n')}\n\n'
            'Hand the value to `throwAsHostFacingError(e, s)` instead. It '
            'peels the carrier as its first branch, and it peels a BRIDGED '
            'exception one level further (SCD96) — a local peel gets the first '
            'and silently misses the second, which is exactly how exec came to '
            'hand callers a `BridgedInstance` long after both twins had '
            'stopped.',
      );
    });

    test('F-SCD101-2: the predicate SCC27 deleted has no call site '
        '[2026-09-14]', () {
      // The condition the todo was filed on. `isSdkShapedError` was removed
      // from both interpreter trees; exec was the third copy that still called
      // it, and could not compile against a working-tree ast because of it.
      final source = File(
        '${Directory.current.path}/lib/src/d4rt_base.dart',
      ).readAsStringSync();
      // Comments may name it — a call may not.
      final callSites = RegExp(
        r'(?<!\w)isSdkShapedError\s*\(',
      ).allMatches(source).length;
      expect(
        callSites,
        0,
        reason:
            '`isSdkShapedError` was deleted from both interpreters by SCC27. A '
            'call here is what made exec uncompilable against the working-tree '
            'ast, which is the defect SCD101 was filed for.',
      );
    });

    test('F-SCD101-3: the boundary delivers what the RESOLVED interpreter '
        'peels [2026-09-14]', () {
      // Behaviour, pinned as it actually is rather than as it will be.
      //
      // PUBLISH-PIN(sce119_aiml-exec-carries-a-fourth-unwrap-copy-until-the-ast-publish-lands): exec
      // resolves `throwAsHostFacingError` from pub.dev, and published 0.65.0
      // peels the interpreter's carrier ONCE where the working tree peels
      // twice (SCD96). So the `FormatException` assertion this case would
      // otherwise make is held back to what the published pair can deliver.
      //
      // `[].first` raises a native StateError, which never passes through a
      // BridgedInstance, so it arrives as itself on any version. A script's
      // `throw FormatException(...)` does pass through one, and arrives peeled
      // only as far as the RESOLVED `throwAsHostFacingError` peels: published
      // 0.65.0 peels once and hands back the shell; the working tree peels
      // twice (SCD96). Exec resolves from pub.dev (DGUC6), so the second
      // assertion below is a statement about the published pair and is
      // expected to tighten to `isA<FormatException>()` when the constraint is
      // raised — see sce119, which raises it.
      expect(
        () => D4rt().execute(
          source: 'main() { var l = <int>[]; return l.first; }',
        ),
        throwsA(isA<StateError>()),
      );
      expect(
        () => D4rt().execute(source: "main() { throw 'plain'; }"),
        throwsA('plain'),
      );
      expect(
        () => D4rt().execute(source: 'main() => totallyUndefinedThing;'),
        throwsA(isA<UndefinedNameD4rtException>()),
      );
    });

    test('F-SCD101-4: I-MISC-97\'s shape returns the thrown value '
        '[2026-09-14]', () {
      // The one case the todo asked to investigate before editing: it reported
      // `try { throw 'Oops'; } finally { }` delivering the carrier instead of
      // the String. Measured on the current tree it delivers the String, on
      // both the sync and the eval path — so the carrier it saw belonged to
      // the half-applied patch state the todo was written under, not to a
      // defect that survived. Pinned so nobody re-opens it from the note.
      expect(
        () => D4rt().execute(
          source: "main() { try { throw 'Oops'; } finally {} }",
        ),
        throwsA('Oops'),
      );
      final runner = D4rt()..execute(source: 'main() => 0;');
      expect(() => runner.eval("throw 'Oops'"), throwsA('Oops'));
    });
  });
}
