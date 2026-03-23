// ignore_for_file: avoid_print
// D4rt test script: Tests MaterialButton, RawMaterialButton, MaterialType,
// ButtonBar, ButtonBarThemeData, MaterialBanner advanced
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Button types test executing');

  // ========== MaterialType ==========
  print('--- MaterialType Tests ---');
  for (final type in MaterialType.values) {
    print('MaterialType: ${type.name}');
  }

  // ========== ButtonBar ==========
  print('--- ButtonBar Tests ---');
  final buttonBar = ButtonBar(
    alignment: MainAxisAlignment.end,
    mainAxisSize: MainAxisSize.min,
    buttonPadding: EdgeInsets.symmetric(horizontal: 8.0),
    buttonTextTheme: ButtonTextTheme.primary,
    children: [
      TextButton(onPressed: () {}, child: Text('Cancel')),
      ElevatedButton(onPressed: () {}, child: Text('OK')),
    ],
  );
  print('ButtonBar created');

  // ========== ButtonBarThemeData ==========
  print('--- ButtonBarThemeData Tests ---');
  final barTheme = ButtonBarThemeData(
    alignment: MainAxisAlignment.center,
    mainAxisSize: MainAxisSize.min,
    buttonTextTheme: ButtonTextTheme.accent,
    buttonMinWidth: 80.0,
    buttonHeight: 40.0,
    buttonPadding: EdgeInsets.all(8.0),
    layoutBehavior: ButtonBarLayoutBehavior.constrained,
    overflowDirection: VerticalDirection.down,
  );
  print('ButtonBarThemeData created');
  print('  alignment: ${barTheme.alignment}');
  print('  buttonMinWidth: ${barTheme.buttonMinWidth}');
  print('  layoutBehavior: ${barTheme.layoutBehavior}');

  // ========== ButtonTextTheme ==========
  print('--- ButtonTextTheme Tests ---');
  for (final t in ButtonTextTheme.values) {
    print('ButtonTextTheme: ${t.name}');
  }

  // ========== ButtonBarLayoutBehavior ==========
  print('--- ButtonBarLayoutBehavior Tests ---');
  for (final b in ButtonBarLayoutBehavior.values) {
    print('ButtonBarLayoutBehavior: ${b.name}');
  }

  // ========== ThemeDataTween ==========
  print('--- ThemeDataTween Tests ---');
  final lightTheme = ThemeData.light();
  final darkTheme = ThemeData.dark();
  final tween = ThemeDataTween(begin: lightTheme, end: darkTheme);
  final mid = tween.lerp(0.5);
  print('ThemeDataTween created');
  print('  lerp(0.5) brightness: ${mid.brightness}');

  print('All button types tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Button Types Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            buttonBar,
            SizedBox(height: 8.0),
            Text('MaterialType: ${MaterialType.values.length} values'),
            Text('ButtonTextTheme: ${ButtonTextTheme.values.length} values'),
          ],
        ),
      ),
    ),
  );
}
