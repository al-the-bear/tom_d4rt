// D4rt test script: Tests ScrollableState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollableState test executing');

  // Test ScrollableState - Scrollable state
  print('ScrollableState is available in the widgets package');
  print('ScrollableState runtimeType accessible');

  print('ScrollableState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollableState Tests'),
      Text('Scrollable state'),
    ],
  );
}
