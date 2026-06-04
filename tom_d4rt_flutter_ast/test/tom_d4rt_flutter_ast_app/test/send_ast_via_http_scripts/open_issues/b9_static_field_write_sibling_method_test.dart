// Reproduces B.9 — static-field write from a sibling static method not persisting.
//
// A static-field write performed inside a sibling static method does not
// survive across calls; the class's static slot is not updated.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class _Counter {
  static int count = 0;
  static void bump() {
    count = count + 1;
  }
}

dynamic build(BuildContext context) {
  _Counter.bump();
  _Counter.bump();
  if (_Counter.count != 2) {
    throw StateError(
      'B.9 reproduced: static-field write from sibling static method did not '
      'persist — expected 2, got ${_Counter.count}',
    );
  }
  return const SizedBox.shrink();
}
