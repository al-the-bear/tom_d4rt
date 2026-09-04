import 'dart:convert';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart`
// — see the note in `stdlib_bytes_builder_test.dart`. Reaching for them by
// same-package path keeps the published API unchanged.
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/async.dart';

/// SCB23 mirror coverage for `tom_d4rt_ast` — the dart:convert supertype edges.
///
/// The script-level twin lives in
/// `tom_d4rt/test/stdlib/convert/convert_hierarchy_test.dart`. This file is
/// registration-level for the same reason as the SC5..SC8 and SCB21 mirrors:
/// `tom_d4rt_exec` is the only runner that could execute a script against
/// *this* tree, and it resolves `tom_d4rt_ast` from pub.dev rather than by
/// path, so it cannot see unpublished local edits.
///
/// Registration level is also the honest level for this particular change.
/// Supertype edges are not a runtime behaviour that only emerges under an
/// interpreter — they are entries in `BridgedClass`'s static registry, and
/// `isSubtypeOf` reads them directly. Asserting on the registry and on
/// `isSubtypeOf` measures exactly the thing SCB23 changed.
///
/// NOTE ON THE STATIC REGISTRY: `BridgedClass.registerSupertypes` writes to a
/// process-wide map with no reset hook, so these tests are order-independent by
/// construction (registration is idempotent and additive) but cannot assert
/// that an edge is ABSENT unless nothing in the process ever registers it. The
/// one negative pinned below — `LineSplitter` is not a `Converter` — is safe
/// precisely because no registrar anywhere declares that edge, which is the
/// property the test exists to protect.
void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    // dart:async first: `StreamTransformerBase -> StreamTransformer` is
    // declared there, and the convert leaves lean on it for their deepest hop.
    AsyncStdlib.register(env);
    ConvertStdlib.register(env);
    // Method adapters take a non-nullable visitor (only getters accept `null`).
    // `decodeStream` resolves no name and loads no module, so an empty loader
    // is enough.
    visitor = InterpreterVisitor(
      globalEnvironment: env,
      moduleContext: AstModuleLoader(
        modules: const {},
        globalEnvironment: env,
        runner: D4rtRunner(),
      ),
    );
  });

  BridgedClass bridge(String name) {
    final b = env.findBridgedClassByName(name);
    expect(b, isNotNull, reason: '$name must be a registered bridge');
    return b!;
  }

  /// What a script's `x is Supertype` ultimately asks.
  bool isSub(String sub, String superName, {Object? value}) =>
      bridge(sub).isSubtypeOf(bridge(superName), value: value);

  group('SCB23: the encodings reach Encoding and Codec', () {
    for (final name in const <String>[
      'Utf8Codec',
      'AsciiCodec',
      'Latin1Codec',
    ]) {
      test(
        'F-SCB23-AST-1-$name: $name is an Encoding and a Codec [2026-07-28]',
        () {
          expect(isSub(name, 'Encoding'), isTrue);
          expect(isSub(name, 'Codec'), isTrue);
        },
      );
    }

    test('F-SCB23-AST-2: Encoding is itself a Codec [2026-07-28]', () {
      // The edge the three above lean on for their second hop — and the reason
      // they must ALSO declare `Codec` directly; see F-SCB23-AST-7.
      expect(isSub('Encoding', 'Codec'), isTrue);
    });
  });

  group('SCB23: the non-encoding codecs reach Codec but not Encoding', () {
    test('F-SCB23-AST-3: JsonCodec and Base64Codec extend Codec directly '
        '[2026-07-28]', () {
      expect(isSub('JsonCodec', 'Codec'), isTrue);
      expect(isSub('Base64Codec', 'Codec'), isTrue);
      // The negative half. A blanket "codec-shaped means Encoding" edge set
      // would satisfy the positives and break here.
      expect(isSub('JsonCodec', 'Encoding'), isFalse);
      expect(isSub('Base64Codec', 'Encoding'), isFalse);
    });
  });

  group('SCB23: the converters reach Converter', () {
    const converters = <String>[
      'JsonEncoder',
      'JsonDecoder',
      'JsonUtf8Encoder',
      'Utf8Encoder',
      'Utf8Decoder',
      'AsciiEncoder',
      'AsciiDecoder',
      'Latin1Encoder',
      'Latin1Decoder',
      'Base64Encoder',
      'Base64Decoder',
      'HtmlEscape',
    ];

    for (final name in converters) {
      test('F-SCB23-AST-4-$name: $name is a Converter [2026-07-28]', () {
        expect(isSub(name, 'Converter'), isTrue);
      });
    }

    test('F-SCB23-AST-5: Converter reaches both stream-transformer roots '
        '[2026-07-28]', () {
      expect(isSub('Converter', 'StreamTransformerBase'), isTrue);
      expect(isSub('Converter', 'StreamTransformer'), isTrue);
    });
  });

  group('SCB23: LineSplitter is a StreamTransformer, not a Converter', () {
    test('F-SCB23-AST-6: the SDK puts it outside the Converter hierarchy '
        '[2026-07-28]', () {
      // `final class LineSplitter extends StreamTransformerBase<String,
      // String>`. SCB23's own description listed it among the classes needing
      // a `-> Converter` edge; that edge would turn a false `is` answer into a
      // confidently wrong `true`, which is worse than the gap it replaced.
      expect(isSub('LineSplitter', 'StreamTransformerBase'), isTrue);
      expect(isSub('LineSplitter', 'StreamTransformer'), isTrue);
      expect(isSub('LineSplitter', 'Converter'), isFalse);
    });
  });

  group('SCB23: the depth invariant', () {
    test('F-SCB23-AST-7: the type test and the member walk agree about depth '
        '[2026-07-28]', () {
      // These two assertions used to disagree, and that disagreement is what
      // every edge list in `ConvertHierarchyConvert` was flattened to hide:
      // `isSubtypeOf` consulted a class's direct supertypes and ONE further
      // hop while the member walk (`transitiveSupertypeNames`) was fully
      // transitive, so a minimal edge set gave correct MEMBER resolution and
      // wrong TYPE TESTS — the failure mode hardest to spot by reading the
      // registry. SCC19 pointed both at the same walk.
      expect(
        BridgedClass.transitiveSupertypeNames('JsonEncoder'),
        containsAll(<String>[
          'Converter',
          'StreamTransformerBase',
          'StreamTransformer',
        ]),
      );
      // Three declarations away, over single-hop edges.
      expect(isSub('JsonEncoder', 'StreamTransformer'), isTrue);
    });
  });

  group('SCB23: the decodeStream adapter', () {
    test('F-SCB23-AST-8: Encoding declares decodeStream [2026-07-28]', () {
      // The block's one real member loss. It lives on `Encoding` in the SDK and
      // on none of the three encodings, so before SCB23 no script could reach
      // it. Pinned on the bridge rather than through a script because the edge
      // (above) and the adapter (here) are what make it reachable together.
      expect(bridge('Encoding').methods.keys, contains('decodeStream'));
    });

    test('F-SCB23-AST-9: the encodings reach it through the supertype walk '
        '[2026-07-28]', () {
      // `Utf8Codec`'s own bridge does not declare it...
      expect(bridge('Utf8Codec').methods.keys, isNot(contains('decodeStream')));
      // ...so the edge is the only thing that makes `utf8.decodeStream` work.
      expect(
        BridgedClass.transitiveSupertypeNames('Utf8Codec'),
        contains('Encoding'),
      );
    });

    test(
      'F-SCB23-AST-10: the adapter decodes a byte stream [2026-07-28]',
      () async {
        final adapter = bridge('Encoding').methods['decodeStream']!;
        // A `Stream` of `List<Object?>` — which is what the interpreter actually
        // hands over, and the reason a plain `Stream.cast<List<int>>()` is not
        // enough: that casts the ELEMENT, and a `List<Object?>` is not a
        // `List<int>`.
        final chunks = <List<Object?>>[
          <Object?>[104, 101],
          <Object?>[108, 108, 111],
        ];
        final result = adapter(
          visitor,
          utf8,
          [Stream<List<Object?>>.fromIterable(chunks)],
          {},
          [],
        );
        expect(await (result as Future), equals('hello'));
      },
    );

    test('F-SCB23-AST-11: the adapter rejects a non-Stream argument '
        '[2026-07-28]', () {
      final adapter = bridge('Encoding').methods['decodeStream']!;
      expect(
        () => adapter(visitor, utf8, ['not a stream'], {}, []),
        throwsA(isA<RuntimeD4rtException>()),
      );
      expect(
        () => adapter(visitor, utf8, [], {}, []),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });
  });
}
