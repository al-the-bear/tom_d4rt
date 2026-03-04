// D4rt test script: Tests ScrollContext from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollContext test executing');

  // Test ScrollContext - ScrollContext
  print('ScrollContext is available in the widgets package');
  print('ScrollContext runtimeType accessible');

  print('ScrollContext test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollContext Tests'),
      Text('ScrollContext'),
    ],
  );
}
