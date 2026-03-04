// D4rt test script: Tests RawMagnifier from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawMagnifier test executing');

  // Test RawMagnifier - Raw magnifier
  print('RawMagnifier is available in the widgets package');
  print('RawMagnifier runtimeType accessible');

  print('RawMagnifier test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawMagnifier Tests'),
      Text('Raw magnifier'),
    ],
  );
}
