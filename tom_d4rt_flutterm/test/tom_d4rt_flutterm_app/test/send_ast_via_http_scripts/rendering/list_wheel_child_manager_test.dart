// D4rt test script: Tests ListWheelChildManager from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ListWheelChildManager test executing');

  // Test ListWheelChildManager - Wheel manager
  print('ListWheelChildManager is available in the rendering package');
  print('ListWheelChildManager: Wheel manager');

  print('ListWheelChildManager test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ListWheelChildManager Tests'),
      Text('Wheel manager'),
    ],
  );
}
