import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../../interpreter_test.dart';
import 'package:test/test.dart';

/// An HTTP-shaped server on the loopback interface, run by the TEST (natively,
/// not by the script under test). It records what the first client sends and
/// answers a complete request head with a fixed response.
///
/// WHY. These tests used to connect to `google.com` and `httpbin.org`. That
/// made the suite depend on outbound network — one full `dart test -j1` run
/// failed `I-FILE-179` and a rerun passed — and, worse, each test wrapped the
/// script in catch-alls so that an unreachable network would not fail it. The
/// same catch-alls swallowed interpreter errors: `break` inside `await for`
/// was broken for months while `I-FILE-179` printed a "Skipping" line and
/// passed (scd4_ahlh). A loopback server is always reachable, so every test
/// here can demand one exact outcome, and because the server records what
/// arrived, a write can be checked from the far end instead of trusted.
class _LoopbackHttp {
  _LoopbackHttp._(this._server) {
    _server.listen(_serve);
  }

  static Future<_LoopbackHttp> start() async =>
      _LoopbackHttp._(await ServerSocket.bind(InternetAddress.loopbackIPv4, 0));

  static const response =
      'HTTP/1.1 200 OK\r\nContent-Length: 2\r\nConnection: close\r\n\r\nok';

  final ServerSocket _server;
  final _firstRequest = Completer<String>();

  int get port => _server.port;

  /// Everything the first client sent: its request head, or all of it when it
  /// closed before sending one.
  Future<String> get firstRequest =>
      _firstRequest.future.timeout(const Duration(seconds: 10));

  void _serve(Socket client) {
    // A client that closes before reading the response makes our write fail
    // with a broken pipe; that is the client's business, not a test failure.
    client.done.catchError((Object _) {});
    final received = StringBuffer();
    var answered = false;
    utf8.decoder
        .bind(client)
        .listen(
          (chunk) {
            received.write(chunk);
            if (!answered && received.toString().contains('\r\n\r\n')) {
              answered = true;
              _record(received.toString());
              client.write(response);
              client.close().catchError((Object _) => client);
            }
          },
          onDone: () => _record(received.toString()),
          onError: (Object _) => _record(received.toString()),
          cancelOnError: true,
        );
  }

  void _record(String request) {
    if (!_firstRequest.isCompleted) _firstRequest.complete(request);
  }

  Future<void> close() => _server.close();
}

