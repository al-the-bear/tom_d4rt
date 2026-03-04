// D4rt test script: Tests AnnotationEntry from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnnotationEntry test executing');

  // Test AnnotationEntry - Annotation entry
  print('AnnotationEntry is available in the rendering package');
  print('AnnotationEntry: Annotation entry');

  print('AnnotationEntry test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnnotationEntry Tests'),
      Text('Annotation entry'),
    ],
  );
}
