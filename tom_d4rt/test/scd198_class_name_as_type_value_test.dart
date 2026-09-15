// A bare class name is a VALUE, and it has to behave like the `Type` it names.
//
// WHAT WAS WRONG, and the todo's own list is the right way in:
//
//     if (x.runtimeType == Foo)         silently always false
//     Map<Type, Handler> keyed on names every lookup misses
//     Set<Type>, List<Type>, Type param
//     SomeClass is Type                 false
//
// The first of those had already been repaired — `visitBinaryExpression`
// reconciles a `Type` against a `BridgedClass` by comparing native types, which
// is why `x.runtimeType == Foo` answers correctly today for bridged AND
// interpreted classes. Re-measured before anything was changed, and it is worth
// stating because the todo's headline says otherwise: the dangerous idiom
// works.
//
// WHAT WAS LEFT WAS SHARPER THAN THE TODO'S DIAGNOSIS. Measured on
// `tom_d4rt` 1.126.0:
//
//     String == "x".runtimeType          true
//     String.hashCode                    264367907
//     "x".runtimeType.hashCode           740950697
//
// Equal objects with different hash codes. That is an `Object` contract
// violation, and it explains the symptom set exactly: `==` answers correctly
// and every hash-based collection misses. It is SCC32's shape — that todo fixed
// it for `BridgedInstance` wrappers — arriving on the class-name value, which
// SCC32 did not cover.
//
// THE FIX IS SCC32's, IN BOTH HALVES, because one half alone makes things
// worse. SCC32's header explains why and the same applies here:
//
//   1. `BridgedClass` delegates `==` and `hashCode` to its `nativeType`.
//   2. A class name used as a HASH KEY is normalised to that native at
//      STORAGE, in `_unwrapHashKey`.
//
// With only (1), `{String: v}[x.runtimeType]` still missed: Dart's hash lookup
// asks `lookupKey == storedKey` with the lookup key as receiver, so a native
// `Type` looking up a stored `BridgedClass` is rejected by `Type.==`, which no
// code here can override. Measured at that midpoint — `m[String]` worked and
// `m[x.runtimeType]` did not, which is the two spellings disagreeing rather
// than being uniformly wrong. (2) removes the choice.
//
// `is Type` IS A THIRD THING and is fixed separately: a class name evaluates to
// a `BridgedClass` or an `InterpretedClass`, neither of which is a Dart `Type`,
// so the `is` predicate needed an arm. Without it the answer was false for
// every class in the language while `x.runtimeType is Type` was true.
//
// EACH OF THE THREE CHANGES HAS BEEN SEEN TO FAIL, and which cases each one
// takes down is the map of what it is for:
//
//   | Reverted                                   | Fires      |
//   | ------------------------------------------ | ---------- |
//   | `BridgedClass` `==` / `hashCode`           | 3, 4, 5    |
//   | the `_unwrapHashKey` normalisation         | 4, 5       |
//   | the `is Type` arm                          | 1          |
//
// The first two rows overlapping on 4 and 5 is the point SCC32 makes: neither
// half alone gets a hash-based collection right, and the first without the
// second leaves the two map spellings disagreeing.
//
// EVERY EXPECTATION HERE WAS COMPUTED AGAINST REAL DART. `identical(String,
// 'x'.runtimeType)` is TRUE in Dart and is deliberately not asserted: this fix
// makes the two compare equal and hash alike, not become one object, and
// pinning identity would pin something the fix does not deliver.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? _run(String source) {
  const path = 'd4rt-mem:/scd198_class_name_as_type_value.dart';
  return D4rt().execute(library: path, name: 'main', sources: {path: source});
}

/// [body] as the whole of `main`.
Object? _script(String body) => _run('Object? main() {\n$body\n}\n');

