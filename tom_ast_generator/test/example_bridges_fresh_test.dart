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

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/testing.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// Examples whose committed bridges predate the generator this package
/// resolves.
const knownStale = <String>{
  // NOT STALE — the two-generator disagreement recorded in
  // `tom_d4rt_generator`'s own example guard, reaching the same example name
  // for the third time. SCE1 regenerated it to a fixed point with
  // `bin/d4rtgen.dart`; this check runs `generateBridges`
  // (`src/bridge_api.dart`), and the two implementations have drifted: the
  // tool emits 5960 code lines here and the check's path 5144, the missing
  // 816 being every abstract, sealed, generic and mixin class.
  //
  // SCF1 owns collapsing them into one; this entry goes when it lands. The two
  // that left this list — `example_project` and `userbridge_user_guide` — were
  // among the three whose `buildkit.yaml` pointed `helpersImport` at the
  // `tom_d4rt` line while the package depends on `tom_d4rt_exec`. SCE1
  // corrected the configuration before regenerating, so they are now generated
  // against the interpreter they actually run on.
  //
  // `d4` is here for the same reason and reports the same four files as its
  // namesakes in the other two packages — `core_extensions`, `dart_overview`,
  // `test_part_of_files`, `test_callback_types` — which is what establishes
  // the cause as the generator split rather than anything about this package.
  'd4',
  'dart_overview',
};

void main() {
  final examples = findD4rtgenProjects('example');

  test('AG-FRESH-EX-00: the known-stale list names only real examples '
      '[2026-09-11] (PASS)', () {
    expect(examples, isNotEmpty, reason: 'discovery found no example');
    expect(knownStale.difference(examples.toSet()), isEmpty);
  });

  for (final example in examples) {
    final onList = knownStale.contains(example);
    test('AG-FRESH-EX[$example]: committed bridges '
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
