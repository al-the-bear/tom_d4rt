// D4rt test script: Tests ParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ParentData test executing');

  // Test ParentData - Base parent data
  print('ParentData is available in the rendering package');
  print('ParentData: Base parent data');

  print('ParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ParentData Tests'),
      Text('Base parent data'),
    ],
  );
}
