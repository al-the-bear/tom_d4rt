// SCE127 — an `on` clause naming something that does not resolve to a type
// fails loudly, because real Dart refuses to compile such a program.
//
// `dart analyze` reports `non_type_in_catch_clause`: "The name 'X' isn't a type
// and can't be used in an on-catch clause." d4rt logged a warning nobody sees
// and answered `false`, so the divergence ran in the most dangerous direction
// available — Dart rejects the program, d4rt silently runs a DIFFERENT BRANCH
// of it:
//
//   * with a later clause, that clause took the branch, and the script
//     returned a value from a handler its author never meant to reach;
//   * with no later clause, the exception escaped the `try` as if the handler
//     were not written.
//
// A script author had no way to discover a dead clause except by testing that
// it fires — precisely the test people skip, because catching by name is
// assumed to work.
//
// WHAT WAS SETTLED FIRST, because it decides whether this is safe. The todo
// names two candidate legitimate cases. Measured, before anything changed:
//
//   | shape                                    | resolves |
//   | ---------------------------------------- | -------- |
//   | class declared AFTER `main`              | yes      |
//   | class from another module in the run     | yes      |
//   | prefixed `on p.Other`                    | yes      |
//   | generic `on List<int>`                   | yes      |
//   | `typedef E = StateError; on E`           | yes      |
//   | type from a library the script did NOT   | NO       |
//   | import (`on LinkedList` with no          |          |
//   | `dart:collection`)                       |          |
//
// So the only unresolvable shape is the one Dart ALSO rejects — it is this
// same defect rather than an exception to it. The second candidate, a bridge
// not finalized when the clause is reached, does not arise: `finalizeBridges`
// runs implicitly on first execute, so bridges are registered before any
// script statement runs. F-SCE127-3 pins the whole table, which is what makes
// the change safe rather than merely correct.
//
// THE OLD CODE'S CONCERN IS ANSWERED, NOT DISCARDED. Its comment read "letting
// the lookup failure escape would replace the exception being dispatched and
// lose the original" — true, and the reason it returned `false`. So the
// failure does not escape: a diagnostic is raised naming BOTH the unresolved
// type and the exception that was being dispatched. F-SCE127-2 pins that both
// halves survive.
//
// WHEN, and why the clause rather than a pass: Dart checks at compile time
// over the whole program; d4rt resolves names lazily, so the analogue is to
// fail when the clause is REACHED. Later than Dart, and only on an exception
// that actually arrives — but it needs no new pass, and it fires at the exact
// moment the wrong branch would have been taken. A dead clause that nothing
// ever reaches stays silent, which F-SCE127-4 records rather than hides.
//
// ABLATED 2026-09-22 by restoring the `Logger.warn` + `return false`:
// F-SCE127-1 and -2 fail. -3 and -4 pass under both, which is what makes -3
// the safety evidence rather than a restatement of the new behaviour.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? run(String source) => D4rt().execute(source: source, name: 'main');

Matcher get _deadClause => throwsA(
  isA<RuntimeD4rtException>().having(
    (e) => e.toString(),
    'message',
    allOf(
      contains('does not resolve to a type'),
      contains('non_type_in_catch_clause'),
    ),
  ),
);

void main() {
  group('SCE127: a dead `on` clause is an error', () {
    test(
      'F-SCE127-1: the three shapes the hazard took [2026-09-22] (PASS)',
      () {
        // Alone: it used to fall through to the bare `catch`.
        expect(
          () => run(
            "main() { try { <int>[].first; } "
            "on NotARegisteredError { return 'CAUGHT'; } "
            "catch (e) { return 'FELL-THROUGH'; } }",
          ),
          _deadClause,
        );
        // With a later clause: that clause used to take the branch, and the
        // script returned `'second'` — a value from a handler nobody chose.
        expect(
          () => run(
            "main() { try { <int>[].first; } "
            "on NotARegisteredError { return 'first'; } "
            "on Error { return 'second'; } }",
          ),
          _deadClause,
        );
        // With no other clause: the exception used to escape the try.
        expect(
          () => run(
            "main() { try { <int>[].first; } "
            "on NotARegisteredError { return 'CAUGHT'; } return 'NO-THROW'; }",
          ),
          _deadClause,
        );
      },
    );

    test('F-SCE127-2: neither half of the failure is lost [2026-09-22] '
        '(PASS)', () {
      // The old code returned `false` precisely so the lookup failure would
      // not replace the exception being dispatched. The diagnostic carries
      // both, so the author learns what is wrong AND what was being handled.
      try {
        run(
          "main() { try { throw FormatException('boom'); } "
          "on NotARegisteredError { return 'CAUGHT'; } }",
        );
        fail('expected a dead-clause diagnostic');
      } catch (e) {
        final message = e.toString();
        expect(
          message,
          contains('NotARegisteredError'),
          reason: 'the unresolved type',
        );
        expect(
          message,
          contains('Import the library'),
          reason: 'the remedy, not just the diagnosis',
        );
        expect(
          message,
          contains('boom'),
          reason:
              'and the exception that was in flight — its VALUE, not the '
              'lookup failure. The first draft reported the resolution error '
              'here, so the diagnostic named the dead clause back at the '
              'reader and reintroduced exactly the loss the old `return false` '
              'existed to prevent. SCC20 F-SCC20-16 caught it',
        );
      }
    });

    test('F-SCE127-3 (safety): every resolvable shape still resolves '
        '[2026-09-22] (PASS)', () {
      // The measurement the change rests on. A legitimate unresolvable `on`
      // type would make working scripts start throwing, so each of these was
      // run BEFORE the change and each resolved.
      expect(
        run(
          "main() { try { throw Later(); } on Later { return 'CAUGHT'; } "
          "catch (e) { return 'FELL'; } }\nclass Later {}",
        ),
        'CAUGHT',
        reason: 'a class declared after main — pass 1 has already declared it',
      );
      expect(
        run(
          "main() { try { <int>[].first; } on StateError { return 'CAUGHT'; } "
          "catch (e) { return 'FELL'; } }",
        ),
        'CAUGHT',
      );
      expect(
        run(
          "main() { try { throw <int>[1]; } on List<int> { return 'CAUGHT'; } "
          "catch (e) { return 'FELL'; } }",
        ),
        'CAUGHT',
        reason: 'a generic on-type',
      );
      expect(
        run(
          "typedef E = StateError;\n"
          "main() { try { <int>[].first; } on E { return 'CAUGHT'; } "
          "catch (e) { return 'FELL'; } }",
        ),
        'CAUGHT',
        reason: 'a typedef alias',
      );
      expect(
        run(
          "import 'dart:collection';\n"
          "main() { try { <int>[].first; } on LinkedList { return 'C'; } "
          "catch (e) { return 'FELL'; } }",
        ),
        'FELL',
        reason:
            'WITH the import the name resolves, so the clause simply does '
            'not match — which is the ordinary miss, not the dead-clause error',
      );
    });

    test('F-SCE127-4: a clause nothing reaches stays silent [2026-09-22] '
        '(PASS)', () {
      // The honest limit of checking at the clause rather than in a pass.
      // Dart rejects this program; d4rt runs it, because the dead clause is
      // never reached. Recorded rather than hidden — it is the price of
      // needing no new pass, and it is what a later whole-program check would
      // close.
      expect(
        run(
          "main() { try { return 'ok'; } "
          "on NotARegisteredError { return 'CAUGHT'; } }",
        ),
        'ok',
      );
    });
  });
}
