/// Test for Bug-92: Future factory constructor returns BridgedInstance
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  group('Bug-92: Future factory constructor', () {
    late D4rt interpreter;

    setUp(() {
      interpreter = D4rt();
    });

    test('Future(() => computation) returns awaitable value [2026-02-10 06:37]', () async {
      final result = await interpreter.execute(source: '''
        Future<String> main() async {
          var future = Future(() => 'Hello');
          var result = await future;
          return result;
        }
      ''');

      expect(result, equals('Hello'));
    });

    test('Future.value returns awaitable value [2026-02-10 06:37]', () async {
      final result = await interpreter.execute(source: '''
        Future<int> main() async {
          var future = Future.value(42);
          var result = await future;
          return result;
        }
      ''');

      expect(result, equals(42));
    });

    test('Future.delayed returns awaitable value [2026-02-10 06:37]', () async {
      final result = await interpreter.execute(source: '''
        Future<String> main() async {
          var future = Future.delayed(Duration(milliseconds: 10), () => 'delayed');
          var result = await future;
          return result;
        }
      ''');

      expect(result, equals('delayed'));
    });

    test('Future.microtask returns awaitable value [2026-02-10 06:37]', () async {
      final result = await interpreter.execute(source: '''
        Future<int> main() async {
          var future = Future.microtask(() => 100);
          var result = await future;
          return result;
        }
      ''');

      expect(result, equals(100));
    });

    test('Future.sync returns awaitable value [2026-02-10 06:37]', () async {
      final result = await interpreter.execute(source: '''
        Future<String> main() async {
          var future = Future.sync(() => 'sync');
          var result = await future;
          return result;
        }
      ''');

      expect(result, equals('sync'));
    });

    test('Chained Future.then works [2026-02-10 06:37]', () async {
      final result = await interpreter.execute(source: '''
        Future<int> main() async {
          var future = Future(() => 10).then((v) => v * 2);
          return await future;
        }
      ''');

      expect(result, equals(20));
    });

    test('Multiple await on Future factory works [2026-02-10 06:37]', () async {
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
