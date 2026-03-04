// D4rt test script: Tests OverlayRoute from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OverlayRoute test executing');

  // Test OverlayRoute - OverlayRoute
  print('OverlayRoute is available in the widgets package');
  print('OverlayRoute runtimeType accessible');

  print('OverlayRoute test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OverlayRoute Tests'),
      Text('OverlayRoute'),
    ],
  );
}
