// scd9_ahcm: every test that runs the generator must carry the `generation`
// tag, because that tag is what gives it a deadline proportional to its work.
//
// A test that runs the generator runs the ANALYZER over a project and its
// dependency graph. That costs seconds with a warm workspace summary cache and
// minutes with a cold one — and a cache is cold right after a dependency
// change, which is when the suite gets run. The framework's default
// 30-second budget is a deadline for a fixed amount of work; these tests do
// not have one, so under load one of them times out. Which one moves: it was
// `d4rt_tester_test.dart` at 12 minutes once, `gen070` and `gen119` at 30
// seconds later. The headline count stopped being reproducible, which is worse
// than a slow suite: a real regression looks exactly like the noise.
//
// `dart_test.yaml` gives the tag a 10x factor. This test keeps the tag applied
// to everything that needs it, so the next generation-bound test file does not
// quietly reintroduce the flake — the failure it causes would land on a
// DIFFERENT file, days later, on whichever machine was busiest.
@Tags(['generation'])
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

/// Calls that mean "this test runs the generator", and so pays analyzer time.
const _generatorEntryPoints = <String>[
  'BridgeGenerator(',
  'generateBridges(',
  'checkBridgeFreshness',
  'previewGeneration',
  'D4rtTester(',
];

/// Every `*_test.dart` under `test/`, recursively.
List<File> testFiles(String testRoot) => Directory(testRoot)
    .listSync(recursive: true)
    .whereType<File>()
    .where((f) => f.path.endsWith('_test.dart'))
    .toList()
  ..sort((a, b) => a.path.compareTo(b.path));

void main() {
  final testRoot = p.join(Directory.current.path, 'test');

  group('scd9: generation-bound tests declare it', () {
    test(
      'G-GENTAG-1: every test file that runs the generator carries the '
      "'generation' tag [2026-09-12] (PASS)",
      () {
        final untagged = <String>[];
        for (final file in testFiles(testRoot)) {
          final source = file.readAsStringSync();
          final runsGenerator =
              _generatorEntryPoints.any((entry) => source.contains(entry));
          if (!runsGenerator) continue;
          if (!source.contains("@Tags(['generation'])")) {
            untagged.add(p.relative(file.path, from: testRoot));
          }
        }

        expect(
          untagged,
          isEmpty,
          reason:
              'These test files run the generator but do not carry the tag '
              "that gives them a proportionate timeout. Add `@Tags(['generation'])` "
              'above their `library;` directive:\n  ${untagged.join('\n  ')}',
        );
      },
    );

    test(
      'G-GENTAG-2: the tag is configured, so carrying it actually buys time '
      '[2026-09-12] (PASS)',
      () {
        // Anti-vacuity: G-GENTAG-1 passes just as happily when the tag means
        // nothing. The factor is what makes the tag worth applying.
        final config = File(
          p.join(Directory.current.path, 'dart_test.yaml'),
        );
        expect(
          config.existsSync(),
          isTrue,
          reason: 'dart_test.yaml is what gives the tag its timeout',
        );
        final text = config.readAsStringSync();
        expect(text, contains('generation:'));
        expect(
          RegExp(r'timeout:\s*(\d+)x').firstMatch(text)?.group(1),
          isNotNull,
          reason: 'the generation tag needs a timeout factor',
        );
        expect(
          int.parse(RegExp(r'timeout:\s*(\d+)x').firstMatch(text)!.group(1)!),
          greaterThanOrEqualTo(4),
          reason:
              'measured: at 1x the suite fails on a cold summary cache under '
              'load, at 10x it passes — see the header of dart_test.yaml for '
              'the harness',
        );
      },
    );
  });
}
