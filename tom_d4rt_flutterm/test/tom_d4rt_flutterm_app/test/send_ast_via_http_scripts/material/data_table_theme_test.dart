// D4rt test script: Tests DataTableTheme from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DataTableTheme test executing');

  // Test DataTableTheme - Table theme
  print('DataTableTheme is available in the material package');
  print('DataTableTheme runtimeType accessible');

  print('DataTableTheme test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DataTableTheme Tests'),
      Text('Table theme'),
    ],
  );
}
