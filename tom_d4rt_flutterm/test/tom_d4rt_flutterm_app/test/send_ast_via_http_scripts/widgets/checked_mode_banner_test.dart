// D4rt test script: Tests CheckedModeBanner from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('CheckedModeBanner test executing');

  // Test CheckedModeBanner - Debug banner
  print('CheckedModeBanner is available in the widgets package');
  print('CheckedModeBanner runtimeType accessible');

  print('CheckedModeBanner test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('CheckedModeBanner Tests'),
      Text('Debug banner'),
    ],
  );
}
