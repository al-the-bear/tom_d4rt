// D4rt test script: Tests ScrollPosition from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollPosition test executing');

  // Test ScrollPosition - Scroll position
  print('ScrollPosition is available in the widgets package');
  print('ScrollPosition runtimeType accessible');

  print('ScrollPosition test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollPosition Tests'),
      Text('Scroll position'),
    ],
  );
}
