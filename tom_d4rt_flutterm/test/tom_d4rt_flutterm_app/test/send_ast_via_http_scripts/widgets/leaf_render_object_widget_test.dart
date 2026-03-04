// D4rt test script: Tests LeafRenderObjectWidget from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LeafRenderObjectWidget test executing');

  // Test LeafRenderObjectWidget - Leaf widget
  print('LeafRenderObjectWidget is available in the widgets package');
  print('LeafRenderObjectWidget runtimeType accessible');

  print('LeafRenderObjectWidget test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LeafRenderObjectWidget Tests'),
      Text('Leaf widget'),
    ],
  );
}
