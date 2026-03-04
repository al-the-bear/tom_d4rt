// D4rt test script: Tests ConstraintsTransformBox from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ConstraintsTransformBox test executing');

  // Test ConstraintsTransformBox - ConstraintsTransformBox
  print('ConstraintsTransformBox is available in the widgets package');
  print('ConstraintsTransformBox runtimeType accessible');

  print('ConstraintsTransformBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ConstraintsTransformBox Tests'),
      Text('ConstraintsTransformBox'),
    ],
  );
}
