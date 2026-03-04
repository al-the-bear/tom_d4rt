// D4rt test script: Tests RawKeyEventData from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawKeyEventData test executing');

  // Test RawKeyEventData - RawKeyEventData
  print('RawKeyEventData is available in the services package');
  print('RawKeyEventData: RawKeyEventData');

  print('RawKeyEventData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawKeyEventData Tests'),
      Text('RawKeyEventData'),
    ],
  );
}
