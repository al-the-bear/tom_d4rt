// Tolerant golden comparator — absorbs sub-pixel font / anti-aliasing drift
// that differs across hosts and Flutter engine revisions, so pixel goldens do
// not oscillate red when the same suite runs on a different machine.
//
// Why: Flutter's default `LocalFileComparator` is exact-match. The screenshots
// in this package render real text (Roboto + Material icons); font hinting and
// anti-aliasing produce tiny per-pixel differences between the host/engine that
// generated the goldens and any other host/engine. Observed drift after the
// Flutter 3.44.6 SDK bump was 0.95%–1.02% — purely font/AA, no structural
// change. A percentage threshold lets that sub-pixel noise pass while genuine
// visual regressions (layout shifts, colour/theme changes) still fail, because
// those move far more than the threshold's worth of pixels.
//
// `flutter test` auto-discovers this file (one per package test root) and runs
// `testExecutable` before the suite, installing the comparator. See quest todo
// RCJ17.

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';

/// Fraction (0.0–1.0) of pixel difference tolerated before a golden fails.
/// 3% comfortably absorbs the observed <1.5% cross-host font/AA drift with
/// margin, while staying well below the double-digit deltas a real layout or
/// theme regression produces.
const double _goldenTolerance = 0.03;

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  final defaultComparator = goldenFileComparator as LocalFileComparator;
  goldenFileComparator = _TolerantGoldenComparator(
    // Append a filename so LocalFileComparator's internal dirname() recovers the
    // exact original basedir (the running test file's directory).
    Uri.parse('${defaultComparator.basedir}flutter_test_config.dart'),
    tolerance: _goldenTolerance,
  );
  await testMain();
}

/// [LocalFileComparator] that passes when the pixel difference is within
/// [tolerance]; otherwise it fails exactly like the default comparator
/// (writing the failure PNGs and throwing).
class _TolerantGoldenComparator extends LocalFileComparator {
  _TolerantGoldenComparator(super.testFile, {required this.tolerance});

  final double tolerance;

  @override
  Future<bool> compare(Uint8List imageBytes, Uri golden) async {
    final result = await GoldenFileComparator.compareLists(
      imageBytes,
      await getGoldenBytes(golden),
    );
    if (result.passed || result.diffPercent <= tolerance) {
      return true;
    }
    final error = await generateFailureOutput(result, golden, basedir);
    throw FlutterError(error);
  }
}
