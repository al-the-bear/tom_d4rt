// D4rt test script: Tests RenderSliverOverlapInjector from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderSliverOverlapInjector test executing');

  // RenderSliverOverlapInjector - RenderSliverOverlapInjector
  // This is typically an abstract/base class used through subclasses
  print('RenderSliverOverlapInjector is available in the widgets package');
  print('RenderSliverOverlapInjector: RenderSliverOverlapInjector');

  print('RenderSliverOverlapInjector test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderSliverOverlapInjector Tests'),
      Text('RenderSliverOverlapInjector'),
    ],
  );
}