void main() {
  group('Socket methods - comprehensive', () {
    late _LoopbackHttp http;

    setUp(() async => http = await _LoopbackHttp.start());
    tearDown(() => http.close());

    test(
      'I-FILE-185: Socket.connect reaches a loopback server. [2026-09-11] (PASS)',
      () async {
        final source =
            '''
     import 'dart:io';
     main() async {
        var socket = await Socket.connect('127.0.0.1', ${http.port},
            timeout: Duration(seconds: 5));
        var remotePort = socket.remotePort;
        await socket.close();
        return remotePort;
      }
      ''';
        final result = await execute(source);
        expect(result, http.port);
      },
    );

    test(
      'I-FILE-183: InternetAddress.lookup resolves localhost. [2026-09-11] (PASS)',
      () async {
        // `localhost` resolves from the hosts file on every host, so a lookup
        // that fails here is a defect, not an environment to tolerate.
        const source = '''
     import 'dart:io';
     main() async {
        var addresses = await InternetAddress.lookup('localhost');
        return addresses.isNotEmpty && addresses.every((a) => a.isLoopback);
      }
      ''';
        final result = await execute(source);
        expect(result, isTrue);
      },
    );

    test(
      'I-FILE-184: InternetAddress constants. [2026-02-10 06:37] (PASS)',
      () {
        const source = '''
     import 'dart:io';
     main() {
        var loopbackIPv4 = InternetAddress.loopbackIPv4.address;
        var loopbackIPv6 = InternetAddress.loopbackIPv6.address;
        var anyIPv4 = InternetAddress.anyIPv4.address;
        var anyIPv6 = InternetAddress.anyIPv6.address;

        return [
          loopbackIPv4 == '127.0.0.1',
          loopbackIPv6 == '::1',
          anyIPv4 == '0.0.0.0',
          anyIPv6 == '::'
        ];
      }
      ''';
        final result = execute(source);
        expect(result, equals([true, true, true, true]));
      },
    );

    test(
      'I-FILE-186: Socket server and client communication. [2026-09-11] (PASS)',
      () async {
        // Both ends run in the script. It used to accept any 'Error:' result
        // and print "Skipping" on any exception; loopback cannot be
        // unavailable, so only the echo is a pass.
        const source = '''
     import 'dart:io';
import 'dart:convert';

main() async {
  // Create a server
  var server = await ServerSocket.bind('127.0.0.1', 0);
  var serverPort = server.port;

  // Handle incoming connections with sync callback
  server.listen((Socket clientSocket) {
    // Read first message and respond
    clientSocket.transform(utf8.decoder).listen((data) {
      clientSocket.write('Echo: \$data');
      clientSocket.close();
    });
  });

  // Create a client
  var clientSocket = await Socket.connect('127.0.0.1', serverPort);
  clientSocket.write('Hello Server');
  await clientSocket.flush();

  // Read response
  var response = await clientSocket.transform(utf8.decoder.cast()).first;

  await server.close();

  return response.trim();
}

      ''';
        final result = await execute(source);
        expect(result, equals('Echo: Hello Server'));
      },
    );

    test(
      'I-FILE-179: Socket write and flush methods. [2026-09-11] (PASS)',
      () async {
        // Also the regression test for `break` inside `await for` over a
        // socket (scd4_ahlh), which the old catch-all reported as a skip.
        final source =
            '''
     import 'dart:io';
     import 'dart:convert';
     main() async {
        var socket = await Socket.connect('127.0.0.1', ${http.port},
            timeout: Duration(seconds: 5));

        // Send HTTP request
        socket.write('GET /get HTTP/1.1\\r\\n');
        socket.write('Host: loopback\\r\\n');
        socket.write('Connection: close\\r\\n');
        socket.write('\\r\\n');

        await socket.flush();

        // Read a bit of response to verify it worked
        var response = '';
        await for (var data in socket.transform(utf8.decoder).take(1)) {
          response = data;
          break;
        }

        await socket.close();

        return response;
      }
      ''';
        final result = await execute(source);
        expect(result, startsWith('HTTP/1.1 200 OK'));
        expect(
          await http.firstRequest,
          'GET /get HTTP/1.1\r\nHost: loopback\r\nConnection: close\r\n\r\n',
          reason: 'what the server received is what the script wrote',
        );
      },
    );

    test(
      'I-FILE-180: Socket add method with bytes. [2026-09-11] (PASS)',
      () async {
        final source =
            '''
     import 'dart:io';
     import 'dart:convert';
     main() async {
        var socket = await Socket.connect('127.0.0.1', ${http.port},
            timeout: Duration(seconds: 3));

        var data = utf8.encode('GET / HTTP/1.1\\r\\nHost: loopback\\r\\n\\r\\n');
        socket.add(data);
        await socket.flush();

        await socket.close();
        return true;
      }
      ''';
        final result = await execute(source);
        expect(result, isTrue);
        expect(
          await http.firstRequest,
          'GET / HTTP/1.1\r\nHost: loopback\r\n\r\n',
          reason: 'the bytes added are the bytes the server received',
        );
      },
    );

    test(
      'I-FILE-181: InternetAddress tryParse method. [2026-02-10 06:37] (PASS)',
      () {
        const source = '''
     import 'dart:io';
     main() {
        var validIPv4 = InternetAddress.tryParse('192.168.1.1');
        var validIPv6 = InternetAddress.tryParse('::1');
        var invalid = InternetAddress.tryParse('invalid.ip');

        return [
          validIPv4 != null,
          validIPv6 != null,
          invalid == null
        ];
      }
      ''';
        final result = execute(source);
        expect(result, equals([true, true, true]));
      },
    );

    test(
      'I-FILE-182: InternetAddress type checking. [2026-02-10 06:37] (PASS)',
      () {
        const source = '''
     import 'dart:io';
     main() {
        var ipv4 = InternetAddress.tryParse('127.0.0.1');
        var ipv6 = InternetAddress.tryParse('::1');

        return [
          ipv4.type == InternetAddressType.IPv4,
          ipv6.type == InternetAddressType.IPv6,
          ipv4.isLoopback,
          ipv6.isLoopback
        ];
      }
      ''';
        final result = execute(source);
        expect(result, equals([true, true, true, true]));
      },
    );
  });

  // SCC12: found by giving the member-gap audit a `ServerSocket` recipe. The
  // audit needs an instance to read members off, so it binds a loopback server —
  // and the canonical SDK form of that call was the one that did not work.
  group('ServerSocket.bind address argument', () {
    test('F-SCC12-1: binds when given an InternetAddress, not just a host '
        'string [2026-09-04]', () async {
      // `ServerSocket.bind` takes `dynamic address` precisely so that either a
      // host string or an `InternetAddress` works, and the SDK documentation
      // uses the `InternetAddress` form. The bridge stringified the argument,
      // which turns `InternetAddress.loopbackIPv4` into the literal text
      // `InternetAddress('127.0.0.1', IPv4)` and sends that to the resolver — so
      // the documented form failed with a host-lookup error while the
      // undocumented string form worked.
      const source = '''
     import 'dart:io';
     main() async {
        final server = await ServerSocket.bind(InternetAddress.loopbackIPv4, 0);
        final bound = [server.address.address, server.port > 0];
        await server.close();
        return bound;
      }
      ''';
      final result = await execute(source);
      expect(result, equals(['127.0.0.1', true]));
    });

    test(
      'F-SCC12-2: still binds when given a host string [2026-09-04]',
      () async {
        // The form that already worked, kept so the pass-through fix cannot be
        // mistaken for a swap of one accepted type for the other.
        const source = '''
     import 'dart:io';
     main() async {
        final server = await ServerSocket.bind('127.0.0.1', 0);
        final port = server.port;
        await server.close();
        return port > 0;
      }
      ''';
        final result = await execute(source);
        expect(result, isTrue);
      },
    );
  });
}
