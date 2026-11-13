// RUNNER BUCKET: guard — run_guard_tests.sh
// relaxsize1 — no generated bridge file of this package exceeds the size a
// GitHub push accepts.
//
// GitHub refuses a push containing a file above 100 MB and warns above 50 MB.
// At tom_d4rt_generator 1.63.0 `lib/src/bridges/flutter_relaxers.b.dart` was
// 93.4 MB in both twins, so a few percent of growth would have blocked every
// push of the d4rt repository. Since 1.64.0 the generator moves the relaxer
// file's RC-2 generic constructor factories into `flutter_relaxers_part<N>.b.dart`
// part files when it is too large for one file (`defaultRelaxerMaxFileBytes`,
// 25 MB before formatting, about 32 MB per part once formatted).
//
// This guard holds the result: every `*.b.dart` under `lib/` stays at or below
// [_budgetBytes], and a file above it is named with its size. The fix for a
// failure is in the generator (a smaller per-file budget, or splitting another
// output), never a hand edit of the `.b.dart`. Pure file I/O: no companion app.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

/// GitHub's warning threshold; half the 100 MB a push refuses.
const int _budgetBytes = 50 * 1000 * 1000;

void main() {
  test('RS1-T1: no generated bridge file under lib/ is above 50 MB '
      '[2026-11-13]', () {
    final bridges =
        Directory('lib')
            .listSync(recursive: true)
            .whereType<File>()
            .where((f) => f.path.endsWith('.b.dart'))
            .toList()
          ..sort((a, b) => a.path.compareTo(b.path));

    // Anti-vacuity: a run from the wrong directory finds nothing and passes.
    expect(
      bridges,
      isNotEmpty,
      reason: 'no *.b.dart under lib/ - run from the package root',
    );

    final tooLarge = [
      for (final f in bridges)
        if (f.lengthSync() > _budgetBytes)
          '${f.path}: ${f.lengthSync()} bytes',
    ];
    expect(
      tooLarge,
      isEmpty,
      reason:
          'above the $_budgetBytes-byte budget (GitHub refuses a push with a '
          'file above 100 MB). Regenerate with a tom_d4rt_generator that '
          'splits the file (relaxsize1); never edit a .b.dart by hand.',
    );
  });
}
