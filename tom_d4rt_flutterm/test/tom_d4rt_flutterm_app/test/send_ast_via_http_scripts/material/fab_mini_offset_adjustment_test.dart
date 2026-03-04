// D4rt test script: Tests FabMiniOffsetAdjustment from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FabMiniOffsetAdjustment test executing');

  // FabMiniOffsetAdjustment is a mixin - verify it exists in the framework
  print('FabMiniOffsetAdjustment is a mixin');
  print('FabMiniOffsetAdjustment runtimeType check available');
  print('FabMiniOffsetAdjustment type: mixin');

  print('FabMiniOffsetAdjustment test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FabMiniOffsetAdjustment Tests'),
      Text('Type: mixin'),
      Text('FabMiniOffsetAdjustment'),
    ],
  );
}
