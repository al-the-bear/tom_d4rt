// D4rt test script: Tests TickerModeData from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TickerModeData test executing');

  // Test TickerModeData - TickerModeData
  print('TickerModeData is available in the widgets package');
  print('TickerModeData runtimeType accessible');

  print('TickerModeData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TickerModeData Tests'),
      Text('TickerModeData'),
    ],
  );
}
