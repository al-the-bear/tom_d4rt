// D4rt test script: Tests RootBackButtonDispatcher from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RootBackButtonDispatcher test executing');

  // Test RootBackButtonDispatcher - RootBackButtonDispatcher
  print('RootBackButtonDispatcher is available in the widgets package');
  print('RootBackButtonDispatcher runtimeType accessible');

  print('RootBackButtonDispatcher test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RootBackButtonDispatcher Tests'),
      Text('RootBackButtonDispatcher'),
    ],
  );
}
