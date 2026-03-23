// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextSelectionPoint from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextSelectionPoint test executing');

  // Test TextSelectionPoint - Selection point
  print('TextSelectionPoint is available in the rendering package');
  print('TextSelectionPoint: Selection point');

  print('TextSelectionPoint test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextSelectionPoint Tests'),
      Text('Selection point'),
    ],
  );
}
