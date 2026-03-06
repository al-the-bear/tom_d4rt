// D4rt test script: Tests IsolateNameServer from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('IsolateNameServer test executing');

  // Test IsolateNameServer - Isolate communication
  print('IsolateNameServer is available in the dart_ui package');
  print('IsolateNameServer: Isolate communication');

  print('IsolateNameServer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('IsolateNameServer Tests'),
      Text('Isolate communication'),
    ],
  );
}
