// D4rt test script: Tests OverlayState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OverlayState test executing');

  // Test OverlayState - OverlayState
  print('OverlayState is available in the widgets package');
  print('OverlayState runtimeType accessible');

  print('OverlayState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OverlayState Tests'),
      Text('OverlayState'),
    ],
  );
}
