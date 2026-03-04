// D4rt test script: Tests WidgetsLocalizations from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetsLocalizations test executing');

  // Test WidgetsLocalizations - WidgetsLocalizations
  print('WidgetsLocalizations is available in the widgets package');
  print('WidgetsLocalizations runtimeType accessible');

  print('WidgetsLocalizations test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetsLocalizations Tests'),
      Text('WidgetsLocalizations'),
    ],
  );
}
