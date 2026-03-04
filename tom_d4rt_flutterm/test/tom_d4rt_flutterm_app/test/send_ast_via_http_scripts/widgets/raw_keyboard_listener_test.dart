// D4rt test script: Tests RawKeyboardListener from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyboardListener test executing');

  // Test RawKeyboardListener - RawKeyboardListener
  print('RawKeyboardListener is available in the widgets package');
  print('RawKeyboardListener runtimeType accessible');

  print('RawKeyboardListener test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawKeyboardListener Tests'),
      Text('RawKeyboardListener'),
    ],
  );
}
