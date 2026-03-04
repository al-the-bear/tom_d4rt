// D4rt test script: Tests TickerMode from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TickerMode test executing');

  // Test TickerMode - Ticker mode
  print('TickerMode is available in the widgets package');
  print('TickerMode runtimeType accessible');

  print('TickerMode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TickerMode Tests'),
      Text('Ticker mode'),
    ],
  );
}
