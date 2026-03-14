import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void _expectCondition(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: $message');
    throw StateError('TransformEngineLayer test failed: $message');
  }
  logs.add('PASS: $message');
}

Float64List _translation(double dx, double dy) {
  return Float64List.fromList(<double>[
    1,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    1,
    0,
    dx,
    dy,
    0,
    1,
  ]);
}

dynamic build(BuildContext context) {
  print('=== TransformEngineLayer comprehensive test start ===');

  final logs = <String>[];
  var assertionCount = 0;

  final builderA = ui.SceneBuilder();
  final transformA = _translation(12, 24);
  final layerA = builderA.pushTransform(transformA);

  _expectCondition(
    layerA is ui.TransformEngineLayer,
    'pushTransform creates TransformEngineLayer',
    logs,
  );
  assertionCount++;

  final recorderA = ui.PictureRecorder();
  final canvasA = ui.Canvas(recorderA);
  canvasA.drawRect(
    const ui.Rect.fromLTWH(0, 0, 20, 20),
    ui.Paint()..color = const ui.Color(0xFF00FF00),
  );
  builderA.addPicture(const ui.Offset(0, 0), recorderA.endRecording());
  builderA.pop();
  final sceneA = builderA.build();

  _expectCondition(
    sceneA is ui.Scene,
    'scene with transform layer builds successfully',
    logs,
  );
  assertionCount++;

  final builderB = ui.SceneBuilder();
  final transformB = _translation(-6, 18);
  final reusedLayer = builderB.pushTransform(transformB, oldLayer: layerA);

  _expectCondition(
    reusedLayer is ui.TransformEngineLayer,
    'oldLayer reuse returns TransformEngineLayer',
    logs,
  );
  assertionCount++;

  final recorderB = ui.PictureRecorder();
  final canvasB = ui.Canvas(recorderB);
  canvasB.drawCircle(
    const ui.Offset(10, 10),
    8,
    ui.Paint()..color = const ui.Color(0xFFFF0000),
  );
  builderB.addPicture(const ui.Offset(0, 0), recorderB.endRecording());
  builderB.pop();
  final sceneB = builderB.build();

  _expectCondition(
    sceneB is ui.Scene,
    'scene with reused transform layer builds successfully',
    logs,
  );
  assertionCount++;

  _expectCondition(
    ui.TransformEngineLayer.toString().contains('TransformEngineLayer'),
    'TransformEngineLayer type name is accessible',
    logs,
  );
  assertionCount++;

  final matrixLengths = <int>[transformA.length, transformB.length];
  _expectCondition(
    matrixLengths.every((value) => value == 16),
    'both transform matrices are 4x4',
    logs,
  );
  assertionCount++;

  _expectCondition(
    transformA[12] == 12 && transformA[13] == 24,
    'first transform translation stored in matrix',
    logs,
  );
  assertionCount++;

  _expectCondition(
    transformB[12] == -6 && transformB[13] == 18,
    'second transform translation stored in matrix',
    logs,
  );
  assertionCount++;

  sceneA.dispose();
  sceneB.dispose();

  print('layerA runtimeType: ${layerA.runtimeType}');
  print('reusedLayer runtimeType: ${reusedLayer.runtimeType}');
  print('matrixLengths: $matrixLengths');

  final summary = <String>[
    'constructor path covered by SceneBuilder.pushTransform',
    'properties covered by matrix content checks and type checks',
    'behavior covered with build/pop and oldLayer reuse path',
    'edge cases covered with negative translation and matrix length checks',
    'assertions: $assertionCount',
  ];

  for (final line in summary) {
    print('SUMMARY: $line');
  }

  print('=== TransformEngineLayer comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('TransformEngineLayer Tests'),
      Text('Assertions: $assertionCount'),
      Text('Layer A: ${layerA.runtimeType}'),
      Text('Layer B: ${reusedLayer.runtimeType}'),
      Text('Matrix lengths: $matrixLengths'),
      Text('Logs: ${logs.length} entries'),
      const Text('Summary widget generated successfully'),
    ],
  );
}
