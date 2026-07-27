/// Native implementation of the file-access shim. See `file_access.dart`.
library;

import 'dart:io';
import 'dart:typed_data';

/// Whether a regular file exists at [path].
bool fileExistsSync(String path) => File(path).existsSync();

/// Reads [path] in full. The caller is expected to have checked
/// [fileExistsSync] first — this deliberately does not translate a missing
/// file into a null, so a race surfaces as the underlying `FileSystemException`
/// rather than a silent empty read.
Uint8List readFileAsBytesSync(String path) => File(path).readAsBytesSync();

/// Asynchronous counterpart of [readFileAsBytesSync].
Future<Uint8List> readFileAsBytes(String path) => File(path).readAsBytes();

/// Writes [bytes] to [path], creating any missing parent directories.
void writeFileAsBytesSync(String path, List<int> bytes) {
  final file = File(path);
  file.parent.createSync(recursive: true);
  file.writeAsBytesSync(bytes);
}
