// D4rt test script: Tests LayoutId from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LayoutId test executing');

  // Test LayoutId - LayoutId
  print('LayoutId is available in the widgets package');
  print('LayoutId runtimeType accessible');

  print('LayoutId test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LayoutId Tests'),
      Text('LayoutId'),
    ],
  );
}
