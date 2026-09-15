// Reading an HTTP response body the way every Dart tutorial shows.
//
//     final body = await response.transform(utf8.decoder).join();
//
// From a script this reported `Runtime Error: transform not yet implemented in
// interpreted environment`, so the only way to read a body was to fold the
// chunks by hand — `toList()`, concatenate, `utf8.decode`. F-SCC74-B10 does
// exactly that, with a comment pointing at this work.
//
// THERE WAS NOTHING TO IMPLEMENT. The `HttpClientResponse` bridge carried a
// local `transform` adapter whose entire body was that throw, above the comment
// "Implementation for transform would be complex, placeholder". But an
// `HttpClientResponse` IS a `Stream<List<int>>`, and the `Stream` bridge's
// `transform` already coerces the transformer and delegates to the native
// method. Deleting the local adapter makes the idiomatic form work; measured
// before the deletion was written, by removing it and re-running the
// reproduction.
//
// So this is SCC51's shape in `dart:io`: a leaf bridge redeclaring a member its
// supertype already supplies, and supplying a WORSE version of it. SCC51 found
// seventeen of these in `dart:collection` — hand-written `first`/`last`/`single`
// that swallowed the SDK's `StateError` — and deleted rather than corrected them,
// because the inherited one was already right. Same remedy here.
//
// THE MESSAGE WAS ALSO WIDER THAN THE DEFECT, which is why the todo behind this
// file was written: "transform not yet implemented in interpreted environment"
// reads as a statement about the interpreter. It was one adapter on one class —
// exactly one site in each tree. `HttpServer.transform` worked the whole time
// (F-SCC74-B13 drives a `WebSocketTransformer` through it) for the same reason
// this one now does: no local adapter shadows the inherited one.
//
// F-SCD187-2 IS THE ONE THAT KEEPS THIS FIXED. A behaviour case proves the
// idiomatic form works today; it does not stop somebody re-adding a local
// adapter tomorrow, which is how the stub got there in the first place.
//
// ABLATED BY RESTORING THE STUB: 4 of the 5 cases go red. The one that does
// not is F-SCD187-4, the hand-folded control — which is precisely what a
// control is for. It reads the body without touching `transform`, so it must
// be indifferent to the adapter, and a control that moved with the subject
// would not be one.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/src/stdlib/io/http.dart';

Future<Object?> _run(String body) async {
  const path = 'd4rt-mem:/scd187_http_response_transform.dart';
  final d4rt = D4rt();
  d4rt.grant(FilesystemPermission.any);
  d4rt.grant(NetworkPermission.any);
  return await d4rt.execute(
    library: path,
    name: 'main',
    sources: {
      path:
          "import 'dart:async';\n"
          "import 'dart:convert';\n"
          "import 'dart:io';\n"
          'Future<Object?> main() async {\n'
          '$body\n'
          '}\n',
    },
  );
}

/// A complete client round trip against a local server, with [read] deciding
/// how the body is taken off the response.
///
/// `force: true` on both closes is load-bearing rather than tidiness: without
/// it `client.close()` waits for idle connections and the test hangs instead of
/// failing, which is how a first attempt at this reproduction was lost.
String _roundTrip(String read, {String body = 'hello world'}) =>
    '''
  final server = await HttpServer.bind('127.0.0.1', 0);
  server.listen((request) {
    request.response.write('$body');
    request.response.close();
  });
  final client = HttpClient();
  final request = await client
      .getUrl(Uri.parse('http://127.0.0.1:' + server.port.toString() + '/'));
  final response = await request.close();
  $read
  client.close(force: true);
  await server.close(force: true);
  return out;
''';

void main() {
  group('SCD187: HttpClientResponse.transform', () {
    test(
      'F-SCD187-1: the idiomatic body read works [2026-09-15] (PASS)',
      () {
        // The reproduction from the todo, verbatim in shape.
        expect(
          _run(
            _roundTrip(
              'final out = await response.transform(utf8.decoder).join();',
            ),
          ),
          completion('hello world'),
        );
      },
      timeout: const Timeout(Duration(seconds: 30)),
    );

    test('F-SCD187-2: the bridge declares no local `transform` [2026-09-15] '
        '(PASS)', () {
      // THE REGRESSION GUARD, and the reason it is structural rather than
      // behavioural. The fix is a DELETION: the inherited `Stream.transform`
      // was always correct and a local adapter can only shadow it. A behaviour
      // case alone would go green again the moment somebody re-added a local
      // adapter that happened to work, and would say nothing about the one
      // that did not.
      final bridge = HttpClientResponseIo.definition;
      expect(
        bridge.methods.keys,
        isNot(contains('transform')),
        reason:
            'HttpClientResponse is a Stream<List<int>> and the Stream bridge '
            'already supplies `transform`. A local adapter here can only '
            'shadow it — which is what reported "transform not yet '
            'implemented in interpreted environment" for as long as it '
            'existed. If a local one is genuinely needed, say why here.',
      );
      // Anti-vacuity: an empty or renamed method map would satisfy the
      // assertion above while measuring nothing.
      expect(bridge.methods.keys, contains('listen'));
    });

    test('F-SCD187-3: transforms chain, so it is the real Stream.transform '
        '[2026-09-15] (PASS)', () {
      // A single `transform` could in principle be special-cased. Chaining a
      // second one onto the result shows the first returned an ordinary
      // `Stream<String>` rather than something that only knows how to `join`.
      expect(
        _run(
          _roundTrip(
            'final out = await response'
            '.transform(utf8.decoder)'
            '.transform(const LineSplitter())'
            '.toList();',
            body: r'first\nsecond',
          ),
        ),
        completion(equals(['first', 'second'])),
      );
    }, timeout: const Timeout(Duration(seconds: 30)));

    test('F-SCD187-4: CONTROL — the hand-folded read still works '
        '[2026-09-15] (PASS)', () {
      // F-SCC74-B10 and anything else written during the outage folds chunks by
      // hand. Deleting the adapter must not disturb that path, and this is what
      // says so — the two reads are different code, not two spellings of one.
      expect(
        _run(
          _roundTrip('''
            final chunks = await response.toList();
            final bytes = <int>[];
            for (final chunk in chunks) { bytes.addAll(chunk); }
            final out = utf8.decode(bytes);
          '''),
        ),
        completion('hello world'),
      );
    }, timeout: const Timeout(Duration(seconds: 30)));

    test('F-SCD187-5: a non-transformer argument is still rejected, by the '
        'inherited adapter [2026-09-15] (PASS)', () {
      // The deletion removes a guard as well as a stub, so the question "what
      // does a bad argument do now" has to be answered rather than assumed.
      // `Stream.transform`'s own check answers it, with the message naming
      // `Stream` rather than `HttpClientResponse` — accurate, since that is the
      // adapter now running.
      expect(
        _run(_roundTrip('final out = await response.transform(42).join();')),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains('StreamTransformer'),
          ),
        ),
      );
    }, timeout: const Timeout(Duration(seconds: 30)));
  });
}
