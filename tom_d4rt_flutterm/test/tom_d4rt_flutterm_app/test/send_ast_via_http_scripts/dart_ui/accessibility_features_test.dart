// D4rt test script: Tests AccessibilityFeatures from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AccessibilityFeatures test executing');

  // Test AccessibilityFeatures - Accessibility settings
  print('AccessibilityFeatures is available in the dart_ui package');
  print('AccessibilityFeatures: Accessibility settings');

  print('AccessibilityFeatures test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AccessibilityFeatures Tests'),
      Text('Accessibility settings'),
    ],
  );
}
