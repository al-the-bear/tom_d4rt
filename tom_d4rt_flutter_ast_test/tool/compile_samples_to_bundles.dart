/// Compiles the multi-file sample apps under `example/` into pre-compiled
/// [AstBundle] JSON assets so they can run on the analyzer-free
/// [FlutterD4rt] runtime — including on the web.
///
/// ## Why this is a `flutter test`
///
/// Producing a bundle needs two things that only coexist under a Flutter
/// test host:
///   • `dart:ui` — [FlutterD4rt] registers Flutter Material bridges, and the
///     set of bridged library URIs (`d4rt.interpreter.bridgedLibraryUris`)
///     tells [AstBundler] which imports to skip rather than inline. A plain
///     `dart run` cannot import `package:flutter` (no `dart:ui`).
///   • `dart:io` — to read `example/` sources and write the JSON assets.
///
/// `flutter test` (flutter_tester) provides both. The app's *runtime* stays
/// analyzer-free; the analyzer toolchain (`tom_ast_generator`) is a
/// dev-dependency used only here.
///
/// ## What it does
///   1. Scans `example/<name>/` for every subdir containing a `main.dart`.
///   2. Compiles each (following relative imports) into an [AstBundle] and
///      writes `assets/bundles/<name>.json`.
///   3. Writes `assets/bundles/index.json` — the manifest the app reads to
///      enumerate bundles.
///   4. Rewrites the generated asset block in `pubspec.yaml`.
///
/// ## Run from the project root
///
///     flutter test tool/compile_samples_to_bundles.dart
///
/// Re-run after adding, removing, or editing any sample.
library;

import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;
import 'package:tom_ast_generator/tom_ast_generator.dart' show AstBundler;
import 'package:tom_d4rt_flutter_ast/tom_d4rt_flutter_ast.dart';

/// Markers delimiting the auto-generated asset list inside `pubspec.yaml`.
const _beginMarker =
    '  # >>> BEGIN generated bundle assets (tool/compile_samples_to_bundles.dart) <<<';
const _endMarker = '  # >>> END generated bundle assets <<<';

void main() {
  // A single test so `flutter test tool/compile_samples_to_bundles.dart`
  // drives the compilation under a Flutter host (dart:ui + dart:io).
  test('compile example samples into AstBundle assets', () async {
    final projectRoot = Directory.current.path;
    final exampleRoot = Directory(p.join(projectRoot, 'example'));
    if (!exampleRoot.existsSync()) {
      fail('example/ not found under $projectRoot — run from the '
          'tom_d4rt_flutter_ast_test project root.');
    }

    final bundlesRoot = Directory(p.join(projectRoot, 'assets', 'bundles'));

    // The bridged-library set drives AstBundler: imports in this set are
    // handled natively at runtime and are NOT inlined into the bundle.
    final d4rt = FlutterD4rt();
    final bundler =
        AstBundler(bridgedLibraries: d4rt.interpreter.bridgedLibraryUris);

    // 1. Discover samples (immediate subdir of example/ with a main.dart).
    final names = <String>[];
    for (final entity in exampleRoot.listSync()) {
      if (entity is! Directory) continue;
      final mainFile = File(p.join(entity.path, 'main.dart'));
      if (!mainFile.existsSync()) continue;
      names.add(p.basename(entity.path));
    }
    names.sort();
    expect(names, isNotEmpty,
        reason: 'no samples with a main.dart found under example/.');

    // 2. Clear and recreate the bundle output so stale bundles vanish.
    if (bundlesRoot.existsSync()) bundlesRoot.deleteSync(recursive: true);
    bundlesRoot.createSync(recursive: true);

    final compiled = <String>[];
    final failures = <String, Object>{};
    for (final name in names) {
      final mainPath = p.join(exampleRoot.path, name, 'main.dart');
      try {
        final bundle = await bundler.createFromFile(mainPath);
        final json = const JsonEncoder().convert(bundle.toJson());
        File(p.join(bundlesRoot.path, '$name.json')).writeAsStringSync(json);
        compiled.add(name);
        // ignore: avoid_print
        print('  ✓ $name (${json.length} bytes)');
      } catch (e) {
        failures[name] = e;
        // ignore: avoid_print
        print('  ✗ $name — $e');
      }
    }

    // 3. Write the manifest (only successfully-compiled bundles).
    final index = {
      'generated': 'tool/compile_samples_to_bundles.dart',
      'bundles': [for (final name in compiled) {'name': name}],
    };
    File(p.join(bundlesRoot.path, 'index.json')).writeAsStringSync(
        '${const JsonEncoder.withIndent('  ').convert(index)}\n');

    // 4. Rewrite the generated asset block in pubspec.yaml.
    _rewritePubspecAssets(p.join(projectRoot, 'pubspec.yaml'));

    // ignore: avoid_print
    print('Compiled ${compiled.length}/${names.length} samples into '
        'assets/bundles/. Manifest: assets/bundles/index.json');
    if (failures.isNotEmpty) {
      // ignore: avoid_print
      print('Skipped (did not compile): ${failures.keys.join(', ')}');
    }

    expect(compiled, isNotEmpty,
        reason: 'no samples compiled successfully: $failures');
  });
}

/// Replaces (or inserts) the marker-delimited asset list under `flutter:`.
/// Declares the whole `assets/bundles/` directory, which bundles the manifest
/// plus every `<name>.json` in one entry.
void _rewritePubspecAssets(String pubspecPath) {
  final pubspec = File(pubspecPath);
  final lines = pubspec.readAsLinesSync();

  final block = <String>[
    _beginMarker,
    '  assets:',
    '    - assets/bundles/',
    _endMarker,
  ];

  final beginIdx = lines.indexWhere((l) => l.trimRight() == _beginMarker);
  final endIdx = lines.indexWhere((l) => l.trimRight() == _endMarker);

  final List<String> out;
  if (beginIdx != -1 && endIdx != -1 && endIdx > beginIdx) {
    out = [
      ...lines.sublist(0, beginIdx),
      ...block,
      ...lines.sublist(endIdx + 1),
    ];
  } else {
    var anchor = lines.indexWhere((l) => l.contains('uses-material-design:'));
    if (anchor == -1) {
      anchor = lines.indexWhere((l) => l.trimRight() == 'flutter:');
    }
    if (anchor == -1) {
      throw StateError('could not find a `flutter:` section in pubspec.yaml '
          'to anchor generated assets.');
    }
    out = [
      ...lines.sublist(0, anchor + 1),
      ...block,
      ...lines.sublist(anchor + 1),
    ];
  }

  pubspec.writeAsStringSync('${out.join('\n')}\n');
}
