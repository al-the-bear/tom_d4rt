import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('Uri methods - comprehensive', () {
    test('I-NET-49: ToString. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Uri uri = Uri.parse("https://example.com/path?query=value#fragment");
        return uri.toString();
      }
      ''';
      expect(execute(source),
          equals('https://example.com/path?query=value#fragment'));
    });

    test('I-NET-38: Host. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Uri uri = Uri.parse("https://example.com/path");
        return uri.host;
      }
      ''';
      expect(execute(source), equals('example.com'));
    });

    test('I-NET-45: Port. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Uri uri = Uri.parse("https://example.com:8080/path");
        return uri.port;
      }
      ''';
      expect(execute(source), equals(8080));
    });

    test('I-NET-46: Scheme. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Uri uri = Uri.parse("https://example.com/path");
        return uri.scheme;
      }
      ''';
      expect(execute(source), equals('https'));
    });

    test('I-NET-47: Path. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Uri uri = Uri.parse("https://example.com/path/to/resource");
        return uri.path;
      }
      ''';
      expect(execute(source), equals('/path/to/resource'));
    });

    test('I-NET-48: Query. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Uri uri = Uri.parse("https://example.com/path?query=value");
        return uri.query;
      }
      ''';
      expect(execute(source), equals('query=value'));
    });

    test('I-NET-50: Fragment. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Uri uri = Uri.parse("https://example.com/path#fragment");
        return uri.fragment;
      }
      ''';
      expect(execute(source), equals('fragment'));
    });

    test('I-NET-51: EncodeComponent. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        return Uri.encodeComponent("hello world");
      }
      ''';
      expect(execute(source), equals('hello%20world'));
    });

    test('I-NET-52: DecodeComponent. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        return Uri.decodeComponent("hello%20world");
      }
      ''';
      expect(execute(source), equals('hello world'));
    });

    test('I-NET-53: EncodeQueryComponent. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        return Uri.encodeQueryComponent("key=value");
      }
      ''';
      expect(execute(source), equals('key%3Dvalue'));
    });

    test('I-NET-31: DecodeQueryComponent. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        return Uri.decodeQueryComponent("key%3Dvalue");
      }
      ''';
      expect(execute(source), equals('key=value'));
    });

    test('I-NET-32: EncodeFull. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        return Uri.encodeFull("https://example.com/path?query=value#fragment");
      }
      ''';
      expect(execute(source),
          equals('https://example.com/path?query=value#fragment'));
    });

    test('I-NET-33: DecodeFull. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        return Uri.decodeFull("https%3A%2F%2Fexample.com%2Fpath%3Fquery%3Dvalue%23fragment");
      }
      ''';
      expect(execute(source),
          equals('https://example.com/path?query=value#fragment'));
    });

    test('I-NET-34: SplitQueryString. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Map<String, String> queryParams = Uri.splitQueryString("key1=value1&key2=value2");
        return queryParams;
      }
      ''';
      expect(execute(source), equals({'key1': 'value1', 'key2': 'value2'}));
    });

    test('I-NET-35: QueryParametersAll. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Uri uri = Uri.parse("https://example.com/path?key=value&key=value2");
        return uri.queryParametersAll;
      }
      ''';
      expect(
          execute(source),
          equals({
            'key': ['value', 'value2']
          }));
    });

    test('I-NET-36: Https. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Uri uri = Uri.https("example.com", "/path", {"query": "value"});
        return uri.toString();
      }
      ''';
      expect(execute(source), equals('https://example.com/path?query=value'));
    });

    test('I-NET-37: Http. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Uri uri = Uri.http("example.com", "/path", {"query": "value"});
        return uri.toString();
      }
      ''';
      expect(execute(source), equals('http://example.com/path?query=value'));
    });

    test('I-NET-39: File. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Uri uri = Uri.file("/path/to/file");
        return uri.toString();
      }
      ''';
      expect(execute(source), equals('file:///path/to/file'));
    });

    test('I-NET-40: Directory. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Uri uri = Uri.directory("/path/to/directory");
        return uri.toString();
      }
      ''';
      expect(execute(source), equals('file:///path/to/directory/'));
    });

    test('I-NET-41: DataFromBytes. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Uri uri = Uri.dataFromBytes([104, 101, 108, 108, 111]);
        return uri.toString();
      }
      ''';
      expect(execute(source),
          equals('data:application/octet-stream;base64,aGVsbG8='));
    });

    test('I-NET-42: DataFromString. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Uri uri = Uri.dataFromString("hello");
        return uri.toString();
      }
      ''';
      expect(execute(source), equals('data:;charset=utf-8,hello'));
    });

    test('I-NET-43: Parse. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Uri uri = Uri.parse("https://example.com/path");
        return uri.toString();
      }
      ''';
      expect(execute(source), equals('https://example.com/path'));
    });

    test('I-NET-44: TryParse. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      main() {
        Uri? uri = Uri.tryParse("https://example.com/path");
        return uri?.toString();
      }
      ''';
      expect(execute(source), equals('https://example.com/path'));
    });
  });
}
