// ignore_for_file: avoid_print
// D4rt test script: RenderStack, StackParentData, RenderPositionedBox
// (rendering, addtests1).
//
// Builds a RenderStack whose children carry StackParentData, positions one,
// and asks a RenderPositionedBox for its dry layout with a width factor.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

RenderBox _box(double w, double h) => RenderConstrainedBox(
  additionalConstraints: BoxConstraints.tightFor(width: w, height: h),
);

dynamic build(BuildContext context) {
  print('=== RenderStack ===');
  final small = _box(20, 20);
  final big = _box(60, 40);
  final stack = RenderStack(
    alignment: Alignment.center,
    textDirection: TextDirection.ltr,
    children: [small, big],
  );
  final data = small.parentData as StackParentData;
  print('positioned before: ${data.isPositioned}');
  data.left = 5;
  data.top = 7;
  print('positioned after: ${data.isPositioned}');
  print('stack children: ${stack.childCount}');
  final size = stack.getDryLayout(
    const BoxConstraints(maxWidth: 200, maxHeight: 200),
  );
  print('stack dry size: ${size.width} x ${size.height}');

  print('=== RenderPositionedBox ===');
  final positioned = RenderPositionedBox(
    alignment: Alignment.topLeft,
    widthFactor: 2,
    heightFactor: 3,
    child: _box(10, 10),
  );
  final p = positioned.getDryLayout(
    const BoxConstraints(maxWidth: 500, maxHeight: 500),
  );
  print('positioned dry size: ${p.width} x ${p.height}');
  print('widthFactor: ${positioned.widthFactor}');
  return const Center(child: Text('RenderStack'));
}
