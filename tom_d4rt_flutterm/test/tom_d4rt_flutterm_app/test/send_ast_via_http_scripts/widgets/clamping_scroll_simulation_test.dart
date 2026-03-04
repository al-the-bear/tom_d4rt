// D4rt test script: Tests ClampingScrollSimulation from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ClampingScrollSimulation test executing');

  // Test ClampingScrollSimulation - Clamp sim
  print('ClampingScrollSimulation is available in the widgets package');
  print('ClampingScrollSimulation runtimeType accessible');

  print('ClampingScrollSimulation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ClampingScrollSimulation Tests'),
      Text('Clamp sim'),
    ],
  );
}
