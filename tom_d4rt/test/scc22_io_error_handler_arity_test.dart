// SCC22 — the nine `dart:io` error-handler sites SCB9 fixed had no test.
//
// SCB9 routed 15 adapters through `errorHandlerArgs` so that a script's error
// handler is called with the arity it declares. Six of them are `dart:async`
// and are pinned by F-SCB9-1..14; the rest are `dart:io` and its header
// recorded them as "verified by construction rather than by test". This file
// closes that, and the shape of the closure is not what the todo assumed.
//
// NO HARNESS HAD TO BE BUILT. The todo's first instruction was to check whether
// a permissioned io harness already existed before writing one. It does:
// `interpreter_test.dart`'s `execute`/`executeAsync` already grant
// `NetworkPermission.any`, and `stdlib/io/socket_test.dart` already binds a
// loopback `ServerSocket` from inside a script. So the io sites were never
// unreachable for want of infrastructure.
//
// THREE OF THE NINE ARE REACHABLE, and they are reachable because an error can
// be forced onto their stream deterministically:
//
//   Socket.listen / Socket.handleError — a loopback server that accepts and
//       immediately destroys the connection makes the client's next write fail
//       with `Broken pipe`, which arrives on the socket's own stream.
//   HttpClientResponse.listen — a loopback server that answers with a
//       `Content-Length` larger than the body it sends and then hangs up makes
//       the client's response stream emit `Connection closed while receiving
//       data`.
//
// THE OTHER SIX ARE NOT, and the reason is the same for five of them: their
// stream's error channel carries *accept-* or *receive-side OS failures*, not
// anything a peer can provoke.
//
//   ServerSocket.listen, RawServerSocket.listen — the error channel of an
//       accept stream fires on `accept(2)` failing (EMFILE, ENFILE). A test
//       cannot exhaust the process file-descriptor table without breaking the
//       test runner with it.
//   HttpServer.listen — same, one layer up. Measured separately: a script
//       cannot even read `req.response` off the request it delivers
//       ("Cannot access property 'response' on target of type _HttpRequest"),
//       so the adapter's onData path is unreachable too. Filed as SCD71.
//   RawSocket.listen — a `RawSocket` reports peer loss as the
//       `RawSocketEvent.readClosed` *data* event, not as an error. Measured:
//       destroying the peer yields `[write, readClosed]` and no error.
//   RawDatagramSocket.listen — would need an ICMP port-unreachable to be
//       surfaced as an error event; loopback on macOS delivers
//       `RawSocketEvent.write` and nothing else. Measured, not assumed.
//   Stdin.listen — needs a terminal. The test process's stdin is a pipe owned
//       by the test runner, and consuming it breaks the runner.
//
// SO THE SIX GET A STRUCTURAL GUARD INSTEAD, and it is a better guard than six
// flaky socket tests would have been. The regression this todo fears is
// specific and stated: "the next person to touch a listen adapter in
// io/socket.dart has nothing telling them the arity behaviour is load-bearing".
// That person's mistake takes one of two shapes — reintroducing a hardcoded
// `[error, stackTrace]` pair, or writing a new adapter that never calls the
// helper. F-SCC22-10 and F-SCC22-11 catch both, at every one of the 15 sites
// including the ones no script can reach, and F-SCC22-12 catches them drifting
// apart between the two trees.
//
// THE HEADER'S OWN COUNT WAS WRONG. SCB9 says "14 sites" and enumerates
// `async/stream.dart (2)`. There are three there — `Stream.listen`,
// `Stream.handleError` and the `StreamSubscription.onError` setter — and there
// were three in the SCB9 commit itself, so the fix always covered 15. Its
// summary line ("the 6 async sites are covered below") and its test list
// (F-SCB9-8 pins the subscription setter) were both right; only the
// enumeration undercounted. Corrected in that header rather than here.
//
// AND ONE DEFECT FOUND ON THE WAY, fixed in this commit because writing the
// socket cases ran into it head-on. An `async` function whose `catch` block has
// an EMPTY BODY abandons every statement after the try/catch and resolves to a
// junk value — `null`, or whatever the last `await` produced. The first draft
// of the `Socket.listen` case wrapped its write loop in `catch (e) {}` and
// returned `null`; adding one statement to the catch body returned the right
// answer. `_handleAsyncError` jumps to `catchClause.body.statements.firstOrNull`
// and does not handle that being `null`, which stops the state machine dead.
// The same function already handles an empty *try* block and an empty *finally*
// block exactly this way, so the empty *catch* was the one hole in the set.
// F-SCC22-13..17 pin it. It is a silent-data-loss bug on a completely ordinary
// idiom, and this corpus writes `catch (e) {}` itself.

