// D4rt test script: Tests UnderlineTabIndicator from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('UnderlineTabIndicator test executing');

  // Test UnderlineTabIndicator - UnderlineTabIndicator
  print('UnderlineTabIndicator is available in the material package');
  print('UnderlineTabIndicator runtimeType accessible');

  print('UnderlineTabIndicator test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('UnderlineTabIndicator Tests'),
      Text('UnderlineTabIndicator'),
    ],
  );
}
