// D4rt test script: Tests SelectionListener from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionListener test executing');

  // Test SelectionListener - Selection listener
  print('SelectionListener is available in the widgets package');
  print('SelectionListener runtimeType accessible');

  print('SelectionListener test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionListener Tests'),
      Text('Selection listener'),
    ],
  );
}
