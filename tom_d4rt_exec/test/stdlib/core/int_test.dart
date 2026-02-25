import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('int tests', () {
    test('I-INT-33: Int.parse. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        int value1 = int.parse("123");
        int value2 = int.parse("-456");
        return [value1, value2];
      }
      ''';
      expect(execute(source), equals([123, -456]));
    });

    test('I-INT-29: Int.tryParse. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        int? value1 = int.tryParse("123");
        int? value2 = int.tryParse("-456");
        int? value3 = int.tryParse("invalid");
        return [value1, value2, value3];
      }
      ''';
      expect(execute(source), equals([123, -456, null]));
    });

    test('I-INT-30: Int.toString. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        int value1 = 123;
        int value2 = -456;
        return [value1.toString(), value2.toString()];
      }
      ''';
      expect(execute(source), equals(['123', '-456']));
    });

    test('I-INT-31: Int.abs. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        int value = -123;
        return value.abs();
      }
      ''';
      expect(execute(source), equals(123));
    });

    test('I-INT-32: Int.bitLength and sign. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        int value = 123;
        return [value.bitLength, value.sign];
      }
      ''';
      expect(execute(source), equals([7, 1]));
    });

    test('I-INT-34: Int.isEven and isOdd. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        int value1 = 123;
        int value2 = 124;
        return [value1.isOdd, value2.isEven];
      }
      ''';
      expect(execute(source), equals([true, true]));
    });

    test('I-INT-35: Int.toRadixString. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        int value = 255;
        return value.toRadixString(16);
      }
      ''';
      expect(execute(source), equals('ff'));
    });

    test('I-INT-36: Int.toUnsigned and toSigned. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        int value = 123456789;
        return [value.toUnsigned(16), value.toSigned(16)];
      }
      ''';
      expect(execute(source), equals([52501, -13035]));
    });

    test('I-INT-37: Int.gcd. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        int value1 = 48;
        int value2 = 18;
        return value1.gcd(value2);
      }
      ''';
      expect(execute(source), equals(6));
    });

    test('I-INT-26: Int.modPow and modInverse. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        int base = 4;
        int exponent = 13;
        int modulus = 497;
        return [base.modPow(exponent, modulus), base.modInverse(modulus)];
      }
      ''';
      expect(execute(source), equals([445, 373]));
    });

    test('I-INT-27: Int.hashCode. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        int value = 123;
        return value.hashCode;
      }
      ''';
      expect(execute(source), isA<int>());
    });

    test('I-INT-28: Int.bitwise operations. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        int value1 = 5; // 0101
        int value2 = 3; // 0011
        return [
          value1 & value2, // AND
          value1 | value2, // OR
          value1 ^ value2, // XOR
          value1 << 1, // Left shift
          value1 >> 1  // Right shift
        ];
      }
      ''';
      expect(execute(source), equals([1, 7, 6, 10, 2]));
    });
  });
}
