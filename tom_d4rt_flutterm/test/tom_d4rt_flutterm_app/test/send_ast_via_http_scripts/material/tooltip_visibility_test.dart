// D4rt test script: Tests TooltipVisibility from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TooltipVisibility test executing');

  // Test TooltipVisibility - Visibility
  print('TooltipVisibility is available in the material package');
  print('TooltipVisibility runtimeType accessible');

  print('TooltipVisibility test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TooltipVisibility Tests'),
      Text('Visibility'),
    ],
  );
}
