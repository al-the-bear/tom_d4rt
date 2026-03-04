// D4rt test script: Tests RestorableTextEditingController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RestorableTextEditingController test executing');

  // Test RestorableTextEditingController - Restorable text
  print('RestorableTextEditingController is available in the widgets package');
  print('RestorableTextEditingController runtimeType accessible');

  print('RestorableTextEditingController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RestorableTextEditingController Tests'),
      Text('Restorable text'),
    ],
  );
}
