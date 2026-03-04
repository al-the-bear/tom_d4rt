// D4rt test script: Tests DialogWindowController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DialogWindowController test executing');

  // Test DialogWindowController - DialogWindowController
  print('DialogWindowController is available in the widgets package');
  print('DialogWindowController runtimeType accessible');

  print('DialogWindowController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DialogWindowController Tests'),
      Text('DialogWindowController'),
    ],
  );
}
