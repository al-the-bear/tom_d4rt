/// SCF31 / GEN-126 — the last case: a script subclass of a CONCRETE bridged
/// class, handed back by native code as its bare native base.
///
/// `class _RenderMeasureBox extends RenderProxyBox` gets no proxy. The base is
/// constructed natively, that object is what native code holds — it has to
/// be, only the real object lays out — and when the framework hands it back
/// (`updateRenderObject(context, covariant _RenderMeasureBox renderObject)`,
/// a viewport's `delegate as _TwoDMgrCountingDelegate`) it arrives as the
/// base. Every check that asked for the script class refused it:
/// `type 'RenderProxyBox' is not a subtype of type '_RenderMeasureBox'`.
///
/// SCE164 showed the two obvious repairs regress (a registered proxy is never
/// built for a concrete base; forcing one breaks layout). This one does not
/// change what crosses. The native super object and its instance are one
/// object to the script, so the checks recognise the native object as the
/// instance — the pairing is recorded when `bridgedSuperObject` is set — and a
/// binding or cast yields the INSTANCE, which carries the script's members and
/// hands the same native object back out.
///
/// The controls (F-SCF31-6, -7) keep the recognition from becoming a waiver:
/// an unrelated script class is still refused, and a base nobody subclassed is
/// still just a base.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

/// `RenderProxyBox`'s stand-in: a concrete bridged class with a constructor.
class _NativeBox {
  _NativeBox(this.value);
  int value;
}

/// What native code holds between the crossing out and the crossing back.
Object? _held;

Object? _stash(
  InterpreterVisitor visitor,
  List<Object?> positional,
  Map<String, Object?> named,
  List<RuntimeType>? typeArgs,
) {
  // The native side keeps the NATIVE object, as a framework keeps a render
  // object: whatever the script passed, unwrapped to its bridged super.
  final value = positional[0];
  _held = value is InterpretedInstance ? value.bridgedSuperObject : value;
  return null;
}

Object? _last(
  InterpreterVisitor visitor,
  List<Object?> positional,
  Map<String, Object?> named,
  List<RuntimeType>? typeArgs,
) => _held;

/// Native code calling a script function with the held object — the
/// `updateRenderObject` direction.
Object? _dispatch(
  InterpreterVisitor visitor,
  List<Object?> positional,
  Map<String, Object?> named,
  List<RuntimeType>? typeArgs,
) => (positional[0] as Callable).call(visitor, [_held]);

const _classes = '''
import 'package:test/box.dart';

class MeasureBox extends Box {
  MeasureBox(int v) : super(v);
  int extra = 7;
}

class OtherBox extends Box {
  OtherBox() : super(0);
}
''';

void main() {
  group('SCF31: a bridged super object is recognised as its instance', () {
    late D4rt interpreter;

    setUp(() {
      _held = null;
      interpreter = D4rt();
      interpreter.registerBridgedClass(
        BridgedClass(
          nativeType: _NativeBox,
          name: 'Box',
          constructors: {
            '': (visitor, positional, named) =>
                _NativeBox(positional[0] as int),
          },
          getters: {'value': (visitor, target) => (target as _NativeBox).value},
          staticMethods: {
            'stash': _stash,
            'last': _last,
            'dispatch': _dispatch,
          },
        ),
        'package:test/box.dart',
      );
    });

    Object? run(String body) => interpreter.execute(source: '$_classes\n$body');

    test('F-SCF31-1: a parameter declared as the script class binds the '
        'native object handed back [2026-09-29] (PASS)', () {
      // Before SCF31: `type 'Box' is not a subtype of type 'MeasureBox'`.
      expect(
        run('''
int size(MeasureBox b) => b.extra;
int main() { Box.stash(MeasureBox(3)); return size(Box.last()); }
'''),
        7,
      );
    });

    test('F-SCF31-2: the same binding on a native-to-interpreted callback '
        '[2026-09-29] (PASS)', () {
      expect(
        run('''
int size(MeasureBox b) => b.extra + b.value;
int main() { Box.stash(MeasureBox(3)); return Box.dispatch(size); }
'''),
        10,
      );
    });

    test('F-SCF31-3: `as` yields the instance, so script members are '
        'reachable after the cast [2026-09-29] (PASS)', () {
      // Before SCF31 the cast was permissive and returned the native base, so
      // `.extra` was an undefined member.
      expect(
        run('''
int main() { Box.stash(MeasureBox(3)); return (Box.last() as MeasureBox).extra; }
'''),
        7,
      );
    });

    test('F-SCF31-4: `is` answers for the instance [2026-09-29] (PASS)', () {
      expect(
        run('''
bool main() { Box.stash(MeasureBox(3)); return Box.last() is MeasureBox; }
'''),
        isTrue,
      );
    });

    test('F-SCF31-5: the native object and the instance are one object '
        '[2026-09-29] (PASS)', () {
      expect(
        run('''
List<bool> main() {
  final b = MeasureBox(3);
  Box.stash(b);
  return [identical(Box.last(), b), Box.last() == b];
}
'''),
        [true, true],
      );
    });

    test('F-SCF31-6: control — an unrelated script class is still refused '
        '[2026-09-29] (PASS)', () {
      expect(
        () => run('''
int size(OtherBox b) => 0;
int main() { Box.stash(MeasureBox(3)); return size(Box.last()); }
'''),
        throwsA(predicate((e) => '$e'.contains("'OtherBox'"))),
      );
      expect(
        run('''
bool main() { Box.stash(MeasureBox(3)); return Box.last() is OtherBox; }
'''),
        isFalse,
      );
    });

    test('F-SCF31-7: control — a base nobody subclassed is still a base '
        '[2026-09-29] (PASS)', () {
      expect(
        run('''
bool main() { Box.stash(Box(1)); return Box.last() is MeasureBox; }
'''),
        isFalse,
      );
      expect(
        () => run('''
int size(MeasureBox b) => b.extra;
int main() { Box.stash(Box(1)); return size(Box.last()); }
'''),
        throwsA(predicate((e) => '$e'.contains("'MeasureBox'"))),
      );
    });

    test('F-SCF31-8: the pairing is recorded when the super object is set, '
        'not when it first crosses out [2026-09-29] (PASS)', () {
      final native = _NativeBox(1);
      final instance = interpreter.execute(
        source: '$_classes\nObject main() => MeasureBox(3);',
      );
      expect(instance, isA<InterpretedInstance>());
      final superObject = (instance as InterpretedInstance).bridgedSuperObject;
      expect(D4.interpretedBehind(superObject), same(instance));
      expect(D4.interpretedBehind(native), isNull);
      // The values an Expando refuses are never recorded rather than thrown.
      expect(
        () => D4.registerInterpretedForNative(1, instance),
        returnsNormally,
      );
      expect(D4.interpretedBehind(1), isNull);
    });
  });
}
