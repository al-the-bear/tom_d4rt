// `stream.transform(utf8.decoder)` on a stream the SCRIPT made.
//
// SCD187 deleted the `HttpClientResponse.transform` stub, so the idiomatic
// body read works — measured, and pinned by
// `test/stdlib/io/scd187_http_response_transform_test.dart`. That fixed the
// case where the stream comes from `dart:io` and is therefore genuinely a
// `Stream<List<int>>`. It did not fix the other half, because nothing had
// asked it:
//
//     final s = Stream<List<int>>.fromIterable([[104, 105]]);
//     await s.transform(utf8.decoder).join();
//
// reported `type '_MultiStream<dynamic>' is not a subtype of type
// 'Stream<List<int>>' of 'stream'` — a host `_TypeError` naming an
// interpreter internal, which is not catchable as a `RuntimeD4rtException`
// and tells a script author nothing to do.
//
// THE CAUSE IS THE INTERPRETER'S VALUE MODEL, not this member. A script's
// values are dynamically typed natively: `Stream<List<int>>.fromIterable` is
// a `_MultiStream<dynamic>` carrying `List<Object?>` chunks, and every bridge
// coerces at its own boundary instead. `utf8.decoder.bind(s)` WORKED on the
// same stream throughout — `Utf8Decoder.bind` coerces with
// `D4.coerceByteStream` — so Dart's two spellings for one operation disagreed,
// and the one every tutorial uses was the broken one.
//
// WHY THE FIX COERCES THE SOURCE RATHER THAN CASTING THE TRANSFORMER. The two
// `Socket.transform` adapters pass `transformer.cast()`, and that was the
// first thing tried here. It fixes the script-made stream and BREAKS the
// dart:io one: `File.openRead()` then rejects the
// `CastConverter<List<int>, String, dynamic, dynamic>` it is handed, because
// `Stream<List<int>>.transform` wants a transformer whose input really is
// `List<int>`. Both directions were measured before the second attempt was
// written. Under it, 3 of 7 go red: F-SCE83-5 is the control it inverts, and
// F-SCE83-1 and -2 fail too — a cast cannot repair a `List<Object?>` chunk,
// which is the second half of why the coercion has to be element-wise.
//
// The socket adapters are right for themselves — they know their element type
// statically (`Stream<Uint8List>`) — which is why this is a fix to
// `Stream.transform` and not a sweep.
//
// ABLATED by restoring `return (target as Stream).transform(streamTransformer)`:
// 4 of 7 go red. The survivors are F-SCE83-5 (the dart:io control, which must
// be indifferent to this change or it is not a control), F-SCE83-6 (a script
// transformer, whose input type a script's values already satisfy) and
// F-SCE83-7 (the argument diagnostic).

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Future<Object?> _run(String body) async {
  const path = 'd4rt-mem:/sce83_transform_element_coercion.dart';
  final d4rt = D4rt();
  d4rt.grant(FilesystemPermission.any);
  final result = d4rt.execute(
    library: path,
    name: 'main',
    sources: {
      path:
          "import 'dart:async';\n"
          "import 'dart:convert';\n"
          "import 'dart:io';\n"
          'class Doubler implements StreamTransformer<int, int> {\n'
          '  Stream<int> bind(Stream<int> source) => source.map((v) => v * 2);\n'
          '}\n'
          'Future<Object?> main() async {\n'
          '$body\n'
          '}\n',
    },
  );
  return await result;
}

void main() {
  group('SCE83: a transformer meets a stream the script made', () {
    test('F-SCE83-1: a decoder reads a script-built byte stream '
        '[2026-09-21] (PASS)', () {
      // The reproduction. `[[104, 105]]` is a script list literal, so the
      // chunk is a `List<Object?>` holding ints — which is why a per-element
      // coercion is needed and a `cast<List<int>>()` is not enough.
      expect(
        _run(
          'final s = Stream<List<int>>.fromIterable([[104, 105]]);\n'
          'return await s.transform(utf8.decoder).join();',
        ),
        completion('hi'),
      );
    });

    test('F-SCE83-2: the same stream through a StreamController '
        '[2026-09-21] (PASS)', () {
      // The other way a script obtains a stream, and it failed identically —
      // `_ControllerStream<dynamic>`. Two sources, one cause.
      expect(
        _run(
          'final c = StreamController<List<int>>();\n'
          'c.add([104, 105]);\n'
          'c.close();\n'
          'return await c.stream.transform(utf8.decoder).join();',
        ),
        completion('hi'),
      );
    });

    test('F-SCE83-3: transformers chain, so the coerced stream is a real one '
        '[2026-09-21] (PASS)', () {
      // A decoder's output feeding a `Stream<String>` transformer. This is
      // the case that proves the second branch of the coercion is reached:
      // `LineSplitter` takes `String`, and the stream it is handed came out
      // of the first transform rather than from the script.
      expect(
        _run(
          'final s = Stream<List<int>>.fromIterable([utf8.encode("a\\nb")]);\n'
          'return await s\n'
          '    .transform(utf8.decoder)\n'
          '    .transform(const LineSplitter())\n'
          '    .join("|");',
        ),
        completion('a|b'),
      );
    });

    test('F-SCE83-4: an encoder takes a script-built String stream '
        '[2026-09-21] (PASS)', () {
      // The reverse direction — `Utf8Encoder` is `String` -> `List<int>`, so
      // it exercises the `String` branch on a stream the script made rather
      // than on a transform result.
      expect(
        _run(
          'final s = Stream<String>.fromIterable(["hi"]);\n'
          'final out = await s.transform(utf8.encoder).toList();\n'
          'return out.first.length;',
        ),
        completion(2),
      );
    });

    test('F-SCE83-5: CONTROL — a dart:io stream is untouched '
        '[2026-09-21] (PASS)', () async {
      // The control, and the case that rejected the first attempt at the fix.
      // `File.openRead()` really is a `Stream<List<int>>`, so it worked before
      // this change and must still: a fix for the dynamic case that breaks the
      // typed one has moved the defect rather than closed it.
      final self =
          'test/stdlib/async/'
          'sce83_transform_element_coercion_test.dart';
      expect(
        await _run(
          "return await File('$self')\n"
          '    .openRead()\n'
          '    .transform(utf8.decoder)\n'
          '    .join()\n'
          "    .then((s) => s.contains('F-SCE83-5'));",
        ),
        isTrue,
      );
    });

    test('F-SCE83-6: CONTROL — a script-defined transformer still binds '
        '[2026-09-21] (PASS)', () {
      // The decision behind this todo asked whether script-defined
      // transformers work; they do, through `StreamTransformer.fromBind` in
      // `_asStreamTransformer`, and they must keep working. Their input type
      // is `dynamic`, so neither coercion branch claims them — which is the
      // behaviour this case pins, not merely that they run.
      expect(
        _run(
          'final s = Stream<int>.fromIterable([1, 2, 3]);\n'
          'return await s.transform(Doubler()).join(",");',
        ),
        completion('2,4,6'),
      );
    });

    test('F-SCE83-7: CONTROL — a non-transformer is still refused by the '
        'bridge [2026-09-21] (PASS)', () {
      // The diagnostic must stay a `RuntimeD4rtException` with the message
      // naming the parameter. The defect this file fixes was precisely a host
      // `_TypeError` reaching a script, so a fix that swallowed the argument
      // check would be the same failure wearing the opposite clothes.
      expect(
        _run(
          'final s = Stream<int>.fromIterable([1]);\n'
          'return await s.transform(42).join();',
        ),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'message',
            contains('Stream.transform requires a StreamTransformer'),
          ),
        ),
      );
    });
  });
}
