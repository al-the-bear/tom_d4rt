// Reproduces C.1 — no auto-synthesized interface proxy for `Curve` (U3).
//
// A script subclass of the bridged abstract base `Curve` cannot cross to native
// code because no interface proxy is registered for it, so the native
// `transform` path that drives the curve fails.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class _SquareCurve extends Curve {
  const _SquareCurve();
  @override
  double transformInternal(double t) => t * t;
}

dynamic build(BuildContext context) {
  const curve = _SquareCurve();
  final sampled = curve.transform(0.5);
  if ((sampled - 0.25).abs() > 1e-9) {
    throw StateError(
      'C.1 reproduced: Curve subclass did not transform correctly — got $sampled',
    );
  }
  return const SizedBox.shrink();
}
