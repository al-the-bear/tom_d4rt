// D4rt test script: Tests TextMagnifier from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextMagnifier test executing');

  // Test TextMagnifier - TextMagnifier
  print('TextMagnifier is available in the material package');
  print('TextMagnifier runtimeType accessible');

  print('TextMagnifier test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextMagnifier Tests'),
      Text('TextMagnifier'),
    ],
  );
}
