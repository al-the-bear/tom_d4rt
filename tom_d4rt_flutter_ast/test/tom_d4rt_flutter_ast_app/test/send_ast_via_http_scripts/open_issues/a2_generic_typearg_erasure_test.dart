// Reproduces A.2 — generic type-argument erasure at the d4rt→native bridge.
//
// `Iterable.whereType<T>()` resolves but the `<T>` filter is erased when it
// crosses into native code, so the result is not actually filtered to `T`.
// Expected (correct Dart): exactly the 3 ints. Reproduced bug: the filter is
// dropped, so the count differs and the script throws.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final mixed = <Object>[1, 'two', 3, 'four', 5];
  final ints = mixed.whereType<int>().toList();
  if (ints.length != 3) {
    throw StateError(
      'A.2 reproduced: whereType<int> filter erased across the bridge — '
      'expected 3 ints, got ${ints.length}: $ints',
    );
  }
  return const SizedBox.shrink();
}
