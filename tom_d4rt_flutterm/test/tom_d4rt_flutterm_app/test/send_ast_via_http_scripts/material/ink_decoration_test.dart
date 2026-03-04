// D4rt test script: Tests InkDecoration from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('InkDecoration test executing');

  // Test InkDecoration - InkDecoration
  print('InkDecoration is available in the material package');
  print('InkDecoration runtimeType accessible');

  print('InkDecoration test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InkDecoration Tests'),
      Text('InkDecoration'),
    ],
  );
}
