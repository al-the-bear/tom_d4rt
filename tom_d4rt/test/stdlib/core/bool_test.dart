import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('bool tests', () {
    test('I-BOOL-5: Bool.parse. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        bool value1 = bool.parse("true");
        bool value2 = bool.parse("false");
        return [value1, value2];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('I-BOOL-1: Bool.tryParse. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        bool? value1 = bool.tryParse("true");
        bool? value2 = bool.tryParse("false");
        bool? value3 = bool.tryParse("invalid");
        return [value1, value2, value3];
      }
      ''';
      expect(execute(source), equals([true, false, null]));
    });

    test('I-BOOL-2: Bool.toString. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        bool value1 = true;
        bool value2 = false;
        return [value1.toString(), value2.toString()];
      }
      ''';
      expect(execute(source), equals(['true', 'false']));
    });

    test('I-BOOL-3: Bool.hashCode. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        bool value1 = true;
        bool value2 = false;
        return [value1.hashCode, value2.hashCode];
      }
      ''';
      final result = execute(source) as List;
      expect(result[0], isA<int>());
      expect(result[1], isA<int>());
      expect(result[0], isNot(equals(result[1])));
    });

    test('I-BOOL-4: Bool logical operators. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        bool value1 = true;
        bool value2 = false;
        return [value1 && value2, value1 || value2, !value1];
      }
      ''';
      expect(execute(source), equals([false, true, false]));
    });

    test('I-BOOL-6: Bool equality. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        bool value1 = true;
        bool value2 = false;
        return [value1 == value2, value1 != value2];
      }
      ''';
      expect(execute(source), equals([false, true]));
    });

    test('I-BOOL-7: Bool.parse with caseSensitive. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        bool value1 = bool.parse("TRUE", caseSensitive: false);
        bool value2 = bool.parse("FALSE", caseSensitive: false);
        return [value1, value2];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('I-BOOL-8: Bool.tryParse with caseSensitive. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        bool? value1 = bool.tryParse("TRUE", caseSensitive: false);
        bool? value2 = bool.tryParse("FALSE", caseSensitive: false);
        bool? value3 = bool.tryParse("INVALID", caseSensitive: false);
        return [value1, value2, value3];
      }
      ''';
      expect(execute(source), equals([true, false, null]));
    });
  });
}
