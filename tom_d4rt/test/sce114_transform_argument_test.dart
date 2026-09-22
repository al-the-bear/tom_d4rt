// SCE114 — every `transform` adapter resolves its argument the same way.
//
// THE TODO'S TWO NAMED HALVES WERE ALREADY CLOSED when this was measured, by
// work that did not know it was closing them: SCE83 gave `Stream.transform`
// the `_bindTransformer` coercion, and SCD187 deleted the
// `HttpClientResponse.transform` stub. F-SCE114-6 pins both, because the
// capability the todo is about — `response.transform(utf8.decoder)`, the line
// every Dart HTTP example contains — had no test of its own in either tree.
//
// WHAT WAS STILL OPEN is what the todo's notes asked for and nobody had done:
// "CHECK THE OTHER `transform` ADAPTERS, because there are four and I have
// measured two." The two socket adapters wrote
//
//     final separator = positionalArgs[0] as StreamTransformer;
//
// where `Stream.transform` resolved through a helper. A cast admits a native
// transformer and a bridged one, and rejects the third shape — an
// `InterpretedInstance` of a script class with a `bind` method, which is the
// case `StreamTransformerBase` exists to enable. So the SAME script class
// worked on a stream and failed on a socket, and the failure was a host
// `_TypeError` naming `InterpretedInstance`, a type the script author cannot
// see, let alone act on.
//
// THE FIX MOVES THE RESOLVER, it does not add a second one:
// `_asStreamTransformer` left `async/stream.dart` for
// `stdlib/stream_transformer_arg.dart`, beside `run_action.dart` and
// `stream_listen.dart` which were extracted from the same kind of duplication.
// All four adapters now ask one function.
//
// THE `.cast()` IN THE SOCKET ADAPTERS STAYS, and that is not an oversight.
// SCE83's `_bindTransformer` coerces the SOURCE instead, and its own doc says
// why the two sites differ: a socket's element type (`Uint8List`) is known
// statically so the cast is computed against it, while a bare `Stream` would
// have the cast inverted on it — a genuinely typed stream then rejects the
// `CastConverter` it is handed. Only the ARGUMENT resolution was shared.
//
// ABLATED 2026-09-22 by restoring both `as StreamTransformer` casts: -1, -2
// and -3 fail. -4, -5 and -6 pass under both — they are the controls and the
// two already-closed halves, and their job is to fail if the shared resolver
// moved anything that was already right.

import 'package:test/test.dart';
import 'interpreter_test.dart';

/// A script that binds a loopback server, connects to it, and has the server
/// write [written] before closing — leaving `socket` in scope for [body].
///
/// Both ends live in the script, as `F-SCC62-1` does: driving the client from
/// the host needs the port before the script runs, and a pre-bound-then-
/// released port is a race.
String socketScript(String body, {String written = r'hi\nthere\n'}) =>
    '''
      import 'dart:async';
      import 'dart:convert';
      import 'dart:io';

      class Lengths {
        Stream bind(Stream source) => source.map((chunk) => chunk.length);
      }

      main() async {
        var server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
        server.listen((connection) async {
          connection.add('$written'.codeUnits);
          await connection.close();
        });
        var socket = await Socket.connect('127.0.0.1', server.port);
        var result = await ($body);
        await server.close();
        return result;
      }
    ''';

/// The message of the failure [source] raises, or `'no throw'`.
Future<String> failure(String source) async {
  try {
    await executeAsync(source);
  } catch (e) {
    return e.toString();
  }
  return 'no throw';
}

