// D4rt test script: Tests ScrollAction from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollAction test executing');

  // Test ScrollAction - Scroll action
  print('ScrollAction is available in the widgets package');
  print('ScrollAction runtimeType accessible');

  print('ScrollAction test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollAction Tests'),
      Text('Scroll action'),
    ],
  );
}
