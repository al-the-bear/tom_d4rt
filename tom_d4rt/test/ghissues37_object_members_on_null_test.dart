// ghissues37 — Object's members answer on null, as in Dart.
//
// Measured 2026-11-10 on this tree (1.253.0), `Object? v;`:
//
//   v.runtimeType     // threw "Cannot access property 'runtimeType' on target of type null."
//   v.toString()      // threw "Cannot invoke method 'toString' on null. ..."
//   v.hashCode        // threw
//   null.runtimeType  // threw
//   '$v'              // 'null' - correct
//   v == null         // true - correct
//
// Dart lets every value, null included, use the members `Null` inherits from
// `Object`: `toString()` ('null'), `hashCode`, `runtimeType` (`Null`), `==`
// and `noSuchMethod` (which throws a NoSuchMethodError, as for any other
// receiver). The member-access paths of both visitors answered null's target
// with the null error before looking at the member. They now answer these
// members; every other member on null is still the error. The same in
// tom_d4rt_ast (test/runtime/ghissues37_object_members_on_null_test.dart).

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? _run(String body) => D4rt().execute(
  library: 'package:p/main.dart',
  sources: {
    'package:p/main.dart':
        'class C { Object? f; }\n'
        'main() {\n'
        '  Object? v;\n'
        '  final c = C();\n'
        '  return $body;\n'
        '}\n',
  },
);

void main() {
  group('GHI37: Object members on null', () {
    test('GHI37-1: toString() through a variable, a literal and a chain '
        '[2026-11-10]', () {
      expect(_run('[v.toString(), null.toString(), c.f.toString()]'), [
        'null',
        'null',
        'null',
      ]);
    });

    test('GHI37-2: hashCode is the native null hashCode [2026-11-10]', () {
      expect(_run('[v.hashCode, null.hashCode, c.f.hashCode]'), [
        null.hashCode,
        null.hashCode,
        null.hashCode,
      ]);
    });

    test('GHI37-3: runtimeType is Null [2026-11-10]', () {
      expect(
        _run(
          "['\${v.runtimeType}', '\${null.runtimeType}', "
          "'\${c.f.runtimeType}', v.runtimeType == Null]",
        ),
        ['Null', 'Null', 'Null', true],
      );
    });

    test('GHI37-4: == as a method call [2026-11-10]', () {
      expect(_run('[v == null, v == 1, c.f == null]'), [true, false, true]);
    });

    test('GHI37-5: noSuchMethod on null throws a NoSuchMethodError, as in '
        'Dart [2026-11-10]', () {
      expect(
        _run(
          '(() { try { v.noSuchMethod(Invocation.method(#m, [])); '
          "return 'no throw'; } on NoSuchMethodError { return 'NSME'; } })()",
        ),
        'NSME',
      );
    });

    test('GHI37-6: every other member on null is still an error '
        '[2026-11-10]', () {
      for (final body in ['v.length', 'v.foo()', 'c.f.isEmpty', 'null.x']) {
        expect(() => _run(body), throwsA(anything), reason: body);
      }
    });

    test('GHI37-7: a null-aware access is unchanged [2026-11-10]', () {
      expect(_run('[v?.toString(), v?.hashCode]'), [null, null]);
    });
  });
}
