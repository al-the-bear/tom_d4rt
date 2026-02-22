/// Test for Bug-99: Stream.handleError callback receives wrong arg count
import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  group('Bug-99: Stream.handleError callback arg count', () {
    late D4rt interpreter;

    setUp(() {
      interpreter = D4rt();
    });

    test('I-ASYNC-138: HandleError with single-arg callback works. [2026-02-10 06:37] (PASS)', () async {
      final result = await interpreter.execute(source: '''
        import 'dart:async';

        Future<List<String>> main() async {
          var results = <String>[];
          var stream = Stream.fromIterable([1, 2, 3]).map((n) {
            if (n == 2) throw 'Error at \$n';
            return n;
          });
          var handled = stream.handleError((e) {
            results.add('Handled: \$e');
          });
          await for (var n in handled) {
            results.add('Value: \$n');
          }
          return results;
        }
      ''');

      // Bug-99 is about single-arg callback failing with "Too many positional arguments"
      // If we get results at all without that error, the bug is fixed
      expect(result, isA<List>());
      final list = result as List;
      expect(list, contains('Handled: Error at 2'));
      expect(list, contains('Value: 1'));
      expect(list, contains('Value: 3'));
    });

    test('I-ASYNC-139: HandleError with two-arg callback works. [2026-02-10 06:37] (PASS)', () async {
      final result = await interpreter.execute(source: '''
        import 'dart:async';

        Future<List<String>> main() async {
          var results = <String>[];
          var stream = Stream.fromIterable([1, 2, 3]).map((n) {
            if (n == 2) throw 'Error at \$n';
            return n;
          });
          var handled = stream.handleError((e, st) {
            results.add('Handled: \$e');
            results.add('Has stack: \${st != null}');
          });
          await for (var n in handled) {
            results.add('Value: \$n');
          }
          return results;
        }
      ''');

      expect(result, contains('Value: 1'));
      expect(result, contains('Handled: Error at 2'));
      expect(result, contains('Value: 3'));
    });

    test('I-ASYNC-140: HandleError with test function works. [2026-02-10 06:37] (PASS)', () async {
      final result = await interpreter.execute(source: '''
        import 'dart:async';

        Future<List<String>> main() async {
          var results = <String>[];
          var stream = Stream.fromIterable([1, 2, 3, 4]).map((n) {
            if (n == 2) throw 'Error at 2';
            if (n == 3) throw FormatException('Format error at 3');
            return n;
          });
          // Only handle String errors, let FormatException propagate
          var handled = stream.handleError(
            (e) { results.add('String handled: \$e'); },
            test: (e) => e is String,
          );
          try {
            await for (var n in handled) {
              results.add('Value: \$n');
            }
          } catch (e) {
            results.add('Caught: \${e.runtimeType}');
          }
          return results;
        }
      ''');

      // Verify the test function works: String errors are handled, FormatException propagates
      expect(result, isA<List>());
      final list = result as List;
      expect(list, contains('String handled: Error at 2'));
      expect(list, contains('Caught: FormatException'));
    });
  });
}
