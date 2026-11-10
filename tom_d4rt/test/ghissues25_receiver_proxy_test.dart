// ghissues25 — a receiver proxy stands in as an interpreted instance's native
// object, so a member it inherits from an abstract bridged class runs.
//
// Measured 2026-11-10 in the Flutter AST twin (published tom_d4rt_ast 0.212.1),
// with `class Leaf extends DiagnosticableTree` overriding debugFillProperties:
//
//   Leaf('a').toDiagnosticsNode(name: 'root')   // null
//   Leaf('a').toStringDeep()                    // null
//
// An abstract bridged class has no constructor adapter, so an interpreted
// subclass has no native super-object, and a member it inherits from the
// bridged class reached the RC-9 fallback: a method became a no-op answering
// null, a getter answered null (GEN-130). An interface proxy registered for
// the class was consulted only where the instance crosses into native code.
// `D4.markProxyIsReceiver` now marks a proxy that may stand in as the
// instance's native object: RC-9 creates it, keeps it as the instance's
// `nativeProxy`, and dispatches through it. Unmarked proxies are not
// consulted there (a widget proxy reads the instance's fields to build
// itself). The same in tom_d4rt_ast
// (test/runtime/ghissues25_receiver_proxy_test.dart).

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// A native abstract class: `describe` calls the overridable `name`.
abstract class Gh25Base {
  String name() => 'base';
  String describe() => 'Base(${name()})';
  String get label => 'label:${name()}';
}

/// The receiver proxy: forwards `name` to the script's override.
class _Gh25Receiver extends Gh25Base implements D4InterpretedProxy {
  _Gh25Receiver(this._visitor, this._instance);
  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;

  @override
  Object get d4rtInstance => _instance;

  @override
  String name() {
    final method = _instance.klass.findInstanceMethod('name');
    if (method == null) return super.name();
    return method.bind(_instance).call(_visitor, [], {}) as String;
  }
}

/// The same shape, registered as a plain interface proxy only.
abstract class Gh25Plain {
  String describe() => 'Plain';
}

class _Gh25PlainProxy extends Gh25Plain implements D4InterpretedProxy {
  _Gh25PlainProxy(this._instance);
  final InterpretedInstance _instance;

  @override
  Object get d4rtInstance => _instance;
}

Object? _run(String body) {
  final d4rt = D4rt()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh25Base,
        name: 'Gh25Base',
        isAbstract: true,
        methods: {
          'name': (visitor, target, positional, named, typeArgs) =>
              (target as Gh25Base).name(),
          'describe': (visitor, target, positional, named, typeArgs) =>
              (target as Gh25Base).describe(),
        },
        getters: {'label': (visitor, target) => (target as Gh25Base).label},
      ),
      'package:g/g.dart',
    )
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh25Plain,
        name: 'Gh25Plain',
        isAbstract: true,
        methods: {
          'describe': (visitor, target, positional, named, typeArgs) =>
              (target as Gh25Plain).describe(),
        },
      ),
      'package:g/g.dart',
    );
  D4.registerInterfaceProxy(
    'Gh25Base',
    (visitor, instance) => _Gh25Receiver(visitor, instance),
  );
  D4.markProxyIsReceiver('Gh25Base');
  D4.registerInterfaceProxy(
    'Gh25Plain',
    (visitor, instance) => _Gh25PlainProxy(instance),
  );
  return d4rt.execute(
    library: 'package:p/main.dart',
    sources: {
      'package:p/main.dart':
          "import 'package:g/g.dart';\n"
          'class Leaf extends Gh25Base {\n'
          "  String name() => 'leaf';\n"
          '}\n'
          'class Wrapped extends Gh25Base {\n'
          "  String name() => 'wrapped';\n"
          "  String describe() => 'S:' + super.describe();\n"
          '}\n'
          'class Bare extends Gh25Base {}\n'
          'class Over extends Gh25Base {\n'
          "  String name() => 'over';\n"
          "  String get label => 'O:' + super.label;\n"
          '}\n'
          'class P extends Gh25Plain {}\n'
          'main() => $body;\n',
    },
  );
}

void main() {
  group('ghissues25: a receiver proxy stands in as the native object', () {
    test('GHI25-1: an inherited method and getter run on the receiver, and '
        'reach the script\'s override [2026-11-10]', () {
      expect(_run('[Leaf().describe(), Leaf().label, Bare().describe()]'), [
        'Base(leaf)',
        'label:leaf',
        'Base(base)',
      ]);
    });

    test('GHI25-2: a script override calling super reaches the inherited '
        'member through the receiver [2026-11-10]', () {
      expect(_run('Wrapped().describe()'), 'S:Base(wrapped)');
    });

    test('GHI25-4: a getter override reading super.label reaches the '
        'inherited getter through the receiver [2026-11-10]', () {
      expect(_run('Over().label'), 'O:label:over');
    });

    test('GHI25-3: an unmarked interface proxy is not consulted for an '
        'inherited member [2026-11-10]', () {
      // The RC-9 fallback, unchanged: a widget proxy builds itself from the
      // instance's fields, so creating one on a member lookup is not safe.
      expect(_run('P().describe()'), isNull);
    });
  });
}
