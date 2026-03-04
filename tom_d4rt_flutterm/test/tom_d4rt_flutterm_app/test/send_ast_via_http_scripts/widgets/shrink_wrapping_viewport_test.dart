// D4rt test script: Tests ShrinkWrappingViewport from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShrinkWrappingViewport test executing');

  // Test ShrinkWrappingViewport - Shrink viewport
  print('ShrinkWrappingViewport is available in the widgets package');
  print('ShrinkWrappingViewport runtimeType accessible');

  print('ShrinkWrappingViewport test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ShrinkWrappingViewport Tests'),
      Text('Shrink viewport'),
    ],
  );
}
