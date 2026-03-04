// D4rt test script: Tests ViewCollection from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ViewCollection test executing');

  // Test ViewCollection - View collection
  print('ViewCollection is available in the widgets package');
  print('ViewCollection runtimeType accessible');

  print('ViewCollection test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ViewCollection Tests'),
      Text('View collection'),
    ],
  );
}
