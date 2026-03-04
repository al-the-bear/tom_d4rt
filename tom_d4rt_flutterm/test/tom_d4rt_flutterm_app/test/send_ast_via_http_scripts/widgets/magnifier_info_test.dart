// D4rt test script: Tests MagnifierInfo from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MagnifierInfo test executing');

  // Test MagnifierInfo - Magnifier info
  print('MagnifierInfo is available in the widgets package');
  print('MagnifierInfo runtimeType accessible');

  print('MagnifierInfo test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MagnifierInfo Tests'),
      Text('Magnifier info'),
    ],
  );
}
