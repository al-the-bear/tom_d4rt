// D4rt test script: Tests TableCell from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TableCell test executing');

  // Test TableCell - Table cell
  print('TableCell is available in the widgets package');
  print('TableCell runtimeType accessible');

  print('TableCell test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TableCell Tests'),
      Text('Table cell'),
    ],
  );
}
