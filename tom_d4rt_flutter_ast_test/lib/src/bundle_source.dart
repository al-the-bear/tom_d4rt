/// Loads pre-compiled [AstBundle]s from Flutter assets.
///
/// This is the analyzer-free counterpart to the source-based
/// `tom_d4rt_flutter_test` app. Rather than shipping `.dart` source and
/// compiling it on the device (which needs the analyzer and a filesystem),
/// the bundles are compiled at build time by
/// `tool/compile_samples_to_bundles.dart` into `assets/bundles/<name>.json`.
///
/// On-device this class reads those JSON assets — works identically on web,
/// desktop, and mobile because the runtime never touches the analyzer or
/// `dart:io`. The manifest at `assets/bundles/index.json` lists every bundle.
library;

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;
import 'package:tom_d4rt_flutter_ast/tom_d4rt_flutter_ast.dart';

/// A single pre-compiled sample, identified by its name (the example folder it
/// was compiled from). The bundle JSON lives at `assets/bundles/<name>.json`.
class BundleEntry {
  /// Display label and asset key stem.
  final String name;

  const BundleEntry(this.name);

  @override
  bool operator ==(Object other) =>
      other is BundleEntry && other.name == name;

  @override
  int get hashCode => name.hashCode;
}

/// Reads the bundle manifest and individual bundle JSON files from assets.
class BundleSource {
  static const _manifestKey = 'assets/bundles/index.json';

  List<BundleEntry>? _entries;

  /// Enumerate the available bundles, sorted by name. Returns an empty list
  /// (rather than throwing) when no bundles have been compiled yet.
  Future<List<BundleEntry>> list() async {
    if (_entries != null) return _entries!;
    final String raw;
    try {
      raw = await rootBundle.loadString(_manifestKey);
    } catch (_) {
      // Manifest missing — no bundles compiled yet.
      return _entries = const [];
    }
    final json = jsonDecode(raw) as Map<String, dynamic>;
    final bundles = (json['bundles'] as List? ?? const [])
        .cast<Map<String, dynamic>>()
        .map((m) => BundleEntry(m['name'] as String))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    return _entries = bundles;
  }

  /// Load and deserialize the [AstBundle] for [entry].
  Future<AstBundle> load(BundleEntry entry) async {
    final raw =
        await rootBundle.loadString('assets/bundles/${entry.name}.json');
    return AstBundle.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }
}
