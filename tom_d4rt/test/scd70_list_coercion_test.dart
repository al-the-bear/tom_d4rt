// SCD70 — the byte APIs accept a list a script can actually construct.
//
// `s.add([65, 66])` threw:
//
//     type 'List<Object?>' is not a subtype of type 'List<int>' in type cast
//
// and — the part that makes it a defect rather than a script-authoring mistake
// — `s.add(<int>[65, 66])` threw the same thing. A list literal written in a
// script is a `List<Object?>` whatever its elements hold and whatever the
// author annotated, because the interpreter CHECKS the element type without
// reifying it. So `as List<int>` could not succeed for any list a script could
// build; it succeeded only for one that arrived already typed from a native
// bridge. There was no spelling of `Socket.add` that worked.
//
// THIRTEEN SITES, NOT TWO. The todo named `Socket.add` and
// `RawDatagramSocket.send`. Grepping `as List<` across both stdlib trees found
// the same cast in `RawSocket.write`, the `RawSocketOption` and `Datagram`
// constructors, all four `RandomAccessFile` buffer members, `stdout.add`,
// `IOSink.add`, `HttpClientRequest.add`, and `Isolate.spawnUri`'s `List<String>`
// args. Every one was unreachable from a script in exactly the same way, and a
// two-site fix would have left eleven twins — which is what the todo's notes
// warned about and why the sweep is the fix.
//
// THE `readInto` PAIR IS THE INTERESTING ONE, and it is why "replace every cast
// with `coerceList`" is the wrong instruction taken literally. `readInto` is an
// OUT parameter: the native writes the bytes it read into the caller's list.
// `coerceList` converts eagerly and hands the native a COPY — measured, that
// returns the byte count and leaves the script's buffer untouched, which is
// WORSE than the cast error it replaced, because a wrong answer is quieter than
// an exception. Those two sites use `List.cast<int>()`, whose `[]=` forwards to
// the source, so the bytes land where the script can see them. F-SCD70-4 is
// that case and it asserts the buffer contents, not the return value.
//
// ONE WORKING NEIGHBOUR EXPLAINS WHY THIS SURVIVED: `File.writeAsBytesSync`
// already used `(arg as List).cast()` and worked, as do a dozen sites in
// `convert/` and `core/`. The broken idiom is the bare `as List<int>`, and it
// sat beside the working one in the same files.
//
// CONTROL, measured by reverting the sweep: `+1 -5`. Only F-SCD70-6 keeps
// passing — it asserts that a list of the WRONG element type is still rejected,
// which a cast also does, and which is the rail against "coerce harder until
// something goes through".

import 'dart:io';

import 'package:test/test.dart';

import 'interpreter_test.dart' show executeAsync;

/// A loopback server that accepts one connection, reads what arrives and
/// reports it, so a successful `add` is proved by the bytes landing rather than
/// by the absence of an exception.
const _echoLengthServer = '''
  final server = await ServerSocket.bind('127.0.0.1', 0);
  final received = <int>[];
  final done = Completer();
  server.listen((c) {
    c.listen((data) { received.addAll(data); },
             onDone: () { if (!done.isCompleted) done.complete(); });
  });
''';

