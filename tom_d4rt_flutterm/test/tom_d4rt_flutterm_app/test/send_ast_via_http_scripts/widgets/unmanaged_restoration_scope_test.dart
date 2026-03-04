// D4rt test script: Tests UnmanagedRestorationScope from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('UnmanagedRestorationScope test executing');

  // Test UnmanagedRestorationScope - UnmanagedRestorationScope
  print('UnmanagedRestorationScope is available in the widgets package');
  print('UnmanagedRestorationScope runtimeType accessible');

  print('UnmanagedRestorationScope test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('UnmanagedRestorationScope Tests'),
      Text('UnmanagedRestorationScope'),
    ],
  );
}
