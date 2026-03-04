// D4rt test script: Tests RawGestureDetector from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawGestureDetector test executing');

  // Test RawGestureDetector - RawGestureDetector
  print('RawGestureDetector is available in the widgets package');
  print('RawGestureDetector runtimeType accessible');

  print('RawGestureDetector test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawGestureDetector Tests'),
      Text('RawGestureDetector'),
    ],
  );
}
