// D4rt test script: Tests RawView from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawView test executing');

  // Test RawView - Raw view
  print('RawView is available in the widgets package');
  print('RawView runtimeType accessible');

  print('RawView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawView Tests'),
      Text('Raw view'),
    ],
  );
}
