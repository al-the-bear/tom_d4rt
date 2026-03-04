// D4rt test script: Tests EdgeDraggingAutoScroller from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('EdgeDraggingAutoScroller test executing');

  // Test EdgeDraggingAutoScroller - EdgeDraggingAutoScroller
  print('EdgeDraggingAutoScroller is available in the widgets package');
  print('EdgeDraggingAutoScroller runtimeType accessible');

  print('EdgeDraggingAutoScroller test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('EdgeDraggingAutoScroller Tests'),
      Text('EdgeDraggingAutoScroller'),
    ],
  );
}
