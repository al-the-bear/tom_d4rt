// D4rt test script: Tests PipelineManifold from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PipelineManifold test executing');

  // Test PipelineManifold - Pipeline manifold
  print('PipelineManifold is available in the rendering package');
  print('PipelineManifold: Pipeline manifold');

  print('PipelineManifold test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PipelineManifold Tests'),
      Text('Pipeline manifold'),
    ],
  );
}
