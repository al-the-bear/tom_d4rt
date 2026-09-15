@Timeout(Duration(minutes: 2))
library;

import 'package:test/test.dart';

import '../../interpreter_test.dart';

/// SCD44 — a script can drive an outbound HTTP request end to end.
///
/// SCC12 could measure neither `HttpClientRequest` nor `HttpHeaders`, and
/// recorded both as unverifiable rather than leaving them silently unmeasured.
/// The stated reason was that the value `HttpClient.getUrl` yields arrives
/// bridged as its `IOSink` supertype, so every `HttpClientRequest` member reads
/// as undefined whatever the adapter map contains.
///
/// **That is no longer true, and the mechanism is worth naming** because the
/// same shape will come up again. Bridge selection resolves `_HttpClientRequest`
/// to `HttpClientRequest` by the `_Foo -> Foo` name canonicalization in
/// `Environment`, which runs BEFORE any ancestor or `isAssignable` scan — so a
/// registered bridge whose private SDK implementation class differs only by the
/// leading underscore is found directly, and a registered ANCESTOR never gets
/// the chance to claim it. `HttpSession`'s bridge already documents the same
/// rule. Confirmed by disabling the SCC49 structural suffix fallback and
/// re-running this round trip: it still passes, so that is not what carries it
/// either.
///
/// This test is the acceptance criterion the todo asked for: it was impossible
/// to write, and writing it is what says the class is usable rather than merely
/// registered. It is also what makes the two audit recipes trustworthy — the
/// recipes obtain an instance, this proves the instance is the right kind.
void main() {
  group('SCD44: an outbound HTTP request round trip', () {
    test('F-SCD44-1: a script reads headers, sets one, and closes the request '
        '[2026-09-12]', () async {
      // A real loopback round trip, with the server in the same script, which
      // is the shape the audit recipes use. Every step is a `HttpClientRequest`
      // or `HttpHeaders` member: if the value were bridged as `IOSink`, the
      // `headers` read alone would fail.
      const source = '''
        import 'dart:io';
        Future<dynamic> main() async {
          final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
          final log = [];
          server.listen((req) async {
            log.add('server-saw:' + (req.headers.value('x-probe') ?? 'none'));
            req.response.write('pong');
            await req.response.close();
          });
          try {
            final client = HttpClient();
            final request = await client.getUrl(
                Uri.parse('http://127.0.0.1:\${server.port}/audit'));
            request.headers.set('x-probe', 'yes');
            log.add('header-read:' + (request.headers.value('x-probe') ?? 'none'));
            final response = await request.close();
            log.add('status:' + response.statusCode.toString());
            client.close();
          } finally {
            await server.close(force: true);
          }
          return log;
        }
      ''';
      expect(
        await executeAsync(source),
        orderedEquals(['header-read:yes', 'server-saw:yes', 'status:200']),
      );
    });

    test('F-SCD44-2: the request is not bridged as its IOSink supertype '
        '[2026-09-12]', () async {
      // The defect stated directly, so a regression names itself rather than
      // presenting as "some HttpClientRequest member stopped working". `close`
      // is declared by `HttpClientRequest` and NOT by `IOSink`, which returns
      // `Future<void>`; reading the response's status is what proves which
      // bridge answered.
      const source = '''
        import 'dart:io';
        Future<dynamic> main() async {
          final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
          server.listen((req) async { await req.response.close(); });
          try {
            final client = HttpClient();
            final request = await client.getUrl(
                Uri.parse('http://127.0.0.1:\${server.port}/audit'));
            // `headers` exists on HttpClientRequest and not on IOSink.
            final hasHeaders = request.headers != null;
            final response = await request.close();
            client.close();
            return [hasHeaders, response.statusCode];
          } finally {
            await server.close(force: true);
          }
        }
      ''';
      expect(await executeAsync(source), orderedEquals([true, 200]));
    });
  });

  /// SCD45 — the response half of the same round trip.
  ///
  /// `HttpClientResponse` carried an audit exemption for a release saying that
  /// obtaining an instance needs a completed HTTP round trip which "does not
  /// finish inside the interpreter — the probe hangs rather than answering".
  /// It does finish. Measured under a wall clock, the round trip below returns
  /// in well under a second, and all 35 of the class's audit candidates turn
  /// out to be reachable through the `Stream<List<int>>` it implements.
  ///
  /// These cases exist because the exemption was wrong and nobody retested it.
  /// A stated reason is a claim about the system, and this one outlived its
  /// cause by long enough to keep 35 members unmeasured — so the response path
  /// gets an executable claim rather than a prose one.
  group('SCD45: the response side of the round trip', () {
    test('F-SCD45-1: a script reads status, headers and body from the '
        'response [2026-09-12]', () async {
      const source = '''
        import 'dart:io';
        Future<dynamic> main() async {
          final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
          server.listen((r) async {
            r.response.write('pong');
            await r.response.close();
          });
          final client = HttpClient();
          try {
            final request = await client.getUrl(
                Uri.parse('http://127.0.0.1:\${server.port}/audit'));
            final response = await request.close();
            // A member of its own, a member of HttpHeaders, and a member it
            // inherits from Stream — the three routes a script can take into
            // this value, and the Stream route is the one all 35 audit
            // candidates use.
            final chunks = await response.toList();
            return [
              response.statusCode,
              response.reasonPhrase,
              response.headers != null,
              chunks.isNotEmpty,
            ];
          } finally {
            client.close(force: true);
            await server.close(force: true);
          }
        }
      ''';
      expect(
        await executeAsync(source),
        orderedEquals([200, 'OK', true, true]),
      );
    });

    test('F-SCD45-2: the response is not bridged as a bare Stream '
        '[2026-09-12]', () async {
      // `statusCode` is declared by `HttpClientResponse` and not by `Stream`,
      // so reading it is what says which bridge answered. Stated directly so a
      // regression names itself, exactly as F-SCD44-2 does for the request.
      const source = '''
        import 'dart:io';
        Future<dynamic> main() async {
          final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
          server.listen((r) async { await r.response.close(); });
          final client = HttpClient();
          try {
            final request = await client.getUrl(
                Uri.parse('http://127.0.0.1:\${server.port}/audit'));
            final response = await request.close();
            return [response.statusCode, response.isRedirect];
          } finally {
            client.close(force: true);
            await server.close(force: true);
          }
        }
      ''';
      expect(await executeAsync(source), orderedEquals([200, false]));
    });
  });
}
