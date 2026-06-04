// Reproduces C.6 — missing static constructor tearoff exposure (idx 77/79/329).
//
// The `EagerGestureRecognizer.new` static constructor tearoff is not emitted by
// the bridge, so referencing it as a value is undefined.
//
// ignore_for_file: avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final EagerGestureRecognizer Function() ctor = EagerGestureRecognizer.new;
  final recognizer = ctor();
  recognizer.dispose();
  return const SizedBox.shrink();
}
