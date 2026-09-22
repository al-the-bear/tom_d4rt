// SCE103 — a typed local is checked, at its declaration and at every write.
//
// The fourth and last of the sites that ask "does this value fit this written
// type", and the widest: every typed local in every script passes through it.
//
//   | site                  | closed by |
//   | --------------------- | --------- |
//   | parameter binding     | SCC29     |
//   | typed patterns        | SCC18     |
//   | for-each loop variable| SCD63     |
//   | typed local           | SCE103    |
//
// `int x = 'two';` bound the String. So did `x = 'two';` afterwards, and so did
// `for (x in ['two'])` — the for-each IDENTIFIER form, which F-SCD63-13 pinned
// as a known gap precisely because it belongs here: the loop node carries no
// annotation, the type was written at `x`'s own declaration, and checking it is
// the same job as checking any other write to `x`.
//
// WHY THIS SITE NEEDED MORE THAN A NEW CALL. The other three check at a single
// moment and remember nothing. A declaration and a later assignment are two
// moments and only the first carries the annotation, so the resolved type is
// recorded per name in the environment that declares it and consulted by
// `assign`. That is the whole of the structural difference.
//
// THE BLAST RADIUS WAS MEASURED, NOT ASSUMED, because this site is much wider
// than SCD63's and its own todo said not to size it by assumption. Across the
// reference suite: ONE behavioural failure, and it was not a false positive.
//
// `Set<int> numbers = {};` evaluated to a MAP. `{}` is a Map unless the context
// type says Set — Dart's rule — and the interpreter has no context type, so the
// literal is always a Map and the disambiguation had nowhere to happen. The
// test that failed only passed before because it asked `isEmpty`, which a Map
// answers too. Everything else about that variable was already broken:
// `s.add(1)` threw "Bridged class 'Map' has no instance method named 'add'",
// and `f(Set<int> s)` called with `{}` threw this very type error through
// SCC29's parameter check. So the declaration check did not break a working
// program; it found the fourth site of a defect three sites already had.
//
// The disambiguation lives in `ResolvedBinding.bind`, beside the `int`→`double`
// widening that is there for the same reason: Dart's own rule, expressed as a
// coercion because the written type is not available any earlier. EMPTY ONLY —
// a non-empty Map bound to a `Set` is a real error and still fails.
//
// ABLATED, by removing the declaration check and the `assign` check: `+4 -6`.
// -1 to -6 fail; the four controls pass. The survivors are the
// rails — `dynamic`, `var`, `Object` and an unresolvable annotation stay
// permissive, a correct program is untouched, `late` is left alone, and fields
// and top-level variables are not reached — and they are what stops the next
// version of this from being "reject anything that does not match by name".
//
// WHAT THE CHECK COSTS, measured 2026-09-22 (sce131), because this site runs
// every time its enclosing block does and its todo asked for the number rather
// than a guess. Per binding, on `tom_d4rt` at 1.174.0:
//
//   annotation            typed      untyped     overhead
//   int v = i;            1.33 us     0.87 us     +0.46 us
//   List<int> v = c;  n=0 3.20 us     0.93 us     +2.27 us
//                     n=1 4.42 us     0.92 us     +3.51 us
//                   n=100 13.9 us     0.96 us     +13.0 us
//                  n=1000 99.8 us     0.98 us     +98.8 us
//
// TWO FINDINGS, and the first is the one that decided not to optimise here.
// The PARAMETER site pays the same absolute price — +0.38 us for `g(int x)`
// against `g(x)` on the same machine — so a typed local is not anomalous, it
// is the standing cost of the shared check arriving at a fourth site. The
// percentage looks alarming for locals only because a local declaration is
// otherwise very cheap while a call is not.
//
// The second is not about this site at all: the overhead grows LINEARLY with
// the collection's length, about 0.096 us per element per binding, because
// SCD92's applied-type check derives a collection's type argument from its
// CONTENTS and walks every element. A 5000-element list costs half a
// millisecond every time it is bound, at all four sites. That is sce131's
// measurement and scf28's problem.
//
// THE ABLATION ALSO CORRECTED ONE OF THESE CASES. -5 survived it at first,
// because `double d = 1` returning an unwidened `1` satisfies `equals(1.0)` —
// `1 == 1.0` in Dart. It asserts `isA<double>` now. A case that cannot fail is
// not evidence, and only running the experiment says which kind you have.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? run(String source) => D4rt().execute(source: source, name: 'main');
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
  group('SCE103: a typed local is checked', () {
    test('F-SCE103-1: the declaration initialiser is checked [2026-09-22] '
        '(PASS)', () {
      expect(
        typeErrorFrom("int x = 'two'; return x;"),
        "type 'String' is not a subtype of type 'int' of 'x'",
      );
      expect(
        typeErrorFrom('String s = 1; return s;'),
        "type 'int' is not a subtype of type 'String' of 's'",
      );
      expect(
        typeErrorFrom("final int f = 'two'; return f;"),
        "type 'String' is not a subtype of type 'int' of 'f'",
      );
    });

    test('F-SCE103-2: every later write is checked too [2026-09-22] (PASS)', () {
      // The half that made this site structurally different from the other
      // three: the annotation is not here, so the declaration had to leave it
      // behind.
      expect(
        typeErrorFrom("int x = 0; x = 'two'; return x;"),
        "type 'String' is not a subtype of type 'int' of 'x'",
      );
      // Declared without an initialiser — nothing to check at the declaration,
      // and the type still has to survive to the assignment.
      expect(
        typeErrorFrom("int x; x = 'two'; return x;"),
        "type 'String' is not a subtype of type 'int' of 'x'",
      );
    });

    test('F-SCE103-3: the for-each identifier form [2026-09-22] (PASS)', () {
      // F-SCD63-13's gap, closed from the declaration side. The loop is not
      // the checker — the assignment to `x` is — which is why the message
      // names `x` where SCD63's names only the element.
      expect(
        typeErrorFrom(
          "int x = 0; var out = []; for (x in [1, 'two']) { out.add(x); } "
          'return out;',
        ),
        "type 'String' is not a subtype of type 'int' of 'x'",
      );
    });

    test('F-SCE103-4: nullability is part of the type [2026-09-22] (PASS)', () {
      expect(
        typeErrorFrom('int x = null; return x;'),
        "type 'Null' is not a subtype of type 'int' of 'x'",
      );
      expect(runBody('int? x = null; return x;'), isNull);
      expect(
        typeErrorFrom("int? x = 'two'; return x;"),
        "type 'String' is not a subtype of type 'int?' of 'x'",
      );
    });

    test('F-SCE103-5: `double` widens an `int`, as Dart does [2026-09-22] '
        '(PASS)', () {
      // Not a subtype relation — `1 is double` is false — but `double d = 1;`
      // is a program Dart accepts, and the value it produces is a double.
      //
      // `isA<double>` rather than `equals(1.0)`, and the ablation is what found
      // that: `1 == 1.0` in Dart, so the obvious assertion passes on the
      // unwidened `int` and this case survived having its own fix removed. A
      // case that cannot fail is not evidence.
      expect(runBody('double d = 1; return d;'), isA<double>());
      expect(runBody('double d = 0; d = 2; return d;'), isA<double>());
      expect(runBody('double d = 1; return d;'), 1.0);
    });

    test('F-SCE103-6: an empty `{}` in a Set context is a Set [2026-09-22] '
        '(PASS)', () {
      // Independent of the check, and older than it: before this commit
      // `s.add(1)` on such a variable threw "Bridged class 'Map' has no
      // instance method named 'add'".
      expect(runBody('Set<int> s = {}; s.add(1); return s.length;'), 1);
      expect(runBody('Set<int> s = {}; return s.isEmpty;'), isTrue);
      expect(run('f(Set<int> s) => s.length;\nmain() => f({});'), 0);
      // A Map context is untouched, and a NON-empty Map is still an error —
      // which is what keeps this a disambiguation rather than a coercion.
      expect(runBody('Map<int, int> m = {}; return m.isEmpty;'), isTrue);
      expect(
        typeErrorFrom('Set<int> s = {1: 2}; return s;'),
        "type 'Map' is not a subtype of type 'Set' of 's'",
      );
    });

    // ---- the rails ---------------------------------------------------------
    //
    // Everything above is a throw that should happen. These are the programs
    // that must keep running, and they are why this is a check rather than a
    // name comparison.

    test('F-SCE103-7 (control): permissive wherever it cannot be sure '
        '[2026-09-22] (PASS)', () {
      expect(runBody("dynamic d = 'two'; return d;"), 'two');
      expect(runBody("var v = 'two'; return v;"), 'two');
      expect(runBody("Object o = 's'; return o;"), 's');
      expect(runBody('num n = 1; return n;'), 1);
      // An annotation that does not resolve is not an accusation.
      expect(runBody("NoSuchType n = 'two'; return n;"), 'two');
    });

    test('F-SCE103-8 (control): a correct program is unaffected [2026-09-22] '
        '(PASS)', () {
      expect(runBody('int x = 1; x = 2; return x;'), 2);
      expect(runBody("String s = 'a'; s = 'b'; return s;"), 'b');
      expect(runBody('List<int> l = [1, 2]; return l.length;'), 2);
      expect(
        runBody(
          'int x = 0; var out = []; for (x in [1, 2]) { out.add(x); } '
          'return out;',
        ),
        [1, 2],
      );
    });

    test('F-SCE103-9 (control): `late` is deliberately out of scope '
        '[2026-09-22] (PASS)', () {
      // A late declaration stores a wrapper rather than a value, and the moment
      // its initialiser runs is not an assignment this can see. Recording
      // nothing leaves late locals as permissive as they were, rather than
      // half-checked — a state that is worse than either.
      expect(runBody("late int x = 'two'; return x;"), 'two');
    });

    test('F-SCE103-10 (control): fields and top-level variables are not '
        'reached [2026-09-22] (PASS)', () {
      // A separate site with a separate population. Named here so the limit is
      // a recorded decision rather than something a reader has to discover by
      // testing it.
      expect(run("class C { int v = 's'; }\nmain() { return C().v; }"), 's');
      expect(run("int g = 's';\nmain() { return g; }"), 's');
    });
    test('F-SCE103-11 (control): a declaration with NO initialiser is not '
        'accused [2026-09-22]', () {
      // sce131. The exemption this site makes deliberately, and the shape its
      // own todo asked to measure before enforcing. `int x;` defines null, and
      // null is not a write real Dart rejects there — the variable is simply
      // unassigned, and d4rt has no definite-assignment analysis to say so.
      // Accusing it would reject a correct program.
      //
      // A control in the strict sense: it survives the ablation, because it
      // asserts what happens when the check does NOT fire. F-SCE103-12 is the
      // half that makes the exemption safe rather than a hole.
      expect(runBody('int x; return x;'), isNull);
      expect(runBody('int? x; return x;'), isNull);
      expect(runBody('int x; x = 1; return x;'), 1);
      expect(runBody('int? x; x = null; return x;'), isNull);
    });

    test('F-SCE103-12: an uninitialised declaration still RECORDS its type, so '
        'the write that supplies the value is checked [2026-09-22]', () {
      // The other half of -11, and the reason the exemption is not a hole. A
      // change that moved the check into `def` would keep -11 green and break
      // this, which is exactly the pair worth having.
      expect(
        typeErrorFrom("int x; x = 'two'; return x;"),
        "type 'String' is not a subtype of type 'int' of 'x'",
      );
      expect(
        typeErrorFrom("int? x; x = 'two'; return x;"),
        "type 'String' is not a subtype of type 'int?' of 'x'",
      );
    });

    test('F-SCE103-13: `final`, `const` and multi-name declarations are '
        'checked too [2026-09-22]', () {
      // sce131. Three in-scope shapes nothing pinned. They are not separate
      // mechanisms — a declaration list holds N names and the check runs per
      // name — but "per name" is exactly the kind of thing a rewrite drops,
      // and `final` / `const` reach the same site by a different keyword.
      expect(
        typeErrorFrom("final int x = 'two'; return x;"),
        "type 'String' is not a subtype of type 'int' of 'x'",
      );
      expect(
        typeErrorFrom("const int x = 'two'; return x;"),
        "type 'String' is not a subtype of type 'int' of 'x'",
      );
      // The SECOND name in a list, so a check that only looked at the first
      // would pass -1 and fail here.
      expect(
        typeErrorFrom("int a = 1, b = 'two'; return b;"),
        "type 'String' is not a subtype of type 'int' of 'b'",
      );
      expect(runBody('int a = 1, b = 2; return a + b;'), 3);
      // A write from a CLOSURE is the same write.
      expect(
        typeErrorFrom("int x = 1; f() { x = 'two'; } f(); return x;"),
        "type 'String' is not a subtype of type 'int' of 'x'",
      );
    });
  });
}
