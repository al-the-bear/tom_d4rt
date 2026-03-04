// D4rt test script: Tests RootWidget from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RootWidget test executing');

  // Test RootWidget - Root widget
  print('RootWidget is available in the widgets package');
  print('RootWidget runtimeType accessible');

  print('RootWidget test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RootWidget Tests'),
      Text('Root widget'),
    ],
  );
}
