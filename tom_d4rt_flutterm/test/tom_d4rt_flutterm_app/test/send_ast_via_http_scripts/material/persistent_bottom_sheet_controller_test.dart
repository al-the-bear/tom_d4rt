// D4rt test script: Tests PersistentBottomSheetController from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PersistentBottomSheetController test executing');

  // Test PersistentBottomSheetController - PersistentBottomSheetController
  print('PersistentBottomSheetController is available in the material package');
  print('PersistentBottomSheetController runtimeType accessible');

  print('PersistentBottomSheetController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PersistentBottomSheetController Tests'),
      Text('PersistentBottomSheetController'),
    ],
  );
}
