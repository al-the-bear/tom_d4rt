import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('Duration tests', () {
    test('I-FILE-131: Duration creation. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Duration duration = Duration(days: 1, hours: 2, minutes: 30, seconds: 45, milliseconds: 500, microseconds: 250);
        return [
          duration.inDays,
          duration.inHours,
          duration.inMinutes,
          duration.inSeconds,
          duration.inMilliseconds,
          duration.inMicroseconds
        ];
      }
      ''';
      expect(
          execute(source), equals([1, 26, 1590, 95445, 95445500, 95445500250]));
    });

    test('I-FILE-127: Duration.fromMilliseconds and fromMicroseconds. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Duration duration1 = Duration(milliseconds: 123456);
        Duration duration2 = Duration(microseconds: 123456789);
        return [duration1.inMilliseconds, duration2.inMicroseconds];
      }
      ''';
      expect(execute(source), equals([123456, 123456789]));
    });

    test('I-FILE-128: Duration addition and subtraction. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Duration duration1 = Duration(hours: 1);
        Duration duration2 = Duration(minutes: 30);
        return [(duration1 + duration2).inMinutes, (duration1 - duration2).inMinutes];
      }
      ''';
      expect(execute(source), equals([90, 30]));
    });

    test('I-FILE-129: Duration multiplication and division. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Duration duration = Duration(minutes: 30);
        return [(duration * 2).inMinutes, (duration ~/ 2).inMinutes];
      }
      ''';
      expect(execute(source), equals([60, 15]));
    });

    test('I-FILE-130: Duration comparison. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Duration duration1 = Duration(hours: 1);
        Duration duration2 = Duration(minutes: 30);
        return [duration1 > duration2, duration1 < duration2, duration1 == Duration(hours: 1)];
      }
      ''';
      expect(execute(source), equals([true, false, true]));
    });

    test('I-FILE-132: Duration properties. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Duration duration = Duration(days: 1, hours: 2, minutes: 30, seconds: 45, milliseconds: 500, microseconds: 250);
        return [duration.isNegative, duration.abs().inHours];
      }
      ''';
      expect(execute(source), equals([false, 26]));
    });

    test('I-FILE-133: Duration.toString. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Duration duration = Duration(hours: 1, minutes: 30, seconds: 45);
        return duration.toString();
      }
      ''';
      expect(execute(source), equals('1:30:45.000000'));
    });

    test('I-FILE-134: Duration.zero. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Duration duration = Duration.zero;
        return duration.inMilliseconds;
      }
      ''';
      expect(execute(source), equals(0));
    });

    test('I-FILE-135: Duration.compareTo. [2026-02-10 06:37] (PASS)', () {
      const source = '''
     main() {
        Duration duration1 = Duration(hours: 1);
        Duration duration2 = Duration(minutes: 30);
        return [duration1.compareTo(duration2), duration2.compareTo(duration1), duration1.compareTo(Duration(hours: 1))];
      }
      ''';
      expect(execute(source), equals([1, -1, 0]));
    });
  });
}
