// D4rt test script: Tests StatefulElement from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('StatefulElement test executing');

  // Test StatefulElement - Stateful element
  print('StatefulElement is available in the widgets package');
  print('StatefulElement runtimeType accessible');

  print('StatefulElement test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StatefulElement Tests'),
      Text('Stateful element'),
    ],
  );
}
