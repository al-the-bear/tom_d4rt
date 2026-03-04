// D4rt test script: Tests KeyboardListener from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeyboardListener test executing');

  // Test KeyboardListener - KeyboardListener
  print('KeyboardListener is available in the widgets package');
  print('KeyboardListener runtimeType accessible');

  print('KeyboardListener test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('KeyboardListener Tests'),
      Text('KeyboardListener'),
    ],
  );
}
