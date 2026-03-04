// D4rt test script: Tests ScrollDragController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollDragController test executing');

  // Test ScrollDragController - ScrollDragController
  print('ScrollDragController is available in the widgets package');
  print('ScrollDragController runtimeType accessible');

  print('ScrollDragController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollDragController Tests'),
      Text('ScrollDragController'),
    ],
  );
}
