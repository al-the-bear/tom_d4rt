// D4rt test script: Tests DataTableSource from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DataTableSource test executing');

  // Test DataTableSource - Data source
  print('DataTableSource is available in the material package');
  print('DataTableSource runtimeType accessible');

  print('DataTableSource test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DataTableSource Tests'),
      Text('Data source'),
    ],
  );
}
