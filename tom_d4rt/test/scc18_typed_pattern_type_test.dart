// SCC18: a typed pattern used to match unconditionally. `case int _` accepted a
// String, so the FIRST arm of every switch statement, switch expression and
// if-case won regardless of the scrutinee.
//
// WHY ~2270 GREEN TESTS SAID NOTHING ABOUT IT. Constant patterns (`case 1:`)
// compare, and destructuring patterns (list, map, record, object-with-fields)
// fail to destructure and throw — so both report non-match correctly. The two
// branches that did not were `DeclaredVariablePattern` (`case int x`) and
// `WildcardPattern` (`case int _`): both read only the *name*, never
// `pattern.type`, so there was no code path that could signal a mismatch. Every
// pattern test in the corpus exercised an arm that was *meant* to match, and a
// suite that only ever asks "does the right arm win" cannot see a matcher that
// says yes to everything.
//
// SO EVERY CASE HERE IS A NEGATIVE ONE. Each pins that a value of the WRONG
// type falls through to a later arm — which is the assertion the corpus was
// missing, not another confirmation that the right arm wins. The four contexts
// are separated deliberately: they reach `_matchAndBind` by different call
// sites (`visitSwitchStatement`, `visitSwitchExpression`, `visitIfStatement`'s
// case clause, and the recursive sub-pattern descent), and a fix to one does
// not imply the others.
//
// THE TYPE TEST IS THE `is` OPERATOR'S. The fix routes both branches through
// `_valueHasType`, lifted out of `visitIsExpression` — so `case Iterable _`
// answers for a bridged collection exactly as `x is Iterable` does, rather than
// through a private copy of the type switch. SCC20 then folded in the last
// remaining copy, the catch clause, so the predicate now has four callers
// (`is`, the declared-type check, this pattern branch, and `on T`) and no other
// type-test body survives in either tree.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

dynamic execute(String source) {
  final d4rt = D4rt()..setDebug(false);
  return d4rt.execute(
    library: 'package:test/main.dart',
    sources: {'package:test/main.dart': source},
  );
}

void main() {
  group('SCC18: a typed pattern rejects a value of the wrong type', () {
    test('F-SCC18-1: a switch statement skips `case int _` for a String '
        '[2026-09-04] (PASS)', () {
      expect(
        execute('''
            main() {
              Object x = 'hello';
              switch (x) {
                case int _: return 'int';
                case String _: return 'String';
                default: return 'other';
              }
            }
          '''),
        'String',
      );
    });

    test('F-SCC18-2: a switch statement skips a typed BINDING pattern for the '
        'wrong type, and the arm that wins binds [2026-09-04] (PASS)', () {
      expect(
        execute('''
            main() {
              Object x = 42;
              switch (x) {
                case String s: return 'String:\$s';
                case int i: return 'int:\${i + 1}';
                default: return 'other';
              }
            }
          '''),
        'int:43',
      );
    });

    test('F-SCC18-3: a switch EXPRESSION skips the wrong-typed arm '
        '[2026-09-04] (PASS)', () {
      expect(
        execute('''
            main() {
              Object x = 'hello';
              return switch (x) {
                int _ => 'int',
                String _ => 'String',
                _ => 'other',
              };
            }
          '''),
        'String',
      );
    });

    test('F-SCC18-4: an if-case with a non-matching type takes the else branch '
        '[2026-09-04] (PASS)', () {
      expect(
        execute('''
            main() {
              Object x = 'hello';
              if (x case int _) {
                return 'int';
              } else {
                return 'not-int';
              }
            }
          '''),
        'not-int',
      );
    });

    test('F-SCC18-5: a nested typed sub-pattern rejects, so the enclosing list '
        'pattern does not match [2026-09-04] (PASS)', () {
      expect(
        execute('''
            main() {
              Object x = [1, 'two'];
              switch (x) {
                case [int _, int _]: return 'two-ints';
                case [int _, String _]: return 'int-then-string';
                default: return 'other';
              }
            }
          '''),
        'int-then-string',
      );
    });

    test('F-SCC18-6: `int(isEven: true)` evaluates its getter instead of '
        'matching anything [2026-09-04] (PASS)', () {
      expect(
        execute('''
            main() {
              var out = [];
              for (var x in [2, 3]) {
                out.add(switch (x) {
                  int(isEven: true) => 'even',
                  int(isEven: false) => 'odd',
                  _ => 'other',
                });
              }
              return out;
            }
          '''),
        ['even', 'odd'],
      );
    });

    test('F-SCC18-7: a bare object pattern `int()` rejects a String '
        '[2026-09-04] (PASS)', () {
      expect(
        execute('''
            main() {
              Object x = 's';
              switch (x) {
                case int(): return 'int';
                case String(): return 'String';
                default: return 'other';
              }
            }
          '''),
        'String',
      );
    });

    test('F-SCC18-8: `num` accepts an int while `double` does not, so the '
        'supertype arm is reachable [2026-09-04] (PASS)', () {
      expect(
        execute('''
            main() {
              Object x = 7;
              switch (x) {
                case double _: return 'double';
                case num _: return 'num';
                default: return 'other';
              }
            }
          '''),
        'num',
      );
    });

    test('F-SCC18-9: an untyped `var`/`_` pattern still matches anything '
        '[2026-09-04] (PASS)', () {
      // The fix must gate on `pattern.type != null` only. An untyped binding is
      // the irrefutable pattern the language says it is, and it is what every
      // existing destructuring test relies on.
      expect(
        execute('''
            main() {
              Object x = 'hello';
              switch (x) {
                case var v: return 'bound:\$v';
                default: return 'other';
              }
            }
          '''),
        'bound:hello',
      );
    });

    test('F-SCC18-10: a typed pattern over a user class rejects an unrelated '
        'instance and accepts a subclass [2026-09-04] (PASS)', () {
      expect(
        execute('''
            class Animal {}
            class Dog extends Animal {}
            class Rock {}

            String classify(Object o) {
              switch (o) {
                case Rock _: return 'rock';
                case Animal _: return 'animal';
                default: return 'other';
              }
            }

            main() => [classify(Dog()), classify(Rock()), classify(3)];
          '''),
        ['animal', 'rock', 'other'],
      );
    });

    test('F-SCC18-11: a typed pattern answers for a bridged collection exactly '
        'as `is` does [2026-09-04] (PASS)', () {
      // SCB7 taught that a bridged `dart:collection` value is a
      // `BridgedInstance`, not a native `Map` — so a private type switch that
      // forgot to unwrap would answer 'other' here while `x is Map` said true.
      // Routing through the `is` predicate is what makes these agree.
      expect(
        execute('''
            import 'dart:collection';
            main() {
              Object x = HashMap<String, int>();
              var viaSwitch = switch (x) {
                List _ => 'List',
                Map _ => 'Map',
                _ => 'other',
              };
              return [viaSwitch, x is Map];
            }
          '''),
        ['Map', true],
      );
    });

    test('F-SCC18-12: a guard still runs on the arm whose type matched, not on '
        'the first arm [2026-09-04] (PASS)', () {
      // Before the fix the first arm always matched, so its `when` clause was
      // the only guard ever evaluated and the value it saw was the wrong type.
      expect(
        execute('''
            main() {
              Object x = 5;
              switch (x) {
                case String s when s.length > 2: return 'long-string';
                case int i when i > 3: return 'big-int';
                case int _: return 'small-int';
                default: return 'other';
              }
            }
          '''),
        'big-int',
      );
    });
  });
}
