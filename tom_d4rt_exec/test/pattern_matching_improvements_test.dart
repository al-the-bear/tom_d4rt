import 'test_helpers.dart';
import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

dynamic execute(String source, {List<Object?>? args}) {
  final d4rt = D4rt(parseSourceCallback: parseSource)..setDebug(false);
  return d4rt.execute(
      library: 'package:test/main.dart',
      positionalArgs: args,
      sources: {'package:test/main.dart': source});
}

void main() {
  group('Pattern Matching Improvements', () {
    test('I-PAT-8: Rest elements in list patterns. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        main() {
          var list = [1, 2, 3, 4, 5];
          switch (list) {
            case [var first, ...var rest]:
              return [first, rest];
            default:
              return "no match";
          }
        }
      ''';

      // This should now work with our implementation
      final result = execute(code);
      expect(
          result,
          equals([
            1,
            [2, 3, 4, 5]
          ]));
    });

    test('I-PAT-9: Rest elements in map patterns. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        main() {
          var map = {'a': 1, 'b': 2, 'c': 3};
          switch (map) {
            case {'a': var a, ...var rest}:
              return [a, rest];
            default:
              return "no match";
          }
        }
      ''';

      // This should now work with our implementation
      final result = execute(code);
      expect(
          result,
          equals([
            1,
            {'b': 2, 'c': 3}
          ]));
    });

    test('I-PAT-10: Object patterns with complex matching. [2026-02-10 06:37] (PASS)', () {
      final code = '''
        class Point {
          num x, y;
          Point(this.x, this.y);
        }
        
        main() {
          var point = Point(10, 20);
          switch (point) {
            case Point(x: var px, y: var py) when px > 5:
              return [px, py];
            default:
              return "no match";
          }
        }
      ''';

      // Bug-79 fix: Object patterns with guards now work correctly
      final result = execute(code);
      expect(result, equals([10, 20]));
    });
  });
}
