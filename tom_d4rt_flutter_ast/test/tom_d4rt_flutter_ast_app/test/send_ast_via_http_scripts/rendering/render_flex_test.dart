// ignore_for_file: avoid_print
// D4rt test script: RenderFlex, FlexParentData (rendering, addtests1).
//
// Builds a RenderFlex with three fixed-size children, sets one child's flex
// through its FlexParentData, and asks for the dry layout and intrinsics,
// which need no attached render tree.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

RenderBox _box(double w, double h) => RenderConstrainedBox(
  additionalConstraints: BoxConstraints.tightFor(width: w, height: h),
);

dynamic build(BuildContext context) {
  print('=== RenderFlex ===');
  final a = _box(20, 10);
  final b = _box(30, 40);
  final c = _box(10, 5);
  final flex = RenderFlex(
    direction: Axis.horizontal,
    mainAxisSize: MainAxisSize.min,
    textDirection: TextDirection.ltr,
    children: [a, b, c],
  );
  print('direction: ${flex.direction}');
  print('child count: ${flex.childCount}');
  final data = b.parentData as FlexParentData;
  data.flex = 2;
  data.fit = FlexFit.tight;
  print('flex data: ${data.flex} ${data.fit}');
  print('first child is a: ${identical(flex.firstChild, a)}');
  final size = flex.getDryLayout(
    const BoxConstraints(maxWidth: 300, maxHeight: 100),
  );
  print('min dry size: ${size.width} x ${size.height}');
  print('min intrinsic width: ${flex.getMinIntrinsicWidth(100)}');
  flex.direction = Axis.vertical;
  print('vertical intrinsic height: ${flex.getMinIntrinsicHeight(100)}');
  return const Center(child: Text('RenderFlex'));
}
