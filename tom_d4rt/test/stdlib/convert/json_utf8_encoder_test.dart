import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  const String testLibPath = 'd4rt-mem:/json_utf8_encoder_test.dart';

  dynamic run(String scriptBody) {
    final fullScript = '''
      import 'dart:convert';
      main() {
        $scriptBody
      }
    ''';
    return D4rt().execute(
      library: testLibPath,
      name: 'main',
      sources: {testLibPath: fullScript},
    );
  }

  group('JsonUtf8Encoder (SC9)', () {
    test('F-SC9-1: converts an object straight to UTF-8 JSON bytes. [2026-07-27]',
        () {
      final result = run('''
        final bytes = JsonUtf8Encoder().convert({'a': 1, 'b': [1, 2]});
        return [bytes.length, utf8.decode(bytes)];
      ''');
      expect(result, [17, '{"a":1,"b":[1,2]}']);
    });

    test('F-SC9-2: the indent argument selects pretty output. [2026-07-27]', () {
      final result = run(r'''
        return utf8.decode(JsonUtf8Encoder('  ').convert({'a': 1}))
            .replaceAll('\n', '|');
      ''');
      expect(result, '{|  "a": 1|}');
    });

    test('F-SC9-3: a null indent selects compact output. [2026-07-27]', () {
      final result = run('''
        return utf8.decode(JsonUtf8Encoder(null).convert({'a': 1}));
      ''');
      expect(result, '{"a":1}');
    });

    test('F-SC9-4: toEncodable is invoked for unsupported values. [2026-07-27]',
        () {
      final result = run('''
        final e = JsonUtf8Encoder(null, (o) => o.toString());
        return utf8.decode(e.convert([Duration(seconds: 1)]));
      ''');
      expect(result, '["0:00:01.000000"]');
    });

    // The reason this bridge exists. `JsonEncoder.fuse(Utf8Encoder())` is
    // specialised by the SDK to return a JsonUtf8Encoder rather than a generic
    // fused converter, so the already-shipped `fuse` adapter could hand back an
    // instance of an unregistered type — and every call on it failed with
    // "Undefined property or method 'convert' on JsonUtf8Encoder".
    test('F-SC9-5: JsonEncoder.fuse(Utf8Encoder()) is now usable. [2026-07-27]',
        () {
      final result = run('''
        final fused = JsonEncoder().fuse(Utf8Encoder());
        return [fused is JsonUtf8Encoder, utf8.decode(fused.convert({'a': 1}))];
      ''');
      expect(result, [true, '{"a":1}']);
    });

    test('F-SC9-6: startChunkedConversion drives a byte sink. [2026-07-27]', () {
      final result = run('''
        final out = [];
        final sink = JsonUtf8Encoder().startChunkedConversion(
            ByteConversionSink.withCallback((b) { out.add(utf8.decode(b)); }));
        sink.add({'x': 9});
        sink.close();
        return out.join();
      ''');
      expect(result, '{"x":9}');
    });

    test('F-SC9-7: a non-String indent is rejected. [2026-07-27]', () {
      expect(
        () => run("return JsonUtf8Encoder(42);"),
        throwsA(isA<RuntimeD4rtException>().having((e) => e.toString(),
            'message', contains('indent must be a String or null'))),
      );
    });

    test('F-SC9-8: a non-Function toEncodable is rejected. [2026-07-27]', () {
      expect(
        () => run("return JsonUtf8Encoder(null, 'x');"),
        throwsA(isA<RuntimeD4rtException>().having((e) => e.toString(),
            'message', contains('toEncodable must be a Function or null'))),
      );
    });

    test('F-SC9-9: a non-int bufferSize is rejected. [2026-07-27]', () {
      expect(
        () => run("return JsonUtf8Encoder(null, null, 'big');"),
        throwsA(isA<RuntimeD4rtException>().having((e) => e.toString(),
            'message', contains('bufferSize must be an int or null'))),
      );
    });

    test('F-SC9-10: convert requires exactly one argument. [2026-07-27]', () {
      expect(
        () => run("return JsonUtf8Encoder().convert();"),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });
  });
}
