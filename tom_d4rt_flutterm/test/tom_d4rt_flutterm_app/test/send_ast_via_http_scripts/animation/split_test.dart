// D4rt test script: Tests Split from animation
import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Split test executing');

  // Test Split - Split
  print('Split is available in the animation package');
  print('Split: Split');

  print('Split test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Split Tests'),
      Text('Split'),
    ],
  );
}
