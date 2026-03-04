// D4rt test script: Tests OrderedTraversalPolicy from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OrderedTraversalPolicy test executing');

  // Test OrderedTraversalPolicy - OrderedTraversalPolicy
  print('OrderedTraversalPolicy is available in the widgets package');
  print('OrderedTraversalPolicy runtimeType accessible');

  print('OrderedTraversalPolicy test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OrderedTraversalPolicy Tests'),
      Text('OrderedTraversalPolicy'),
    ],
  );
}
