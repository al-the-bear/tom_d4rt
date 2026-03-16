// D4rt test script: Tests FrameData from dart:ui via PlatformDispatcher
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FrameData test executing');

  // Access via PlatformDispatcher
  final dispatcher = ui.PlatformDispatcher.instance;
  final frameData = dispatcher.frameData;
  print('FrameData type: ${frameData.runtimeType}');
  print('frameNumber: ${frameData.frameNumber}');

  // Access again to see if frameNumber changes
  final frameData2 = dispatcher.frameData;
  print('frameNumber (2nd access): ${frameData2.frameNumber}');

  print('FrameData test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FrameData Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('Type: ${frameData.runtimeType}'),
      Text('frameNumber: ${frameData.frameNumber}'),
      Text('Accessed via PlatformDispatcher.instance.frameData'),
    ],
  );
}
