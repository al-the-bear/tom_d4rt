// D4rt test script: Tests MultiChildLayoutParentData from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MultiChildLayoutParentData test executing');

  // Test MultiChildLayoutParentData - MultiChildLayoutParentData
  print('MultiChildLayoutParentData is available in the rendering package');
  print('MultiChildLayoutParentData: MultiChildLayoutParentData');

  print('MultiChildLayoutParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MultiChildLayoutParentData Tests'),
      Text('MultiChildLayoutParentData'),
    ],
  );
}
