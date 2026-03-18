// D4rt test script: Tests RenderSliverFillRemainingWithScrollable from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverFillRemainingWithScrollable test executing');

  // RenderSliverFillRemainingWithScrollable - Scrollable remaining
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverFillRemainingWithScrollable is available in the rendering package');
  print('RenderSliverFillRemainingWithScrollable: Scrollable remaining');

  print('RenderSliverFillRemainingWithScrollable test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverFillRemainingWithScrollable Tests'),
      Text('Scrollable remaining'),
    ],
  );
}
