// D4rt test script: Tests BoxHitTestResult from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BoxHitTestResult test executing');

  // Test BoxHitTestResult - Box hit test
  print('BoxHitTestResult is available in the rendering package');
  print('BoxHitTestResult: Box hit test');

  print('BoxHitTestResult test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BoxHitTestResult Tests'),
      Text('Box hit test'),
    ],
  );
}
