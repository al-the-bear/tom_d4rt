/// Bundles the multi-file sample apps under `example/` into Flutter assets
/// so they can run on platforms with no workspace filesystem access
/// (iOS / iPadOS / Android).
///
/// What it does:
///   1. Scans `example/<name>/` for every immediate subdirectory containing
///      a `main.dart`.
///   2. Mirrors all `.dart` files of each sample into
///      `assets/samples/<name>/...` (preserving relative sub-paths).
///   3. Writes `assets/samples/index.json` — the manifest the app reads at
///      runtime to enumerate samples and resolve their source files.
///   4. Rewrites the generated asset block in `pubspec.yaml` so every
///      sample directory is declared (Flutter does not bundle nested asset
///      directories recursively — each must be listed explicitly).
///
/// Run from the project root:
///
///     dart run tool/sync_samples_to_assets.dart
///
/// Re-run after adding, removing, or editing any sample. The `assets/samples`
/// tree and the generated pubspec block are fully regenerated each run, so
/// stale samples are pruned automatically.
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;

/// Markers delimiting the auto-generated asset list inside `pubspec.yaml`.
/// Everything between them is owned by this script and rewritten on each run.
const _beginMarker =
    '  # >>> BEGIN generated sample assets (tool/sync_samples_to_assets.dart) <<<';
const _endMarker =
    '  # >>> END generated sample assets <<<';

void main(List<String> args) {
  final projectRoot = Directory.current.path;
  final exampleRoot = Directory(p.join(projectRoot, 'example'));
  if (!exampleRoot.existsSync()) {
    stderr.writeln('error: example/ not found under $projectRoot — run from '
        'the d4rt_flutter_sample project root.');
    exitCode = 1;
    return;
  }

  final assetsRoot = Directory(p.join(projectRoot, 'assets', 'samples'));

  // 1. Discover samples (immediate subdir of example/ containing main.dart).
  final samples = <_Sample>[];
  for (final entity in exampleRoot.listSync()) {
    if (entity is! Directory) continue;
    final mainFile = File(p.join(entity.path, 'main.dart'));
    if (!mainFile.existsSync()) continue;

    final files = entity
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .map((f) => p.relative(f.path, from: entity.path))
        // Normalise to forward slashes for stable asset keys / URIs.
        .map((rel) => rel.replaceAll(r'\', '/'))
        .toList()
      ..sort();

    samples.add(_Sample(name: p.basename(entity.path), files: files));
  }
  samples.sort((a, b) => a.name.compareTo(b.name));

  if (samples.isEmpty) {
    stderr.writeln('error: no samples with a main.dart found under example/.');
    exitCode = 1;
    return;
  }

  // 2. Clear and recreate the asset mirror so deleted files/samples vanish.
  if (assetsRoot.existsSync()) assetsRoot.deleteSync(recursive: true);
  assetsRoot.createSync(recursive: true);

  var copiedFiles = 0;
  for (final sample in samples) {
    for (final rel in sample.files) {
      final src = File(p.join(exampleRoot.path, sample.name, rel));
      final dst = File(p.join(assetsRoot.path, sample.name, rel));
      dst.parent.createSync(recursive: true);
      dst.writeAsStringSync(src.readAsStringSync());
      copiedFiles++;
    }
  }

  // 3. Write the manifest.
  final index = {
    'generated': 'tool/sync_samples_to_assets.dart',
    'samples': [
      for (final s in samples)
        {'name': s.name, 'main': 'main.dart', 'files': s.files},
    ],
  };
  File(p.join(assetsRoot.path, 'index.json'))
      .writeAsStringSync('${const JsonEncoder.withIndent('  ').convert(index)}\n');

  // 4. Rewrite the generated asset block in pubspec.yaml.
  _rewritePubspecAssets(p.join(projectRoot, 'pubspec.yaml'), samples);

  stdout.writeln('Bundled ${samples.length} samples '
      '($copiedFiles .dart files) into assets/samples/.');
  stdout.writeln('Manifest: assets/samples/index.json');
  stdout.writeln('pubspec.yaml asset block regenerated.');
}

/// Replaces (or inserts) the marker-delimited asset list under the `flutter:`
/// key. The block declares `assets/samples/index.json` plus one entry per
/// sample directory.
void _rewritePubspecAssets(String pubspecPath, List<_Sample> samples) {
  final pubspec = File(pubspecPath);
  final lines = pubspec.readAsLinesSync();

  final block = <String>[
    _beginMarker,
    '  assets:',
    '    - assets/samples/index.json',
    for (final s in samples) '    - assets/samples/${s.name}/',
    _endMarker,
  ];

  final beginIdx = lines.indexWhere((l) => l.trimRight() == _beginMarker);
  final endIdx = lines.indexWhere((l) => l.trimRight() == _endMarker);

  final List<String> out;
  if (beginIdx != -1 && endIdx != -1 && endIdx > beginIdx) {
    // Replace the existing block in place.
    out = [
      ...lines.sublist(0, beginIdx),
      ...block,
      ...lines.sublist(endIdx + 1),
    ];
  } else {
    // Insert immediately after `uses-material-design:` (or under flutter:).
    var anchor = lines.indexWhere((l) => l.contains('uses-material-design:'));
    if (anchor == -1) {
      anchor = lines.indexWhere((l) => l.trimRight() == 'flutter:');
    }
    if (anchor == -1) {
      stderr.writeln('error: could not find a `flutter:` section in '
          'pubspec.yaml to anchor generated assets.');
      exitCode = 1;
      return;
    }
    out = [
      ...lines.sublist(0, anchor + 1),
      ...block,
      ...lines.sublist(anchor + 1),
    ];
  }

  pubspec.writeAsStringSync('${out.join('\n')}\n');
}

class _Sample {
  final String name;
  final List<String> files;
  const _Sample({required this.name, required this.files});
}
