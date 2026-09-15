// The `dart:io` bridges refuse every socket-acquiring operation without a
// matching `NetworkPermission`.
//
// WHAT WAS WRONG. `NetworkPermission` was declared, documented and threaded
// through the permission system, and in the whole of `lib` it gated exactly
// ONE call site: `InternetAddress.lookup`. Everything that actually opens a
// socket — `Socket.connect`, `ServerSocket.bind`, `RawSocket.connect`,
// `RawServerSocket.bind`, `RawDatagramSocket.bind`, `HttpServer.bind` /
// `bindSecure` / `listenOn`, `WebSocket.connect` and the entire `HttpClient`
// surface — ran unchecked. What stood in for a gate was the IMPORT gate on
// `dart:io`, which is keyed on `FilesystemPermission`, so a script granted
// filesystem access silently received unrestricted network access.
//
// WHY THE SWEEP IS THE POINT. A partial gate is worse than none, because it
// reads as a working sandbox. `HttpServer.bind` alone is bypassable with
// `ServerSocket.bind` + `HttpServer.listenOn`; `HttpClient.getUrl` alone is
// bypassable with `HttpClient.open`; all of HTTP is bypassable with
// `Socket.connect`. F-SCD170-4 drives those three routes specifically, and
// F-SCD170-1 is a census over the sources so an adapter added later cannot
// quietly arrive ungated.
//
// THE GRANTED DIRECTION asserts only that the failure is no longer a
// PERMISSION failure — a connection to a closed port legitimately fails, and
// pinning a successful connection would make these tests depend on the host's
// network. A gate that failed closed on everything would pass a one-sided
// test, which is what F-SCD170-3 and F-SCD170-5 exist to prevent.

import 'dart:io' as io;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// The bridge sources that acquire sockets.
const _gatedSources = <String>[
  'lib/src/stdlib/io/socket.dart',
  'lib/src/stdlib/io/http.dart',
  'lib/src/stdlib/io/websocket.dart',
];

/// Native calls that acquire a socket, and therefore must be gated.
final RegExp _socketAcquiring = RegExp(
  r'\b(?:Socket|RawSocket|ServerSocket|RawServerSocket|RawDatagramSocket|'
  r'HttpServer|WebSocket)\.(?:connect|startConnect|bind|bindSecure|listenOn)\('
  r'|\(target as HttpClient\)\.\w+\(',
);

final RegExp _gateCall = RegExp(r'checkNetwork\w+Permission\(');

/// `HttpClient` members the bridge calls that acquire NO socket.
///
/// The census matches every `(target as HttpClient).x(` and then subtracts
/// this set, rather than listing the fourteen that DO connect. The polarity is
/// the point: a method added to the bridge later is required to be gated by
/// default and has to be exempted deliberately, whereas a hand-list of
/// connecting methods would let a new one through in silence — which is the
/// shape of the defect this whole file exists for.
///
/// `close` tears a client down, and the two credential methods populate a
/// local store consulted when a request is later made; that request goes
/// through `open`/`openUrl`, which are gated.
const _httpClientNonConnecting = <String>{
  'addCredentials',
  'addProxyCredentials',
  'close',
};

final RegExp _httpClientCall = RegExp(r'\(target as HttpClient\)\.(\w+)\(');

/// Runs [source] with filesystem access but no network grant.
Object? Function() _denied(String source) {
  final interpreter = D4rt()..grant(FilesystemPermission.any);
  return () => interpreter.execute(source: source);
}

Matcher _isPermissionDenial = throwsA(
  isA<RuntimeD4rtException>().having(
    (e) => e.message,
    'message',
    allOf(contains('Network permission denied'), contains('NetworkPermission')),
  ),
);

/// Scripts that reach a socket, one per entry point.
const _entryPoints = <String, String>{
  'Socket.connect': "await Socket.connect('127.0.0.1', 9);",
  'Socket.startConnect': "await Socket.startConnect('127.0.0.1', 9);",
  'ServerSocket.bind': "await ServerSocket.bind('127.0.0.1', 0);",
  'RawSocket.connect': "await RawSocket.connect('127.0.0.1', 9);",
  'RawSocket.startConnect': "await RawSocket.startConnect('127.0.0.1', 9);",
  'RawServerSocket.bind': "await RawServerSocket.bind('127.0.0.1', 0);",
  'RawDatagramSocket.bind': "await RawDatagramSocket.bind('127.0.0.1', 0);",
  'HttpServer.bind': "await HttpServer.bind('127.0.0.1', 0);",
  'InternetAddress.lookup': "await InternetAddress.lookup('localhost');",
  'HttpClient.getUrl':
      "await HttpClient().getUrl(Uri.parse('http://127.0.0.1:9/'));",
  'HttpClient.get': "await HttpClient().get('127.0.0.1', 9, '/');",
  'HttpClient.open': "await HttpClient().open('GET', '127.0.0.1', 9, '/');",
  'HttpClient.openUrl':
      "await HttpClient().openUrl('GET', Uri.parse('http://127.0.0.1:9/'));",
  'WebSocket.connect': "await WebSocket.connect('ws://127.0.0.1:9/');",
};

String _script(String body) =>
    "import 'dart:io';\nFuture<dynamic> main() async { $body return 1; }";

