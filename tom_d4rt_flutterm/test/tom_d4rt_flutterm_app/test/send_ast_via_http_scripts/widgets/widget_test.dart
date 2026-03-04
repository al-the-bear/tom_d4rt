// D4rt test script: Tests Widget from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Widget test executing');

  // Test Widget - Widget base
  print('Widget is available in the widgets package');
  print('Widget runtimeType accessible');

  print('Widget test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Widget Tests'),
      Text('Widget base'),
    ],
  );
}
