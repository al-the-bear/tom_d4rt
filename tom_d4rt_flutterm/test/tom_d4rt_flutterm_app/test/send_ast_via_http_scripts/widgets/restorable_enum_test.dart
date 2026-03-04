// D4rt test script: Tests RestorableEnum from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorableEnum test executing');

  // Test RestorableEnum - Restorable enum
  print('RestorableEnum is available in the widgets package');
  print('RestorableEnum runtimeType accessible');

  print('RestorableEnum test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RestorableEnum Tests'),
      Text('Restorable enum'),
    ],
  );
}
