// SCE83/AST — `Stream.transform` meets the stream shape the interpreter makes.
//
// The behaviour twin is
// `tom_d4rt/test/stdlib/async/sce83_transform_element_coercion_test.dart`,
// which drives real scripts. This tree has no parser, so it asks the same
// question of the adapter directly — and that is the copy that matters for
// the strategic goal, because it is the tree a Flutter app ships.
//
// THE SHAPE UNDER TEST. A script's `Stream<List<int>>.fromIterable([[104,
// 105]])` is natively a `Stream<dynamic>` whose events are `List<Object?>`:
// the interpreter's values are dynamically typed and each bridge coerces at
// its own boundary. Handing that to `utf8.decoder` — a
// `StreamTransformer<List<int>, String>` — raised a host `_TypeError` naming
// an interpreter internal, which no script can catch and no script author can
// act on. The adapter now coerces the SOURCE element-wise, so both halves of
// the mismatch are repaired: the stream's type argument and its chunks'.
//
// The erased shapes are built by hand rather than by running a script, which
// is the only honest way to ask this here — `erasedChunks` is exactly what
// `InterpreterVisitor` produces for a list literal of ints.
//
// ABLATED by restoring `return (target as Stream).transform(streamTransformer)`:
// 2 of 5 go red, AST-1 and AST-3 — one per coercion branch. The three that do
// not are controls and must not: a typed stream, a transformer the interpreter
// already satisfies, and the argument diagnostic. The reference twin's split
// under the same ablation is 4 of 7.

import 'dart:async';
import 'dart:convert';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/async.dart';

void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    AsyncStdlib.register(env);
    visitor = InterpreterVisitor(
      globalEnvironment: env,
      moduleContext: AstModuleLoader(
        modules: const {},
        globalEnvironment: env,
        runner: D4rtRunner(),
      ),
    );
  });

  /// Invokes the `Stream` bridge's `transform` adapter the way the
  /// interpreter would, and collects what comes back.
  Future<List<Object?>> transform(Stream source, Object? transformer) async {
    final adapter = env.findBridgedClassByName('Stream')?.methods['transform'];
    expect(adapter, isNotNull, reason: 'Stream.transform must be registered');
    final out = adapter!(visitor, source, [transformer], {}, []);
    return await (out as Stream).toList();
  }

  /// The erased shape the interpreter produces for `[104, 105]`.
  Stream<dynamic> erasedChunks(List<int> bytes) =>
      Stream<dynamic>.fromIterable([
        <Object?>[...bytes],
      ]);

  group('SCE83/AST: a transformer meets a stream the interpreter made', () {
    test('F-SCE83-AST-1: a decoder reads the erased stream shape '
        '[2026-09-21] (PASS)', () {
      // The reproduction. Both the stream's type argument (`dynamic`) and its
      // chunk type (`List<Object?>`) are wrong for `utf8.decoder`, and a cast
      // repairs only the first — which is why the coercion is element-wise.
      expect(
        transform(erasedChunks([104, 105]), utf8.decoder),
        completion(['hi']),
      );
    });

    test('F-SCE83-AST-2: CONTROL — a genuinely typed stream is untouched '
        '[2026-09-21] (PASS)', () {
      // What a `dart:io` stream looks like here. It worked before the change
      // and must still: the first attempt at this fix cast the TRANSFORMER
      // instead, which repaired the case above and broke this one.
      expect(
        transform(
          Stream<List<int>>.fromIterable([
            [104, 105],
          ]),
          utf8.decoder,
        ),
        completion(['hi']),
      );
    });

    test('F-SCE83-AST-3: the String branch takes an erased String stream '
        '[2026-09-21] (PASS)', () {
      // `Utf8Encoder` is the reverse direction, `String` -> `List<int>`, and
      // is what proves the second branch is reachable rather than dead.
      expect(
        transform(Stream<dynamic>.fromIterable(['hi']), utf8.encoder),
        completion([
          [104, 105],
        ]),
      );
    });

    test('F-SCE83-AST-4: CONTROL — a transformer the interpreter can already '
        'satisfy goes through untouched [2026-09-21] (PASS)', () {
      // A script-defined transformer arrives as `StreamTransformer<dynamic,
      // dynamic>` through `StreamTransformer.fromBind`; its input type is one
      // the interpreter's own values already meet, so neither coercion branch
      // may claim it. A branch that did would re-type every event a script
      // transformer sees.
      final doubler = StreamTransformer<dynamic, dynamic>.fromBind(
        (source) => source.map((v) => (v as int) * 2),
      );
      expect(
        transform(Stream<dynamic>.fromIterable([1, 2, 3]), doubler),
        completion([2, 4, 6]),
      );
    });

    test('F-SCE83-AST-5: CONTROL — a non-transformer is still refused by the '
        'bridge [2026-09-21] (PASS)', () {
      // The defect being fixed was a host error reaching a script, so the
      // adapter's own diagnostic must survive the change as a
      // RuntimeD4rtException rather than becoming another cast failure.
      expect(
        () => transform(Stream<dynamic>.fromIterable([1]), 42),
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
