/// Run code that writes generated files into a package, with those writes
/// landing in a scratch tree instead — and with every read seeing what an
/// in-place run would see.
///
/// This is the mechanism behind `checkBridgeFreshness`, kept apart from it
/// because it is about `dart:io`, not about bridges.
///
/// THE OVERLAY RULE. Within the package, the scratch tree lies over the
/// package: a path whose scratch counterpart exists resolves to the scratch
/// copy, every other path resolves to the package. The scratch tree starts
/// empty and only ever receives what the zone's code writes, so a read returns
/// the fresh file when this run produced it and the committed file otherwise —
/// which is exactly what the same code would read when writing in place.
///
/// Reads MUST keep resolving to the package. Redirecting them too was tried
/// and is observably wrong: packages import their own generated files
/// (`tom_build_cli` imports its `dartscript.b.dart`), so the analyzer then
/// meets one library under two URIs and fails with a library-cycle error.
///
/// WHAT IS REDIRECTED. Writes to files in the package whose name ends in
/// [redirectedSuffix]; the parent directories of those writes; and directories
/// that do not exist in the package, so creating one does not leave an empty
/// directory behind — except the scratch tree's own ancestors, which are
/// created where they belong. Other package files are read and written as
/// usual. A
/// mutation of a redirected file that is not a write or a create — `delete`,
/// `rename`, `setLastModified` — throws [UnsupportedError] rather than silently
/// reaching the package: an unexplained write is a failure, not a result.
///
/// One asymmetry is accepted: listing a directory that exists in the package
/// shows the package's entries, not files this run added to it. Generation
/// does not list its own output directories, and merging listings would put
/// the overlay in the path of every source enumeration the analyzer makes.
///
/// WHAT IS NOT. Anything that bypasses `dart:io`'s [File] and [Directory]
/// constructors — a subprocess, an isolate, `Link` — is outside the zone.
library;

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path/path.dart' as p;

/// Run [body] with writes to [redirectedSuffix] files in [packageRoot]
/// redirected under [scratchRoot], per the overlay rule in this library's
/// documentation. [scratchRoot] must lie inside [packageRoot].
Future<T> runWithScratchOverlay<T>({
  required String packageRoot,
  required String scratchRoot,
  required Future<T> Function() body,
  String redirectedSuffix = '.b.dart',
}) {
  // Why an explicit context: the default one asks `Directory.current` for the
  // working directory, and that getter constructs a `Directory` — which inside
  // the zone re-enters [_ScratchOverlay.createDirectory], which resolves a path
  // through the default context again. Capturing the directory here, before
  // the zone exists, breaks the cycle.
  final paths = p.Context(current: Directory.current.path);
  final overlay = _ScratchOverlay(
    paths,
    paths.normalize(paths.absolute(packageRoot)),
    paths.normalize(paths.absolute(scratchRoot)),
    redirectedSuffix,
  );
  return IOOverrides.runWithIOOverrides(body, overlay);
}

/// Extends [IOOverrides] rather than using `IOOverrides.runZoned`: the
/// superclass members build the real entities, whereas calling `File(...)`
/// from inside a `runZoned` callback re-enters the callback.
final class _ScratchOverlay extends IOOverrides {
  _ScratchOverlay(
    this.paths,
    this.packageRoot,
    this.scratchRoot,
    this.redirectedSuffix,
  );

  /// Path arithmetic that never consults `Directory.current`; see
  /// [runWithScratchOverlay].
  final p.Context paths;
  final String packageRoot;
  final String scratchRoot;
  final String redirectedSuffix;

  /// The scratch counterpart of [path], or null when [path] is not covered by
  /// the overlay: outside the package, the scratch tree itself or anything in
  /// it, or an ANCESTOR of the scratch tree.
  ///
  /// Why ancestors: creating the scratch tree creates them. Were a missing one
  /// redirected, its counterpart would lie inside the scratch tree, whose
  /// creation needs that same ancestor — and `createSync(recursive: true)`
  /// would chase the pair until the stack overflowed.
  String? _counterpart(String path) {
    final absolute = paths.normalize(paths.absolute(path));
    if (!paths.isWithin(packageRoot, absolute) ||
        paths.equals(scratchRoot, absolute) ||
        paths.isWithin(scratchRoot, absolute) ||
        paths.isWithin(absolute, scratchRoot)) {
      return null;
    }
    return paths.join(scratchRoot, paths.relative(absolute, from: packageRoot));
  }

