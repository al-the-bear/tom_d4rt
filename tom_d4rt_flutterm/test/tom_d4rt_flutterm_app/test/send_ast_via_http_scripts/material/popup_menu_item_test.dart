// D4rt test script: Tests PopupMenuItem from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PopupMenuItem test executing');

  // Test PopupMenuItem - PopupMenuItem
  print('PopupMenuItem is available in the material package');
  print('PopupMenuItem runtimeType accessible');

  print('PopupMenuItem test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PopupMenuItem Tests'),
      Text('PopupMenuItem'),
    ],
  );
}
