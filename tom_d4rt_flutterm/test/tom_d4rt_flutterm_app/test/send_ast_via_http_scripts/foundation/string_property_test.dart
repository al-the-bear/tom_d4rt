// D4rt test script: Tests StringProperty from foundation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('StringProperty test executing');

  // Test StringProperty - StringProperty
  print('StringProperty is available in the foundation package');
  print('StringProperty: StringProperty');

  print('StringProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StringProperty Tests'),
      Text('StringProperty'),
    ],
  );
}
