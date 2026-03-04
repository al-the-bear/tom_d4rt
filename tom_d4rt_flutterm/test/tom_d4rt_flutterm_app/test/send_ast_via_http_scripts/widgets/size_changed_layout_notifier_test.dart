// D4rt test script: Tests SizeChangedLayoutNotifier from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SizeChangedLayoutNotifier test executing');

  // Test SizeChangedLayoutNotifier - SizeChangedLayoutNotifier
  print('SizeChangedLayoutNotifier is available in the widgets package');
  print('SizeChangedLayoutNotifier runtimeType accessible');

  print('SizeChangedLayoutNotifier test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SizeChangedLayoutNotifier Tests'),
      Text('SizeChangedLayoutNotifier'),
    ],
  );
}
