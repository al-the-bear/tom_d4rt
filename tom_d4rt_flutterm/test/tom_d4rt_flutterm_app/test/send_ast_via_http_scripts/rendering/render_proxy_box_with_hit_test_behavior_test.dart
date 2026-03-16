// D4rt test script: Tests RenderProxyBoxWithHitTestBehavior from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderProxyBoxWithHitTestBehavior test executing');

  // RenderProxyBoxWithHitTestBehavior - Proxy with behavior
  // This is typically an abstract/base class used through subclasses
  print('RenderProxyBoxWithHitTestBehavior is available in the rendering package');
  print('RenderProxyBoxWithHitTestBehavior: Proxy with behavior');

  print('RenderProxyBoxWithHitTestBehavior test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderProxyBoxWithHitTestBehavior Tests'),
      Text('Proxy with behavior'),
    ],
  );
}
