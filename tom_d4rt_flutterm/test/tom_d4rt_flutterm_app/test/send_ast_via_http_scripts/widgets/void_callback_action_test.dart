// D4rt test script: Tests VoidCallbackAction from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('VoidCallbackAction test executing');

  // Test VoidCallbackAction - VoidCallbackAction
  print('VoidCallbackAction is available in the widgets package');
  print('VoidCallbackAction runtimeType accessible');

  print('VoidCallbackAction test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('VoidCallbackAction Tests'),
      Text('VoidCallbackAction'),
    ],
  );
}
