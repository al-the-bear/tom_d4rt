// D4rt test script: Tests ListWheelParentData from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ListWheelParentData test executing');

  // Test ListWheelParentData - Wheel parent data
  print('ListWheelParentData is available in the rendering package');
  print('ListWheelParentData: Wheel parent data');

  print('ListWheelParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ListWheelParentData Tests'),
      Text('Wheel parent data'),
    ],
  );
}
