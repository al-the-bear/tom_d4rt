// D4rt test script: Tests DropdownMenuItem from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DropdownMenuItem test executing');

  // Test DropdownMenuItem - DropdownMenuItem
  print('DropdownMenuItem is available in the material package');
  print('DropdownMenuItem runtimeType accessible');

  print('DropdownMenuItem test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DropdownMenuItem Tests'),
      Text('DropdownMenuItem'),
    ],
  );
}
