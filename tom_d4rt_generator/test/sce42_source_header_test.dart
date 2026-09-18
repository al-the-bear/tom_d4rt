// REPO-WIDE GUARD (tom_d4rt_generator) — no committed `*.b.dart` header records an absolute path.
//
// Its subject reaches OUTSIDE this package, so it runs only when
// tom_d4rt_generator's suite runs and a session working elsewhere in the repo
// reaches none of it. SCD129 made that arrangement visible rather than
// incidental: `grep -rn 'REPO-WIDE GUARD' */test` lists every one, and
// `tom_d4rt/test/scd129_repo_wide_guard_index_test.dart` fails if a new one
// arrives without this banner.
//
// sce42: the `// Source:` header is the CANONICAL URI of the input, not the
// path the run happened to be handed.
//
// TWO DEFECTS, and the second is the worse one.
//
// The CLI walks a project with paths relative to its scan root; the library
// API is handed an absolute one. The header was written verbatim, so the same
// project generated the two ways produced two different files — and
// `checkBridgeFreshness` normalises away the `// Generated:` line and nothing
// else, so they could never compare equal. Following the regeneration command
// that every `example_bridges_fresh_test.dart` PRINTS therefore turned a fresh
// example stale, and told the reader to commit the result.
//
// And a generated file has no business recording where on one machine its
// input happened to live. Four tracked files carry a developer's home
// directory today; regenerating them on another machine rewrites them.
//
// WHY THE UNIT TESTS BELOW PIN THE URI MAPPING RATHER THAN RUNNING BOTH
// PIPELINES. What makes the two agree is that `_getPackageUri` maps every
// spelling of one file to one URI. Running both pipelines to compare headers
// would take a minute, need a resolved fixture project, and still only observe
// that property indirectly — so it is asserted directly, and the end-to-end
// behaviour is what `example_bridges_fresh_test.dart` already measures.

//
// G-SCE42-5 and -6 DO run the generator — that is the point of them — so
// this file carries the `generation` tag and its proportionate timeout.
@Tags(['generation'])
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_generator.dart';

/// Committed files whose header still records an absolute path.
///
/// Each entry is a file that CANNOT be repaired from this package: the Flutter
/// twins resolve the generator from pub.dev, so their bridges carry whatever
/// the published generator wrote and only a regeneration after a publish can
/// change them. SCF1 owns that sweep and names these four.
///
/// An entry comes off by regenerating the file, never by editing its header.
const _absoluteHeaderBacklog = <String>{
  'tom_d4rt_flutter/lib/src/bridges/dart_ui_bridges.b.dart',
  'tom_d4rt_flutter/lib/src/bridges/vector_math_bridges.b.dart',
  'tom_d4rt_flutter_ast/lib/src/bridges/dart_ui_bridges.b.dart',
  'tom_d4rt_flutter_ast/lib/src/bridges/vector_math_bridges.b.dart',
};

/// The repo root — the parent of this package.
String get _repoRoot => p.normalize(p.join(Directory.current.path, '..'));

