import '../../interpreter_test.dart';
import 'package:test/test.dart';

void main() {
  group('Codec tests', () {
    test('I-MISC-402: Codec encode and decode. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:convert';
      main() {
        Codec<String, List<int>> codec = Utf8Codec();
        List<int> encoded = codec.encode("hello");
        String decoded = codec.decode(encoded);
        return [encoded, decoded];
      }
      ''';
      expect(
          execute(source),
          equals([
            [104, 101, 108, 108, 111],
            'hello'
          ]));
    });

    test('I-MISC-400: Codec fuse. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:convert';
      main() {
        Codec<String, String> codec = Utf8Codec().fuse(Base64Codec());
        String encoded = codec.encode("hello");
        String decoded = codec.decode(encoded);
        return [encoded, decoded];
      }
      ''';
      expect(execute(source), equals(['aGVsbG8=', 'hello']));
    });

    test('I-MISC-401: Codec encoder and decoder. [2026-02-10 06:37] (PASS)', () {
      const source = '''
      import 'dart:convert';
      main() {
        Codec<String, List<int>> codec = Utf8Codec();
        Converter<String, List<int>> encoder = codec.encoder;
        Converter<List<int>, String> decoder = codec.decoder;
        List<int> encoded = encoder.convert("hello");
        String decoded = decoder.convert(encoded);
        return [encoded, decoded];
      }
      ''';
      expect(
          execute(source),
          equals([
            [104, 101, 108, 108, 111],
            'hello'
          ]));
    });
  });
}
