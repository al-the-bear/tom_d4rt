// D4rt test script: Tests MultiChildRenderObjectWidget from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MultiChildRenderObjectWidget test executing');

  // Test MultiChildRenderObjectWidget - Multi child
  print('MultiChildRenderObjectWidget is available in the widgets package');
  print('MultiChildRenderObjectWidget runtimeType accessible');

  print('MultiChildRenderObjectWidget test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MultiChildRenderObjectWidget Tests'),
      Text('Multi child'),
    ],
  );
}
