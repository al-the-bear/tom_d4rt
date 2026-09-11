// Every example/ project's committed bridges must match what this generator
// produces from the project's own `buildkit.yaml`.
//
// The examples carry `buildkit_skip.yaml`, so no workspace-wide scan reaches
// them, and nothing else notices when a generator change leaves them behind.
// This is where it gets noticed: in the suite of the generator that produced
// them, in the same run as the change.
//
// A RATCHET, NOT A WISH LIST. [knownStale] names the examples that were stale
// when the check was introduced; regenerating them is the d4rt quest's
// reconciliation backlog. For an example on the list the test asserts that it
// is STILL stale, so regenerating one fails here until its entry is deleted —
// the list can only shrink. An example off the list must be fresh, so no new
// staleness can land.
//
// To regenerate one, from this package's directory:
//
//     dart run bin/d4rtgen.dart -s example/<name>
//
// then commit everything it changes, including a new `relaxers.b.dart`, which
// the regenerated `dartscript.b.dart` imports.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// Examples whose committed bridges predate the current generator. Delete an
/// entry in the commit that regenerates it.
const knownStale = <String>{
  'd4',
  'dart_overview',
  'example_project',
  'user_guide',
  'user_reference',
  'userbridge_override',
  'userbridge_user_guide',
};

/// Package-relative directories under `example/` whose `buildkit.yaml` has a
/// `d4rtgen:` section.
List<String> discoverExamples() {
  final examples = <String>[];
  for (final entity in Directory('example').listSync(recursive: true)) {
    if (entity is! File || p.basename(entity.path) != 'buildkit.yaml') continue;
    final segments = p.split(entity.path);
    if (segments.contains('.dart_tool') || segments.contains('build')) continue;
    if (!RegExp(
      r'^d4rtgen:',
      multiLine: true,
    ).hasMatch(entity.readAsStringSync())) {
      continue;
    }
    examples.add(p.relative(entity.parent.path, from: 'example'));
  }
  return examples..sort();
}

void main() {
  final examples = discoverExamples();

  test('G-FRESH-EX-00: the known-stale list names only real examples '
      '[2026-09-11] (PASS)', () {
    expect(examples, isNotEmpty, reason: 'discovery found no example');
    expect(knownStale.difference(examples.toSet()), isEmpty);
  });

  for (final example in examples) {
    final onList = knownStale.contains(example);
    test('G-FRESH-EX[$example]: committed bridges '
        '${onList ? 'are still known-stale' : 'match the generator'} '
        '[2026-09-11] (PASS)', () async {
      final root = p.absolute('example', example);

      // Like D4rtTester.prepareBridges, resolve an example that has never
      // been resolved on this machine. The gate itself refuses to, and the
      // files this writes — `.dart_tool/`, `pubspec.lock` — are gitignored.
      if (!File(
        p.join(root, '.dart_tool', 'package_config.json'),
      ).existsSync()) {
        final pubGet = await Process.run('dart', [
          'pub',
          'get',
        ], workingDirectory: root);
        expect(pubGet.exitCode, 0, reason: '${pubGet.stderr}');
      }

      final freshness = await checkBridgeFreshness(root);
      expect(freshness.errors, isEmpty, reason: 'generation failed');
      expect(freshness.checked, isNotEmpty);
      if (onList) {
        expect(
          freshness.isFresh,
          isFalse,
          reason:
              '$example is fresh now — delete it from knownStale so it '
              'stays fresh.',
        );
      } else {
        expect(
          freshness.stale,
          isEmpty,
          reason:
              'regenerate example/$example and commit:\n  '
              '${freshness.stale.join('\n  ')}',
        );
      }
    }, timeout: const Timeout(Duration(minutes: 5)));
  }
}
