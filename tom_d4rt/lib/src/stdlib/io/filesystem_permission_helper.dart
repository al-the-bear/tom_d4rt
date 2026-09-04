/// Per-operation `FilesystemPermission` gate for the `dart:io` bridges.
///
/// The `dart:io` IMPORT gate only establishes that *some* filesystem
/// permission was granted; it says nothing about which paths. Without these
/// checks a grant scoped to one directory behaves exactly like
/// `FilesystemPermission.any` — every bridged file/directory operation would
/// run unchecked. Each read/write entry point in `file.dart`,
/// `directory.dart` and `file_system_entity.dart` calls in here first, so the
/// denial happens BEFORE the native operation, not after.
library;

import 'dart:io';

import 'package:tom_d4rt/d4rt.dart';

/// Asserts the script may read [path]. Throws otherwise.
void checkFilesystemReadPermission(
  InterpreterVisitor visitor,
  String path, {
  String operation = 'read',
}) {
  _checkFilesystemPermission(
    visitor,
    path,
    operation: operation,
    read: true,
    write: false,
  );
}

/// Asserts the script may write [path]. Throws otherwise.
void checkFilesystemWritePermission(
  InterpreterVisitor visitor,
  String path, {
  String operation = 'write',
}) {
  _checkFilesystemPermission(
    visitor,
    path,
    operation: operation,
    read: false,
    write: true,
  );
}

void _checkFilesystemPermission(
  InterpreterVisitor visitor,
  String path, {
  required String operation,
  required bool read,
  required bool write,
}) {
  // No interpreter instance means no permission set to enforce — the bridges
  // are being driven directly (e.g. from a unit test), not sandboxed.
  final d4rt = visitor.moduleLoader.d4rt;
  if (d4rt == null) return;

  // Match on absolute paths: the grant is canonicalized the same way, and a
  // relative operation path would otherwise never fall inside an absolute
  // scope.
  final normalizedPath = File(path).absolute.path;
  final allowed = d4rt.checkPermission({
    'type': 'filesystem',
    'path': normalizedPath,
    'read': read,
    'write': write,
    'execute': false,
  });

  if (allowed) return;

  throw RuntimeD4rtException(
    'Filesystem permission denied for $operation on "$path". '
    'Grant an appropriate FilesystemPermission for this path.',
  );
}
