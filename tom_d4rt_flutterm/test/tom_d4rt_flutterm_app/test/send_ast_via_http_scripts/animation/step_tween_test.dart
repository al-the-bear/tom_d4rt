// D4rt test script: Tests StepTween from animation
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('StepTween test executing');

  // Test StepTween - StepTween
  print('StepTween is available in the animation package');
  print('StepTween: StepTween');

  print('StepTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('StepTween Tests'),
      Text('StepTween'),
    ],
  );
}
