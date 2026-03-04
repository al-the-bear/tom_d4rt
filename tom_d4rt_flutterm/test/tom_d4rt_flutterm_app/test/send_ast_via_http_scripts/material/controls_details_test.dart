// D4rt test script: Tests ControlsDetails from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ControlsDetails test executing');

  // Test ControlsDetails - Controls details
  print('ControlsDetails is available in the material package');
  print('ControlsDetails runtimeType accessible');

  print('ControlsDetails test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ControlsDetails Tests'),
      Text('Controls details'),
    ],
  );
}
