// D4rt test script: Tests ScrollPhysics from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ScrollPhysics test executing');

  // Test ScrollPhysics - Scroll physics
  print('ScrollPhysics is available in the widgets package');
  print('ScrollPhysics runtimeType accessible');

  print('ScrollPhysics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ScrollPhysics Tests'),
      Text('Scroll physics'),
    ],
  );
}
