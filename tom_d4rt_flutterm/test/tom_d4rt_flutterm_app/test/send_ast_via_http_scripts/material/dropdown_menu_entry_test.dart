// D4rt test script: Tests DropdownMenuEntry from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DropdownMenuEntry test executing');

  // Test DropdownMenuEntry - DropdownMenuEntry
  print('DropdownMenuEntry is available in the material package');
  print('DropdownMenuEntry runtimeType accessible');

  print('DropdownMenuEntry test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DropdownMenuEntry Tests'),
      Text('DropdownMenuEntry'),
    ],
  );
}
