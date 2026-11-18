// ignore_for_file: avoid_print
// D4rt test script: RenderListBody, RenderWrap (rendering, addtests1).
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

RenderBox _box(double w, double h) => RenderConstrainedBox(
  additionalConstraints: BoxConstraints.tightFor(width: w, height: h),
);

dynamic build(BuildContext context) {
  print('=== RenderListBody ===');
  final list = RenderListBody(children: [_box(30, 10), _box(30, 20)]);
  print('list axis: ${list.axisDirection}');
  print('list children: ${list.childCount}');
  print('list intrinsic height: ${list.getMinIntrinsicHeight(100)}');

  print('=== RenderWrap ===');
  final wrap = RenderWrap(
    spacing: 4,
    runSpacing: 6,
    textDirection: TextDirection.ltr,
    children: [_box(40, 10), _box(40, 10), _box(40, 10)],
  );
  print('wrap spacing: ${wrap.spacing} ${wrap.runSpacing}');
  final size = wrap.getDryLayout(
    const BoxConstraints(maxWidth: 90, maxHeight: 200),
  );
  print('wrap dry size: ${size.width} x ${size.height}');
  return const Center(child: Text('list body / wrap'));
}
