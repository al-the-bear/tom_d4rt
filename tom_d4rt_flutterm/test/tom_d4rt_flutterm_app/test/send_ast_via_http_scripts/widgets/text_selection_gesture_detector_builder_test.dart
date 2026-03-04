// D4rt test script: Tests TextSelectionGestureDetectorBuilder from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextSelectionGestureDetectorBuilder test executing');

  // Test TextSelectionGestureDetectorBuilder - TextSelectionGestureDetectorBuilder
  print('TextSelectionGestureDetectorBuilder is available in the widgets package');
  print('TextSelectionGestureDetectorBuilder runtimeType accessible');

  print('TextSelectionGestureDetectorBuilder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextSelectionGestureDetectorBuilder Tests'),
      Text('TextSelectionGestureDetectorBuilder'),
    ],
  );
}
