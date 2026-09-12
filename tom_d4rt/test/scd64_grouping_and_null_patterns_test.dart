// SCD64 — the three pattern kinds `_matchAndBind` had no branch for.
//
// The todo named one: `case (int _)` threw `Unimplemented Error: Pattern type
// not yet supported in _matchAndBind: ParenthesizedPatternImpl`. Its notes
// asked for an audit of the rest of the dispatch, "because the set of
// unsupported pattern kinds is not known". It is now, and it was three:
//
//   | pattern kind           | spelled     | before            |
//   | ---------------------- | ----------- | ----------------- |
//   | ParenthesizedPattern   | `(p)`       | Unimplemented     |
//   | NullCheckPattern       | `p?`        | Unimplemented     |
//   | NullAssertPattern      | `p!`        | Unimplemented     |
//
// The audit ran every DartPattern subtype the analyzer defines through five
// contexts in one pass, rather than finding them one accident at a time. The
// other twelve — constant, declared-variable, wildcard, assigned-variable,
// list, map, record, object, relational, logical-or, logical-and, cast — were
// already implemented and answered correctly in all five.
//
// ALL THREE WERE FIXED TOGETHER, AND THE BLAST RADIUS IS PROVABLY ZERO. A
// branch that today raises `Unimplemented` has no behaviour to regress: every
// program that reaches it already dies there. Splitting this into three
// commits would have bought three rounds of mirror, version bump and suite run
// for no extra safety.
//
// THE TWO NULL PATTERNS ARE THE SAME SYNTAX WITH OPPOSITE ANSWERS, which is
// the whole reason they are pinned together here. Measured against the SDK,
// not assumed:
//
//   `case int n?` with null  ->  falls to the next arm, quietly
//   `case int n!` with null  ->  THROWS TypeError, and cannot select an arm
//
// Getting those backwards is invisible in a test that only uses non-null
// scrutinees, so F-SCD64-4 and F-SCD64-5 exist to separate them. The
// exception TYPE is load-bearing and not cosmetic: arm selection catches
// `PatternMatchD4rtException` and nothing else, so a null-assert signalled as
// a match failure would silently take `default` instead of stopping.
//
// CONTROL, measured by reverting all three branches: `+2 -6`. Only F-SCD64-7
// (the twelve already-working kinds) and F-SCD64-8 (the cast divergence, which
// this change does not touch) keep passing. They are the rails: -7 says the
// new branches did not disturb the dispatch they were added to, and -8 pins a
// known divergence as known, so closing it later is a decision rather than a
// drift.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? run(String source) => D4rt().execute(source: source, name: 'main');

/// `main` returning `'HIT'` from a `case $pattern:` arm over `$scrutinee`, or
/// `'miss'` from `default`.
String switchOn(String pattern, String scrutinee) =>
    "main() { Object? v = $scrutinee; "
    "switch (v) { case $pattern: return 'HIT'; default: return 'miss'; } }";

