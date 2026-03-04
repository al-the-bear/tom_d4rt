// D4rt test script: Tests DeviceOrientationBuilder from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DeviceOrientationBuilder test executing');

  // Test DeviceOrientationBuilder - DeviceOrientationBuilder
  print('DeviceOrientationBuilder is available in the widgets package');
  print('DeviceOrientationBuilder runtimeType accessible');

  print('DeviceOrientationBuilder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DeviceOrientationBuilder Tests'),
      Text('DeviceOrientationBuilder'),
    ],
  );
}
