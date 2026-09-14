/// SCD119 — a native proxy standing in for an interpreted instance must bind
/// to a parameter declared as the script's own class.
///
/// THE SHAPE, as the flutter corpus met it. A script declares
/// `class BrandColors extends ThemeExtension<BrandColors>` and hands instances
/// of it to Flutter. `ThemeExtension` is bridged, so the value that crosses
/// into native code is a registered `D4InterpretedProxy` —
/// `_InterpretedThemeExtension`, holding the `InterpretedInstance`. When such a
/// value comes back and is passed to a script function declared
/// `Widget brandPreview(BrandColors brand)`, the bind failed with
///
///     type 'ThemeExtension' is not a subtype of type 'BrandColors' of 'brand'
///
/// while EVERY MEMBER ACCESS on the same value worked. That asymmetry is the
/// whole diagnosis: the property and method paths already unwrap a proxy (the
/// D2 sites in `interpreter_visitor.dart`), and the type check was the only
/// place that did not. Measured by changing the script's parameter to `dynamic`
/// — `frameworkErrors` went 1 -> 0 with nothing else touched, so the value was
/// always usable and only the verdict on it was wrong.
///
/// WHY THE FIX IS AT THE FAILING BRANCH AND NOT IN `getRuntimeType`. Teaching
/// the environment to see through every proxy is the more correct model, and it
/// would change what `is`, `as` and `runtimeType` answer for every proxied
/// widget in a live tree. Cluster 25 was reverted in April for exactly that
/// kind of reach on the dispatch path. Retrying the check only AFTER it has
/// already failed can remove a rejection but never add one, so no program that
/// binds today stops binding.
///
/// F-SCD119-3 and F-SCD119-4 are the controls. A guard that is repaired by
/// "unwrap and accept" is trivially over-repaired into "accept anything
/// wrapped", and these two are what stands between the two readings.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// The native base a bridge is registered for — `ThemeExtension`'s stand-in.
class _NativeShape {
  const _NativeShape();
}

/// An unrelated bridged native type, for the control.
class _NativeCrate {
  const _NativeCrate();
}

/// What `D4.registerInterfaceProxy` produces: a real native subtype that
/// carries the interpreted instance it stands for.
class ShapeProxy extends _NativeShape implements D4InterpretedProxy {
  ShapeProxy(this._instance);
  final Object _instance;

  @override
  Object get d4rtInstance => _instance;
}

/// The native round-trip: hand it the interpreted instance, get the proxy that
/// stands for it. IDEMPOTENT, like the real `D4.registerInterfaceProxy`
/// factories — a proxy is made from an `InterpretedInstance`, never from
/// another proxy, so re-crossing the boundary with a value that is already
/// proxied hands the same object back.
Object? _wrap(
  InterpreterVisitor visitor,
  List<Object?> positional,
  Map<String, Object?> named,
  List<RuntimeType>? typeArgs,
) {
  final value = positional[0];
  return value is ShapeProxy ? value : ShapeProxy(value as Object);
}

void main() {
  group('SCD119: a D4InterpretedProxy binds as the class it stands for', () {
    late D4rt interpreter;

    setUp(() {
      interpreter = D4rt();

      // `Shape` is the bridged superclass a script extends. `wrap` is the
      // native round-trip: it takes the interpreted instance and gives back the
      // proxy, which is what a real bridge hands to Flutter and what Flutter
      // hands back.
      interpreter.registerBridgedClass(
        BridgedClass(
          nativeType: _NativeShape,
          name: 'Shape',
          constructors: {'': (visitor, positional, named) => _NativeShape()},
          staticMethods: {'wrap': _wrap},
        ),
        'package:test/shape.dart',
      );

      interpreter.registerBridgedClass(
        BridgedClass(
          nativeType: _NativeCrate,
          name: 'Crate',
          constructors: {'': (visitor, positional, named) => _NativeCrate()},
          staticMethods: {'wrap': _wrap},
        ),
        'package:test/crate.dart',
      );
    });

    test(
      'F-SCD119-1: a proxy binds to a parameter declared as the script class '
      'it wraps [2026-09-14]',
      () {
        // Pre-fix: `type 'Shape' is not a subtype of type 'MyShape' of 's'`.
        final code = '''
          import 'package:test/shape.dart';

          class MyShape extends Shape {
            int size = 7;
          }

          int take(MyShape s) => s.size;

          int main() {
            final proxied = Shape.wrap(MyShape());
            return take(proxied);
          }
        ''';
        expect(interpreter.execute(source: code), equals(7));
      },
    );

    test('F-SCD119-2: the PROXY is what gets bound, not the instance behind it '
        '[2026-09-14]', () {
      // The value has to stay whatever native code downstream expects; only
      // the verdict on it changes. `Shape.wrap` accepts anything, so passing
      // the bound value straight back through a native boundary is the
      // cheapest way to ask what was actually bound: a proxy round-trips,
      // and its member access still reaches the interpreted class.
      final code = '''
          import 'package:test/shape.dart';

          class MyShape extends Shape {
            int size = 11;
          }

          int take(MyShape s) {
            final again = Shape.wrap(s);
            return take2(again);
          }

          int take2(MyShape s) => s.size;

          int main() => take(Shape.wrap(MyShape()));
        ''';
      expect(interpreter.execute(source: code), equals(11));
    });

    test('F-SCD119-3 (control): a proxy does NOT bind to an unrelated script '
        'class [2026-09-14]', () {
      // Same proxy machinery, wrong declared class. If this passes, the fix
      // has stopped being a type check and become an unwrap-and-accept.
      final code = '''
          import 'package:test/shape.dart';

          class MyShape extends Shape {
            int size = 3;
          }

          class OtherShape extends Shape {
            int size = 4;
          }

          int take(OtherShape s) => s.size;

          int main() => take(Shape.wrap(MyShape()));
        ''';
      expect(
        () => interpreter.execute(source: code),
        throwsA(
          predicate(
            (e) => e.toString().contains("is not a subtype of type"),
            'a subtype rejection naming the declared type',
          ),
        ),
      );
    });

    test('F-SCD119-4 (control): a NON-proxy native value is still rejected '
        '[2026-09-14]', () {
      // The retry is reached only for a `D4InterpretedProxy`. A bare bridged
      // value that happens to be wrong must still be refused by the base
      // check, unchanged.
      final code = '''
          import 'package:test/shape.dart';

          class MyShape extends Shape {
            int size = 5;
          }

          int take(MyShape s) => s.size;

          int main() => take(Shape());
        ''';
      expect(
        () => interpreter.execute(source: code),
        throwsA(
          predicate(
            (e) => e.toString().contains("is not a subtype of type"),
            'a subtype rejection',
          ),
        ),
      );
    });
  });
}
