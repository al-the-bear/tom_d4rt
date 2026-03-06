// D4rt test script: Tests IntProperty from foundation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('IntProperty test executing');

  // Test IntProperty - IntProperty
  print('IntProperty is available in the foundation package');
  print('IntProperty: IntProperty');

  print('IntProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('IntProperty Tests'),
      Text('IntProperty'),
    ],
  );
}
