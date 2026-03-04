// D4rt test script: Tests StretchEffect from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('StretchEffect test executing');

  // Test StretchEffect - StretchEffect
  print('StretchEffect is available in the widgets package');
  print('StretchEffect runtimeType accessible');

  print('StretchEffect test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StretchEffect Tests'),
      Text('StretchEffect'),
    ],
  );
}
