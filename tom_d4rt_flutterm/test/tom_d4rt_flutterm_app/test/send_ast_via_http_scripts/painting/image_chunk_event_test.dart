// ignore_for_file: avoid_print
// D4rt test script: Tests ImageChunkEvent from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImageChunkEvent test executing');

  // Create ImageChunkEvent
  final event = ImageChunkEvent(
    cumulativeBytesLoaded: 5000,
    expectedTotalBytes: 10000,
  );

  print('Created: ${event.runtimeType}');

  // Test properties
  print('\nChunk event properties:');
  print('cumulativeBytesLoaded: ${event.cumulativeBytesLoaded}');
  print('expectedTotalBytes: ${event.expectedTotalBytes}');

  // Calculate progress
  if (event.expectedTotalBytes != null) {
    final progress = event.cumulativeBytesLoaded / event.expectedTotalBytes!;
    print('Progress: ${(progress * 100).toStringAsFixed(1)}%');
  }

  // When expectedTotalBytes is null
  print('\nWhen expectedTotalBytes is null:');
  print('- Server didnt send Content-Length');
  print('- Cant calculate percentage');
  print('- Still get bytes loaded');

  // Usage in ImageStreamListener
  print('\nUsage in ImageStreamListener:');
  print('ImageStreamListener(');
  print('  onImage: (info, sync) { },');
  print('  onChunk: (ImageChunkEvent event) {');
  print('    setState(() {');
  print('      _bytesLoaded = event.cumulativeBytesLoaded;');
  print('    });');
  print('  },');
  print(')');

  // Progress indicator example
  print('\nProgress indicator:');
  print('if (event.expectedTotalBytes != null)');
  print('  LinearProgressIndicator(');
  print('    value: loaded / total,');
  print('  )');

  print('\nImageChunkEvent test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ImageChunkEvent Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Image download progress'),
      Text('loaded: ${event.cumulativeBytesLoaded}'),
      Text('total: ${event.expectedTotalBytes}'),
      Text('Used in: onChunk callback'),
    ],
  );
}
