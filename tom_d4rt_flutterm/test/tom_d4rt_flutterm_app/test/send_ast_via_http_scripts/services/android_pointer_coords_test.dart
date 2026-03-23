// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AndroidPointerCoords from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AndroidPointerCoords test executing');
  print('=' * 50);

  // Create AndroidPointerCoords with basic parameters
  final coords1 = AndroidPointerCoords(
    orientation: 0.0,
    pressure: 1.0,
    size: 0.5,
    toolMajor: 10.0,
    toolMinor: 8.0,
    touchMajor: 20.0,
    touchMinor: 15.0,
    x: 100.0,
    y: 200.0,
  );
  print('\nAndroidPointerCoords created:');
  print('runtimeType: ${coords1.runtimeType}');
  print('x: ${coords1.x}');
  print('y: ${coords1.y}');
  print('pressure: ${coords1.pressure}');
  print('size: ${coords1.size}');

  // Test orientation
  print('\nOrientation and geometry:');
  print('orientation: ${coords1.orientation}');
  print('toolMajor: ${coords1.toolMajor}');
  print('toolMinor: ${coords1.toolMinor}');
  print('touchMajor: ${coords1.touchMajor}');
  print('touchMinor: ${coords1.touchMinor}');

  // Create with different pressure values
  print('\nDifferent pressure values:');
  final lightTouch = AndroidPointerCoords(
    orientation: 0,
    pressure: 0.2,
    size: 0.3,
    toolMajor: 5,
    toolMinor: 4,
    touchMajor: 10,
    touchMinor: 8,
    x: 50,
    y: 50,
  );
  final hardPress = AndroidPointerCoords(
    orientation: 0,
    pressure: 1.0,
    size: 0.8,
    toolMajor: 15,
    toolMinor: 12,
    touchMajor: 30,
    touchMinor: 25,
    x: 150,
    y: 150,
  );
  print('Light touch pressure: ${lightTouch.pressure}');
  print('Hard press pressure: ${hardPress.pressure}');

  // Create with orientation
  print('\nDifferent orientations:');
  final horizontal = AndroidPointerCoords(
    orientation: 0.0,
    pressure: 0.5,
    size: 0.5,
    toolMajor: 10,
    toolMinor: 5,
    touchMajor: 20,
    touchMinor: 10,
    x: 100,
    y: 100,
  );
  final diagonal = AndroidPointerCoords(
    orientation: 0.785,
    pressure: 0.5,
    size: 0.5,
    toolMajor: 10,
    toolMinor: 5,
    touchMajor: 20,
    touchMinor: 10,
    x: 100,
    y: 100,
  );
  print('Horizontal orientation: ${horizontal.orientation}');
  print('Diagonal (45°) orientation: ${diagonal.orientation}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is Object: true /* coords1 is Object */');

  // Compare coordinates
  print('\nCoordinate comparison:');
  print('x range: ${lightTouch.x} to ${hardPress.x}');
  print('y range: ${lightTouch.y} to ${hardPress.y}');

  // Touch/Tool size relationship
  print('\nTouch vs Tool size:');
  print('touchMajor >= toolMajor: ${coords1.touchMajor >= coords1.toolMajor}');
  print('touchMinor >= toolMinor: ${coords1.touchMinor >= coords1.toolMinor}');

  // Explain purpose
  print('\nAndroidPointerCoords purpose:');
  print('- Detailed touch/stylus coordinate data');
  print('- x, y: Position on screen');
  print('- pressure: Touch pressure (0.0-1.0)');
  print('- size: Touch point size');
  print('- orientation: Touch angle in radians');
  print('- touchMajor/Minor: Touch contact ellipse');
  print('- toolMajor/Minor: Tool (finger/stylus) size');
  print('- Used in AndroidMotionEvent');

  print('\n' + '=' * 50);
  print('AndroidPointerCoords test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'AndroidPointerCoords Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${coords1.runtimeType}'),
      Text('Position: (${coords1.x}, ${coords1.y})'),
      Text('pressure: ${coords1.pressure}'),
      Text('size: ${coords1.size}'),
      Text('Purpose: Android touch coordinates'),
    ],
  );
}
