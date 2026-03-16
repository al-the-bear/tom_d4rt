// D4rt test script: Tests ChannelBuffers from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ChannelBuffers test executing');

  // Static constants
  print('kDefaultBufferSize: ${ui.ChannelBuffers.kDefaultBufferSize}');
  print('kControlChannelName: ${ui.ChannelBuffers.kControlChannelName}');

  // Create instance
  final buffers = ui.ChannelBuffers();
  print('ChannelBuffers created: ${buffers.runtimeType}');

  // Resize a channel
  buffers.resize('test_channel', 100);
  print('Resized test_channel to 100');

  // Allow overflow
  buffers.allowOverflow('test_channel', true);
  print('allowOverflow(test_channel, true)');

  buffers.allowOverflow('test_channel', false);
  print('allowOverflow(test_channel, false)');

  // Resize another channel
  buffers.resize('another_channel', 50);
  print('Resized another_channel to 50');

  // Test with different sizes
  buffers.resize('small_channel', 1);
  print('Resized small_channel to 1');
  buffers.resize('large_channel', 1000);
  print('Resized large_channel to 1000');

  print('ChannelBuffers test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ChannelBuffers Tests', style: TextStyle(fontWeight: FontWeight.bold)),
      SizedBox(height: 8),
      Text('kDefaultBufferSize: ${ui.ChannelBuffers.kDefaultBufferSize}'),
      Text('kControlChannelName: ${ui.ChannelBuffers.kControlChannelName}'),
      Text('Constructor, resize, allowOverflow: OK'),
    ],
  );
}
