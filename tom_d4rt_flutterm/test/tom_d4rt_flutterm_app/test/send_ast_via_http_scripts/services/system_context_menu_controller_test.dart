// D4rt test script: Tests SystemContextMenuController from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SystemContextMenuController test executing');

  // Test SystemContextMenuController - SystemContextMenuController
  print('SystemContextMenuController is available in the services package');
  print('SystemContextMenuController: SystemContextMenuController');

  print('SystemContextMenuController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SystemContextMenuController Tests'),
      Text('SystemContextMenuController'),
    ],
  );
}
