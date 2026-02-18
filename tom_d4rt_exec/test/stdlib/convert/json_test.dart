import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('Json tests', () {
    test('I-MISC-416: JsonCodec encode and decode. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:convert';
      main() {
        JsonCodec codec = JsonCodec();
        Map<String, dynamic> data = {"key": "value", "number": 42};
        String encoded = codec.encode(data);
        Map<String, dynamic> decoded = codec.decode(encoded);
        return [encoded, decoded];
      }
      ''';
      final result = execute(source) as List;
      expect(result[0], equals('{"key":"value","number":42}'));
      expect(result[1], equals({"key": "value", "number": 42}));
    });

    test('I-MISC-413: JsonEncoder convert. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:convert';
      main() {
        JsonEncoder encoder = JsonEncoder();
        Map<String, dynamic> data = {"key": "value", "number": 42};
        String encoded = encoder.convert(data);
        return encoded;
      }
      ''';
      expect(execute(source), equals('{"key":"value","number":42}'));
    });

    test('I-MISC-414: JsonDecoder convert. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:convert';
      main() {
        JsonDecoder decoder = JsonDecoder();
        String json = '{"key":"value","number":42}';
        Map<String, dynamic> decoded = decoder.convert(json);
        return decoded;
      }
      ''';
      expect(execute(source), equals({"key": "value", "number": 42}));
    });

    test('I-MISC-415: JsonEncode. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:convert';
      main() {
        Map<String, dynamic> data = {"key": "value", "number": 42};
        String encoded = jsonEncode(data);
        return encoded;
      }
      ''';
      expect(execute(source), equals('{"key":"value","number":42}'));
    });

    test('I-MISC-417: JsonDecode. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:convert';
      main() {
        String json = '{"key":"value","number":42}';
        Map<String, dynamic> decoded = jsonDecode(json);
        return decoded;
      }
      ''';
      expect(execute(source), equals({"key": "value", "number": 42}));
    });

    test('I-MISC-418: JsonEncode with toEncodable. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:convert';
      main() {
        Map<String, dynamic> data = {"key": "value", "date": DateTime(2023, 1, 1)};
        String encoded = jsonEncode(data, toEncodable: (nonEncodable) {
          if (nonEncodable is DateTime) {
            return nonEncodable.toIso8601String();
          }
          return nonEncodable.toString();
        });
        return encoded;
      }
      ''';
      expect(execute(source), contains('"key":"value"'));
      expect(execute(source), contains('"date":"2023-01-01T00:00:00.000'));
    });

    test('I-MISC-419: JsonDecode with reviver. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:convert';
      main() {
        String json = '{"key":"value","date":"2023-01-01T00:00:00.000Z"}';
        Map<String, dynamic> decoded = jsonDecode(json, reviver: (key, value) {
          if (key == "date") {
            return DateTime.parse(value);
          }
          return value;
        });
        return decoded;
      }
      ''';
      final result = execute(source) as Map;
      expect(result['key'], equals('value'));
      expect(result['date'], isA<DateTime>());
      expect((result['date'] as DateTime).isUtc, isTrue);
      expect((result['date'] as DateTime).year, equals(2023));
    });

    test('I-MISC-412: JsonCodec with toEncodable and reviver. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:convert';
      main() {
        JsonCodec codec = JsonCodec(
          toEncodable: (nonEncodable) {
            if (nonEncodable is DateTime) {
              return nonEncodable.toIso8601String();
            }
            return nonEncodable.toString();
          },
          reviver: (key, value) {
            if (key == "date" && value is String) {
              return DateTime.parse(value);
            }
            return value;
          },
        );
        Map<String, dynamic> data = {"key": "value", "date": DateTime.utc(2023, 1, 1)};
        String encoded = codec.encode(data);
        Map<String, dynamic> decoded = codec.decode(encoded);
        return [encoded, decoded];
      }
      ''';
      final result = execute(source) as List;
      expect(result[0],
          equals('{"key":"value","date":"2023-01-01T00:00:00.000Z"}'));
      final decodedMap = result[1] as Map;
      expect(decodedMap['key'], equals('value'));
      expect(decodedMap['date'], isA<DateTime>());
      expect((decodedMap['date'] as DateTime).isUtc, isTrue);
      expect((decodedMap['date'] as DateTime).year, equals(2023));
    });
  });
}
