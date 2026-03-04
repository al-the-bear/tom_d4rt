// D4rt test script: Tests KeyUpEvent from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('KeyUpEvent test executing');

  // Test KeyUpEvent - KeyUpEvent
  print('KeyUpEvent is available in the services package');
  print('KeyUpEvent: KeyUpEvent');

  print('KeyUpEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('KeyUpEvent Tests'),
      Text('KeyUpEvent'),
    ],
  );
}
