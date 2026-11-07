// Pull request al-the-bear/tom_d4rt#7 — an interpreted class whose path to a
// bridged type runs through interpreted interfaces.
//
// Reproduced 2026-11-07 on tom_d4rt 1.235.0: with `abstract class I implements
// Shape {}` (Shape bridged), `class C implements I` was rejected at a `Shape`
// parameter and `C() is Shape` answered false. `InterpretedClass.isSubtypeOf`
// asked about a bridged target walked only the superclass chain and its
// bridged supertypes and the mixins, never the interpreted `interfaces`; and it
// accepted any bridged supertype whose NAME matched the target, so a class
// implementing one library's `Token` passed for another library's unrelated
// `Token`.
//
// Now the question is a walk over the whole interpreted supertype graph
// (superclass, mixins, interfaces), each class visited once, with every bridged
// supertype it reaches asked `BridgedClass.isSubtypeOf` — native identity, the
// registered hierarchy — and never compared by name.
//
// The cases follow the PR's description (native controls, direct and
// transitive interfaces, inherited and mixin paths, a diamond, a cycle,
// unrelated types, same-name bridges); the fix is this repo's own.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

abstract class Gh7Shape {
  String describe();
}

class Gh7Circle implements Gh7Shape {
  @override
  String describe() => 'circle';
}

/// Two unrelated native classes, each bridged under the name `Gh7Token`.
class _TokenA {}

class _TokenB {}

D4rt _interpreter() {
  BridgedClass.registerSupertypes({
    'Gh7Circle': ['Gh7Shape'],
  });
  return D4rt()
    ..registerBridgedClass(
      BridgedClass(nativeType: Gh7Shape, name: 'Gh7Shape', isAbstract: true),
      'package:shapes/shapes.dart',
    )
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh7Circle,
        name: 'Gh7Circle',
        constructors: {'': (visitor, positional, named) => Gh7Circle()},
      ),
      'package:shapes/shapes.dart',
    )
    ..registerBridgedClass(
      BridgedClass(nativeType: _TokenA, name: 'Gh7Token', isAbstract: true),
      'package:a/a.dart',
    )
    ..registerBridgedClass(
      BridgedClass(nativeType: _TokenB, name: 'Gh7Token', isAbstract: true),
      'package:b/b.dart',
    );
}

/// [declarations] after the shapes import, `String take(Gh7Shape s)` and
/// `main() => <expression>`.
Object? run(String declarations, String expression) => _interpreter().execute(
  source:
      "import 'package:shapes/shapes.dart';\n"
      '$declarations\n'
      "String take(Gh7Shape s) => 'ok';\n"
      'main() => $expression;',
);

final _rejected = throwsA(
  predicate(
    (Object e) => e.toString().contains("is not a subtype of type 'Gh7Shape'"),
    'a parameter type error naming Gh7Shape',
  ),
);

/// `package:p/ua.dart` sees library a's `Gh7Token` and declares [userA] plus
/// `takeA` / `isA` and [extraA]; `main.dart` sees library b's and declares
/// `takeB` / `isB`, then evaluates [expression]. The two bridges are never in
/// one scope, as two packages' same-named classes are not.
Object? tokens(String userA, String extraA, String expression) =>
    _interpreter().execute(
      library: 'package:p/main.dart',
      sources: {
        'package:p/ua.dart':
            "import 'package:a/a.dart';\n"
            "import 'package:p/ub.dart';\n"
            '$userA\n'
            "String takeA(Gh7Token t) => 'a';\n"
            'bool isA(Object? x) => x is Gh7Token;\n'
            '$extraA',
        'package:p/ub.dart':
            "import 'package:b/b.dart';\n"
            "String takeB(Gh7Token t) => 'b';\n"
            'bool isB(Object? x) => x is Gh7Token;',
        'package:p/main.dart':
            "import 'package:p/ua.dart';\n"
            "import 'package:p/ub.dart';\n"
            'main() => $expression;',
      },
    );

final _rejectedToken = throwsA(
  predicate(
    (Object e) => e.toString().contains("is not a subtype of type 'Gh7Token'"),
    'a parameter type error naming Gh7Token',
  ),
);

const _viaI =
    'abstract class I implements Gh7Shape {}\n'
    "class ViaI implements I { String describe() => 'viaI'; }";

