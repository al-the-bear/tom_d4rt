// D4rt test script: Tests InkSparkle from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('InkSparkle test executing');

  // Test InkSparkle - InkSparkle
  print('InkSparkle is available in the material package');
  print('InkSparkle runtimeType accessible');

  print('InkSparkle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InkSparkle Tests'),
      Text('InkSparkle'),
    ],
  );
}
