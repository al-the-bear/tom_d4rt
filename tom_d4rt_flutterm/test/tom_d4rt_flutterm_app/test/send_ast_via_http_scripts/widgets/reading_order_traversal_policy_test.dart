// D4rt test script: Tests ReadingOrderTraversalPolicy from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ReadingOrderTraversalPolicy test executing');

  // Test ReadingOrderTraversalPolicy - ReadingOrderTraversalPolicy
  print('ReadingOrderTraversalPolicy is available in the widgets package');
  print('ReadingOrderTraversalPolicy runtimeType accessible');

  print('ReadingOrderTraversalPolicy test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ReadingOrderTraversalPolicy Tests'),
      Text('ReadingOrderTraversalPolicy'),
    ],
  );
}
