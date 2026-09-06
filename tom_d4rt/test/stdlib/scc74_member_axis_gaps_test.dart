// SCC74 — the members the method/static axis of the coverage audit reported
// unreachable.
//
// SCC73's guard covers constructors and instance getters. It cannot cover
// methods or statics, because those need arguments and because inheritance
// makes a declared-member diff meaningless for them — which is why the method
// axis is measured by `tool/stdlib_member_diff.dart` instead, probing each
// candidate through a real instance.
//
// That tool reported 13 confirmed-unreachable members. Eight are closed and
// exercised here; five are recorded decisions rather than defects and are
// pinned by `intentionally_unbridged_test.dart` instead.
//
// WHY THESE CASES EXIST ON TOP OF THE AUDIT. The audit asks whether a member
// RESOLVES — it reads it and classifies the error, so an adapter that resolves
// and then returns the wrong thing satisfies it completely. `Runes.iterator`
// made that concrete during SCC73: registered as a method, it resolved fine and
// handed back the bound callable instead of the iterator. Reachability and
// correctness are different questions and only one of them is mechanical.

@Timeout(Duration(minutes: 2))
library;

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Future<Object?> _run(String body) async {
  const path = 'd4rt-mem:/scc74_behaviour.dart';
  final d4rt = D4rt();
  d4rt.grant(FilesystemPermission.any);
  d4rt.grant(NetworkPermission.any);
  return await d4rt.execute(
    library: path,
    name: 'main',
    sources: {
      path:
          "import 'dart:async';\n"
          "import 'dart:collection';\n"
          "import 'dart:convert';\n"
          "import 'dart:io';\n"
          'Future<Object?> main() async {\n'
          '$body\n'
          '}\n',
    },
  );
}

