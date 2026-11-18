// ignore_for_file: avoid_print
// D4rt test script: RenderClipRect, RenderClipRRect, RenderClipOval,
// RenderClipPath (rendering, addtests1).
//
// Builds each clip render object around a fixed-size child and reads its
// clip behaviour and dry layout; the clip itself applies when painting, which
// needs an attached render tree.
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

RenderBox _box() => RenderConstrainedBox(
  additionalConstraints: const BoxConstraints.tightFor(width: 40, height: 30),
);

dynamic build(BuildContext context) {
  print('=== RenderClip* ===');
  final rect = RenderClipRect(child: _box(), clipBehavior: Clip.hardEdge);
  final rrect = RenderClipRRect(
    child: _box(),
    borderRadius: BorderRadius.circular(8),
    clipBehavior: Clip.antiAlias,
  );
  final oval = RenderClipOval(child: _box());
  final path = RenderClipPath(child: _box());
  const c = BoxConstraints(maxWidth: 100, maxHeight: 100);
  print('rect: ${rect.clipBehavior} ${rect.getDryLayout(c)}');
  print('rrect: ${rrect.clipBehavior} ${rrect.borderRadius}');
  print('oval: ${oval.clipBehavior} ${oval.getDryLayout(c).width}');
  print('path: ${path.clipBehavior} ${path.getDryLayout(c).height}');
  rect.clipBehavior = Clip.none;
  print('rect after: ${rect.clipBehavior}');
  return const Center(child: Text('RenderClip'));
}
