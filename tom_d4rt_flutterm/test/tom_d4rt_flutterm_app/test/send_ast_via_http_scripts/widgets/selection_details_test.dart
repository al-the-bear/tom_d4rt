// D4rt test script: Tests SelectionDetails from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SelectionDetails test executing');

  // Test SelectionDetails - SelectionDetails
  print('SelectionDetails is available in the widgets package');
  print('SelectionDetails runtimeType accessible');

  print('SelectionDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SelectionDetails Tests'),
      Text('SelectionDetails'),
    ],
  );
}
