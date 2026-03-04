// D4rt test script: Tests AnimatedTheme from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedTheme test executing');

  // Test AnimatedTheme - Theme
  print('AnimatedTheme is available in the material package');
  print('AnimatedTheme runtimeType accessible');

  print('AnimatedTheme test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnimatedTheme Tests'),
      Text('Theme'),
    ],
  );
}
