/// SCE217 — `Socket.pipe` accepts the consumers a script can actually hold.
///
/// The adapter guarded on the raw `StreamConsumer` and then cast to
/// `StreamConsumer<Uint8List>`. Dart generics are covariant, so the cast only
/// admits a consumer whose element type is a SUBTYPE of `Uint8List` — and no
/// consumer a script can build or obtain is one:
///
///   * `StreamController()` in a script is `StreamController<dynamic>` (type
///     arguments are erased);
///   * `File.openWrite()`, and another `Socket`, are `IOSink`s —
///     `StreamConsumer<List<int>>`.
///
/// So the guard passed and the next line threw a raw `_TypeError` for every
/// reachable call, including the canonical proxy (`client.pipe(upstream)`).
/// The inherited `Stream.pipe` adapter had the same defect one level up — its
/// typed `stream.pipe(consumer)` call runs the same covariant check — so the
/// `Socket` copy was deleted (SCC51's rule for a shadow) and `Stream.pipe`
/// now runs the SDK's own body through `D4.pipeStream`: `addStream`
/// dispatched on the consumer, then `close`. A socket inherits it.
@TestOn('vm')
library;

import 'package:test/test.dart';

import '../../interpreter_test.dart';

void main() {
  group('SCE217: Socket.pipe', () {
    test('F-SCE217-1: pipes into a script StreamController '
        '[2026-09-28] (PASS)', () async {
      final result = await executeAsync('''
        import 'dart:io';
        import 'dart:async';
        main() async {
          var server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
          var received = <int>[];
          var done = Completer();
          server.listen((socket) async {
            var sink = StreamController();
            sink.stream.listen((chunk) => received.addAll(chunk),
                onDone: () => done.complete());
            await socket.pipe(sink);
          });
          var client = await Socket.connect('127.0.0.1', server.port);
          client.add([1, 2, 3]);
          await client.close();
          await done.future;
          await server.close();
          return received;
        }
      ''');
      expect(result, [1, 2, 3]);
    });

    test('F-SCE217-2: pipes into another socket — the proxy shape, an IOSink '
        'is a StreamConsumer<List<int>> [2026-09-28] (PASS)', () async {
      final result = await executeAsync('''
        import 'dart:io';
        import 'dart:async';
        main() async {
          // An echo server: whatever arrives is piped straight back.
          var server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
          server.listen((socket) { socket.pipe(socket); });
          var client = await Socket.connect('127.0.0.1', server.port);
          var received = <int>[];
          var done = Completer();
          client.listen((chunk) => received.addAll(chunk),
              onDone: () => done.complete());
          client.add([7, 8, 9]);
          await client.flush();
          await Future.delayed(Duration(milliseconds: 50));
          await client.close();
          await done.future;
          await server.close();
          return received;
        }
      ''');
      expect(result, [7, 8, 9]);
    });

    test("F-SCE217-3: a non-consumer is refused by the adapter's own "
        'exception, not a cast error [2026-09-28] (PASS)', () async {
      await expectLater(
        executeAsync('''
          import 'dart:io';
          main() async {
            var server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
            var client = await Socket.connect('127.0.0.1', server.port);
            try {
              await client.pipe(42);
            } finally {
              client.destroy();
              await server.close();
            }
          }
        '''),
        throwsA(
          predicate(
            (Object? e) => e is! TypeError && '$e'.contains('StreamConsumer'),
            'the adapter naming StreamConsumer',
          ),
        ),
      );
    });
  });
}
