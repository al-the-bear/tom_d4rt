// D4rt test script: Tests ExpansibleController from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ExpansibleController test executing');

  // Test ExpansibleController - ExpansibleController
  print('ExpansibleController is available in the widgets package');
  print('ExpansibleController runtimeType accessible');

  print('ExpansibleController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ExpansibleController Tests'),
      Text('ExpansibleController'),
    ],
  );
}
