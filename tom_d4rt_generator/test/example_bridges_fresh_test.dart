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
  // NOT STALE. Both were regenerated to a fixed point by `bin/d4rtgen.dart` in
  // SCE1's sweep and `git diff` is empty for them — but this check does not run
  // that generator. `checkBridgeFreshness` calls `generateBridges`
  // (`src/bridge_api.dart`), and `d4rtgen` calls `_generateBridges`
  // (`src/v2/d4rtgen_executor.dart`). The two are hand-maintained mirrors, and
  // they no longer agree: measured on `dart_overview`, the tool emits 5960 code
  // lines and the check's path 5144, the missing 816 being every abstract,
  // sealed, generic and mixin class in the package — `Shape`, `SortedList`,
  // `Bird`, `Flying` and the rest. Neither the overlay nor the starting state
  // is responsible; both paths were measured in place, from the same fixed
  // point, with the same config.
  //
  // So these two entries record a disagreement between two generators, not a
  // stale file, and deleting them would make the ratchet demand that the tool's
  // own output look stale. SCF1 owns collapsing the two implementations into
  // one; when it lands, both come off and the comment goes with them.
  //
  // The other five examples pass because their generation happens to agree
  // across the two paths — which is why the split went unnoticed.
  'dart_overview',
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
