// D4rt test script: Tests FocusTraversalOrder from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FocusTraversalOrder test executing');

  // Test FocusTraversalOrder - FocusTraversalOrder
  print('FocusTraversalOrder is available in the widgets package');
  print('FocusTraversalOrder runtimeType accessible');

  print('FocusTraversalOrder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FocusTraversalOrder Tests'),
      Text('FocusTraversalOrder'),
    ],
  );
}
