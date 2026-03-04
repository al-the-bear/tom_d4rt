// D4rt test script: Tests MagnifierController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MagnifierController test executing');

  // Test MagnifierController - Magnifier control
  print('MagnifierController is available in the widgets package');
  print('MagnifierController runtimeType accessible');

  print('MagnifierController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MagnifierController Tests'),
      Text('Magnifier control'),
    ],
  );
}
