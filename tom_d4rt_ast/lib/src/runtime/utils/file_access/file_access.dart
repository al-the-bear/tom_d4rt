/// Platform-swapped file access for the bundle/AST loading convenience APIs.
///
/// `AstBundle.fromFile`/`saveToFile` and `D4rtRunner.parseJsonFile`/
/// `executeFromJsonFile` are host-side conveniences: they read a bundle off
/// disk. A web consumer gets its bundle over the network instead and uses the
/// byte-level entry points (`AstBundle.fromBytes`, `fromZip`,
/// `D4rtRunner.parseJson`) — but it must still be able to *import* the library
/// that declares the file-based ones.
///
/// So the `dart:io` usage lives here, behind a conditional import, and the web
/// side throws [UnsupportedError] rather than failing to compile. This is the
/// same shape as `security/current_directory_io.dart` and
/// `utils/logger/logger.dart`.
///
/// Note that GZIP is deliberately NOT part of this shim: `package:archive`'s
/// `GZipEncoder`/`GZipDecoder` already pick the native `dart:io` codec on
/// native and a pure-Dart one on web, so the compression path needs no
/// conditional of its own.
library;

export 'io.dart' if (dart.library.html) 'web.dart';
