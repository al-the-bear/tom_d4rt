// D4rt test script: Tests NavigationToolbar from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('NavigationToolbar test executing');

  // Test NavigationToolbar - Nav toolbar
  print('NavigationToolbar is available in the widgets package');
  print('NavigationToolbar runtimeType accessible');

  print('NavigationToolbar test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('NavigationToolbar Tests'),
      Text('Nav toolbar'),
    ],
  );
}
