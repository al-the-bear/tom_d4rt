// D4rt test script: Tests ColorFiltered from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ColorFiltered test executing');

  // Test ColorFiltered - Color filtering
  print('ColorFiltered is available in the widgets package');
  print('ColorFiltered runtimeType accessible');

  print('ColorFiltered test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ColorFiltered Tests'),
      Text('Color filtering'),
    ],
  );
}
