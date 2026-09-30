// SCF38: a native closure resolves to the `Function` bridge, not to the bridge
// named like its RETURN type.
//
// A function type prints as `(params) => Ret`, and SCC49's structural suffix
// fallback takes the trailing name — so a host-built `(int x) => x` was
// claimed by the `int` bridge and a `() => Map<String, Object>` tear-off by
// `Map`. A member read on the closure then ran that bridge's adapters against
// a function. In the Flutter twins that is every callback read off a
// host-built widget: `(BuildContext) => Widget` suffix-matches `Widget`.
//
// The suffix rule exists for private CLASS names (`_CompactIterator`), and a
// function type is not a class name. A `Function` value now resolves to the
// `Function` bridge, whose `isAssignable` is `v is Function`.
//
// This is a name-resolution change, so the test is script-level (the scd5a
// pattern): a real interpreter, real imports, a native closure handed over by
// host code, and members read on it by the script. The analyzer-free twin is
// `tom_d4rt_ast/test/runtime/scf38_native_closure_bridge_test.dart`.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// PUBLISH-BLOCKED (DGUC6): exec resolves `tom_d4rt_ast` from pub.dev, and
/// the release carrying scf38 is 0.199.0. Remove the skip — which makes the
/// file the reference verbatim again — when exec's floor passes it.
const _publishBlocked =
    'PUBLISH-BLOCKED: needs tom_d4rt_ast 0.199.0 (scf38, published by scf42)';

class _Host {}

/// Closures built by HOST code, the shape a Flutter widget's `onPressed` or
/// `builder` has when a script reads it.
final _closures = <String, Object>{
  'intToInt': (int x) => x,
  'mapTearOff': _mapFactory,
  'voidCallback': () {},
};

Map<String, Object> _mapFactory() => {'k': 1};

Object? _run(String body) {
  final d4rt = D4rt()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: _Host,
        name: 'Host',
        staticMethods: {
          'closure': (visitor, positional, named, typeArgs) =>
              _closures[positional[0] as String],
        },
      ),
      'package:test/host.dart',
    );
  return d4rt.execute(
    source:
        '''
import 'package:test/host.dart';
$body
''',
  );
}

void main() {
  group('SCF38: a host-built closure is a Function', skip: _publishBlocked, () {
    test('F-SCF38-1: toBridgedInstance resolves (int) => int and a () => Map '
        'tear-off to Function [2026-09-30] (PASS)', () {
      final env = Environment();
      Stdlib(env).register();
      for (final closure in [(int x) => x, _mapFactory]) {
        final bridged = env.toBridgedInstance(closure);
        expect(
          bridged?.bridgedClass.name,
          'Function',
          reason: '${closure.runtimeType}',
        );
      }
    });

    test('F-SCF38-2: toString, hashCode and runtimeType on a host closure '
        'answer as a function does [2026-09-30] (PASS)', () {
      final closure = _closures['intToInt']!;
      expect(
        _run(
          "List main() { final f = Host.closure('intToInt'); "
          'return [f.toString(), f.hashCode, f.runtimeType.toString()]; }',
        ),
        [closure.toString(), closure.hashCode, closure.runtimeType.toString()],
      );
    });

    test('F-SCF38-3: the Map-returning tear-off is not treated as a Map '
        '[2026-09-30] (PASS)', () {
      // Before SCF38 `f.length` reached the Map bridge's `length` adapter,
      // which cast the closure to Map.
      expect(
        () => _run(
          "main() { final f = Host.closure('mapTearOff'); return f.length; }",
        ),
        throwsA(predicate((e) => '$e'.contains('length'))),
      );
      expect(
        _run(
          "Map main() { final f = Host.closure('mapTearOff'); return f(); }",
        ),
        {'k': 1},
      );
    });

    test(
      'F-SCF38-4: calling a host closure is unchanged [2026-09-30] (PASS)',
      () {
        expect(
          _run(
            "int main() { final f = Host.closure('intToInt'); return f(41) + 1; }",
          ),
          42,
        );
      },
    );
  });
}
