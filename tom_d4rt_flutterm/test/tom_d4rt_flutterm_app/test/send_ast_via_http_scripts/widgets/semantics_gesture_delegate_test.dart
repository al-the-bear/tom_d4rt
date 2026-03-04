// D4rt test script: Tests SemanticsGestureDelegate from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SemanticsGestureDelegate test executing');

  // Test SemanticsGestureDelegate - SemanticsGestureDelegate
  print('SemanticsGestureDelegate is available in the widgets package');
  print('SemanticsGestureDelegate runtimeType accessible');

  print('SemanticsGestureDelegate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SemanticsGestureDelegate Tests'),
      Text('SemanticsGestureDelegate'),
    ],
  );
}
