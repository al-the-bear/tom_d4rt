import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('Base64 methods - comprehensive', () {
    test('I-MISC-399: Base64Codec encode. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:convert';
      main() {
        Base64Codec codec = Base64Codec();
        return codec.encode([104, 101, 108, 108, 111]); // "hello"
      }
      ''';
      expect(execute(source), equals('aGVsbG8='));
    });

    test('I-MISC-395: Base64Codec decode. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:convert';
      main() {
        Base64Codec codec = Base64Codec();
        return codec.decode("aGVsbG8="); // "hello"
      }
      ''';
      expect(execute(source), equals([104, 101, 108, 108, 111]));
    });

    test('I-MISC-396: Base64Encoder convert. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:convert';
      main() {
        Base64Encoder encoder = Base64Encoder();
        return encoder.convert([104, 101, 108, 108, 111]); // "hello"
      }
      ''';
      expect(execute(source), equals('aGVsbG8='));
    });

    test('I-MISC-397: Base64Decoder convert. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:convert';
      main() {
        Base64Decoder decoder = Base64Decoder();
        return decoder.convert("aGVsbG8="); // "hello"
      }
      ''';
      expect(execute(source), equals([104, 101, 108, 108, 111]));
    });

    test('I-MISC-398: Base64Codec normalize. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:convert';
      main() {
        Base64Codec codec = Base64Codec();
        return codec.normalize("aGVsbG8="); // "aGVsbG8="
      }
      ''';
      expect(execute(source), equals('aGVsbG8='));
    });
  });
}
