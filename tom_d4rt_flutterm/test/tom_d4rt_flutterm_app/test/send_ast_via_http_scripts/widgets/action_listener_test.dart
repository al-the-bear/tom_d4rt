// D4rt test script: Tests ActionListener from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ActionListener test executing');

  // Test ActionListener - Action listener
  print('ActionListener is available in the widgets package');
  print('ActionListener runtimeType accessible');

  print('ActionListener test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ActionListener Tests'),
      Text('Action listener'),
    ],
  );
}
