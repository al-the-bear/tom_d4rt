/// Plan G — null-propagation for arithmetic and bitwise binary operators.
///
/// The interpreter is intentionally lenient when one side of an arithmetic
/// or bitwise operator is `null`: it returns `null` instead of throwing
/// `Unsupported operator (…) for types null and …` or
/// `Native error during bridged operator '…': type 'Null' is not a
/// subtype of type 'num' in type cast`. This lets dynamic UI scripts that
/// read transient nulls (e.g. an animated value sampled before the bridged
/// getter is ready) degrade gracefully instead of crashing the render
/// pipeline.
///
/// Strict static Dart would reject these expressions; D4rt is dynamic and
/// chooses fault-tolerance for the scripting use case.
///
/// Excluded from null-propagation:
///   - `+` — String concatenation and bridged typed-`+` adapters keep their
///     existing semantics on the dedicated String/Bridged paths.
///   - `==`, `!=`, `<`, `<=`, `>`, `>=` — null comparisons are meaningful.
///   - `&&`, `||`, `??` — short-circuit/null-coalescing operators handled
///     before this dispatch.
library;

import 'package:tom_d4rt/d4rt.dart';
import 'package:test/test.dart';

void main() {
  group('Plan G — null-propagating arithmetic operators (left null)', () {
    late D4rt d4rt;

    setUp(() {
      d4rt = D4rt();
    });

    test('null * int returns null', () {
      final result = d4rt.execute(
        source: '''
        main() {
          dynamic x;
          return x * 2;
        }
      ''',
      );
      expect(result, isNull);
    });

    test('null * double returns null', () {
      final result = d4rt.execute(
        source: '''
        main() {
          dynamic x;
          return x * 3.14;
        }
      ''',
      );
      expect(result, isNull);
    });

    test('null * int chained still returns null', () {
      final result = d4rt.execute(
        source: '''
        main() {
          dynamic x;
          return x * 3.14 * 2;
        }
      ''',
      );
      expect(result, isNull);
    });

    test('null - int returns null', () {
      final result = d4rt.execute(
        source: '''
        main() {
          dynamic x;
          return x - 2;
        }
      ''',
      );
      expect(result, isNull);
    });

    test('null / int returns null', () {
      final result = d4rt.execute(
        source: '''
        main() {
          dynamic x;
          return x / 2;
        }
      ''',
      );
      expect(result, isNull);
    });

    test('null & int returns null', () {
      final result = d4rt.execute(
        source: '''
        main() {
          dynamic x;
          return x & 0xFF;
        }
      ''',
      );
      expect(result, isNull);
    });

    test('null | int returns null', () {
      final result = d4rt.execute(
        source: '''
        main() {
          dynamic x;
          return x | 0xFF;
        }
      ''',
      );
      expect(result, isNull);
    });

    test('null << int returns null', () {
      final result = d4rt.execute(
        source: '''
        main() {
          dynamic x;
          return x << 2;
        }
      ''',
      );
      expect(result, isNull);
    });
  });

  group('Plan G — null-propagating arithmetic operators (right null)', () {
    late D4rt d4rt;

    setUp(() {
      d4rt = D4rt();
    });

    test('int * null returns null', () {
      final result = d4rt.execute(
        source: '''
        main() {
          dynamic x;
          return 2 * x;
        }
      ''',
      );
      expect(result, isNull);
    });

    test('double - null returns null (mirrors bridged operator path)', () {
      final result = d4rt.execute(
        source: '''
        main() {
          dynamic x;
          double y = 5.0;
          return y - x;
        }
      ''',
      );
      expect(result, isNull);
    });

    test('int / null returns null', () {
      final result = d4rt.execute(
        source: '''
        main() {
          dynamic x;
          return 4 / x;
        }
      ''',
      );
      expect(result, isNull);
    });

    test('int & null returns null', () {
      final result = d4rt.execute(
        source: '''
        main() {
          dynamic x;
          return 0xFF & x;
        }
      ''',
      );
      expect(result, isNull);
    });
  });

  group('Plan G — preserved semantics', () {
    late D4rt d4rt;

    setUp(() {
      d4rt = D4rt();
    });

    test('non-null * int still works', () {
      final result = d4rt.execute(
        source: '''
        main() {
          dynamic x = 5;
          return x * 2;
        }
      ''',
      );
      expect(result, 10);
    });

    test('non-null & int still works', () {
      final result = d4rt.execute(
        source: '''
        main() {
          dynamic x = 0xF0;
          return x & 0x0F;
        }
      ''',
      );
      expect(result, 0);
    });

    test('non-null - non-null works', () {
      final result = d4rt.execute(
        source: '''
        main() {
          double a = 5.0;
          double b = 3.0;
          return a - b;
        }
      ''',
      );
      expect(result, 2.0);
    });

    test('String + null still uses stringify concat (not null-propagated)', () {
      // `+` is excluded from null-propagation so the existing
      // `'$left$right'` stringify fallback for String concatenation keeps
      // working — `'foo' + null` formats to `'foonull'` rather than being
      // silently turned into `null`.
      final result = d4rt.execute(
        source: '''
        main() {
          dynamic x;
          return 'foo' + x;
        }
      ''',
      );
      expect(result, 'foonull');
    });

    test('null == null is still true', () {
      final result = d4rt.execute(
        source: '''
        main() {
          dynamic x;
          dynamic y;
          return x == y;
        }
      ''',
      );
      expect(result, isTrue);
    });

    test('null != int is still true', () {
      final result = d4rt.execute(
        source: '''
        main() {
          dynamic x;
          return x != 5;
        }
      ''',
      );
      expect(result, isTrue);
    });
  });
}
