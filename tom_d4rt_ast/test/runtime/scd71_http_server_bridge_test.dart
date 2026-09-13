// SCD71/AST — a real `HttpRequest` resolves to the public bridge, and its
// members answer.
//
// SCD71 reported that an `HttpServer` handler could not read any member of the
// request it was handed — `req.response` failed with "Cannot access property
// 'response' on target of type _HttpRequest" — and diagnosed it as the registry
// being keyed on the public `HttpRequest` while the SDK hands over its private
// `_HttpRequest`.
//
// THE DIAGNOSIS WAS WRONG AND THE DEFECT IS GONE. Measured 2026-09-12: the
// canonical four-line server serves a request end to end in `tom_d4rt`, and
// every member reads. The generic resolution the todo asked for already
// existed, and it is NAME CANONICALISATION rather than anything about types:
// step 3 of `Environment.toBridgedInstance` strips the leading underscore off
// `_HttpRequest` and looks for a bridge whose `name` is the remainder. What was
// actually missing was the bridge itself — `HttpRequest` and `HttpResponse`
// were not bridged AT ALL until SCC62 on 2026-09-06, two days after this todo
// was filed, so there was nothing for the canonicalisation to find.
//
// WHICH STEP RESOLVES IT WAS MEASURED, not read off the comments. The first
// control removed `isAssignable` from the `HttpRequest` bridge, on the
// assumption that step 2's predicate iteration carried this case — every test
// still passed. The predicate is not on this path; the name is. A guard whose
// header explains the wrong mechanism is worse than one that explains none,
// because the next reader trusts it.
//
// SO THIS FILE IS THE HALF SCC62 LEFT. Its script-level coverage is
// `tom_d4rt/test/stdlib/io/http_server_test.dart` (F-SCC62-1..13); the twin got
// the bridges and no test of its own, because a script cannot run against this
// tree (DGUC6 — `tom_d4rt_exec` resolves `tom_d4rt_ast` from pub.dev).
//
// CONTROLS, and they split usefully rather than all firing at once. Removing
// the `HttpRequest` registration fails -1, -2 and -3; removing `HttpResponse`
// fails -2 and -4. Between them every case is covered, and the split is the
// evidence that each case depends on the bridge it is about rather than on a
// shared setup step.
//
// REGISTRATION-LEVEL, BUT WITH A REAL REQUEST. The whole claim is about what
// happens to a native object whose runtime type is private, so a synthetic
// stand-in would test nothing: the test binds an actual `HttpServer` from the
// Dart side, takes the `_HttpRequest` the SDK delivers, and asks this tree's
// registry and adapters about it. That is the same object the interpreter would
// hand a script handler, reached without needing an interpreter.

@TestOn('vm')
library;

import 'dart:async';
import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';

void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    IoStdlib.register(env);
    visitor = InterpreterVisitor(
      globalEnvironment: env,
      moduleContext: AstModuleLoader(
        modules: const {},
        globalEnvironment: env,
        runner: D4rtRunner(),
      ),
    );
  });

  BridgedClass bridge(String name) {
    final b = env.findBridgedClassByName(name);
    expect(b, isNotNull, reason: '$name must be a registered bridge');
    return b!;
  }

  /// Binds a loopback server, makes one request against it, and hands the
  /// `HttpRequest` the SDK delivers to [body] before answering and tearing
  /// everything down.
  Future<T> withRequest<T>(FutureOr<T> Function(HttpRequest) body) async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final delivered = Completer<HttpRequest>();
    server.listen(delivered.complete);
    final client = HttpClient();
    final request = await client.get('127.0.0.1', server.port, '/probe');
    final pending = request.close();
    final received = await delivered.future.timeout(
      const Duration(seconds: 10),
    );
    try {
      return await body(received);
    } finally {
      received.response.close();
      await pending;
      client.close();
      await server.close(force: true);
    }
  }

  group('SCD71/AST: the server-side request bridges answer', () {
    test(
      'F-SCD71-AST-1: a private `_HttpRequest` resolves to the public bridge '
      '[2026-09-12] (PASS)',
      () async {
        // The claim SCD71 was filed about, asked of the registry directly. The
        // object is the SDK's own private implementation; the bridge it must
        // reach is registered under the public interface name.
        await withRequest((request) {
          expect(
            request.runtimeType.toString(),
            startsWith('_'),
            reason:
                'the SDK is expected to hand over a private implementation '
                '— if it stops doing so this test proves nothing',
          );
          final wrapped = env.toBridgedInstance(request);
          expect(wrapped, isNotNull);
          expect(wrapped!.bridgedClass.name, 'HttpRequest');
        });
      },
      timeout: const Timeout(Duration(seconds: 30)),
    );

    test('F-SCD71-AST-2: `response` reads, and is itself bridged '
        '[2026-09-12] (PASS)', () async {
      // `req.response` is the member the todo named, and the one that makes
      // the server usable at all. Reading it is half the answer; the value it
      // returns has to resolve too, or the next line of every handler fails.
      await withRequest((request) {
        final response = bridge('HttpRequest').getters['response']!(
          visitor,
          request,
        );
        expect(response, isA<HttpResponse>());
        expect(response.runtimeType.toString(), startsWith('_'));
        final wrapped = env.toBridgedInstance(response);
        expect(wrapped, isNotNull);
        expect(wrapped!.bridgedClass.name, 'HttpResponse');
      });
    }, timeout: const Timeout(Duration(seconds: 30)));

    test('F-SCD71-AST-3: the other declared getters answer too '
        '[2026-09-12] (PASS)', () async {
      // `response` resolving could be one lucky adapter. These are the
      // members a handler reads before it decides what to do, and each goes
      // through the same private-implementation target.
      await withRequest((request) {
        final requestBridge = bridge('HttpRequest');
        Object? read(String name) =>
            requestBridge.getters[name]!(visitor, request);
        expect(read('method'), 'GET');
        expect(read('uri').toString(), '/probe');
        expect(read('protocolVersion'), isA<String>());
        expect(read('contentLength'), isA<int>());
        expect(read('headers'), isA<HttpHeaders>());
        expect(read('connectionInfo'), isA<HttpConnectionInfo>());
      });
    }, timeout: const Timeout(Duration(seconds: 30)));

    test('F-SCD71-AST-4: the response adapters write through to the wire '
        '[2026-09-12] (PASS)', () async {
      // Reading a member is not answering a request. This drives the response
      // the way a script's handler would — through the bridge adapters, not
      // through the native object — and reads the bytes back off the client.
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => server.close(force: true));
      final responseBridge = bridge('HttpResponse');
      server.listen((request) {
        responseBridge.setters['statusCode']!(visitor, request.response, 201);
        responseBridge.methods['write']!(
          visitor,
          request.response,
          ['served'],
          {},
          [],
        );
        responseBridge.methods['close']!(visitor, request.response, [], {}, []);
      });
      final client = HttpClient();
      addTearDown(client.close);
      final request = await client.get('127.0.0.1', server.port, '/');
      final response = await request.close();
      final bytes = <int>[];
      await for (final chunk in response) {
        bytes.addAll(chunk);
      }
      expect(response.statusCode, 201);
      expect(String.fromCharCodes(bytes), 'served');
    }, timeout: const Timeout(Duration(seconds: 30)));
  });
}
