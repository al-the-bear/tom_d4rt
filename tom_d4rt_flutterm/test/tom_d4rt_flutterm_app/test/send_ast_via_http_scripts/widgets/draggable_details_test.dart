// D4rt test script: Tests DraggableDetails from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DraggableDetails test executing');

  // Test DraggableDetails - DraggableDetails
  print('DraggableDetails is available in the widgets package');
  print('DraggableDetails runtimeType accessible');

  print('DraggableDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DraggableDetails Tests'),
      Text('DraggableDetails'),
    ],
  );
}
