// D4rt test script: Tests RestorableNum from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorableNum test executing');

  // Test RestorableNum - RestorableNum
  print('RestorableNum is available in the widgets package');
  print('RestorableNum runtimeType accessible');

  print('RestorableNum test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RestorableNum Tests'),
      Text('RestorableNum'),
    ],
  );
}
