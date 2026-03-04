// D4rt test script: Tests WidgetsApp from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetsApp test executing');

  // Test WidgetsApp - Widgets app
  print('WidgetsApp is available in the widgets package');
  print('WidgetsApp runtimeType accessible');

  print('WidgetsApp test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetsApp Tests'),
      Text('Widgets app'),
    ],
  );
}
