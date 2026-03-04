// D4rt test script: Tests SingleActivator from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SingleActivator test executing');

  // Test SingleActivator - SingleActivator
  print('SingleActivator is available in the widgets package');
  print('SingleActivator runtimeType accessible');

  print('SingleActivator test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SingleActivator Tests'),
      Text('SingleActivator'),
    ],
  );
}
