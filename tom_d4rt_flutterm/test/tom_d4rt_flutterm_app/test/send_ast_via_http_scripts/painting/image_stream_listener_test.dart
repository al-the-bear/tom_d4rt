// D4rt test script: Tests ImageStreamListener from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImageStreamListener test executing');

  // Create ImageStreamListener
  final listener = ImageStreamListener(
    (ImageInfo info, bool sync) {
      print('Image loaded: ${info.image.width}x${info.image.height}');
    },
    onChunk: (ImageChunkEvent event) {
      print('Progress: ${event.cumulativeBytesLoaded}');
    },
    onError: (Object error, StackTrace? stack) {
      print('Error: $error');
    },
  );

  print('Created: ${listener.runtimeType}');

  // Test callbacks
  print('\nCallback properties:');
  print('onImage: ${listener.onImage != null}');
  print('onChunk: ${listener.onChunk != null}');
  print('onError: ${listener.onError != null}');

  // Callback explanations
  print('\nCallback purposes:');
  print('- onImage: called when image ready');
  print('- onChunk: called during download');
  print('- onError: called on failure');

  // onImage parameters
  print('\nonImage parameters:');
  print('- ImageInfo: decoded image + scale');
  print('- bool sync: true if synchronous');

  // onChunk for progress
  print('\nImageChunkEvent:');
  print('- cumulativeBytesLoaded: bytes so far');
  print('- expectedTotalBytes: total size');

  // Usage with Image widget
  print('\nUsage pattern:');
  print('final stream = provider.resolve(config);');
  print('stream.addListener(ImageStreamListener(');
  print('  (info, sync) => setState(() => _image = info),');
  print('  onError: (e, s) => handleError(e),');
  print('));');

  print('\nImageStreamListener test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ImageStreamListener Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Image load callbacks'),
      Text('onImage: when ready'),
      Text('onChunk: progress'),
      Text('onError: failures'),
    ],
  );
}
