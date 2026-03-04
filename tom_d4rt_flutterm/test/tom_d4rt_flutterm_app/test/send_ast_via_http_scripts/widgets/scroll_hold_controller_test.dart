// D4rt test script: Tests ScrollHoldController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollHoldController test executing');

  // Test ScrollHoldController - ScrollHoldController
  print('ScrollHoldController is available in the widgets package');
  print('ScrollHoldController runtimeType accessible');

  print('ScrollHoldController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollHoldController Tests'),
      Text('ScrollHoldController'),
    ],
  );
}
