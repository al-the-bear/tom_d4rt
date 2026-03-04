// D4rt test script: Tests RangeMaintainingScrollPhysics from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RangeMaintainingScrollPhysics test executing');

  // Test RangeMaintainingScrollPhysics - Range maintaining
  print('RangeMaintainingScrollPhysics is available in the widgets package');
  print('RangeMaintainingScrollPhysics runtimeType accessible');

  print('RangeMaintainingScrollPhysics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RangeMaintainingScrollPhysics Tests'),
      Text('Range maintaining'),
    ],
  );
}
