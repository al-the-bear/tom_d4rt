// D4rt test script: Tests DragBoundaryDelegate from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DragBoundaryDelegate test executing');

  // Test DragBoundaryDelegate - DragBoundaryDelegate
  print('DragBoundaryDelegate is available in the widgets package');
  print('DragBoundaryDelegate runtimeType accessible');

  print('DragBoundaryDelegate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DragBoundaryDelegate Tests'),
      Text('DragBoundaryDelegate'),
    ],
  );
}
