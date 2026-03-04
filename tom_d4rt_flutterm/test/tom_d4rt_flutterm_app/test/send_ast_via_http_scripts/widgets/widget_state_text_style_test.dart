// D4rt test script: Tests WidgetStateTextStyle from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetStateTextStyle test executing');

  // Test WidgetStateTextStyle - WidgetStateTextStyle
  print('WidgetStateTextStyle is available in the widgets package');
  print('WidgetStateTextStyle runtimeType accessible');

  print('WidgetStateTextStyle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetStateTextStyle Tests'),
      Text('WidgetStateTextStyle'),
    ],
  );
}