  /// The path a read of [path] should use.
  ///
  /// A directory present in the package always resolves to the package, even
  /// when a write has created its counterpart: after the first write under
  /// `lib/`, the scratch `lib/` holds one file, and resolving there would hide
  /// every source from a directory listing.
  String _readPath(String path) {
    final counterpart = _counterpart(path);
    if (counterpart == null) return path;
    final inScratch = super.fseGetTypeSync(counterpart, true);
    if (inScratch == FileSystemEntityType.notFound) return path;
    if (inScratch == FileSystemEntityType.directory &&
        super.fseGetTypeSync(path, true) == FileSystemEntityType.directory) {
      return path;
    }
    return counterpart;
  }

  File _real(String path) => super.createFile(path);

  Directory _realDirectory(String path) => super.createDirectory(path);

  @override
  File createFile(String path) {
    final counterpart = _counterpart(path);
    if (counterpart == null || !path.endsWith(redirectedSuffix)) {
      return super.createFile(path);
    }
    return _OverlaidFile(this, path, counterpart);
  }

  @override
  Directory createDirectory(String path) {
    final counterpart = _counterpart(path);
    if (counterpart == null) return super.createDirectory(path);
    final inPackage = super.createDirectory(path);
    return inPackage.existsSync()
        ? inPackage
        : super.createDirectory(counterpart);
  }

  @override
  Future<FileSystemEntityType> fseGetType(String path, bool followLinks) =>
      super.fseGetType(_readPath(path), followLinks);

  @override
  FileSystemEntityType fseGetTypeSync(String path, bool followLinks) =>
      super.fseGetTypeSync(_readPath(path), followLinks);

  @override
  Future<FileStat> stat(String path) => super.stat(_readPath(path));

  @override
  FileStat statSync(String path) => super.statSync(_readPath(path));
}

/// A package file whose reads follow the overlay and whose writes land in the
/// scratch tree. [path] stays the package path, so URIs derived from it — the
/// analyzer's among them — are the ones an in-place run would derive.
final class _OverlaidFile implements File {
  _OverlaidFile(this._overlay, this.path, this._scratchPath);

  final _ScratchOverlay _overlay;
  final String _scratchPath;

  @override
  final String path;

  File get _reader => _overlay._real(_overlay._readPath(path));

  File get _scratch => _overlay._real(_scratchPath);

  File _writer() {
    _overlay
        ._realDirectory(_overlay.paths.dirname(_scratchPath))
        .createSync(recursive: true);
    return _scratch;
  }

  Never _refuse(String operation) => throw UnsupportedError(
    '$operation on $path inside a scratch overlay: only writes are '
    'redirected, and this would modify the package itself.',
  );

  // --- Identity -------------------------------------------------------------

  @override
  Uri get uri => Uri.file(path);

  @override
  bool get isAbsolute => _overlay.paths.isAbsolute(path);

  @override
  File get absolute => File(_overlay.paths.absolute(path));

  @override
  Directory get parent => Directory(_overlay.paths.dirname(path));

  // --- Reads: follow the overlay --------------------------------------------

  @override
  Future<bool> exists() => _reader.exists();

  @override
  bool existsSync() => _reader.existsSync();

  @override
  Future<FileStat> stat() => _reader.stat();

  @override
  FileStat statSync() => _reader.statSync();

  @override
  Future<int> length() => _reader.length();

  @override
  int lengthSync() => _reader.lengthSync();

  @override
  Future<DateTime> lastAccessed() => _reader.lastAccessed();

  @override
  DateTime lastAccessedSync() => _reader.lastAccessedSync();

  @override
  Future<DateTime> lastModified() => _reader.lastModified();

  @override
  DateTime lastModifiedSync() => _reader.lastModifiedSync();

