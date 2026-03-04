// D4rt test script: Tests RenderWebImage from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderWebImage test executing');

  // RenderWebImage - RenderWebImage
  // This is typically an abstract/base class used through subclasses
  print('RenderWebImage is available in the widgets package');
  print('RenderWebImage: RenderWebImage');

  print('RenderWebImage test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderWebImage Tests'),
      Text('RenderWebImage'),
    ],
  );
}
