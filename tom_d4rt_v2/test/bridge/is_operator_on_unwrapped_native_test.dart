/// Regression: `value is BridgedX` returns the right answer when
/// `value` is a raw native object that the bridge layer never wrapped
/// in a [BridgedInstance].
///
/// The original bug (surfaced by Flutter's `KeyboardListener.onKeyEvent`):
/// `visitIsExpression`'s `BridgedClass` branch only handled
/// `expressionValue is BridgedInstance`; for every other operand it
/// returned `false`. Flutter callbacks routinely pass native objects
/// (`KeyDownEvent`, `PointerEvent`, `BuildContext`, …) straight into the
/// script unwrapped — the `is`-check silently dropped every press.
///
/// The fix falls through to the bridge's `isAssignable` predicate, which
/// closes over the host's native `v is X` operator and is authoritative.
///
/// This test simulates the broken scenario via a static method that
/// returns a raw native value (no wrapping), then runs `value is X`
/// against it.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_v2/d4rt.dart';

class _Beep {
  final String tone;
  const _Beep(this.tone);
}

class _Boop extends _Beep {
  const _Boop(super.tone);
}

void main() {
  group('is-operator on raw native values', () {
    late D4rt interpreter;

    setUp(() {
      interpreter = D4rt();
      // Register two related bridges so we can also test subtype
      // discrimination: `_Boop` extends `_Beep` natively, so a `_Boop`
      // instance should pass `is Beep` AND `is Boop`, and a `_Beep`
      // instance should pass `is Beep` only.
      interpreter.registerBridgedClass(
        BridgedClass(
          nativeType: _Beep,
          name: 'Beep',
          isAssignable: (v) => v is _Beep,
          hierarchyDepth: 1,
          constructors: {
            '': (visitor, positional, named) => _Beep(positional[0] as String),
          },
          staticMethods: {
            // Returns a NATIVE _Beep without wrapping — simulates a
            // Flutter callback parameter.
            'makeRaw': (visitor, positional, named, typeArgs) =>
                _Beep(positional[0] as String),
          },
        ),
        'test:beep',
      );
      interpreter.registerBridgedClass(
        BridgedClass(
          nativeType: _Boop,
          name: 'Boop',
          isAssignable: (v) => v is _Boop,
          hierarchyDepth: 2,
          constructors: {
            '': (visitor, positional, named) => _Boop(positional[0] as String),
          },
          staticMethods: {
            'makeRaw': (visitor, positional, named, typeArgs) =>
                _Boop(positional[0] as String),
          },
        ),
        'test:boop',
      );
    });

    test('raw native value `is BridgedClass` returns true', () {
      final result = interpreter.execute(
        library: 'main',
        sources: {
          'main': '''
import 'test:beep';

bool run() {
  final v = Beep.makeRaw('hi');
  return v is Beep;
}
''',
          'test:beep': '',
        },
        name: 'run',
      );
      expect(result, isTrue,
          reason: '`Beep.makeRaw()` returns a raw `_Beep`; the script '
              "must recognise it as `is Beep`. If this fails, the "
              '`is`-operator BridgedClass branch is regressing.');
    });

    test('raw native subtype `is BridgedSubtype` returns true', () {
      final result = interpreter.execute(
        library: 'main',
        sources: {
          'main': '''
import 'test:boop';

bool run() {
  final v = Boop.makeRaw('hello');
  return v is Boop;
}
''',
          'test:boop': '',
        },
        name: 'run',
      );
      expect(result, isTrue);
    });

    test('raw native value `is UnrelatedBridge` returns false', () {
      // Boop instance against Beep-only check should still be true
      // (Boop extends Beep), but Beep instance against Boop should
      // return false — the test verifies negative discrimination too.
      final result = interpreter.execute(
        library: 'main',
        sources: {
          'main': '''
import 'test:beep';
import 'test:boop';

bool run() {
  final v = Beep.makeRaw('hi');
  return v is Boop;
}
''',
          'test:beep': '',
          'test:boop': '',
        },
        name: 'run',
      );
      expect(result, isFalse,
          reason: 'A plain `_Beep` is not a `_Boop`; `is Boop` must be '
              'false.');
    });

    test('`is!` negation works on raw native values', () {
      final result = interpreter.execute(
        library: 'main',
        sources: {
          'main': '''
import 'test:beep';

bool run() {
  final v = Beep.makeRaw('hi');
  return v is! Beep;
}
''',
          'test:beep': '',
        },
        name: 'run',
      );
      expect(result, isFalse,
          reason: '`v is! Beep` must be false for a `_Beep` instance.');
    });

    test('`null is BridgedX` returns false', () {
      final result = interpreter.execute(
        library: 'main',
        sources: {
          'main': '''
import 'test:beep';

bool run() {
  final Object? v = null;
  return v is Beep;
}
''',
          'test:beep': '',
        },
        name: 'run',
      );
      expect(result, isFalse);
    });
  });
}
