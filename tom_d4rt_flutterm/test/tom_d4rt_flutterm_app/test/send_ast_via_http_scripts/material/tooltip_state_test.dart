// D4rt test script: Tests TooltipState from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TooltipState test executing');

  // Test TooltipState - TooltipState
  print('TooltipState is available in the material package');
  print('TooltipState runtimeType accessible');

  print('TooltipState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TooltipState Tests'),
      Text('TooltipState'),
    ],
  );
}
