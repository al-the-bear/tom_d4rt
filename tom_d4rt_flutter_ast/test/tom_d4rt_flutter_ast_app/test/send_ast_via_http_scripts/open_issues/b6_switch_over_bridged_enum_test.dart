// Reproduces B.6 — switch over a BridgedEnum falls through to null.
//
// The equality probe in `visitSwitchStatement` fails both directions for
// certain bridged-enum values, so a String-returning helper falls through to an
// implicit null instead of returning the matched branch.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

String? _describe(Axis axis) {
  switch (axis) {
    case Axis.horizontal:
      return 'horizontal';
    case Axis.vertical:
      return 'vertical';
  }
}

dynamic build(BuildContext context) {
  final result = _describe(Axis.horizontal);
  if (result != 'horizontal') {
    throw StateError(
      'B.6 reproduced: switch over BridgedEnum fell through to null — '
      'expected "horizontal", got "$result"',
    );
  }
  return const SizedBox.shrink();
}
