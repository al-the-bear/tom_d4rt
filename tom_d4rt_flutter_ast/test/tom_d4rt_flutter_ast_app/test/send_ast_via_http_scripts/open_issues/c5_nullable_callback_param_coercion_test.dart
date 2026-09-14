// Reproduces C.5 — nullable callback param coercion (semanticsBuilder, idx 310).
//
// The generator does not coerce nullable function-typed params (e.g.
// `SemanticsBuilderCallback?` on CustomPainter.semanticsBuilder), so a script
// painter that supplies one fails to cross the bridge.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class _LabeledPainter extends CustomPainter {
  const _LabeledPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = Colors.blue);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;

  @override
  SemanticsBuilderCallback? get semanticsBuilder => (Size size) =>
      <CustomPainterSemantics>[];
}

dynamic build(BuildContext context) {
  return const CustomPaint(
    size: Size(20, 20),
    painter: _LabeledPainter(),
  );
}
