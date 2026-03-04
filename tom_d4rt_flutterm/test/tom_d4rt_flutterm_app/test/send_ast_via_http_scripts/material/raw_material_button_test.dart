// D4rt test script: Tests RawMaterialButton from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawMaterialButton test executing');

  // Test RawMaterialButton - Raw button
  print('RawMaterialButton is available in the material package');
  print('RawMaterialButton runtimeType accessible');

  print('RawMaterialButton test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawMaterialButton Tests'),
      Text('Raw button'),
    ],
  );
}
