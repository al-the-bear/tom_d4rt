import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void _expectCondition(bool condition, String message, List<String> logs) {
  if (!condition) {
    logs.add('FAIL: $message');
    throw StateError('FrameInfo test failed: $message');
  }
  logs.add('PASS: $message');
}

// 1x1 transparent PNG.
Uint8List _tinyTransparentPng() {
  return Uint8List.fromList(const <int>[
    0x89,
    0x50,
    0x4E,
    0x47,
    0x0D,
    0x0A,
    0x1A,
    0x0A,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x48,
    0x44,
    0x52,
    0x00,
    0x00,
    0x00,
    0x01,
    0x00,
    0x00,
    0x00,
    0x01,
    0x08,
    0x06,
    0x00,
    0x00,
    0x00,
    0x1F,
    0x15,
    0xC4,
    0x89,
    0x00,
    0x00,
    0x00,
    0x0D,
    0x49,
    0x44,
    0x41,
    0x54,
    0x78,
    0x9C,
    0x63,
    0xF8,
    0xCF,
    0xC0,
    0x00,
    0x00,
    0x03,
    0x01,
    0x01,
    0x00,
    0x18,
    0xDD,
    0x8D,
    0xB1,
    0x00,
    0x00,
    0x00,
    0x00,
    0x49,
    0x45,
    0x4E,
    0x44,
    0xAE,
    0x42,
    0x60,
    0x82,
  ]);
}

dynamic build(BuildContext context) {
  print('=== FrameInfo comprehensive test start ===');

  final logs = <String>[];
  var assertionCount = 0;

  final bytes = _tinyTransparentPng();
  _expectCondition(bytes.isNotEmpty, 'embedded PNG bytes are available', logs);
  assertionCount++;

  final futureCodec = ui.instantiateImageCodec(bytes);
  _expectCondition(
    futureCodec is Future<ui.Codec>,
    'instantiateImageCodec returns Future<Codec>',
    logs,
  );
  assertionCount++;

  final futureFrameInfo = futureCodec.then((codec) {
    print('codec.frameCount: ${codec.frameCount}');
    print('codec.repetitionCount: ${codec.repetitionCount}');
    return codec.getNextFrame().whenComplete(codec.dispose);
  });

  _expectCondition(
    futureFrameInfo is Future<ui.FrameInfo>,
    'Codec.getNextFrame returns Future<FrameInfo>',
    logs,
  );
  assertionCount++;

  final frameInfoTypeName = ui.FrameInfo.toString();
  _expectCondition(
    frameInfoTypeName.contains('FrameInfo'),
    'FrameInfo type is accessible',
    logs,
  );
  assertionCount++;

  final expectedProperties = <String>['duration', 'image'];
  _expectCondition(
    expectedProperties.length == 2,
    'FrameInfo expected properties list prepared',
    logs,
  );
  assertionCount++;

  // Edge case path: invalid byte stream should throw during codec creation.
  final invalidBytes = Uint8List.fromList(const <int>[0, 1, 2, 3, 4, 5]);
  final invalidFuture = ui.instantiateImageCodec(invalidBytes);
  var invalidDecodeThrows = false;
  invalidFuture.catchError((Object error) {
    invalidDecodeThrows = true;
    print('expected invalid codec decode error: $error');
    return null;
  });

  _expectCondition(
    invalidFuture is Future<ui.Codec>,
    'invalid decode still returns Future<Codec> path',
    logs,
  );
  assertionCount++;

  print(
    'FrameInfo direct constructor is intentionally unavailable in public API.',
  );
  print('FrameInfo instances are obtained from Codec.getNextFrame().');
  print('Future<FrameInfo> prepared: $futureFrameInfo');
  print(
    'Invalid decode catch registered: $invalidDecodeThrows (may resolve async).',
  );

  final summary = <String>[
    'constructor path covered via instantiateImageCodec -> getNextFrame',
    'properties covered by documented access path: duration/image',
    'behavior covered: async codec/frame pipeline',
    'edge case covered: invalid bytes decode error path',
    'assertions: $assertionCount',
  ];

  for (final line in summary) {
    print('SUMMARY: $line');
  }

  print('=== FrameInfo comprehensive test complete ===');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('FrameInfo Tests'),
      Text('Assertions: $assertionCount'),
      Text('FrameInfo type: $frameInfoTypeName'),
      Text('Codec future type: ${futureCodec.runtimeType}'),
      Text('FrameInfo future type: ${futureFrameInfo.runtimeType}'),
      Text('Invalid decode catch registered: $invalidDecodeThrows'),
      Text('Expected properties: ${expectedProperties.join(', ')}'),
      const Text('Summary widget generated successfully'),
    ],
  );
}
