// Every example/ project's committed bridges must match what this generator
// produces from the project's own `buildkit.yaml`.
//
// The examples carry `buildkit_skip.yaml`, so no workspace-wide scan reaches
// them, and nothing else notices when a generator change leaves them behind.
// This is where it gets noticed: in the suite of the generator that produced
// them, in the same run as the change.
//
// [knownStale] is a ratchet (see `freshnessRatchetViolation`): an example on it
// must still be stale, and every other example must be fresh. To regenerate
// one, from this package's directory:
//
//     dart run bin/d4rtgen.dart -s example/<name>
//
// then commit everything it changes — including a new `relaxers.b.dart`, which
// the regenerated `dartscript.b.dart` imports — and delete its entry here.

@Tags(['generation'])
library;

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/testing.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// Examples whose committed bridges predate the current generator.
const knownStale = <String>{
  'd4',
  'dart_overview',
  'example_project',
  'user_guide',
  'user_reference',
  'userbridge_override',
  'userbridge_user_guide',
};

void main() {
  final examples = findD4rtgenProjects('example');

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
      final unresolved = await resolveIfUnresolved(root);
      expect(unresolved, isNull, reason: unresolved);
      final violation = freshnessRatchetViolation(
        example,
        await checkBridgeFreshness(root),
        knownStale: onList,
      );
      expect(violation, isNull, reason: violation);
    }, timeout: const Timeout(Duration(minutes: 5)));
  }
}
