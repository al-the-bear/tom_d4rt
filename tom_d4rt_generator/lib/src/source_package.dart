/// Where a source file sits in its package, read from the file system.
library;

import 'dart:io';

/// The package a source file belongs to: the directory holding the `lib/`
/// the file is under, the name that directory's `pubspec.yaml` declares, and
/// the file's path below `lib/`.
///
/// SCF32. Every question of this shape used to be answered by searching the
/// raw path for `'/lib/'`, written out six times across the generator. A
/// Windows path holds `\lib\`, so on Windows every one of them answered "no
/// package" — and the element-mode walker, which resolves a library by its
/// `package:` URI, found nothing for any SDK or pub-cache library. The
/// generator emitted 24 classes there where macOS emits 2015. This is the one
/// place that asks, and it normalises separators first.
///
/// Paths it returns are `/`-separated whatever the input used. `dart:io`
/// accepts that spelling on Windows, and a `package:` URI requires it.
class SourcePackage {
  const SourcePackage._(this.root, this.name, this.libRelativePath);

  /// The package directory, `/`-separated.
  final String root;

  /// The `name:` declared by the package's `pubspec.yaml`, or null when that
  /// file is missing or declares none.
  final String? name;

  /// The source file's path below `lib/`, `/`-separated.
  final String libRelativePath;

  /// `package:<name>/<libRelativePath>`, or null when [name] is unknown.
  String? get packageUri =>
      name == null ? null : 'package:$name/$libRelativePath';

  /// The package [sourcePath] belongs to, or null when it is not under a
  /// `lib/` directory at all.
  ///
  /// The FIRST `lib/` segment is the one used, as every former copy did.
  static SourcePackage? of(String sourcePath) {
    final posix = sourcePath.replaceAll(r'\', '/');
    final libIndex = posix.indexOf('/lib/');
    if (libIndex == -1) return null;
    final root = posix.substring(0, libIndex);
    return SourcePackage._(
      root,
      _pubspecName(root),
      posix.substring(libIndex + '/lib/'.length),
    );
  }

  static final _namePattern = RegExp(r'^name:\s*(\S+)', multiLine: true);

  static String? _pubspecName(String root) {
    try {
      final pubspec = File('$root/pubspec.yaml');
      if (!pubspec.existsSync()) return null;
      return _namePattern.firstMatch(pubspec.readAsStringSync())?.group(1);
    } on FileSystemException {
      return null;
    }
  }
}
