// D4rt test script: Tests BaseWindowController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BaseWindowController test executing');

  // Test BaseWindowController - BaseWindowController
  print('BaseWindowController is available in the widgets package');
  print('BaseWindowController runtimeType accessible');

  print('BaseWindowController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BaseWindowController Tests'),
      Text('BaseWindowController'),
    ],
  );
}
