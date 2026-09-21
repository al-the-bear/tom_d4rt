import 'dart:io';

import 'package:tom_d4rt_ast/runtime.dart';

import 'filesystem_permission_helper.dart';
import 'certificate_permission_helper.dart';

/// Bridged `dart:io` `X509Certificate`.
///
/// SCD171: `HttpRequest.certificate` and `HttpClientResponse.certificate` were
/// already bridged and already returned one of these, with no bridge claiming
/// the type — so on an HTTPS connection every member call on the result failed
/// with `Undefined property or method ... on _X509CertificateImpl`.
///
/// IT FAILED SILENTLY, which is why it outlived the sweep that exists to catch
/// exactly this. SCC24 walks the bridged getters looking for unclaimed native
/// types, and it skips nulls; `certificate` is null on a plain-HTTP request, so
/// the sweep saw nothing to complain about. SCD171 gives the sweep a live
/// instance from a real handshake, so the blind spot is closed for this type.
///
/// `nativeNames` IS NOT WHAT MAKES THIS WORK, and that was measured rather than
/// assumed: removing it leaves both the round-trip test and the SCC24 sweep
/// green, because `isAssignable` already claims `_X509CertificateImpl` — it
/// implements the public interface, so the predicate answers true for it. The
/// entry is kept because every sibling `dart:io` bridge carries one for its
/// impl type and because it still claims the type if the predicate is ever
/// narrowed; it is documentation and defence, not the mechanism.
class X509CertificateIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: X509Certificate,
    name: 'X509Certificate',
    isAssignable: (v) => v is X509Certificate,
    typeParameterCount: 0,
    nativeNames: ['_X509CertificateImpl'],
    getters: {
      'der': (visitor, target) => (target as X509Certificate).der,
      'pem': (visitor, target) => (target as X509Certificate).pem,
      'sha1': (visitor, target) => (target as X509Certificate).sha1,
      'subject': (visitor, target) => (target as X509Certificate).subject,
      'issuer': (visitor, target) => (target as X509Certificate).issuer,
      'startValidity': (visitor, target) =>
          (target as X509Certificate).startValidity,
      'endValidity': (visitor, target) =>
          (target as X509Certificate).endValidity,
    },
  );
}

/// Bridged `dart:io` `TlsProtocolVersion`.
///
/// SCD171: registered because `SecurityContext.minimumTlsProtocolVersion`
/// returns one, and an unclaimed return type is inert — every member call on
/// it fails with `Undefined property or method ...`, which is the defect shape
/// SCC24 exists to catch. It caught this one the moment the getter was added.
///
/// The SDK class has no public instance members at all: two `static const`
/// values, a private field and a private factory. So the bridge is the two
/// constants, which is also exactly what a script needs in order to USE the
/// setter — without them the member would be settable only to a value no
/// script could name.
class TlsProtocolVersionIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: TlsProtocolVersion,
    name: 'TlsProtocolVersion',
    isAssignable: (v) => v is TlsProtocolVersion,
    typeParameterCount: 0,
    staticGetters: {
      'tls1_2': (visitor) => TlsProtocolVersion.tls1_2,
      'tls1_3': (visitor) => TlsProtocolVersion.tls1_3,
    },
  );
}

