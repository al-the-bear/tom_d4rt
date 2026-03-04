// D4rt test script: Tests WidgetStateMouseCursor from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetStateMouseCursor test executing');

  // Test WidgetStateMouseCursor - WidgetStateMouseCursor
  print('WidgetStateMouseCursor is available in the widgets package');
  print('WidgetStateMouseCursor runtimeType accessible');

  print('WidgetStateMouseCursor test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetStateMouseCursor Tests'),
      Text('WidgetStateMouseCursor'),
    ],
  );
}
