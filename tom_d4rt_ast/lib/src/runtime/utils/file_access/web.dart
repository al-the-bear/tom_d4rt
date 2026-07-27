/// Web implementation of the file-access shim. See `file_access.dart`.
///
/// There is no filesystem here. Every entry point throws rather than
/// pretending to succeed: a bundle that silently loaded as empty would fail
/// much later, somewhere in the interpreter, with a message that says nothing
/// about the real cause.
library;

import 'dart:typed_data';

/// Always `false` — web has no filesystem to look in.
///
/// Returning `false` rather than throwing lets callers keep their
/// "does it exist?" branch, which produces the caller's own domain error
/// (e.g. `Bundle file not found`) instead of a shim-level one.
bool fileExistsSync(String path) => false;

Uint8List readFileAsBytesSync(String path) => throw _unsupported('read', path);

Future<Uint8List> readFileAsBytes(String path) =>
    throw _unsupported('read', path);

void writeFileAsBytesSync(String path, List<int> bytes) =>
    throw _unsupported('write', path);

UnsupportedError _unsupported(String operation, String path) =>
    UnsupportedError(
      'Cannot $operation "$path": file access is not available on web. '
      'Load the bundle bytes yourself (e.g. over HTTP or from an asset) and '
      'use AstBundle.fromBytes / AstBundle.fromZip / D4rtRunner.parseJson '
      'instead of the file-based convenience methods.',
    );
