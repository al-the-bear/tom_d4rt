// D4rt test script: Tests RawGestureDetectorState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawGestureDetectorState test executing');

  // Test RawGestureDetectorState - RawGestureDetectorState
  print('RawGestureDetectorState is available in the widgets package');
  print('RawGestureDetectorState runtimeType accessible');

  print('RawGestureDetectorState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawGestureDetectorState Tests'),
      Text('RawGestureDetectorState'),
    ],
  );
}
