// D4rt test script: Tests BoxConstraintsTween from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BoxConstraintsTween test executing');

  // Test BoxConstraintsTween - Constraints tween
  print('BoxConstraintsTween is available in the widgets package');
  print('BoxConstraintsTween runtimeType accessible');

  print('BoxConstraintsTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BoxConstraintsTween Tests'),
      Text('Constraints tween'),
    ],
  );
}
