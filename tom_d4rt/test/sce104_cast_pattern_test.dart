// SCE104 — a failing cast pattern throws, and there is only one cast.
//
// `case var x as T` raised `PatternMatchD4rtException` when the cast failed,
// and every arm-selection site catches exactly that and reads it as "this arm
// did not match". So the failure was converted into arm selection: a program
// that should stop ran on down `default`, into a branch its author wrote for a
// different case. `as` in a pattern exists to assert; a cast pattern that
// cannot fail is a cast pattern that does nothing.
//
// THE BAD DIRECTION OF THE TWO. SCD64's gaps were loudly unavailable — the
// program died with a visible interpreter error. This one was quietly wrong.
//
// THE FIX IS NOT "THROW INSTEAD", and that is the substance of it. `v as T` and
// `case var x as T` are the same operation written twice, and they were
// implemented twice: an eleven-name ladder in `visitAsExpression` and a
// nine-name ladder in the `CastPattern` branch, each with a permissive
// `default`. Measured before the merge, the two disagreed on eight inputs and
// each knew something the other did not:
//
//   | input             | expression  | pattern | Dart   |
//   | ----------------- | ----------- | ------- | ------ |
//   | `'s' as int`      | throws      | MISS    | throws |
//   | `1 as double`     | 1.0         | MISS    | 1.0    |
//   | `1 as Null`       | throws      | HIT     | throws |
//   | `'s' as I` (=int) | throws      | HIT     | throws |
//   | `'s' as Map`      | RETURNS 's' | miss    | throws |
//   | `'s' as Set`      | RETURNS 's' | miss    | throws |
//
// Turning the pattern's ladder into a throw without merging would have shipped
// four of those rows as crashes-or-passes in the wrong places. The pattern
// lacked `Null`, alias resolution (SCD100) and the `int`→`double` promotion
// (GEN-094); the expression lacked `Map` and `Set` entirely, so a failing cast
// to either RETURNED ITS OPERAND. One body ends both.
//
// THE CAST'S RESULT IS WHAT BINDS, not the operand — `1 as double` binds 1.0,
// and a proxy cast to the class it wraps binds the interpreted instance (C21).
// Binding the operand would make the cast a test with no effect, which is half
// of what a cast is.
//
// WHAT IS DELIBERATELY UNCHANGED: the shared ladder's `default` is still
// permissive, so `A() as B` between two unrelated script classes still
// succeeds. That permissiveness was load-bearing while a wrong answer only cost
// an arm, and it is a separate decision with a separate blast radius — pinned
// below as F-SCE104-7 so it is a recorded limit rather than an oversight.
//
// BLAST RADIUS, measured rather than assumed because this change CAN break a
// green test where SCD64's could not: zero. Across the reference suite the only
// failures were the version bump, the two mirror guards, and F-SCD64-8 — the
// case that pinned this divergence on purpose, and which is inverted rather
// than deleted.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? run(String source) => D4rt().execute(source: source, name: 'main');

/// `main` returning `'HIT:<binding>'` from `case var n as $type:` over
/// [scrutinee], or `'miss'` from `default`.
Object? castArm(String type, String scrutinee) => run(
  'main() { Object? v = $scrutinee; '
  "switch (v) { case var n as $type: return 'HIT:\$n'; "
  "default: return 'miss'; } }",
);

/// `main` returning `v as $type`.
Object? castExpr(String type, String scrutinee) =>
    run('main() { Object? v = $scrutinee; return v as $type; }');

/// The message of the [TypeError] [body] raises, or null when it raises none.
String? typeErrorFrom(Object? Function() body) {
  try {
    body();
    return null;
  } on TypeError catch (e) {
    return e.toString();
  }
}

