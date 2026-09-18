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
//
// RUN IT TWICE. Generation is not a one-pass fixed point: the second run reads
// what the first wrote and can produce a different, larger file — measured on
// `dart_overview`, 2934 committed lines became 5144 after one run and 5960
// after two, and 5960 is stable. A single run therefore leaves a package that
// is still not what the generator produces from it. Regenerate until the
// content stops changing (the `// Generated:` line always does).

@Tags(['generation'])
library;

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/testing.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// Examples whose committed bridges predate the current generator.
const knownStale = <String>{
  // NOT STALE. `dart_overview` was regenerated to a fixed point by
  // `bin/d4rtgen.dart` and `git diff` is empty for it — but this check does not
  // call it the same way.
  //
  // THE EARLIER EXPLANATION HERE WAS WRONG and is recorded as such so nobody
  // hunts for it again: it said `d4rtgen` and `checkBridgeFreshness` run two
  // hand-maintained generator implementations that had drifted apart. SCE28
  // unified those — both build their config with the same loader and call the
  // same `generateBridges`, and `--dump-config` returns byte-identical JSON.
  //
  // MEASURED (SCE37): the variable is the FORM of `projectPath`, nothing else.
  // `checkBridgeFreshness` opens with `p.normalize(p.absolute(projectPath))`
  // while `d4rtgen` passes `-p .` through as given, and `generateBridges` is
  // not invariant under that: its barrel export-clause filter looks up
  // `exportInfo[c.sourceFile]`, and `sourceFile` is written in mixed forms, so
  // a relative path MISSES the lookup and falls open while an absolute one
  // HITS the wrong entry. Relative yields 110 classes, absolute 97 — one
  // version, one config, cold cache, either working directory. The absolute
  // run drops `Animal` as "not exported from barrel file" while the barrel
  // reads `show Animal, Cat, …`, which is the proof that side is wrong.
  //
  // So this entry records a generator that is not path-form invariant, not a
  // stale file. SCF1 owns the fix; when it lands this comes off.
  //
  // The other examples pass because their generation happens to agree across
  // the two forms — which is why the split went unnoticed.
  'dart_overview',
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

  test('G-FRESH-EX-00: the known-stale list names only real examples '
      '[2026-09-11] (PASS)', () {
    expect(examples, isNotEmpty, reason: 'discovery found no example');
    expect(knownStale.difference(examples.toSet()), isEmpty);
  });

  for (final example in examples.where((e) => !untrackedOutput.contains(e))) {
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
