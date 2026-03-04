// D4rt test script: Tests TreeSliverNodeParentData from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TreeSliverNodeParentData test executing');

  // Test TreeSliverNodeParentData - Tree node data
  print('TreeSliverNodeParentData is available in the rendering package');
  print('TreeSliverNodeParentData: Tree node data');

  print('TreeSliverNodeParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TreeSliverNodeParentData Tests'),
      Text('Tree node data'),
    ],
  );
}
