// SCE113 — `Function.apply`'s named arguments are keyed by Symbol, which is
// the only spelling Dart accepts.
//
// The SDK declares `Function.apply(Function, List?, [Map<Symbol, dynamic>?])`.
// The adapter read `Map<String, Object?>`, because that is what d4rt's own
// `Callable.call` takes — so the only spelling a script could use was
// `{'b': 2}`, which no Dart program can contain, and `{#b: 2}`, the spelling
// every Dart author writes, threw. The named-argument half of `Function.apply`
// had therefore never worked for any legal program.
//
// WHY THAT MATTERS more than a wrong key type: `Function.apply` is how a script
// calls a function whose parameters it does not know statically. There is no
// other route to that, so the failure removes the escape hatch rather than
// inconveniencing a caller.
//
// SCD70 MADE IT VISIBLE RATHER THAN CAUSING IT. Before that sweep the adapter
// cast, and every call — String keys included — died with an opaque `_TypeError`
// about `_Map<Object?, Object?>`. Replacing the cast with a coercion produced a
// message that names `Symbol`, which is what turned an unreadable failure into
// a diagnosis. Neither spelling worked before it.
//
// THE NEIGHBOURS WERE MEASURED, as SCD68 and SCD70 both found worth doing, and
// `Function.apply` is the only site. `Invocation.method`/`.genericMethod` take
// the same `Map<Symbol, …>` and were already right — they `cast<Symbol,
// Object?>` and keep Symbols all the way through, and the interpreter's own
// `noSuchMethod` path builds Symbol keys from names. F-SCE113-8 pins that,
// because "translate Symbol keys to names" applied one file wider would break
// it.
//
// STRING KEYS ARE REJECTED, not accepted alongside Symbols. d4rt matches the
// SDK per construct — the posture SCD62, SCD64 and SCD68 each settled on — so
// that a script ported from Dart behaves the same and a script written against
// d4rt still compiles as Dart. The compatibility argument for accepting both
// is about a user who cannot exist: the String spelling only started working in
// SCD70's commit on 2026-09-12 and has never been published.
//
// ABLATED 2026-09-22, by restoring the `D4.coerceMap<String, Object?>` call
// and the `as List<Object?>` cast beside it: 7 of 9 fail. -1, -2, -3, -6 and
// -9 fail because the legal spellings throw; -4 and -5 fail on the message,
// which named `String` as the expected key type — the defect stated as a
// requirement. Only -7 and -8 pass under both, which is what they are for.
//
// -5 WAS PREDICTED TO PASS ABLATED and does not, which is worth keeping:
// rejecting `{3: 2}` looked like behaviour the fix could not have changed,
// because a non-Symbol key was refused either way. The old refusal said the
// key should have been a `String`, so the case was pinning the defect's own
// story about itself.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Runs [body] as the body of `main`, with `f(a, {b, c})` in scope.
///
/// `f` returns a digit-per-parameter number rather than a string so that a
/// named argument landing on the wrong parameter is a different answer, not a
/// differently-ordered one.
Object? apply(String body) => D4rt().execute(
  source: 'f(a, {b = 0, c = 0}) => a + b * 10 + c * 100;\nmain() { $body }',
  name: 'main',
);

/// The message of the [ArgumentD4rtException] [body] raises.
String rejection(String body) {
  try {
    apply(body);
  } on ArgumentD4rtException catch (e) {
    return e.toString();
  }
  return 'no throw';
}

