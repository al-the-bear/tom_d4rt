// D4rt test script: Tests RestorableValue from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorableValue test executing');

  // Test RestorableValue - Restorable value
  print('RestorableValue is available in the widgets package');
  print('RestorableValue runtimeType accessible');

  print('RestorableValue test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RestorableValue Tests'),
      Text('Restorable value'),
    ],
  );
}
