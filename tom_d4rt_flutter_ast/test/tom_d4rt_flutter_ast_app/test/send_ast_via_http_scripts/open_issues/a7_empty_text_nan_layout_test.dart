// Reproduces A.7 — empty Text('') triggers a NaN layout assertion banner.
//
// An empty `Text` widget hits a text-layout edge in the bridged paragraph path
// that produces a non-fatal Offset/Rect NaN banner. Non-fatal, but the harness
// records FE > 0.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  return const Center(child: Text(''));
}
