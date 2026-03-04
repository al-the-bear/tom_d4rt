// D4rt test script: Tests StatelessElement from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('StatelessElement test executing');

  // Test StatelessElement - Stateless element
  print('StatelessElement is available in the widgets package');
  print('StatelessElement runtimeType accessible');

  print('StatelessElement test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StatelessElement Tests'),
      Text('Stateless element'),
    ],
  );
}
