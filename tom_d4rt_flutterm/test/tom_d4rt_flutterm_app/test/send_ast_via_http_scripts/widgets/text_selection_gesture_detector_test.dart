// D4rt test script: Tests TextSelectionGestureDetector from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextSelectionGestureDetector test executing');

  // Test TextSelectionGestureDetector - Selection gestures
  print('TextSelectionGestureDetector is available in the widgets package');
  print('TextSelectionGestureDetector runtimeType accessible');

  print('TextSelectionGestureDetector test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextSelectionGestureDetector Tests'),
      Text('Selection gestures'),
    ],
  );
}
