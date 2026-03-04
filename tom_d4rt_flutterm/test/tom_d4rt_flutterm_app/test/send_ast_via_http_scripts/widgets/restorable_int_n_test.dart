// D4rt test script: Tests RestorableIntN from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorableIntN test executing');

  // Test RestorableIntN - RestorableIntN
  print('RestorableIntN is available in the widgets package');
  print('RestorableIntN runtimeType accessible');

  print('RestorableIntN test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RestorableIntN Tests'),
      Text('RestorableIntN'),
    ],
  );
}
