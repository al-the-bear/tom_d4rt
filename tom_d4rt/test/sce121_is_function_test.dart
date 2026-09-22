// SCE121 — `is Function` answers for every value the interpreter can call.
//
// It answered `true` for a script function or a closure and `false` for every
// native one. THE DAMNING MEASUREMENT IS NOT THE `false`, IT IS THE PAIR:
//
//     var f = 'abc'.substring;
//     f(1);                     // 'bc' — works
//     f is Function;            // false
//
// So the guard rejected a value the interpreter was perfectly able to call,
// and a script written the Dart way — a plugin registry, a callback table,
// `if (x is Function) x()` — silently took the else-branch for every native
// callable. That reads as "d4rt cannot do that" rather than "the type test is
// wrong", which is why it survived.
//
// THE POPULATION WAS ENUMERATED BEFORE ANYTHING WAS CHANGED, as the notes ask,
// rather than patching the one shape a probe happened to use. Measured false:
// a bridged instance-method tear-off (`'abc'.substring`, `<int>[].add`,
// `1.toString`), a bridged static (`int.parse`), a constructor tear-off
// (`Object.new`) and a bridged top-level (`json.decode`). Measured true:
// script function, closure, script tear-off.
//
// THE FIX IS IN THE `Function` BRIDGE, not in the interpreter's type-test
// path. `Callable` is the interpreter's own "can be invoked" interface and
// every tear-off shape implements it, so `isAssignable: (v) => v is Function
// || v is Callable` makes the type test agree with what invocation already
// does. That is the only consistency a script can act on, and it is one line
// where the answer is manufactured rather than a branch in a predicate
// SCD62/SCD63 have both already shown to be fuller than it looks.
//
// A CLASS WITH `call` IS STILL NOT A FUNCTION (F-SCE121-3). That is real Dart
// — `c()` works and `c is Function` is false — and it is the case a fix aimed
// at "anything callable" gets wrong. `InterpretedInstance` does not implement
// `Callable`, so the rule lands on the right side of it by construction.
//
// TWO HALVES STAY UNFIXED AND ARE WRITTEN DOWN, which the todo's DONE-WHEN
// requires: `'abc'.substring is String Function(int)` is false, and
// `runtimeType` reports `BridgedMethodCallable`. Both are the same underlying
// fact — the interpreter has no function TYPE for a native callable, only the
// knowledge that it can be invoked — and F-SCE121-4 pins them so they read as
// measured rather than missed. `doc/d4rt_limitations.md` Lim-11 carries the
// reasoning, including why a half-right function type would be worse than an
// honest class name.
//
// ABLATED 2026-09-22 by removing the `isAssignable` line: F-SCE121-1 and -2
// fail, and so does F-SCD77-2 in `scd77_uri_is_scheme_test.dart`, which is
// the expectation this commit inverted — it was written down as a `false` with
// a note naming this todo, precisely so that it would fail on the day the
// answer changed rather than pass through it quietly. -3 and -4 pass under
// both: -3 is the rail against over-widening and -4 is the pair that was
// already false and stays false.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? run(String body, {String imports = '', String decls = ''}) =>
    D4rt().execute(source: '$imports\n$decls\nmain() { $body }', name: 'main');

void main() {
  group('SCE121: is Function', () {
    test('F-SCE121-1: every native callable answers true [2026-09-22] '
        '(PASS)', () {
      // A bridged instance method, on three different receivers.
      expect(run("return 'abc'.substring is Function;"), isTrue);
      expect(run('return <int>[].add is Function;'), isTrue);
      expect(run('return 1.toString is Function;'), isTrue);
      // A bridged static, a constructor tear-off, and a bridged top-level.
      expect(run('return int.parse is Function;'), isTrue);
      expect(run('return Object.new is Function;'), isTrue);
      expect(
        run(
          'return json.decode is Function;',
          imports: "import 'dart:convert';",
        ),
        isTrue,
      );
      // The two that already worked, so a change that swapped the answer
      // rather than widening it fails here.
      expect(run('return f is Function;', decls: 'f() => 1;'), isTrue);
      expect(run('var f = () => 1; return f is Function;'), isTrue);
    });

    test('F-SCE121-2: the guard a script writes now reaches the call '
        '[2026-09-22] (PASS)', () {
      // The defect stated as the script sees it. The else-branch used to be
      // taken for a value the very next line could have invoked.
      expect(
        run(
          "var f = 'abc'.substring; "
          'if (f is Function) { return f(1); } return "rejected";',
        ),
        'bc',
      );
      expect(
        run('var f = () => 7; if (f is Function) { return f(); } return -1;'),
        7,
      );
      // A registry, which is the shape the todo names.
      expect(
        run(
          "var table = {'a': 'abc'.substring, 'b': () => 9}; "
          'var n = 0; '
          'for (final v in table.values) { if (v is Function) { n = n + 1; } } '
          'return n;',
        ),
        2,
      );
    });

    test('F-SCE121-3 (rail): nothing else became a Function [2026-09-22] '
        '(PASS)', () {
      for (final expr in [
        '1',
        "'s'",
        'null',
        '[]',
        'int',
        'StringBuffer()',
        "Uri.parse('http://x')",
      ]) {
        expect(
          run('return $expr is Function;'),
          isFalse,
          reason: '$expr must not be a Function',
        );
      }
      expect(run('return C() is Function;', decls: 'class C {}'), isFalse);
      expect(run('return E.a is Function;', decls: 'enum E { a }'), isFalse);
      // THE CASE A FIX AIMED AT "ANYTHING CALLABLE" GETS WRONG: real Dart says
      // an object with a `call` method is callable and is NOT a Function.
      expect(
        run('return C() is Function;', decls: 'class C { call() => 1; }'),
        isFalse,
        reason: 'a class declaring `call` is invocable, not a Function',
      );
      // And a callable is not suddenly every other type.
      expect(run("return 'abc'.substring is String;"), isFalse);
      expect(run('var f = () => 1; return f is int;'), isFalse);
    });

    test(
      'F-SCE121-4: the two halves that stay, stated [2026-09-22] (PASS)',
      () {
        // Pinned so the next reader knows they were measured and left rather
        // than missed. Both are the same fact: there is no function TYPE for a
        // native callable, only the knowledge that it can be invoked. See
        // `doc/d4rt_limitations.md` Lim-11.
        expect(
          run("return 'abc'.substring is String Function(int);"),
          isFalse,
          reason:
              'the typed form goes through the structural path, which has '
              'no runtime type to compare a bridged tear-off against',
        );
        expect(
          run("return 'abc'.substring.runtimeType.toString();"),
          'BridgedMethodCallable',
        );
        // Interpreted functions are only partly better: the typed form works,
        // the runtimeType is still the bare name.
        expect(
          run('var f = (String s) => true; return f is bool Function(String);'),
          isTrue,
        );
        expect(
          run('var f = (String s) => true; return f.runtimeType.toString();'),
          'Function',
        );
      },
    );
  });
}
