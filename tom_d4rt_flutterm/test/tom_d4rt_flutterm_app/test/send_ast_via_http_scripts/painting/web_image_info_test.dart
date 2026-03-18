// D4rt test script: Tests WebImageInfo from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('WebImageInfo test executing');

  // WebImageInfo is web-specific
  print('WebImageInfo is web-platform specific');

  // Purpose
  print('\nPurpose:');
  print('- Extended ImageInfo for web');
  print('- Contains web-specific data');
  print('- Used by web image providers');

  // Web platform differences
  print('\nWeb platform differences:');
  print('- Images can be HTML elements');
  print('- May reference <img> tags');
  print('- Different rendering path');

  // How it extends ImageInfo
  print('\nExtends ImageInfo:');
  print('- Still has image, scale');
  print('- Adds web-specific metadata');
  print('- Used in Flutter web engine');

  // Platform conditional
  print('\nPlatform conditional:');
  print('if (kIsWeb) {');
  print('  // WebImageInfo may be used');
  print('} else {');
  print('  // Regular ImageInfo');
  print('}');

  // Related classes
  print('\nRelated web classes:');
  print('- HtmlElementView for web elements');
  print('- Platform-specific image decoding');

  // When encountered
  print('\nWhen encountered:');
  print('- Loading network images on web');
  print('- Using Image.network on web');
  print('- Custom web ImageProvider');

  print('\nWebImageInfo test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'WebImageInfo Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Web-platform ImageInfo'),
      Text('Extends base ImageInfo'),
      Text('For: Flutter web engine'),
    ],
  );
}
