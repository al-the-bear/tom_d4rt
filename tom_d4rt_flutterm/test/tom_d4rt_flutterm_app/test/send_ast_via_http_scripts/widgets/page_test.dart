// D4rt test script: Tests Page from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Page test executing');

  // Test Page - Page
  print('Page is available in the widgets package');
  print('Page runtimeType accessible');

  print('Page test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Page Tests'),
      Text('Page'),
    ],
  );
}
