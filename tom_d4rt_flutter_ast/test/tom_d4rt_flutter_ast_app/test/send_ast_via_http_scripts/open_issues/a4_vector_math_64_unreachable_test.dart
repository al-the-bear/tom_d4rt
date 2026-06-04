// Reproduces A.4 — vector_math_64 types are unreachable.
//
// Only `Matrix4` (re-exported by Flutter) is bridged; importing
// `package:vector_math/vector_math_64.dart` and naming `Vector3` is
// unresolvable because vector_math is intentionally not in the bridged
// libraries.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart';

dynamic build(BuildContext context) {
  final v = Vector3(1.0, 2.0, 3.0);
  return Center(child: Text('${v.length}'));
}
