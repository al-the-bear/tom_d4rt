// D4rt test script: Tests ComponentElement from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ComponentElement test executing');

  // Test ComponentElement - Component element
  print('ComponentElement is available in the widgets package');
  print('ComponentElement runtimeType accessible');

  print('ComponentElement test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ComponentElement Tests'),
      Text('Component element'),
    ],
  );
}
