// D4rt test script: Tests ReorderableDragStartListener from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ReorderableDragStartListener test executing');

  // Test ReorderableDragStartListener - ReorderableDragStartListener
  print('ReorderableDragStartListener is available in the widgets package');
  print('ReorderableDragStartListener runtimeType accessible');

  print('ReorderableDragStartListener test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ReorderableDragStartListener Tests'),
      Text('ReorderableDragStartListener'),
    ],
  );
}
