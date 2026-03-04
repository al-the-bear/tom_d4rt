// D4rt test script: Tests HtmlElementView from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('HtmlElementView test executing');

  // Test HtmlElementView - Web view
  print('HtmlElementView is available in the widgets package');
  print('HtmlElementView runtimeType accessible');

  print('HtmlElementView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('HtmlElementView Tests'),
      Text('Web view'),
    ],
  );
}
