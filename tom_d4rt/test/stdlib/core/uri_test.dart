import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('Uri methods - comprehensive', () {
    test('toString [2026-02-10 06:37]', () {
      const source = '''
      main() {
        Uri uri = Uri.parse("https://example.com/path?query=value#fragment");
        return uri.toString();
      }
      ''';
      expect(execute(source),
          equals('https://example.com/path?query=value#fragment'));
    });

    test('host [2026-02-10 06:37]', () {
      const source = '''
      main() {
        Uri uri = Uri.parse("https://example.com/path");
        return uri.host;
      }
      ''';
      expect(execute(source), equals('example.com'));
    });

    test('port [2026-02-10 06:37]', () {
      const source = '''
      main() {
        Uri uri = Uri.parse("https://example.com:8080/path");
        return uri.port;
      }
      ''';
      expect(execute(source), equals(8080));
    });

    test('scheme [2026-02-10 06:37]', () {
      const source = '''
      main() {
        Uri uri = Uri.parse("https://example.com/path");
        return uri.scheme;
      }
      ''';
      expect(execute(source), equals('https'));
    });

    test('path [2026-02-10 06:37]', () {
      const source = '''
      main() {
        Uri uri = Uri.parse("https://example.com/path/to/resource");
        return uri.path;
      }
      ''';
      expect(execute(source), equals('/path/to/resource'));
    });

    test('query [2026-02-10 06:37]', () {
      const source = '''
      main() {
        Uri uri = Uri.parse("https://example.com/path?query=value");
        return uri.query;
      }
      ''';
      expect(execute(source), equals('query=value'));
    });

    test('fragment [2026-02-10 06:37]', () {
      const source = '''
      main() {
        Uri uri = Uri.parse("https://example.com/path#fragment");
        return uri.fragment;
      }
      ''';
      expect(execute(source), equals('fragment'));
    });

    test('encodeComponent [2026-02-10 06:37]', () {
      const source = '''
      main() {
        return Uri.encodeComponent("hello world");
      }
      ''';
      expect(execute(source), equals('hello%20world'));
    });

    test('decodeComponent [2026-02-10 06:37]', () {
      const source = '''
      main() {
        return Uri.decodeComponent("hello%20world");
      }
      ''';
      expect(execute(source), equals('hello world'));
    });

    test('encodeQueryComponent [2026-02-10 06:37]', () {
      const source = '''
      main() {
        return Uri.encodeQueryComponent("key=value");
      }
      ''';
      expect(execute(source), equals('key%3Dvalue'));
    });

    test('decodeQueryComponent [2026-02-10 06:37]', () {
      const source = '''
      main() {
        return Uri.decodeQueryComponent("key%3Dvalue");
      }
      ''';
      expect(execute(source), equals('key=value'));
    });

    test('encodeFull [2026-02-10 06:37]', () {
      const source = '''
      main() {
        return Uri.encodeFull("https://example.com/path?query=value#fragment");
      }
      ''';
      expect(execute(source),
          equals('https://example.com/path?query=value#fragment'));
    });

    test('decodeFull [2026-02-10 06:37]', () {
      const source = '''
      main() {
        return Uri.decodeFull("https%3A%2F%2Fexample.com%2Fpath%3Fquery%3Dvalue%23fragment");
      }
      ''';
      expect(execute(source),
          equals('https://example.com/path?query=value#fragment'));
    });

    test('splitQueryString [2026-02-10 06:37]', () {
      const source = '''
      main() {
        Map<String, String> queryParams = Uri.splitQueryString("key1=value1&key2=value2");
        return queryParams;
      }
      ''';
      expect(execute(source), equals({'key1': 'value1', 'key2': 'value2'}));
    });

    test('queryParametersAll [2026-02-10 06:37]', () {
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

    test('https [2026-02-10 06:37]', () {
      const source = '''
      main() {
        Uri uri = Uri.https("example.com", "/path", {"query": "value"});
        return uri.toString();
      }
      ''';
      expect(execute(source), equals('https://example.com/path?query=value'));
    });

    test('http [2026-02-10 06:37]', () {
      const source = '''
      main() {
        Uri uri = Uri.http("example.com", "/path", {"query": "value"});
        return uri.toString();
      }
      ''';
      expect(execute(source), equals('http://example.com/path?query=value'));
    });

    test('file [2026-02-10 06:37]', () {
      const source = '''
      main() {
        Uri uri = Uri.file("/path/to/file");
        return uri.toString();
      }
      ''';
      expect(execute(source), equals('file:///path/to/file'));
    });

    test('directory [2026-02-10 06:37]', () {
      const source = '''
      main() {
        Uri uri = Uri.directory("/path/to/directory");
        return uri.toString();
      }
      ''';
      expect(execute(source), equals('file:///path/to/directory/'));
    });

    test('dataFromBytes [2026-02-10 06:37]', () {
      const source = '''
      main() {
        Uri uri = Uri.dataFromBytes([104, 101, 108, 108, 111]);
        return uri.toString();
      }
      ''';
      expect(execute(source),
          equals('data:application/octet-stream;base64,aGVsbG8='));
    });

    test('dataFromString [2026-02-10 06:37]', () {
      const source = '''
      main() {
        Uri uri = Uri.dataFromString("hello");
        return uri.toString();
      }
      ''';
      expect(execute(source), equals('data:;charset=utf-8,hello'));
    });

    test('parse [2026-02-10 06:37]', () {
      const source = '''
      main() {
        Uri uri = Uri.parse("https://example.com/path");
        return uri.toString();
      }
      ''';
      expect(execute(source), equals('https://example.com/path'));
    });

    test('tryParse [2026-02-10 06:37]', () {
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
