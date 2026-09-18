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

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  test(
    'BRIDGE-FRESH-01: the committed bridges match the generator '
    '[2026-09-11] (PASS)',
    () async {
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
        reason: 'regenerate with d4rtgen and commit:\n  '
            '${freshness.stale.join('\n  ')}',
      );
      // A generated file no run writes any more is invisible to the comparison
      // above, which only looks at what a run produces. Such a file can only
      // rot or be hand-edited in the belief a regeneration will keep the edit.
      expect(
        freshness.orphanScanSkipped,
        isNull,
        reason: 'the orphan scan did not run, so its result means nothing',
      );
      expect(
        freshness.orphaned,
        isEmpty,
        reason: 'committed generated files that no run writes. d4rtgen never '
            'deletes them; decide and remove by hand:\n  '
            '${freshness.orphaned.join('\n  ')}',
      );
    },
    timeout: const Timeout(Duration(minutes: 10)),
  );
}
