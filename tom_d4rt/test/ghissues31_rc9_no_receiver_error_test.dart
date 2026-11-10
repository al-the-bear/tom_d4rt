// ghissues31 — a member a script class inherits from an abstract bridged
// class, with no native object to run it on, is an error instead of null.
//
// Measured 2026-11-10 on this tree (1.252.0), `class C extends Gh31Base {}`
// where `Gh31Base` is an abstract bridged class (no constructor adapter) with
// no receiver proxy:
//
//   C().greet()          // null      (Dart: 'hello')
//   C().size             // null      (Dart: 3)
//   D().greet()          // 'd:null'  - D's `super.greet()` was a no-op
//
// An abstract bridged class has no constructor adapter, so a script subclass
// has no native super-object. Unless a receiver proxy is marked for the class
// (`D4.markProxyIsReceiver`, ghissues25 / ghissues29), the RC-9 fallback in
// `InterpretedInstance.get` answered a method with a no-op returning null and
// a getter with null, and the visitor treated `super.m()` as a no-op -
// silently. They now throw a RuntimeD4rtException naming the script class,
// the bridged class and the member, and how to give the class a receiver.
// One named exception: a `super.m()` on a script State whose State proxy
// runs it (`nativeStateProxy`, set by the Flutter twins) stays a no-op - the
// proxy runs the native State member around the script's override (GHI31-5).
// The same in tom_d4rt_ast
// (test/runtime/ghissues31_rc9_no_receiver_error_test.dart).

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// A native abstract class with a method, a getter and a callback method.
abstract class Gh31Base {
  String greet() => 'hello';
  int get size => 3;
}

/// The same shape, with a receiver proxy marked for it.
abstract class Gh31Marked {
  String greet() => 'hello';
  int get size => 3;
}

class _Gh31MarkedReceiver extends Gh31Marked implements D4InterpretedProxy {
  _Gh31MarkedReceiver(this._instance);
  final InterpretedInstance _instance;

  @override
  Object get d4rtInstance => _instance;
}

BridgedClass _bridge(Type nativeType, String name) => BridgedClass(
  nativeType: nativeType,
  name: name,
  isAbstract: true,
  methods: {
    'greet': (visitor, target, positional, named, typeArgs) =>
        target is Gh31Base ? target.greet() : (target as Gh31Marked).greet(),
  },
  getters: {
    'size': (visitor, target) =>
        target is Gh31Base ? target.size : (target as Gh31Marked).size,
  },
);

Object? _run(String body) {
  final d4rt = D4rt()
    ..registerBridgedClass(_bridge(Gh31Base, 'Gh31Base'), 'package:g/g.dart')
    ..registerBridgedClass(
      _bridge(Gh31Marked, 'Gh31Marked'),
      'package:g/g.dart',
    )
    // Stands in for the Flutter twins' `_InterpretedStatefulWidget`, which
    // sets `nativeStateProxy` on a script State it runs.
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Object,
        name: 'Gh31Host',
        staticMethods: {
          'adopt': (visitor, positional, named, typeArgs) {
            (positional[0] as InterpretedInstance).nativeStateProxy = Object();
            return positional[0];
          },
        },
      ),
      'package:g/g.dart',
    );
  D4.registerInterfaceProxy(
    'Gh31Marked',
    (visitor, instance) => _Gh31MarkedReceiver(instance),
  );
  D4.markProxyIsReceiver('Gh31Marked');
  return d4rt.execute(
    library: 'package:p/main.dart',
    sources: {
      'package:p/main.dart':
          "import 'package:g/g.dart';\n"
          'class C extends Gh31Base {}\n'
          'class D extends Gh31Base {\n'
          "  String greet() => 'd:' + super.greet();\n"
          '}\n'
          'class M extends Gh31Marked {}\n'
          'class S extends Gh31Base {\n'
          "  String greet() { super.greet(); return 'state'; }\n"
          '}\n'
          'class N extends Gh31Marked {\n'
          "  String greet() => 'n:' + super.greet();\n"
          '}\n'
          'main() => $body;\n',
    },
  );
}

Matcher _noReceiver(String scriptClass, String member) => throwsA(
  predicate(
    (Object? e) =>
        e is RuntimeD4rtException &&
        e.message.contains("'$scriptClass'") &&
        e.message.contains("'Gh31Base.$member'") &&
        e.message.contains('markProxyIsReceiver'),
    "a RuntimeD4rtException naming '$scriptClass' and 'Gh31Base.$member'",
  ),
);

void main() {
  group('GHI31: an inherited bridged member with no receiver is an error', () {
    test('GHI31-1: an inherited method [2026-11-10]', () {
      expect(() => _run('C().greet()'), _noReceiver('C', 'greet'));
    });

    test('GHI31-2: an inherited getter [2026-11-10]', () {
      expect(() => _run('C().size'), _noReceiver('C', 'size'));
    });

    test('GHI31-3: super.m() in an override [2026-11-10]', () {
      expect(() => _run('D().greet()'), _noReceiver('D', 'greet'));
    });

    test('GHI31-5: the named exception - super.m() on a State the State '
        'proxy runs stays a no-op [2026-11-10]', () {
      expect(_run('(Gh31Host.adopt(S()) as S).greet()'), 'state');
      // The same class without the proxy gets the error.
      expect(() => _run('S().greet()'), _noReceiver('S', 'greet'));
    });

    test('GHI31-4: a marked receiver still answers natively '
        '[2026-11-10]', () {
      expect(_run('[M().greet(), M().size, N().greet()]'), [
        'hello',
        3,
        'n:hello',
      ]);
    });
  });
}
