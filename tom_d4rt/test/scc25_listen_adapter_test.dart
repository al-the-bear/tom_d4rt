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

import 'dart:io';

import 'package:test/test.dart';

import 'interpreter_test.dart';

/// `lib/src/stdlib` in each tree.
///
/// Both trees are swept from this one suite, following the precedent
/// F-SCC22-11/-12 set: `tom_d4rt_ast` has no parser, so it cannot run the
/// script cases above, and a guard that only watched the tree it lives in would
/// let the duplication grow back in the other half of the mirror unnoticed.
/// The two packages always sit side by side in the `tom_d4rt` repo, which is
/// what makes the relative path work.
const _stdlibRoots = <String, String>{
  'tom_d4rt': 'lib/src/stdlib',
  'tom_d4rt_ast': '../tom_d4rt_ast/lib/src/runtime/stdlib',
};

/// The files that carry a `listen` adapter, relative to a tree's stdlib root.
///
/// Listed rather than globbed: a glob would silently start passing if a file
/// were renamed, and the point of the guard is to notice exactly that kind of
/// move.
const _listenAdapterFiles = <String>[
  'async/stream.dart',
  'io/socket.dart',
  'io/stdio.dart',
  'io/http.dart',
];

/// Every stdlib file under [root], for the `_runAction` uniqueness guard.
List<File> _allStdlibSources(String root) {
  final dir = Directory(root);
  if (!dir.existsSync()) {
    fail(
      'stdlib root "$root" does not exist — run this from the package root, '
      'with both packages checked out side by side.',
    );
  }
  return dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));
}

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

  group('SCC25: the duplication cannot grow back', () {
    test('F-SCC25-6: `_runAction` is not redefined privately in any stdlib file '
        '[2026-09-04]', () {
      // Before the fix there were four private definitions in two different
      // shapes: `T? _runAction<T>` in io/socket.dart and
      // typed_data/uint8_list.dart, `FutureOr<T> _runAction<T>` in
      // async/stream.dart and async/stream_controller.dart. They differ only
      // when the function is null and T is non-nullable, where the FutureOr
      // form throws and the nullable form returns null — a divergence no call
      // site relied on, since none of the 84 of them ever awaits the result.
      //
      // The guard is on the *definition*, not on the call: call sites should
      // keep using the helper freely.
      // Comment lines are skipped deliberately: `run_action.dart` documents the
      // two shapes it replaced by quoting their signatures, and a guard that
      // cannot tell a definition from a description of one would make the
      // explanation unwritable.
      final offenders = <String>[];
      for (final root in _stdlibRoots.entries) {
        for (final file in _allStdlibSources(root.value)) {
          final lines = file.readAsLinesSync();
          for (var i = 0; i < lines.length; i++) {
            final line = lines[i];
            if (line.trimLeft().startsWith('//')) continue;
            if (RegExp(r'\b_runAction<T>\s*\(').hasMatch(line)) {
              offenders.add('${root.key}: ${file.path}:${i + 1}');
            }
          }
        }
      }
      expect(
        offenders,
        isEmpty,
        reason:
            'A private `_runAction` has reappeared. Use the shared '
            '`runAction` from lib/src/stdlib/run_action.dart instead — a '
            'second copy is how SCB9 turned into a fourteen-site fix.',
      );
    });

    test('F-SCC25-7: no listen adapter builds its own onError/onDone wrapper '
        'trio [2026-09-04]', () {
      // The onError and onDone wrappers were the genuinely identical part of
      // the nine copies — byte-for-byte the same in all six that had them,
      // including the `onErrorWrapper` / `onDoneWrapper` names. That is the
      // duplication the shared adapter removes, so its return is what this
      // guard watches for.
      final offenders = <String>[];
      for (final root in _stdlibRoots.entries) {
        for (final relative in _listenAdapterFiles) {
          final path = '${root.value}/$relative';
          final lines = File(path).readAsLinesSync();
          for (var i = 0; i < lines.length; i++) {
            if (lines[i].contains('onErrorWrapper') ||
                lines[i].contains('onDoneWrapper')) {
              offenders.add('${root.key}: $path:${i + 1}');
            }
          }
        }
      }
      expect(
        offenders,
        isEmpty,
        reason:
            'A listen adapter is building its own callback wrappers '
            'again. Call `bridgedStreamListen` from '
            'lib/src/stdlib/stream_listen.dart — it already handles the '
            'error-handler arity that SCB9 had to fix in fourteen places.',
      );
    });
  });
}
