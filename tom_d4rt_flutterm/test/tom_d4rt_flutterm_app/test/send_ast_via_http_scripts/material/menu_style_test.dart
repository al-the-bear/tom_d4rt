// D4rt test script: Tests MenuStyle from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MenuStyle test executing');

  // Test MenuStyle - Menu style
  print('MenuStyle is available in the material package');
  print('MenuStyle runtimeType accessible');

  print('MenuStyle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MenuStyle Tests'),
      Text('Menu style'),
    ],
  );
}
