import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('RandomCore tests', () {
    test('I-MISC-432: Random.nextInt. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:math';
      main() {
        Random random = Random(42);
        return [random.nextInt(100), random.nextInt(100), random.nextInt(100)];
      }
      ''';
      // Values determined by running locally with seed 42
      expect(execute(source), equals([87, 58, 4]));
    });

    test('I-MISC-428: Random.nextDouble. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:math';
      main() {
        Random random = Random(42);
        return [random.nextDouble(), random.nextDouble(), random.nextDouble()];
      }
      ''';
      // Values determined by running locally with seed 42, use closeTo
      final result = execute(source) as List;
      expect(result[0], closeTo(0.150925, 0.000001));
      expect(result[1], closeTo(0.604147, 0.000001));
      expect(result[2], closeTo(0.661681, 0.000001));
    });

    test('I-MISC-429: Random.nextBool. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:math';
      main() {
        Random random = Random(42);
        return [random.nextBool(), random.nextBool(), random.nextBool()];
      }
      ''';
      // Values determined by running locally with seed 42
      expect(execute(source), equals([false, true, true]));
    });

    test('I-MISC-430: Random with no seed. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:math';
      main() {
        Random random = Random();
        return random.nextInt(100);
      }
      ''';
      // Cannot predict the value, just check the type
      expect(execute(source), isA<int>());
    });

    test('I-MISC-431: Random.toString. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:math';
      main() {
        Random random = Random(42);
        return random.toString();
      }
      ''';
      // toString might vary, check it returns something reasonable
      expect(execute(source), isA<String>());
      expect((execute(source) as String).isNotEmpty, isTrue);
    });

    test('I-MISC-433: Random.hashCode. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:math';
      main() {
        Random random1 = Random(42);
        Random random2 = Random(42);
        return random1.hashCode == random2.hashCode;
      }
      ''';
      // Two Random instances, even with the same seed, should not have the same hashCode
      expect(execute(source), isFalse);
    });
  });
}
