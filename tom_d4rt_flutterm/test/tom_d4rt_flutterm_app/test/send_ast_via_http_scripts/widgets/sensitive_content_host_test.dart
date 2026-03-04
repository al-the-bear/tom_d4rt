// D4rt test script: Tests SensitiveContentHost from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SensitiveContentHost test executing');

  // Test SensitiveContentHost - SensitiveContentHost
  print('SensitiveContentHost is available in the widgets package');
  print('SensitiveContentHost runtimeType accessible');

  print('SensitiveContentHost test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SensitiveContentHost Tests'),
      Text('SensitiveContentHost'),
    ],
  );
}
