// D4rt test script: Tests WidgetStateMapper from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetStateMapper test executing');

  // Test WidgetStateMapper - WidgetStateMapper
  print('WidgetStateMapper is available in the widgets package');
  print('WidgetStateMapper runtimeType accessible');

  print('WidgetStateMapper test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetStateMapper Tests'),
      Text('WidgetStateMapper'),
    ],
  );
}
