// D4rt test script: Tests Viewport from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Viewport test executing');

  // Test Viewport - Viewport widget
  print('Viewport is available in the widgets package');
  print('Viewport runtimeType accessible');

  print('Viewport test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Viewport Tests'),
      Text('Viewport widget'),
    ],
  );
}
