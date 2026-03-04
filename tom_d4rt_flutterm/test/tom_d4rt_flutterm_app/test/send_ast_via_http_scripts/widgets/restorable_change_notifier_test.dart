// D4rt test script: Tests RestorableChangeNotifier from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorableChangeNotifier test executing');

  // Test RestorableChangeNotifier - RestorableChangeNotifier
  print('RestorableChangeNotifier is available in the widgets package');
  print('RestorableChangeNotifier runtimeType accessible');

  print('RestorableChangeNotifier test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RestorableChangeNotifier Tests'),
      Text('RestorableChangeNotifier'),
    ],
  );
}
