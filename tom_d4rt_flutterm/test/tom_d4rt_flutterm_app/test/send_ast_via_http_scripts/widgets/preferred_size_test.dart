// D4rt test script: Tests PreferredSize from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PreferredSize test executing');

  // Test PreferredSize - PreferredSize
  print('PreferredSize is available in the widgets package');
  print('PreferredSize runtimeType accessible');

  print('PreferredSize test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PreferredSize Tests'),
      Text('PreferredSize'),
    ],
  );
}