  @override
  Future<String> resolveSymbolicLinks() => _reader.resolveSymbolicLinks();

  @override
  String resolveSymbolicLinksSync() => _reader.resolveSymbolicLinksSync();

  @override
  Stream<List<int>> openRead([int? start, int? end]) =>
      _reader.openRead(start, end);

  @override
  Future<Uint8List> readAsBytes() => _reader.readAsBytes();

  @override
  Uint8List readAsBytesSync() => _reader.readAsBytesSync();

  @override
  Future<String> readAsString({Encoding encoding = utf8}) =>
      _reader.readAsString(encoding: encoding);

  @override
  String readAsStringSync({Encoding encoding = utf8}) =>
      _reader.readAsStringSync(encoding: encoding);

  @override
  Future<List<String>> readAsLines({Encoding encoding = utf8}) =>
      _reader.readAsLines(encoding: encoding);

  @override
  List<String> readAsLinesSync({Encoding encoding = utf8}) =>
      _reader.readAsLinesSync(encoding: encoding);

  @override
  Future<File> copy(String newPath) => _reader.copy(newPath);

  @override
  File copySync(String newPath) => _reader.copySync(newPath);

  @override
  Stream<FileSystemEvent> watch({
    int events = FileSystemEvent.all,
    bool recursive = false,
  }) => _reader.watch(events: events, recursive: recursive);

  // --- Writes: land in the scratch tree -------------------------------------

  @override
  Future<File> create({bool recursive = false, bool exclusive = false}) async {
    await _writer().create(exclusive: exclusive);
    return this;
  }

  @override
  void createSync({bool recursive = false, bool exclusive = false}) =>
      _writer().createSync(exclusive: exclusive);

  @override
  Future<File> writeAsBytes(
    List<int> bytes, {
    FileMode mode = FileMode.write,
    bool flush = false,
  }) async {
    await _writer().writeAsBytes(bytes, mode: mode, flush: flush);
    return this;
  }

  @override
  void writeAsBytesSync(
    List<int> bytes, {
    FileMode mode = FileMode.write,
    bool flush = false,
  }) => _writer().writeAsBytesSync(bytes, mode: mode, flush: flush);

  @override
  Future<File> writeAsString(
    String contents, {
    FileMode mode = FileMode.write,
    Encoding encoding = utf8,
    bool flush = false,
  }) async {
    await _writer().writeAsString(
      contents,
      mode: mode,
      encoding: encoding,
      flush: flush,
    );
    return this;
  }

  @override
  void writeAsStringSync(
    String contents, {
    FileMode mode = FileMode.write,
    Encoding encoding = utf8,
    bool flush = false,
  }) => _writer().writeAsStringSync(
    contents,
    mode: mode,
    encoding: encoding,
    flush: flush,
  );

  @override
  IOSink openWrite({
    FileMode mode = FileMode.write,
    Encoding encoding = utf8,
  }) => _writer().openWrite(mode: mode, encoding: encoding);

  @override
  Future<RandomAccessFile> open({FileMode mode = FileMode.read}) =>
      mode == FileMode.read ? _reader.open() : _writer().open(mode: mode);

  @override
  RandomAccessFile openSync({FileMode mode = FileMode.read}) =>
      mode == FileMode.read
      ? _reader.openSync()
      : _writer().openSync(mode: mode);

  // --- Other mutations: refused ---------------------------------------------

  @override
  Future<FileSystemEntity> delete({bool recursive = false}) =>
      _refuse('delete');

  @override
  void deleteSync({bool recursive = false}) => _refuse('deleteSync');

  @override
  Future<File> rename(String newPath) => _refuse('rename');

  @override
  File renameSync(String newPath) => _refuse('renameSync');

  @override
  Future<void> setLastAccessed(DateTime time) => _refuse('setLastAccessed');

  @override
  void setLastAccessedSync(DateTime time) => _refuse('setLastAccessedSync');

  @override
  Future<void> setLastModified(DateTime time) => _refuse('setLastModified');

  @override
  void setLastModifiedSync(DateTime time) => _refuse('setLastModifiedSync');

  @override
  String toString() => "File: '$path' (scratch overlay)";
}
