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
// EXCEPT RIGHT NOW, AND THIS IS THE ONE CASE WHERE THAT INSTRUCTION IS WRONG.
// Measured 2026-09-21: this test is RED on `lib/src/bridges/dcli_bridges.b.dart`
// and a fresh generation is WORSE than what is committed, so following the
// line above would commit a downgrade. The committed file was written by
// generator 1.26.2; every generator since resolves `Env.scopeKey` to
// `InvalidType` and emits `value as dynamic` where 1.26.2 emitted
// `D4.extractBridgedArg<ScopeKey<Env>>(value, 'scopeKey')`. The second of those
// is behavioural: it assigns whatever the interpreter passed, wrapper and all.
//
// The cause is the generator's move to summary-based element extraction —
// `scope` is a direct dependency but no barrel re-exports `ScopeKey`, so it
// falls outside the linked element universe the summaries build. The run says
// so: "GEN-079 WARNING: ScopeKey is not re-exported by any barrel import".
// Cache staleness, pub-cache damage and a hand-edited committed file were each
// ruled out by measurement; the tree's 1.42.0 produces output identical to the
// resolved 1.28.0's.
//
// So LEAVE THIS RED until `scf18` is fixed. It is doing its job — the red is
// what stops the downgrade — and the failure is not a reason to regenerate.

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
}
