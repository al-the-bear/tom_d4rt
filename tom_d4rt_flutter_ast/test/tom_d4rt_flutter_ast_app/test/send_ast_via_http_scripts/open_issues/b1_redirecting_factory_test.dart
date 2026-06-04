// Reproduces B.1 — redirecting factory `factory X() = Y` is not implemented.
//
// The constructor evaluator does not resolve redirecting-factory constructors,
// so instantiating `_Shape()` (which redirects to `_Circle`) fails.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

abstract class _Shape {
  factory _Shape() = _Circle;
  String describe();
}

class _Circle implements _Shape {
  _Circle();
  @override
  String describe() => 'circle';
}

dynamic build(BuildContext context) {
  final _Shape shape = _Shape();
  return Center(child: Text(shape.describe()));
}
