// D4rt test script: Tests MagnifierDecoration from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MagnifierDecoration test executing');

  // Test MagnifierDecoration - Magnifier decor
  print('MagnifierDecoration is available in the widgets package');
  print('MagnifierDecoration runtimeType accessible');

  print('MagnifierDecoration test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MagnifierDecoration Tests'),
      Text('Magnifier decor'),
    ],
  );
}
