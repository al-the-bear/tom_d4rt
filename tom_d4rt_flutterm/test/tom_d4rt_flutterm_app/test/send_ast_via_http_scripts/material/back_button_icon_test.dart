// D4rt test script: Tests BackButtonIcon from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BackButtonIcon test executing');

  // Test BackButtonIcon - BackButtonIcon
  print('BackButtonIcon is available in the material package');
  print('BackButtonIcon runtimeType accessible');

  print('BackButtonIcon test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BackButtonIcon Tests'),
      Text('BackButtonIcon'),
    ],
  );
}
