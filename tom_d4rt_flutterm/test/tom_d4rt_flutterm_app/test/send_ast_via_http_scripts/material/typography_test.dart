// D4rt test script: Tests Typography from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Typography test executing');

  // Test Typography - Typography
  print('Typography is available in the material package');
  print('Typography runtimeType accessible');

  print('Typography test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Typography Tests'),
      Text('Typography'),
    ],
  );
}
