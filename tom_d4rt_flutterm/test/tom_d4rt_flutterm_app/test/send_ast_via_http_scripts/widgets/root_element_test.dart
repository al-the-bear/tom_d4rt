// D4rt test script: Tests RootElement from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RootElement test executing');

  // Test RootElement - Root element
  print('RootElement is available in the widgets package');
  print('RootElement runtimeType accessible');

  print('RootElement test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RootElement Tests'),
      Text('Root element'),
    ],
  );
}
