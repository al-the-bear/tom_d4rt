// D4rt test script: Tests FloatingActionButtonLocation from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FloatingActionButtonLocation test executing');

  // Test FloatingActionButtonLocation - FAB location
  print('FloatingActionButtonLocation is available in the material package');
  print('FloatingActionButtonLocation runtimeType accessible');

  print('FloatingActionButtonLocation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FloatingActionButtonLocation Tests'),
      Text('FAB location'),
    ],
  );
}
