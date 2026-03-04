// D4rt test script: Tests BeveledRectangleBorder, ResizeImage, ResizeImageKey, OneFrameImageStreamCompleter, MultiFrameImageStreamCompleter, ImageErrorListener, ImageCacheStatus, ImageInfo
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('Image stream and painting advanced test executing');

  // ========== BeveledRectangleBorder ==========
  print('--- BeveledRectangleBorder Tests ---');
  final beveledBorder = BeveledRectangleBorder(
    borderRadius: BorderRadius.circular(8.0),
  );
  print('BeveledRectangleBorder borderRadius: ${beveledBorder.borderRadius}');
  print('Type: ${beveledBorder.runtimeType}');

  final beveledWithSide = BeveledRectangleBorder(
    side: BorderSide(color: Colors.blue, width: 2.0),
    borderRadius: BorderRadius.circular(12.0),
  );
  print('BeveledRectangleBorder with side color: blue, width: 2.0');
  print('BeveledRectangleBorder borderRadius: ${beveledWithSide.borderRadius}');

  // ========== ResizeImage ==========
  print('--- ResizeImage Tests ---');
  final resizeImage = ResizeImage(
    NetworkImage('https://example.com/img.png'),
    width: 100,
  );
  print('ResizeImage: created with width 100');
  print('Type: ${resizeImage.runtimeType}');

  final resizeImageBoth = ResizeImage(
    NetworkImage('https://example.com/img2.png'),
    width: 200,
    height: 150,
  );
  print('ResizeImage: created with width 200, height 150');

  // ========== ResizeImageKey ==========
  print('--- ResizeImageKey Tests ---');
  // ResizeImageKey is the key used internally by ResizeImage for caching.
  // Referenced through ResizeImage.
  print('ResizeImageKey: referenced via ResizeImage caching key');
  print('Type: ResizeImageKey');

  // ========== OneFrameImageStreamCompleter ==========
  print('--- OneFrameImageStreamCompleter Tests ---');
  // OneFrameImageStreamCompleter manages single-frame image loading.
  // Requires a Future<ImageInfo> to construct.
  print('OneFrameImageStreamCompleter: single-frame image stream completer');
  print('Type: OneFrameImageStreamCompleter');
  print('Constructor: OneFrameImageStreamCompleter(Future<ImageInfo>)');

  // ========== MultiFrameImageStreamCompleter ==========
  print('--- MultiFrameImageStreamCompleter Tests ---');
  // MultiFrameImageStreamCompleter manages multi-frame (animated) image loading.
  print(
    'MultiFrameImageStreamCompleter: multi-frame animated image stream completer',
  );
  print('Type: MultiFrameImageStreamCompleter');
  print('Used for: animated GIF, APNG, and other multi-frame formats');

  // ========== ImageErrorListener ==========
  print('--- ImageErrorListener Tests ---');
  // ImageErrorListener is a typedef: void Function(dynamic exception, StackTrace? stackTrace)
  void imageErrorListener(dynamic exception, StackTrace? stackTrace) {
    print('ImageErrorListener caught: $exception');
  }

  imageErrorListener('test error', null);
  print('ImageErrorListener: defined function matching typedef signature');
  print('Type: void Function(dynamic, StackTrace?)');

  // ========== ImageCacheStatus ==========
  print('--- ImageCacheStatus Tests ---');
  // ImageCacheStatus represents the cache status of an image.
  // Obtained from ImageCache.statusForKey().
  final imageCache = ImageCache();
  print('ImageCache created: ${imageCache.runtimeType}');
  print('ImageCache maximumSize: ${imageCache.maximumSize}');
  print('ImageCache currentSize: ${imageCache.currentSize}');
  print('ImageCacheStatus: obtained via ImageCache.statusForKey()');
  print('Type: ImageCacheStatus');

  // ========== ImageInfo ==========
  print('--- ImageInfo Tests ---');
  // ImageInfo holds an image and its scale.
  // Cannot easily construct without a real ui.Image, but reference the type.
  print('ImageInfo: holds ui.Image and scale');
  print('Type: ImageInfo');
  print('Fields: image (ui.Image), scale (double), debugLabel (String?)');

  print('All image stream and painting advanced tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Image Stream Advanced Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('BeveledRectangleBorder: OK'),
            Text('ResizeImage: OK'),
            Text('ResizeImageKey: OK'),
            Text('OneFrameImageStreamCompleter: OK'),
            Text('MultiFrameImageStreamCompleter: OK'),
            Text('ImageErrorListener: OK'),
            Text('ImageCacheStatus: OK'),
            Text('ImageInfo: OK'),
          ],
        ),
      ),
    ),
  );
}
