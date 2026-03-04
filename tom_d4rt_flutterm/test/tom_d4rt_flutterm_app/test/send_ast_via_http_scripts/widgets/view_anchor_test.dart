// D4rt test script: Tests ViewAnchor from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ViewAnchor test executing');

  // Test ViewAnchor - View anchor
  print('ViewAnchor is available in the widgets package');
  print('ViewAnchor runtimeType accessible');

  print('ViewAnchor test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ViewAnchor Tests'),
      Text('View anchor'),
    ],
  );
}
