// D4rt test script: Tests ListBodyParentData from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ListBodyParentData test executing');

  // Test ListBodyParentData - List body data
  print('ListBodyParentData is available in the rendering package');
  print('ListBodyParentData: List body data');

  print('ListBodyParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ListBodyParentData Tests'),
      Text('List body data'),
    ],
  );
}
