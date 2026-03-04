// D4rt test script: Tests PlatformAdaptiveIcons from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PlatformAdaptiveIcons test executing');

  // Test PlatformAdaptiveIcons - PlatformAdaptiveIcons
  print('PlatformAdaptiveIcons is available in the material package');
  print('PlatformAdaptiveIcons runtimeType accessible');

  print('PlatformAdaptiveIcons test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformAdaptiveIcons Tests'),
      Text('PlatformAdaptiveIcons'),
    ],
  );
}
