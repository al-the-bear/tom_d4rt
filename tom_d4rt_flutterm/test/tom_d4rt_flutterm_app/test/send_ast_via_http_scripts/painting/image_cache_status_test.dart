// D4rt test script: Tests ImageCacheStatus from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ImageCacheStatus test executing');

  // Get current cache stats via PaintingBinding
  print('ImageCacheStatus reports cache state');

  // Properties explanation
  print('\nImageCacheStatus properties:');
  print('- pending: image is being loaded');
  print('- keepAlive: image in keepAlive list');
  print('- live: image in live list');
  print('- untracked: image not in cache');

  // What each means
  print('\nPending:');
  print('- Codec being decoded');
  print('- Not yet available');

  print('\nKeepAlive:');
  print('- Loaded but no active listeners');
  print('- May be evicted under memory pressure');

  print('\nLive:');
  print('- Has active listeners');
  print('- Won\'t be evicted');

  print('\nUntracked:');
  print('- Not managed by cache');
  print('- Custom image handling');

  // How to check
  print('\nHow to check:');
  print('final status = PaintingBinding');
  print('  .instance.imageCache');
  print('  .statusForKey(provider);');
  print('if (status.live) ...');

  // ImageCache relationship
  print('\nImageCache relationship:');
  print('- ImageCache tracks images');
  print('- statusForKey() returns status');
  print('- Useful for debugging');

  print('\nImageCacheStatus test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ImageCacheStatus Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Cache state reporting'),
      Text('States: pending, keepAlive, live'),
      Text('Via: imageCache.statusForKey()'),
    ],
  );
}
