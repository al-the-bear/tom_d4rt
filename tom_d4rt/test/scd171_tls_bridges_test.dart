// `X509Certificate` and `SecurityContext` are registered, so the TLS surface
// the adapters already consumed is reachable from a script.
//
// WHAT WAS WRONG. `SecurityContext` appeared three times in
// `stdlib/io/http.dart`, every one of them a parameter an adapter casts to —
// `HttpServer.bindSecure`'s third positional and `HttpClient`'s `context`
// named argument — and no bridge registered it, so a script had no way to
// build the value they demand and both entry points were unreachable.
//
// `X509Certificate` failed WORSE, because it failed silently.
// `HttpRequest.certificate` and `HttpClientResponse.certificate` were bridged
// and returned one; nothing claimed the type, so on an HTTPS connection every
// member call on the result died with `Undefined property or method ... on
// _X509CertificateImpl`. The SCC24 native-name sweep could not see it: that
// getter is null on a plain-HTTP request and the sweep skips nulls.
//
// SO THE CERTIFICATE HERE IS A REAL ONE. A hand-built stand-in would exercise
// the bridge against a type the runtime never produces, which is the precise
// way this defect stayed hidden. F-SCD171-1 drives a full loopback HTTPS round
// trip from inside the interpreter — the script builds the `SecurityContext`,
// binds with `bindSecure`, connects with `HttpClient`, and reads the
// certificate off the response.
//
// IT ALSO DEMONSTRATES SCD170 COMPOSING: that round trip needs
// `NetworkPermission` for the bind and the connect, and `FilesystemPermission`
// for the two certificate files, and the script is granted both explicitly.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

import 'tls_fixture.dart';

