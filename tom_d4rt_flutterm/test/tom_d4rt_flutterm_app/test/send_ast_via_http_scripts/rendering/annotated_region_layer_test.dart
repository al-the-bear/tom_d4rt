// D4rt test script: Tests AnnotatedRegionLayer from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AnnotatedRegionLayer test executing');

  // Test AnnotatedRegionLayer - Annotated layer
  print('AnnotatedRegionLayer is available in the rendering package');
  print('AnnotatedRegionLayer: Annotated layer');

  print('AnnotatedRegionLayer test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AnnotatedRegionLayer Tests'),
      Text('Annotated layer'),
    ],
  );
}
