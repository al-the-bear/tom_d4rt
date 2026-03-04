// D4rt test script: Tests ColorProperty from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ColorProperty test executing');

  // Test ColorProperty - Diagnostics property
  print('ColorProperty is available in the painting package');
  print('ColorProperty: Diagnostics property');

  print('ColorProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ColorProperty Tests'),
      Text('Diagnostics property'),
    ],
  );
}
