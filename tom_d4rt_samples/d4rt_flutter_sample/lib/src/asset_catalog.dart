/// App-local catalogue of every bundled `.dart` file, for the **Files** and
/// **Paste & Run** tabs.
///
/// This is deliberately separate from `tom_d4rt_flutter`'s [AssetSampleSource]
/// (which the *run* path uses). That loader only exposes runnable samples; the
/// Files tab additionally needs to browse the hand-authored
/// `copy-paste-samples` group, which must never appear in the run gallery. So
/// this catalogue reads the manifests directly and tags each group as runnable
/// or not.
library;

import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

/// One browsable file inside a [SampleFiles] group.
class FileNode {
  /// Path relative to the group root, e.g. `main.dart` or `lib/foo.dart`.
  final String relPath;

  /// Full `rootBundle` asset key used to load the content.
  final String assetKey;

  const FileNode({required this.relPath, required this.assetKey});
}

/// A named group of files shown as one node in the Files tree.
class SampleFiles {
  /// Display name (the sample's folder name, or `copy-paste-samples`).
  final String name;

  /// The group's files, sorted by [FileNode.relPath].
  final List<FileNode> files;

  /// Whether the group is a runnable sample app (`true`) or a collection of
  /// copy-paste snippets (`false`). The run gallery shows only runnable groups.
  final bool runnable;

  const SampleFiles({
    required this.name,
    required this.files,
    required this.runnable,
  });
}

/// Reads the two asset manifests and exposes them as browsable file groups.
///
/// Results are cached after the first read. All I/O goes through [rootBundle],
/// so the catalogue works identically on desktop, mobile, and web.
class AssetCatalog {
  static const _samplesManifest = 'assets/samples/index.json';
  static const _pasteManifest = 'assets/copy_paste_samples/index.json';

  List<SampleFiles>? _groups;

  /// Every group: the runnable samples first, then the copy-paste snippets.
  Future<List<SampleFiles>> groups() async {
    if (_groups != null) return _groups!;

    final groups = <SampleFiles>[];

    // Runnable samples (same manifest the run path reads).
    final samplesRaw = await rootBundle.loadString(_samplesManifest);
    final samplesJson = jsonDecode(samplesRaw) as Map<String, dynamic>;
    for (final m in (samplesJson['samples'] as List).cast<Map<String, dynamic>>()) {
      final name = m['name'] as String;
      groups.add(SampleFiles(
        name: name,
        runnable: true,
        files: _nodes(
          (m['files'] as List).cast<String>(),
          (rel) => 'assets/samples/$name/$rel',
        ),
      ));
    }

    // Copy-paste snippets (best-effort — absence is not an error).
    try {
      final pasteRaw = await rootBundle.loadString(_pasteManifest);
      final pasteJson = jsonDecode(pasteRaw) as Map<String, dynamic>;
      final name = pasteJson['name'] as String? ?? 'copy-paste-samples';
      groups.add(SampleFiles(
        name: name,
        runnable: false,
        files: _nodes(
          (pasteJson['files'] as List).cast<String>(),
          (rel) => 'assets/copy_paste_samples/$rel',
        ),
      ));
    } catch (_) {
      // No snippet manifest bundled — Files tab simply omits the group.
    }

    return _groups = groups;
  }

  /// The copy-paste snippet files (the non-runnable groups, flattened) — the
  /// "Load snippet" source for the Paste & Run tab.
  Future<List<FileNode>> snippets() async => [
        for (final g in await groups())
          if (!g.runnable) ...g.files,
      ];

  /// Load a file's source text.
  Future<String> loadContent(FileNode node) =>
      rootBundle.loadString(node.assetKey);

  static List<FileNode> _nodes(
    List<String> rels,
    String Function(String rel) keyFor,
  ) {
    final sorted = [...rels]..sort();
    return [
      for (final rel in sorted) FileNode(relPath: rel, assetKey: keyFor(rel)),
    ];
  }
}
