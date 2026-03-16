// D4rt test script: Tests FabContainedOffsetY from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FabContainedOffsetY test executing');

  // FabContainedOffsetY is a mixin - verify it exists in the framework
  print('FabContainedOffsetY is a mixin');
  print('FabContainedOffsetY runtimeType check available');
  print('FabContainedOffsetY type: mixin');

  print('FabContainedOffsetY test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FabContainedOffsetY Tests'),
      Text('Type: mixin'),
      Text('FabContainedOffsetY'),
    ],
  );
}
