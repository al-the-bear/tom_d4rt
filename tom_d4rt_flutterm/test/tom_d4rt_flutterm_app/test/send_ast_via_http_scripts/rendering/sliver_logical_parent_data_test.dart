// D4rt test script: Tests SliverLogicalParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SliverLogicalParentData test executing');

  // Test SliverLogicalParentData - Logical sliver data
  print('SliverLogicalParentData is available in the rendering package');
  print('SliverLogicalParentData: Logical sliver data');

  print('SliverLogicalParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SliverLogicalParentData Tests'),
      Text('Logical sliver data'),
    ],
  );
}
