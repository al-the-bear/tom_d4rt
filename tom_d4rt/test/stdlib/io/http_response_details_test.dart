import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';
import '../../interpreter_test.dart';

/// SCC65 — the two value types reached *through* `HttpClientResponse`.
///
/// `redirects` and `compressionState` were bridged as getters long before the
/// types they yield were bridged as names. That is the shape SCC62 named a
/// dead end: the member resolves, the call succeeds, and the script is handed
/// a value it cannot name, test, or read a field from. Nothing throws at the
/// boundary — the failure surfaces later and somewhere else, as an undefined
/// member on a value whose origin is no longer in view.
///
/// It is worse here than in SCC62's case, because the bridge these members
/// hang off already works. A script that gets as far as reading `.redirects`
/// has a live HTTP response in hand and every reason to believe the rest of
/// the surface is there.
///
/// **Why a fake rather than a real response.** A populated `List<RedirectInfo>`
/// requires a server that actually redirects, and the SDK's implementation
/// class is private, so a script cannot construct one either. Implementing the
/// interface natively and injecting it is what lets the getters be exercised
/// without a network — and it is honest, because `RedirectInfo` is an
/// `abstract interface class`, so this is exactly what the SDK invites.
class _FakeRedirectInfo implements RedirectInfo {
  @override
  final int statusCode;
  @override
  final String method;
  @override
  final Uri location;

  const _FakeRedirectInfo(this.statusCode, this.method, this.location);
}

/// Runs [source] with a `redirectFixture()` top-level function in scope,
/// returning a native [RedirectInfo] the interpreter did not construct.
dynamic executeWithRedirectFixture(String source) {
  final d4rt = D4rt()..setDebug(false);
  d4rt.grant(FilesystemPermission.any);
  d4rt.grant(NetworkPermission.any);
  d4rt.registertopLevelFunction(
    'redirectFixture',
    (visitor, args, namedArgs, typeArgs) =>
        _FakeRedirectInfo(302, 'GET', Uri.parse('https://example.test/moved')),
    'package:fixture/redirect.dart',
    signature: 'RedirectInfo redirectFixture()',
  );
  return d4rt.execute(
    library: 'package:test/main.dart',
    sources: {'package:test/main.dart': source},
  );
}

