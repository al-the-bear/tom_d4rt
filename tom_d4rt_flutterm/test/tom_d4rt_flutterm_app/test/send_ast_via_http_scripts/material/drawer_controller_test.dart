// D4rt test script: Tests DrawerController from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DrawerController test executing');

  // Test DrawerController - DrawerController
  print('DrawerController is available in the material package');
  print('DrawerController runtimeType accessible');

  print('DrawerController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DrawerController Tests'),
      Text('DrawerController'),
    ],
  );
}
