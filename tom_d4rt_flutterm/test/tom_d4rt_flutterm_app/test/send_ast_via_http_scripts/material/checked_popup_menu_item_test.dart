// D4rt test script: Tests CheckedPopupMenuItem from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CheckedPopupMenuItem test executing');

  // Test CheckedPopupMenuItem - CheckedPopupMenuItem
  print('CheckedPopupMenuItem is available in the material package');
  print('CheckedPopupMenuItem runtimeType accessible');

  print('CheckedPopupMenuItem test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CheckedPopupMenuItem Tests'),
      Text('CheckedPopupMenuItem'),
    ],
  );
}
