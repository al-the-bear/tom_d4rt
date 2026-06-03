/// Source-agnostic discovery and loading of the multi-file D4rt sample apps.
///
/// Desktop builds read the live `example/` tree off disk so edits show up on
/// the next reload. Mobile builds (iOS / iPadOS / Android) have no access to
/// the workspace filesystem, so they read a bundled snapshot produced by
/// `tool/sync_samples_to_assets.dart` from Flutter assets instead.
///
/// Both paths converge on a [SampleProgram] — a `{libraryUri: source}` map
/// plus an entry-point URI — that feeds straight into
/// `SourceFlutterD4rt.buildProgram`. The interpreter never touches the
/// filesystem itself: relative imports are pre-resolved into the map here.
library;

import 'dart:convert';
import 'dart:io' show Directory, File, Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:tom_d4rt/d4rt.dart' show resolveImportsRecursively;

/// A single discoverable sample app.
class SampleAppEntry {
  /// Directory name of the sample — display label and selection key.
  final String name;

  /// Opaque locator interpreted by the [SampleSource] that produced this
  /// entry. Disk source: absolute path to the sample's `main.dart`. Asset
  /// source: the sample's key in the bundled manifest (its folder name).
  final String locator;

  const SampleAppEntry({required this.name, required this.locator});

  @override
  bool operator ==(Object other) =>
      other is SampleAppEntry &&
      other.name == name &&
      other.locator == locator;

  @override
  int get hashCode => Object.hash(name, locator);
}

/// A fully-resolved multi-file program ready for the interpreter.
///
/// [sources] maps every file's URI to its source text — including all
/// transitively-imported relative files — so the interpreter needs no
/// further I/O. [libraryUri] is the entry point (`main.dart`).
class SampleProgram {
  final String libraryUri;
  final String basePath;
  final Map<String, String> sources;

  const SampleProgram({
    required this.libraryUri,
    required this.basePath,
    required this.sources,
  });
}

/// Strategy for enumerating and loading samples on a given platform.
abstract class SampleSource {
  /// Human-readable description of where samples come from — surfaced in the
  /// UI when none are found.
  String get rootLabel;

  /// Whether the sample root is currently reachable (disk dir exists / asset
  /// manifest present). Asset sources are always considered available.
  Future<bool> get available;

  /// Enumerate the available samples, sorted by name.
  Future<List<SampleAppEntry>> list();

  /// Resolve [entry] into a runnable [SampleProgram].
  Future<SampleProgram> loadProgram(SampleAppEntry entry);
}

/// `true` on iOS / iPadOS / Android, where the workspace filesystem is
/// unavailable and samples must come from bundled assets.
bool get isMobileRuntime =>
    !kIsWeb && (Platform.isIOS || Platform.isAndroid);

/// Picks the right [SampleSource] for the current platform.
SampleSource createSampleSource() =>
    isMobileRuntime ? AssetSampleSource() : DiskSampleSource();

// ─────────────────────────────────────────────────────────────────────────
// Disk-backed source (desktop)
// ─────────────────────────────────────────────────────────────────────────

/// Reads the live `example/` tree, resolving relative imports off disk.
///
/// Locates the example root by walking up from the running executable so the
/// lookup works for `flutter run`, macOS `.app` bundles, and packaged
/// Linux / Windows builds — then falls back to a CWD-relative path.
class DiskSampleSource implements SampleSource {
  final String root;

  DiskSampleSource() : root = _defaultExampleRoot();

  static String _defaultExampleRoot() {
    var cur = File(Platform.resolvedExecutable).parent.path;
    for (var i = 0; i < 12; i++) {
      final scoped = p.join(cur, 'tom_d4rt_flutter_test/example');
      if (Directory(scoped).existsSync()) return p.normalize(scoped);
      final parent = p.dirname(cur);
      if (parent == cur) break;
      cur = parent;
    }
    return p.normalize('example');
  }

  @override
  String get rootLabel => root;

  @override
  Future<bool> get available async => Directory(root).existsSync();

