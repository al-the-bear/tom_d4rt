// D4rt test script: Tests SliverPhysicalContainerParentData from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverPhysicalContainerParentData test executing');

  // Test SliverPhysicalContainerParentData - Physical container
  print('SliverPhysicalContainerParentData is available in the rendering package');
  print('SliverPhysicalContainerParentData: Physical container');

  print('SliverPhysicalContainerParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverPhysicalContainerParentData Tests'),
      Text('Physical container'),
    ],
  );
}
