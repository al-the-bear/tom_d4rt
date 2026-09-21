/// `CertificatePermission` gate for the `dart:io` TLS bridges.
///
/// SCE74H. Every `SecurityContext` member that installs key material passes
/// through here — the four path variants and the four `*Bytes` variants alike.
///
/// WHY A CAPABILITY OF ITS OWN when `FilesystemPermission` already covers the
/// read. It covers it as an ORDINARY read, and a private key is not an
/// ordinary read: a script scoped to a directory that happens to hold one
/// could otherwise hand it to a `SecurityContext` and serve traffic under the
/// host's identity, with nothing in the grant list saying that was possible.
///
/// WHY THE BYTES VARIANTS ARE GATED TOO, though they read nothing. The
/// capability is "install key material into a TLS context", not "open a file".
/// Gating only the path forms would leave the shorter route wide open. The
/// path forms are therefore checked twice, here and by the filesystem gate,
/// which is correct: they genuinely do both things.
///
/// IT LIVES IN ITS OWN FILE for the reason SCD170 moved `io/socket.dart` off
/// SCD49's allow-list — the permission idiom differs between the twins, so
/// confining it to a helper keeps `io/tls.dart` code-identical and leaves one
/// small recorded divergence instead of a large one.
library;

import 'package:tom_d4rt/d4rt.dart';

/// Asserts the script may install key material into a `SecurityContext`.
void checkCertificatePermission(InterpreterVisitor visitor, String member) {
  // No interpreter instance means no permission set to enforce — the bridges
  // are being driven directly (e.g. from a unit test), not sandboxed. NOT a
  // sandbox hole: every path that runs a SCRIPT builds its loader with
  // `d4rt: this`, so a script's visitor always carries one and this branch is
  // unreachable from interpreted code. The analyzer-free twin is permissive in
  // the same state for the same reason — its `NoOpModuleContext
  // .checkPermission` returns true when no checker is wired — so the two trees
  // agree on the un-sandboxed mode and differ only in where they express it.
  // Pinned by `test/stdlib/io/sce87_permission_gate_null_handle_test.dart`.
  final d4rt = visitor.moduleLoader.d4rt;
  if (d4rt == null) return;
  if (d4rt.checkPermission(const {'type': 'certificate'})) return;

  throw RuntimeD4rtException(
    'Certificate permission denied for SecurityContext.$member. '
    'Grant CertificatePermission.load to allow installing certificates and '
    'private keys.',
  );
}
