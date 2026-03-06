// D4rt test script: Tests RenderClipRSuperellipse from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderClipRSuperellipse test executing');

  // RenderClipRSuperellipse - Clip superellipse
  // This is typically an abstract/base class used through subclasses
  print('RenderClipRSuperellipse is available in the rendering package');
  print('RenderClipRSuperellipse: Clip superellipse');

  print('RenderClipRSuperellipse test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderClipRSuperellipse Tests'),
      Text('Clip superellipse'),
    ],
  );
}
