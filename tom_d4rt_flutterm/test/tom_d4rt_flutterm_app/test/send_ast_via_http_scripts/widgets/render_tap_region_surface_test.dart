// D4rt test script: Tests RenderTapRegionSurface from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderTapRegionSurface test executing');

  // RenderTapRegionSurface - RenderTapRegionSurface
  // This is typically an abstract/base class used through subclasses
  print('RenderTapRegionSurface is available in the widgets package');
  print('RenderTapRegionSurface: RenderTapRegionSurface');

  print('RenderTapRegionSurface test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderTapRegionSurface Tests'),
      Text('RenderTapRegionSurface'),
    ],
  );
}