  @override
  Future<List<SampleAppEntry>> list() async {
    final dir = Directory(root);
    if (!dir.existsSync()) return const [];
    final result = <SampleAppEntry>[];
    for (final entity in dir.listSync()) {
      if (entity is! Directory) continue;
      final mainFile = File(p.join(entity.path, 'main.dart'));
      if (!mainFile.existsSync()) continue;
      result.add(SampleAppEntry(
        name: p.basename(entity.path),
        locator: mainFile.path,
      ));
    }
    result.sort((a, b) => a.name.compareTo(b.name));
    return result;
  }

  @override
  Future<SampleProgram> loadProgram(SampleAppEntry entry) async =>
      buildDiskProgram(entry.locator);
}

/// Builds a [SampleProgram] from a `main.dart` on disk, recursively pulling
/// in every relative import. Shared by [DiskSampleSource] and
/// `SourceFlutterD4rt.buildMultiFile`.
SampleProgram buildDiskProgram(String mainFilePath) {
  final mainFile = File(mainFilePath);
  if (!mainFile.existsSync()) {
    throw SampleLoadException('Sample entry point not found: $mainFilePath');
  }
  final fullPath = mainFile.resolveSymbolicLinksSync();
  final libraryUri = 'file://$fullPath';
  final sources = <String, String>{};
  resolveImportsRecursively(
    mainFile.readAsStringSync(),
    libraryUri,
    sources,
    null,
  );
  return SampleProgram(
    libraryUri: libraryUri,
    basePath: mainFile.parent.path,
    sources: sources,
  );
}

// ─────────────────────────────────────────────────────────────────────────
// Asset-backed source (mobile)
// ─────────────────────────────────────────────────────────────────────────

/// Reads the snapshot bundled by `tool/sync_samples_to_assets.dart` from
/// Flutter assets. The manifest at `assets/samples/index.json` lists each
/// sample and its `.dart` files; sources are loaded via [rootBundle].
class AssetSampleSource implements SampleSource {
  static const _manifestKey = 'assets/samples/index.json';

  /// Parsed manifest entries, cached after the first read.
  List<_AssetSample>? _manifest;

  Future<List<_AssetSample>> _loadManifest() async {
    if (_manifest != null) return _manifest!;
    final raw = await rootBundle.loadString(_manifestKey);
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final samples = (json['samples'] as List)
        .cast<Map<String, dynamic>>()
        .map((m) => _AssetSample(
              name: m['name'] as String,
              main: m['main'] as String,
              files: (m['files'] as List).cast<String>(),
            ))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    return _manifest = samples;
  }

  @override
  String get rootLabel => 'bundled assets ($_manifestKey)';

  @override
  Future<bool> get available async {
    try {
      await _loadManifest();
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<List<SampleAppEntry>> list() async {
    final manifest = await _loadManifest();
    return [
      for (final s in manifest)
        SampleAppEntry(name: s.name, locator: s.name),
    ];
  }

  @override
  Future<SampleProgram> loadProgram(SampleAppEntry entry) async {
    final manifest = await _loadManifest();
    final sample = manifest.firstWhere(
      (s) => s.name == entry.locator,
      orElse: () =>
          throw SampleLoadException('Unknown bundled sample: ${entry.locator}'),
    );

    // Synthetic absolute paths give the interpreter stable file:// URIs to
    // resolve relative imports against — mirroring the disk layout without
    // touching a real filesystem (the iOS sandbox has none to mirror).
    final base = '/samples/${sample.name}';
    final sources = <String, String>{};
    for (final rel in sample.files) {
      final assetKey = 'assets/samples/${sample.name}/$rel';
      final src = await rootBundle.loadString(assetKey);
      sources['file://$base/$rel'] = src;
    }
    final libraryUri = 'file://$base/${sample.main}';
    if (!sources.containsKey(libraryUri)) {
      throw SampleLoadException(
        'Bundled sample ${sample.name} has no ${sample.main}',
      );
    }
    return SampleProgram(
      libraryUri: libraryUri,
      basePath: base,
      sources: sources,
    );
  }
}

class _AssetSample {
  final String name;
  final String main;
  final List<String> files;
  const _AssetSample({
    required this.name,
    required this.main,
    required this.files,
  });
}

/// Thrown when a sample cannot be located or read by a [SampleSource].
class SampleLoadException implements Exception {
  final String message;
  const SampleLoadException(this.message);
  @override
  String toString() => 'SampleLoadException: $message';
}
