// D4rt test script: Tests Color from dart:ui
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Color test executing');
  print('=' * 50);

  // Color class for ARGB colors
  print('\nColor:');
  print('Represents a 32-bit ARGB color');
  print('Immutable color value');

  // Constructor
  final c1 = Color(0xFF42A5F5);
  print('\nColor(0xFF42A5F5):');
  print('value: ${c1.toARGB32().toRadixString(16).toUpperCase()}');
  print('alpha: ${(c1.a * 255).round()}');
  print('red: ${(c1.r * 255).round()}');
  print('green: ${(c1.g * 255).round()}');
  print('blue: ${(c1.b * 255).round()}');

  // fromARGB
  final c2 = Color.fromARGB(255, 255, 100, 50);
  print('\nColor.fromARGB(255, 255, 100, 50):');
  print('value: ${c2.toARGB32().toRadixString(16).toUpperCase()}');
  print('red: ${(c2.r * 255).round()}');
  print('green: ${(c2.g * 255).round()}');
  print('blue: ${(c2.b * 255).round()}');

  // fromRGBO
  final c3 = Color.fromRGBO(100, 150, 200, 0.5);
  print('\nColor.fromRGBO(100, 150, 200, 0.5):');
  print('alpha: ${(c3.a * 255).round()}');
  print('opacity: ${c3.a.toStringAsFixed(2)}');

  // withAlpha/withOpacity
  print('\nwithAlpha/withOpacity:');
  final c4 = c1.withAlpha(128);
  print('withAlpha(128).alpha: ${(c4.a * 255).round()}');
  final c5 = c1.withValues(alpha: 0.5);
  print('withOpacity(0.5).opacity: ${c5.a.toStringAsFixed(2)}');

  // withRed/withGreen/withBlue
  print('\nwith component methods:');
  print('withRed(0).red: ${(c1.withRed(0).r * 255).round()}');
  print('withGreen(0).green: ${(c1.withGreen(0).g * 255).round()}');
  print('withBlue(0).blue: ${(c1.withBlue(0).b * 255).round()}');

  // computeLuminance
  print('\ncomputeLuminance:');
  print(
    'white luminance: ${Colors.white.computeLuminance().toStringAsFixed(2)}',
  );
  print(
    'black luminance: ${Colors.black.computeLuminance().toStringAsFixed(2)}',
  );
  print('c1 luminance: ${c1.computeLuminance().toStringAsFixed(2)}');

  // Equality
  print('\nEquality:');
  final c6 = Color(0xFF42A5F5);
  print('c1 == c6: ${c1 == c6}');
  print('c1.hashCode == c6.hashCode: ${c1.hashCode == c6.hashCode}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('Color (class)');
  print('  \u2514\u2500 SystemColor (subclass)');

  // Explain purpose
  print('\nColor purpose:');
  print('- 32-bit ARGB color value');
  print('- Immutable color representation');
  print('- Component accessors');
  print('- with* methods for modification');
  print('- computeLuminance for contrast');

  print('\n${'=' * 50}');
  print('Color test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Color Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Container(width: 50, height: 20, color: c1),
      Text('ARGB: ${(c1.a * 255).round()}, ${(c1.r * 255).round()}, ${(c1.g * 255).round()}, ${(c1.b * 255).round()}'),
      Text('Luminance: ${c1.computeLuminance().toStringAsFixed(2)}'),
      Text('Purpose: ARGB colors'),
    ],
  );
}
