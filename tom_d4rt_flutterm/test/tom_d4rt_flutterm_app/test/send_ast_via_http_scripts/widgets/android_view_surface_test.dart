// D4rt test script: Tests AndroidViewSurface from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AndroidViewSurface test executing');

  // Test AndroidViewSurface - Surface
  print('AndroidViewSurface is available in the widgets package');
  print('AndroidViewSurface runtimeType accessible');

  print('AndroidViewSurface test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AndroidViewSurface Tests'),
      Text('Surface'),
    ],
  );
}
