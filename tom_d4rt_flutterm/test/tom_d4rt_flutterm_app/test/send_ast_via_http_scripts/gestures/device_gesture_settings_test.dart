// D4rt test script: Tests DeviceGestureSettings from gestures
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DeviceGestureSettings test executing');

  // Test DeviceGestureSettings - Device settings
  print('DeviceGestureSettings is available in the gestures package');
  print('DeviceGestureSettings: Device settings');

  print('DeviceGestureSettings test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DeviceGestureSettings Tests'),
      Text('Device settings'),
    ],
  );
}
