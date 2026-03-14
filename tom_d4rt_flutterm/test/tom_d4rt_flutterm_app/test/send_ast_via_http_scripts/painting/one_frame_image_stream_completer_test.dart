// D4rt test script: Tests OneFrameImageStreamCompleter from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('OneFrameImageStreamCompleter test executing');

  // OneFrameImageStreamCompleter for static images
  print('OneFrameImageStreamCompleter handles static images');

  // Purpose
  print('\nPurpose:');
  print('- Handles single-frame static images');
  print('- PNG, JPEG, BMP, etc.');
  print('- Simpler than MultiFrame variant');

  // Constructor
  print('\nConstructor:');
  print('OneFrameImageStreamCompleter(');
  print('  Future<ImageInfo> image,');
  print('  {InformationCollector? info}');
  print(')');

  // How it works
  print('\nHow it works:');
  print('1. Receives Future<ImageInfo>');
  print('2. Waits for image to load');
  print('3. Notifies all listeners once');
  print('4. Keeps image for late listeners');

  // vs MultiFrame
  print('\nvs MultiFrameImageStreamCompleter:');
  print('- OneFrame: static images (PNG, JPEG)');
  print('- MultiFrame: animated (GIF, APNG)');
  print('- OneFrame is simpler, no timing');

  // Type hierarchy
  print('\nType hierarchy:');
  print('ImageStreamCompleter (abstract)');
  print('  └── OneFrameImageStreamCompleter');
  print('  └── MultiFrameImageStreamCompleter');

  // Usage in ImageProvider
  print('\nUsage in ImageProvider:');
  print('load() {');
  print('  return OneFrameImageStreamCompleter(');
  print('    loadImage(),');
  print('  );');
  print('}');

  print('\nOneFrameImageStreamCompleter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'OneFrameImageStreamCompleter Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Static image handler'),
      Text('Formats: PNG, JPEG, BMP'),
      Text('Single notification'),
    ],
  );
}
