/// SCE217 — `D4.pipeStream` pipes into the consumers a script holds.
///
/// `Stream<X>.pipe(StreamConsumer<X>)` is a typed call, and generics are
/// covariant, so a script's `StreamController<dynamic>` or an `IOSink`
/// (`StreamConsumer<List<int>>`) failed it for a `Stream<Uint8List>`.
/// `D4.pipeStream` runs the SDK's own `pipe` body with the consumer's
/// `addStream` dispatched dynamically. The script-level cases (a real socket
/// piped into a controller and into itself) are in `tom_d4rt`'s
/// `stdlib/io/sce217_socket_pipe_test.dart`; this package has no parser.
library;

import 'dart:async';
import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

Stream<Uint8List> _bytes() => Stream<Uint8List>.fromIterable([
  Uint8List.fromList([1, 2]),
  Uint8List.fromList([3]),
]);

void main() {
  group('SCE217: D4.pipeStream', () {
    test('F-SCE217-4: a dynamic consumer receives the typed stream and is '
        'closed [2026-09-28] (PASS)', () async {
      final inner = StreamController<dynamic>();
      final received = inner.stream.toList();
      expect(inner, isNot(isA<StreamConsumer<Uint8List>>()));
      expect(
        () => _bytes().pipe(inner as dynamic),
        throwsA(isA<TypeError>()),
        reason: 'precondition: the typed SDK call rejects this consumer',
      );
      await D4.pipeStream(_bytes(), inner, 'Stream.pipe');
      expect(
        await received,
        [
          [1, 2],
          [3],
        ],
        reason: 'received every chunk, and toList completed: it was closed',
      );
    });

    test('F-SCE217-5: a List<int> consumer (the IOSink shape) receives it '
        'too [2026-09-28] (PASS)', () async {
      final inner = StreamController<List<int>>();
      final received = inner.stream.toList();
      expect(inner, isNot(isA<StreamConsumer<Uint8List>>()));
      await D4.pipeStream(_bytes(), inner, 'Stream.pipe');
      expect(await received, hasLength(2));
    });

    test('F-SCE217-6: a non-consumer is refused with the member message, and '
        'an unrelated element type still fails [2026-09-28] (PASS)', () async {
      expect(
        () => D4.pipeStream(_bytes(), 42, 'Stream.pipe'),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains('Stream.pipe requires a StreamConsumer argument.'),
          ),
        ),
      );
      final wrong = StreamController<String>();
      expect(
        () => D4.pipeStream(_bytes(), wrong, 'Stream.pipe'),
        throwsA(isA<TypeError>()),
        reason: 'this widens nothing: a String consumer cannot take bytes',
      );
      // Not awaited: close() completes only once a listener sees done.
      unawaited(wrong.close());
    });
  });
}
