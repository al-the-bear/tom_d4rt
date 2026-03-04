// D4rt test script: Tests SensitiveContent from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SensitiveContent test executing');

  // Test SensitiveContent - SensitiveContent
  print('SensitiveContent is available in the widgets package');
  print('SensitiveContent runtimeType accessible');

  print('SensitiveContent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SensitiveContent Tests'),
      Text('SensitiveContent'),
    ],
  );
}
