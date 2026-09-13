// SCC25 — the `listen` adapter is copy-pasted across the stdlib, and the
// copies have drifted apart.
//
// THE TODO'S PREMISE WAS WRONG IN A WAY THAT MATTERS. It recorded that
// `io/socket.dart`'s listen adapter is "BYTE-IDENTICAL" to
// `async/stream.dart`'s, and that `_runAction` is "identical in every copy, so
// this is mechanical". Measured before touching anything: none of the nine
// `listen` adapters is identical to any other, and `_runAction` exists in two
// different shapes. Copy-paste is the origin, but what is actually there now is
// nine independent near-copies that were each edited separately.
//
// That is worse than the todo described, not better. Identical copies are
// merely wasteful; drifted copies disagree, and the disagreement is invisible
// because no test compares them. Measured on the pre-fix tree, the same script
// expression — `x.listen(null)`, which is legal Dart because `Stream.listen`
// declares `onData` as nullable — produced FOUR different outcomes depending on
// which bridge `x` came from:
//
//   Stream, Socket           accepted, no data callback     (matches the SDK)
//   ServerSocket, RawSocket, CastError: "type 'Null' is not a subtype of
//   RawServerSocket,             type 'InterpretedFunction'"
//   RawDatagramSocket            — an internal crash, not a script error
//   Stdin, HttpServer        RuntimeD4rtException, an invented restriction
//                                stricter than the platform's own contract
//
// None of those three behaviours was chosen; they are three different authors
// writing the same adapter from memory. This file pins the SDK-faithful one for
// every bridge that has a `listen`, so the drift cannot silently return.
//
// WHY A SOURCE-LEVEL GUARD TOO (F-SCC25-6/-7). Behavioural tests pin what the
// adapters do today, but the defect SCC25 is really about is structural: the
// next `listen` adapter someone adds will be a tenth copy, and no behavioural
// test can fail for code that does not exist yet. SCB9 is the precedent — it
// had to change fourteen sites for a one-line fix, and it found them by grep.
// The two source guards fail when a new private `_runAction` appears or when a
// `listen` adapter builds its own wrapper trio, which is the moment the cost is
// one edit rather than fourteen.
//
// REACHABILITY. Five of the nine bridges can be driven from a script here:
// Stream (a controller), Socket and ServerSocket (loopback TCP),
// RawDatagramSocket (loopback UDP) and HttpServer (loopback HTTP). The other
// four — RawSocket, RawServerSocket, Stdin, and the second HttpClient site —
// are unreachable for the reasons SCC22 measured and recorded in
// `scc22_io_error_handler_arity_test.dart`; that header remains the record and
// the source guards are what cover them here.
//
// WHERE THE SOURCE GUARDS WENT. F-SCC25-6/-7 — the two that read the stdlib
// trees instead of running a script — live in
// `scc25_listen_duplication_guard_test.dart` since SCD79. They resolve their
// paths relative to the package they run in, so they cannot be ported to
// `tom_d4rt_exec`, while the five cases below can and now are. Splitting keeps
// this file a verbatim port on both sides rather than buying a
// `_divergentBaseline` blanket over it; that file's header carries the decision.

import 'package:test/test.dart';

import 'interpreter_test.dart';

void main() {
  group('SCC25: every listen adapter accepts the argument shapes the SDK does', () {
    // `Stream.listen`'s first parameter is `void Function(T)?`. Passing null is
    // ordinary Dart — it subscribes for the `onDone` / `onError` channels
    // without wanting the data. Every bridge below wraps a real `Stream`, so
    // every one of them has to accept it. Before the fix only the first two
    // did.

    test('F-SCC25-1: Stream.listen(null) subscribes without a data callback '
        '[2026-09-04]', () async {
      // The baseline. `async/stream.dart` already had the SDK-faithful shape,
      // so this passes before and after — it is here to make the contrast in
      // F-SCC25-3/-4/-5 a comparison rather than an assertion in isolation.
      const source = '''
     import 'dart:async';
     main() async {
        final controller = StreamController();
        final done = Completer();
        controller.stream.listen(null, onDone: () => done.complete('done'));
        await controller.close();
        return await done.future;
      }
      ''';
      expect(await executeAsync(source), equals('done'));
    });

    test('F-SCC25-2: Socket.listen(null) subscribes without a data callback '
        '[2026-09-04]', () async {
      // Socket's adapter read `positionalArgs[0]` with no bounds check and cast
      // to a *nullable* function, so null flowed through correctly here but a
      // zero-argument call crashed with RangeError instead of a script error.
      // Both shapes go through the shared adapter now.
      const source = '''
     import 'dart:io';
     import 'dart:async';
     main() async {
        final server = await ServerSocket.bind('127.0.0.1', 0);
        server.listen((s) => s.destroy());
        final socket = await Socket.connect('127.0.0.1', server.port);
        final done = Completer();
        socket.listen(null, onDone: () => done.complete('done'));
        final result = await done.future;
        await server.close();
        return result;
      }
      ''';
      expect(await executeAsync(source), equals('done'));
    });

    test('F-SCC25-3: ServerSocket.listen(null) subscribes without a data '
        'callback [2026-09-04]', () async {
      // RED before the fix: the adapter cast to a NON-nullable
      // `InterpretedFunction`, so this died with "type 'Null' is not a subtype
      // of type 'InterpretedFunction'" — a Dart cast error escaping the
      // interpreter, which is an internal crash rather than a diagnosable
      // script fault.
      const source = '''
     import 'dart:io';
     main() async {
        final server = await ServerSocket.bind('127.0.0.1', 0);
        server.listen(null);
        final port = server.port;
        await server.close();
        return port > 0;
      }
      ''';
      expect(await executeAsync(source), isTrue);
    });

    test('F-SCC25-4: RawDatagramSocket.listen(null) subscribes without a data '
        'callback [2026-09-04]', () async {
      // RED before the fix, same cast. This is the only one of the three raw
      // socket adapters a test can bind without a peer, which is why it stands
      // in for all three — they were byte-identical to each other in the drift
      // and are byte-identical to each other now, via the shared adapter.
      const source = '''
     import 'dart:io';
     main() async {
        final socket = await RawDatagramSocket.bind('127.0.0.1', 0);
        socket.listen(null);
        final port = socket.port;
        socket.close();
        return port > 0;
      }
      ''';
      expect(await executeAsync(source), isTrue);
    });

    test('F-SCC25-5: HttpServer.listen(null) subscribes without a data callback '
        '[2026-09-04]', () async {
      // RED before the fix for a different reason than -3/-4: `io/http.dart`
      // threw RuntimeD4rtException('listen requires an onData callback.'), a
      // restriction d4rt invented. Nothing in the SDK requires onData, and no
      // test pinned the message — it was one author's guess, and the two other
      // authors guessed differently.
      const source = '''
     import 'dart:io';
     main() async {
        final server = await HttpServer.bind('127.0.0.1', 0);
        server.listen(null);
        final port = server.port;
        await server.close();
        return port > 0;
      }
      ''';
      expect(await executeAsync(source), isTrue);
    });
  });
}
