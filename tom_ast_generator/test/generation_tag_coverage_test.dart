// sce40: every test that runs the generator must carry the `generation` tag,
// because that tag is what gives it a deadline proportional to its work.
// Carried here from tom_d4rt_generator, which met the consequence first.
//
// A test that runs the generator runs the ANALYZER over a project and its
// dependency graph. That costs seconds with a warm workspace summary cache and
// minutes with a cold one — and a cache is cold right after a dependency
// change, which is when the suite gets run. The framework's default 30-second
// budget is a deadline for a fixed amount of work; these tests do not have
// one, so under load one of them times out. Which one MOVES between runs, so
// the suite's headline count stops being reproducible — which is worse than a
// slow suite, because a real regression then looks exactly like the noise. In
// tom_d4rt_generator that was read as flaky tests for a month.
//
// `dart_test.yaml` gives the tag a 10x factor. This test keeps the tag applied
// to everything that needs it, so the next generation-bound test file does not
// quietly reintroduce the flake — the failure it causes would land on a
// DIFFERENT file, days later, on whichever machine was busiest.
//
// A KNOWN LIMIT, so nobody reads more into a green run than it carries: the
// scan is textual and only reads `*_test.dart`. It therefore flags a file that
// merely MENTIONS an entry point in a comment (harmless — a spurious tag costs
// nothing), and it would MISS a test that reaches generation only through
// `AstgenTestSetup.prepareBridges`, which is not a test file and so is never scanned. No test does
// that today: the two that use the helper also name an entry point directly.
@Tags(['generation'])
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

/// Calls that mean "this test runs the generator", and so pays analyzer time.
///
/// Kept identical to tom_d4rt_generator's list: these mirrors call generation
/// by the same names, so a divergence here would be drift, not adaptation.
const _generatorEntryPoints = <String>[
  'BridgeGenerator(',
  'generateBridges(',
  'checkBridgeFreshness',
  'previewGeneration',
  'D4rtTester(',
];

/// Every `*_test.dart` under `test/`, recursively.
List<File> testFiles(String testRoot) =>
    Directory(testRoot)
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('_test.dart'))
        .toList()
      ..sort((a, b) => a.path.compareTo(b.path));

void main() {
  final testRoot = p.join(Directory.current.path, 'test');

  group('sce40: generation-bound tests declare it', () {
    test('AG-GENTAG-1: every test file that runs the generator carries '
        "the 'generation' tag [2026-09-18] (PASS)", () {
      final untagged = <String>[];
      var scanned = 0;
      for (final file in testFiles(testRoot)) {
        final source = file.readAsStringSync();
        final runsGenerator = _generatorEntryPoints.any(
          (entry) => source.contains(entry),
        );
        if (!runsGenerator) continue;
        scanned++;
        if (!source.contains("@Tags(['generation'])")) {
          untagged.add(p.relative(file.path, from: testRoot));
        }
      }

      expect(
        scanned,
        greaterThan(0),
        reason:
            'found no generation-bound test file at all, so an empty '
            '`untagged` would prove nothing',
      );
      expect(
        untagged,
        isEmpty,
        reason:
            'These test files run the generator but do not carry the tag '
            "that gives them a proportionate timeout. Add `@Tags(['generation'])` "
            'above their `library;` directive:\n  ${untagged.join('\n  ')}',
      );
    });

    test('AG-GENTAG-2: the tag is configured, so carrying it actually '
        'buys time [2026-09-18] (PASS)', () {
      // Anti-vacuity: GENTAG-1 passes just as happily when the tag means
      // nothing. The factor is what makes the tag worth applying.
      final config = File(p.join(Directory.current.path, 'dart_test.yaml'));
      expect(
        config.existsSync(),
        isTrue,
        reason: 'dart_test.yaml is what gives the tag its timeout',
      );
      final text = config.readAsStringSync();
      expect(text, contains('generation:'));
      final factor = RegExp(r'timeout:\s*(\d+)x').firstMatch(text);
      expect(
        factor,
        isNotNull,
        reason: 'the generation tag needs a timeout factor',
      );
      expect(
        int.parse(factor!.group(1)!),
        greaterThanOrEqualTo(4),
        reason:
            'measured in tom_d4rt_generator: at 1x the suite fails on a cold '
            'summary cache under load, at 10x it passes — see the header of '
            'dart_test.yaml for the harness',
      );
    });
  });
}
