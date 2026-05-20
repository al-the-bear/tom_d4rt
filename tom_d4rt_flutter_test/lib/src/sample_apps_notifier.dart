/// Discovery and selection of multi-file D4rt sample apps shipped under
/// `tom_d4rt_flutter_test/example/`.
///
/// A sample app is any immediate subdirectory of the example root that
/// contains a `main.dart` file. Each sample is loaded as a full D4rt
/// program — `main.dart` plus every relative-imported `.dart` file —
/// via [SourceFlutterD4rt.buildMultiFile].
library;

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;

/// A single discoverable sample app.
class SampleAppEntry {
  /// Directory name of the sample, used as a display label and dropdown key.
  final String name;

  /// Absolute path to the sample's `main.dart` entry point.
  final String mainPath;

  const SampleAppEntry({required this.name, required this.mainPath});

  @override
  bool operator ==(Object other) =>
      other is SampleAppEntry &&
      other.name == name &&
      other.mainPath == mainPath;

  @override
  int get hashCode => Object.hash(name, mainPath);
}

/// Filesystem scanner: locates the example root and enumerates sample apps.
///
/// Mirrors the resolution strategy used by `TestScriptLoader.defaultRoot` —
/// walks up from the running executable looking for the sibling
/// `tom_d4rt_flutter_test/example/` directory so the lookup works for
/// `flutter run`, macOS `.app` bundles, and packaged Linux/Windows builds.
class ExampleLoader {
  static String get defaultExampleRoot {
    // Walk up from the running executable looking for our own project
    // folder; the `example/` directory sits directly inside it. The loop
    // covers macOS `.app` bundle depth (build/macos/Build/Products/Debug/
    // Runner.app/Contents/MacOS — eight levels) plus a small buffer for
    // future layout drift.
    var cur = File(Platform.resolvedExecutable).parent.path;
    for (var i = 0; i < 12; i++) {
      final scoped = p.join(cur, 'tom_d4rt_flutter_test/example');
      if (Directory(scoped).existsSync()) return p.normalize(scoped);
      final parent = p.dirname(cur);
      if (parent == cur) break;
      cur = parent;
    }
    // Fallback: CWD-relative (works for `flutter run` from the project root).
    return p.normalize('example');
  }

  static bool rootExists(String root) => Directory(root).existsSync();

  /// Return every immediate subdirectory of [root] that contains a
  /// `main.dart`, sorted alphabetically by folder name.
  static List<SampleAppEntry> loadAll(String root) {
    final dir = Directory(root);
    if (!dir.existsSync()) return const [];
    final result = <SampleAppEntry>[];
    for (final entity in dir.listSync()) {
      if (entity is! Directory) continue;
      final mainFile = File(p.join(entity.path, 'main.dart'));
      if (!mainFile.existsSync()) continue;
      result.add(SampleAppEntry(
        name: p.basename(entity.path),
        mainPath: mainFile.path,
      ));
    }
    result.sort((a, b) => a.name.compareTo(b.name));
    return result;
  }
}

/// Reactive holder for the discovered sample list and the current selection.
///
/// The list is loaded once at construction; callers can [reload] to pick up
/// new folders added on disk while the app is running.
class SampleAppsNotifier extends ChangeNotifier {
  final String _root;
  List<SampleAppEntry> _samples;
  SampleAppEntry? _selected;

  SampleAppsNotifier()
      : _root = ExampleLoader.defaultExampleRoot,
        _samples = const [] {
    _refresh();
  }

  String get root => _root;
  bool get rootExists => ExampleLoader.rootExists(_root);
  List<SampleAppEntry> get samples => _samples;
  SampleAppEntry? get selected => _selected;

  /// Pick a different sample. No-op (and no notification) when the entry
  /// already matches the current selection.
  void select(SampleAppEntry? entry) {
    if (entry == _selected) return;
    _selected = entry;
    notifyListeners();
  }

  /// Re-scan the example root for added/removed sample folders.
  void reload() {
    _refresh();
    notifyListeners();
  }

  void _refresh() {
    _samples = ExampleLoader.loadAll(_root);
    if (_samples.isEmpty) {
      _selected = null;
    } else if (_selected == null ||
        !_samples.any((s) => s.name == _selected!.name)) {
      _selected = _samples.first;
    }
  }
}
