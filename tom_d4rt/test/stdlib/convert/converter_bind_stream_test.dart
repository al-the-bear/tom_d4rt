import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// SCC68 — `Converter.bind` over a script-built stream.
///
/// **What was broken.** Every `bind` adapter in `dart:convert` guarded its
/// argument with a *container-typed* test (`positionalArgs[0] is!
/// Stream&lt;String&gt;`) and then made the matching container-typed cast. The
/// interpreter erases type arguments — `Stream.fromIterable` hands back a
/// `Stream<Object?>` and a list literal evaluates to `List<Object?>` — so the
/// guard rejected every stream a script could construct. The whole
/// `Converter.bind` surface was unreachable from interpreted code, and the
/// symptom was the guard's own message rather than a cast error, which is why
/// it read as "wrong argument" instead of "bridge bug".
///
/// **Why a native test would not have caught it.** Handing the adapter a
/// `Stream<String>` built in Dart passes the guard. The failure only appears
/// when the stream comes from the interpreter, so every case below drives a
/// script-built literal end to end.
void main() {
  const String testLibPath = 'd4rt-mem:/converter_bind_stream_test.dart';

  Future<Object?> run(String scriptBody) async {
    final fullScript =
        '''
      import 'dart:convert';
      import 'dart:async';
      Future<Object?> main() async {
        $scriptBody
      }
    ''';
    return await D4rt().execute(
          library: testLibPath,
          name: 'main',
          sources: {testLibPath: fullScript},
        )
        as Object?;
  }

  group('Converter.bind over script-built streams (SCC68)', () {
    test('F-SCC68-1: utf8.encoder.bind consumes a script Stream<String>. '
        '[2026-09-06]', () async {
      final result = await run(r'''
        final chunks = await utf8.encoder
            .bind(Stream.fromIterable(['ab', 'cd']))
            .toList();
        return chunks.map((c) => c.toList()).toList();
      ''');
      expect(result, [
        [97, 98],
        [99, 100],
      ]);
    });

    test('F-SCC68-2: utf8.decoder.bind consumes a script Stream<List<int>>. '
        '[2026-09-06]', () async {
      final result = await run(r'''
        return await utf8.decoder
            .bind(Stream.fromIterable([[104, 101, 108], [108, 111]]))
            .join();
      ''');
      expect(result, 'hello');
    });

    test('F-SCC68-3: ascii.encoder.bind consumes a script Stream<String>. '
        '[2026-09-06]', () async {
      final result = await run(r'''
        final chunks = await ascii.encoder
            .bind(Stream.fromIterable(['hi']))
            .toList();
        return chunks.map((c) => c.toList()).toList();
      ''');
      expect(result, [
        [104, 105],
      ]);
    });

    test('F-SCC68-4: ascii.decoder.bind consumes a script Stream<List<int>>. '
        '[2026-09-06]', () async {
      final result = await run(r'''
        return await ascii.decoder
            .bind(Stream.fromIterable([[104, 105]]))
            .join();
      ''');
      expect(result, 'hi');
    });

    test('F-SCC68-5: latin1.encoder.bind consumes a script Stream<String>. '
        '[2026-09-06]', () async {
      final result = await run(r'''
        final chunks = await latin1.encoder
            .bind(Stream.fromIterable(['é']))
            .toList();
        return chunks.map((c) => c.toList()).toList();
      ''');
      expect(result, [
        [233],
      ]);
    });

    test('F-SCC68-6: latin1.decoder.bind consumes a script Stream<List<int>>. '
        '[2026-09-06]', () async {
      final result = await run(r'''
        return await latin1.decoder
            .bind(Stream.fromIterable([[233]]))
            .join();
      ''');
      expect(result, 'é');
    });

    test('F-SCC68-7: base64.encoder.bind consumes a script Stream<List<int>>. '
        '[2026-09-06]', () async {
      final result = await run(r'''
        return await base64.encoder
            .bind(Stream.fromIterable([[104, 101, 108, 108, 111]]))
            .join();
      ''');
      expect(result, 'aGVsbG8=');
    });

    test('F-SCC68-8: base64.decoder.bind consumes a script Stream<String>. '
        '[2026-09-06]', () async {
      final result = await run(r'''
        final chunks = await base64.decoder
            .bind(Stream.fromIterable(['aGVsbG8=']))
            .toList();
        return chunks.map((c) => c.toList()).toList();
      ''');
      expect(result, [
        [104, 101, 108, 108, 111],
      ]);
    });

    test('F-SCC68-9: LineSplitter().bind consumes a script Stream<String>. '
        '[2026-09-06]', () async {
      final result = await run(r'''
        return await const LineSplitter()
            .bind(Stream.fromIterable(['a\nb\n', 'c\n']))
            .toList();
      ''');
      expect(result, ['a', 'b', 'c']);
    });

    test('F-SCC68-10: htmlEscape.bind consumes a script Stream<String>. '
        '[2026-09-06]', () async {
      final result = await run(r'''
        return await htmlEscape
            .bind(Stream.fromIterable(['<a>']))
            .join();
      ''');
      expect(result, '&lt;a&gt;');
    });

    test('F-SCC68-11: json.decoder.bind consumes a script Stream<String>. '
        '[2026-09-06]', () async {
      final result = await run(r'''
        final values = await json.decoder
            .bind(Stream.fromIterable(['{"a":', '1}']))
            .toList();
        return values.map((v) => v['a']).toList();
      ''');
      expect(result, [1]);
    });

    test('F-SCC68-12: a genuinely wrong element type still fails, and the '
        'message names the offending type. [2026-09-06]', () async {
      await expectLater(
        run(r'''
        return await utf8.decoder
            .bind(Stream.fromIterable(['not-a-chunk']))
            .join();
      '''),
        throwsA(
          isA<Object>().having(
            (e) => e.toString(),
            'toString',
            allOf(contains('Utf8Decoder.bind'), contains('String')),
          ),
        ),
      );
    });
  });
}
