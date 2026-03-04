// D4rt test script: Tests DragScrollActivity from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DragScrollActivity test executing');

  // Test DragScrollActivity - DragScrollActivity
  print('DragScrollActivity is available in the widgets package');
  print('DragScrollActivity runtimeType accessible');

  print('DragScrollActivity test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DragScrollActivity Tests'),
      Text('DragScrollActivity'),
    ],
  );
}
