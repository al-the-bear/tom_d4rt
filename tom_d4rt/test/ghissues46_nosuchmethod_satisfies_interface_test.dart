// ghissues46 — GitHub #13: a class whose superclass (bridged or interpreted)
// or the class itself declares noSuchMethod satisfies the interfaces it does
// not implement.
//
// Measured 2026-11-14 on tom_d4rt 1.257.0 / tom_d4rt_ast 0.237.0, with
// Serverpod's shape - `class Sentinel extends UndefinedSentinel implements
// Contract {}`, the bridged `UndefinedSentinel` declaring `noSuchMethod`:
//
//   Sentinel() is Contract   // threw: Missing concrete implementation for
//                            //   interface method 'read' in class 'Sentinel'
//                            //   (Dart: true)
//
// Dart gives a class with a non-trivial noSuchMethod (declared or inherited,
// other than Object's) a forwarder for every member its interfaces or
// abstract superclasses leave unimplemented, so the class is valid and a call
// of such a member reaches that noSuchMethod with an Invocation. A class that
// relies on Object's noSuchMethod is still refused. Two parts: the
// declaration check (`checkInheritedMembers`) now accepts such a class, and a
// missing member now reaches a BRIDGED superclass's noSuchMethod too (it
// reached only an interpreted one) - Serverpod's sentinel throws its native
// UnsupportedError there. The same in tom_d4rt_ast
// (test/runtime/ghissues46_nosuchmethod_satisfies_interface_test.dart).

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Serverpod's `UndefinedSentinel`, reduced: a native class whose
/// noSuchMethod refuses every member.
abstract class Gh46Sentinel {
  const Gh46Sentinel();

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnsupportedError('gh46 sentinel: ${invocation.memberName}');
}

class _Gh46NativeSentinel extends Gh46Sentinel {
  const _Gh46NativeSentinel();
}

/// A native class without a noSuchMethod of its own.
class Gh46Plain {
  const Gh46Plain();
}

Object? _run(String body) {
  final d4rt = D4rt()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh46Sentinel,
        name: 'Gh46Sentinel',
        isAbstract: true,
        constructors: {
          '': (visitor, positional, named) => const _Gh46NativeSentinel(),
        },
        methods: {
          'noSuchMethod': (visitor, target, positional, named, typeArgs) =>
              (target as Gh46Sentinel).noSuchMethod(
                positional.single as Invocation,
              ),
        },
      ),
      'package:g/g.dart',
    )
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh46Plain,
        name: 'Gh46Plain',
        constructors: {
          '': (visitor, positional, named) => const Gh46Plain(),
        },
      ),
      'package:g/g.dart',
    );
  return d4rt.execute(
    library: 'package:p/main.dart',
    sources: {
      'package:p/main.dart':
          "import 'package:g/g.dart';\n"
          'abstract class Contract { String read(); int get size; }\n'
          '$body',
    },
  );
}

void main() {
  group('ghissues46: noSuchMethod satisfies an interface', () {
    test('GHI46-1: a bridged superclass with noSuchMethod - the class is '
        'valid and implements the interface (GitHub #13) [2026-11-14]', () {
      expect(
        _run(
          'class Sentinel extends Gh46Sentinel implements Contract {}\n'
          'bool main() => Sentinel() is Contract;',
        ),
        isTrue,
      );
    });

    test('GHI46-2: a missing method and getter reach the bridged '
        'noSuchMethod, which throws its native UnsupportedError '
        '[2026-11-14]', () {
      expect(
        _run(
          'class Sentinel extends Gh46Sentinel implements Contract {}\n'
          'List<Object?> main() {\n'
          '  final Contract c = Sentinel();\n'
          '  final out = <Object?>[];\n'
          '  try { c.read(); } on UnsupportedError catch (e) { out.add(e.message); }\n'
          '  try { c.size; } on UnsupportedError catch (e) { out.add(e.message); }\n'
          '  return out;\n'
          '}',
        ),
        [
          'gh46 sentinel: Symbol("read")',
          'gh46 sentinel: Symbol("size")',
        ],
      );
    });

    test('GHI46-3: an interpreted superclass with noSuchMethod - valid, and a '
        'missing member reaches it with the invocation [2026-11-14]', () {
      expect(
        _run(
          'class Base { dynamic noSuchMethod(Invocation i) => '
          "'nsm:\${i.isGetter}:\${i.positionalArguments}'; }\n"
          'class C extends Base implements Contract {}\n'
          'List<Object?> main() {\n'
          '  final Contract c = C();\n'
          '  return [c is Contract, c.read(), c.size];\n'
          '}',
        ),
        [true, 'nsm:false:[]', 'nsm:true:[]'],
      );
    });

    test('GHI46-4: the class\'s own noSuchMethod satisfies its interfaces and '
        'its abstract superclass [2026-11-14]', () {
      expect(
        _run(
          'abstract class Shape { String name(); }\n'
          'class C extends Shape implements Contract {\n'
          '  dynamic noSuchMethod(Invocation i) => '
          "i.isGetter ? 7 : 'own';\n"
          '}\n'
          'List<Object?> main() {\n'
          '  final c = C();\n'
          '  return [c is Contract, c is Shape, c.read(), c.size, c.name()];\n'
          '}',
        ),
        [true, true, 'own', 7, 'own'],
      );
    });

    test('GHI46-5: Object\'s noSuchMethod satisfies nothing - an interpreted '
        'class, and one extending a bridged class without noSuchMethod, are '
        'still refused [2026-11-14]', () {
      for (final declaration in [
        'class C implements Contract {}',
        'class C extends Gh46Plain implements Contract {}',
        'abstract class Shape { String name(); }\nclass C extends Shape {}',
      ]) {
        expect(
          () => _run('$declaration\nObject main() => C();'),
          throwsA(
            predicate(
              (Object e) =>
                  e.toString().contains('Missing concrete implementation'),
              'refused as incomplete',
            ),
          ),
          reason: declaration,
        );
      }
    });
  });
}
