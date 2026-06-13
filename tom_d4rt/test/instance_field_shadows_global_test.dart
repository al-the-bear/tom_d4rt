/// Regression test for FIX-20260613-1038-C — an instance field must shadow a
/// bridged top-level (library) function of the same name.
///
/// Context: `gradient_transform_test.dart` in the flutter-material corpus
/// emitted 33 framework errors of the form
///   `Invalid parameter "radians": expected double, got NativeFunction`
/// and
///   `Unsupported operator (*) for types double and NativeFunction`.
///
/// Root cause: inside an interpreted instance method, a bare identifier
/// `radians` was resolved against the FULL lexical chain first — which
/// reaches the global environment where the bridged top-level function
/// `radians(double degrees)` (from vector_math) lives. That `NativeFunction`
/// shadowed the instance field `radians`, so `Matrix4.rotationZ(radians)` and
/// `sign * radians` received a function instead of a double.
///
/// Dart semantics: instance members shadow library-level (top-level/imported)
/// declarations; only true locals (params, block locals, closures) shadow
/// instance members. These tests pin that precedence using a registered
/// bridged top-level function that collides with an instance field name.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

D4rt _interpreterWithRadians() {
  final d4rt = D4rt();
  // Bridged top-level function `radians(double degrees)` — mirrors the
  // vector_math global that triggered the original collision.
  d4rt.registertopLevelFunction(
    'radians',
    (visitor, args, namedArgs, typeArgs) =>
        (args[0] as num).toDouble() * 3.141592653589793 / 180.0,
    'package:fixture/math.dart',
    signature: 'double radians(double degrees)',
  );
  return d4rt;
}

void main() {
  group('FIX-20260613-1038-C — instance field shadows bridged global fn', () {
    test('bare instance field `radians` resolves to the field, not the global '
        'function', () {
      final d4rt = _interpreterWithRadians();
      final result = d4rt.execute(source: '''
import 'package:fixture/math.dart';

class Rotator {
  final double radians;
  const Rotator(this.radians);

  double readField() => radians;
}

main() => Rotator(1.5).readField();
''');
      expect(result, 1.5,
          reason: 'instance field `radians` must win over the bridged global '
              '`radians(double)` function');
    });

    test('instance field `radians` usable in arithmetic inside a method', () {
      final d4rt = _interpreterWithRadians();
      final result = d4rt.execute(source: '''
import 'package:fixture/math.dart';

class Rotator {
  final double radians;
  const Rotator(this.radians);

  double scaled(double sign) => sign * radians;
}

main() => Rotator(2.0).scaled(3.0);
''');
      expect(result, 6.0,
          reason: '`sign * radians` must multiply two doubles, not a double '
              'and a NativeFunction');
    });

    test('the bridged global `radians` is still callable where no instance '
        'member shadows it', () {
      final d4rt = _interpreterWithRadians();
      final result = d4rt.execute(source: '''
import 'package:fixture/math.dart';

main() => radians(180.0);
''');
      expect(result, closeTo(3.141592653589793, 1e-9),
          reason: 'top-level call site (no `this`) must still reach the '
              'bridged global function');
    });

    test('a true local named `radians` still shadows both the field and the '
        'global', () {
      final d4rt = _interpreterWithRadians();
      final result = d4rt.execute(source: '''
import 'package:fixture/math.dart';

class Rotator {
  final double radians;
  const Rotator(this.radians);

  double withLocal() {
    final radians = 9.0;
    return radians;
  }
}

main() => Rotator(1.0).withLocal();
''');
      expect(result, 9.0,
          reason: 'a local variable must shadow both the instance field and '
              'the bridged global');
    });
  });
}
