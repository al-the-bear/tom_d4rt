import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('String methods - comprehensive', () {
    test('I-STRING-27: Substring. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello world";
        return text.substring(0, 5);
      }
      ''';
      expect(execute(source), equals('hello'));
    });

    test('I-STRING-11: ToUpperCase. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello";
        return text.toUpperCase();
      }
      ''';
      expect(execute(source), equals('HELLO'));
    });

    test('I-STRING-22: ToLowerCase. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "HELLO";
        return text.toLowerCase();
      }
      ''';
      expect(execute(source), equals('hello'));
    });

    test('I-STRING-24: Contains. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello world";
        return [text.contains("world"), text.contains("dart")];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('I-STRING-25: StartsWith. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello world";
        return [text.startsWith("hello"), text.startsWith("world")];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('I-STRING-26: EndsWith. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello world";
        return [text.endsWith("world"), text.endsWith("hello")];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('I-STRING-28: IndexOf. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello world";
        return [text.indexOf("world"), text.indexOf("dart")];
      }
      ''';
      expect(execute(source), equals([6, -1]));
    });

    test('I-STRING-29: LastIndexOf. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello world world";
        return text.lastIndexOf("world");
      }
      ''';
      expect(execute(source), equals(12));
    });

    test('I-STRING-30: Trim. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "  hello world  ";
        return text.trim();
      }
      ''';
      expect(execute(source), equals('hello world'));
    });

    test('I-STRING-31: ReplaceAll. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello world";
        return text.replaceAll("world", "dart");
      }
      ''';
      expect(execute(source), equals('hello dart'));
    });

    test('I-STRING-5: Split. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello world";
        return text.split(" ");
      }
      ''';
      expect(execute(source), equals(['hello', 'world']));
    });

    test('I-STRING-6: PadLeft. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello";
        return text.padLeft(10, "-");
      }
      ''';
      expect(execute(source), equals('-----hello'));
    });

    test('I-STRING-7: PadRight. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello";
        return text.padRight(10, "-");
      }
      ''';
      expect(execute(source), equals('hello-----'));
    });

    test('I-STRING-8: ReplaceFirst. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello world";
        return text.replaceFirst("world", "dart");
      }
      ''';
      expect(execute(source), equals('hello dart'));
    });

    test('I-STRING-9: ReplaceRange. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello world";
        return text.replaceRange(6, 11, "dart");
      }
      ''';
      expect(execute(source), equals('hello dart'));
    });

    test('I-STRING-10: CodeUnitAt. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello";
        return text.codeUnitAt(0);
      }
      ''';
      expect(execute(source), equals(104));
    });

    test('I-STRING-12: ToString. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello";
        return text.toString();
      }
      ''';
      expect(execute(source), equals('hello'));
    });

    test('I-STRING-13: CompareTo. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello";
        return [text.compareTo("hello"), text.compareTo("world")];
      }
      ''';
      expect(execute(source), equals([0, -1]));
    });

    test('I-STRING-14: IsEmpty and isNotEmpty. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "";
        return [text.isEmpty, text.isNotEmpty];
      }
      ''';
      expect(execute(source), equals([true, false]));
    });

    test('I-STRING-15: Length. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello";
        return text.length;
      }
      ''';
      expect(execute(source), equals(5));
    });

    test('I-STRING-16: CodeUnits. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello";
        return text.codeUnits;
      }
      ''';
      expect(execute(source), equals([104, 101, 108, 108, 111]));
    });

    test('I-STRING-17: Runes. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello";
        return text.runes.toList();
      }
      ''';
      expect(execute(source), equals([104, 101, 108, 108, 111]));
    });

    test('I-STRING-18: ReplaceAllMapped. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello world";
        return text.replaceAllMapped("world", (match) => "dart");
      }
      ''';
      expect(execute(source), equals('hello dart'));
    });

    test('I-STRING-19: ReplaceFirstMapped. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        String text = "hello world world";
        return text.replaceFirstMapped("world", (match) => "dart");
      }
      ''';
      expect(execute(source), equals('hello dart world'));
    });

    test('I-STRING-20: FromCharCode. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        return String.fromCharCode(104);
      }
      ''';
      expect(execute(source), equals('h'));
    });

    test('I-STRING-21: FromCharCodes. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        return String.fromCharCodes([104, 101, 108, 108, 111]);
      }
      ''';
      expect(execute(source), equals('hello'));
    });

    test('I-STRING-23: FromEnvironment. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        return String.fromEnvironment("key", defaultValue: "default");
      }
      ''';
      expect(execute(source), equals('default'));
    });
  });
}
