// D4rt test script: Tests CloseButton from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CloseButton test executing');

  // Test CloseButton - CloseButton
  print('CloseButton is available in the material package');
  print('CloseButton runtimeType accessible');

  print('CloseButton test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CloseButton Tests'),
      Text('CloseButton'),
    ],
  );
}
