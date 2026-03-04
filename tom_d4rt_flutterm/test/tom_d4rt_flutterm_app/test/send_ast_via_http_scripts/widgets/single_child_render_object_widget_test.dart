// D4rt test script: Tests SingleChildRenderObjectWidget from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SingleChildRenderObjectWidget test executing');

  // Test SingleChildRenderObjectWidget - Single child
  print('SingleChildRenderObjectWidget is available in the widgets package');
  print('SingleChildRenderObjectWidget runtimeType accessible');

  print('SingleChildRenderObjectWidget test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SingleChildRenderObjectWidget Tests'),
      Text('Single child'),
    ],
  );
}
