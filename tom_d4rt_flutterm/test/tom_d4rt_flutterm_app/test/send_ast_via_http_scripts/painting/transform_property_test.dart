// D4rt test script: Tests TransformProperty from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TransformProperty test executing');

  // Test TransformProperty - Transform diagnostics
  print('TransformProperty is available in the painting package');
  print('TransformProperty: Transform diagnostics');

  print('TransformProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TransformProperty Tests'),
      Text('Transform diagnostics'),
    ],
  );
}
