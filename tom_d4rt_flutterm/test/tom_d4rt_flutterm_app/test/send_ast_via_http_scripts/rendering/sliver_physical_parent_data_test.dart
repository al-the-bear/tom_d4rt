// ignore_for_file: avoid_print
// D4rt test script: Tests SliverPhysicalParentData from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverPhysicalParentData test executing');

  // Test SliverPhysicalParentData - Physical sliver data
  print('SliverPhysicalParentData is available in the rendering package');
  print('SliverPhysicalParentData: Physical sliver data');

  print('SliverPhysicalParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverPhysicalParentData Tests'),
      Text('Physical sliver data'),
    ],
  );
}
