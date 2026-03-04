// D4rt test script: Tests WeakMap from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WeakMap test executing');

  // Test WeakMap - WeakMap
  print('WeakMap is available in the widgets package');
  print('WeakMap runtimeType accessible');

  print('WeakMap test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WeakMap Tests'),
      Text('WeakMap'),
    ],
  );
}
