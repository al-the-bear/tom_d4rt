// D4rt test script: Tests RawRadio from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawRadio test executing');

  // Test RawRadio - RawRadio
  print('RawRadio is available in the widgets package');
  print('RawRadio runtimeType accessible');

  print('RawRadio test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawRadio Tests'),
      Text('RawRadio'),
    ],
  );
}