void main() {
  group('SCD198: a class name used as a value', () {
    test('F-SCD198-1: `SomeClass is Type` is true, bridged and interpreted '
        '[2026-09-15] (PASS)', () {
      // The check a script writes before using a value as a type at all. Both
      // kinds, or the fix trades one asymmetry for another.
      expect(_script('return String is Type;'), isTrue);
      expect(_run('class Foo {}\nObject? main() => Foo is Type;'), isTrue);
      expect(_script('return "x".runtimeType is Type;'), isTrue);
    });

    test('F-SCD198-2: nothing else became a Type [2026-09-15] (PASS)', () {
      // The arm added for F-SCD198-1 widens a predicate, and a widened
      // predicate is the easiest place to say yes to everything. Each of these
      // is a value a script routinely tests.
      expect(_script('return 42 is Type;'), isFalse);
      expect(_script('return "s" is Type;'), isFalse);
      expect(_script('return null is Type;'), isFalse);
      expect(_script('return [1] is Type;'), isFalse);
      expect(_run('class Foo {}\nObject? main() => Foo() is Type;'), isFalse);
    });

    test('F-SCD198-3: equality and hashing agree [2026-09-15] (PASS)', () {
      // The `Object` contract. `==` answered correctly before this work and
      // `hashCode` did not, which is the whole reason the collections missed
      // while the comparison looked fine.
      expect(_script('return "x".runtimeType == String;'), isTrue);
      expect(_script('return String == "x".runtimeType;'), isTrue);
      expect(
        _script('return String.hashCode == "x".runtimeType.hashCode;'),
        isTrue,
      );
      // And not everything is equal to everything.
      expect(_script('return String == int;'), isFalse);
      expect(_script('return String.hashCode == int.hashCode;'), isFalse);
    });

    test('F-SCD198-4: both map spellings reach the same entry [2026-09-15] '
        '(PASS)', () {
      // The midpoint of this fix had `m[String]` working and
      // `m[x.runtimeType]` not — two spellings disagreeing, which SCC32 argues
      // is worse than being uniformly wrong. Both are asserted for that reason,
      // and `containsKey` beside `[]` because they reach the map by different
      // routes: `[]` passes the key through untouched, `containsKey` is a
      // bridge call that unwraps its arguments on the way in.
      expect(
        _script(
          'final m = <Type, String>{String: "s", int: "i"};\n'
          'return "\${m["x".runtimeType]},\${m[1.runtimeType]}";',
        ),
        equals('s,i'),
      );
      expect(
        _script('final m = <Type, String>{String: "s"};\nreturn m[String];'),
        equals('s'),
      );
      expect(
        _script(
          'final m = <Type, String>{String: "s"};\n'
          'return m.containsKey("x".runtimeType);',
        ),
        isTrue,
      );
      // The reverse storage direction, which worked once `==`/`hashCode`
      // agreed and is what says the fix is not one-directional.
      expect(
        _script(
          'final m = <Type, String>{"x".runtimeType: "s"};\nreturn m[String];',
        ),
        equals('s'),
      );
    });

    test('F-SCD198-5: sets and lists too [2026-09-15] (PASS)', () {
      // A set element IS a hash key and normalises like one; a list is not
      // hash-keyed and reaches the value\'s own `==`. Different mechanisms, so
      // both are asserted rather than one standing in for the other.
      expect(
        _script(
          'final s = <Type>{String};\nreturn s.contains("x".runtimeType);',
        ),
        isTrue,
      );
      expect(
        _script('final l = <Type>[int];\nreturn l.indexOf(1.runtimeType);'),
        equals(0),
      );
    });

    test('F-SCD198-6: interpreted classes answer the same way [2026-09-15] '
        '(PASS)', () {
      // These already worked, and the point of the case is that they still do:
      // the fix is on the bridged path and must not have traded one asymmetry
      // for another.
      expect(
        _run(
          'class Foo {}\n'
          'Object? main() { final x = Foo(); return x.runtimeType == Foo; }',
        ),
        isTrue,
      );
      expect(
        _run(
          'class Foo {}\n'
          'Object? main() { final m = <Type, String>{Foo: "f"};\n'
          '  return m[Foo().runtimeType]; }',
        ),
        equals('f'),
      );
    });

    test('F-SCD198-7: a class name still prints as its name [2026-09-15] '
        '(PASS)', () {
      // What made the original defect hard to see: the wrong object printed
      // exactly like the right one. It still prints that way, which is
      // correct — the point is that it now also compares and hashes like it.
      expect(_script('return String.toString();'), equals('String'));
      expect(_script('return "x".runtimeType.toString();'), equals('String'));
      expect(
        _script('Type t = String;\nreturn t.toString();'),
        equals('String'),
      );
    });
  });
}
