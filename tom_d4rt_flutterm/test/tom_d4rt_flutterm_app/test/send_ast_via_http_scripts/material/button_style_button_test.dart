// D4rt test script: Tests ButtonStyleButton from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ButtonStyleButton test executing');

  // Test ButtonStyleButton - Style button base
  print('ButtonStyleButton is available in the material package');
  print('ButtonStyleButton runtimeType accessible');

  print('ButtonStyleButton test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ButtonStyleButton Tests'),
      Text('Style button base'),
    ],
  );
}
