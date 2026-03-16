// D4rt test script: Tests RenderTapRegion from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderTapRegion test executing');

  // RenderTapRegion - RenderTapRegion
  // This is typically an abstract/base class used through subclasses
  print('RenderTapRegion is available in the widgets package');
  print('RenderTapRegion: RenderTapRegion');

  print('RenderTapRegion test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderTapRegion Tests'),
      Text('RenderTapRegion'),
    ],
  );
}
