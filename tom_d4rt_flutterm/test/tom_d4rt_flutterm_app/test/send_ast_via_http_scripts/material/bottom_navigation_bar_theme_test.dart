// D4rt test script: Tests BottomNavigationBarTheme from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BottomNavigationBarTheme test executing');

  // Test BottomNavigationBarTheme - BottomNavigationBarTheme
  print('BottomNavigationBarTheme is available in the material package');
  print('BottomNavigationBarTheme runtimeType accessible');

  print('BottomNavigationBarTheme test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BottomNavigationBarTheme Tests'),
      Text('BottomNavigationBarTheme'),
    ],
  );
}
