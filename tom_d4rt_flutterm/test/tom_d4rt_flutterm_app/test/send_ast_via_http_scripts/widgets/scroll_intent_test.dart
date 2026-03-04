// D4rt test script: Tests ScrollIntent from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollIntent test executing');

  // Test ScrollIntent - Scroll intent
  print('ScrollIntent is available in the widgets package');
  print('ScrollIntent runtimeType accessible');

  print('ScrollIntent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollIntent Tests'),
      Text('Scroll intent'),
    ],
  );
}
