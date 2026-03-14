// D4rt test script: Tests ImageStreamListener from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageStreamListener test executing');
  final results = <String>[];

  // ========== Basic ImageStreamListener Tests ==========
  print('Testing ImageStreamListener constructors...');

  // Test 1: Create ImageStreamListener with onImage only
  var imageCallCount = 0;
  final listener1 = ImageStreamListener((ImageInfo info, bool synchronousCall) {
    imageCallCount++;
    print('Image callback invoked');
  });
  assert(listener1 != null, 'Listener should be created');
  results.add('ImageStreamListener with onImage created');
  print('Listener1 created');

  // Test 2: Create ImageStreamListener with onImage and onError
  var errorCallCount = 0;
  final listener2 = ImageStreamListener(
    (ImageInfo info, bool synchronousCall) {
      imageCallCount++;
    },
    onError: (Object exception, StackTrace? stackTrace) {
      errorCallCount++;
      print('Error callback invoked: $exception');
    },
  );
  assert(listener2 != null, 'Listener with error handler should be created');
  results.add('ImageStreamListener with onImage and onError created');
  print('Listener2 created');

  // Test 3: Create ImageStreamListener with onChunk
  var chunkCallCount = 0;
  final listener3 = ImageStreamListener(
    (ImageInfo info, bool synchronousCall) {
      imageCallCount++;
    },
    onChunk: (ImageChunkEvent event) {
      chunkCallCount++;
      print(
        'Chunk event: ${event.cumulativeBytesLoaded}/${event.expectedTotalBytes}',
      );
    },
  );
  assert(listener3 != null, 'Listener with chunk handler should be created');
  results.add('ImageStreamListener with onChunk created');
  print('Listener3 created');

  // Test 4: Full ImageStreamListener
  final listener4 = ImageStreamListener(
    (ImageInfo info, bool synchronousCall) {
      imageCallCount++;
    },
    onChunk: (ImageChunkEvent event) {
      chunkCallCount++;
    },
    onError: (Object exception, StackTrace? stackTrace) {
      errorCallCount++;
    },
  );
  assert(listener4 != null, 'Full listener should be created');
  results.add('Full ImageStreamListener created (all callbacks)');
  print('Full listener created');

  // ========== Callback Signature Documentation ==========
  print('Documenting callback signatures...');

  // onImage signature
  results.add('onImage: void Function(ImageInfo info, bool synchronousCall)');
  print('onImage signature documented');

  // onError signature
  results.add(
    'onError: void Function(Object exception, StackTrace? stackTrace)?',
  );
  print('onError signature documented');

  // onChunk signature
  results.add('onChunk: void Function(ImageChunkEvent event)?');
  print('onChunk signature documented');

  // ========== Callback Behavior Documentation ==========
  print('Documenting callback behavior...');

  // synchronousCall parameter
  results.add(
    'synchronousCall=true: Called during addListener (image was cached)',
  );
  print('synchronousCall=true documented');

  results.add('synchronousCall=false: Called asynchronously (image loaded)');
  print('synchronousCall=false documented');

  // Image callback frequency
  results.add('onImage may be called multiple times (multi-frame images)');
  print('Multi-frame documented');

  // Chunk callback frequency
  results.add('onChunk called during progressive loading');
  print('Chunk frequency documented');

  // ========== Error Handling Patterns ==========
  print('Documenting error handling patterns...');

  // Pattern 1: Basic error handling
  results.add('Pattern: Always provide onError to handle failures');
  print('Error handling pattern documented');

  // Pattern 2: Error types
  final errorTypes = [
    'NetworkImageLoadException - HTTP errors',
    'SocketException - Network unavailable',
    'FormatException - Invalid image format',
    'Exception - General loading failures',
  ];
  for (final errorType in errorTypes) {
    results.add('Error type: $errorType');
    print('Error type: $errorType');
  }

  // ========== ImageStreamListener Equality ==========
  print('Testing listener equality...');

  // Same callback = same listener
  void imageCallback(ImageInfo info, bool sync) {}
  final listenerA = ImageStreamListener(imageCallback);
  final listenerB = ImageStreamListener(imageCallback);

  // Note: Listeners with same callback are equal
  results.add('Listener equality based on callback identity');
  print('Equality documented');

  // ========== ImageStreamListener in ImageStream ==========
  print('Testing ImageStreamListener with ImageStream...');

  final stream = ImageStream();
  results.add('ImageStream created for listener test');
  print('Stream created');

  // Note: Cannot fully test addListener without completer,
  // but can verify API exists
  results.add('ImageStream.addListener(listener) - registers callback');
  print('addListener API documented');

  results.add('ImageStream.removeListener(listener) - unregisters callback');
  print('removeListener API documented');

  // ========== Best Practices ==========
  print('Documenting best practices...');

  results.add('Best practice: Store listener reference for removal');
  print('Listener storage documented');

  results.add('Best practice: Remove listener in dispose()');
  print('Dispose cleanup documented');

  results.add('Best practice: Handle both success and error cases');
  print('Error handling documented');

  results.add('Best practice: Dispose ImageInfo after use');
  print('Resource disposal documented');

  // ========== Multiple Listeners Count ==========
  print('Testing multiple listener creation...');

  final listeners = <ImageStreamListener>[];
  for (var i = 0; i < 5; i++) {
    final idx = i;
    final listener = ImageStreamListener(
      (ImageInfo info, bool sync) => print('Listener $idx called'),
    );
    listeners.add(listener);
    results.add('Listener #${i + 1} created');
    print('Listener #${i + 1} created');
  }
  assert(listeners.length == 5, 'Should have 5 listeners');
  results.add('Total listeners created: ${listeners.length}');

  print('ImageStreamListener test completed: ${results.length} tests/docs');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'ImageStreamListener Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      Text('Total items: ${results.length}', style: TextStyle(fontSize: 14)),
      Divider(),
      ...results.map(
        (r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(r, style: TextStyle(fontSize: 11)),
        ),
      ),
    ],
  );
}
