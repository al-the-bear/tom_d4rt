// D4rt test script: Tests DecorationImagePainter from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DecorationImagePainter test executing');

  // DecorationImagePainter paints DecorationImage
  print('DecorationImagePainter paints DecorationImage');

  // What it paints
  print('\nPaints DecorationImage:');
  print('- Image within BoxDecoration');
  print('- Handles fit, alignment, repeat');
  print('- Supports color filters');

  // DecorationImage example
  print('\nDecorationImage properties:');
  print('- image: ImageProvider');
  print('- fit: BoxFit (cover, contain, etc)');
  print('- alignment: Alignment');
  print('- repeat: ImageRepeat');
  print('- colorFilter: ColorFilter');
  print('- opacity: double');

  // How its created
  print('\nCreated by:');
  print('BoxDecoration._createBackgroundImagePainter()');
  print('- Internal to BoxDecoration');
  print('- Not directly instantiated');

  // Paint process
  print('\nPaint process:');
  print('1. Created when BoxPainter needs image');
  print('2. Listens for image load');
  print('3. Paints image to canvas');
  print('4. Applies fit/alignment');

  // Usage
  print('\nUsage via BoxDecoration:');
  print('Container(');
  print('  decoration: BoxDecoration(');
  print('    image: DecorationImage(');
  print('      image: NetworkImage(url),');
  print('      fit: BoxFit.cover,');
  print('    ),');
  print('  ),');
  print(')');

  print('\nDecorationImagePainter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DecorationImagePainter Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Paints DecorationImage'),
      Text('Handles: fit, alignment, repeat'),
      Text('Internal to BoxDecoration'),
    ],
  );
}
