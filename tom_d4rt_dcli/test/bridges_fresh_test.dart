// The committed `*.b.dart` files must match what the generator produces from
// this package's own `buildkit.yaml`.
//
// Nothing regenerates them during `dart test`: they change only when somebody
// runs `d4rtgen`. Without this check, a generator upgrade or a source change
// that was not followed by a regeneration leaves the rest of the suite green
// and testing stale generated code. The check regenerates into a scratch tree
// under `.dart_tool/` and never writes to the package.
//
// When it fails: run `dart run tom_d4rt_generator:d4rtgen` in this package and
// commit what it changes.
//
// ONE CASE WHERE THAT INSTRUCTION CAN BE WRONG, and the second test below is
// what makes it safe. From 2026-09-18 to at least 2026-09-21 a fresh
// generation was WORSE than the committed file: `SettingsYaml` came back as
// `InvalidType` / `dynamic` (scf7) and `Env.scopeKey`'s `ScopeKey<Env>` as
// `value as dynamic` (scf18), identically in both REPL tools, so following the
// message would have committed a downgrade.
//
// The cause was in the environment, not in either tool or the generator's
// code: no generator release between 1.42.0 and 1.44.0 and no
// `tom_analyzer_shared` change since 2026-08-04 touches type resolution, yet
// sce212's regeneration on 2026-09-28 (generator 1.44.0) reproduced the real
// types, and 1.46.0 does too. The one input that moved is the analyzer summary
// cache (`<workspace>/.tom/analyzer-cache/<analyzer major>/<sdk>/`), which
// `dart pub get` never touches. The type is resolved through the bundles that
// LINK against `scope` and `settings_yaml`, not through their own summaries:
// scf18 rebuilt `scope@5.1.0.sum` alone on 2026-09-21 and the output did not
// change, while `dcli_core@10.0.0.sum` was rebuilt on 2026-09-25 — between the
// last red and the first green. A dependent bundle linked against a superseded
// closure is the explanation that fits every measurement. The "ScopeKey is not
// re-exported by any barrel import" warning still prints and the type still
// resolves, so the barrel gap first blamed was not it. Ruled out earlier, and still ruled out: dcli 8 vs 10, the
// project's `.dart_tool`, a missing package.
//
// IF IT RECURS: delete the affected `*.sum` files under that cache directory —
// the dependents (`dcli_core@*`, `dcli@*`), not only the package that owns the
// lost type — and regenerate before believing a fresh generation over the
// committed file.
// BRIDGE-FRESH-02 below refuses a committed downgrade either way.

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  test('BRIDGE-FRESH-01: the committed bridges match the generator '
      '[2026-09-11] (PASS)', () async {
    final freshness = await checkBridgeFreshness(Directory.current.path);
    expect(freshness.errors, isEmpty, reason: 'generation failed');
    expect(
      freshness.checked,
      isNotEmpty,
      reason: 'the generator produced nothing, so nothing was compared',
    );
    expect(
      freshness.stale,
      isEmpty,
      reason:
          'regenerate with d4rtgen and commit:\n  '
          '${freshness.stale.join('\n  ')}',
    );
    // A generated file no run writes any more is invisible to the comparison
    // above, which only looks at what a run produces. Such a file can only rot
    // or be hand-edited in the belief a regeneration will keep the edit.
    expect(
      freshness.orphanScanSkipped,
      isNull,
      reason: 'the orphan scan did not run, so its result means nothing',
    );
    expect(
      freshness.orphaned,
      isEmpty,
      reason:
          'committed generated files that no run writes. d4rtgen never '
          'deletes them; decide and remove by hand:\n  '
          '${freshness.orphaned.join('\n  ')}',
    );
  }, timeout: const Timeout(Duration(minutes: 10)));

  test('BRIDGE-FRESH-02: the committed dcli bridge keeps the types a degraded '
      'generation loses [2026-09-29] (PASS)', () {
    // scf7 / scf18: a generation run against a stale analyzer summary resolved
    // these to `InvalidType` / `dynamic`. BRIDGE-FRESH-01 would then go red
    // and tell the reader to regenerate and commit — which would commit the
    // downgrade. This refuses that commit.
    final bridge = File(
      'lib/src/bridges/dcli_bridges.b.dart',
    ).readAsStringSync();
    expect(
      bridge.contains('InvalidType'),
      isFalse,
      reason:
          'a type the analyzer could not resolve reached the bridge; see the '
          'header of this file before committing it',
    );
    expect(
      bridge,
      contains(r'D4.getRequiredArg<$settings_yaml_1.SettingsYaml>('),
      reason: 'getExcludedPaths lost its SettingsYaml parameter type (scf7)',
    );
    expect(
      // `\s*`: generator 1.51.0 formats its output, which can break the chain
      // before `.extractBridgedArg`. The assertion is about the TYPE argument.
      RegExp(
        r'D4\s*\.extractBridgedArg<\$scope_1\.ScopeKey<',
      ).allMatches(bridge),
      hasLength(greaterThanOrEqualTo(3)),
      reason: 'Env.scopeKey lost its ScopeKey<Env> type (scf18)',
    );
  });
}
