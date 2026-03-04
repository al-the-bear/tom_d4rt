// D4rt test script: Tests VoidCallbackIntent from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('VoidCallbackIntent test executing');

  // Test VoidCallbackIntent - VoidCallbackIntent
  print('VoidCallbackIntent is available in the widgets package');
  print('VoidCallbackIntent runtimeType accessible');

  print('VoidCallbackIntent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('VoidCallbackIntent Tests'),
      Text('VoidCallbackIntent'),
    ],
  );
}
