/// SCE160 — which bridge claims each SDK StreamTransformer implementation.
///
/// Found by the pre-publish pass: `StreamTransformer.fromHandlers(...)`
/// returns a `_StreamHandlerTransformer`, and that name was listed on the
/// STREAM bridge's `nativeNames`. The analyzer-free line resolves a bare
/// native by its runtime name alone, so `t.cast<int, int>()` dispatched to
/// `Stream.cast` and failed with `is not a subtype of type 'Stream<dynamic>'`.
/// The reference line escaped through static types, which is why its suite
/// never saw it. The other three factories' types had no bridge at all.
///
/// Measured against the SDK, not assumed: none of the four types is a Stream.
library;

import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/src/stdlib/async/stream.dart';

void main() {
  final env = Environment()
    ..defineBridge(StreamAsync.definition, sourceUri: 'dart:async')
    ..defineBridge(StreamTransformerAsync.definition, sourceUri: 'dart:async');

  final transformers = <String, StreamTransformer<int, int>>{
    'fromHandlers': StreamTransformer<int, int>.fromHandlers(
      handleData: (d, s) => s.add(d),
    ),
    'unnamed': StreamTransformer<int, int>((s, c) => s.listen(null)),
    'fromBind': StreamTransformer<int, int>.fromBind((s) => s),
    'cast': StreamTransformer<int, int>.fromHandlers().cast<int, int>(),
  };

  group(
    'SCE160: StreamTransformer implementations resolve to their bridge',
    () {
      for (final entry in transformers.entries) {
        test('F-SCE160-${entry.key}: ${entry.value.runtimeType} is claimed by '
            'StreamTransformer [2026-09-25]', () {
          expect(
            entry.value,
            isNot(isA<Stream<Object?>>()),
            reason: 'the premise: it is not a Stream',
          );
          expect(
            env.toBridgedClass(entry.value.runtimeType).name,
            'StreamTransformer',
          );
        });
      }

      test('F-SCE160-control: a real stream still resolves to Stream '
          '[2026-09-25]', () {
        final stream = Stream<int>.fromIterable(const [1]);
        expect(env.toBridgedClass(stream.runtimeType).name, 'Stream');
      });
    },
  );
}
