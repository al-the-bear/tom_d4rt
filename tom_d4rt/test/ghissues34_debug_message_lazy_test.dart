// ghissues34 — with debug logging off, the interpreter builds no debug
// message, so it never stringifies the values a message would name.
//
// `Logger.debug(String)` takes a finished string, so every
// `Logger.debug("... $target ...")` built its message - calling `toString()` on
// targets, arguments and values - on every evaluation, logging on or off.
// Measured 2026-11-10 on this tree (1.254.0) with a bridged object whose
// `toString()` counts its calls: a script reading a getter, calling a method,
// passing the object along and assigning it stringified it on every step
// (the CPU profile of the perf suite showed `_AbstractType.toString`,
// `_StringBase._interpolate` and `_OneByteString._concatAll` among the hottest
// functions). The evaluation paths of both trees now wrap each interpolating
// `Logger.debug` in `if (Logger.isDebug) { ... }`. The same in tom_d4rt_ast
// (test/runtime/ghissues34_debug_message_lazy_test.dart).

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// A native object that counts how often it is stringified.
class Gh34Probe {
  static int stringified = 0;
  int value = 1;
  int bump() => ++value;

  @override
  String toString() {
    stringified++;
    return 'Gh34Probe($value)';
  }
}

Object? _run(String body) {
  final d4rt = D4rt()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Gh34Probe,
        name: 'Gh34Probe',
        constructors: {'': (visitor, positional, named) => Gh34Probe()},
        getters: {'value': (visitor, target) => (target as Gh34Probe).value},
        setters: {
          'value': (visitor, target, value) =>
              (target as Gh34Probe).value = value as int,
        },
        methods: {
          'bump': (visitor, target, positional, named, typeArgs) =>
              (target as Gh34Probe).bump(),
        },
      ),
      'package:g/g.dart',
    );
  return d4rt.execute(
    library: 'package:p/main.dart',
    sources: {
      'package:p/main.dart':
          "import 'package:g/g.dart';\n"
          'class Holder { Object? held; }\n'
          'int take(Gh34Probe p) => p.value;\n'
          'main() {\n'
          '$body\n'
          '}\n',
    },
  );
}

void main() {
  setUp(() {
    Logger.setDebug(false);
    Gh34Probe.stringified = 0;
  });

  group('GHI34: no debug message is built with logging off', () {
    test('GHI34-1: member access, method invocation, identifier lookup and '
        'assignment never stringify a value [2026-11-10]', () {
      final result = _run('''
  final p = Gh34Probe();
  var sum = p.value;
  p.bump();
  sum += p.value;
  final q = p;
  q.value = 5;
  sum += take(q);
  final h = Holder();
  h.held = q;
  final r = h.held as Gh34Probe;
  sum += r.bump();
  for (var i = 0; i < 3; i++) { sum += p.value; }
  return sum;''');
      expect(result, 1 + 2 + 5 + 6 + 18);
      expect(
        Gh34Probe.stringified,
        0,
        reason: 'a debug message was built with debug logging off',
      );
    });

    test('GHI34-2: with debug logging on, the messages are built '
        '[2026-11-10]', () {
      // The control: the probe can see a message being built.
      Logger.setDebug(true);
      try {
        _run('final p = Gh34Probe(); p.bump(); return p.value;');
      } finally {
        Logger.setDebug(false);
      }
      expect(Gh34Probe.stringified, greaterThan(0));
    });
  });
}