void main() {
  group('SCE42: the source header is canonical', () {
    late BridgeGenerator generator;

    setUp(() {
      generator = BridgeGenerator(workspacePath: Directory.current.path);
    });

    test('G-SCE42-1: a pub-cache path becomes a `package:` URI, not an absolute '
        'path [2026-09-18] (PASS)', () {
      // The shape actually committed today:
      //   // Source: /Users/<user>/.pub-cache/hosted/pub.dev/vector_math-2.2.0/...
      // The package name is read from the package's own pubspec, so the
      // fixture is a real directory rather than a made-up string.
      final tmp = Directory.systemTemp.createTempSync('sce42_cache_');
      addTearDown(() {
        try {
          tmp.deleteSync(recursive: true);
        } catch (_) {}
      });
      final pkg = p.join(
        tmp.path,
        '.pub-cache',
        'hosted',
        'pub.dev',
        'vector_math-2.2.0',
      );
      Directory(p.join(pkg, 'lib')).createSync(recursive: true);
      File(
        p.join(pkg, 'pubspec.yaml'),
      ).writeAsStringSync('name: vector_math\nversion: 2.2.0\n');
      File(
        p.join(pkg, 'lib', 'vector_math_64.dart'),
      ).writeAsStringSync('class Vector2 {}\n');

      final uri = generator.packageUriForTesting(
        p.join(pkg, 'lib', 'vector_math_64.dart'),
      );

      expect(
        uri,
        startsWith('package:'),
        reason:
            'a header that names a home directory is not reproducible '
            'on any other machine',
      );
      expect(uri, 'package:vector_math/vector_math_64.dart');
      expect(p.isAbsolute(uri), isFalse);
    });

    test(
      'G-SCE42-2: a sky_engine path becomes `dart:ui` [2026-09-18] (PASS)',
      () {
        final uri = generator.packageUriForTesting(
          '/somewhere/flutter/bin/cache/pkg/sky_engine/lib/ui/ui.dart',
        );

        expect(uri, 'dart:ui');
      },
    );

    test(
      'G-SCE42-3: the same file spelled relatively and absolutely maps to one '
      'URI — which is what makes the two pipelines agree [2026-09-18] (PASS)',
      () {
        // The CLI is given `example/d4/lib/x.dart`; the library API is given
        // the absolute form of the same file. Before sce42 the header was
        // whichever string arrived, so the two never compared equal.
        final tmp = Directory.systemTemp.createTempSync('sce42_');
        addTearDown(() {
          try {
            tmp.deleteSync(recursive: true);
          } catch (_) {}
        });
        Directory(p.join(tmp.path, 'pkg', 'lib')).createSync(recursive: true);
        File(
          p.join(tmp.path, 'pkg', 'pubspec.yaml'),
        ).writeAsStringSync('name: zom_sce42\n');
        File(
          p.join(tmp.path, 'pkg', 'lib', 'x.dart'),
        ).writeAsStringSync('class X {}\n');

        final absolute = generator.packageUriForTesting(
          p.join(tmp.path, 'pkg', 'lib', 'x.dart'),
        );

        // The relative spelling is resolved against the working directory, so
        // it has to be exercised from one that makes it name the same file.
        final saved = Directory.current;
        Directory.current = tmp.path;
        final String relative;
        try {
          relative = generator.packageUriForTesting('pkg/lib/x.dart');
        } finally {
          Directory.current = saved;
        }

        expect(absolute, 'package:zom_sce42/x.dart');
        expect(
          relative,
          absolute,
          reason:
              'the header must not depend on how the caller spelled the '
              'path, or the CLI and the library API cannot agree',
        );
      },
    );

    /// Generates one bridge file from a throwaway package and returns its
    /// emitted `// Source:` header.
    ///
    /// This is what actually pins sce42: the URI mapping above was already
    /// correct before the fix — the defect was that the header did not USE it.
    /// A test exercising only `packageUriForTesting` passed just as happily
    /// with the change reverted, which was measured before this was added.
    Future<String> emittedHeader({required bool absolute}) async {
      final tmp = Directory.systemTemp.createTempSync('sce42_emit_');
      addTearDown(() {
        try {
          tmp.deleteSync(recursive: true);
        } catch (_) {}
      });
      final pkg = p.join(tmp.path, 'pkg');
      Directory(p.join(pkg, 'lib')).createSync(recursive: true);
      File(
        p.join(pkg, 'pubspec.yaml'),
      ).writeAsStringSync('name: zom_sce42_emit\n');
      File(
        p.join(pkg, 'lib', 'thing.dart'),
      ).writeAsStringSync('class Thing {\n  int value = 1;\n}\n');

      final gen = BridgeGenerator(
        workspacePath: pkg,
        packageName: 'zom_sce42_emit',
        sourceImport: 'thing.dart',
        skipPrivate: true,
      );

      final output = p.join(tmp.path, 'out', 'thing_bridges.dart');
      final saved = Directory.current;
      if (!absolute) Directory.current = pkg;
      final BridgeGeneratorResult result;
      try {
        result = await gen.generateBridges(
          sourceFiles: [
            absolute ? p.join(pkg, 'lib', 'thing.dart') : 'lib/thing.dart',
          ],
          outputPath: output,
          moduleName: 'thing',
        );
      } finally {
        Directory.current = saved;
      }

      expect(result.errors, isEmpty, reason: '${result.errors}');
      expect(result.outputFiles, isNotEmpty);
      return File(result.outputFiles.first)
          .readAsStringSync()
          .split('\n')
          .firstWhere(
            (line) => line.startsWith('// Source: '),
            orElse: () => '<no // Source: header emitted>',
          );
    }

    test('G-SCE42-5: the EMITTED header is the canonical URI, not the path the '
        'generator was handed [2026-09-18] (PASS)', () async {
      expect(
        await emittedHeader(absolute: true),
        '// Source: package:zom_sce42_emit/thing.dart',
        reason:
            'the generator was given an absolute path; emitting it verbatim '
            'is what put a home directory into four committed files',
      );
    }, timeout: const Timeout(Duration(minutes: 2)));

    test('G-SCE42-6: the emitted header does not depend on how the caller '
        'spelled the path [2026-09-18] (PASS)', () async {
      // The CLI hands over a relative path, the library API an absolute one.
      // This is the equality the freshness gate needs, asserted on the
      // header the two actually write.
      final fromAbsolute = await emittedHeader(absolute: true);
      final fromRelative = await emittedHeader(absolute: false);

      expect(fromRelative, fromAbsolute);
      expect(fromAbsolute, isNot(contains(Directory.systemTemp.path)));
    }, timeout: const Timeout(Duration(minutes: 2)));

    test('G-SCE42-4: no committed `*.b.dart` header records an absolute path '
        '[2026-09-18] (PASS)', () {
      final listed = Process.runSync('git', [
        'ls-files',
        '*.b.dart',
      ], workingDirectory: _repoRoot);
      expect(
        listed.exitCode,
        0,
        reason: 'could not list tracked files: ${listed.stderr}',
      );

      final tracked = (listed.stdout as String)
          .split('\n')
          .where((line) => line.trim().isNotEmpty)
          .toList();
      expect(
        tracked,
        isNotEmpty,
        reason:
            'no tracked bridges found, so an empty result would prove '
            'nothing',
      );

      final offenders = <String>[];
      for (final relative in tracked) {
        final file = File(p.join(_repoRoot, relative));
        if (!file.existsSync()) continue;
        for (final line in file.readAsLinesSync()) {
          if (!line.startsWith('// Source: ')) continue;
          final value = line.substring('// Source: '.length).trim();
          if (value.startsWith('/') ||
              RegExp(r'^[A-Za-z]:[\\/]').hasMatch(value)) {
            offenders.add(relative);
          }
          break; // the header is the only place this appears
        }
      }

      expect(
        offenders.toSet().difference(_absoluteHeaderBacklog),
        isEmpty,
        reason:
            'these committed bridges record an absolute path in their '
            '`// Source:` header, so the same project generates differently '
            'on another machine. Regenerate them — do not edit the header:\n'
            '  ${offenders.toSet().difference(_absoluteHeaderBacklog).join('\n  ')}',
      );

      // The backlog is a ratchet: an entry that has been repaired must be
      // deleted, or the set quietly outlives its cause.
      expect(
        _absoluteHeaderBacklog.difference(offenders.toSet()),
        isEmpty,
        reason:
            'these are listed as carrying an absolute header but no longer '
            'do. Delete them from `_absoluteHeaderBacklog`:\n'
            '  ${_absoluteHeaderBacklog.difference(offenders.toSet()).join('\n  ')}',
      );
    });
  });
}
