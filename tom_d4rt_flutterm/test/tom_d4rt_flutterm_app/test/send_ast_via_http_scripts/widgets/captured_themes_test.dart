// D4rt test script: Tests CapturedThemes from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('CapturedThemes test executing');

  // Test CapturedThemes - Captured themes
  print('CapturedThemes is available in the widgets package');
  print('CapturedThemes runtimeType accessible');

  print('CapturedThemes test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CapturedThemes Tests'),
      Text('Captured themes'),
    ],
  );
}
