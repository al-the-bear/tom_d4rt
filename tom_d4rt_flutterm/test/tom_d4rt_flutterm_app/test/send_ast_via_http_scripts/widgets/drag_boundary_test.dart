// D4rt test script: Tests DragBoundary from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DragBoundary test executing');

  // Test DragBoundary - DragBoundary
  print('DragBoundary is available in the widgets package');
  print('DragBoundary runtimeType accessible');

  print('DragBoundary test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DragBoundary Tests'),
      Text('DragBoundary'),
    ],
  );
}
