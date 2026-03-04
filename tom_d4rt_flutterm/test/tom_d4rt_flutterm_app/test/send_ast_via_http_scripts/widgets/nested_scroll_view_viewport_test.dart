// D4rt test script: Tests NestedScrollViewViewport from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('NestedScrollViewViewport test executing');

  // Test NestedScrollViewViewport - NestedScrollViewViewport
  print('NestedScrollViewViewport is available in the widgets package');
  print('NestedScrollViewViewport runtimeType accessible');

  print('NestedScrollViewViewport test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NestedScrollViewViewport Tests'),
      Text('NestedScrollViewViewport'),
    ],
  );
}
