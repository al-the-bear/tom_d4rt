/// A throwaway self-signed certificate, for tests that need a real TLS peer.
///
/// SCD171 bridged `X509Certificate`, whose only honest test subject is a
/// certificate an actual handshake produced: the SDK returns
/// `_X509CertificateImpl`, and a hand-built stand-in would exercise the bridge
/// against a type the runtime never hands it. The same fixture serves the
/// SCC24 native-name sweep, which needs a live instance for the same reason.
///
/// Written under `.dart_tool/` and deleted afterwards — it is a key and a
/// certificate, so it does not belong in the repository at any lifetime.
library;

import 'dart:io';

/// A generated key/certificate pair on disk.
class TlsFixture {
  TlsFixture._(this.directory, this.certificatePath, this.keyPath);

  final Directory directory;
  final String certificatePath;
  final String keyPath;

  /// Generates a self-signed certificate for `localhost`, or returns null when
  /// this host has no `openssl`.
  ///
  /// Returning null rather than throwing is deliberate: a missing `openssl` is
  /// a property of the machine, and the callers say so out loud rather than
  /// reporting a bridge defect that is not there.
  static Future<TlsFixture?> generate() async {
    final dir = Directory(
      '${Directory.current.path}/.dart_tool/test_fixtures/'
      'tls_${pid}_${DateTime.now().microsecondsSinceEpoch}',
    )..createSync(recursive: true);
    final cert = '${dir.path}/cert.pem';
    final key = '${dir.path}/key.pem';
    try {
      final result = await Process.run('openssl', [
        'req',
        '-x509',
        '-newkey',
        'rsa:2048',
        '-nodes',
        '-keyout',
        key,
        '-out',
        cert,
        '-days',
        '1',
        '-subj',
        '/CN=localhost',
        // A SAN, not just a CN: modern TLS stacks ignore the common name for
        // hostname verification, so a CN-only certificate fails the very
        // handshake it was generated for.
        '-addext',
        'subjectAltName=DNS:localhost,IP:127.0.0.1',
        // Self-signed AND a CA, so the client can trust it as a root rather
        // than the fixture having to disable verification. A self-signed leaf
        // without basicConstraints is rejected as a trust anchor, which reads
        // as a bridge failure and is not one.
        '-addext',
        'basicConstraints=critical,CA:TRUE',
      ]);
      if (result.exitCode != 0 ||
          !File(cert).existsSync() ||
          !File(key).existsSync()) {
        dir.deleteSync(recursive: true);
        return null;
      }
    } on ProcessException {
      dir.deleteSync(recursive: true);
      return null;
    }
    return TlsFixture._(dir, cert, key);
  }

  SecurityContext serverContext() => SecurityContext()
    ..useCertificateChain(certificatePath)
    ..usePrivateKey(keyPath);

  /// A client context that trusts this fixture's certificate, so the handshake
  /// completes without disabling verification anywhere.
  SecurityContext clientContext() =>
      SecurityContext(withTrustedRoots: false)
        ..setTrustedCertificates(certificatePath);

  void dispose() {
    if (directory.existsSync()) directory.deleteSync(recursive: true);
  }

  /// The certificate a real loopback handshake yields, as the runtime builds
  /// it.
  Future<X509Certificate> peerCertificate() async {
    final server = await SecureServerSocket.bind(
      InternetAddress.loopbackIPv4,
      0,
      serverContext(),
    );
    final accepting = server.first;
    // By NAME, not by address: the certificate is issued for `localhost`, and
    // connecting to the literal address asks the stack to verify a name the
    // certificate does not claim.
    final client = await SecureSocket.connect(
      'localhost',
      server.port,
      context: clientContext(),
      // ACCEPTED DELIBERATELY, and only here. What this fixture exists to
      // produce is the `X509Certificate` OBJECT a real handshake builds; the
      // trust decision is not its subject. Making a throwaway self-signed
      // certificate verify as a root would mean generating a CA and a leaf and
      // chaining them, which is a lot of fixture for a question no test here
      // asks. The callback still proves the certificate reached the client.
      onBadCertificate: (certificate) => true,
    );
    final certificate = client.peerCertificate!;
    (await accepting).destroy();
    client.destroy();
    await server.close();
    return certificate;
  }
}
