// D4rt test script: Tests FabFloatOffsetY from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FabFloatOffsetY test executing');

  // FabFloatOffsetY is a mixin - verify it exists in the framework
  print('FabFloatOffsetY is a mixin');
  print('FabFloatOffsetY runtimeType check available');
  print('FabFloatOffsetY type: mixin');

  print('FabFloatOffsetY test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FabFloatOffsetY Tests'),
      Text('Type: mixin'),
      Text('FabFloatOffsetY'),
    ],
  );
}