void main() {
  group('SCC74: dart:collection', () {
    test('F-SCC74-B1: LinkedListEntry.insertAfter places the entry after the '
        'target [2026-09-06]', () async {
      expect(
        await _run('''
          final list = LinkedList();
          final a = LinkedListEntry('a');
          final c = LinkedListEntry('c');
          list.add(a);
          list.add(c);
          a.insertAfter(LinkedListEntry('b'));
          return list.map((e) => e.value).toList();
        '''),
        equals(['a', 'b', 'c']),
      );
    });

    test('F-SCC74-B2: LinkedListEntry.insertBefore places the entry before the '
        'target [2026-09-06]', () async {
      expect(
        await _run('''
          final list = LinkedList();
          final a = LinkedListEntry('a');
          final c = LinkedListEntry('c');
          list.add(a);
          list.add(c);
          c.insertBefore(LinkedListEntry('b'));
          return list.map((e) => e.value).toList();
        '''),
        equals(['a', 'b', 'c']),
      );
    });

    test('F-SCC74-B3: insertAfter names what it wanted when given a non-entry '
        '[2026-09-06]', () async {
      await expectLater(
        _run('''
          final list = LinkedList();
          final a = LinkedListEntry('a');
          list.add(a);
          a.insertAfter('not an entry');
          return null;
        '''),
        throwsA(
          isA<Object>().having(
            (e) => e.toString(),
            'toString',
            contains('LinkedListEntry.insertAfter'),
          ),
        ),
      );
    });
  });

  group('SCC74: dart:core', () {
    test('F-SCC74-B4: Object.noSuchMethod throws for an Invocation nothing '
        'handles [2026-09-06]', () async {
      // The native contract. It matters because an interpreted class overriding
      // noSuchMethod reaches this through `super.noSuchMethod(invocation)` when
      // it decides not to handle a call, and without the adapter that
      // super-call has nowhere to go.
      await expectLater(
        _run('''
          final invocation = Invocation.method(#absent, const []);
          return Object().noSuchMethod(invocation);
        '''),
        throwsA(isA<Object>()),
      );
    });

    test('F-SCC74-B5: Object.noSuchMethod rejects a non-Invocation argument '
        '[2026-09-06]', () async {
      await expectLater(
        _run("return Object().noSuchMethod('nope');"),
        throwsA(
          isA<Object>().having(
            (e) => e.toString(),
            'toString',
            allOf(contains('noSuchMethod'), contains('Invocation')),
          ),
        ),
      );
    });
  });

  group('SCC74: dart:convert', () {
    test('F-SCC74-B6: StringConversionSink.asUtf8Sink accepts bytes and '
        'forwards the decoded string [2026-09-06]', () async {
      expect(
        await _run('''
          final seen = <String>[];
          final sink = StringConversionSink.withCallback((s) => seen.add(s));
          final bytes = sink.asUtf8Sink(false);
          bytes.add([104, 105]);
          bytes.close();
          return seen;
        '''),
        equals(['hi']),
      );
    });

    test('F-SCC74-B7: asUtf8Sink requires its allowMalformed flag '
        '[2026-09-06]', () async {
      await expectLater(
        _run('''
          final sink = StringConversionSink.withCallback((s) {});
          return sink.asUtf8Sink();
        '''),
        throwsA(
          isA<Object>().having(
            (e) => e.toString(),
            'toString',
            contains('asUtf8Sink'),
          ),
        ),
      );
    });
  });

  group('SCC74: dart:io', () {
    test('F-SCC74-B8: stdout.lineTerminator reads, and round-trips a legal '
        'value [2026-09-06]', () async {
      // Written back to whatever it already was: this is the process's real
      // stdout, and a test that left it on "\r\n" would change how every later
      // suite in the same run prints.
      expect(
        await _run(r'''
          final original = stdout.lineTerminator;
          stdout.lineTerminator = original;
          return [original, stdout.lineTerminator, original == '\n' || original == '\r\n'];
        '''),
        equals([stdout.lineTerminator, stdout.lineTerminator, true]),
      );
    });

    test('F-SCC74-B9: stdout.lineTerminator rejects anything but the two legal '
        'values [2026-09-06]', () async {
      // The SDK asserts on this, and an assert is stripped in a release build —
      // so the guard is what makes the contract hold for a script.
      await expectLater(
        _run("stdout.lineTerminator = 'x'; return null;"),
        throwsA(
          isA<Object>().having(
            (e) => e.toString(),
            'toString',
            contains('lineTerminator'),
          ),
        ),
      );
    });

    test('F-SCC74-B10: HttpClient.connectionFactory routes the connection '
        'through a script-supplied task [2026-09-06]', () async {
      // The strongest of these cases: the callback is stored and invoked later
      // by native code, so it exercises the deferred-callback binding rather
      // than just the assignment.
      final result = await _run('''
        final server = await HttpServer.bind('127.0.0.1', 0);
        server.listen((request) {
          request.response.write('routed');
          request.response.close();
        });
        var called = 0;
        final client = HttpClient();
        client.connectionFactory = (uri, proxyHost, proxyPort) {
          called = called + 1;
          return Socket.startConnect('127.0.0.1', server.port);
        };
        final request =
            await client.getUrl(Uri.parse('http://127.0.0.1:1/ignored'));
        final response = await request.close();
        // Read by folding the chunks rather than with
        // `response.transform(utf8.decoder)`: `transform` on an
        // `HttpClientResponse` reports "not yet implemented in interpreted
        // environment", which is a separate gap from this one and is filed as
        // its own todo. Folding measures the same thing without depending on
        // it.
        final chunks = await response.toList();
        final bytes = <int>[];
        for (final chunk in chunks) {
          bytes.addAll(chunk);
        }
        final body = utf8.decode(bytes);
        client.close(force: true);
        await server.close(force: true);
        return [body, called];
      ''');
      expect(result, equals(['routed', 1]));
    });

    test('F-SCC74-B11: connectionFactory accepts null to restore the default, '
        'and rejects a non-function [2026-09-06]', () async {
      expect(
        await _run('''
          final client = HttpClient();
          client.connectionFactory = null;
          client.close();
          return 'cleared';
        '''),
        equals('cleared'),
      );
      await expectLater(
        _run('''
          final client = HttpClient();
          client.connectionFactory = 42;
          return null;
        '''),
        throwsA(
          isA<Object>().having(
            (e) => e.toString(),
            'toString',
            contains('connectionFactory'),
          ),
        ),
      );
    });

    test('F-SCC74-B12: HttpClient.authenticateProxy takes a callback and null '
        '[2026-09-06]', () async {
      // The hook only fires behind a proxy issuing a 407, which a unit test
      // cannot stage without one. What is checkable here is the half that was
      // actually broken: the assignment itself threw, so no script could reach
      // the hook at all.
      expect(
        await _run('''
          final client = HttpClient();
          client.authenticateProxy = (host, port, scheme, realm) async => false;
          client.authenticateProxy = null;
          client.close();
          return 'assigned';
        '''),
        equals('assigned'),
      );
      await expectLater(
        _run('''
          final client = HttpClient();
          client.authenticateProxy = 'nope';
          return null;
        '''),
        throwsA(
          isA<Object>().having(
            (e) => e.toString(),
            'toString',
            contains('authenticateProxy'),
          ),
        ),
      );
    });

    test('F-SCC74-B13: WebSocketTransformer.cast yields a transformer that '
        'still upgrades [2026-09-06]', () async {
      final result = await _run('''
        final server = await HttpServer.bind('127.0.0.1', 0);
        final port = server.port;
        final transformer = WebSocketTransformer().cast();
        server.transform(transformer).listen((socket) {
          socket.add('from-server');
          socket.close();
        });
        final client = await WebSocket.connect('ws://127.0.0.1:\$port/');
        final message = await client.first;
        await client.close();
        await server.close(force: true);
        return message;
      ''');
      expect(result, equals('from-server'));
    });
  });
}
