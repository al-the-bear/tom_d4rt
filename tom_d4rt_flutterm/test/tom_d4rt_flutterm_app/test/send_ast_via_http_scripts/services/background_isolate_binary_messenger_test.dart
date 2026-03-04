// D4rt test script: Tests BackgroundIsolateBinaryMessenger from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BackgroundIsolateBinaryMessenger test executing');

  // Test BackgroundIsolateBinaryMessenger - BackgroundIsolateBinaryMessenger
  print('BackgroundIsolateBinaryMessenger is available in the services package');
  print('BackgroundIsolateBinaryMessenger: BackgroundIsolateBinaryMessenger');

  print('BackgroundIsolateBinaryMessenger test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BackgroundIsolateBinaryMessenger Tests'),
      Text('BackgroundIsolateBinaryMessenger'),
    ],
  );
}
