import 'dart:convert';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// The stdlib registrars are deliberately not re-exported from `runtime.dart`
// — see the note in `stdlib_bytes_builder_test.dart`. Reaching for them by
// same-package path keeps the published API unchanged.
import 'package:tom_d4rt_ast/src/runtime/stdlib/convert.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/async.dart';

/// SCC68 mirror coverage for `tom_d4rt_ast` — stream arguments survive the
/// interpreter's type-argument erasure.
///
/// The script-level twin lives in
/// `tom_d4rt/test/stdlib/convert/converter_bind_stream_test.dart`. This file is
/// registration-level for the DGUC6 reason: `tom_d4rt_exec` is the only runner
/// that could execute a script against *this* tree, and it resolves
/// `tom_d4rt_ast` from pub.dev rather than by path, so it cannot see
/// unpublished local edits. Invoking the adapter lambda directly is the only
/// way to measure this tree's behaviour today.
///
/// The level is also honest for what changed. The bug was entirely in the
/// adapter's argument handling: a container-typed guard
/// (`positionalArgs[0] is! Stream<String>`) followed by a container-typed cast.
/// Handing the lambda the erased shape the interpreter actually produces —
/// `Stream<Object?>`, and `Stream<List<Object?>>` for byte chunks — reproduces
/// the failure exactly, without needing a script to build it.
void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    // dart:async first: the convert bridges lean on its stream types.
    AsyncStdlib.register(env);
    ConvertStdlib.register(env);
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

  /// Invoke a `bind` adapter the way the interpreter would.
  Object? bind(String bridgeName, Object target, Object? stream) =>
      bridge(bridgeName).methods['bind']!(visitor, target, [stream], {}, []);

  /// What a script's `Stream.fromIterable([...])` actually evaluates to: the
  /// element type is erased to the top type.
  Stream<Object?> erased(List<Object?> elements) =>
      Stream<Object?>.fromIterable(elements);

  /// What a script's stream of byte chunks evaluates to: erased twice over —
  /// the stream element AND the list element. This is why
  /// `Stream.cast<List<int>>()` is not enough; `cast` converts the ELEMENT, and
  /// a `List<Object?>` is not a `List<int>`.
  Stream<Object?> erasedChunks(List<List<Object?>> chunks) =>
      Stream<Object?>.fromIterable(chunks);

  group('SCC68: convert bind adapters accept erased streams', () {
    test('F-SCC68-AST-1: Utf8Encoder.bind takes a Stream<Object?> of strings '
        '[2026-09-06]', () async {
      final out =
          await (bind('Utf8Encoder', const Utf8Encoder(), erased(['ab', 'cd']))
                  as Stream)
              .toList();
      expect(
        out.map((c) => (c as List).toList()).toList(),
        equals([
          [97, 98],
          [99, 100],
        ]),
      );
    });

    test('F-SCC68-AST-2: Utf8Decoder.bind takes erased byte chunks '
        '[2026-09-06]', () async {
      final out =
          await (bind(
                    'Utf8Decoder',
                    const Utf8Decoder(),
                    erasedChunks([
                      <Object?>[104, 101, 108],
                      <Object?>[108, 111],
                    ]),
                  )
                  as Stream)
              .join();
      expect(out, equals('hello'));
    });

    test('F-SCC68-AST-3: AsciiEncoder.bind takes a Stream<Object?> of strings '
        '[2026-09-06]', () async {
      final out =
          await (bind('AsciiEncoder', const AsciiEncoder(), erased(['hi']))
                  as Stream)
              .toList();
      expect(
        out.map((c) => (c as List).toList()).toList(),
        equals([
          [104, 105],
        ]),
      );
    });

    test('F-SCC68-AST-4: AsciiDecoder.bind takes erased byte chunks '
        '[2026-09-06]', () async {
      final out =
          await (bind(
                    'AsciiDecoder',
                    const AsciiDecoder(),
                    erasedChunks([
                      <Object?>[104, 105],
                    ]),
                  )
                  as Stream)
              .join();
      expect(out, equals('hi'));
    });

    test('F-SCC68-AST-5: Latin1Encoder.bind takes a Stream<Object?> of strings '
        '[2026-09-06]', () async {
      final out =
          await (bind('Latin1Encoder', const Latin1Encoder(), erased(['é']))
                  as Stream)
              .toList();
      expect(
        out.map((c) => (c as List).toList()).toList(),
        equals([
          [233],
        ]),
      );
    });

    test('F-SCC68-AST-6: Latin1Decoder.bind takes erased byte chunks '
        '[2026-09-06]', () async {
      final out =
          await (bind(
                    'Latin1Decoder',
                    const Latin1Decoder(),
                    erasedChunks([
                      <Object?>[233],
                    ]),
                  )
                  as Stream)
              .join();
      expect(out, equals('é'));
    });

    test('F-SCC68-AST-7: Base64Encoder.bind takes erased byte chunks '
        '[2026-09-06]', () async {
      final out =
          await (bind(
                    'Base64Encoder',
                    const Base64Encoder(),
                    erasedChunks([
                      <Object?>[104, 101, 108, 108, 111],
                    ]),
                  )
                  as Stream)
              .join();
      expect(out, equals('aGVsbG8='));
    });

    test('F-SCC68-AST-8: Base64Decoder.bind takes a Stream<Object?> of strings '
        '[2026-09-06]', () async {
      final out =
          await (bind(
                    'Base64Decoder',
                    const Base64Decoder(),
                    erased(['aGVsbG8=']),
                  )
                  as Stream)
              .toList();
      expect(
        out.map((c) => (c as List).toList()).toList(),
        equals([
          [104, 101, 108, 108, 111],
        ]),
      );
    });

    test('F-SCC68-AST-9: LineSplitter.bind takes a Stream<Object?> of strings '
        '[2026-09-06]', () async {
      final out =
          await (bind(
                    'LineSplitter',
                    const LineSplitter(),
                    erased(['a\nb\n', 'c\n']),
                  )
                  as Stream)
              .toList();
      expect(out, equals(['a', 'b', 'c']));
    });

    test('F-SCC68-AST-10: HtmlEscape.bind takes a Stream<Object?> of strings '
        '[2026-09-06]', () async {
      final out =
          await (bind('HtmlEscape', htmlEscape, erased(['<a>'])) as Stream)
              .join();
      expect(out, equals('&lt;a&gt;'));
    });

    test('F-SCC68-AST-11: JsonDecoder.bind takes a Stream<Object?> of strings '
        '[2026-09-06]', () async {
      final out =
          await (bind(
                    'JsonDecoder',
                    const JsonDecoder(),
                    erased(['{"a":', '1}']),
                  )
                  as Stream)
              .toList();
      expect(out.map((v) => (v as Map)['a']).toList(), equals([1]));
    });

    test('F-SCC68-AST-12: JsonEncoder.bind takes a Stream<Object?> of values '
        '[2026-09-06]', () async {
      final out =
          await (bind(
                    'JsonEncoder',
                    const JsonEncoder(),
                    erased([
                      {'a': 1},
                    ]),
                  )
                  as Stream)
              .join();
      expect(out, equals('{"a":1}'));
    });
  });

  group('SCC68: the guard keeps its exception type and names the bad type', () {
    // The guard survives the fix on purpose. `D4.coerce*` throws
    // `ArgumentD4rtException`; every stdlib adapter throws
    // `RuntimeD4rtException`. Those are SIBLINGS under `D4rtException`, not
    // parent and child, so routing the whole check through the helper would
    // silently change what a script's `catch` dispatches on. The guard only
    // narrowed from `Stream<T>` — which the interpreter can never satisfy — to
    // a raw `Stream`.
    test('F-SCC68-AST-13: a non-Stream argument still throws '
        'RuntimeD4rtException [2026-09-06]', () {
      expect(
        () => bind('Utf8Decoder', const Utf8Decoder(), 'not a stream'),
        throwsA(isA<RuntimeD4rtException>()),
      );
      expect(
        () => bridge('Utf8Decoder').methods['bind']!(
          visitor,
          const Utf8Decoder(),
          [],
          {},
          [],
        ),
        throwsA(isA<RuntimeD4rtException>()),
      );
    });

    test('F-SCC68-AST-14: a wrong ELEMENT type fails per element and names the '
        'offending type [2026-09-06]', () {
      // A `Stream` passes the guard, so the failure now comes from the
      // coercion — which reports the parameter and the type it actually saw
      // rather than the guard's flat "wrong argument".
      expect(
        (bind('Utf8Decoder', const Utf8Decoder(), erased(['not-a-chunk']))
                as Stream)
            .join(),
        throwsA(
          isA<ArgumentD4rtException>().having(
            (e) => e.toString(),
            'toString',
            allOf(contains('Utf8Decoder.bind'), contains('String')),
          ),
        ),
      );
    });
  });

  group('SCC68: the D4 stream coercion helpers', () {
    test('F-SCC68-AST-15: coerceStream converts element by element '
        '[2026-09-06]', () async {
      final out = await D4
          .coerceStream<String>(erased(['a', 'b']), 'test')
          .toList();
      expect(out, equals(['a', 'b']));
    });

    test('F-SCC68-AST-16: coerceStream passes an already-typed stream through '
        'untouched [2026-09-06]', () {
      final typed = Stream<String>.fromIterable(['a']);
      expect(identical(D4.coerceStream<String>(typed, 'test'), typed), isTrue);
    });

    test('F-SCC68-AST-17: coerceByteStream converts the chunk, not just the '
        'element [2026-09-06]', () async {
      final out = await D4
          .coerceByteStream(
            erasedChunks([
              <Object?>[1, 2],
              <Object?>[3],
            ]),
            'test',
          )
          .toList();
      expect(
        out,
        equals([
          [1, 2],
          [3],
        ]),
      );
      // The point of the helper: the chunks come back as real `List<int>`, so
      // a native API that demands one does not reject them.
      expect(out.first, isA<List<int>>());
    });

    test('F-SCC68-AST-18: the helpers reject a non-Stream with '
        'ArgumentD4rtException [2026-09-06]', () {
      expect(
        () => D4.coerceStream<String>('nope', 'test'),
        throwsA(isA<ArgumentD4rtException>()),
      );
      expect(
        () => D4.coerceByteStream('nope', 'test'),
        throwsA(isA<ArgumentD4rtException>()),
      );
    });
  });
}
