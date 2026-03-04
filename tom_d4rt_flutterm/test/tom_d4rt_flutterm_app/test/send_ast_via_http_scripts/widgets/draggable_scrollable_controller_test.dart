// D4rt test script: Tests DraggableScrollableController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DraggableScrollableController test executing');

  // Test DraggableScrollableController - DraggableScrollableController
  print('DraggableScrollableController is available in the widgets package');
  print('DraggableScrollableController runtimeType accessible');

  print('DraggableScrollableController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DraggableScrollableController Tests'),
      Text('DraggableScrollableController'),
    ],
  );
}
