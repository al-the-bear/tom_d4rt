// ignore_for_file: avoid_print
// D4rt test script: Tests Placeholder widget from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Placeholder test executing');

  // ========== PLACEHOLDER ==========
  print('--- Placeholder Tests ---');

  // Default Placeholder
  final defaultPlaceholder = Placeholder();
  print('Default Placeholder created');

  // Placeholder with custom color
  final colorPlaceholder = Placeholder(color: Colors.red);
  print('Placeholder with red color created');

  // Placeholder with custom stroke width
  final strokePlaceholder = Placeholder(strokeWidth: 4.0);
  print('Placeholder with strokeWidth=4.0 created');

  // Placeholder with fallback dimensions
  final dimensionPlaceholder = Placeholder(
    fallbackWidth: 200.0,
    fallbackHeight: 100.0,
  );
  print('Placeholder with fallback 200x100 created');

  // Placeholder with all custom properties
  final fullPlaceholder = Placeholder(
    color: Colors.blue,
    strokeWidth: 3.0,
    fallbackWidth: 300.0,
    fallbackHeight: 150.0,
  );
  print('Full custom Placeholder created');
  print('  color: ${fullPlaceholder.color}');
  print('  strokeWidth: ${fullPlaceholder.strokeWidth}');
  print('  fallbackWidth: ${fullPlaceholder.fallbackWidth}');
  print('  fallbackHeight: ${fullPlaceholder.fallbackHeight}');

  // Placeholder with child replaced (used for layout testing)
  final smallPlaceholder = Placeholder(
    fallbackWidth: 50.0,
    fallbackHeight: 50.0,
    color: Colors.green,
    strokeWidth: 1.0,
  );
  print('Small Placeholder 50x50 created');

  print('All Placeholder tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Placeholder Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            SizedBox(width: 200.0, height: 100.0, child: defaultPlaceholder),
            SizedBox(height: 8.0),
            SizedBox(width: 200.0, height: 100.0, child: colorPlaceholder),
            SizedBox(height: 8.0),
            SizedBox(width: 200.0, height: 100.0, child: strokePlaceholder),
            SizedBox(height: 8.0),
            fullPlaceholder,
          ],
        ),
      ),
    ),
  );
}