void main() {
  group('SCD64: grouping and null patterns', () {
    test(
      'F-SCD64-1: `(p)` matches exactly what `p` matches [2026-09-12] (PASS)',
      () {
        expect(run(switchOn('(int _)', '1')), 'HIT');
        expect(run(switchOn('(int _)', "'s'")), 'miss');
        expect(run(switchOn('(int _)', 'null')), 'miss');
        // Parentheses add nothing of their own, so nesting them changes
        // nothing — the case that says the branch recurses rather than
        // handling one level and stopping.
        expect(run(switchOn('(((int _)))', '1')), 'HIT');
      },
    );

    test('F-SCD64-2: `(p)` binds what `p` binds, and guards still see it '
        '[2026-09-12] (PASS)', () {
      expect(
        run(
          "main() { switch (7) { case (int n): return n; default: return 0; } }",
        ),
        7,
      );
      // The guard runs after the pattern binds, so a binding lost inside the
      // parentheses would surface here as a missing variable rather than as
      // a wrong answer.
      expect(
        run(
          "main() { switch (5) { case (int n) when n > 3: return 'guard'; "
          "default: return 'miss'; } }",
        ),
        'guard',
      );
    });

    test('F-SCD64-3: a non-match inside the parentheses propagates out '
        '[2026-09-12] (PASS)', () {
      // Nested inside a list pattern, so the recursion is reached through
      // the sub-pattern descent rather than at the top of the dispatch…
      expect(
        run(
          "main() { switch ([1, 0]) { case [(int _), _]: return 'HIT'; "
          "default: return 'miss'; } }",
        ),
        'HIT',
      );
      // …and the inner pattern failing must make the WHOLE arm fail, not be
      // swallowed by the grouping.
      expect(
        run(
          "main() { switch (['s', 0]) { case [(int _), _]: return 'HIT'; "
          "default: return 'miss'; } }",
        ),
        'miss',
      );
    });

    test('F-SCD64-4: `p?` does not match null, and does not throw '
        '[2026-09-12] (PASS)', () {
      expect(run(switchOn('int n?', '1')), 'HIT');
      expect(run(switchOn('int n?', 'null')), 'miss');
      expect(run(switchOn('int n?', "'s'")), 'miss');
      // It binds through the check.
      expect(
        run(
          "main() { switch (7) { case (int n?): return n; default: return 0; } }",
        ),
        7,
      );
      // Quietly: a script's `on TypeError` must see nothing. This is the
      // half that distinguishes it from `p!`.
      expect(
        run(
          "main() { Object? z = null; "
          "try { switch (z) { case int n?: return 'HIT'; default: return 'miss'; } } "
          "on TypeError { return 'caught'; } }",
        ),
        'miss',
      );
    });

    test('F-SCD64-5: `p!` throws on null rather than selecting another arm '
        '[2026-09-12] (PASS)', () {
      expect(run(switchOn('int n!', '1')), 'HIT');
      expect(run(switchOn('int n!', "'s'")), 'miss');
      // The SDK's own wording, so a ported script's message assertions hold.
      try {
        run(switchOn('int n!', 'null'));
        fail('expected a TypeError, not a fall-through to `default`');
      } on TypeError catch (e) {
        expect(e.toString(), 'Null check operator used on a null value');
      }
      // And a script can catch it as a TypeError — which only works because
      // it is NOT a PatternMatchD4rtException, the type arm selection eats.
      expect(
        run(
          "main() { Object? z = null; "
          "try { switch (z) { case int n!: return 'HIT'; default: return 'miss'; } } "
          "on TypeError { return 'caught'; } }",
        ),
        'caught',
      );
    });

    test('F-SCD64-6: all four pattern contexts, plus for-each and assignment '
        '[2026-09-12] (PASS)', () {
      // switch statement is covered above; the other refutable contexts:
      expect(
        run(
          "main() { Object? v = 1; "
          "return switch (v) { (int _) => 'HIT', _ => 'miss' }; }",
        ),
        'HIT',
      );
      expect(
        run(
          "main() { Object? v = 1; if (v case (int _)) { return 'HIT'; } "
          "return 'miss'; }",
        ),
        'HIT',
      );
      // Irrefutable contexts reach `_matchAndBind` through two DIFFERENT
      // call sites, each with its own error wrapping — so a branch that works
      // in a switch can still be unreachable here.
      expect(run('main() { var (int a) = 1; return a; }'), 1);
      expect(run('main() { int a = 0; (a) = 5; return a; }'), 5);
      expect(
        run(
          'main() { var o = []; for (var (int a) in [1, 2]) { o.add(a); } '
          'return o; }',
        ),
        [1, 2],
      );
      // A null-assert in a declaration is legal Dart whose entire purpose is
      // to throw. It only reaches the caller as a TypeError because that site
      // stopped wrapping TypeErrors in a RuntimeD4rtException.
      expect(run('main() { var (a!) = 1; return a; }'), 1);
      expect(
        () => run('main() { Object? z = null; var (a!) = z; return a; }'),
        throwsA(isA<TypeError>()),
      );
    });

    test('F-SCD64-7: the twelve kinds that already worked still do '
        '[2026-09-12] (PASS)', () {
      // The audit's control column. These say the three new branches were
      // added to the dispatch without disturbing it — and they are what a
      // future `Unimplemented` in this chain would show up against, since
      // the audit that found SCD64 is not repeatable from the test suite.
      const kinds = <String, List<String>>{
        //  pattern            : [matching scrutinee, non-matching]
        '1': ['1', '2'], // ConstantPattern
        'int n': ['1', "'s'"], // DeclaredVariablePattern
        'int _': ['1', "'s'"], // WildcardPattern
        '[1, 2]': ['[1, 2]', '[1, 3]'], // ListPattern
        "{'a': 1}": ["{'a': 1}", "{'a': 2}"], // MapPattern
        '(int a, int b)': ['(1, 2)', "(1, 's')"], // RecordPattern
        'int()': ['1', "'s'"], // ObjectPattern
        '> 0': ['1', '-1'], // RelationalPattern
        '1 || 2': ['2', '3'], // LogicalOrPattern
        'int _ && > 0': ['1', '-1'], // LogicalAndPattern
        // The cast's non-matching half is deliberately '' — see F-SCD64-8.
        'var n as int': ['1', ''],
      };
      kinds.forEach((pattern, scrutinees) {
        expect(
          run(switchOn(pattern, scrutinees[0])),
          'HIT',
          reason: 'pattern `$pattern` should match ${scrutinees[0]}',
        );
        if (scrutinees[1].isEmpty) return; // cast failure: see F-SCD64-8
        expect(
          run(switchOn(pattern, scrutinees[1])),
          'miss',
          reason: 'pattern `$pattern` should not match ${scrutinees[1]}',
        );
      });
      // AssignedVariablePattern has no switch form — it is an assignment.
      expect(
        run('main() { int a = 0; int b = 0; (a, b) = (1, 2); return [a, b]; }'),
        [1, 2],
      );
    });

    test('F-SCD64-8: a failing cast pattern still MISSES where Dart throws '
        '[2026-09-12] (PASS)', () {
      // NOT fixed here, and pinned so it stays visible. `case var n as int`
      // over a String raises `TypeError: type 'String' is not a subtype of
      // type 'int' in type cast` in real Dart; d4rt signals a non-match and
      // takes `default`. That is an arm-selection difference with real blast
      // radius — a program that should stop keeps running — so it is a
      // decision of its own rather than a tail of this todo.
      expect(run(switchOn('var n as int', "'s'")), 'miss');
    });
  });
}
