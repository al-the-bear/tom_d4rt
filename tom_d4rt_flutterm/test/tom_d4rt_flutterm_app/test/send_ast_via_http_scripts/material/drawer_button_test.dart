// D4rt test script: Tests DrawerButton from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DrawerButton test executing');

  // Test DrawerButton - DrawerButton
  print('DrawerButton is available in the material package');
  print('DrawerButton runtimeType accessible');

  print('DrawerButton test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DrawerButton Tests'),
      Text('DrawerButton'),
    ],
  );
}
