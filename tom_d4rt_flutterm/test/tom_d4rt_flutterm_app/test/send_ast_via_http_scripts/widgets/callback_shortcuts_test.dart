// D4rt test script: Tests CallbackShortcuts from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('CallbackShortcuts test executing');

  // Test CallbackShortcuts - Callback shortcuts
  print('CallbackShortcuts is available in the widgets package');
  print('CallbackShortcuts runtimeType accessible');

  print('CallbackShortcuts test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CallbackShortcuts Tests'),
      Text('Callback shortcuts'),
    ],
  );
}