void main() {
  group('SCE113: Function.apply takes Symbol keys', () {
    test('F-SCE113-1: the legal spelling reaches the named parameter '
        '[2026-09-22] (PASS)', () {
      expect(apply('return Function.apply(f, [1], {#b: 2});'), 21);
    });

    test('F-SCE113-2: a Symbol built by the constructor is the same key '
        '[2026-09-22] (PASS)', () {
      // `#b` and `Symbol('b')` are `==` and hash-equal, so a script may mix
      // them; the name extraction must not depend on which route produced it.
      expect(apply("return Function.apply(f, [1], {Symbol('b'): 2});"), 21);
    });

    test('F-SCE113-3: several named arguments, alongside positional ones '
        '[2026-09-22] (PASS)', () {
      expect(apply('return Function.apply(f, [1], {#b: 2, #c: 3});'), 321);
      // Declaration order is not call order — `c` first still lands on `c`.
      expect(apply('return Function.apply(f, [1], {#c: 3, #b: 2});'), 321);
      // A closure, not a declared function: the callee is a `Callable` either
      // way, so the translated names have to reach both.
      expect(
        apply(
          'var h = (a, {b = 0}) => a + b; '
          'return Function.apply(h, [1], {#b: 2});',
        ),
        3,
      );
    });

    test('F-SCE113-4: a String key is rejected, and the message shows the '
        'legal spelling [2026-09-22] (PASS)', () {
      final message = rejection("return Function.apply(f, [1], {'b': 2});");
      expect(message, contains('keyed by Symbol, not String'));
      // The remedy, not just the diagnosis: the reader is told what to write,
      // spelled with their own parameter name.
      expect(message, contains('{#b: ...}'));
      expect(message, contains("{'b': ...}"));
    });

    test('F-SCE113-5: a key of any other type names its own type '
        '[2026-09-22] (PASS)', () {
      expect(
        rejection('return Function.apply(f, [1], {3: 2});'),
        contains('keyed by Symbol, not int'),
      );
      // A map is still required, and the message says so rather than reporting
      // an absent key type.
      expect(
        rejection('return Function.apply(f, [1], 5);'),
        contains('expected Map<Symbol, dynamic>, got int'),
      );
    });

    test('F-SCE113-6: both argument lists are nullable, and null means none '
        '[2026-09-22] (PASS)', () {
      // The SDK declares `List?` and `Map<Symbol, dynamic>?`. Passing `null`
      // is legal and means "no arguments" — it used to be an error for both.
      expect(apply('return Function.apply(f, [1], null);'), 1);
      expect(
        apply('return Function.apply((({b = 0}) => b), null, {#b: 7});'),
        7,
      );
    });

    test('F-SCE113-7 (control): the forms that already worked still work '
        '[2026-09-22] (PASS)', () {
      expect(apply('return Function.apply(f, [1]);'), 1);
      expect(apply('return Function.apply(f, [1], {});'), 1);
      expect(apply('return Function.apply((a) => a * 2, [4]);'), 8);
    });

    test('F-SCE113-8 (control): the Symbol-keyed neighbours are untouched '
        '[2026-09-22] (PASS)', () {
      // `Invocation` takes the same `Map<Symbol, …>` and keeps it Symbol-keyed
      // all the way through — the SDK exposes `namedArguments` as
      // `Map<Symbol, dynamic>`, so translating names here would be the defect
      // rather than the fix.
      expect(
        apply(
          'var i = Invocation.method(#f, [1], {#b: 2}); '
          'return i.namedArguments[#b];',
        ),
        2,
      );
      expect(apply('var i = Invocation.getter(#g); return i.memberName;'), #g);
      // The interpreter's own noSuchMethod path is the other direction —
      // names in, Symbols out — and is what the Invocation shape has to match.
      expect(
        D4rt().execute(
          source:
              'class A { noSuchMethod(i) => i.namedArguments[#b]; }\n'
              'main() { dynamic a = A(); return a.foo(1, b: 2); }',
          name: 'main',
        ),
        2,
      );
    });

    test('F-SCE113-9: an unknown name still reports the parameter, not the key '
        '[2026-09-22] (PASS)', () {
      // The translation must not swallow the arity check behind it: once the
      // key is a name, a name that matches nothing is the callee's error.
      expect(
        () => apply('return Function.apply(f, [1], {#zz: 2});'),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'message',
            contains("does not have a parameter named 'zz'"),
          ),
        ),
      );
    });
  });
}
