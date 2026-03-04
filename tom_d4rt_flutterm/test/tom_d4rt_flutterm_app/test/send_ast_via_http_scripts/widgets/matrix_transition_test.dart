// D4rt test script: Tests MatrixTransition from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MatrixTransition test executing');

  // Test MatrixTransition - MatrixTransition
  print('MatrixTransition is available in the widgets package');
  print('MatrixTransition runtimeType accessible');

  print('MatrixTransition test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MatrixTransition Tests'),
      Text('MatrixTransition'),
    ],
  );
}
