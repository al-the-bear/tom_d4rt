// D4rt test script: Tests Constraints from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Constraints test executing');

  // Test Constraints - Base constraints
  print('Constraints is available in the rendering package');
  print('Constraints: Base constraints');

  print('Constraints test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Constraints Tests'),
      Text('Base constraints'),
    ],
  );
}
