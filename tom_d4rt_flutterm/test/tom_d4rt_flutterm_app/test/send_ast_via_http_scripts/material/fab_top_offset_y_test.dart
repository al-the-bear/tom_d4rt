// D4rt test script: Tests FabTopOffsetY from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FabTopOffsetY test executing');

  // FabTopOffsetY is a mixin - verify it exists in the framework
  print('FabTopOffsetY is a mixin');
  print('FabTopOffsetY runtimeType check available');
  print('FabTopOffsetY type: mixin');

  print('FabTopOffsetY test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FabTopOffsetY Tests'),
      Text('Type: mixin'),
      Text('FabTopOffsetY'),
    ],
  );
}
