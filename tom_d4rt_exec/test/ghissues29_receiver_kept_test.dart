// ghissues29 — a receiver proxy is ONE native object per script instance,
// whichever route creates it first.
//
// ghissues25 kept a receiver created by an inherited member (RC-9,
// `D4.receiverProxyFor`), but a script instance crossing into native code
// (an argument, `D4.tryCreateInterfaceProxyWithVisitor`) got a fresh proxy at
// every crossing. With the generator now marking every proxy it generates
// (CustomPainter, Decoration, the layout delegates, ...), the framework would
// hold one proxy and the script's inherited calls another - a listener added
// through one would never be called by the other. A marked proxy is now kept
// on `nativeProxy` by every route, and a script's `super.m()` that reaches a
// `D4ReceiverProxy` runs inside `d4rtSuperCall`, so the native member runs
// once instead of the proxy forwarding to the override again. The same in
// tom_d4rt_ast
// (test/runtime/ghissues29_receiver_kept_test.dart).

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

abstract class Gh29Base {
  String name() => 'base';
  String describe() => 'Base(${name()})';
}

/// Shaped like a generated receiver: overridable members forward to the
/// script unless a forward or a script `super` call of that member is running.
class _Gh29Receiver extends Gh29Base
    implements D4InterpretedProxy, D4ReceiverProxy {
  _Gh29Receiver(this._visitor, this._instance);
  final InterpreterVisitor _visitor;
  final InterpretedInstance _instance;
  final Set<String> _forwarding = <String>{};

  @override
  Object get d4rtInstance => _instance;

  @override
  R d4rtSuperCall<R>(String member, R Function() call) {
    if (!_forwarding.add(member)) return call();
    try {
      return call();
    } finally {
      _forwarding.remove(member);
    }
  }

  String _forward(String member, String Function() native) {
    final method = _instance.klass.findInstanceMethod(member);
    if (method == null || _forwarding.contains(member)) return native();
    _forwarding.add(member);
    try {
      return method.bind(_instance).call(_visitor, [], {}) as String;
    } finally {
      _forwarding.remove(member);
    }
  }

  @override
  String name() => _forward('name', super.name);

  @override
  String describe() => _forward('describe', super.describe);
}

/// Unmarked: a fresh proxy per crossing, as before.
abstract class Gh29Plain {
  String describe() => 'Plain';
}

class _Gh29PlainProxy extends Gh29Plain implements D4InterpretedProxy {
  _Gh29PlainProxy(this._instance);
  final InterpretedInstance _instance;

  @override
  Object get d4rtInstance => _instance;
}

/// The native side: answers which native object it received.
class Gh29Host {
  static final seen = <Object>[];
  static int take(Object value) {
    seen.add(value);
    return seen.length;
  }
}

Object? _run(String body) {
  Gh29Host.seen.clear();
  final d4rt = D4rt()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh29Base,
        name: 'Gh29Base',
        isAbstract: true,
        methods: {
          'describe': (visitor, target, positional, named, typeArgs) =>
              (target as Gh29Base).describe(),
        },
      ),
      'package:g/g.dart',
    )
    ..registerBridgedClass(
      BridgedClass(nativeType: Gh29Plain, name: 'Gh29Plain', isAbstract: true),
      'package:g/g.dart',
    )
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh29Host,
        name: 'Gh29Host',
        staticMethods: {
          'takeBase': (visitor, positional, named, typeArgs) => Gh29Host.take(
            D4.extractBridgedArg<Gh29Base>(positional[0], 'value', visitor),
          ),
          'takeMaybe': (visitor, positional, named, typeArgs) => Gh29Host.take(
            D4.extractBridgedArg<Gh29Base?>(positional[0], 'value', visitor)!,
          ),
          'takePlain': (visitor, positional, named, typeArgs) => Gh29Host.take(
            D4.extractBridgedArg<Gh29Plain>(positional[0], 'value', visitor),
          ),
        },
      ),
      'package:g/g.dart',
    );
  D4.registerInterfaceProxy(
    'Gh29Base',
    (visitor, instance) => _Gh29Receiver(visitor, instance),
  );
  D4.markProxyIsReceiver('Gh29Base');
  D4.registerInterfaceProxy(
    'Gh29Plain',
    (visitor, instance) => _Gh29PlainProxy(instance),
  );
  return d4rt.execute(
    library: 'package:p/main.dart',
    sources: {
      'package:p/main.dart':
          "import 'package:g/g.dart';\n"
          "class Leaf extends Gh29Base { String name() => 'leaf'; }\n"
          'class Twice extends Gh29Base {\n'
          "  String describe() => 'S:' + super.describe();\n"
          '}\n'
          'class P extends Gh29Plain {}\n'
          'main() { $body }\n',
    },
  );
}

void main() {
  group('ghissues29: a receiver proxy is one native object per instance', () {
    test('GHI29-K1: two crossings into native code receive the same proxy, '
        'and it is the receiver of inherited calls [2026-11-10]', () {
      expect(
        _run(
          'final l = Leaf(); Gh29Host.takeBase(l); Gh29Host.takeBase(l); '
          'return l.describe();',
        ),
        'Base(leaf)',
      );
      expect(Gh29Host.seen, hasLength(2));
      expect(identical(Gh29Host.seen[0], Gh29Host.seen[1]), isTrue);
      expect(Gh29Host.seen[0], isA<_Gh29Receiver>());
    });

    test('GHI29-K2: an inherited call first, a crossing after, the same proxy '
        '[2026-11-10]', () {
      _run(
        'final l = Leaf(); l.describe(); Gh29Host.takeBase(l); '
        'Gh29Host.takeBase(l); return null;',
      );
      expect(identical(Gh29Host.seen[0], Gh29Host.seen[1]), isTrue);
    });

    test('GHI29-K4: a script override calling super runs the native member '
        'once, before and after the proxy is kept [2026-11-10]', () {
      expect(
        _run(
          'final t = Twice(); final first = t.describe(); '
          'Gh29Host.takeBase(t); return [first, t.describe()];',
        ),
        ['S:Base(base)', 'S:Base(base)'],
      );
      // Native code calling the overridden member reaches the script once.
      expect((Gh29Host.seen.single as Gh29Base).describe(), 'S:Base(base)');
    });

    test('GHI29-K5: a nullable parameter type gets the proxy on the first '
        'crossing [2026-11-10]', () {
      _run(
        'final l = Leaf(); Gh29Host.takeMaybe(l); Gh29Host.takeBase(l); '
        'return null;',
      );
      expect(Gh29Host.seen.first, isA<_Gh29Receiver>());
      expect(identical(Gh29Host.seen[0], Gh29Host.seen[1]), isTrue);
    });

    test('GHI29-K3: an unmarked proxy is still created per crossing '
        '[2026-11-10]', () {
      _run(
        'final x = P(); Gh29Host.takePlain(x); Gh29Host.takePlain(x); '
        'return null;',
      );
      expect(identical(Gh29Host.seen[0], Gh29Host.seen[1]), isFalse);
    });
  });
}
