/// Per-operation `FilesystemPermission` gate for the `dart:io` bridges.
///
/// The `dart:io` IMPORT gate only establishes that *some* filesystem
/// permission was granted; it says nothing about which paths. Without these
/// checks a grant scoped to one directory behaves exactly like
/// `FilesystemPermission.any` — every bridged file/directory operation would
/// run unchecked. Each read/write entry point in `file.dart`,
/// `directory.dart` and `file_system_entity.dart` calls in here first, so the
/// denial happens BEFORE the native operation, not after.
///
/// Twin of `tom_d4rt/lib/src/stdlib/io/filesystem_permission_helper.dart`.
/// The two differ only in how they reach the permission set: the analyzer tree
/// holds a nullable `D4rt` on its module loader, whereas here the
/// [ModuleContext] interface owns `checkPermission` and is permissive by
/// default when no checker is configured.
library;

import 'dart:io';

import 'package:tom_d4rt_ast/runtime.dart';

/// Asserts the script may read [path]. Throws otherwise.
void checkFilesystemReadPermission(InterpreterVisitor visitor, String path,
    {String operation = 'read'}) {
  _checkFilesystemPermission(visitor, path,
      operation: operation, read: true, write: false);
}

/// Asserts the script may write [path]. Throws otherwise.
void checkFilesystemWritePermission(InterpreterVisitor visitor, String path,
    {String operation = 'write'}) {
  _checkFilesystemPermission(visitor, path,
      operation: operation, read: false, write: true);
}

void _checkFilesystemPermission(
  InterpreterVisitor visitor,
  String path, {
  required String operation,
  required bool read,
  required bool write,
}) {
  // Match on absolute paths: the grant is canonicalized the same way, and a
  // relative operation path would otherwise never fall inside an absolute
  // scope.
  final normalizedPath = File(path).absolute.path;
  final allowed = visitor.moduleContext.checkPermission({
    'type': 'filesystem',
    'path': normalizedPath,
    'read': read,
    'write': write,
    'execute': false,
  });

  if (allowed) return;

  throw RuntimeD4rtException(
      'Filesystem permission denied for $operation on "$path". '
      'Grant an appropriate FilesystemPermission for this path.');
}
