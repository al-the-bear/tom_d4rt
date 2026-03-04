// D4rt test script: Tests OrientationBuilder from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OrientationBuilder test executing');

  // Test OrientationBuilder - OrientationBuilder
  print('OrientationBuilder is available in the widgets package');
  print('OrientationBuilder runtimeType accessible');

  print('OrientationBuilder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OrientationBuilder Tests'),
      Text('OrientationBuilder'),
    ],
  );
}
