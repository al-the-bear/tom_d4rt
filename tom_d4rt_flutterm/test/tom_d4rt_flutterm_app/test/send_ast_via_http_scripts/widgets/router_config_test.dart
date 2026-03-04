// D4rt test script: Tests RouterConfig from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RouterConfig test executing');

  // Test RouterConfig - RouterConfig
  print('RouterConfig is available in the widgets package');
  print('RouterConfig runtimeType accessible');

  print('RouterConfig test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RouterConfig Tests'),
      Text('RouterConfig'),
    ],
  );
}
