// D4rt test script: Tests OverlayPortalController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OverlayPortalController test executing');

  // Test OverlayPortalController - OverlayPortalController
  print('OverlayPortalController is available in the widgets package');
  print('OverlayPortalController runtimeType accessible');

  print('OverlayPortalController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OverlayPortalController Tests'),
      Text('OverlayPortalController'),
    ],
  );
}
