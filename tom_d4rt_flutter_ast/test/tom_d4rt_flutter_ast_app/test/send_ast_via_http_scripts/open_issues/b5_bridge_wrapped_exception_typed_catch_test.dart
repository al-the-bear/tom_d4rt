// Reproduces B.5 — bridge-wrapped exceptions escape typed `on` / bare `catch`.
//
// A native throw crossing the bridge is wrapped in `RuntimeError`, discarding
// the original type, so a typed `on FormatException` clause never matches the
// native FormatException raised by `int.parse`.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  var matchedTyped = false;
  try {
    int.parse('not-a-number');
  } on FormatException {
    matchedTyped = true;
  } catch (_) {
    matchedTyped = false;
  }
  if (!matchedTyped) {
    throw StateError(
      'B.5 reproduced: native FormatException not matched by typed '
      '`on FormatException` (bridge wrapped it in RuntimeError)',
    );
  }
  return const SizedBox.shrink();
}