void main() {
  group('SCD170: every socket-acquiring bridge is gated', () {
    test('F-SCD170-1: every socket-acquiring native call in the bridge '
        'sources has a gate above it [2026-09-15] (PASS)', () {
      // Anti-vacuity AND the structural half: the behavioural cases below can
      // only cover entry points somebody remembered to list, so the census is
      // what notices an adapter added later.
      final ungated = <String>[];
      final exempted = <String>{};
      var scanned = 0;
      for (final path in _gatedSources) {
        final lines = io.File(path).readAsLinesSync();
        expect(lines, isNotEmpty, reason: '$path is empty or missing');
        for (var i = 0; i < lines.length; i++) {
          if (!_socketAcquiring.hasMatch(lines[i])) continue;
          final httpClient = _httpClientCall.firstMatch(lines[i]);
          if (httpClient != null &&
              _httpClientNonConnecting.contains(httpClient.group(1))) {
            exempted.add(httpClient.group(1)!);
            continue;
          }
          scanned++;
          final from = i - 12 < 0 ? 0 : i - 12;
          final window = lines.sublist(from, i).join('\n');
          if (!_gateCall.hasMatch(window)) {
            ungated.add('$path:${i + 1}: ${lines[i].trim()}');
          }
        }
      }
      expect(
        scanned,
        greaterThanOrEqualTo(20),
        reason:
            'only $scanned socket-acquiring calls found — the scan is not '
            'seeing the bridge surface, so the check below is vacuous',
      );
      // No exemption outlives its cause: a name left here after the bridge
      // stopped calling it would silently widen what the census ignores.
      expect(
        exempted,
        equals(_httpClientNonConnecting),
        reason:
            'the non-connecting exemption list no longer matches what the '
            'bridge calls — remove the entries that are gone, and check '
            'whether anything new needs gating',
      );
      expect(
        ungated,
        isEmpty,
        reason:
            'These acquire a socket with no NetworkPermission check above '
            'them. A partial gate reads as a working sandbox and is worse '
            'than none: add a checkNetwork*Permission call from '
            'lib/src/stdlib/io/network_permission_helper.dart.',
      );
    });

    for (final entry in _entryPoints.entries) {
      test('F-SCD170-2-${entry.key}: refuses without NetworkPermission '
          '[2026-09-15] (PASS)', () async {
        await expectLater(_denied(_script(entry.value))(), _isPermissionDenial);
      });
    }

    test('F-SCD170-3: the grant lets the operation through '
        '[2026-09-15] (PASS)', () async {
      // Bind to port 0 and read the assigned port back: a real socket, no
      // dependence on anything outside this process.
      final interpreter = D4rt()
        ..grant(FilesystemPermission.any)
        ..grant(NetworkPermission.any);
      final port = await interpreter.execute(
        source: _script(
          "final s = await ServerSocket.bind('127.0.0.1', 0);"
          ' final p = s.port; await s.close(); return p;',
        ).replaceFirst(' return 1; }', ' }'),
      );
      expect(port, isA<int>());
      expect(port as int, greaterThan(0));
    });

    test('F-SCD170-4: the three documented bypass routes are all closed '
        '[2026-09-15] (PASS)', () async {
      // Each of these is a way to reach the network AROUND a gate placed only
      // on the obvious method, and each is named in SCD170 as the reason the
      // change had to be one sweep rather than per-class.
      await expectLater(
        _denied(
          _script(
            "final s = await ServerSocket.bind('127.0.0.1', 0);"
            ' HttpServer.listenOn(s);',
          ),
        )(),
        _isPermissionDenial,
      );
      await expectLater(
        _denied(
          _script("await HttpClient().open('GET', '127.0.0.1', 9, '/');"),
        )(),
        _isPermissionDenial,
      );
      await expectLater(
        _denied(_script("await Socket.connect('127.0.0.1', 9);"))(),
        _isPermissionDenial,
      );
    });

    test('F-SCD170-5: a host-scoped grant refuses a different host '
        '[2026-09-15] (PASS)', () async {
      // The granularity NetworkPermission has always modelled and never
      // enforced: the single gate that existed took a host argument and then
      // dropped it, so connectTo behaved exactly like connect.
      final interpreter = D4rt()
        ..grant(FilesystemPermission.any)
        ..grant(NetworkPermission.connectTo('allowed.invalid'));
      await expectLater(
        interpreter.execute(
          source: _script("await Socket.connect('denied.invalid', 9);"),
        ),
        _isPermissionDenial,
      );
    });

    test('F-SCD170-6 (control): a host-scoped grant admits its own host '
        '[2026-09-15] (PASS)', () async {
      // Without this, F-SCD170-5 is satisfied by a gate that refuses every
      // host — a different bug with the same test result. `.invalid` never
      // resolves, so the operation still fails; what matters is that it no
      // longer fails as a PERMISSION denial.
      final interpreter = D4rt()
        ..grant(FilesystemPermission.any)
        ..grant(NetworkPermission.connectTo('allowed.invalid'));
      Object? error;
      try {
        await interpreter.execute(
          source: _script("await Socket.connect('allowed.invalid', 9);"),
        );
      } catch (e) {
        error = e;
      }
      expect(error, isNotNull, reason: 'allowed.invalid cannot resolve');
      expect(
        error.toString(),
        isNot(contains('Network permission denied')),
        reason: 'the grant names this host, so the gate must not be what fails',
      );
    });

    test('F-SCD170-7 (control): a script that opens no socket is unaffected '
        '[2026-09-15] (PASS)', () async {
      final interpreter = D4rt()..grant(FilesystemPermission.any);
      expect(
        await interpreter.execute(
          source:
              "import 'dart:io';\n"
              'Future<dynamic> main() async '
              "{ return InternetAddress('127.0.0.1').address; }",
        ),
        '127.0.0.1',
      );
    });
  });
}
