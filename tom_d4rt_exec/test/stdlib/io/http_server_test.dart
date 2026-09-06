import 'package:test/test.dart';
import '../../interpreter_test.dart';

/// SCC62 — the server half of `dart:io`, and why bridging `HttpServer` alone
/// was not enough to serve a single request.
///
/// `HttpServer` has been bridged for a long time, so a script could bind a
/// port and attach a listener. What it received in that listener had no
/// name: `HttpRequest` was unbridged, so `request.method` failed, and
/// `request.response` — the only way to answer — returned an `HttpResponse`
/// that was likewise unbridged. The bridged server was decorative.
///
/// The other four types in this file are each reached *through* those two —
/// `HttpSession` off `request.session`, `HttpConnectionInfo` off
/// `request.connectionInfo`, `HttpConnectionsInfo` off
/// `server.connectionsInfo()`, and `SameSite` as the value
/// `Cookie.sameSite` already declared it took. Bridging any of them without
/// the request/response pair would have moved the dead end one level down
/// rather than removing it.
///
/// THE CENTREPIECE IS THE ROUND TRIP, not the name resolution. Every getter
/// asserted below could be satisfied by a bridge that never actually reaches
/// the socket; `F-SCC62-1` binds, serves, answers and reads the body back,
/// which is the only assertion here that fails if the stream shape is wrong.
/// The script is both server and client on purpose — driving the client from
/// the host would require knowing the port before the script runs, and a
/// pre-bound-then-released port is a race.
///
/// SANDBOX POSTURE, measured rather than assumed: these bridges do not widen
/// it. `HttpServer.bind` was already bridged and already reachable, so the six
/// types added here only let a script *name* values it was already being
/// handed. What the measurement did surface is that `NetworkPermission` gates
/// exactly one call site in the whole library (`InternetAddress.lookup`) while
/// `bind`, `connect` and the entire `HttpClient` surface sit behind an import
/// gate keyed on `FilesystemPermission`. That is a real gap and a much larger
/// one than this file's subject; it is tracked separately, because a partial
/// gate added here would be bypassable via `ServerSocket` + `HttpServer.listenOn`
/// while looking like the capability was sandboxed.
void main() {
  group('SCC62: a script can serve a request end to end', () {
    test('F-SCC62-1: bind, receive a request, write a response, read it back '
        '[2026-09-06]', () async {
      // The whole todo in one script. Before these bridges the listener body
      // failed on `request.method` — the server bound, accepted the
      // connection, and then could do nothing with it.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        var seen = [];
        server.listen((request) {
          seen.add(request.method);
          seen.add(request.uri.path);
          var response = request.response;
          response.statusCode = HttpStatus.created;
          response.headers.set('x-marker', 'scc62');
          response.write('hello');
          response.close();
        });

        var client = HttpClient();
        var request = await client.getUrl(
          Uri.parse('http://127.0.0.1:' + server.port.toString() + '/greet'));
        var response = await request.close();

        var bytes = [];
        var done = Completer();
        response.listen(
          (chunk) { bytes.addAll(chunk); },
          onDone: () { done.complete(); },
        );
        await done.future;
        await server.close();
        client.close();

        return [
          seen,
          response.statusCode,
          response.headers.value('x-marker'),
          String.fromCharCodes(bytes),
        ];
      }
      ''';
      expect(
        await executeAsync(source),
        equals([
          ['GET', '/greet'],
          201,
          'scc62',
          'hello',
        ]),
      );
    });

    test('F-SCC62-2: the request and response are recognised as their own '
        'types [2026-09-06]', () async {
      // `is` rather than `on`, for the reason SCC61's file header gives: an
      // `on` clause inside an async body currently matches unconditionally, so
      // an `on`-shaped assertion would be green with or without the bridge.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        var kinds = [];
        var handled = Completer();
        server.listen((request) {
          kinds.add(request is HttpRequest);
          kinds.add(request.response is HttpResponse);
          kinds.add(request is HttpResponse);
          request.response.close();
          handled.complete();
        });

        var client = HttpClient();
        var request = await client.getUrl(
          Uri.parse('http://127.0.0.1:' + server.port.toString() + '/'));
        await request.close();
        await handled.future;
        await server.close();
        client.close();
        return kinds;
      }
      ''';
      expect(await executeAsync(source), equals([true, true, false]));
    });
  });

  group('SCC62: the request surface', () {
    test('F-SCC62-3: the declared getters all read [2026-09-06]', () async {
      // A sweep rather than one assertion per getter: an unbridged getter on a
      // bridged class does not fail quietly, it throws, so one script that
      // touches all of them is the same coverage at a fraction of the socket
      // setup. The values are asserted by *shape* where the SDK does not
      // promise a constant — `protocolVersion` is '1.1' for HTTP/1.1 but that
      // is the transport's choice, not this bridge's.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        var out = [];
        var handled = Completer();
        server.listen((request) {
          out.add(request.method);
          out.add(request.uri.path);
          out.add(request.requestedUri.path);
          out.add(request.contentLength);
          out.add(request.protocolVersion);
          out.add(request.persistentConnection);
          out.add(request.headers.value('x-probe'));
          out.add(request.cookies.length);
          out.add(request.certificate == null);
          request.response.close();
          handled.complete();
        });

        var client = HttpClient();
        var request = await client.getUrl(
          Uri.parse('http://127.0.0.1:' + server.port.toString() + '/probe'));
        request.headers.set('x-probe', 'yes');
        await request.close();
        await handled.future;
        await server.close();
        client.close();
        return out;
      }
      ''';
      expect(
        await executeAsync(source),
        equals([
          'GET',
          '/probe',
          '/probe',
          // -1, not 0: the SDK reports an ABSENT Content-Length as unknown, and
          // a GET carries no body. Asserting the SDK's value rather than the
          // intuitive one is the point — a bridge that quietly normalised it
          // would be lying about the request.
          -1,
          '1.1',
          true,
          'yes',
          0,
          // No `SecurityContext` on a plain loopback bind, so this is the
          // reachable half of the getter. That it returns null rather than
          // throwing is the assertion.
          true,
        ]),
      );
    });

    test('F-SCC62-4: the request body is a stream the script can drain '
        '[2026-09-06]', () async {
      // `HttpRequest implements Stream<Uint8List>`, and the todo asks for the
      // stream shape verified rather than assumed. This is the inbound half —
      // `F-SCC62-1` covers the outbound one.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        var body = [];
        var handled = Completer();
        server.listen((request) {
          request.listen(
            (chunk) { body.addAll(chunk); },
            onDone: () {
              request.response.close();
              handled.complete();
            },
          );
        });

        var client = HttpClient();
        var request = await client.postUrl(
          Uri.parse('http://127.0.0.1:' + server.port.toString() + '/'));
        request.write('payload');
        await request.close();
        await handled.future;
        await server.close();
        client.close();
        return String.fromCharCodes(body);
      }
      ''';
      expect(await executeAsync(source), equals('payload'));
    });
  });

  group('SCC62: the response surface', () {
    test('F-SCC62-5: the mutable fields round-trip [2026-09-06]', () async {
      // Setters, not just getters. `HttpResponse` is the one type here whose
      // whole point is being written to, and a bridge with getters alone would
      // satisfy every name-resolution assertion while leaving it read-only.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        var out = [];
        var handled = Completer();
        server.listen((request) {
          var r = request.response;
          out.add(r.statusCode);
          r.statusCode = HttpStatus.accepted;
          r.reasonPhrase = 'Sure';
          r.bufferOutput = false;
          r.persistentConnection = false;
          r.contentLength = 2;
          r.deadline = Duration(seconds: 30);
          out.add(r.statusCode);
          out.add(r.reasonPhrase);
          out.add(r.bufferOutput);
          out.add(r.persistentConnection);
          out.add(r.contentLength);
          out.add(r.deadline.inSeconds);
          out.add(r.cookies.length);
          r.write('ok');
          r.close();
          handled.complete();
        });

        var client = HttpClient();
        var request = await client.getUrl(
          Uri.parse('http://127.0.0.1:' + server.port.toString() + '/'));
        var response = await request.close();
        await handled.future;
        out.add(response.statusCode);
        out.add(response.reasonPhrase);
        await server.close();
        client.close();
        return out;
      }
      ''';
      expect(
        await executeAsync(source),
        equals([
          // The SDK default before anything is written.
          200,
          202, 'Sure', false, false, 2, 30, 0,
          // What the client actually received — the setters reached the wire,
          // they did not merely stick to the bridged object.
          202, 'Sure',
        ]),
      );
    });

    test('F-SCC62-6: an IOSink write of bytes reaches the client '
        '[2026-09-06]', () async {
      // `HttpResponse implements IOSink`, so `add`/`writeln`/`writeAll` are
      // part of its surface and not decoration. Covering them together with
      // `write` (already in F-SCC62-1) is what pins the whole sink.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        server.listen((request) {
          var r = request.response;
          r.add([104, 105]);
          r.writeAll(['a', 'b'], '-');
          r.close();
        });

        var client = HttpClient();
        var request = await client.getUrl(
          Uri.parse('http://127.0.0.1:' + server.port.toString() + '/'));
        var response = await request.close();
        var bytes = [];
        var done = Completer();
        response.listen(
          (chunk) { bytes.addAll(chunk); },
          onDone: () { done.complete(); },
        );
        await done.future;
        await server.close();
        client.close();
        return String.fromCharCodes(bytes);
      }
      ''';
      expect(await executeAsync(source), equals('hia-b'));
    });

    test('F-SCC62-7: redirect() sends a Location the client follows '
        '[2026-09-06]', () async {
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        server.listen((request) {
          if (request.uri.path == '/from') {
            request.response.redirect(
              Uri.parse('http://127.0.0.1:' + server.port.toString() + '/to'));
          } else {
            request.response.write('arrived');
            request.response.close();
          }
        });

        var client = HttpClient();
        var request = await client.getUrl(
          Uri.parse('http://127.0.0.1:' + server.port.toString() + '/from'));
        var response = await request.close();
        var bytes = [];
        var done = Completer();
        response.listen(
          (chunk) { bytes.addAll(chunk); },
          onDone: () { done.complete(); },
        );
        await done.future;
        await server.close();
        client.close();
        return [response.statusCode, String.fromCharCodes(bytes)];
      }
      ''';
      expect(await executeAsync(source), equals([200, 'arrived']));
    });
  });

  group('SCC62: the connection and session types hanging off a request', () {
    test('F-SCC62-8: connectionInfo names the peer [2026-09-06]', () async {
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        var out = [];
        var handled = Completer();
        server.listen((request) {
          var info = request.connectionInfo;
          out.add(info is HttpConnectionInfo);
          out.add(info.remoteAddress.address);
          out.add(info.localPort == server.port);
          out.add(info.remotePort > 0);
          request.response.close();
          handled.complete();
        });

        var client = HttpClient();
        var request = await client.getUrl(
          Uri.parse('http://127.0.0.1:' + server.port.toString() + '/'));
        await request.close();
        await handled.future;
        await server.close();
        client.close();
        return out;
      }
      ''';
      expect(
        await executeAsync(source),
        equals([true, '127.0.0.1', true, true]),
      );
    });

    test('F-SCC62-9: connectionsInfo counts the live connections '
        '[2026-09-06]', () async {
      // The counters are read while a connection is genuinely open, so `total`
      // is asserted as non-zero rather than as a fixed number — how the SDK
      // apportions it between active and idle is its business and not
      // something this bridge should pin.
      const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        var out = [];
        var handled = Completer();
        server.listen((request) {
          var info = server.connectionsInfo();
          out.add(info is HttpConnectionsInfo);
          out.add(info.total > 0);
          out.add(info.total == info.active + info.idle + info.closing);
          request.response.close();
          handled.complete();
        });

        var client = HttpClient();
        var request = await client.getUrl(
          Uri.parse('http://127.0.0.1:' + server.port.toString() + '/'));
        await request.close();
        await handled.future;
        await server.close();
        client.close();
        return out;
      }
      ''';
      expect(await executeAsync(source), equals([true, true, true]));
    });

    test(
      'F-SCC62-10: the session is readable and destroyable [2026-09-06]',
      () async {
        // `HttpSession implements Map`, which is why `[]` and `[]=` are bridged
        // alongside the four declared members: a session with an id and no way to
        // store anything against it is the same dead end one level down that this
        // todo exists to remove.
        const source = '''
      import 'dart:io';
      import 'dart:async';
      main() async {
        var server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
        var out = [];
        var handled = Completer();
        server.listen((request) {
          var session = request.session;
          out.add(session is HttpSession);
          out.add(session.id.length > 0);
          out.add(session.isNew);
          session['visits'] = 1;
          out.add(session['visits']);
          out.add(session.containsKey('visits'));
          session.destroy();
          request.response.close();
          handled.complete();
        });

        var client = HttpClient();
        var request = await client.getUrl(
          Uri.parse('http://127.0.0.1:' + server.port.toString() + '/'));
        await request.close();
        await handled.future;
        await server.close();
        client.close();
        return out;
      }
      ''';
        expect(await executeAsync(source), equals([true, true, true, 1, true]));
      },
    );
  });

  group('SCC62: SameSite', () {
    test('F-SCC62-11: the three constants are named values, not an enum '
        '[2026-09-06]', () {
      // The todo called SameSite an enum. It is not: the SDK declares
      // `final class SameSite` with a private constructor and three static
      // consts, exactly like `Endian`. Bridging it as a `BridgedEnumDefinition`
      // would have given it `index` and `values` semantics it does not have and
      // lost `toString`, which is the wire form.
      const source = '''
      import 'dart:io';
      main() {
        return [
          SameSite.lax.name,
          SameSite.strict.name,
          SameSite.none.name,
          SameSite.values.length,
          SameSite.lax.toString(),
          identical(SameSite.lax, SameSite.values[0]),
        ];
      }
      ''';
      expect(
        execute(source),
        equals(['Lax', 'Strict', 'None', 3, 'SameSite=Lax', true]),
      );
    });

    test('F-SCC62-12: Cookie.sameSite round-trips [2026-09-06]', () {
      // `CookieIo` has declared this getter and setter all along, so before the
      // bridge the getter returned a value with no name and the setter could
      // not be called with anything but null — a property that looked complete
      // from the bridge listing and was unusable from a script.
      const source = '''
      import 'dart:io';
      main() {
        var c = Cookie('sid', 'abc');
        var before = c.sameSite == null;
        c.sameSite = SameSite.strict;
        return [before, c.sameSite.name, c.toString().contains('SameSite=Strict')];
      }
      ''';
      expect(execute(source), equals([true, 'Strict', true]));
    });

    test('F-SCC62-13: a SameSite parsed off the wire is recognised '
        '[2026-09-06]', () {
      // The value arrives from a native call rather than from a script-side
      // constant, which is the case `isAssignable` exists for.
      const source = '''
      import 'dart:io';
      main() {
        var c = Cookie.fromSetCookieValue('sid=abc; SameSite=None');
        return [c.sameSite is SameSite, c.sameSite.name];
      }
      ''';
      expect(execute(source), equals([true, 'None']));
    });
  });
}
