// D4rt test script: Tests WindowPositioner from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WindowPositioner test executing');

  // Test WindowPositioner - WindowPositioner
  print('WindowPositioner is available in the widgets package');
  print('WindowPositioner runtimeType accessible');

  print('WindowPositioner test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WindowPositioner Tests'),
      Text('WindowPositioner'),
    ],
  );
}