void main() {
  group('SCD70: byte APIs take a script-built list', () {
    test(
      'F-SCD70-1: Socket.add sends a plain list literal [2026-09-12] (PASS)',
      () async {
        // The bytes are read back on the server side: "did not throw" would
        // also pass against an adapter that accepted the list and dropped it.
        expect(
          await executeAsync('''
            import 'dart:io';
            import 'dart:async';
            main() async {
              $_echoLengthServer
              final s = await Socket.connect('127.0.0.1', server.port);
              s.add([65, 66, 67]);
              await s.flush();
              await s.close();
              await done.future.timeout(Duration(seconds: 5));
              await server.close();
              return received;
            }
          '''),
          [65, 66, 67],
        );
      },
      timeout: const Timeout(Duration(seconds: 30)),
    );

    test(
      'F-SCD70-2: the annotated spelling works too [2026-09-12] (PASS)',
      () async {
        // `<int>[...]` was the obvious thing for an author to try after the
        // first failure, and it failed identically — the annotation is checked,
        // not reified. Pinned so a future "fix" that only special-cases the
        // annotated form is visibly incomplete.
        expect(
          await executeAsync('''
            import 'dart:io';
            import 'dart:async';
            main() async {
              $_echoLengthServer
              final s = await Socket.connect('127.0.0.1', server.port);
              s.add(<int>[68, 69]);
              await s.flush();
              await s.close();
              await done.future.timeout(Duration(seconds: 5));
              await server.close();
              return received;
            }
          '''),
          [68, 69],
        );
      },
      timeout: const Timeout(Duration(seconds: 30)),
    );

    test(
      'F-SCD70-3: RawDatagramSocket.send takes one too [2026-09-12] (PASS)',
      () async {
        // The todo's second named site, and a different adapter from `add` —
        // it reads `positionalArgs[0]` in a three-argument member.
        expect(
          await executeAsync('''
            import 'dart:io';
            main() async {
              final s = await RawDatagramSocket.bind('127.0.0.1', 0);
              final n = s.send([65, 66], InternetAddress('127.0.0.1'), s.port);
              s.close();
              return n;
            }
          '''),
          2,
        );
      },
      timeout: const Timeout(Duration(seconds: 30)),
    );

    test(
      'F-SCD70-4: readInto fills the caller\'s buffer [2026-09-12] (PASS)',
      () async {
        // THE OUT-PARAMETER CASE. Asserting the return value alone passes
        // against the copy-handing bug this file's header describes: the count
        // is right and the buffer is untouched. Only reading the buffer back
        // catches it.
        final dir = Directory.systemTemp.createTempSync('scd70');
        addTearDown(() => dir.deleteSync(recursive: true));
        final path = '${dir.path}/bytes.bin';
        expect(
          await executeAsync('''
            import 'dart:io';
            main() {
              final f = File(r'$path').openSync(mode: FileMode.write);
              f.writeFromSync([65, 66, 67]);
              f.closeSync();
              final r = File(r'$path').openSync();
              final buffer = [0, 0, 0];
              final n = r.readIntoSync(buffer);
              r.closeSync();
              return [n, buffer];
            }
          '''),
          [
            3,
            [65, 66, 67],
          ],
        );
      },
      timeout: const Timeout(Duration(seconds: 30)),
    );

    test('F-SCD70-5: IOSink.add takes one, through a file sink '
        '[2026-09-12] (PASS)', () async {
      // `io_sink.dart`'s adapter, reached without a socket. `stdout.add` is
      // the same adapter shape and is deliberately not tested here — it would
      // write raw bytes into the test runner's own output.
      final dir = Directory.systemTemp.createTempSync('scd70');
      addTearDown(() => dir.deleteSync(recursive: true));
      final path = '${dir.path}/sink.bin';
      expect(
        await executeAsync('''
            import 'dart:io';
            main() async {
              final sink = File(r'$path').openWrite();
              sink.add([72, 73]);
              await sink.close();
              return File(r'$path').readAsBytesSync();
            }
          '''),
        [72, 73],
      );
    }, timeout: const Timeout(Duration(seconds: 30)));

    test(
      'F-SCD70-6: a wrong element type is still rejected [2026-09-12] (PASS)',
      () async {
        // THE RAIL. The fix must make `List<Object?>` usable, not make every
        // list usable — a coercion that shrugged at a String would send
        // whatever it managed to convert and lose the rest. This is also the
        // one case a plain cast got right, so it is what separates "coerced
        // correctly" from "coerced harder until something went through".
        final dir = Directory.systemTemp.createTempSync('scd70');
        addTearDown(() => dir.deleteSync(recursive: true));
        final path = '${dir.path}/bad.bin';
        await expectLater(
          executeAsync('''
            import 'dart:io';
            main() async {
              final sink = File(r'$path').openWrite();
              sink.add([72, 'not a byte']);
              await sink.close();
              return 'wrote';
            }
          '''),
          throwsA(anything),
        );
      },
      timeout: const Timeout(Duration(seconds: 30)),
    );
  });
}
