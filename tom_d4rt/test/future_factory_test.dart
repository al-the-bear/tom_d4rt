/// Test for Bug-92: Future factory constructor returns BridgedInstance
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  group('Bug-92: Future factory constructor', () {
    late D4rt interpreter;

    setUp(() {
      interpreter = D4rt();
    });

    test('I-ASYNC-48: Future(() => computation) returns awaitable value. [2026-02-10 06:37] (PASS)', () async {
      final result = await interpreter.execute(source: '''
        Future<String> main() async {
          var future = Future(() => 'Hello');
          var result = await future;
          return result;
        }
      ''');

      expect(result, equals('Hello'));
    });

    test('I-ASYNC-49: Future.value returns awaitable value. [2026-02-10 06:37] (PASS)', () async {
      final result = await interpreter.execute(source: '''
        Future<int> main() async {
          var future = Future.value(42);
          var result = await future;
          return result;
        }
      ''');

      expect(result, equals(42));
    });

    test('I-ASYNC-50: Future.delayed returns awaitable value. [2026-02-10 06:37] (PASS)', () async {
      final result = await interpreter.execute(source: '''
        Future<String> main() async {
          var future = Future.delayed(Duration(milliseconds: 10), () => 'delayed');
          var result = await future;
          return result;
        }
      ''');

      expect(result, equals('delayed'));
    });

    test('I-ASYNC-51: Future.microtask returns awaitable value. [2026-02-10 06:37] (PASS)', () async {
      final result = await interpreter.execute(source: '''
        Future<int> main() async {
          var future = Future.microtask(() => 100);
          var result = await future;
          return result;
        }
      ''');

      expect(result, equals(100));
    });

    test('I-ASYNC-52: Future.sync returns awaitable value. [2026-02-10 06:37] (PASS)', () async {
      final result = await interpreter.execute(source: '''
        Future<String> main() async {
          var future = Future.sync(() => 'sync');
          var result = await future;
          return result;
        }
      ''');

      expect(result, equals('sync'));
    });

    test('I-ASYNC-53: Chained Future.then works. [2026-02-10 06:37] (PASS)', () async {
      final result = await interpreter.execute(source: '''
        Future<int> main() async {
          var future = Future(() => 10).then((v) => v * 2);
          return await future;
        }
      ''');

      expect(result, equals(20));
    });

    test('I-ASYNC-54: Multiple await on Future factory works. [2026-02-10 06:37] (PASS)', () async {
      final result = await interpreter.execute(source: '''
        Future<int> main() async {
          var a = await Future(() => 1);
          var b = await Future(() => 2);
          var c = await Future(() => 3);
          return a + b + c;
        }
      ''');

      expect(result, equals(6));
    });
  });
}
