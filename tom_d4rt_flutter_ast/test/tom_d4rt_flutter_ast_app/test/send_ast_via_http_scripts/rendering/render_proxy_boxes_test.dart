// ignore_for_file: avoid_print
// D4rt test script: RenderAspectRatio, RenderFittedBox, RenderIntrinsicWidth,
// RenderIntrinsicHeight, RenderLimitedBox, RenderOpacity, RenderTransform,
// RenderDecoratedBox (rendering, addtests1).
//
// Builds each single-child render object around a fixed-size child and asks
// for what it computes without an attached tree: dry layouts, intrinsics,
// and its properties.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

RenderBox _box(double w, double h) => RenderConstrainedBox(
  additionalConstraints: BoxConstraints.tightFor(width: w, height: h),
);

dynamic build(BuildContext context) {
  print('=== proxy boxes ===');
  const loose = BoxConstraints(maxWidth: 200, maxHeight: 200);

  final aspect = RenderAspectRatio(aspectRatio: 2, child: _box(10, 10));
  print('aspect: ${aspect.aspectRatio} ${aspect.getDryLayout(loose)}');

  final fitted = RenderFittedBox(fit: BoxFit.contain, child: _box(40, 20));
  print('fitted: ${fitted.fit} ${fitted.getDryLayout(loose)}');

  final iw = RenderIntrinsicWidth(stepWidth: 25, child: _box(30, 10));
  print('intrinsic width: ${iw.getDryLayout(loose).width}');

  final ih = RenderIntrinsicHeight(child: _box(30, 15));
  print('intrinsic height: ${ih.getDryLayout(loose).height}');

  final limited = RenderLimitedBox(maxWidth: 50, maxHeight: 60);
  final unbounded = limited.getDryLayout(const BoxConstraints());
  print(
    'limited: ${limited.maxWidth} ${unbounded.width} x ${unbounded.height}',
  );

  final opacity = RenderOpacity(opacity: 0.5, child: _box(5, 5));
  print('opacity: ${opacity.opacity}');
  opacity.opacity = 0.25;
  print('opacity after: ${opacity.opacity}');

  final transform = RenderTransform(
    transform: Matrix4.identity()..scaleByDouble(2, 2, 1, 1),
    child: _box(5, 5),
  );
  print('transform identity: ${transform.transformHitTests}');

  final decorated = RenderDecoratedBox(
    decoration: const BoxDecoration(color: Colors.teal),
    child: _box(12, 8),
  );
  print('decorated: ${decorated.position} ${decorated.getDryLayout(loose)}');
  return const Center(child: Text('proxy boxes'));
}
