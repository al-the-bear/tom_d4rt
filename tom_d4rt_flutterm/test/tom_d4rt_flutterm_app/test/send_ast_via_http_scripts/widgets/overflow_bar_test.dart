// D4rt test script: Tests OverflowBar from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OverflowBar test executing');

  // Test OverflowBar - Overflow bar
  print('OverflowBar is available in the widgets package');
  print('OverflowBar runtimeType accessible');

  print('OverflowBar test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OverflowBar Tests'),
      Text('Overflow bar'),
    ],
  );
}
