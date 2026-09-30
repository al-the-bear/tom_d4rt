// Every example/ project's committed bridges must match what the generator
// this package resolves produces from the project's own `buildkit.yaml`.
//
// The examples carry `buildkit_skip.yaml`, so no workspace-wide scan reaches
// them; nothing but this package's own suite can notice when a generator
// upgrade leaves them behind.
//
// [knownStale] is a ratchet (see `freshnessRatchetViolation` in
// `package:tom_d4rt_generator/testing.dart`): an example on it must still be
// stale, and every other example must be fresh. To regenerate one, from this
// package's directory:
//
//     dart run tom_d4rt_generator:d4rtgen -s example/<name>
//
// then commit everything it changes — including a new `relaxers.b.dart`, which
// the regenerated `dartscript.b.dart` imports — and delete its entry here.
// First check that the example's `helpersImport` and `d4rtImport` name the
// interpreter line its pubspec depends on: regenerating against the wrong line
// produces clean output that is still wrong.

@Tags(['generation'])
library;

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/testing.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// Examples whose committed bridges predate the generator this package
/// resolves.
const knownStale = <String>{
  // EMPTY since SCH3 (2026-09-30). The dart_overview entry recorded the
  // path-form divergence SCE37 measured between `d4rtgen -p .` and this
  // check's absolute path (SCF1). Regenerated to a fixed point with
  // tom_d4rt_generator 1.51.0, it is fresh here, as it became in the
  // generator's own ratchet. Every example must now stay fresh.
};

/// Examples whose generated output is NOT VERSIONED, so freshness cannot be a
/// statement about this repository.
///
/// `.gitignore` carries `**/example/d4/**/*.b.dart`: not one `.b.dart` under
/// any `example/d4` in this repo is tracked — measured across all three
/// generator packages, 0 tracked against 15-17 on disk. `checkBridgeFreshness`
/// compares a fresh generation against what the PACKAGE holds, so for these it
/// compares against local untracked files: fresh on a machine that ran the
/// generator tests recently, `notCommitted` on a clean clone, and neither
/// verdict describes anything a reviewer could act on.
///
/// Skipped rather than listed as known-stale, because the ratchet has no
/// meaning here in either direction. SCE6 measured it; SCE1 had put these
/// entries on and off the known-stale list on the strength of a local
/// regeneration, which is exactly the machine-dependence this removes.
const untrackedOutput = <String>{'d4'};

void main() {
  final examples = findD4rtgenProjects('example');

  test('X-FRESH-EX-00: the known-stale list names only real examples '
      '[2026-09-11] (PASS)', () {
    expect(examples, isNotEmpty, reason: 'discovery found no example');
    expect(knownStale.difference(examples.toSet()), isEmpty);
  });

  for (final example in examples.where((e) => !untrackedOutput.contains(e))) {
    final onList = knownStale.contains(example);
    test('X-FRESH-EX[$example]: committed bridges '
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
