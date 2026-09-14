import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// SCD104 — exec's host boundary is held to the SCC27 CONTRACT, not to a mirror.
///
/// THE OPEN QUESTION THE TODO ASKED, ANSWERED BY MEASUREMENT
///
/// SCD104 records a third copy of the execute boundary — one the two-tree mirror
/// discipline does not cover — and offers three fixes in preference order:
/// (1) delete the fork and delegate to `D4rtRunner`; (2) keep only the
/// exec-specific part; (3) put the file under whatever enforces parity. It says
/// explicitly that what exec's boundary does that the runner's does not is
/// "genuinely open".
///
/// Measured, (1) is not available. Exec's classic `execute()` is **its own
/// engine**: `_executeInEnvironmentInZone` runs its own `DeclarationVisitor`
/// pass, builds its own `InterpreterVisitor`, and drives its own module loader.
/// The inner `D4rtRunner` serves `executeBundle()` and forwarded state
/// (packages, extensions, warmup) — it never sees the classic path, so there is
/// no runner boundary for that path to delegate to. A boundary is not a fork of
/// something when it is the only one covering its own engine.
///
/// (2) is unnecessary. The exec-owned case the todo names — the analyzer parse
/// front end's `SourceCodeD4rtException`, which the runner never raises —
/// reaches the host correctly through the GENERAL rule, because
/// `abstract class D4rtException implements Exception` and SCC27's rule admits
/// every `Exception`. The todo's own notes derive this; F-SCD104-3 measures it.
/// So there is no exec-specific remainder to keep.
///
/// WHAT WAS ACTUALLY LEFT, AND WHY THIS FILE IS A CONTRACT TEST
///
/// The rule duplication is gone: SCC35 ported `throwAsHostFacingError` in, and
/// SCD101 deleted the four hand-rolled carrier peels that still ran in front of
/// it. `d4rt_base.dart` now has five delegating call sites and enumerates no
/// types. What is NOT guarded is that it stays that way — which is option (3).
///
/// **"Mirror parity" is the wrong instrument for it**, and that is worth saying
/// rather than quietly substituting something else. Exec's boundary is not a
/// copy of a file in another tree; it is a different engine's call site for a
/// shared rule. Comparing its SOURCE to anything would compare things that are
/// supposed to differ. What must not differ is the CONTRACT, so that is what is
/// asserted here — every shape that can escape, and what the host receives.
///
/// Measured against `tom_d4rt` the same day, nine of ten shapes agree exactly.
/// The tenth is the publish gap, pinned below.
void main() {
  group('SCD104: exec\'s boundary keeps the SCC27 contract', () {
    // ------------------------------------------------------------------
    // The rule: anything that is an Error or an Exception escapes as itself.

    test('F-SCD104-1: an Error raised by an operation escapes as itself '
        '[2026-09-14]', () {
      expect(
        () => D4rt().execute(
          source: 'main() { var l = <int>[]; return l.first; }',
        ),
        throwsA(isA<StateError>()),
      );
      expect(
        () => D4rt().execute(source: 'main() { assert(false); }'),
        throwsA(isA<AssertionError>()),
      );
    });

    test('F-SCD104-2: an Exception from a NATIVE bridge escapes as itself '
        '[2026-09-14]', () {
      // The case SCC27 was written for: a native callee's error arrives inside
      // a `RuntimeD4rtException` wrapper, and the boundary has to unwrap it or
      // `on FormatException` works inside a script and not at the call site
      // that ran it.
      expect(
        () => D4rt().execute(source: "main() => int.parse('zz');"),
        throwsA(isA<FormatException>()),
      );
    });

    test('F-SCD104-3: the EXEC-OWNED diagnostic needs no special clause '
        '[2026-09-14]', () {
      // This is the case SCD104 flagged as possibly needing its own branch:
      // the analyzer parse front end raises `SourceCodeD4rtException`, which
      // the inner runner never sees. It needs no branch — `D4rtException`
      // implements `Exception`, so the general rule already admits it. That is
      // why option (2) is unnecessary, and this case is what says so.
      expect(
        () => D4rt().execute(source: 'main() { this is not dart'),
        throwsA(isA<SourceCodeD4rtException>()),
      );
    });

    test('F-SCD104-4: d4rt\'s own signal escapes as itself [2026-09-14]', () {
      // SCC31 made an undefined name unswallowable; the boundary must not
      // relabel it on the way out.
      expect(
        () => D4rt().execute(source: 'main() => nope;'),
        throwsA(isA<UndefinedNameD4rtException>()),
      );
      expect(
        () => D4rt().execute(source: 'int f() => 1;'),
        throwsA(isA<UndefinedNameD4rtException>()),
      );
    });

    test('F-SCD104-5: a value in NEITHER hierarchy escapes as itself '
        '[2026-09-14]', () {
      // Real Dart lets a script `throw 'plain'`, and the boundary must not
      // turn that into a diagnostic about an unexpected error.
      expect(
        () => D4rt().execute(source: "main() { throw 'plain'; }"),
        throwsA('plain'),
      );
    });

    test('F-SCD104-6: a script-declared exception arrives as the interpreted '
        'instance [2026-09-14]', () {
      // No native object to peel to, and the host cannot name a type the
      // script invented, so what it gets is the interpreted instance itself.
      //
      // PUBLISH-PIN(sce119_aiml-exec-carries-a-fourth-unwrap-copy-until-the-ast-publish-lands):
      // whether that instance renders its OWN `toString()` is SCD72's fix, and
      // exec resolves an interpreter that predates it — `_pinnedInterpreterFloors`
      // carries `scd72_instance_tostring_test.dart` at 0.81.0 against a
      // resolved 0.65.0. So the reference tree answers `E!` here and exec
      // answers `<instance of E>`. The TYPE is the contract this file is
      // about and it already agrees; the rendering is the version gap.
      expect(
        () => D4rt().execute(
          source: '''
          class E implements Exception { String toString() => 'E!'; }
          main() { throw E(); }
        ''',
        ),
        throwsA(isA<InterpretedInstance>()),
      );
    });

    test('F-SCD104-7: a BRIDGED exception is the one shape still gated on the '
        'publish [2026-09-14]', () {
      // PUBLISH-PIN(sce119_aiml-exec-carries-a-fourth-unwrap-copy-until-the-ast-publish-lands):
      // exec resolves `throwAsHostFacingError` from pub.dev, and published
      // 0.65.0 peels the interpreter's carrier ONCE where the working tree
      // peels twice (SCD96 — a bridged exception holds its native object one
      // level further in). So this is the single shape where exec and the
      // reference tree disagree, and it is a version gap rather than a
      // boundary defect. Asserted as it IS, so the day it changes is visible.
      expect(
        () =>
            D4rt().execute(source: "main() { throw FormatException('boom'); }"),
        throwsA(isNot(isA<FormatException>())),
        reason:
            'When the constraint is raised this becomes isA<FormatException>() '
            '— see sce119. F-SCD103-1 will go red and name this file.',
      );
    });

    // ------------------------------------------------------------------
    // The source guard: the rule must stay delegated, not re-enumerated.

    test('F-SCD104-8: the boundary delegates and enumerates nothing '
        '[2026-09-14]', () {
      // The drift SCD104 is about did not present as a wrong answer — it
      // presented as a WORKING BUILD until somebody raised a version
      // constraint, at which point a predicate both interpreters had deleted
      // turned into a compile error. A behavioural test cannot catch that
      // shape, because the file does not compile to be tested. This one can:
      // it reads the source and asks whether the decision is still delegated.
      final source = File(
        '${Directory.current.path}/lib/src/d4rt_base.dart',
      ).readAsStringSync();

      expect(
        RegExp(r'throwAsHostFacingError\s*[(,]').allMatches(source).length,
        greaterThanOrEqualTo(4),
        reason:
            'exec\'s boundary stopped delegating to the shared rule. Its '
            'classic path is its own engine, so it is the ONLY boundary that '
            'path has — but the rule it applies has to be the shared one, or '
            'the third copy starts deciding for itself again.',
      );

      // The specific shape SCC27 deleted: a clause that lists the types
      // allowed to escape. Every one of these is an `Exception` already, so a
      // list naming them is both redundant and a place to drift.
      //
      // ONE SITE IS ALLOWED, and it is allowed on measurement rather than on
      // resemblance. `_parseSource` rethrows `SourceCodeD4rtException` /
      // `RuntimeD4rtException` and wraps anything else with which module
      // failed to load. That is module-load CONTEXT, not the host-facing
      // decision — and measured, all three reachable failure shapes (a library
      // absent from `sources`, a parse error, an unresolvable import) take the
      // rethrow branch and arrive as `SourceCodeD4rtException`, so the
      // relabelling branch is not observable. It is listed rather than
      // pattern-excluded so that moving it, or adding a second, is visible.
      const allowedEnumerations = <String>{'_parseSource'};
      final enumerated = <String>[];
      for (final type in const [
        'SourceCodeD4rtException',
        'AmbiguousBridgedNameException',
        'isSdkShapedError',
      ]) {
        for (final match in RegExp('(is|on)\\s+$type\\b').allMatches(source)) {
          final line = '\n'.allMatches(source.substring(0, match.start)).length;
          // Which method is this in? The nearest preceding `_name(...) {`
          // wins — good enough to attribute a line, and it fails CLOSED: a
          // site it cannot attribute is reported rather than waved through.
          final enclosing = RegExp(r'\b(_\w+)\s*\([^)]*\)\s*\{')
              .allMatches(source.substring(0, match.start))
              .map((m) => m.group(1)!);
          if (enclosing.isNotEmpty &&
              allowedEnumerations.contains(enclosing.last)) {
            continue;
          }
          enumerated.add('  line ${line + 1}: ${match.group(0)}');
        }
      }
      expect(
        enumerated,
        isEmpty,
        reason:
            'The boundary is enumerating the types allowed to escape '
            'again:\n${enumerated.join('\n')}\n\n'
            'SCC27 replaced that list with one rule — anything that is an '
            '`Error` or an `Exception` escapes as itself — because every '
            '`D4rtException` implements `Exception`, so the list is redundant '
            'and needs maintenance the rule does not. It is also how this copy '
            'came to stop compiling: the list named a predicate the '
            'interpreters had deleted, and only a version bump reported it.',
      );
    });
  });
}
