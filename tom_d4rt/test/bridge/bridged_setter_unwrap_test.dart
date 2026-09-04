/// GEN-079 back-port — bridged setter must unwrap a `BridgedInstance`
/// right-hand side to the underlying native object so that covariant
/// typed generic setters (e.g. `ValueNotifier<Color>.value`) receive
/// the native value rather than the wrapper.
///
/// Cluster G #12 (`tom_d4rt_flutter_ast/doc/testlog_20260522-1328-issue-analysis/error_analysis.md`)
/// reproduced the missing unwrap as
/// `type 'BridgedInstance<Object>' is not a subtype of type 'Color' of 'newValue'`
/// when `foundation/notifier_test.dart` did `colorNotifier.value = c`.
///
/// Mirrors the equivalent behaviour already present in
/// `tom_d4rt_ast/lib/src/runtime/interpreter_visitor.dart` at the four
/// bridged-setter sites:
///   - implicit `this.foo = value` on a bridged 'this'
///   - `target.property = value` via `PropertyAccess`
///   - `super.property = value` (bridged super)
///   - `prefix.property = value` via `PrefixedIdentifier`
library;

// The `_NativeHolder` getter/setter pair intentionally wraps a private field
// to mirror the covariant generic store of `ValueNotifier<T>.value` under test.
// ignore_for_file: unnecessary_getters_setters

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

class _NativeColor {
  const _NativeColor(this.r);
  final int r;
  @override
  String toString() => '_NativeColor($r)';
}

class _NativeHolder<T> {
  _NativeHolder(this._value);
  T _value;
  T get value => _value;
  // Strict-typed setter — mirrors the covariant generic store of
  // `ValueNotifier<Color>.value`.
  set value(T newValue) => _value = newValue;
}

void main() {
  group('GEN-079 bridged setter BridgedInstance unwrap', () {
    late D4rt interpreter;

    setUp(() {
      interpreter = D4rt();

      final colorBridge = BridgedClass(
        nativeType: _NativeColor,
        name: 'Color',
        constructors: {
          '': (visitor, positional, named) {
            if (positional.length != 1 || positional[0] is! int) {
              throw ArgumentError('Color expects one int positional arg');
            }
            return _NativeColor(positional[0] as int);
          },
        },
        getters: {'r': (visitor, target) => (target as _NativeColor).r},
      );

      final holderBridge = BridgedClass(
        nativeType: _NativeHolder,
        name: 'Holder',
        constructors: {
          '': (visitor, positional, named) {
            if (positional.length != 1 || positional[0] is! _NativeColor) {
              throw ArgumentError(
                'Holder expects a _NativeColor (got ${positional.isEmpty ? 'nothing' : positional[0].runtimeType})',
              );
            }
            return _NativeHolder<_NativeColor>(positional[0] as _NativeColor);
          },
        },
        getters: {
          'value': (visitor, target) =>
              (target as _NativeHolder<_NativeColor>).value,
        },
        setters: {
          // Mirrors the typed-covariant ValueNotifier<Color>.value setter:
          // assigning anything other than a _NativeColor would throw at
          // runtime if the interpreter forwarded the BridgedInstance
          // wrapper instead of unwrapping it first.
          'value': (visitor, target, value) {
            (target as _NativeHolder<_NativeColor>).value =
                value as _NativeColor;
          },
        },
      );

      interpreter.registerBridgedClass(colorBridge, 'package:test/color.dart');
      interpreter.registerBridgedClass(
        holderBridge,
        'package:test/holder.dart',
      );
    });

    test('PrefixedIdentifier setter unwraps BridgedInstance<Color>', () {
      // `holder.value = c` where `c` is a Color BridgedInstance —
      // pre-fix this threw `type 'BridgedInstance<Object>' is not a
      // subtype of type '_NativeColor' of 'newValue'`.
      final code = '''
        import 'package:test/color.dart';
        import 'package:test/holder.dart';

        int main() {
          final h = Holder(Color(1));
          final c = Color(99);
          h.value = c;
          return h.value.r;
        }
      ''';
      expect(interpreter.execute(source: code), equals(99));
    });

    test('PropertyAccess setter unwraps BridgedInstance<Color>', () {
      // Force a PropertyAccess receiver (`(expr).value = c`) so we exercise
      // the second of the four interpreter sites.
      final code = '''
        import 'package:test/color.dart';
        import 'package:test/holder.dart';

        int main() {
          final h = Holder(Color(2));
          (h).value = Color(42);
          return h.value.r;
        }
      ''';
      expect(interpreter.execute(source: code), equals(42));
    });

    test('Setter unwraps BridgedInstance<Color> across a for-in loop', () {
      // Exercises the unwrap pattern most commonly hit by real scripts:
      // notifier_test does `for (final c in <Color>[…]) colorNotifier.value = c`
      // — the loop-bound variable resolves to a BridgedInstance<Color>
      // wrapper that must be unwrapped before the native setter store.
      final code = '''
        import 'package:test/color.dart';
        import 'package:test/holder.dart';

        int main() {
          final h = Holder(Color(0));
          final palette = [Color(11), Color(22), Color(33)];
          for (final c in palette) {
            h.value = c;
          }
          return h.value.r;
        }
      ''';
      expect(interpreter.execute(source: code), equals(33));
    });
  });
}
