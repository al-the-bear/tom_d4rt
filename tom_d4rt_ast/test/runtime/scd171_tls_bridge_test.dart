// SCD171 — the TLS bridges, at registration level.
//
// `SecurityContext`, `X509Certificate` and `TlsProtocolVersion` were added to
// close a gap on the reference line: two of them were consumed by adapters and
// registered nowhere, and the third is what the second's
// `minimumTlsProtocolVersion` returns.
//
// WHY REGISTRATION LEVEL AND NOT A SCRIPT. This tree has no parser, so the
// script-level proof — a loopback HTTPS round trip reading every certificate
// getter — lives in `tom_d4rt/test/scd171_tls_bridges_test.dart` and transfers
// by SCD49, which holds the two stdlib trees code-identical. What this file
// pins is the part that is local: the three names are registered here, with the
// members the reference bridge declares.
//
// `TlsProtocolVersion` is the reason the file exists rather than relying on the
// SCC24 sweep alone: the other two reach that sweep through a live certificate,
// and this one has no instance getter anywhere to be reached by, so F-SCD58-2
// reported it as a bridge no test in this tree names.

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/io.dart';

void main() {
  late Environment env;

  setUp(() {
    env = Environment();
    CoreStdlib.register(env);
    IoStdlib.register(env);
  });

  group('SCD171: the TLS bridges are registered in this tree', () {
    test('F-SCD171-AST-1: all three names resolve to a bridge '
        '[2026-09-15] (PASS)', () {
      for (final name in const [
        'SecurityContext',
        'X509Certificate',
        'TlsProtocolVersion',
      ]) {
        expect(
          env.findBridgedClassByName(name),
          isNotNull,
          reason: '$name is consumed by an adapter and must be registered',
        );
      }
    });

    test('F-SCD171-AST-2: X509Certificate declares the seven SDK getters '
        '[2026-09-15] (PASS)', () {
      final bridge = env.findBridgedClassByName('X509Certificate')!;
      expect(
        bridge.getters.keys.toSet(),
        containsAll(const [
          'der',
          'pem',
          'sha1',
          'subject',
          'issuer',
          'startValidity',
          'endValidity',
        ]),
      );
    });

    test('F-SCD171-AST-3: SecurityContext declares the file-reading family '
        'and its byte twins [2026-09-15] (PASS)', () {
      final bridge = env.findBridgedClassByName('SecurityContext')!;
      expect(
        bridge.methods.keys.toSet(),
        containsAll(const [
          'usePrivateKey',
          'useCertificateChain',
          'setTrustedCertificates',
          'setClientAuthorities',
          'usePrivateKeyBytes',
          'useCertificateChainBytes',
          'setTrustedCertificatesBytes',
          'setClientAuthoritiesBytes',
          'setAlpnProtocols',
        ]),
      );
      expect(bridge.constructors.keys, contains(''));
      expect(bridge.staticGetters.keys, contains('defaultContext'));
    });

    test('F-SCD171-AST-5: each bridge is registered for the SDK type it names '
        '[2026-09-15] (PASS)', () {
      // The names above are strings, and a string is not a reference: SCD58's
      // coverage scan strips string literals precisely so that naming a bridge
      // in quotes does not count as exercising it. Comparing `nativeType`
      // against the `dart:io` type is the assertion that actually depends on
      // the bridge being wired to the right class — and it is the one that made
      // `TlsProtocolVersion` stop reading as a bridge no test names.
      expect(
        env.findBridgedClassByName('SecurityContext')!.nativeType,
        SecurityContext,
      );
      expect(
        env.findBridgedClassByName('X509Certificate')!.nativeType,
        X509Certificate,
      );
      expect(
        env.findBridgedClassByName('TlsProtocolVersion')!.nativeType,
        TlsProtocolVersion,
      );
    });

    test('F-SCD171-AST-4: TlsProtocolVersion exposes the two SDK constants '
        '[2026-09-15] (PASS)', () {
      // Its whole public surface. Without them the `minimumTlsProtocolVersion`
      // setter would be settable only to a value no script could name.
      final bridge = env.findBridgedClassByName('TlsProtocolVersion')!;
      expect(
        bridge.staticGetters.keys.toSet(),
        equals(const {'tls1_2', 'tls1_3'}),
      );
    });
  });
}
