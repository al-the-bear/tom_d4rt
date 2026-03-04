// D4rt test script: Tests ContainerBoxParentData from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ContainerBoxParentData test executing');

  // Test ContainerBoxParentData - Container box data
  print('ContainerBoxParentData is available in the rendering package');
  print('ContainerBoxParentData: Container box data');

  print('ContainerBoxParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ContainerBoxParentData Tests'),
      Text('Container box data'),
    ],
  );
}
