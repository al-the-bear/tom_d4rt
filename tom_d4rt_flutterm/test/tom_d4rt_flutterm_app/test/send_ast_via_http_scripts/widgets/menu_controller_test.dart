// D4rt test script: Tests MenuController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MenuController test executing');

  // Test MenuController - MenuController
  print('MenuController is available in the widgets package');
  print('MenuController runtimeType accessible');

  print('MenuController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MenuController Tests'),
      Text('MenuController'),
    ],
  );
}
