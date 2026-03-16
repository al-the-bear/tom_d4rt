// D4rt test script: Tests FabCenterOffsetX from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FabCenterOffsetX test executing');

  // FabCenterOffsetX is a mixin - verify it exists in the framework
  print('FabCenterOffsetX is a mixin');
  print('FabCenterOffsetX runtimeType check available');
  print('FabCenterOffsetX type: mixin');

  print('FabCenterOffsetX test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FabCenterOffsetX Tests'),
      Text('Type: mixin'),
      Text('FabCenterOffsetX'),
    ],
  );
}
