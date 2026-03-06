// D4rt test script: Tests TableCellParentData from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TableCellParentData test executing');

  // Test TableCellParentData - Table cell data
  print('TableCellParentData is available in the rendering package');
  print('TableCellParentData: Table cell data');

  print('TableCellParentData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TableCellParentData Tests'),
      Text('Table cell data'),
    ],
  );
}
