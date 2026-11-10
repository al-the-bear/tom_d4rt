// ghissues19 — an enum's `implements` and `with` clauses make it a subtype.
//
// Measured 2026-11-09 on this tree (1.240.0): the members of an enum's mixins
// and interfaces were reachable, but every subtype question answered no.
// `InterpretedEnum.isSubtypeOf` answered only for the enum itself and
// `Object`, the `implements` clause was never read (an undefined interface was
// accepted), and `is` with an interpreted class on the right gave false for
// any enum value:
//
//   enum E implements C { a; int c() => 7; }
//   E.a is C              -> false              (Dart: true)
//   int take(C x) => ...; take(E.a)
//                         -> type 'E' is not a subtype of type 'C' of 'x'
//   List<C> l = [E.a]     -> type 'List<E>' is not a subtype of type 'List<C>'
//   E.a is Enum           -> false              (Dart: true)
//
// Now the enum records its interfaces and answers for them, its mixins, their
// supertypes and `Enum`; an undefined interface is reported, and one declared
// in a library still loading is resolved once the load returns (GitHub #9).

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

import 'interpreter_test.dart' show execute;

const _types = '''
abstract class C { int c(); }
abstract class D extends C {}
mixin F { int f() => 3; }
''';

abstract class Gh13Shape {
  String shape();
}

D4rt _bridged() => D4rt()
  ..registerBridgedClass(
    BridgedClass(nativeType: Gh13Shape, name: 'Gh13Shape', isAbstract: true),
    'package:shapes/shapes.dart',
  );

/// Throws whose message contains [part].
Matcher _refusedWith(String part) => throwsA(
  predicate((Object e) => e.toString().contains(part), 'an error naming $part'),
);

void main() {
  group(
    'ghissues19: an enum is a subtype of what it implements and mixes in',
    () {
      test('GHI19-1: `is` an implemented interface, an applied mixin, Enum and '
          'Object [2026-11-09]', () {
        expect(
          execute(
            '${_types}enum E with F implements C { a; int c() => 7; }\n'
            'main() => [E.a.c(), E.a.f(), E.a is C, E.a is F, E.a is Enum, '
            'E.a is Object];',
          ),
          [7, 3, true, true, true, true],
        );
      });

      test('GHI19-2: a typed parameter, a typed list element and a cast '
          '[2026-11-09]', () {
        expect(
          execute(
            '${_types}enum E implements C { a; int c() => 7; }\n'
            'int take(C x) => x.c();\n'
            'main() { List<C> l = [E.a]; final C viaCast = E.a as C; '
            'return [take(E.a), l.first.c(), viaCast.c()]; }',
          ),
          [7, 7, 7],
        );
      });

      test('GHI19-3: an interface reached through another interface '
          '[2026-11-09]', () {
        expect(
          execute(
            '${_types}enum E implements D { a; int c() => 9; }\n'
            'main() => [E.a is D, E.a is C];',
          ),
          [true, true],
        );
      });

      test('GHI19-4: a bridged interface, in `is` and a typed parameter '
          '[2026-11-09]', () {
        expect(
          _bridged().execute(
            source:
                "import 'package:shapes/shapes.dart';\n"
                "enum E implements Gh13Shape { a; String shape() => 's'; }\n"
                'String take(Gh13Shape s) => s.shape();\n'
                'main() => [E.a is Gh13Shape, take(E.a)];',
          ),
          [true, 's'],
        );
      });

      test('GHI19-5: an unrelated class is not a supertype, and an undefined '
          'interface is reported [2026-11-09]', () {
        expect(
          execute(
            '${_types}enum E with F { a }\n'
            'int take(C x) => 1;\n'
            'main() => [E.a is C, E.a is D];',
          ),
          [false, false],
        );
        expect(
          () => execute(
            '${_types}enum E with F { a }\n'
            'int take(C x) => 1;\n'
            'main() => take(E.a);',
          ),
          _refusedWith("type 'E' is not a subtype of type 'C' of 'x'"),
        );
        expect(
          () => execute('enum E implements Missing { a }\nmain() => 1;'),
          _refusedWith("Interface 'Missing' not found for enum 'E'"),
        );
      });

      test('GHI19-6: an interface declared in a library still loading '
          '[2026-11-09]', () {
        // main imports a.dart, whose import of b.dart loads first; b.dart
        // imports a.dart back, still loading, so E is declared before C.
        expect(
          D4rt().execute(
            library: 'package:p/main.dart',
            sources: {
              'package:p/main.dart':
                  "import 'package:p/a.dart';\n"
                  "import 'package:p/b.dart';\n"
                  'main() => [E.a is C, E.a.c()];',
              'package:p/a.dart':
                  "import 'package:p/b.dart';\n"
                  'abstract class C { int c(); }',
              'package:p/b.dart':
                  "import 'package:p/a.dart';\n"
                  'enum E implements C { a; int c() => 5; }',
            },
          ),
          [true, 5],
        );
      });
    },
  );
}
