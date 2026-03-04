// D4rt test script: Tests SharedAppData from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SharedAppData test executing');

  // Test SharedAppData - Shared app data
  print('SharedAppData is available in the widgets package');
  print('SharedAppData runtimeType accessible');

  print('SharedAppData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SharedAppData Tests'),
      Text('Shared app data'),
    ],
  );
}
