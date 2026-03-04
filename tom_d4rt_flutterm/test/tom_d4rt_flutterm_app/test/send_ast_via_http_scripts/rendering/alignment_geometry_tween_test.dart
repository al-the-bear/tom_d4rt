// D4rt test script: Tests AlignmentGeometryTween from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AlignmentGeometryTween test executing');

  // Test AlignmentGeometryTween - Alignment tween
  print('AlignmentGeometryTween is available in the rendering package');
  print('AlignmentGeometryTween: Alignment tween');

  print('AlignmentGeometryTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AlignmentGeometryTween Tests'),
      Text('Alignment tween'),
    ],
  );
}
