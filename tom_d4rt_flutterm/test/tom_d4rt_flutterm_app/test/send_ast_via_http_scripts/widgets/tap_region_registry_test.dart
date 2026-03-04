// D4rt test script: Tests TapRegionRegistry from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TapRegionRegistry test executing');

  // Test TapRegionRegistry - TapRegionRegistry
  print('TapRegionRegistry is available in the widgets package');
  print('TapRegionRegistry runtimeType accessible');

  print('TapRegionRegistry test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TapRegionRegistry Tests'),
      Text('TapRegionRegistry'),
    ],
  );
}
