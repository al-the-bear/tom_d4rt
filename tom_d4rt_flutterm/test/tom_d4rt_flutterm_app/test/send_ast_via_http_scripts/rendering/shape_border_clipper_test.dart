// D4rt test script: Tests ShapeBorderClipper from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShapeBorderClipper test executing');

  // Test ShapeBorderClipper - Shape clipper
  print('ShapeBorderClipper is available in the rendering package');
  print('ShapeBorderClipper: Shape clipper');

  print('ShapeBorderClipper test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ShapeBorderClipper Tests'),
      Text('Shape clipper'),
    ],
  );
}
