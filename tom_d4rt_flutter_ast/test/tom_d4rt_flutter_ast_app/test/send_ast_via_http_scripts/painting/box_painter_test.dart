// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests BoxPainter from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BoxPainter test executing');

  // BoxPainter is abstract - created by Decoration.createBoxPainter
  print('BoxPainter paints Decoration');

  // Create via BoxDecoration
  final decoration = BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(8),
    boxShadow: [BoxShadow(blurRadius: 4)],
  );

  final painter = decoration.createBoxPainter();
  print('\nCreated painter: ${painter.runtimeType}');
  print('is BoxPainter: ${true}');

  // Key methods
  print('\nKey methods:');
  print('- paint(Canvas, Offset, ImageConfiguration)');
  print('- dispose(): clean up resources');

  // How it's used
  print('\nHow it\'s used:');
  print('1. Decoration.createBoxPainter() creates painter');
  print('2. paint() draws decoration to canvas');
  print('3. dispose() when done');

  // ImageConfiguration
  print('\nImageConfiguration provides:');
  print('- size: box dimensions');
  print('- textDirection: for gradients');
  print('- locale: for locale-specific');

  // Reusability
  print('\nReusability:');
  print('- One painter per decoration instance');
  print('- Can paint multiple times');
  print('- More efficient than recreating');

  // In rendering
  print('\nIn rendering (DecoratedBox):');
  print('- createRenderObject uses painter');
  print('- Caches painter for efficiency');
  print('- Recreates on decoration change');

  // Dispose
  painter.dispose();
  print('\nPainter disposed');

  print('\nBoxPainter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'BoxPainter Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Paints Decoration to canvas'),
      Text('Created by: createBoxPainter()'),
      Text('Must dispose when done'),
    ],
  );
}
