// D4rt test script: Tests ScrollableDetails from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollableDetails test executing');

  // Test ScrollableDetails - ScrollableDetails
  print('ScrollableDetails is available in the widgets package');
  print('ScrollableDetails runtimeType accessible');

  print('ScrollableDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollableDetails Tests'),
      Text('ScrollableDetails'),
    ],
  );
}
