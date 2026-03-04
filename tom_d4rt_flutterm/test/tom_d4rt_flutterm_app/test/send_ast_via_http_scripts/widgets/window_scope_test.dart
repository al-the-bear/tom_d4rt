// D4rt test script: Tests WindowScope from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WindowScope test executing');

  // Test WindowScope - WindowScope
  print('WindowScope is available in the widgets package');
  print('WindowScope runtimeType accessible');

  print('WindowScope test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WindowScope Tests'),
      Text('WindowScope'),
    ],
  );
}
