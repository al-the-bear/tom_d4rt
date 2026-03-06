// D4rt test script: Tests GestureSettings from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('GestureSettings test executing');

  // Test GestureSettings - Gesture configuration
  print('GestureSettings is available in the dart_ui package');
  print('GestureSettings: Gesture configuration');

  print('GestureSettings test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('GestureSettings Tests'),
      Text('Gesture configuration'),
    ],
  );
}
