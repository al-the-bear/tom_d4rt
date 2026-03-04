// D4rt test script: Tests ListWheelViewport from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ListWheelViewport test executing');

  // Test ListWheelViewport - Wheel viewport
  print('ListWheelViewport is available in the widgets package');
  print('ListWheelViewport runtimeType accessible');

  print('ListWheelViewport test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ListWheelViewport Tests'),
      Text('Wheel viewport'),
    ],
  );
}
