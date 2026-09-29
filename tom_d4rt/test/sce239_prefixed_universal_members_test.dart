// SCE239 — `e.hashCode` and `e.runtimeType` on a bridged value answer from the
// native object, through a prefixed identifier as through a property access.
//
// The analyzer-free tree has answered these two before consulting any member
// map (GEN-075) in both `visitPropertyAccess` and `visitPrefixedIdentifier`.
// This tree had the read in `visitPropertyAccess` only (SCC78 aligned that one),
// so `e.hashCode` on a variable reached the bridge's maps, and a bridge that
// declared no `hashCode` getter, or declared it as a method, answered wrongly
// here (the bound method, not an int) and correctly in the twin. One line of mirror divergence with a
// behavioural consequence, found while writing SCD196's twin case.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

class _Plain {}

Object? _run(String body) {
  final d4rt = D4rt()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: _Plain,
        name: 'Plain',
        constructors: {'': (visitor, positional, named) => _Plain()},
        // Misdeclared on purpose, as `MapEntry.hashCode` once was: a METHOD
        // where `Object` declares a getter. F-SCD189-1 catches this shape in
        // the stdlib; a user bridge has no such guard, so the reader must not
        // depend on it.
        methods: {
          'hashCode': (visitor, target, positional, named, _) =>
              (target as _Plain).hashCode,
          'runtimeType': (visitor, target, positional, named, _) =>
              (target as _Plain).runtimeType,
        },
      ),
      'package:test/plain.dart',
    );
  return d4rt.execute(
    source: "import 'package:test/plain.dart';\nObject? main() { $body }",
  );
}

void main() {
  test('F-SCE239-1: a bridge that misdeclares hashCode as a method still '
      'answers e.hashCode with an int [2026-09-29] (PASS)', () {
    expect(_run('final e = Plain(); return e.hashCode is int;'), isTrue);
  });

  test('F-SCE239-2: e.runtimeType is the native type, not the wrapper '
      '[2026-09-29] (PASS)', () {
    expect(_run('final e = Plain(); return e.runtimeType;'), _Plain);
  });
}
