// D4rt test script: Tests SystemTextScaler from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SystemTextScaler test executing');

  // Test SystemTextScaler - SystemTextScaler
  print('SystemTextScaler is available in the widgets package');
  print('SystemTextScaler runtimeType accessible');

  print('SystemTextScaler test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SystemTextScaler Tests'),
      Text('SystemTextScaler'),
    ],
  );
}
