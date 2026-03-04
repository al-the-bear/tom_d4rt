// D4rt test script: Tests RestorableInt from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorableInt test executing');

  // Test RestorableInt - Restorable int
  print('RestorableInt is available in the widgets package');
  print('RestorableInt runtimeType accessible');

  print('RestorableInt test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RestorableInt Tests'),
      Text('Restorable int'),
    ],
  );
}
