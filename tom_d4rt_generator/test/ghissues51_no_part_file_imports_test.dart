// REPO-WIDE GUARD (tom_d4rt_generator) — no committed `*.b.dart` imports a part file.
//
// Its subject reaches OUTSIDE this package, so it runs only when
// tom_d4rt_generator's suite runs and a session working elsewhere in the repo
// reaches none of it. `grep -rn 'REPO-WIDE GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` counts them.
//
// ghissues51 (GitHub #17): a generated adapter imported
// `package:vector_math/src/vector_math_64/matrix4.dart`, a part of
// vector_math_64.dart (import_of_non_library). The generator now routes every
// prefixed import through its part-of resolution; this guard reads what the
// generator actually wrote, in every package of the repository that commits
// generated bridges (the generator's examples, exec, astgen, dcli, samples
// and both Flutter twins), and resolves each `package:` import through the
// package config nearest to the file. An import whose file starts with a
// `part of` directive fails it.
//
// Package configs are per machine and gitignored, so a file whose package has
// none is reported as unresolved rather than passed; the guard fails when it
// resolved nothing at all, which would make it vacuous.

library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

/// The import block of the largest committed bridge ends at line 358
/// (measured 2026-11-14); 128 KB covers it many times over without reading
/// the 30 MB relaxer parts whole.
const _headBytes = 128 * 1024;

final _importLine = RegExp(r"^import '(package:[^']+)'", multiLine: true);
final _partOf = RegExp(r'^\s*part\s+of\b', multiLine: true);

String _head(File file) {
  final raf = file.openSync();
  try {
    final bytes = raf.readSync(_headBytes);
    return utf8.decode(bytes, allowMalformed: true);
  } finally {
    raf.closeSync();
  }
}

/// The nearest `.dart_tool/package_config.json` at or above [dir], below
/// [repoRoot].
File? _configFor(String dir, String repoRoot) {
  var current = dir;
  while (p.isWithin(repoRoot, current) || p.equals(repoRoot, current)) {
    final config = File(p.join(current, '.dart_tool', 'package_config.json'));
    if (config.existsSync()) return config;
    if (p.equals(repoRoot, current)) break;
    current = p.dirname(current);
  }
  return null;
}

String _asDirectory(String uri) => uri.endsWith('/') ? uri : '$uri/';

final _configCache = <String, Map<String, String>>{};

/// Package name -> absolute `lib/` directory, from [config].
Map<String, String> _packageRoots(
  File config,
) => _configCache.putIfAbsent(config.path, () {
  final json = jsonDecode(config.readAsStringSync()) as Map<String, dynamic>;
  final base = config.parent.uri;
  return {
    for (final entry in (json['packages'] as List).cast<Map<String, dynamic>>())
      entry['name'] as String: base
          // `dart pub get` writes rootUri without a trailing slash; without
          // one, resolving packageUri would replace its last segment.
          .resolve(_asDirectory(entry['rootUri'] as String))
          .resolve((entry['packageUri'] as String?) ?? 'lib/')
          .toFilePath(),
  };
});

void main() {
  test('G-GHI51-GUARD: no committed *.b.dart imports a part file '
      '(GitHub #17) [2026-11-14]', () {
    final repoRoot = p.dirname(Directory.current.absolute.path);
    final listed = Process.runSync('git', [
      'ls-files',
      '*.b.dart',
    ], workingDirectory: repoRoot);
    expect(listed.exitCode, 0, reason: '${listed.stderr}');
    final files = (listed.stdout as String)
        .split('\n')
        .where((l) => l.isNotEmpty)
        .map((l) => p.join(repoRoot, l))
        .toList();
    expect(files, isNotEmpty);

    final partImports = <String>[];
    final unresolvedFiles = <String>{};
    var checkedImports = 0;
    for (final path in files) {
      final file = File(path);
      if (!file.existsSync()) continue;
      final config = _configFor(p.dirname(path), repoRoot);
      if (config == null) {
        unresolvedFiles.add(p.relative(path, from: repoRoot));
        continue;
      }
      final roots = _packageRoots(config);
      for (final match in _importLine.allMatches(_head(file))) {
        final uri = Uri.parse(match.group(1)!);
        final root = roots[uri.pathSegments.first];
        if (root == null) continue;
        final target = File(p.joinAll([root, ...uri.pathSegments.skip(1)]));
        if (!target.existsSync()) continue;
        checkedImports++;
        final head = target.readAsLinesSync().take(30).join('\n');
        if (_partOf.hasMatch(head)) {
          partImports.add(
            '${p.relative(path, from: repoRoot)}: ${match.group(1)}',
          );
        }
      }
    }

    if (unresolvedFiles.isNotEmpty) {
      print(
        'G-GHI51-GUARD: ${unresolvedFiles.length} file(s) without a package '
        'config on this machine were not checked: '
        '${unresolvedFiles.take(5).join(', ')}'
        '${unresolvedFiles.length > 5 ? ', ...' : ''}',
      );
    }
    expect(
      checkedImports,
      greaterThan(0),
      reason: 'no import resolved: the guard would pass vacuously',
    );
    expect(
      partImports,
      isEmpty,
      reason:
          'These generated files import a part file, which the analyzer '
          'rejects as import_of_non_library. Fix the generator and '
          'regenerate; never edit a *.b.dart.',
    );
  });
}