void main() {
  group('SCD171: the TLS types are bridged', () {
    late TlsFixture? fixture;

    setUpAll(() async => fixture = await TlsFixture.generate());
    tearDownAll(() => fixture?.dispose());

    /// An interpreter granted everything this file's scripts legitimately need.
    D4rt granted() => D4rt()
      ..grant(FilesystemPermission.any)
      ..grant(NetworkPermission.any);

    test('F-SCD171-1: a script reads every X509Certificate getter off a real '
        'HTTPS round trip [2026-09-15] (PASS)', () async {
      final f = fixture;
      if (f == null) {
        markTestSkipped(
          'openssl is not on this host, so no certificate can be generated. '
          'The bridge is unmeasurable here rather than broken — every other '
          'case in this file still runs.',
        );
        return;
      }
      final result = await granted().execute(
        source:
            '''
import 'dart:io';
Future<dynamic> main() async {
  final context = SecurityContext();
  context.useCertificateChain(r'${f.certificatePath}');
  context.usePrivateKey(r'${f.keyPath}');
  final server = await HttpServer.bindSecure('localhost', 0, context);
  server.listen((request) { request.response.close(); });

  final client = HttpClient();
  client.badCertificateCallback = (cert, host, port) => true;
  final request =
      await client.getUrl(Uri.parse('https://localhost:\${server.port}/'));
  final response = await request.close();
  final certificate = response.certificate;
  final report = [
    certificate.subject.trim(),
    certificate.issuer.trim(),
    certificate.pem.startsWith('-----BEGIN CERTIFICATE-----'),
    certificate.der.length > 0,
    certificate.sha1.length,
    certificate.startValidity.isBefore(certificate.endValidity),
  ];
  await server.close(force: true);
  client.close(force: true);
  return report.join('|');
}
''',
      );
      expect(
        result,
        '/CN=localhost|/CN=localhost|true|true|20|true',
        reason:
            'Before SCD171 every one of these member calls failed with '
            '"Undefined property or method ... on _X509CertificateImpl".',
      );
    });

    test('F-SCD171-2: SecurityContext is constructible and its statics '
        'resolve [2026-09-15] (PASS)', () async {
      expect(
        await granted().execute(
          source:
              "import 'dart:io';\n"
              'dynamic main() {\n'
              '  final a = SecurityContext();\n'
              '  final b = SecurityContext(withTrustedRoots: true);\n'
              '  final c = SecurityContext.defaultContext;\n'
              '  return [a != null, b != null, c != null].join("|");\n'
              '}',
        ),
        'true|true|true',
      );
    });

    test('F-SCD171-3: the file-reading members go through '
        'FilesystemPermission [2026-09-15] (PASS)', () async {
      // The reason this todo was sequenced after SCD170. These four take a
      // PATH and read it, so handing it straight to the SDK would let a script
      // scoped to one directory read a private key anywhere on the host
      // through a TLS API — a filesystem escape wearing a network hat.
      final f = fixture;
      if (f == null) {
        markTestSkipped('openssl is not on this host');
        return;
      }
      for (final member in const [
        'useCertificateChain',
        'usePrivateKey',
        'setTrustedCertificates',
        'setClientAuthorities',
      ]) {
        // Granted for a directory that does NOT contain the fixture, so the
        // refusal is about scope rather than about holding no grant at all.
        final interpreter = D4rt()
          ..grant(FilesystemPermission.readPath(f.directory.parent.path))
          ..grant(NetworkPermission.any);
        // `expect`, not `expectLater`: the script's `main` is synchronous, so
        // `execute` throws during the call rather than returning a Future that
        // completes with an error — an `expectLater` on its result never sees
        // the throw at all.
        expect(
          () => interpreter.execute(
            source:
                "import 'dart:io';\n"
                'dynamic main() {\n'
                "  SecurityContext().$member(r'/etc/ssl/private/anywhere.pem');\n"
                '}',
          ),
          throwsA(
            isA<RuntimeD4rtException>().having(
              (e) => e.message,
              'message for $member',
              contains('Filesystem permission denied'),
            ),
          ),
          reason: '$member reads a file and must be gated',
        );
      }
    });

    test('F-SCD171-4 (control): the same members succeed inside the granted '
        'scope [2026-09-15] (PASS)', () async {
      // Without this, F-SCD171-3 is satisfied by members that refuse every
      // path — a different bug with the same test result.
      final f = fixture;
      if (f == null) {
        markTestSkipped('openssl is not on this host');
        return;
      }
      expect(
        await granted().execute(
          source:
              "import 'dart:io';\n"
              'dynamic main() {\n'
              '  final c = SecurityContext();\n'
              "  c.useCertificateChain(r'${f.certificatePath}');\n"
              "  c.usePrivateKey(r'${f.keyPath}');\n"
              '  return "ok";\n'
              '}',
        ),
        'ok',
      );
    });

    test('F-SCD171-5: the *Bytes variants need no filesystem grant '
        '[2026-09-15] (PASS)', () async {
      // The deliberate asymmetry: these take bytes the script already holds
      // and read nothing, and a script that obtained those bytes did so
      // through a gated read. Gating them again would refuse an operation that
      // touches no file.
      final f = fixture;
      if (f == null) {
        markTestSkipped('openssl is not on this host');
        return;
      }
      final pem = await granted().execute(
        source:
            "import 'dart:io';\n"
            "dynamic main() => File(r'${f.certificatePath}').readAsStringSync();",
      );
      final interpreter = D4rt()..grant(NetworkPermission.any);
      // No FilesystemPermission at all — so `dart:io` cannot even be imported,
      // which is sce206's subject. Drive the bridge through a granted import
      // but an ungranted PATH instead: the bytes route must not consult the
      // path scope, because it has no path.
      final scoped = D4rt()
        ..grant(FilesystemPermission.readPath('/nonexistent-scope'))
        ..grant(NetworkPermission.any);
      expect(interpreter, isNotNull);
      expect(
        await scoped.execute(
          source:
              "import 'dart:io';\n"
              'dynamic main() {\n'
              '  final bytes = <int>[${(pem as String).codeUnits.join(',')}];\n'
              '  SecurityContext().setTrustedCertificatesBytes(bytes);\n'
              '  return "ok";\n'
              '}',
        ),
        'ok',
      );
    });

    test('F-SCD171-6: both types are registered under their public names '
        '[2026-09-15] (PASS)', () async {
      // Anti-vacuity for the whole file: every case above reaches the bridges
      // through a script, so a registration that silently disappeared would
      // turn them all into "undefined name" failures that read as something
      // else.
      expect(
        await granted().execute(
          source:
              "import 'dart:io';\n"
              'dynamic main() => '
              '[SecurityContext, X509Certificate].map((t) => '
              't.toString()).join("|");',
        ),
        'SecurityContext|X509Certificate',
      );
    });
  });
}
