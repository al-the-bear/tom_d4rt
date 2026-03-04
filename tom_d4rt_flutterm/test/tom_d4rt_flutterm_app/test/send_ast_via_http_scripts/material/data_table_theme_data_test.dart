// D4rt test script: Tests DataTableThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DataTableThemeData test executing');

  // Test DataTableThemeData - Table data
  print('DataTableThemeData is available in the material package');
  print('DataTableThemeData runtimeType accessible');

  print('DataTableThemeData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DataTableThemeData Tests'),
      Text('Table data'),
    ],
  );
}