void main() {
  group('SCC65: RedirectInfo', () {
    test('F-SCC65-11: the name answers a type test [2026-09-06]', () {
      const source = '''
      import 'dart:io';
      main() { return 1 is RedirectInfo; }
      ''';
      expect(execute(source), isFalse);
    });

    test('F-SCC65-12: a native RedirectInfo satisfies its own type '
        '[2026-09-06]', () {
      // The question F-SCC65-11 cannot ask: that the bridge claims the values
      // the SDK actually hands back, and not merely that a name resolves.
      const source = '''
      import 'dart:io';
      import 'package:fixture/redirect.dart';
      main() { return redirectFixture() is RedirectInfo; }
      ''';
      expect(executeWithRedirectFixture(source), isTrue);
    });

    test('F-SCC65-13: all three getters read through [2026-09-06]', () {
      // The whole public surface of the interface. `location` is the one that
      // matters most — it is what `RedirectException.uri` reads and the only
      // way a script can learn where a redirect chain actually went.
      const source = '''
      import 'dart:io';
      import 'package:fixture/redirect.dart';
      main() {
        var r = redirectFixture();
        return [r.statusCode, r.method, r.location.toString()];
      }
      ''';
      expect(
        executeWithRedirectFixture(source),
        equals([302, 'GET', 'https://example.test/moved']),
      );
    });

    test('F-SCC65-14: it cannot be constructed [2026-09-06]', () {
      // `abstract interface class RedirectInfo` — no constructor, no factory.
      const source = '''
      import 'dart:io';
      main() { return RedirectInfo(); }
      ''';
      expect(
        () => execute(source),
        throwsRuntimeError(
          // Not a bare `contains`: while the name was unbridged this passed on
          // `Undefined variable: RedirectInfo`, which proves nothing about
          // constructability.
          allOf(contains('RedirectInfo'), isNot(contains('Undefined'))),
        ),
      );
    });

    test('F-SCC65-15: RedirectException.redirects yields nameable values '
        '[2026-09-06]', () {
      // The call site the audit found. `RedirectExceptionIo` has bridged this
      // getter all along; until the element type was bridged the list it
      // returned held values a script could not read.
      const source = '''
      import 'dart:io';
      import 'package:fixture/redirect.dart';
      main() {
        var e = RedirectException('too many', [redirectFixture()]);
        return [e.redirects.length, e.redirects.first is RedirectInfo,
                e.redirects.first.statusCode, e.uri.toString()];
      }
      ''';
      expect(
        executeWithRedirectFixture(source),
        equals([1, true, 302, 'https://example.test/moved']),
      );
    });
  });

  group('SCC65: HttpClientResponseCompressionState', () {
    test('F-SCC65-16: the three constants are reachable [2026-09-06]', () {
      const source = '''
      import 'dart:io';
      main() {
        return [
          HttpClientResponseCompressionState.notCompressed.toString(),
          HttpClientResponseCompressionState.decompressed.toString(),
          HttpClientResponseCompressionState.compressed.toString(),
        ];
      }
      ''';
      expect(
        execute(source),
        equals([
          'HttpClientResponseCompressionState.notCompressed',
          'HttpClientResponseCompressionState.decompressed',
          'HttpClientResponseCompressionState.compressed',
        ]),
      );
    });

    test('F-SCC65-17: name and index read through [2026-09-06]', () {
      // Unlike `SameSite` and `ProcessStartMode` — the other two constant
      // families in this stdlib — this one is a genuine Dart `enum`, so it
      // really does have `name` and `index` and a bridge that omitted them
      // would be refusing what Dart accepts.
      const source = '''
      import 'dart:io';
      main() {
        var s = HttpClientResponseCompressionState.decompressed;
        return [s.name, s.index];
      }
      ''';
      expect(execute(source), equals(['decompressed', 1]));
    });

    test('F-SCC65-18: values lists all three in declaration order '
        '[2026-09-06]', () {
      const source = '''
      import 'dart:io';
      main() {
        return HttpClientResponseCompressionState.values
            .map((v) => v.name).toList();
      }
      ''';
      expect(
        execute(source),
        equals(['notCompressed', 'decompressed', 'compressed']),
      );
    });

    test('F-SCC65-19: a value satisfies its own type and identity compares '
        '[2026-09-06]', () {
      // Identity is how a script uses this type at all — the value is only
      // ever compared against a constant. A bridge that handed back a fresh
      // wrapper per access would pass every other case here and fail this one.
      const source = '''
      import 'dart:io';
      main() {
        var s = HttpClientResponseCompressionState.compressed;
        return [
          s is HttpClientResponseCompressionState,
          s == HttpClientResponseCompressionState.compressed,
          s == HttpClientResponseCompressionState.notCompressed,
        ];
      }
      ''';
      expect(execute(source), equals([true, true, false]));
    });

    test('F-SCC65-20: it works as a switch subject [2026-09-06]', () {
      // The idiomatic use, and the one that breaks first if identity is not
      // preserved: a switch over enum constants is a chain of `==` the
      // interpreter evaluates rather than a jump table.
      const source = '''
      import 'dart:io';
      String describe(HttpClientResponseCompressionState s) {
        switch (s) {
          case HttpClientResponseCompressionState.notCompressed:
            return 'plain';
          case HttpClientResponseCompressionState.decompressed:
            return 'unzipped';
          case HttpClientResponseCompressionState.compressed:
            return 'still zipped';
        }
        return 'unknown';
      }
      main() {
        return HttpClientResponseCompressionState.values
            .map(describe).toList();
      }
      ''';
      expect(execute(source), equals(['plain', 'unzipped', 'still zipped']));
    });

    test('F-SCC65-21: an unrelated value is not a compression state '
        '[2026-09-06]', () {
      const source = '''
      import 'dart:io';
      main() { return 1 is HttpClientResponseCompressionState; }
      ''';
      expect(execute(source), isFalse);
    });
  });
}
