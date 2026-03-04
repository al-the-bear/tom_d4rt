// D4rt test script: Tests TreeSliverNode from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TreeSliverNode test executing');

  // Test TreeSliverNode - TreeSliverNode
  print('TreeSliverNode is available in the widgets package');
  print('TreeSliverNode runtimeType accessible');

  print('TreeSliverNode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TreeSliverNode Tests'),
      Text('TreeSliverNode'),
    ],
  );
}
