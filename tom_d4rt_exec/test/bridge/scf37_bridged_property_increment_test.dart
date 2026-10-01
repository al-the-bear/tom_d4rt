// SCF37: `obj.v++` / `++obj.v` on a bridged object's property.
//
// `b.v += 1` worked on a bridged getter/setter pair, but `b.v++` and `++b.v`
// threw "Cannot increment/decrement property on non-instance object": the four
// increment/decrement sites (prefix and postfix, each for a `PropertyAccess`
// and a `PrefixedIdentifier` operand) accepted only an interpreted instance
// as the receiver. They now read through the bridge's getter adapter and
// write through its setter adapter, as the compound path does, with the step
// computed by the same `computeCompoundValue`.
//
// The analyzer-free twin is
// `tom_d4rt_ast/test/runtime/scf37_bridged_property_increment_test.dart`.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

class _NativeBox {
  _NativeBox(this.v);
  num v;
  int get readOnly => 1;
}

Object? _run(String body) {
  final d4rt = D4rt()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: _NativeBox,
        name: 'Box',
        constructors: {
          '': (visitor, positional, named) => _NativeBox(positional[0] as num),
        },
        getters: {
          'v': (visitor, target) => (target as _NativeBox).v,
          'readOnly': (visitor, target) => (target as _NativeBox).readOnly,
        },
        setters: {
          'v': (visitor, target, value) =>
              (target as _NativeBox).v = value as num,
        },
      ),
      'package:test/box.dart',
    );
  return d4rt.execute(
    source:
        '''
import 'package:test/box.dart';
$body
''',
  );
}

void main() {
  group('SCF37: ++ and -- on a bridged property', () {
    test('F-SCF37-1: postfix on a prefixed identifier yields the old value '
        'and stores the new [2026-09-30] (PASS)', () {
      expect(
        _run(
          'List main() { final b = Box(1); final r = b.v++; return [r, b.v]; }',
        ),
        [1, 2],
      );
      expect(
        _run(
          'List main() { final b = Box(1); final r = b.v--; return [r, b.v]; }',
        ),
        [1, 0],
      );
    });

    test('F-SCF37-2: prefix on a prefixed identifier yields the new value '
        '[2026-09-30] (PASS)', () {
      expect(
        _run(
          'List main() { final b = Box(1); final r = ++b.v; return [r, b.v]; }',
        ),
        [2, 2],
      );
      expect(
        _run(
          'List main() { final b = Box(1); final r = --b.v; return [r, b.v]; }',
        ),
        [0, 0],
      );
    });

    test('F-SCF37-3: a property-access operand, postfix and prefix '
        '[2026-09-30] (PASS)', () {
      expect(
        _run(
          'List main() { final l = [Box(1)]; final r = l[0].v++; '
          'return [r, l[0].v]; }',
        ),
        [1, 2],
      );
      expect(
        _run(
          'List main() { final l = [Box(5)]; final r = --l[0].v; '
          'return [r, l[0].v]; }',
        ),
        [4, 4],
      );
      expect(
        _run('List main() { final b = Box(2.5); (b).v++; return [b.v]; }'),
        [3.5],
      );
    });

    test('F-SCF37-4: a property with no setter is refused by name '
        '[2026-09-30] (PASS)', () {
      expect(
        () => _run('main() { final b = Box(1); b.readOnly++; }'),
        throwsA(
          predicate(
            (e) => '$e'.contains('Box.readOnly') && '$e'.contains('no setter'),
          ),
        ),
      );
    });

    test('F-SCF37-5: control — an interpreted instance still increments '
        '[2026-09-30] (PASS)', () {
      expect(
        _run(
          'class C { int v = 1; } '
          'List main() { final c = C(); final a = c.v++; final b = ++c.v; '
          'return [a, b, c.v]; }',
        ),
        [1, 3, 3],
      );
    });
  });
}
