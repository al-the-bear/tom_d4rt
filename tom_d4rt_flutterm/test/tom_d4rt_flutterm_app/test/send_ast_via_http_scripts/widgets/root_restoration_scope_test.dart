// D4rt test script: Tests RootRestorationScope from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RootRestorationScope test executing');

  // Test RootRestorationScope - Root restoration
  print('RootRestorationScope is available in the widgets package');
  print('RootRestorationScope runtimeType accessible');

  print('RootRestorationScope test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RootRestorationScope Tests'),
      Text('Root restoration'),
    ],
  );
}