void main() {
  group('SCE104: a failing cast pattern throws', () {
    test('F-SCE104-1: the failure is a TypeError, not a missed arm '
        '[2026-09-22] (PASS)', () {
      expect(
        typeErrorFrom(() => castArm('int', "'s'")),
        "type 'String' is not a subtype of type 'int' in type cast",
      );
      expect(
        typeErrorFrom(() => castArm('String', '1')),
        "type 'int' is not a subtype of type 'String' in type cast",
      );
      expect(
        typeErrorFrom(() => castArm('int', 'null')),
        "type 'Null' is not a subtype of type 'int' in type cast",
      );
    });

    test('F-SCE104-2: the throw is not caught by arm selection [2026-09-22] '
        '(PASS)', () {
      // The sharpest form: a LATER arm that would have matched. If the
      // exception were still a `PatternMatchD4rtException` this would return
      // 'later' rather than throwing, and nothing would look wrong.
      expect(
        typeErrorFrom(
          () => run(
            "main() { Object? v = 's'; switch (v) { "
            "case var n as int: return 'first'; "
            "case String _: return 'later'; "
            "default: return 'miss'; } }",
          ),
        ),
        "type 'String' is not a subtype of type 'int' in type cast",
      );
    });

    test('F-SCE104-3: the CAST RESULT binds, not the operand [2026-09-22] '
        '(PASS)', () {
      // GEN-094's `int`→`double` promotion, which the pattern's own ladder did
      // not have at all — it answered `1 as double` with a miss.
      expect(castArm('double', '1'), 'HIT:1.0');
      expect(castArm('double', '1.5'), 'HIT:1.5');
    });

    test('F-SCE104-4: the pattern and the expression give the same answer '
        '[2026-09-22] (PASS)', () {
      // The structural claim, asked directly rather than implied by the cases
      // above: one operation, one implementation. A future change that repairs
      // one construct and not the other fails here even if every case above
      // still passes, because those only ask about the pattern.
      const rows = <List<String>>[
        ['int', '1'],
        ['int', "'s'"],
        ['String', "'s'"],
        ['String', '1'],
        ['double', '1'],
        ['int', '1.5'],
        ['int', 'null'],
        ['int?', 'null'],
        ['List', '[1]'],
        ['List', "'s'"],
        ['Set', '{1, 2}'],
        ['Set', "'s'"],
        ['Map', '{1: 2}'],
        ['Map', "'s'"],
        ['Object', '1'],
        ['Object', 'null'],
        ['num', "'s'"],
        ['Null', 'null'],
        ['Null', '1'],
      ];
      final disagreements = <String>[];
      for (final row in rows) {
        final type = row[0];
        final value = row[1];
        final patternThrew = typeErrorFrom(() => castArm(type, value)) != null;
        final exprThrew = typeErrorFrom(() => castExpr(type, value)) != null;
        if (patternThrew != exprThrew) {
          disagreements.add(
            '$value as $type: pattern ${patternThrew ? "threw" : "did not"}, '
            'expression ${exprThrew ? "threw" : "did not"}',
          );
        }
      }
      expect(
        disagreements,
        isEmpty,
        reason:
            'A cast pattern and a cast expression are one operation:\n'
            '${disagreements.join('\n')}',
      );
    });

    test('F-SCE104-5: a type alias reaches the pattern too [2026-09-22] '
        '(PASS)', () {
      // SCD100 taught the EXPRESSION to resolve an alias before choosing its
      // branch; the pattern's own ladder never learned, so `'s' as I` through
      // `typedef I = int` selected the arm. Sharing the body is what carries
      // the fix across.
      expect(
        typeErrorFrom(
          () => run(
            'typedef I = int;\n'
            "main() { Object? v = 's'; switch (v) { "
            "case var n as I: return 'HIT'; default: return 'miss'; } }",
          ),
        ),
        "type 'String' is not a subtype of type 'I' in type cast",
      );
    });

    // ---- the rails ---------------------------------------------------------

    test('F-SCE104-6 (control): a succeeding cast still selects its arm '
        '[2026-09-22] (PASS)', () {
      // Everything above is a throw that should happen, so a fix of "always
      // throw" satisfies all of it.
      expect(castArm('int', '1'), 'HIT:1');
      expect(castArm('String', "'s'"), 'HIT:s');
      expect(castArm('int?', 'null'), 'HIT:null');
      expect(castArm('num', '1'), 'HIT:1');
      expect(castArm('dynamic', "'s'"), 'HIT:s');
      expect(castArm('List', '[1]'), 'HIT:[1]');
    });

    test('F-SCE104-7 (control): the shared ladder is still permissive for '
        'script classes [2026-09-22] (PASS)', () {
      // A RECORDED LIMIT, not an oversight. The ladder's `default` answers
      // "yes" for every name it does not enumerate, which is why `A() as B`
      // between unrelated script classes succeeds — in the pattern and in the
      // expression alike, which is the property this commit is about. Making
      // it strict changes which casts SUCCEED as well as which throw, and that
      // is a separate decision with its own blast radius.
      expect(
        run(
          'class A {} class B {}\n'
          "main() { Object? v = A(); switch (v) { case var n as B: "
          "return 'HIT'; default: return 'miss'; } }",
        ),
        'HIT',
      );
    });

    test('F-SCE104-8 (control): the expression keeps its own wording '
        '[2026-09-22] (PASS)', () {
      // One body, two messages. The SDK words a failed `as` and a failed cast
      // PATTERN differently, and matching it per construct is the point of
      // D4rtTypeError — the same discipline ResolvedBinding applies with its
      // `of 'name'` suffix. Sharing the implementation must not collapse them.
      expect(
        typeErrorFrom(() => castExpr('int', "'s'")),
        "Cast failed with 'as' : value of type String cannot be cast to int",
      );
    });
  });
}
