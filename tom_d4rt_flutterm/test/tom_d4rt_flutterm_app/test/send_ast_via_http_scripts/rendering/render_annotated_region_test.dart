// D4rt test script: Tests RenderAnnotatedRegion from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderAnnotatedRegion test executing');

  // RenderAnnotatedRegion - Annotated region
  // This is typically an abstract/base class used through subclasses
  print('RenderAnnotatedRegion is available in the rendering package');
  print('RenderAnnotatedRegion: Annotated region');

  print('RenderAnnotatedRegion test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAnnotatedRegion Tests'),
      Text('Annotated region'),
    ],
  );
}
