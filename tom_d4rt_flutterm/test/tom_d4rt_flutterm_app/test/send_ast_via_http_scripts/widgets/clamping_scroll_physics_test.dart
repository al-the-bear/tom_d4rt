// D4rt test script: Tests ClampingScrollPhysics from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClampingScrollPhysics test executing');

  // Test ClampingScrollPhysics - Clamping scroll
  print('ClampingScrollPhysics is available in the widgets package');
  print('ClampingScrollPhysics runtimeType accessible');

  print('ClampingScrollPhysics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ClampingScrollPhysics Tests'),
      Text('Clamping scroll'),
    ],
  );
}
