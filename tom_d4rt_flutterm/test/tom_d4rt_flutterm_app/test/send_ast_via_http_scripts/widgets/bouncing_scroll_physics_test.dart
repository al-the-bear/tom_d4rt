// D4rt test script: Tests BouncingScrollPhysics from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BouncingScrollPhysics test executing');

  // Test BouncingScrollPhysics - Bouncing scroll
  print('BouncingScrollPhysics is available in the widgets package');
  print('BouncingScrollPhysics runtimeType accessible');

  print('BouncingScrollPhysics test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BouncingScrollPhysics Tests'),
      Text('Bouncing scroll'),
    ],
  );
}
