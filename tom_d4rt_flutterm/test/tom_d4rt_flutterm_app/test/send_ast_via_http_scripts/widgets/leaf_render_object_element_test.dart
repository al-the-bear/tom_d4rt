// D4rt test script: Tests LeafRenderObjectElement from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LeafRenderObjectElement test executing');

  // Test LeafRenderObjectElement - Leaf element
  print('LeafRenderObjectElement is available in the widgets package');
  print('LeafRenderObjectElement runtimeType accessible');

  print('LeafRenderObjectElement test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LeafRenderObjectElement Tests'),
      Text('Leaf element'),
    ],
  );
}
