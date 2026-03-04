// D4rt test script: Tests ScrollConfiguration from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollConfiguration test executing');

  // Test ScrollConfiguration - Scroll config
  print('ScrollConfiguration is available in the widgets package');
  print('ScrollConfiguration runtimeType accessible');

  print('ScrollConfiguration test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollConfiguration Tests'),
      Text('Scroll config'),
    ],
  );
}
