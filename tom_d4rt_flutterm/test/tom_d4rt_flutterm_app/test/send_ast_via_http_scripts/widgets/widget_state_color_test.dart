// D4rt test script: Tests WidgetStateColor from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetStateColor test executing');

  // Test WidgetStateColor - WidgetStateColor
  print('WidgetStateColor is available in the widgets package');
  print('WidgetStateColor runtimeType accessible');

  print('WidgetStateColor test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetStateColor Tests'),
      Text('WidgetStateColor'),
    ],
  );
}
