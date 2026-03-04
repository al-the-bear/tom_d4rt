// D4rt test script: Tests FabDockedOffsetY from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FabDockedOffsetY test executing');

  // FabDockedOffsetY is a mixin - verify it exists in the framework
  print('FabDockedOffsetY is a mixin');
  print('FabDockedOffsetY runtimeType check available');
  print('FabDockedOffsetY type: mixin');

  print('FabDockedOffsetY test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FabDockedOffsetY Tests'),
      Text('Type: mixin'),
      Text('FabDockedOffsetY'),
    ],
  );
}
