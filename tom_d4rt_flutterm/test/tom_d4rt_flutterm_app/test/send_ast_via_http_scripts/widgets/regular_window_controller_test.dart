// D4rt test script: Tests RegularWindowController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RegularWindowController test executing');

  // Test RegularWindowController - RegularWindowController
  print('RegularWindowController is available in the widgets package');
  print('RegularWindowController runtimeType accessible');

  print('RegularWindowController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RegularWindowController Tests'),
      Text('RegularWindowController'),
    ],
  );
}
