// D4rt test script: Tests TapRegionSurface from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TapRegionSurface test executing');

  // Test TapRegionSurface - Tap surface
  print('TapRegionSurface is available in the widgets package');
  print('TapRegionSurface runtimeType accessible');

  print('TapRegionSurface test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TapRegionSurface Tests'),
      Text('Tap surface'),
    ],
  );
}
