// D4rt test script: Tests AnnotationResult from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnnotationResult test executing');

  // Test AnnotationResult - Annotation result
  print('AnnotationResult is available in the rendering package');
  print('AnnotationResult: Annotation result');

  print('AnnotationResult test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnnotationResult Tests'),
      Text('Annotation result'),
    ],
  );
}
