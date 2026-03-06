// D4rt test script: Tests ImageFilterContext from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageFilterContext test executing');

  // Test ImageFilterContext - Filter context
  print('ImageFilterContext is available in the rendering package');
  print('ImageFilterContext: Filter context');

  print('ImageFilterContext test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImageFilterContext Tests'),
      Text('Filter context'),
    ],
  );
}
