// ignore_for_file: avoid_print
// D4rt test script: Tests TextSelectionTheme, TextSelectionThemeData,
// TextSelectionHandleType
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextSelection widgets test executing');

  // ========== TextSelectionHandleType ==========
  print('--- TextSelectionHandleType Tests ---');
  for (final type in TextSelectionHandleType.values) {
    print('TextSelectionHandleType: ${type.name}');
  }

  // ========== TextSelectionThemeData ==========
  print('--- TextSelectionThemeData Tests ---');
  final themeData = TextSelectionThemeData(
    cursorColor: Colors.blue,
    selectionColor: Colors.blue.withValues(alpha: 0.4),
    selectionHandleColor: Colors.blue,
  );
  print('TextSelectionThemeData created');
  print('  cursorColor: ${themeData.cursorColor}');
  print('  selectionColor: ${themeData.selectionColor}');
  print('  selectionHandleColor: ${themeData.selectionHandleColor}');

  // Default theme data
  final defaultData = TextSelectionThemeData();
  print('Default TextSelectionThemeData created');
  print('  cursorColor: ${defaultData.cursorColor}');

  // copyWith
  final copied = themeData.copyWith(cursorColor: Colors.red);
  print('copyWith cursorColor: ${copied.cursorColor}');

  // ========== TextSelectionTheme ==========
  print('--- TextSelectionTheme Tests ---');
  final theme = TextSelectionTheme(data: themeData, child: Text('Themed text'));
  print('TextSelectionTheme created');

  // lerp
  final lerped = TextSelectionThemeData.lerp(themeData, defaultData, 0.5);
  print('TextSelectionThemeData.lerp at 0.5');

  print('All text selection widget tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: TextSelectionTheme(
        data: TextSelectionThemeData(
          cursorColor: Colors.red,
          selectionColor: Colors.red.withValues(alpha: 0.3),
          selectionHandleColor: Colors.red,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'TextSelection Widgets Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'TextSelectionHandleType: ${TextSelectionHandleType.values.length} values',
              ),
              Text('TextSelectionThemeData created'),
              Text('TextSelectionTheme wrapping'),
            ],
          ),
        ),
      ),
    ),
  );
}
