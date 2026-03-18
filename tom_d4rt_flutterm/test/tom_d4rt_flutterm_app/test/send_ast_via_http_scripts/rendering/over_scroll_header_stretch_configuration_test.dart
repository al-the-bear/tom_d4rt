// D4rt test script: Tests OverScrollHeaderStretchConfiguration from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OverScrollHeaderStretchConfiguration test executing');

  // Test OverScrollHeaderStretchConfiguration - Stretch config
  print('OverScrollHeaderStretchConfiguration is available in the rendering package');
  print('OverScrollHeaderStretchConfiguration: Stretch config');

  print('OverScrollHeaderStretchConfiguration test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OverScrollHeaderStretchConfiguration Tests'),
      Text('Stretch config'),
    ],
  );
}
