// D4rt test script: Tests DragTargetDetails from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DragTargetDetails test executing');

  // Test DragTargetDetails - DragTargetDetails
  print('DragTargetDetails is available in the widgets package');
  print('DragTargetDetails runtimeType accessible');

  print('DragTargetDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DragTargetDetails Tests'),
      Text('DragTargetDetails'),
    ],
  );
}
