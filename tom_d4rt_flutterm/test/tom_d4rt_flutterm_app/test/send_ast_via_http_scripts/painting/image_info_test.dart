// D4rt test script: Tests ImageInfo from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('ImageInfo test executing');

  // ImageInfo wraps decoded image with metadata
  print('ImageInfo wraps ui.Image with metadata');

  // What it contains
  print('\nImageInfo properties:');
  print('- image: ui.Image (the pixel data)');
  print('- scale: double (display scale)');
  print('- debugLabel: String? (for debugging)');

  // Scale explanation
  print('\nScale examples:');
  print('- 1.0: @1x image');
  print('- 2.0: @2x retina image');
  print('- 3.0: @3x super retina');

  // Size with scale
  print('\nPhysical vs logical size:');
  print('image.width / scale = logical width');
  print('200px @ 2.0 scale = 100 logical px');

  // How received
  print('\nHow received:');
  print('ImageStreamListener(');
  print('  (ImageInfo info, bool sync) {');
  print('    final image = info.image;');
  print('    final scale = info.scale;');
  print('  },');
  print(')');

  // Clone
  print('\nCloning:');
  print('- info.clone() creates copy');
  print('- Needed to extend lifetime');
  print('- Must dispose when done');

  // Dispose
  print('\nDispose:');
  print('- info.dispose() releases image');
  print('- Required to free GPU memory');
  print('- Call when no longer needed');

  // In Image widget
  print('\nIn Image widget:');
  print('- Receives ImageInfo from provider');
  print('- Uses image in RawImage');
  print('- Framework handles dispose');

  print('\nImageInfo test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ImageInfo Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Decoded image wrapper'),
      Text('Contains: image + scale'),
      Text('Must dispose after use'),
    ],
  );
}
