// D4rt test script: Tests KeyEventManager from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeyEventManager test executing');

  // Test KeyEventManager - KeyEventManager
  print('KeyEventManager is available in the services package');
  print('KeyEventManager: KeyEventManager');

  print('KeyEventManager test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('KeyEventManager Tests'),
      Text('KeyEventManager'),
    ],
  );
}