import 'dart:io';

import 'package:test/test.dart';

import 'interpreter_test.dart' show executeAsync;

// ---------------------------------------------------------------------------
// Script fragments
// ---------------------------------------------------------------------------

/// A loopback server that accepts one connection and destroys it, so the
/// client's next write fails with a broken pipe that lands on its stream.
const _hangUpServer = '''
        final server = await ServerSocket.bind('127.0.0.1', 0);
        server.listen((c) { c.destroy(); });
''';

/// Writes until the broken pipe surfaces. The catch body is deliberately
/// non-empty — `write` throws as well as signalling the stream, and what this
/// group measures is the stream handler, not the throw.
const _writeUntilBrokenPipe = '''
        var writeFailed = false;
        try {
          for (var i = 0; i < 300; i++) { s.write('x' * 4096); await s.flush(); }
        } catch (e) { writeFailed = true; }
        await Future.delayed(Duration(milliseconds: 400));
''';

Future<Object?> _socketListen(String handler) => executeAsync('''
      import 'dart:io';
      main() async {
        final seen = [];
$_hangUpServer
        final s = await Socket.connect('127.0.0.1', server.port);
        s.listen((d) {}, onError: $handler);
$_writeUntilBrokenPipe
        await server.close();
        return seen;
      }
''');

Future<Object?> _socketHandleError(String handler) => executeAsync('''
      import 'dart:io';
      main() async {
        final seen = [];
$_hangUpServer
        final s = await Socket.connect('127.0.0.1', server.port);
        s.handleError($handler).listen((d) {});
$_writeUntilBrokenPipe
        await server.close();
        return seen;
      }
''');

/// A loopback server speaking HTTP by hand: it promises 100 bytes, sends five,
/// and hangs up. The client's response stream then errors deterministically.
Future<Object?> _httpResponseListen(String handler) => executeAsync('''
      import 'dart:io';
      main() async {
        final seen = [];
        final server = await ServerSocket.bind('127.0.0.1', 0);
        server.listen((c) {
          c.listen((_) {
            c.write('HTTP/1.1 200 OK\\r\\nContent-Length: 100\\r\\n\\r\\nshort');
            c.close();
          });
        });
        final client = HttpClient();
        final req = await client.get('127.0.0.1', server.port, '/');
        final resp = await req.close();
        resp.listen((d) {}, onError: $handler);
        await Future.delayed(Duration(milliseconds: 600));
        await server.close();
        return seen;
      }
''');

const _unary = r"(e) => seen.add('unary')";
const _binary = r"(e, st) => seen.add('binary:${st != null}')";
const _optional = r"(e, [st]) => seen.add('optional:${st != null}')";

// ---------------------------------------------------------------------------
// Structural sweep
// ---------------------------------------------------------------------------

