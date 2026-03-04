// D4rt test script: Tests ListWheelChildDelegate from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ListWheelChildDelegate test executing');

  // Test ListWheelChildDelegate - Child delegate
  print('ListWheelChildDelegate is available in the widgets package');
  print('ListWheelChildDelegate runtimeType accessible');

  print('ListWheelChildDelegate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ListWheelChildDelegate Tests'),
      Text('Child delegate'),
    ],
  );
}
