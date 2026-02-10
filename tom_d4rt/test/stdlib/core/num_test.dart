import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('num methods - comprehensive', () {
    test('I-INT-58: Abs. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = -42.5;
        return value.abs();
      }
      ''';
      expect(execute(source), equals(42.5));
    });

    test('I-INT-44: Ceil. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42.3;
        return value.ceil();
      }
      ''';
      expect(execute(source), equals(43));
    });

    test('I-INT-54: Floor. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42.7;
        return value.floor();
      }
      ''';
      expect(execute(source), equals(42));
    });

    test('I-INT-55: Round. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42.5;
        return value.round();
      }
      ''';
      expect(execute(source), equals(43));
    });

    test('I-INT-56: ToInt. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42.9;
        return value.toInt();
      }
      ''';
      expect(execute(source), equals(42));
    });

    test('I-INT-57: ToDouble. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42;
        return value.toDouble();
      }
      ''';
      expect(execute(source), equals(42.0));
    });

    test('I-INT-59: ToString. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42.5;
        return value.toString();
      }
      ''';
      expect(execute(source), equals('42.5'));
    });

    test('I-INT-60: IsFinite. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42.5;
        return value.isFinite;
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('I-INT-61: IsInfinite. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = double.infinity;
        return value.isInfinite;
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('I-INT-62: IsNaN. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = double.nan;
        return value.isNaN;
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('I-INT-38: IsNegative. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = -42.5;
        return value.isNegative;
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('I-INT-39: Clamp. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42.5;
        return [value.clamp(40, 45), value.clamp(43, 50)];
      }
      ''';
      expect(execute(source), equals([42.5, 43]));
    });

    test('I-INT-40: Remainder. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42.5;
        return value.remainder(10);
      }
      ''';
      expect(execute(source), equals(2.5));
    });

    test('I-INT-41: CompareTo. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42.5;
        return [value.compareTo(42.5), value.compareTo(50), value.compareTo(40)];
      }
      ''';
      expect(execute(source), equals([0, -1, 1]));
    });

    test('I-INT-42: Sign. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = -42.5;
        return value.sign;
      }
      ''';
      expect(execute(source), equals(-1.0));
    });

    test('I-INT-43: ToStringAsFixed. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42.56789;
        return value.toStringAsFixed(2);
      }
      ''';
      expect(execute(source), equals('42.57'));
    });

    test('I-INT-45: ToStringAsExponential. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42.56789;
        return value.toStringAsExponential(2);
      }
      ''';
      expect(execute(source), equals('4.26e+1'));
    });

    test('I-INT-46: ToStringAsPrecision. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42.56789;
        return value.toStringAsPrecision(4);
      }
      ''';
      expect(execute(source), equals('42.57'));
    });

    test('I-INT-47: Truncate. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42.9;
        return value.truncate();
      }
      ''';
      expect(execute(source), equals(42));
    });

    test('I-INT-48: TruncateToDouble. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42.9;
        return value.truncateToDouble();
      }
      ''';
      expect(execute(source), equals(42.0));
    });

    test('I-INT-49: CeilToDouble. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42.3;
        return value.ceilToDouble();
      }
      ''';
      expect(execute(source), equals(43.0));
    });

    test('I-INT-50: FloorToDouble. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42.7;
        return value.floorToDouble();
      }
      ''';
      expect(execute(source), equals(42.0));
    });

    test('I-INT-51: RoundToDouble. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = 42.5;
        return value.roundToDouble();
      }
      ''';
      expect(execute(source), equals(43.0));
    });

    test('I-INT-52: Parse. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num value = num.parse("42.5");
        return value;
      }
      ''';
      expect(execute(source), equals(42.5));
    });

    test('I-INT-53: TryParse. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        num? value = num.tryParse("42.5");
        num? invalid = num.tryParse("invalid");
        return [value, invalid];
      }
      ''';
      expect(execute(source), equals([42.5, null]));
    });
  });
}
