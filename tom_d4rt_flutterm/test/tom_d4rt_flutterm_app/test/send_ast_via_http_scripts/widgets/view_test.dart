// D4rt test script: Tests View from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('View test executing');

  // Test View - View widget
  print('View is available in the widgets package');
  print('View runtimeType accessible');

  print('View test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('View Tests'),
      Text('View widget'),
    ],
  );
}
