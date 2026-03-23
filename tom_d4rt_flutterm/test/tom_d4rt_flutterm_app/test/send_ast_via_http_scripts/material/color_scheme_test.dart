// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ColorScheme, MaterialColor, MaterialAccentColor,
// ThemeDataTween, theme concepts
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Color scheme test executing');

  // ========== ColorScheme ==========
  print('--- ColorScheme Tests ---');
  final lightScheme = ColorScheme.light(
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: Colors.green,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.white,
    onSurface: Colors.black,
  );
  print('ColorScheme.light created');
  print('  primary: ${lightScheme.primary}');
  print('  secondary: ${lightScheme.secondary}');
  print('  brightness: ${lightScheme.brightness}');

  final darkScheme = ColorScheme.dark(
    primary: Colors.blue.shade200,
    secondary: Colors.green.shade200,
  );
  print('ColorScheme.dark created');
  print('  brightness: ${darkScheme.brightness}');

  // fromSeed
  final seedScheme = ColorScheme.fromSeed(seedColor: Colors.deepPurple);
  print('ColorScheme.fromSeed(deepPurple)');
  print('  primary: ${seedScheme.primary}');
  print('  primaryContainer: ${seedScheme.primaryContainer}');

  // copyWith
  final modified = lightScheme.copyWith(primary: Colors.orange);
  print('copyWith primary: ${modified.primary}');

  // ========== MaterialColor ==========
  print('--- MaterialColor Tests ---');
  final matColor = MaterialColor(0xFF4CAF50, {
    50: Color(0xFFE8F5E9),
    100: Color(0xFFC8E6C9),
    200: Color(0xFFA5D6A7),
    300: Color(0xFF81C784),
    400: Color(0xFF66BB6A),
    500: Color(0xFF4CAF50),
    600: Color(0xFF43A047),
    700: Color(0xFF388E3C),
    800: Color(0xFF2E7D32),
    900: Color(0xFF1B5E20),
  });
  print('MaterialColor created');
  print('  shade50: ${matColor.shade50}');
  print('  shade500: ${matColor.shade500}');
  print('  shade900: ${matColor.shade900}');

  // Built-in material colors
  print('Colors.blue.shade100: ${Colors.blue.shade100}');
  print('Colors.red.shade400: ${Colors.red.shade400}');
  print('Colors.green.shade700: ${Colors.green.shade700}');

  // ========== MaterialAccentColor ==========
  print('--- MaterialAccentColor Tests ---');
  final accentColor = MaterialAccentColor(0xFF448AFF, {
    100: Color(0xFF82B1FF),
    200: Color(0xFF448AFF),
    400: Color(0xFF2979FF),
    700: Color(0xFF2962FF),
  });
  print('MaterialAccentColor created');
  print('  shade100: ${accentColor.shade100}');
  print('  shade200: ${accentColor.shade200}');
  print('  shade700: ${accentColor.shade700}');

  // Built-in accent colors
  print('Colors.blueAccent: ${Colors.blueAccent}');
  print('Colors.redAccent: ${Colors.redAccent}');

  print('All color scheme tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    theme: ThemeData(colorScheme: seedScheme),
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Color Scheme Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (final shade in [100, 300, 500, 700, 900])
                  Container(width: 40, height: 40, color: Colors.blue[shade]),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
