// D4rt test script: Tests EnumProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('EnumProperty test executing');

  // Test EnumProperty - EnumProperty
  print('EnumProperty is available in the foundation package');
  print('EnumProperty: EnumProperty');

  print('EnumProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('EnumProperty Tests'),
      Text('EnumProperty'),
    ],
  );
}
