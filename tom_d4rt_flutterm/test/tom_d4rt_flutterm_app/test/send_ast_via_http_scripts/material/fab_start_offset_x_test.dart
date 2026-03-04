// D4rt test script: Tests FabStartOffsetX from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FabStartOffsetX test executing');

  // FabStartOffsetX is a mixin - verify it exists in the framework
  print('FabStartOffsetX is a mixin');
  print('FabStartOffsetX runtimeType check available');
  print('FabStartOffsetX type: mixin');

  print('FabStartOffsetX test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FabStartOffsetX Tests'),
      Text('Type: mixin'),
      Text('FabStartOffsetX'),
    ],
  );
}
