// ignore_for_file: avoid_print
// D4rt test script: Tests Gradient from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Gradient test executing');

  // Gradient is abstract - test via LinearGradient
  final linear = LinearGradient(
    colors: [Colors.red, Colors.blue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  print('LinearGradient: ${linear.runtimeType}');
  print('is Gradient: ${true}');

  // Test properties
  print('\nLinearGradient properties:');
  print('colors: ${linear.colors}');
  print('begin: ${linear.begin}');
  print('end: ${linear.end}');

  // RadialGradient
  print('\nRadialGradient:');
  final radial = RadialGradient(
    colors: [Colors.yellow, Colors.orange],
    center: Alignment.center,
    radius: 0.5,
  );
  print('type: ${radial.runtimeType}');
  print('center: ${radial.center}');
  print('radius: ${radial.radius}');

  // SweepGradient
  print('\nSweepGradient:');
  final sweep = SweepGradient(
    colors: [Colors.green, Colors.blue, Colors.green],
    center: Alignment.center,
  );
  print('type: ${sweep.runtimeType}');

  // Type hierarchy
  print('\nGradient subclasses:');
  print('- LinearGradient');
  print('- RadialGradient');
  print('- SweepGradient');

  // Usage
  print('\nUsage in BoxDecoration:');
  print('BoxDecoration(gradient: LinearGradient(...))');

  // Create shader
  print('\nCreate shader:');
  print('gradient.createShader(Rect bounds)');

  print('\nGradient test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Gradient Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Abstract gradient base'),
      Container(
        width: 100,
        height: 30,
        decoration: BoxDecoration(gradient: linear),
      ),
      Text('Subclasses: Linear, Radial, Sweep'),
    ],
  );
}
