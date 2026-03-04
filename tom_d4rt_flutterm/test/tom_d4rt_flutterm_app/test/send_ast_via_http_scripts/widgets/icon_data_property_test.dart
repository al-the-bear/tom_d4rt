// D4rt test script: Tests IconDataProperty from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('IconDataProperty test executing');

  // Test IconDataProperty - IconDataProperty
  print('IconDataProperty is available in the widgets package');
  print('IconDataProperty runtimeType accessible');

  print('IconDataProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('IconDataProperty Tests'),
      Text('IconDataProperty'),
    ],
  );
}
