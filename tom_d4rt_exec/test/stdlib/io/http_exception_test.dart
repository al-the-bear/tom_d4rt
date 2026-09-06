import 'dart:io';

import 'package:test/test.dart';
import '../../interpreter_test.dart';

/// SCC61 — the `dart:io` exception names, and why an unbridged one is worse
/// than an unbridged anything else.
///
/// An unbridged name normally fails LOUDLY: `HttpStatus.notFound` raised
/// `Undefined variable: HttpStatus`, which a script author reads and acts on.
/// A catch clause does not have that property. `_valueHasType` reports a failed
/// type lookup by throwing, and `visitTryStatement` deliberately reads that
/// throw as "this clause does not match" — it has to, because letting it escape
/// would replace the exception being dispatched with a lookup failure and lose
/// the original. The consequence is that `on HttpException catch (e) { … }`
/// around an unbridged `HttpException` is not an error, it is DEAD CODE that
/// looks correct, and the exception travels straight past it.
///
/// That was measurable before this bridge existed and is what the first group
/// pins. The second group covers the same failure one level up: `IOException`
/// was already declared to the supertype registry (so `FileSystemException`
/// could reach `Exception` truthfully) but was never bridged as a class, so
/// `on IOException catch` silently missed a thrown `FileSystemException` while
/// `on Exception catch` caught it. A handler that gets *less* specific and
/// starts working is the signature of this defect.
///
/// The third group is the constants holder, bundled here because it is trivial
/// and is reached for constantly next to exception handling.
///
/// NOT PINNED HERE, deliberately: inside an `async` function the catch clause
/// type is ignored entirely — `_handleAsyncError` takes `catchClauses.first`
/// with an explicit "simplified" note — so `on String catch` catches a
/// `FormatException`. That is a much larger defect than this file's subject and
/// it is the OPPOSITE failure (over-match, not miss). It is tracked separately
/// rather than pinned, because an assertion written against today's behaviour
/// would be something to delete rather than repair. It is also why
/// `F-SCC61-13` below reaches for `is` inside a bare `catch` instead of an
/// `on HttpException` clause: an `on` clause in an async body would pass that
/// test whether or not the bridge exists.
void main() {
  group('SCC61: the HTTP exception types are nameable and catchable', () {
    test('F-SCC61-1: HttpException constructs and exposes message/uri '
        '[2026-09-06]', () {
      const source = '''
      import 'dart:io';
      main() {
        var e = HttpException('boom', uri: Uri.parse('http://x/y'));
        return [e.message, e.uri.toString()];
      }
      ''';
      expect(execute(source), equals(['boom', 'http://x/y']));
    });

    test(
      'F-SCC61-2: the uri is optional and defaults to null [2026-09-06]',
      () {
        const source = '''
      import 'dart:io';
      main() {
        var e = HttpException('boom');
        return [e.message, e.uri == null, e.toString()];
      }
      ''';
        expect(execute(source), equals(['boom', true, 'HttpException: boom']));
      },
    );

    test('F-SCC61-3: `on HttpException catch` matches a thrown HttpException '
        '[2026-09-06]', () {
      // The case the whole todo is named after. Before the bridge this returned
      // 'other' — the specific handler was skipped and the general one ran.
      const source = '''
      import 'dart:io';
      main() {
        try {
          throw HttpException('boom');
        } on HttpException catch (e) {
          return 'http:' + e.message;
        } catch (e) {
          return 'other';
        }
      }
      ''';
      expect(execute(source), equals('http:boom'));
    });

    test('F-SCC61-4: RedirectException constructs and exposes its fields '
        '[2026-09-06]', () {
      // `redirects` is a `List<RedirectInfo>`, and `RedirectInfo` is not bridged
      // (tracked with the rest of the client-side leftovers), so an empty list
      // is the only one a script can build today. The getter is bridged anyway
      // because a natively-thrown RedirectException carries a populated one.
      const source = '''
      import 'dart:io';
      main() {
        var e = RedirectException('too many', []);
        return [e.message, e.redirects.length, e.uri == null, e.toString()];
      }
      ''';
      expect(
        execute(source),
        equals(['too many', 0, true, 'RedirectException: too many']),
      );
    });

    test('F-SCC61-5: `on HttpException catch` matches a thrown '
        'RedirectException [2026-09-06]', () {
      // `class RedirectException implements HttpException` — the registry edge,
      // not the `isAssignable` predicate, is what has to answer this.
      const source = '''
      import 'dart:io';
      main() {
        try {
          throw RedirectException('too many', []);
        } on HttpException catch (e) {
          return 'http';
        } catch (e) {
          return 'other';
        }
      }
      ''';
      expect(execute(source), equals('http'));
    });

    test('F-SCC61-6: the type tests agree with the catch clauses '
        '[2026-09-06]', () {
      // `on T` and `is T` go through one predicate since SCC20. Asserted rather
      // than assumed, because a bridge can satisfy one and not the other: the
      // `is` side reaches `isAssignable` for an unwrapped native operand, the
      // catch side arrives wrapped and consults the registry first.
      const source = '''
      import 'dart:io';
      main() {
        var h = HttpException('a');
        var r = RedirectException('b', []);
        return [
          h is HttpException, h is IOException, h is Exception,
          r is RedirectException, r is HttpException, r is IOException,
          h is RedirectException,
        ];
      }
      ''';
      expect(
        execute(source),
        equals([true, true, true, true, true, true, false]),
      );
    });
  });

  group('SCC61: IOException is a catchable class, not just a registry edge', () {
    // The same silent miss one level up, and it was live for every bridged
    // dart:io exception rather than only the unbridged ones. `IOException` was
    // declared to the supertype registry so `FileSystemException` could reach
    // `Exception` truthfully, but nothing bridged the class — so the name could
    // not resolve, and `on IOException catch` matched nothing at all.
    const thrown = <String, String>{
      'FileSystemException': "FileSystemException('boom')",
      'SocketException': "SocketException('boom')",
      'HttpException': "HttpException('boom')",
      'RedirectException': "RedirectException('boom', [])",
    };

    for (final entry in thrown.entries) {
      test('F-SCC61-7-${entry.key}: `on IOException catch` matches a thrown '
          '${entry.key} [2026-09-06]', () {
        final source =
            '''
        import 'dart:io';
        main() {
          try {
            throw ${entry.value};
          } on IOException catch (e) {
            return 'io';
          } catch (e) {
            return 'other';
          }
        }
        ''';
        expect(execute(source), equals('io'));
      });

      test('F-SCC61-8-${entry.key}: ${entry.key} answers `is IOException` '
          '[2026-09-06]', () {
        final source =
            '''
        import 'dart:io';
        main() { return [${entry.value} is IOException, 1 is IOException]; }
        ''';
        expect(execute(source), equals([true, false]));
      });
    }

    test('F-SCC61-9: a more specific clause still wins over IOException '
        '[2026-09-06]', () {
      // Bridging a base type is the move that can steal dispatch from its own
      // subtypes — `IOExceptionIo` carries an `isAssignable` that answers true
      // for every value below it. The registry edges are what keep
      // `_filterToMostSpecific` preferring the leaf; this asserts the outcome
      // rather than the mechanism.
      const source = '''
      import 'dart:io';
      main() {
        try {
          throw FileSystemException('boom', '/tmp/x');
        } on FileSystemException catch (e) {
          return 'fs:' + e.path;
        } on IOException catch (e) {
          return 'io';
        }
      }
      ''';
      expect(execute(source), equals('fs:/tmp/x'));
    });

    test('F-SCC61-10: member dispatch still reaches the subclass getters '
        '[2026-09-06]', () {
      // The other half of the same risk: if the IOException bridge claimed the
      // value, `osError` and `path` would stop resolving.
      const source = '''
      import 'dart:io';
      main() {
        var e = SocketException('boom', port: 42);
        return [e.message, e.port];
      }
      ''';
      expect(execute(source), equals(['boom', 42]));
    });
  });

  group('SCC61: HttpStatus is a reachable constants holder', () {
    // A table rather than a spot check: the bridge is 70 hand-written getters
    // and a typo in any one of them is a wrong number, not an error.
    const expected = <String, int>{
      'continue_': 100,
      'switchingProtocols': 101,
      'processing': 102,
      'ok': 200,
      'created': 201,
      'accepted': 202,
      'nonAuthoritativeInformation': 203,
      'noContent': 204,
      'resetContent': 205,
      'partialContent': 206,
      'multiStatus': 207,
      'alreadyReported': 208,
      'imUsed': 226,
      'multipleChoices': 300,
      'movedPermanently': 301,
      'found': 302,
      'movedTemporarily': 302,
      'seeOther': 303,
      'notModified': 304,
      'useProxy': 305,
      'temporaryRedirect': 307,
      'permanentRedirect': 308,
      'badRequest': 400,
      'unauthorized': 401,
      'paymentRequired': 402,
      'forbidden': 403,
      'notFound': 404,
      'methodNotAllowed': 405,
      'notAcceptable': 406,
      'proxyAuthenticationRequired': 407,
      'requestTimeout': 408,
      'conflict': 409,
      'gone': 410,
      'lengthRequired': 411,
      'preconditionFailed': 412,
      'requestEntityTooLarge': 413,
      'requestUriTooLong': 414,
      'unsupportedMediaType': 415,
      'requestedRangeNotSatisfiable': 416,
      'expectationFailed': 417,
      'misdirectedRequest': 421,
      'unprocessableEntity': 422,
      'locked': 423,
      'failedDependency': 424,
      'upgradeRequired': 426,
      'preconditionRequired': 428,
      'tooManyRequests': 429,
      'requestHeaderFieldsTooLarge': 431,
      'connectionClosedWithoutResponse': 444,
      'unavailableForLegalReasons': 451,
      'clientClosedRequest': 499,
      'internalServerError': 500,
      'notImplemented': 501,
      'badGateway': 502,
      'serviceUnavailable': 503,
      'gatewayTimeout': 504,
      'httpVersionNotSupported': 505,
      'variantAlsoNegotiates': 506,
      'insufficientStorage': 507,
      'loopDetected': 508,
      'notExtended': 510,
      'networkAuthenticationRequired': 511,
      'networkConnectTimeoutError': 599,
    };

    test('F-SCC61-11: every HttpStatus constant carries the SDK value '
        '[2026-09-06]', () {
      final names = expected.keys.toList();
      final source =
          '''
      import 'dart:io';
      main() { return [${names.map((n) => 'HttpStatus.$n').join(', ')}]; }
      ''';
      expect(execute(source), equals(names.map((n) => expected[n]).toList()));
    });

    test('F-SCC61-12: the constants are usable against a live status code '
        '[2026-09-06]', () {
      const source = '''
      import 'dart:io';
      main() {
        var code = 404;
        if (code == HttpStatus.notFound) return 'missing';
        return 'present';
      }
      ''';
      expect(execute(source), equals('missing'));
    });
  });

  group('SCC61: a natively-thrown HttpException reaches script code', () {
    test('F-SCC61-13: a redirect loop surfaces as a RedirectException the '
        'script can identify [2026-09-06]', () async {
      // End to end, with the exception produced by the SDK rather than by the
      // script: everything above throws a value the script itself constructed,
      // which exercises the bridge's constructor and says nothing about whether
      // a value arriving from a native call is recognised.
      //
      // The assertion is `is` inside a bare `catch`, not an `on HttpException`
      // clause. The realistic script here is `async`, and an `on` clause in an
      // async body currently matches unconditionally (see the file header) — so
      // an `on`-shaped test would be green with or without this bridge.
      final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
      addTearDown(() => server.close(force: true));
      server.listen((request) {
        request.response.statusCode = HttpStatus.found;
        request.response.headers.set('location', '/again');
        request.response.close();
      });

      final source =
          '''
      import 'dart:io';
      main() async {
        var client = HttpClient();
        try {
          var request = await client.getUrl(
            Uri.parse('http://127.0.0.1:${server.port}/'));
          request.maxRedirects = 1;
          await request.close();
          return 'no-throw';
        } catch (e) {
          return [
            e is RedirectException,
            e is HttpException,
            e is IOException,
            e is Exception,
            e is FileSystemException,
          ];
        }
      }
      ''';
      expect(
        await executeAsync(source),
        equals([true, true, true, true, false]),
      );
    });
  });
}
