// D4rt test script: Tests RenderProxySliver from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderProxySliver test executing');

  // RenderProxySliver - Proxy sliver
  // This is typically an abstract/base class used through subclasses
  print('RenderProxySliver is available in the rendering package');
  print('RenderProxySliver: Proxy sliver');

  print('RenderProxySliver test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderProxySliver Tests'),
      Text('Proxy sliver'),
    ],
  );
}
