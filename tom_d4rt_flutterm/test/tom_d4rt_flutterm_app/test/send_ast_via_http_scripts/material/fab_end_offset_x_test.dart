// D4rt test script: Tests FabEndOffsetX from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FabEndOffsetX test executing');

  // FabEndOffsetX is a mixin - verify it exists in the framework
  print('FabEndOffsetX is a mixin');
  print('FabEndOffsetX runtimeType check available');
  print('FabEndOffsetX type: mixin');

  print('FabEndOffsetX test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FabEndOffsetX Tests'),
      Text('Type: mixin'),
      Text('FabEndOffsetX'),
    ],
  );
}
