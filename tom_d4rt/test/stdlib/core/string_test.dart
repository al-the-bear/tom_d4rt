import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('String methods - comprehensive', () {
    test('substring [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello world";
        return text.substring(0, 5);
      }
      ''';
      expect(execute(source), equals('hello'));
    });

    test('toUpperCase [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello";
        return text.toUpperCase();
      }
      ''';
      expect(execute(source), equals('HELLO'));
    });

    test('toLowerCase [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "HELLO";
        return text.toLowerCase();
      }
      ''';
      expect(execute(source), equals('hello'));
    });

    test('contains [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello world";
        return [text.contains("world"), text.contains("dart")];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('startsWith [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello world";
        return [text.startsWith("hello"), text.startsWith("world")];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('endsWith [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello world";
        return [text.endsWith("world"), text.endsWith("hello")];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('indexOf [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello world";
        return [text.indexOf("world"), text.indexOf("dart")];
      }
      ''';
      expect(execute(source), equals([6, -1]));
    });

    test('lastIndexOf [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello world world";
        return text.lastIndexOf("world");
      }
      ''';
      expect(execute(source), equals(12));
    });

    test('trim [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "  hello world  ";
        return text.trim();
      }
      ''';
      expect(execute(source), equals('hello world'));
    });

    test('replaceAll [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello world";
        return text.replaceAll("world", "dart");
      }
      ''';
      expect(execute(source), equals('hello dart'));
    });

    test('split [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello world";
        return text.split(" ");
      }
      ''';
      expect(execute(source), equals(['hello', 'world']));
    });

    test('padLeft [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello";
        return text.padLeft(10, "-");
      }
      ''';
      expect(execute(source), equals('-----hello'));
    });

    test('padRight [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello";
        return text.padRight(10, "-");
      }
      ''';
      expect(execute(source), equals('hello-----'));
    });

    test('replaceFirst [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello world";
        return text.replaceFirst("world", "dart");
      }
      ''';
      expect(execute(source), equals('hello dart'));
    });

    test('replaceRange [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello world";
        return text.replaceRange(6, 11, "dart");
      }
      ''';
      expect(execute(source), equals('hello dart'));
    });

    test('codeUnitAt [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello";
        return text.codeUnitAt(0);
      }
      ''';
      expect(execute(source), equals(104));
    });

    test('toString [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello";
        return text.toString();
      }
      ''';
      expect(execute(source), equals('hello'));
    });

    test('compareTo [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello";
        return [text.compareTo("hello"), text.compareTo("world")];
      }
      ''';
      expect(execute(source), equals([0, -1]));
    });

    test('isEmpty and isNotEmpty [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "";
        return [text.isEmpty, text.isNotEmpty];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('length [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello";
        return text.length;
      }
      ''';
      expect(execute(source), equals(5));
    });

    test('codeUnits [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello";
        return text.codeUnits;
      }
      ''';
      expect(execute(source), equals([104, 101, 108, 108, 111]));
    });

    test('runes [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello";
        return text.runes.toList();
      }
      ''';
      expect(execute(source), equals([104, 101, 108, 108, 111]));
    });

    test('replaceAllMapped [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello world";
        return text.replaceAllMapped("world", (match) => "dart");
      }
      ''';
      expect(execute(source), equals('hello dart'));
    });

    test('replaceFirstMapped [2026-02-10 06:37]', () {
      const source = '''
      main() {
        String text = "hello world world";
        return text.replaceFirstMapped("world", (match) => "dart");
      }
      ''';
      expect(execute(source), equals('hello dart world'));
    });

    test('fromCharCode [2026-02-10 06:37]', () {
      const source = '''
      main() {
        return String.fromCharCode(104);
      }
      ''';
      expect(execute(source), equals('h'));
    });

    test('fromCharCodes [2026-02-10 06:37]', () {
      const source = '''
      main() {
        return String.fromCharCodes([104, 101, 108, 108, 111]);
      }
      ''';
      expect(execute(source), equals('hello'));
    });

    test('fromEnvironment [2026-02-10 06:37]', () {
      const source = '''
      main() {
        return String.fromEnvironment("key", defaultValue: "default");
      }
      ''';
      expect(execute(source), equals('default'));
    });
  });
}
