import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('RegExp methods - comprehensive', () {
    test('hasMatch [2026-02-10 06:37]', () {
      const source = '''
      main() {
        RegExp regex = RegExp(r'^hello');
        return [regex.hasMatch('hello world'), regex.hasMatch('world hello')];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('allMatches [2026-02-10 06:37]', () {
      const source = '''
      main() {
        RegExp regex = RegExp(r'\\d+');
        Iterable<Match> matches = regex.allMatches('123 abc 456');
        List<String?> result = [];
        for (var match in matches) {
          result.add(match.group(0));
        }
        return result;
      }
      ''';
      expect(execute(source), equals(['123', '456']));
    });

    test('stringMatch [2026-02-10 06:37]', () {
      const source = '''
      main() {
        RegExp regex = RegExp(r'world');
        return [regex.stringMatch('hello world'), regex.stringMatch('hello')];
      }
      ''';
      expect(execute(source), equals(['world', null]));
    });

    test('matchAsPrefix [2026-02-10 06:37]', () {
      const source = '''
      main() {
        RegExp regex = RegExp(r'hello');
        return [regex.matchAsPrefix('hello world')?.group(0), regex.matchAsPrefix('world hello')?.group(0)];
      }
      ''';
      expect(execute(source), equals(['hello', null]));
    });

    test('isCaseSensitive [2026-02-10 06:37]', () {
      const source = '''
      main() {
        RegExp regex = RegExp(r'hello', caseSensitive: false);
        return regex.isCaseSensitive;
      }
      ''';
      expect(execute(source), isFalse);
    });

    test('isDotAll [2026-02-10 06:37]', () {
      const source = '''
      main() {
        RegExp regex = RegExp(r'hello', dotAll: true);
        return regex.isDotAll;
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('isMultiLine [2026-02-10 06:37]', () {
      const source = '''
      main() {
        RegExp regex = RegExp(r'hello', multiLine: true);
        return regex.isMultiLine;
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('isUnicode [2026-02-10 06:37]', () {
      const source = '''
      main() {
        RegExp regex = RegExp(r'hello', unicode: true);
        return regex.isUnicode;
      }
      ''';
      expect(execute(source), isTrue);
    });

    test('pattern [2026-02-10 06:37]', () {
      const source = '''
      main() {
        RegExp regex = RegExp(r'hello');
        return regex.pattern;
      }
      ''';
      expect(execute(source), equals('hello'));
    });

    test('toString [2026-02-10 06:37]', () {
      const source = '''
      main() {
        RegExp regex = RegExp(r'hello');
        return regex.toString();
      }
      ''';
      // toString format might vary slightly across implementations, check pattern
      expect(execute(source), contains('pattern=hello'));
    });

    test('escape [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String escaped = RegExp.escape('hello.world');
        return escaped;
      }
      ''';
      expect(execute(source), equals('hello\\.world'));
    });
  });
}
