// SCD63 — a typed for-each loop variable is checked against the element it
// binds.
//
// `for (final int x in [1, 'two', 3])` used to bind the String and keep going.
// The body then ran with a value its own declaration rules out, and — measured,
// this is the part that makes it worse than an ordinary missing check — it did
// not fail there either: `x + 1` reached `String.+` and produced `'two1'`. A
// silently wrong value, not an error several frames away.
//
// SEVEN PATHS, ONE CONSTRUCT. The check had to land on every one of them,
// because which path a given loop takes is decided by things a reader of the
// loop cannot see:
//
//   | path                                  | reached by                     |
//   | ------------------------------------- | ------------------------------ |
//   | visitor `_executeForIn`               | a sync function                |
//   | visitor `_executeForInWithItems`      | `await for`, non-state-machine |
//   | visitor `ForElement`                  | `[for (final int x in xs) x]`  |
//   | state machine, await-for item         | `await for` inside `async`     |
//   | state machine, for-in (2 env cases)   | plain for-in inside `async`    |
//   | `_executeForInWithYieldSuspension`    | `sync*` / `async*`             |
//
// So the same loop is checked or unchecked depending on whether its enclosing
// function is `async` — which is why F-SCD63-6 walks all of them rather than
// trusting the statement case to stand for the rest. Only the state machine's
// await-for path was reachable by the todo's own probe; four of the others were
// found by reading, after that probe came back green on a fix that had already
// landed in the visitor.
//
// IT IS A BINDING CHECK, NOT `is`. The obvious implementation — ask the
// visitor's `_valueHasType`, the predicate SCC18 extracted — is wrong twice
// over, and F-SCD63-8 and F-SCD63-9 are the two cases that say so:
//
//   • `for (final double d in [1, 2.5])` is a program real Dart ACCEPTS: the
//     literal widens. `1 is double` is false, so the `is` predicate would
//     reject it. The binding check widens instead, and binds 1.0.
//   • `is` must answer "no" to a type it cannot resolve — that is what makes it
//     a question. A binding check must wave that same type through, or a script
//     using a type from an unbridged library stops running.
//
// The check reused is the one SCC29 wrote for parameter binding, which had
// already settled both of those. This is its second caller, not a third caller
// of `_valueHasType`.
//
// THE FIX WAS REVERTED AND THE SPLIT IS THE DESIGN. Measured, `+4 -9`:
//
//   | case                                          | on revert |
//   | --------------------------------------------- | --------- |
//   | F-SCD63-1  mismatch raises TypeError           | FAILS     |
//   | F-SCD63-2  throws on the element, not up front | FAILS     |
//   | F-SCD63-5  nullability is part of it           | FAILS     |
//   | F-SCD63-6/-7  all seven execution paths        | FAIL      |
//   | F-SCD63-8  `double` widens an `int`            | FAILS     |
//   | F-SCD63-10 real subtype relation               | FAILS     |
//   | F-SCD63-11 bridged elements agree with `is`    | FAILS     |
//   | F-SCD63-12 a bound type parameter              | FAILS     |
//   | F-SCD63-3  a homogeneous loop still runs       | passes    |
//   | F-SCD63-4  irrefutable annotations             | passes    |
//   | F-SCD63-9  unresolvable stays permissive       | passes    |
//   | F-SCD63-13 the identifier form is not checked  | passes    |
//
// The four that keep passing are the point of writing them. They are not
// evidence about this defect; they are the rails. -3 and -4 stop the next
// version of this check from rejecting correct loops, -9 stops it from turning
// "I cannot resolve that" into "you are wrong", and -13 pins a known gap as a
// gap, so closing it later is a decision somebody made rather than a silent
// widening nobody noticed.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Runs [source] as a whole program and returns `main`'s result.
Object? run(String source) => D4rt().execute(source: source, name: 'main');

/// Runs [body] as the body of `Object? main()`.
Object? runBody(String body) => run('Object? main() {\n$body\n}');