void main() {
  group('PR #7: native controls', () {
    test('GH7-1: a native subtype binds to the bridged parameter '
        '[2026-11-07]', () {
      expect(run('', 'take(Gh7Circle())'), 'ok');
    });

    test('GH7-2: a native subtype `is` the bridged type [2026-11-07]', () {
      expect(run('', 'Gh7Circle() is Gh7Shape'), true);
    });
  });

  group('PR #7: interpreted paths to a bridged type', () {
    test('GH7-3: a direct `implements` [2026-11-07]', () {
      expect(
        run(
          "class Direct implements Gh7Shape { String describe() => 'd'; }",
          '[take(Direct()), Direct() is Gh7Shape]',
        ),
        ['ok', true],
      );
    });

    test('GH7-4: through an interpreted interface that implements it '
        '[2026-11-07]', () {
      expect(run(_viaI, '[take(ViaI()), ViaI() is Gh7Shape]'), ['ok', true]);
    });

    test('GH7-5: through an interpreted interface that extends it '
        '[2026-11-07]', () {
      expect(
        run(
          'abstract class J extends Gh7Shape {}\n'
              "class ViaJ implements J { String describe() => 'viaJ'; }",
          '[take(ViaJ()), ViaJ() is Gh7Shape]',
        ),
        ['ok', true],
      );
    });

    test('GH7-6: inherited from a superclass that has the interface '
        '[2026-11-07]', () {
      expect(
        run(
          '$_viaI\nclass Sub extends ViaI {}',
          '[take(Sub()), Sub() is Gh7Shape]',
        ),
        ['ok', true],
      );
    });

    test('GH7-7: through a mixin whose interface reaches it [2026-11-07]', () {
      expect(
        run(
          'abstract class I implements Gh7Shape {}\n'
              "mixin M implements I { String describe() => 'm'; }\n"
              'class WithM with M {}',
          '[take(WithM()), WithM() is Gh7Shape]',
        ),
        ['ok', true],
      );
    });

    test('GH7-8: a diamond of two interfaces [2026-11-07]', () {
      expect(
        run(
          'abstract class I implements Gh7Shape {}\n'
              'abstract class I2 implements Gh7Shape {}\n'
              "class Diamond implements I, I2 { String describe() => 'd'; }",
          '[take(Diamond()), Diamond() is Gh7Shape]',
        ),
        ['ok', true],
      );
    });
  });

  group('PR #7: what is still refused', () {
    test('GH7-9: a cyclic interface graph ends in a refusal, not a stack '
        'overflow [2026-11-07]', () {
      // Dart rejects the cycle at compile time; the interpreter does not, so
      // the walk is what has to terminate.
      const cycle =
          'abstract class A implements B {}\n'
          'abstract class B implements A {}\n'
          'class C implements A {}\n'
          'class U {}';
      expect(run(cycle, '[C() is Gh7Shape, C() is U]'), [false, false]);
      expect(() => run(cycle, 'take(C())'), _rejected);
    }, timeout: const Timeout(Duration(seconds: 30)));

    test('GH7-10: an unrelated class, and one whose interfaces never reach '
        'the bridged type [2026-11-07]', () {
      expect(() => run('class U {}', 'take(U())'), _rejected);
      const other =
          'abstract class Other {}\n'
          'abstract class Mid implements Other {}\n'
          'class V implements Mid {}';
      expect(run(other, 'V() is Gh7Shape'), false);
      expect(() => run(other, 'take(V())'), _rejected);
    });

    test('GH7-11: a bridge of the same name over another native type is not '
        'the type [2026-11-07]', () {
      expect(
        tokens(
          'class X implements Gh7Token {}',
          'Object? check(Object? x) => [takeA(x), isA(x), isB(x)];',
          'check(X())',
        ),
        ['a', true, false],
      );
      expect(
        () => tokens('class X implements Gh7Token {}', '', 'takeB(X())'),
        _rejectedToken,
      );
    });

    test('GH7-12: nor through an interpreted interface [2026-11-07]', () {
      const viaI =
          'abstract class I implements Gh7Token {}\n'
          'class X implements I {}';
      expect(
        tokens(
          viaI,
          'Object? check(Object? x) => [takeA(x), isA(x), isB(x)];',
          'check(X())',
        ),
        ['a', true, false],
      );
      expect(() => tokens(viaI, '', 'takeB(X())'), _rejectedToken);
    });
  });
}
