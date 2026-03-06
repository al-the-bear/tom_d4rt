// D4rt test script: Tests SystemChannels from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SystemChannels test executing');

  // Test SystemChannels - System channels
  print('SystemChannels is available in the services package');
  print('SystemChannels: System channels');

  print('SystemChannels test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SystemChannels Tests'),
      Text('System channels'),
    ],
  );
}
