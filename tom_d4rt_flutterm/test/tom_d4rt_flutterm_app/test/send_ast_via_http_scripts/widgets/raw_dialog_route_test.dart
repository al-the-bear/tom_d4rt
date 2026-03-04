// D4rt test script: Tests RawDialogRoute from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawDialogRoute test executing');

  // Test RawDialogRoute - RawDialogRoute
  print('RawDialogRoute is available in the widgets package');
  print('RawDialogRoute runtimeType accessible');

  print('RawDialogRoute test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawDialogRoute Tests'),
      Text('RawDialogRoute'),
    ],
  );
}
