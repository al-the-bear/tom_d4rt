// Reproduces B.2 — C-style for(;;) shares one loop variable across closures.
//
// `_executeClassicFor` reuses a single loop environment, so closures created in
// the loop body all capture the post-loop value instead of the per-iteration
// value. Correct Dart yields [0, 1, 2]; the bug yields [3, 3, 3].
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final closures = <int Function()>[];
  for (var i = 0; i < 3; i++) {
    closures.add(() => i);
  }
  final captured = closures.map((c) => c()).toList();
  if (captured.toString() != '[0, 1, 2]') {
    throw StateError(
      'B.2 reproduced: C-style for shares one loop variable — '
      'expected [0, 1, 2], got $captured',
    );
  }
  return const SizedBox.shrink();
}