/// The message of the [TypeError] [body] raises, or null when it raises none.
String? typeErrorFrom(String body) {
  try {
    runBody(body);
    return null;
  } on TypeError catch (e) {
    return e.toString();
  }
}

void main() {
  group('SCD63: a typed for-each variable is checked', () {
    test(
      'F-SCD63-1: a mismatched element raises TypeError, with the SDK wording '
      '[2026-09-12] (PASS)',
      () {
        expect(
          typeErrorFrom("for (final int x in [1, 'two', 3]) {}"),
          "type 'String' is not a subtype of type 'int'",
          reason:
              'the SDK spells a failed for-in bind with no `of` clause; '
              'matching it per construct is the point of D4rtTypeError',
        );
        expect(
          typeErrorFrom("for (String s in [1, 2]) {}"),
          "type 'int' is not a subtype of type 'String'",
        );
        // `on TypeError` in a script must catch it, not just the host.
        expect(
          run('''
            main() {
              try { for (final int x in [1, 'two']) {} return 'no throw'; }
              on TypeError { return 'caught'; }
            }
          '''),
          'caught',
        );
      },
    );

    test(
      'F-SCD63-2: it throws ON the bad element, after the good ones have run '
      '[2026-09-12] (PASS)',
      () {
        // Real Dart runs iteration 1, then throws on iteration 2. A check that
        // validated the whole iterable up front would produce no output at all,
        // which is a different program.
        expect(
          run('''
            main() {
              var seen = [];
              try { for (final int x in [1, 'two', 3]) { seen.add(x); } }
              on TypeError { seen.add('threw'); }
              return seen;
            }
          '''),
          [1, 'threw'],
        );
      },
    );

    test('F-SCD63-3: a homogeneous loop is untouched [2026-09-12] (PASS)', () {
      expect(
        runBody('''
          var out = [];
          for (final int x in [1, 2, 3]) { out.add(x + 1); }
          return out;
        '''),
        [2, 3, 4],
      );
      expect(
        runBody('''
          var out = [];
          for (final String s in ['a', 'b']) { out.add(s.toUpperCase()); }
          return out;
        '''),
        ['A', 'B'],
      );
    });

    test('F-SCD63-4: irrefutable annotations still admit everything '
        '[2026-09-12] (PASS)', () {
      // `var`, `dynamic`, `Object?` and `void` each admit anything, and each
      // reaches the check by a different exit — an untyped node, the name
      // test, the nullable branch, the name test again. A fix that closed
      // only one of them would look right on the other three.
      expect(
        runBody(
          "var out = []; "
          "for (var x in [1, 'two', null]) { out.add(x); } return out;",
        ),
        [1, 'two', null],
      );
      expect(
        runBody(
          "var out = []; "
          "for (dynamic x in [1, 'two', null]) { out.add(x); } return out;",
        ),
        [1, 'two', null],
      );
      expect(
        runBody(
          "var out = []; "
          "for (Object? x in [1, 'two', null]) { out.add(x); } return out;",
        ),
        [1, 'two', null],
      );
      expect(
        runBody(
          "var out = []; "
          "for (void v in [1, 'two']) { out.add(v); } return out;",
        ),
        [1, 'two'],
      );
    });

    test(
      'F-SCD63-5: nullability is part of the question [2026-09-12] (PASS)',
      () {
        // `int?` takes the null and still rejects the String…
        expect(
          runBody(
            "var out = []; "
            "for (final int? x in [1, null]) { out.add(x); } return out;",
          ),
          [1, null],
        );
        expect(
          typeErrorFrom("for (final int? x in [1, null, 'two']) {}"),
          "type 'String' is not a subtype of type 'int?'",
        );
        // …and the non-nullable spelling rejects the null, which is the half a
        // "null always passes" shortcut would get wrong.
        expect(
          typeErrorFrom('for (final int x in [1, null]) {}'),
          "type 'Null' is not a subtype of type 'int'",
        );
      },
    );

    test(
      'F-SCD63-6: every for-each execution path checks [2026-09-12] (PASS)',
      () {
        const bad = "[1, 'two']";
        // Sync statement — the visitor's own loop.
        expect(typeErrorFrom('for (final int x in $bad) {}'), isNotNull);
        // Collection-literal element — a separate implementation in the
        // visitor, reached only from inside a list/set/map literal.
        expect(
          typeErrorFrom('return [for (final int x in $bad) x];'),
          isNotNull,
        );
        // The five paths that run through futures are asserted in F-SCD63-7,
        // where the result can be awaited.
      },
    );

    test(
      'F-SCD63-7: the async and generator paths check too [2026-09-12] (PASS)',
      () async {
        Future<String> outcome(String source) async {
          try {
            final r = run(source);
            await (r is Future ? r : Future<Object?>.value(r));
            return 'no throw';
          } on TypeError {
            return 'caught';
          }
        }

        // NON-EMPTY BODIES THROUGHOUT, and not for tidiness: a for-in with an
        // EMPTY block body inside an `async` function does not run at all —
        // `main() async { for (final int x in [1, 'two']) {} return 'ran'; }`
        // returns null, losing the statements after the loop as well. Measured
        // against the pre-SCD63 build too, so it is an independent state-machine
        // defect, not this change; filed separately. Written with `{}` here,
        // these cases would report 'no throw' for a reason that has nothing to
        // do with the check.

        // for-in inside async (state machine, both environment branches)
        expect(
          await outcome(
            "main() async { var o = []; "
            "for (final int x in [1, 'two']) { o.add(x); } return o; }",
          ),
          'caught',
        );
        // …and with an await in the body, which suspends mid-loop and resumes
        // through the other branch of the same site.
        expect(
          await outcome('''
            Future<int> d(int v) async => v;
            main() async {
              var o = [];
              for (final int x in [1, 'two']) { o.add(await d(x)); }
              return o;
            }
          '''),
          'caught',
        );
        // await-for over a stream
        expect(
          await outcome('''
            Stream<Object> gen() async* { yield 1; yield 'two'; }
            main() async { var o = []; await for (final int x in gen()) { o.add(x); } return o; }
          '''),
          'caught',
        );
        // sync* generator
        expect(
          await outcome('''
            Iterable<Object> g() sync* { for (final int x in [1, 'two']) { yield x; } }
            main() => g().toList();
          '''),
          'caught',
        );
        // async* generator
        expect(
          await outcome('''
            Stream<Object> g() async* { for (final int x in [1, 'two']) { yield x; } }
            main() async { await g().toList(); }
          '''),
          'caught',
        );

        // The matching controls: none of those paths breaks a correct loop.
        expect(
          await outcome(
            "main() async { var o = []; "
            "for (final int x in [1, 2]) { o.add(x); } return o; }",
          ),
          'no throw',
        );
        expect(
          await outcome('''
            Stream<int> gen() async* { yield 1; yield 2; }
            main() async { var o = []; await for (final int x in gen()) { o.add(x); } return o; }
          '''),
          'no throw',
        );
        expect(
          await outcome('''
            Iterable<int> g() sync* { for (final int x in [1, 2]) { yield x * 2; } }
            main() => g().toList();
          '''),
          'no throw',
        );
      },
    );

    test(
      'F-SCD63-8: `double` widens an `int`, as Dart does [2026-09-12] (PASS)',
      () {
        // `for (final double d in [1, 2.5])` COMPILES AND RUNS in real Dart:
        // the literal list is inferred `List<double>` and the 1 widens. D4rt's
        // list holds an `int`, so a check built on the `is` predicate would
        // reject a correct program — the one failure mode worse than the silent
        // pass being fixed. The binding check converts instead.
        expect(
          runBody('''
          var out = [];
          for (final double d in [1, 2.5]) { out.add(d); }
          return out;
        '''),
          [1.0, 2.5],
        );
        // The conversion is real, not a pass-through: the body sees a double.
        expect(
          runBody(
            "for (final double d in [1]) { return d.isFinite && d is double; }",
          ),
          isTrue,
        );
      },
    );

    test('F-SCD63-9: an unresolvable annotation stays permissive '
        '[2026-09-12] (PASS)', () {
      // A name the interpreter cannot resolve is "I do not know", and a
      // binding check must not turn that into "you are wrong" — scripts run
      // against partially-bridged libraries by design. `is` answers such a
      // name with a lookup failure, which is correct FOR `is` and wrong here.
      expect(
        runBody(
          "var out = []; "
          "for (final Nope n in [1, 2]) { out.add(n); } return out;",
        ),
        [1, 2],
      );
    });

    test('F-SCD63-10: user classes use the real subtype relation '
        '[2026-09-12] (PASS)', () {
      const decls = '''
          class Animal {}
          class Dog extends Animal { String toString() => 'Dog'; }
          class Cat extends Animal { String toString() => 'Cat'; }
        ''';
      // A subtype binds…
      expect(
        run(
          '$decls main() { var out = []; '
          'for (final Animal a in [Dog(), Cat()]) { out.add(a.toString()); } '
          'return out; }',
        ),
        ['Dog', 'Cat'],
      );
      // …and a sibling does not. Name equality would accept neither; "any
      // instance is any class" would accept both.
      try {
        run('$decls main() { for (final Dog d in <Animal>[Dog(), Cat()]) {} }');
        fail('expected a TypeError for the Cat');
      } on TypeError catch (e) {
        expect(e.toString(), "type 'Cat' is not a subtype of type 'Dog'");
      }
    });

    test('F-SCD63-11: a bridged element answers the same as `is` '
        '[2026-09-12] (PASS)', () {
      // A bridged value arrives wrapped, and the wrapper is neither a List
      // nor a Map — the SCB7 shape. The binding check must agree with the
      // `is` operator on the same value, or a loop over `dart:collection`
      // views starts failing on values a script can see are Lists.
      const prelude = "import 'dart:collection';\n";
      expect(
        run('${prelude}main() => UnmodifiableListView([1, 2]) is List;'),
        isTrue,
      );
      expect(
        run(
          '${prelude}main() { var out = []; '
          'for (final List l in [UnmodifiableListView([1, 2]), [3]]) '
          '{ out.add(l.length); } return out; }',
        ),
        [2, 1],
      );
      // Bridged iterables as the SOURCE are the other half: `Map.keys` is not
      // a plain List either.
      expect(
        runBody(
          "var out = []; "
          "for (final int k in {1: 'a', 2: 'b'}.keys) { out.add(k); } return out;",
        ),
        [1, 2],
      );
      expect(
        typeErrorFrom("for (final int k in {1: 'a', 'b': 2}.keys) {}"),
        "type 'String' is not a subtype of type 'int'",
      );
    });

    test('F-SCD63-12: a generic type parameter is checked against its binding '
        '[2026-09-12] (PASS)', () {
      // `T` resolves to what the call supplied, so `f<int>` rejects the
      // String. This is not free: a `T` that resolves to a placeholder rather
      // than to a type must be waved through instead, which is why the check
      // tests the RESOLVED type rather than the spelling.
      expect(
        runBody(
          "var out = []; "
          "for (final T x in [1, 2]) { out.add(x); } return out;",
        ),
        [1, 2],
        reason: 'an unbound `T` at top level resolves to nothing checkable',
      );
      try {
        run('''
            f<T>(List items) { for (final T x in items) {} }
            main() => f<int>([1, 'two']);
          ''');
        fail('expected a TypeError');
      } on TypeError catch (e) {
        expect(e.toString(), "type 'String' is not a subtype of type 'int'");
      }
    });

    test('F-SCD63-13: the identifier form is deliberately NOT checked here '
        '[2026-09-12] (PASS)', () {
      // `for (x in xs)` carries no annotation on the loop: the type was
      // written at `x`'s own declaration, which this node does not reach.
      // Real Dart does reject this, so the case is a KNOWN GAP pinned as it
      // stands — the same gap as a plain `int x = someString;`, which is a
      // separate site with a far wider blast radius.
      expect(
        runBody(
          "int x = 0; var out = []; "
          "for (x in [1, 'two']) { out.add(x); } return out;",
        ),
        [1, 'two'],
      );
    });
  });
}
