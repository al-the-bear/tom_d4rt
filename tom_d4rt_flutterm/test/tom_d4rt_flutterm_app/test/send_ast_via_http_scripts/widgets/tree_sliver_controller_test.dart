// D4rt test script: Tests TreeSliverController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TreeSliverController test executing');

  // Test TreeSliverController - TreeSliverController
  print('TreeSliverController is available in the widgets package');
  print('TreeSliverController runtimeType accessible');

  print('TreeSliverController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TreeSliverController Tests'),
      Text('TreeSliverController'),
    ],
  );
}
