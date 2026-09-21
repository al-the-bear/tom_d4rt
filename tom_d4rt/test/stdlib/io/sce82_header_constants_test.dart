// SCE82: the `HttpHeaders` constant block, and three smaller static gaps.
//
// The audit reported 51 confirmed-unreachable members: 45 `HttpHeaders`
// constants, four `RawSocketOption` level/interface values,
// `ConnectionTask.fromSocket` and `Platform.lineTerminator`. Every one was a
// member a script could never call, and nothing had regressed — the audit
// simply could not see them until SCD44 widened it.
//
// THE HALF-BRIDGED STATE WAS THE WORST ONE. Seventeen `HttpHeaders` constants
// resolved and forty-five did not, so a script writing
// `headers.set(HttpHeaders.acceptRangesHeader, …)` failed while
// `HttpHeaders.acceptHeader` beside it worked — the ones that resolve teach the
// author to expect the rest.
//
// WHY THESE ASSERT AGAINST `dart:io` RATHER THAN AGAINST A LITERAL. A bridge
// that resolves and returns the WRONG header name is a defect no other test
// here would catch: the script gets a string, the call succeeds, and the
// request carries the wrong field. Comparing against the SDK's own constant
// makes a wrong value fail.
//
// The bridge itself delegates (`(visitor) => HttpHeaders.acceptRangesHeader`)
// rather than repeating the literal, so a mistyped NAME is a compile error.
// These cases cover the other half: that the bridge is wired to the constant it
// claims, and that the whole block is reachable rather than a sample of it.

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? run(String body) =>
    (D4rt()
          ..grant(FilesystemPermission.any)
          ..grant(NetworkPermission.any)
          ..grant(DangerousPermission.any))
        .execute(source: "import 'dart:io';\n$body");

