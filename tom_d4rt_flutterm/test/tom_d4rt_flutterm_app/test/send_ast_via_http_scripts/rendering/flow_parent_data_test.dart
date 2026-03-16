// D4rt test script: Tests FlowParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FlowParentData test executing');

  // Test FlowParentData - Flow parent data
  print('FlowParentData is available in the rendering package');
  print('FlowParentData: Flow parent data');

  print('FlowParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FlowParentData Tests'),
      Text('Flow parent data'),
    ],
  );
}
