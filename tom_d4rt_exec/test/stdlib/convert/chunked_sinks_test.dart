import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  const String testLibPath = 'd4rt-mem:/chunked_sinks_test.dart';

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

  group('ClosableStringSink (SC9)', () {
    test('F-SC9-11: fromStringSink writes through to the buffer. [2026-07-27]',
        () {
      final result = run(r'''
        final b = StringBuffer();
        final s = ClosableStringSink.fromStringSink(b, () {});
        s.write('hello');
        s.writeln(' world');
        s.writeCharCode(33);
        s.writeAll(['a', 'b'], '-');
        return b.toString().replaceAll('\n', '|');
      ''');
      expect(result, 'hello world|!a-b');
    });

    test('F-SC9-12: close() invokes the onClose callback. [2026-07-27]', () {
      final result = run('''
        var closed = false;
        final s = ClosableStringSink.fromStringSink(
            StringBuffer(), () { closed = true; });
        final before = closed;
        s.close();
        return [before, closed];
      ''');
      expect(result, [false, true]);
    });

    test('F-SC9-13: writeAll defaults to an empty separator. [2026-07-27]', () {
      final result = run('''
        final b = StringBuffer();
        ClosableStringSink.fromStringSink(b, () {}).writeAll([1, 2, 3]);
        return b.toString();
      ''');
      expect(result, '123');
    });

    test('F-SC9-14: fromStringSink rejects a non-StringSink. [2026-07-27]', () {
      expect(
        () => run("return ClosableStringSink.fromStringSink(42, () {});"),
        throwsA(isA<RuntimeD4rtException>().having((e) => e.toString(),
            'message', contains('requires a StringSink'))),
      );
    });

    test('F-SC9-15: fromStringSink rejects a non-Function onClose. [2026-07-27]',
        () {
      expect(
        () => run("return ClosableStringSink.fromStringSink(StringBuffer(), 7);"),
        throwsA(isA<RuntimeD4rtException>().having((e) => e.toString(),
            'message', contains('requires a callback'))),
      );
    });

    test('F-SC9-16: writeCharCode rejects a non-int. [2026-07-27]', () {
      expect(
        () => run(
            "return ClosableStringSink.fromStringSink(StringBuffer(), () {}).writeCharCode('x');"),
        throwsA(isA<RuntimeD4rtException>().having((e) => e.toString(),
            'message', contains('writeCharCode requires one int'))),
      );
    });
  });

  // StringConversionSink and ChunkedConversionSink were both fully written and
  // exported, but neither was ever passed to `defineBridge` — so no script
  // could name them. That made `Converter.startChunkedConversion` uncallable
  // (nothing could construct its argument) and left `asStringSink()`, the
  // idiomatic route to a ClosableStringSink, unreachable.
  group('chunked-conversion sinks, newly registered (SC9)', () {
    test('F-SC9-17: StringConversionSink.withCallback accumulates. [2026-07-27]',
        () {
      final result = run('''
        final out = [];
        final s = StringConversionSink.withCallback((v) { out.add(v); });
        s.add('abc');
        s.add('def');
        s.close();
        return out.join('/');
      ''');
      expect(result, 'abcdef');
    });

    test('F-SC9-18: addSlice writes a substring. [2026-07-27]', () {
      final result = run('''
        final out = [];
        final s = StringConversionSink.withCallback((v) { out.add(v); });
        s.addSlice('abcdef', 1, 4, true);
        return out.join();
      ''');
      expect(result, 'bcd');
    });

    test('F-SC9-19: asStringSink yields a working ClosableStringSink. [2026-07-27]',
        () {
      final result = run(r'''
        final out = [];
        final css = StringConversionSink.withCallback((v) { out.add(v); })
            .asStringSink();
        css.write('xy');
        css.writeln('z');
        css.close();
        return [css is ClosableStringSink, out.join().replaceAll('\n', '|')];
      ''');
      expect(result, [true, 'xyz|']);
    });

    test('F-SC9-20: ChunkedConversionSink.withCallback collects chunks. [2026-07-27]',
        () {
      final result = run('''
        final out = [];
        final s = ChunkedConversionSink.withCallback((chunks) {
          out.add(chunks.length);
        });
        s.add(1);
        s.add(2);
        s.close();
        return out.join();
      ''');
      expect(result, '2');
    });

    test('F-SC9-21: JsonEncoder.startChunkedConversion is now callable. [2026-07-27]',
        () {
      final result = run('''
        final out = [];
        final sink = JsonEncoder().startChunkedConversion(
            StringConversionSink.withCallback((v) { out.add(v); }));
        sink.add({'a': 1});
        sink.close();
        return out.join();
      ''');
      expect(result, '{"a":1}');
    });

    // Registering ChunkedConversionSink gave the root of the sink hierarchy an
    // `isAssignable` predicate, which matches *every* sink in the library. The
    // supertype edges in ConvertHierarchyConvert are what stop it from
    // swallowing its own subtypes; without them the specific surface
    // disappeared ("Bridged class 'ChunkedConversionSink' has no instance
    // method named 'asStringSink'"). These two guard that routing.
    test('F-SC9-22: a byte sink keeps its own surface. [2026-07-27]', () {
      final result = run('''
        final out = [];
        final s = ByteConversionSink.withCallback((b) { out.add(utf8.decode(b)); });
        s.add(utf8.encode('ab'));
        s.addSlice(utf8.encode('cdef'), 1, 3, false);
        s.close();
        return out.join();
      ''');
      expect(result, 'abde');
    });

    test('F-SC9-23: encoder and decoder route to their own sink kind. [2026-07-27]',
        () {
      final result = run('''
        final bytes = [];
        final enc = utf8.encoder.startChunkedConversion(
            ByteConversionSink.withCallback((b) { bytes.add(b.length); }));
        enc.add('hello');
        enc.close();
        final text = [];
        final dec = utf8.decoder.startChunkedConversion(
            StringConversionSink.withCallback((v) { text.add(v); }));
        dec.add(utf8.encode('hi there'));
        dec.close();
        return [bytes.join(), text.join()];
      ''');
      expect(result, ['5', 'hi there']);
    });
  });
}
