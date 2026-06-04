// Reproduces B.3 — runtimeType.toString() on interpreted classes fails.
//
// `InterpretedInstance.runtimeType` returns an `InterpretedClass` whose
// `toString` is not callable, so the class name cannot be obtained this way.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class _Widget7 {}

dynamic build(BuildContext context) {
  final name = _Widget7().runtimeType.toString();
  if (!name.contains('_Widget7')) {
    throw StateError(
      'B.3 reproduced: runtimeType.toString() did not yield the declared '
      'class name — got "$name"',
    );
  }
  return const SizedBox.shrink();
}
