// D4rt test script: Tests MultiFrameImageStreamCompleter from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MultiFrameImageStreamCompleter test executing');

  // MultiFrameImageStreamCompleter handles animated images (GIF, APNG, etc)
  print('MultiFrameImageStreamCompleter for animated images');

  // Explain purpose
  print('\nPurpose:');
  print('- Handles multi-frame animated images');
  print('- Manages frame timing and decoding');
  print('- Supports GIF, APNG, animated WebP');

  // Constructor parameters
  print('\nConstructor parameters:');
  print('- codec: async stream of Codec');
  print('- scale: image scale factor');
  print('- informationCollector: debug info');
  print('- chunkEvents: loading progress');

  // How it works
  print('\nHow it works:');
  print('1. Receives Codec stream');
  print('2. Decodes frames on demand');
  print('3. Reports frame duration');
  print('4. Loops animation if configured');

  // Type hierarchy
  print('\nType hierarchy:');
  print('ImageStreamCompleter (abstract)');
  print('  └── MultiFrameImageStreamCompleter');
  print('  └── OneFrameImageStreamCompleter');

  // Lifecycle
  print('\nLifecycle:');
  print('- Created by ImageProvider');
  print('- Receives codec asynchronously');
  print('- Notifies listeners per frame');
  print('- Disposed when no listeners');

  // Example usage
  print('\nUsage in custom ImageProvider:');
  print('load() {');
  print('  return MultiFrameImageStreamCompleter(');
  print('    codec: loadCodec(),');
  print('    scale: scale,');
  print('  );');
  print('}');

  print('\nMultiFrameImageStreamCompleter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MultiFrameImageStreamCompleter Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Animated image handler'),
      Text('Supports: GIF, APNG, WebP'),
      Text('Decodes frames on demand'),
    ],
  );
}