/// The adapters that hand an error to a script-supplied handler, by the stdlib
/// file they live in and the `Class.member` they implement.
///
/// This is the whole set SCB9 fixed, not just the io part: a guard that only
/// listed the io sites would go quiet the moment someone reintroduced the bug
/// in `async/`, which is where it was originally reported.
///
/// **SCC25 changed this map deliberately, and shrank it from 15 entries to 7.**
/// SCB9's 15 sites included nine `listen` adapters that were near-copies of one
/// another; SCC25 collapsed all nine into the single `bridgedStreamListen` in
/// `stream_listen.dart`, so they no longer call `errorHandlerArgs` themselves.
/// The nine did not lose their guarantee — they inherit it from the one place
/// that now implements it, which is a stronger arrangement than nine
/// independent copies each asserted separately. What this map protects after
/// SCC25 is the six adapters that are genuinely their own code plus the shared
/// helper; the *shape* of the collapse is pinned separately by F-SCC25-7, which
/// fails if a `listen` adapter starts building its own wrappers again.
const _expectedSites = <String, List<String>>{
  'async/future.dart': ['Future.then', 'Future.catchError', 'Future.onError'],
  'async/stream.dart': ['Stream.handleError', 'StreamSubscription.onError'],
  'io/socket.dart': ['Socket.handleError'],
  'stream_listen.dart': ['bridgedStreamListen'],
};

/// `lib/src/stdlib` in each tree. The two packages always sit side by side in
/// the `tom_d4rt` repo, which is what makes the convergence check in
/// F-SCC22-12 possible at all.
const _stdlibRoots = <String, String>{
  'tom_d4rt': 'lib/src/stdlib',
  'tom_d4rt_ast': '../tom_d4rt_ast/lib/src/runtime/stdlib',
};

final _memberPattern = RegExp(r"^\s*'(\w+)':\s*\(visitor");
final _classPattern = RegExp(r"^\s*name:\s*'(\w+)'");

/// The `Class.member` of every adapter in [file] that calls `errorHandlerArgs`.
///
/// Read structurally rather than by parsing: the bridge definitions are nested
/// map literals, so the enclosing class and member are found by scanning back
/// from the call for the nearest `'member': (visitor` and then the nearest
/// `name: 'Class'`. Both spellings are uniform across every stdlib file in both
/// trees, which is what makes the scan reliable.
List<String> _sitesIn(File file) {
  final lines = file.readAsLinesSync();
  final sites = <String>[];
  for (var i = 0; i < lines.length; i++) {
    if (!lines[i].contains('errorHandlerArgs(')) continue;
    String? member;
    String? className;
    for (var j = i; j >= 0; j--) {
      member ??= _memberPattern.firstMatch(lines[j])?.group(1);
      final cls = _classPattern.firstMatch(lines[j])?.group(1);
      if (cls != null) {
        className = cls;
        break;
      }
    }
    if (className != null) {
      sites.add('$className.${member ?? '<no member>'}');
      continue;
    }
    // No enclosing bridge class: the call is in a shared helper, which since
    // SCC25 is where nine of the fifteen original sites live. Name it by its
    // top-level function so a failure still says *what* stopped calling the
    // helper rather than `<no class>`.
    sites.add(_enclosingTopLevelFunction(lines, i) ?? '<no class>.<no member>');
  }
  return sites;
}

/// The name of the top-level function containing line [from], scanning back for
/// the nearest declaration that starts in column 0 and takes a parameter list.
String? _enclosingTopLevelFunction(List<String> lines, int from) {
  final declaration = RegExp(r'^[\w<>?,\s]*?(\w+)\s*\($');
  for (var i = from; i >= 0; i--) {
    if (lines[i].startsWith(' ') || lines[i].startsWith('//')) continue;
    final match = declaration.firstMatch(lines[i].trimRight());
    if (match != null) return match.group(1);
  }
  return null;
}

/// Every `.dart` file under [root], excluding the helper itself.
List<File> _stdlibFiles(String root) {
  final dir = Directory(root);
  if (!dir.existsSync()) {
    fail('stdlib root "$root" does not exist — run this from the package root, '
        'with both packages checked out side by side.');
  }
  return dir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) =>
          f.path.endsWith('.dart') &&
          !f.path.endsWith('error_handler_args.dart'))
      .toList()
    ..sort((a, b) => a.path.compareTo(b.path));
}

/// The full `{relative file: [sites]}` map for one tree.
Map<String, List<String>> _siteMap(String root) {
  final result = <String, List<String>>{};
  for (final file in _stdlibFiles(root)) {
    final sites = _sitesIn(file);
    if (sites.isEmpty) continue;
    result[file.path.substring(root.length + 1)] = sites;
  }
  return result;
}

