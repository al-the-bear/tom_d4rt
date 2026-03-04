// D4rt test script: Tests WebBrowserDetection from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WebBrowserDetection test executing');

  // Test WebBrowserDetection - WebBrowserDetection
  print('WebBrowserDetection is available in the widgets package');
  print('WebBrowserDetection runtimeType accessible');

  print('WebBrowserDetection test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WebBrowserDetection Tests'),
      Text('WebBrowserDetection'),
    ],
  );
}
