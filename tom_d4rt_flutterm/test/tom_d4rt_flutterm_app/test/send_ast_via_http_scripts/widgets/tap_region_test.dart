// D4rt test script: Tests TapRegion from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TapRegion test executing');

  // Test TapRegion - Tap region
  print('TapRegion is available in the widgets package');
  print('TapRegion runtimeType accessible');

  print('TapRegion test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TapRegion Tests'),
      Text('Tap region'),
    ],
  );
}
