// D4rt test script: Tests KeyData from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeyData test executing');

  // Test KeyData - Keyboard events
  print('KeyData is available in the dart_ui package');
  print('KeyData: Keyboard events');

  print('KeyData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('KeyData Tests'),
      Text('Keyboard events'),
    ],
  );
}
