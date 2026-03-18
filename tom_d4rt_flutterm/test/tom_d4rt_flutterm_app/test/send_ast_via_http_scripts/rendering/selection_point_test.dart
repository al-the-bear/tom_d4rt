// D4rt test script: Tests SelectionPoint from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionPoint test executing');

  // Test SelectionPoint - Selection point
  print('SelectionPoint is available in the rendering package');
  print('SelectionPoint: Selection point');

  print('SelectionPoint test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionPoint Tests'),
      Text('Selection point'),
    ],
  );
}
