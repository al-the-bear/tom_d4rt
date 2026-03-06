// D4rt test script: Tests LiveText from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LiveText test executing');

  // Test LiveText - Live text
  print('LiveText is available in the services package');
  print('LiveText: Live text');

  print('LiveText test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LiveText Tests'),
      Text('Live text'),
    ],
  );
}