/// Bridged `dart:io` `SecurityContext`.
///
/// SCD171: three adapters cast a parameter to this type — `HttpServer`'s
/// `bindSecure` third positional and `HttpClient`'s `context` named argument —
/// and nothing registered it, so a script had no way to construct the value
/// they demand and both entry points were unreachable.
///
/// THE FOUR FILE-READING MEMBERS GO THROUGH THE FILESYSTEM GATE, and that is
/// the reason this todo was sequenced after SCD170 rather than beside it.
/// `usePrivateKey`, `useCertificateChain`, `setTrustedCertificates` and
/// `setClientAuthorities` each take a PATH and read it. Handing the path
/// straight to the SDK would let a script scoped to one directory read a
/// private key anywhere on the host through a TLS API — a filesystem escape
/// wearing a network hat. They call the same helper `file.dart` and
/// `directory.dart` use, so one scope governs every path in `dart:io`.
///
/// The `*Bytes` variants take the bytes the script already holds and read
/// nothing, so they are ungated; a script that obtained the bytes did so
/// through a gated read.
class SecurityContextIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: SecurityContext,
    name: 'SecurityContext',
    isAssignable: (v) => v is SecurityContext,
    typeParameterCount: 0,
    nativeNames: ['_SecurityContext'],
    constructors: {
      '': (visitor, positionalArgs, namedArgs) => SecurityContext(
        withTrustedRoots: namedArgs['withTrustedRoots'] as bool? ?? false,
      ),
    },
    getters: {
      'allowLegacyUnsafeRenegotiation': (visitor, target) =>
          (target as SecurityContext).allowLegacyUnsafeRenegotiation,
      'minimumTlsProtocolVersion': (visitor, target) =>
          (target as SecurityContext).minimumTlsProtocolVersion,
    },
    setters: {
      'allowLegacyUnsafeRenegotiation': (visitor, target, value) {
        (target as SecurityContext).allowLegacyUnsafeRenegotiation =
            value as bool;
      },
      'minimumTlsProtocolVersion': (visitor, target, value) {
        (target as SecurityContext).minimumTlsProtocolVersion =
            value as TlsProtocolVersion;
      },
    },
    staticGetters: {
      'defaultContext': (visitor) => SecurityContext.defaultContext,
      // `alpnSupported` is deliberately absent: the SDK deprecates it, so
      // bridging it would add surface that is on its way out and would make
      // the twin's analyzer complain. `setAlpnProtocols` below is not
      // deprecated and is bridged.
    },
    methods: {
      'usePrivateKey': (visitor, target, positionalArgs, namedArgs, _) {
        checkCertificatePermission(visitor, 'usePrivateKey');
        final file = _requirePath(positionalArgs, 'usePrivateKey');
        checkFilesystemReadPermission(
          visitor,
          file,
          operation: 'SecurityContext.usePrivateKey',
        );
        (target as SecurityContext).usePrivateKey(
          file,
          password: namedArgs['password'] as String?,
        );
        return null;
      },
      'useCertificateChain': (visitor, target, positionalArgs, namedArgs, _) {
        checkCertificatePermission(visitor, 'useCertificateChain');
        final file = _requirePath(positionalArgs, 'useCertificateChain');
        checkFilesystemReadPermission(
          visitor,
          file,
          operation: 'SecurityContext.useCertificateChain',
        );
        (target as SecurityContext).useCertificateChain(
          file,
          password: namedArgs['password'] as String?,
        );
        return null;
      },
      'setTrustedCertificates':
          (visitor, target, positionalArgs, namedArgs, _) {
            checkCertificatePermission(visitor, 'setTrustedCertificates');
            final file = _requirePath(positionalArgs, 'setTrustedCertificates');
            checkFilesystemReadPermission(
              visitor,
              file,
              operation: 'SecurityContext.setTrustedCertificates',
            );
            (target as SecurityContext).setTrustedCertificates(
              file,
              password: namedArgs['password'] as String?,
            );
            return null;
          },
      'setClientAuthorities': (visitor, target, positionalArgs, namedArgs, _) {
        checkCertificatePermission(visitor, 'setClientAuthorities');
        final file = _requirePath(positionalArgs, 'setClientAuthorities');
        checkFilesystemReadPermission(
          visitor,
          file,
          operation: 'SecurityContext.setClientAuthorities',
        );
        (target as SecurityContext).setClientAuthorities(
          file,
          password: namedArgs['password'] as String?,
        );
        return null;
      },
      'usePrivateKeyBytes': (visitor, target, positionalArgs, namedArgs, _) {
        checkCertificatePermission(visitor, 'usePrivateKeyBytes');
        (target as SecurityContext).usePrivateKeyBytes(
          _requireBytes(positionalArgs, 'usePrivateKeyBytes'),
          password: namedArgs['password'] as String?,
        );
        return null;
      },
      'useCertificateChainBytes':
          (visitor, target, positionalArgs, namedArgs, _) {
            checkCertificatePermission(visitor, 'useCertificateChainBytes');
            (target as SecurityContext).useCertificateChainBytes(
              _requireBytes(positionalArgs, 'useCertificateChainBytes'),
              password: namedArgs['password'] as String?,
            );
            return null;
          },
      'setTrustedCertificatesBytes':
          (visitor, target, positionalArgs, namedArgs, _) {
            checkCertificatePermission(visitor, 'setTrustedCertificatesBytes');
            (target as SecurityContext).setTrustedCertificatesBytes(
              _requireBytes(positionalArgs, 'setTrustedCertificatesBytes'),
              password: namedArgs['password'] as String?,
            );
            return null;
          },
      'setClientAuthoritiesBytes':
          (visitor, target, positionalArgs, namedArgs, _) {
            checkCertificatePermission(visitor, 'setClientAuthoritiesBytes');
            (target as SecurityContext).setClientAuthoritiesBytes(
              _requireBytes(positionalArgs, 'setClientAuthoritiesBytes'),
              password: namedArgs['password'] as String?,
            );
            return null;
          },
      'setAlpnProtocols': (visitor, target, positionalArgs, namedArgs, _) {
        if (positionalArgs.length != 2 || positionalArgs[1] is! bool) {
          throw ArgumentD4rtException(
            'SecurityContext.setAlpnProtocols requires protocols and isServer',
          );
        }
        (target as SecurityContext).setAlpnProtocols(
          // SCD70: coerce, not cast — a list literal written in a script is a
          // `_List<Object?>` whatever its entries hold.
          D4.coerceList<String>(positionalArgs[0], 'protocols'),
          positionalArgs[1] as bool,
        );
        return null;
      },
    },
  );
}

String _requirePath(List<dynamic> positionalArgs, String member) {
  if (positionalArgs.isEmpty || positionalArgs[0] is! String) {
    throw ArgumentD4rtException(
      'SecurityContext.$member requires a file path String',
    );
  }
  return positionalArgs[0] as String;
}

List<int> _requireBytes(List<dynamic> positionalArgs, String member) {
  if (positionalArgs.isEmpty) {
    throw ArgumentD4rtException('SecurityContext.$member requires bytes');
  }
  return D4.coerceList<int>(positionalArgs[0], 'bytes');
}
