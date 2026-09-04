/// Tests for [D4rt.executeBundleAs] / [D4rt.executeBundleAsAsync] — the
/// typed entry points introduced in step 2 of
/// `tom_d4rt_flutterm/doc/d4rt_consolidation_plan.md`.
///
/// Both methods forward to [D4rtRunner.executeBundleAs] /
/// [D4rtRunner.executeBundleAsAsync], which in turn run the regular
/// `executeBundle` path and apply [D4.unwrapAs] to the raw result. This
/// suite exercises:
///
/// * a Flutter-free bundle that returns a primitive [int];
/// * a bundle whose `main` returns an instance of a registered
///   [BridgedClass] (the runner unwraps a [BridgedInstance] to the native
///   object);
/// * a bundle whose `main` returns an instance of an interpreted class
///   that extends a registered bridged superclass (the runner reaches the
///   `bridgedSuperObject` branch);
/// * an `async` bundle exercising [executeBundleAsAsync];
/// * the [D4UnwrapException] path when the result type doesn't match.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

class _NativeBox {
  _NativeBox(this.value);
  final int value;
}

class _NativeColoredBox extends _NativeBox {
  _NativeColoredBox(super.value, this.color);
  final String color;
}

void _registerBoxBridge(D4rt d4rt) {
  final box = BridgedClass(
    name: '_NativeBox',
    nativeType: _NativeBox,
    constructors: {
      '': (visitor, positional, named) {
        return _NativeBox(positional[0] as int);
      },
    },
    getters: {'value': (visitor, target) => (target as _NativeBox).value},
  );
  d4rt.registerBridgedClass(box, 'package:test_lib/box.dart');

  // Register supertype relationship so subtype checks (BridgedClass→
  // BridgedClass) resolve `_NativeColoredBox` as a `_NativeBox`, and so
  // an interpreted class extending `_NativeBox` can be unwrapped to the
  // bridged super type via the `bridgedSuperObject` branch.
  BridgedClass.registerSupertypes({
    '_NativeColoredBox': ['_NativeBox'],
  });

  final coloredBox = BridgedClass(
    name: '_NativeColoredBox',
    nativeType: _NativeColoredBox,
    constructors: {
      '': (visitor, positional, named) {
        return _NativeColoredBox(positional[0] as int, positional[1] as String);
      },
    },
    getters: {
      'value': (visitor, target) => (target as _NativeColoredBox).value,
      'color': (visitor, target) => (target as _NativeColoredBox).color,
    },
  );
  d4rt.registerBridgedClass(coloredBox, 'package:test_lib/box.dart');
}

void main() {
  group('D4rt.executeBundleAs<T>', () {
    test('returns the raw int when T == int', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('int main() => 42;');

      final result = d4rt.executeBundleAs<int>(bundle);

      expect(result, 42);
    });

    test('unwraps a BridgedInstance to the native object', () async {
      final d4rt = D4rt();
      _registerBoxBridge(d4rt);
      final bundle = await d4rt.createBundleFromSource('''
import 'package:test_lib/box.dart';
_NativeBox main() => _NativeBox(7);
''');

      final result = d4rt.executeBundleAs<_NativeBox>(bundle);

      expect(result, isA<_NativeBox>());
      expect(result.value, 7);
    });

    test(
      'unwraps to a more specific subtype when concretely assignable',
      () async {
        final d4rt = D4rt();
        _registerBoxBridge(d4rt);
        final bundle = await d4rt.createBundleFromSource('''
import 'package:test_lib/box.dart';
_NativeColoredBox main() => _NativeColoredBox(3, 'green');
''');

        final result = d4rt.executeBundleAs<_NativeColoredBox>(bundle);

        expect(result.value, 3);
        expect(result.color, 'green');
      },
    );

    test('unwraps an InterpretedInstance whose bridged-super matches T '
        '(reaches the bridgedSuperObject branch)', () async {
      final d4rt = D4rt();
      _registerBoxBridge(d4rt);
      final bundle = await d4rt.createBundleFromSource('''
import 'package:test_lib/box.dart';
class TaggedBox extends _NativeBox {
  TaggedBox(int v) : super(v);
}
_NativeBox main() => TaggedBox(11);
''');

      final result = d4rt.executeBundleAs<_NativeBox>(bundle);

      expect(result, isA<_NativeBox>());
      expect(result.value, 11);
    });

    test('throws D4UnwrapException when the result is not a T', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('int main() => 42;');

      expect(
        () => d4rt.executeBundleAs<String>(bundle),
        throwsA(
          isA<D4UnwrapException>()
              .having((e) => e.expectedType, 'expectedType', 'String')
              .having((e) => e.actualType, 'actualType', 'int'),
        ),
      );
    });

    test('throws D4UnwrapException when the bundle returns null and '
        'T is non-nullable', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource(
        'Object? main() => null;',
      );

      expect(
        () => d4rt.executeBundleAs<int>(bundle),
        throwsA(
          isA<D4UnwrapException>().having(
            (e) => e.actualType,
            'actualType',
            'null',
          ),
        ),
      );
    });

    test('returns null when bundle returns null and T is nullable', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource(
        'Object? main() => null;',
      );

      final result = d4rt.executeBundleAs<int?>(bundle);

      expect(result, isNull);
    });
  });

  group('D4rt.executeBundleAsAsync<T>', () {
    test('awaits a Future<int> result', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
Future<int> main() async => 21;
''');

      final result = await d4rt.executeBundleAsAsync<int>(bundle);

      expect(result, 21);
    });

    test(
      'also handles synchronous results (passes through unchanged)',
      () async {
        final d4rt = D4rt();
        final bundle = await d4rt.createBundleFromSource('int main() => 5;');

        final result = await d4rt.executeBundleAsAsync<int>(bundle);

        expect(result, 5);
      },
    );

    test('awaits and unwraps a Future<BridgedInstance> result', () async {
      final d4rt = D4rt();
      _registerBoxBridge(d4rt);
      final bundle = await d4rt.createBundleFromSource('''
import 'package:test_lib/box.dart';
Future<_NativeBox> main() async => _NativeBox(99);
''');

      final result = await d4rt.executeBundleAsAsync<_NativeBox>(bundle);

      expect(result.value, 99);
    });

    test(
      'throws D4UnwrapException for an awaited Future with a wrong type',
      () async {
        final d4rt = D4rt();
        final bundle = await d4rt.createBundleFromSource('''
Future<int> main() async => 42;
''');

        await expectLater(
          d4rt.executeBundleAsAsync<String>(bundle),
          throwsA(
            isA<D4UnwrapException>()
                .having((e) => e.expectedType, 'expectedType', 'String')
                .having((e) => e.actualType, 'actualType', 'int'),
          ),
        );
      },
    );
  });
}