void main() {
  group('SCC22: the reachable dart:io error-handler sites', () {
    // Socket.listen — site 1 of 9. Not a copy of Stream.listen's test: SCB9's
    // header records that io/socket.dart's listen adapter was a byte-identical
    // copy of async/stream.dart's, which is exactly why it needs its own case.
    test('F-SCC22-1: a unary Socket.listen onError receives the error '
        '[2026-09-04]', () async {
      expect(await _socketListen(_unary), orderedEquals(['unary']));
    }, timeout: const Timeout(Duration(seconds: 40)));

    test('F-SCC22-2: a binary Socket.listen onError receives both arguments '
        '[2026-09-04]', () async {
      expect(await _socketListen(_binary), orderedEquals(['binary:true']));
    }, timeout: const Timeout(Duration(seconds: 40)));

    test(
        'F-SCC22-3: a Socket.listen onError with an optional second parameter '
        'still receives the stack trace [2026-09-04]', () async {
      // The `maxPositionalArity`-not-`arity` property, at an io site. Selecting
      // on `arity` reports 1 for `(e, [st])` and would drop the stack trace.
      expect(await _socketListen(_optional), orderedEquals(['optional:true']));
    }, timeout: const Timeout(Duration(seconds: 40)));

    test('F-SCC22-4: a unary Socket.handleError handler receives the error '
        '[2026-09-04]', () async {
      expect(await _socketHandleError(_unary), orderedEquals(['unary']));
    }, timeout: const Timeout(Duration(seconds: 40)));

    test('F-SCC22-5: a binary Socket.handleError handler receives both '
        'arguments [2026-09-04]', () async {
      expect(await _socketHandleError(_binary), orderedEquals(['binary:true']));
    }, timeout: const Timeout(Duration(seconds: 40)));

    test(
        'F-SCC22-6: a Socket.handleError handler with an optional second '
        'parameter still receives the stack trace [2026-09-04]', () async {
      expect(
          await _socketHandleError(_optional), orderedEquals(['optional:true']));
    }, timeout: const Timeout(Duration(seconds: 40)));

    test('F-SCC22-7: a unary HttpClientResponse.listen onError receives the '
        'error [2026-09-04]', () async {
      expect(await _httpResponseListen(_unary), orderedEquals(['unary']));
    }, timeout: const Timeout(Duration(seconds: 40)));

    test('F-SCC22-8: a binary HttpClientResponse.listen onError receives both '
        'arguments [2026-09-04]', () async {
      expect(await _httpResponseListen(_binary), orderedEquals(['binary:true']));
    }, timeout: const Timeout(Duration(seconds: 40)));

    test(
        'F-SCC22-9: an HttpClientResponse.listen onError with an optional '
        'second parameter still receives the stack trace [2026-09-04]',
        () async {
      expect(await _httpResponseListen(_optional),
          orderedEquals(['optional:true']));
    }, timeout: const Timeout(Duration(seconds: 40)));
  });

  group('SCC22: the sites no script can reach are guarded structurally', () {
    test(
        'F-SCC22-10: the only hardcoded [error, stackTrace] pair in the stdlib '
        'is the one inside errorHandlerArgs [2026-09-04]', () {
      // The regression SCB9 fixed, stated as an invariant. Every adapter used
      // to build this pair itself; the helper is now the only place allowed to,
      // because it is the only place that first asks how many parameters the
      // script's handler declared.
      for (final entry in _stdlibRoots.entries) {
        final offenders = <String>[];
        for (final file in _stdlibFiles(entry.value)) {
          final lines = file.readAsLinesSync();
          for (var i = 0; i < lines.length; i++) {
            if (RegExp(r'\[\s*\w*[Ee]rror\w*\s*,\s*\w*[Ss]tack\w*\s*\]')
                .hasMatch(lines[i])) {
              offenders.add('${entry.key}: ${file.path}:${i + 1}');
            }
          }
        }
        expect(offenders, isEmpty,
            reason: 'a two-argument error-handler call was hardcoded again — '
                'route it through errorHandlerArgs instead');
      }
    });

    test(
        'F-SCC22-11: every error-handler adapter still routes through the '
        'helper, in both trees [2026-09-04]', () {
      // Named per site rather than counted, so a failure says *which* adapter
      // stopped calling the helper.
      //
      // The set was 15 until SCC25 collapsed the nine `listen` adapters into
      // `bridgedStreamListen`. The six that had no behavioural case anywhere in
      // the corpus — ServerSocket.listen, RawSocket.listen,
      // RawServerSocket.listen, RawDatagramSocket.listen, HttpServer.listen and
      // Stdin.listen — were all `listen` adapters, so they are now covered by
      // whatever covers the shared one, which includes F-SCB9-1..3 and
      // F-SCC22-1..3. That is the substantive gain from the de-duplication: the
      // sites a test cannot reach stopped being separate code.
      for (final entry in _stdlibRoots.entries) {
        expect(_siteMap(entry.value), equals(_expectedSites),
            reason: '${entry.key}: the set of adapters calling '
                'errorHandlerArgs changed');
      }
    });

    test(
        'F-SCC22-12: the two trees declare the same sites, so the fix cannot '
        'drift out of one of them [2026-09-04]', () {
      // The mirror rule as an assertion. SCB9 landed in both trees by hand;
      // nothing until now would have noticed a later edit reaching only one.
      expect(_siteMap(_stdlibRoots['tom_d4rt_ast']!),
          equals(_siteMap(_stdlibRoots['tom_d4rt']!)));
    });
  });

  group('SCC22: an empty catch block does not abandon an async function', () {
    // Found by this todo's first Socket draft, which used `catch (e) {}` and
    // silently returned null. `_handleAsyncError` resumes at
    // `catchClause.body.statements.firstOrNull` — `null` for an empty body —
    // and a null resume identifier stops the state machine where it stands.

    test('F-SCC22-13: statements after an empty catch still run [2026-09-04]',
        () async {
      expect(await executeAsync(r'''
        main() async {
          final seen = [];
          try { throw 'x'; } catch (e) {}
          seen.add('after');
          return seen;
        }
      '''), orderedEquals(['after']));
    });

    test(
        'F-SCC22-14: the same holds when the try block awaited before throwing '
        '[2026-09-04]', () async {
      // The suspended route through the state machine, which is the one that
      // returned the last awaited VALUE (1) rather than null — a different
      // wrong answer from the same missing branch.
      expect(await executeAsync(r'''
        main() async {
          final seen = [];
          try { await Future.value(1); throw 'x'; } catch (e) {}
          seen.add('after');
          return seen;
        }
      '''), orderedEquals(['after']));
    });

    test('F-SCC22-15: an await after an empty catch still resumes [2026-09-04]',
        () async {
      expect(await executeAsync(r'''
        main() async {
          final seen = [];
          try { throw 'x'; } catch (e) {}
          final v = await Future.value(7);
          seen.add(v);
          return seen;
        }
      '''), orderedEquals([7]));
    });

    test(
        'F-SCC22-16: an empty catch runs the finally before continuing '
        '[2026-09-04]', () async {
      // The empty-catch branch must reach a `finally` the same way a completed
      // non-empty catch does, not skip past the whole statement.
      expect(await executeAsync(r'''
        main() async {
          final seen = [];
          try { await Future.value(1); throw 'x'; }
          catch (e) {}
          finally { seen.add('finally'); }
          seen.add('after');
          return seen;
        }
      '''), orderedEquals(['finally', 'after']));
    });

    test(
        'F-SCC22-17: a non-empty catch is unaffected, and still binds the error '
        '[2026-09-04]', () async {
      // The regression guard for the fix itself: the working path is the one a
      // careless empty-body branch would be most likely to break.
      expect(await executeAsync(r'''
        main() async {
          final seen = [];
          try { await Future.value(1); throw 'boom'; }
          catch (e) { seen.add('caught:$e'); }
          seen.add('after');
          return seen;
        }
      '''), orderedEquals(['caught:boom', 'after']));
    });
  });
}
