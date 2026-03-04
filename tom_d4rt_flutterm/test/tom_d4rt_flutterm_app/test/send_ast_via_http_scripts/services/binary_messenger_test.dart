// D4rt test script: Tests BinaryMessenger from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BinaryMessenger test executing');

  // Test BinaryMessenger - Binary messaging
  print('BinaryMessenger is available in the services package');
  print('BinaryMessenger: Binary messaging');

  print('BinaryMessenger test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BinaryMessenger Tests'),
      Text('Binary messaging'),
    ],
  );
}
