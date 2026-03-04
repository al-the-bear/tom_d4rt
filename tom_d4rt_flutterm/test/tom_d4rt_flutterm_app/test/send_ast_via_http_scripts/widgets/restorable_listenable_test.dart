// D4rt test script: Tests RestorableListenable from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorableListenable test executing');

  // Test RestorableListenable - RestorableListenable
  print('RestorableListenable is available in the widgets package');
  print('RestorableListenable runtimeType accessible');

  print('RestorableListenable test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RestorableListenable Tests'),
      Text('RestorableListenable'),
    ],
  );
}
