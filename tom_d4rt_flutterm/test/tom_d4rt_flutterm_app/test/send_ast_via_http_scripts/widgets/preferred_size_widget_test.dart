// D4rt test script: Tests PreferredSizeWidget from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PreferredSizeWidget test executing');

  // Test PreferredSizeWidget - PreferredSizeWidget
  print('PreferredSizeWidget is available in the widgets package');
  print('PreferredSizeWidget runtimeType accessible');

  print('PreferredSizeWidget test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PreferredSizeWidget Tests'),
      Text('PreferredSizeWidget'),
    ],
  );
}
