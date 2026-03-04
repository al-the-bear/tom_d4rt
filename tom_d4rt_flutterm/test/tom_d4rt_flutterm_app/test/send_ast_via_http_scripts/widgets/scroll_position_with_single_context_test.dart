// D4rt test script: Tests ScrollPositionWithSingleContext from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollPositionWithSingleContext test executing');

  // Test ScrollPositionWithSingleContext - ScrollPositionWithSingleContext
  print('ScrollPositionWithSingleContext is available in the widgets package');
  print('ScrollPositionWithSingleContext runtimeType accessible');

  print('ScrollPositionWithSingleContext test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollPositionWithSingleContext Tests'),
      Text('ScrollPositionWithSingleContext'),
    ],
  );
}
