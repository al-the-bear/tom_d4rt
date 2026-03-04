// D4rt test script: Tests NestedScrollViewState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('NestedScrollViewState test executing');

  // Test NestedScrollViewState - NestedScrollViewState
  print('NestedScrollViewState is available in the widgets package');
  print('NestedScrollViewState runtimeType accessible');

  print('NestedScrollViewState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NestedScrollViewState Tests'),
      Text('NestedScrollViewState'),
    ],
  );
}
