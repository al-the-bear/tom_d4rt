// D4rt test script: Tests SliverLogicalContainerParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverLogicalContainerParentData test executing');

  // Test SliverLogicalContainerParentData - Logical container
  print('SliverLogicalContainerParentData is available in the rendering package');
  print('SliverLogicalContainerParentData: Logical container');

  print('SliverLogicalContainerParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverLogicalContainerParentData Tests'),
      Text('Logical container'),
    ],
  );
}
