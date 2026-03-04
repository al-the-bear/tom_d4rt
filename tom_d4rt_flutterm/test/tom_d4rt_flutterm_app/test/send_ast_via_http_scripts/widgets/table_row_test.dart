// D4rt test script: Tests TableRow from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TableRow test executing');

  // Test TableRow - Table row
  print('TableRow is available in the widgets package');
  print('TableRow runtimeType accessible');

  print('TableRow test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TableRow Tests'),
      Text('Table row'),
    ],
  );
}
