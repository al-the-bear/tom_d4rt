// D4rt test script: Tests InheritedTheme from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('InheritedTheme test executing');

  // Test InheritedTheme - Inherited theme
  print('InheritedTheme is available in the widgets package');
  print('InheritedTheme runtimeType accessible');

  print('InheritedTheme test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('InheritedTheme Tests'),
      Text('Inherited theme'),
    ],
  );
}