void main() {
  group('SCE114: every transform adapter resolves its argument alike', () {
    test('F-SCE114-1: Socket.transform accepts an interpreted transformer '
        '[2026-09-22] (PASS)', () async {
      // `Lengths` has no native object at all — its `bind` lives only in the
      // interpreter, which is exactly the shape the cast rejected.
      expect(
        await executeAsync(
          socketScript('socket.transform(Lengths()).toList()'),
        ),
        [9],
      );
    });

    test('F-SCE114-2: a non-transformer argument names the member, not an '
        'interpreter-internal type [2026-09-22] (PASS)', () async {
      final wrongType = await failure(
        socketScript('socket.transform(42).toList()'),
      );
      expect(
        wrongType,
        contains(
          'Socket.transform requires a '
          'StreamTransformer argument',
        ),
      );
      // The old failure was a host `_TypeError`. Naming the SDK type the
      // adapter cast to tells the reader about the bridge's implementation
      // rather than about their program.
      expect(wrongType, isNot(contains('_TypeError')));
      expect(wrongType, isNot(contains('InterpretedInstance')));

      // A missing argument reaches the same sentence rather than a RangeError
      // restated by SCB28's arity heuristic.
      expect(
        await failure(socketScript('socket.transform().toList()')),
        contains('Socket.transform requires a StreamTransformer argument'),
      );

      // An interpreted instance without `bind` is not a transformer either,
      // and is the case that separates "resolve" from "accept anything".
      expect(
        await failure(socketScript('socket.transform(Object()).toList()')),
        contains('Socket.transform requires a StreamTransformer argument'),
      );
    });

    test('F-SCE114-3: ServerSocket.transform reports its own name '
        '[2026-09-22] (PASS)', () async {
      // It said `Socket.transform` — copied along with the body it was copied
      // from, which is the same defect shape SCE110 swept out of seventeen
      // `dart:io` adapters.
      expect(
        await failure('''
          import 'dart:io';
          main() async {
            var server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
            try {
              return server.transform(42);
            } finally {
              await server.close();
            }
          }
        '''),
        contains(
          'ServerSocket.transform requires a StreamTransformer '
          'argument',
        ),
      );
    });

    test('F-SCE114-4 (control): the native transformer path is unchanged '
        '[2026-09-22] (PASS)', () async {
      expect(
        await executeAsync(
          socketScript('socket.transform(utf8.decoder).join()'),
        ),
        'hi\nthere\n',
      );
      // Chained, because `.cast()` on the socket's statically-known element
      // type is the half of the old code the fix deliberately kept.
      expect(
        await executeAsync(
          socketScript(
            'socket.transform(utf8.decoder)'
            '.transform(LineSplitter()).toList()',
          ),
        ),
        ['hi', 'there'],
      );
      // `StreamTransformer.fromHandlers` builds a NATIVE transformer from
      // interpreted callbacks — the shape that always passed the cast, and so
      // the one a fix aimed at interpreted classes could have broken.
      expect(
        await executeAsync(
          socketScript('''socket.transform(
            StreamTransformer.fromHandlers(
              handleData: (chunk, sink) { sink.add(chunk.length); },
            )).toList()'''),
        ),
        [9],
      );
    });

    test('F-SCE114-5 (control): Stream.transform still resolves the same '
        'three shapes [2026-09-22] (PASS)', () async {
      // The path that was already right. It shares the resolver now, so it is
      // where a regression in the move would land first.
      expect(
        await executeAsync('''
          import 'dart:async';
          import 'dart:convert';
          class Lengths {
            Stream bind(Stream source) => source.map((c) => c.length);
          }
          main() async {
            var native = await Stream.fromIterable(['ab', 'cde'])
                .transform(StreamTransformer.fromHandlers(
                    handleData: (d, sink) { sink.add(d.length); })).toList();
            var interpreted = await Stream.fromIterable(['ab', 'cde'])
                .transform(Lengths()).toList();
            return [native, interpreted];
          }
        '''),
        [
          [2, 3],
          [2, 3],
        ],
      );
      expect(
        await failure('''
          main() async => await Stream.fromIterable([1]).transform(42).toList();
        '''),
        contains('Stream.transform requires a StreamTransformer argument'),
      );
    });

    test('F-SCE114-6: the capability this todo is named for '
        '[2026-09-22] (PASS)', () async {
      // Both halves the todo reported are closed — by SCE83 and SCD187 — and
      // neither had a test. A closed defect with no test is one refactor away
      // from being open again.
      expect(
        await executeAsync('''
          import 'dart:convert';
          main() async => await Stream.fromIterable([[104, 105]])
              .transform(utf8.decoder).join();
        '''),
        'hi',
      );
      // `HttpClientResponse.transform` was `throw RuntimeD4rtException(
      // 'transform not yet implemented in interpreted environment')`. This is
      // the line every Dart HTTP example contains.
      expect(
        await executeAsync('''
          import 'dart:convert';
          import 'dart:io';
          main() async {
            var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
            server.listen((request) {
              request.response.write('hello');
              request.response.close();
            });
            var client = HttpClient();
            var request = await client.getUrl(
              Uri.parse('http://127.0.0.1:' + server.port.toString() + '/'));
            var response = await request.close();
            var body = await response.transform(utf8.decoder).join();
            await server.close();
            client.close();
            return body;
          }
        '''),
        'hello',
      );
    });
  });
}
