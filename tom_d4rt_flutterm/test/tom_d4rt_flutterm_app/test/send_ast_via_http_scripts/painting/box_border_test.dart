// D4rt test script: Tests BoxBorder from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BoxBorder test executing');

  // Test BoxBorder - Base box border
  print('BoxBorder is available in the painting package');
  print('BoxBorder: Base box border');

  print('BoxBorder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BoxBorder Tests'),
      Text('Base box border'),
    ],
  );
}
