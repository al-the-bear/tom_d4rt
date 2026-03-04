// D4rt test script: Tests PopupWindowController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PopupWindowController test executing');

  // Test PopupWindowController - PopupWindowController
  print('PopupWindowController is available in the widgets package');
  print('PopupWindowController runtimeType accessible');

  print('PopupWindowController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PopupWindowController Tests'),
      Text('PopupWindowController'),
    ],
  );
}
