import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// SCB23 — supertype edges for the codec/converter half of `dart:convert`.
///
/// SC9 created `ConvertHierarchyConvert` for the SINK half of the library
/// (`ChunkedConversionSink` and friends). The half scripts actually touch —
/// codecs, encodings and converters — had no edges at all, so every `is`
/// answer over it was silently `false`: `utf8 is Codec`, `utf8 is Encoding`,
/// `JsonEncoder() is Converter`, `LineSplitter() is StreamTransformer`.
///
/// Two things make this block worth more than the usual cosmetic type-test
/// repair, and both are pinned below.
///
/// **`decodeStream` was genuinely missing.** It is declared on `Encoding` and
/// on none of the three encodings, so `utf8.decodeStream(...)` threw
/// `Undefined property or method`. The edge alone does not fix that — the
/// `Encoding` bridge did not declare `decodeStream` either — so SCB23 adds the
/// adapter as well. This is the one real member loss in the block; every other
/// inherited member was already declared explicitly on each leaf bridge.
///
/// **`LineSplitter` is NOT a `Converter`.** The SDK declares
/// `final class LineSplitter extends StreamTransformerBase<String, String>`.
/// SCB23's own text listed it among the classes needing a `-> Converter` edge;
/// that would have been a wrong edge making a false `is` answer *true*, which
/// is worse than the gap it replaced. The mechanical `--hierarchy` audit had it
/// right and the hand-written list did not, so `F-SCB23-9` pins the negative.
///
/// EDGES ARE DECLARED ONE PER SDK RELATIONSHIP. They used to be written out as
/// full closures, and that was load-bearing rather than stylistic:
/// `BridgedClass.isSubtypeOf` consulted the registry for the direct supertypes
/// and ONE further hop, so `JsonEncoder -> Converter -> StreamTransformerBase
/// -> StreamTransformer` answered `false` at three hops unless the closure was
/// restated. SCC19 pointed that predicate at the same transitive walk the
/// MEMBER lookup had always used, which removed the asymmetry and with it the
/// need to flatten. `F-SCB23-13` was written to fail the moment someone
/// un-flattened the block; it now passes on single-hop edges, which is what
/// makes it evidence for the walk rather than for the flattening.
void main() {
  const String testLibPath = 'd4rt-mem:/convert_hierarchy_test.dart';

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

  group('SCB23: the encodings reach Encoding and Codec', () {
    // The three top-level instances are what scripts hold, so they are probed
    // as instances rather than through a constructor.
    for (final name in const <String>['utf8', 'ascii', 'latin1']) {
      test('F-SCB23-1-$name: $name is an Encoding and a Codec [2026-07-28]',
          () {
        expect(run('return [$name is Encoding, $name is Codec];'),
            equals([true, true]));
      });
    }

    test('F-SCB23-2: the encoding classes carry the same edges [2026-07-28]',
        () {
      // Constructed rather than top-level, because the edge is on the class
      // and a future change could plausibly reach only the singleton path.
      expect(
        run('return [Utf8Codec() is Encoding, AsciiCodec() is Codec, '
            'Latin1Codec() is Encoding];'),
        equals([true, true, true]),
      );
    });
  });

  group('SCB23: the non-encoding codecs reach Codec', () {
    test('F-SCB23-3: json and base64 are Codecs but not Encodings '
        '[2026-07-28]', () {
      // `JsonCodec extends Codec<Object?, String>` and
      // `Base64Codec extends Codec<List<int>, String>` — neither goes through
      // `Encoding`, so the negative half is as much of an assertion as the
      // positive one. A blanket "everything codec-shaped is an Encoding" edge
      // set would pass the first list and fail this one.
      expect(
        run('return [json is Codec, base64 is Codec, base64Url is Codec, '
            'json is Encoding, base64 is Encoding];'),
        equals([true, true, true, false, false]),
      );
    });

    test('F-SCB23-4: Encoding is itself a Codec [2026-07-28]', () {
      // The edge the three encodings lean on for their second hop.
      expect(run(r'''
        var e = Encoding.getByName('utf-8');
        return [e is Codec, e is Encoding];
      '''), equals([true, true]));
    });
  });

  group('SCB23: the converters reach Converter', () {
    const converters = <String>[
      'JsonEncoder()',
      'JsonDecoder()',
      'JsonUtf8Encoder()',
      'Utf8Encoder()',
      'Utf8Decoder()',
      'AsciiEncoder()',
      'AsciiDecoder()',
      'Latin1Encoder()',
      'Latin1Decoder()',
      'Base64Encoder()',
      'Base64Decoder()',
      'HtmlEscape()',
    ];

    for (final ctor in converters) {
      test('F-SCB23-5-${ctor.replaceAll('()', '')}: $ctor is a Converter '
          '[2026-07-28]', () {
        expect(run('return $ctor is Converter;'), isTrue);
      });
    }

    test('F-SCB23-6: the encoder/decoder getters hand back Converters '
        '[2026-07-28]', () {
      // The route a script actually takes. `utf8.decoder` returns a
      // `Utf8Decoder`, and until the edges existed the value it produced
      // answered `false` to the type its own getter is declared to return.
      expect(
        run('return [utf8.decoder is Converter, utf8.encoder is Converter, '
            'json.encoder is Converter, base64.decoder is Converter];'),
        equals([true, true, true, true]),
      );
    });
  });

  group('SCB23: Converter reaches the stream-transformer roots', () {
    test('F-SCB23-7: Converter is a StreamTransformerBase and a '
        'StreamTransformer [2026-07-28]', () {
      // `abstract mixin class Converter<S, T> implements
      // StreamTransformerBase<S, T>`, and `StreamTransformerBase` implements
      // `StreamTransformer` (edge already registered by dart:async).
      expect(
        run('var c = utf8.decoder; '
            'return [c is StreamTransformerBase, c is StreamTransformer];'),
        equals([true, true]),
      );
    });

    test('F-SCB23-8: LineSplitter is a StreamTransformer [2026-07-28]', () {
      expect(
        run('var s = LineSplitter(); '
            'return [s is StreamTransformerBase, s is StreamTransformer];'),
        equals([true, true]),
      );
    });

    test('F-SCB23-9: LineSplitter is NOT a Converter [2026-07-28]', () {
      // The SDK declares `LineSplitter extends StreamTransformerBase<String,
      // String>` — it is not in the Converter hierarchy at all. SCB23's
      // description listed it among the classes needing a `-> Converter` edge;
      // this pins the correction so the wrong edge cannot be added later in
      // good faith.
      expect(run('return LineSplitter() is Converter;'), isFalse);
    });
  });

  group('SCB23: decodeStream, the one real member loss', () {
    test('F-SCB23-10: utf8.decodeStream decodes a byte stream [2026-07-28]',
        () {
      // Declared on `Encoding` and on none of the three encodings, so before
      // SCB23 this threw `Undefined property or method`. Needs BOTH halves of
      // the fix: the `Utf8Codec -> Encoding` edge to reach the adapter, and
      // the adapter itself, which the `Encoding` bridge did not declare.
      expect(run(r'''
        var s = Stream<List<int>>.fromIterable([
          [104, 101], [108, 108, 111]
        ]);
        return utf8.decodeStream(s);
      '''), completion(equals('hello')));
    });

    test('F-SCB23-11: latin1 and ascii inherit it too [2026-07-28]', () {
      expect(run(r'''
        var a = ascii.decodeStream(Stream<List<int>>.fromIterable([[104, 105]]));
        var l = latin1.decodeStream(Stream<List<int>>.fromIterable([[104, 105]]));
        return Future.wait([a, l]);
      '''), completion(equals(['hi', 'hi'])));
    });

    test('F-SCB23-12: decodeStream rejects a non-Stream argument '
        '[2026-07-28]', () {
      expect(
        () => run("return utf8.decodeStream('not a stream');"),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });
  });

  group('SCB23: the depth invariant', () {
    test('F-SCB23-13: a leaf converter reaches StreamTransformer three '
        'declarations away [2026-07-28]', () {
      // `JsonEncoder -> Converter -> StreamTransformerBase ->
      // StreamTransformer` is three hops. This case was written when
      // `isSubtypeOf` consulted only two, so it passed on the flattened edge
      // lists and was the first thing to fail if anyone tidied the block into
      // minimal form. SCC19 made the predicate transitive and the block was
      // tidied; the case still passes, which is the whole point of leaving it
      // here — it now measures the walk instead of the workaround.
      expect(run('return JsonEncoder() is StreamTransformer;'), isTrue);
    });
  });

  group('SCB23: the members the new edges must not disturb', () {
    test('F-SCB23-14: leaf members still win over the inherited ones '
        '[2026-07-28]', () {
      // Every one of these is declared on the leaf bridge AND now reachable on
      // `Codec`/`Converter` through the supertype walk. The walk only fires
      // when the leaf has no such member, so the leaf must keep answering.
      expect(run(r'''
        return [
          utf8.encode('ab').length,
          utf8.decode([104, 105]),
          JsonEncoder().convert({'a': 1}),
          base64.encode([1, 2, 3]),
          LineSplitter().convert('a\nb').length,
        ];
      '''), equals([2, 'hi', '{"a":1}', 'AQID', 2]));
    });

    test('F-SCB23-15: fuse still resolves on both halves [2026-07-28]', () {
      expect(run(r'''
        var fused = utf8.fuse(base64);
        return fused.encode('hi');
      '''), equals('aGk='));
    });
  });
}