void main() {
  group('SCE82: the HttpHeaders constant block is fully bridged', () {
    // Every constant the audit reported, paired with the SDK's own value.
    final expected = <String, Object?>{
      'acceptRangesHeader': HttpHeaders.acceptRangesHeader,
      'accessControlAllowCredentialsHeader':
          HttpHeaders.accessControlAllowCredentialsHeader,
      'accessControlAllowHeadersHeader':
          HttpHeaders.accessControlAllowHeadersHeader,
      'accessControlAllowMethodsHeader':
          HttpHeaders.accessControlAllowMethodsHeader,
      'accessControlAllowOriginHeader':
          HttpHeaders.accessControlAllowOriginHeader,
      'accessControlExposeHeadersHeader':
          HttpHeaders.accessControlExposeHeadersHeader,
      'accessControlMaxAgeHeader': HttpHeaders.accessControlMaxAgeHeader,
      'accessControlRequestHeadersHeader':
          HttpHeaders.accessControlRequestHeadersHeader,
      'accessControlRequestMethodHeader':
          HttpHeaders.accessControlRequestMethodHeader,
      'ageHeader': HttpHeaders.ageHeader,
      'allowHeader': HttpHeaders.allowHeader,
      'contentDisposition': HttpHeaders.contentDisposition,
      'contentLanguageHeader': HttpHeaders.contentLanguageHeader,
      'contentLocationHeader': HttpHeaders.contentLocationHeader,
      'contentMD5Header': HttpHeaders.contentMD5Header,
      'contentRangeHeader': HttpHeaders.contentRangeHeader,
      'etagHeader': HttpHeaders.etagHeader,
      'expectHeader': HttpHeaders.expectHeader,
      'expiresHeader': HttpHeaders.expiresHeader,
      'fromHeader': HttpHeaders.fromHeader,
      'ifMatchHeader': HttpHeaders.ifMatchHeader,
      'ifNoneMatchHeader': HttpHeaders.ifNoneMatchHeader,
      'ifRangeHeader': HttpHeaders.ifRangeHeader,
      'ifUnmodifiedSinceHeader': HttpHeaders.ifUnmodifiedSinceHeader,
      'lastModifiedHeader': HttpHeaders.lastModifiedHeader,
      'maxForwardsHeader': HttpHeaders.maxForwardsHeader,
      'pragmaHeader': HttpHeaders.pragmaHeader,
      'proxyAuthenticateHeader': HttpHeaders.proxyAuthenticateHeader,
      'proxyAuthorizationHeader': HttpHeaders.proxyAuthorizationHeader,
      'rangeHeader': HttpHeaders.rangeHeader,
      'refererHeader': HttpHeaders.refererHeader,
      'retryAfterHeader': HttpHeaders.retryAfterHeader,
      'serverHeader': HttpHeaders.serverHeader,
      'teHeader': HttpHeaders.teHeader,
      'trailerHeader': HttpHeaders.trailerHeader,
      'transferEncodingHeader': HttpHeaders.transferEncodingHeader,
      'upgradeHeader': HttpHeaders.upgradeHeader,
      'varyHeader': HttpHeaders.varyHeader,
      'viaHeader': HttpHeaders.viaHeader,
      'warningHeader': HttpHeaders.warningHeader,
      'wwwAuthenticateHeader': HttpHeaders.wwwAuthenticateHeader,
    };

    test('F-SCE82-1: every constant resolves and equals the SDK value '
        '[2026-09-21]', () {
      final wrong = <String>[];
      for (final entry in expected.entries) {
        Object? got;
        try {
          got = run('main() => HttpHeaders.${entry.key};');
        } catch (e) {
          wrong.add('${entry.key}: threw ${'$e'.split('\n').first}');
          continue;
        }
        if (got != entry.value) {
          wrong.add('${entry.key}: got "$got", dart:io says "${entry.value}"');
        }
      }
      expect(wrong, isEmpty, reason: wrong.join('\n'));
    });

    test('F-SCE82-2: the four LIST constants come across as lists '
        '[2026-09-21]', () {
      // `generalHeaders`, `entityHeaders`, `requestHeaders` and
      // `responseHeaders` are `List<String>` rather than `String`, so they
      // exercise a different return path than the forty-one above.
      expect(
        run('main() => HttpHeaders.generalHeaders;'),
        orderedEquals(HttpHeaders.generalHeaders),
      );
      expect(
        run('main() => HttpHeaders.entityHeaders;'),
        orderedEquals(HttpHeaders.entityHeaders),
      );
      expect(
        run('main() => HttpHeaders.requestHeaders;'),
        orderedEquals(HttpHeaders.requestHeaders),
      );
      expect(
        run('main() => HttpHeaders.responseHeaders;'),
        orderedEquals(HttpHeaders.responseHeaders),
      );
    });

    test('F-SCE82-3 (control): a constant that was ALREADY bridged still '
        'works [2026-09-21]', () {
      // The seventeen that resolved before are the reason the gap was
      // invisible to a script author; a regression in them would be the same
      // defect from the other side.
      expect(
        run('main() => HttpHeaders.acceptHeader;'),
        HttpHeaders.acceptHeader,
      );
      expect(run('main() => HttpHeaders.dateHeader;'), HttpHeaders.dateHeader);
    });
  });

  group('SCE82: the three smaller static gaps', () {
    test('F-SCE82-4: RawSocketOption level and interface constants '
        '[2026-09-21]', () {
      // Without these a script cannot build an IP-multicast `RawSocketOption`
      // at all, so the constructors were only half usable.
      expect(
        run('main() => RawSocketOption.levelIPv4;'),
        RawSocketOption.levelIPv4,
      );
      expect(
        run('main() => RawSocketOption.levelIPv6;'),
        RawSocketOption.levelIPv6,
      );
      expect(
        run('main() => RawSocketOption.IPv4MulticastInterface;'),
        RawSocketOption.IPv4MulticastInterface,
      );
      expect(
        run('main() => RawSocketOption.IPv6MulticastInterface;'),
        RawSocketOption.IPv6MulticastInterface,
      );
    });

    test('F-SCE82-5: Platform.lineTerminator [2026-09-21]', () {
      expect(
        run('main() => Platform.lineTerminator;'),
        Platform.lineTerminator,
      );
    });

    test('F-SCE82-6: Platform.lineTerminator is GATED like its neighbours '
        '[2026-09-21]', () {
      // It is a pure value, but it is a host property and every other
      // `Platform` getter goes through the dangerous-permission gate. Bridging
      // it ungated would have made it the one `Platform` member a script can
      // read without a grant.
      //
      // The MESSAGE is asserted, not merely the throw: an UNBRIDGED member
      // also throws, so `throwsA(isA<RuntimeD4rtException>())` alone passes
      // whether the gate works or the member is simply missing — which is the
      // state this whole file exists to leave behind.
      expect(
        () => (D4rt()..grant(FilesystemPermission.any)).execute(
          source: "import 'dart:io';\nmain() => Platform.lineTerminator;",
        ),
        throwsA(
          predicate<Object>(
            (e) => '$e'.contains('DangerousPermission'),
            'denied by the permission gate, not absent from the bridge',
          ),
        ),
      );
    });

    test('F-SCE82-7: ConnectionTask.fromSocket resolves [2026-09-21]', () {
      // Documented by the SDK for `HttpClient.connectionFactory`, which is
      // bridged — so this is script-reachable rather than an implementor-only
      // hook. Resolution is what the audit measured and what this pins;
      // driving a real socket through it belongs to the HTTP suites.
      expect(
        run('main() { var f = ConnectionTask.fromSocket; return f != null; }'),
        isTrue,
      );
    });
  });
}
