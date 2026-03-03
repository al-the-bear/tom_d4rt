// D4rt test script: Tests ButtonTheme, ButtonThemeData, ElevatedButtonTheme, ElevatedButtonThemeData, TextButtonTheme, OutlinedButtonTheme, FilledButtonTheme, IconButtonTheme, FloatingActionButtonTheme, FloatingActionButtonThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ThemaData (button themes) test executing');

  // ========== BUTTON THEME DATA ==========
  print('--- ButtonThemeData Tests ---');

  final buttonThemeData = ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
    minWidth: 88.0,
    height: 36.0,
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
  );
  print('ButtonThemeData created');
  print('  minWidth: ${buttonThemeData.minWidth}');
  print('  height: ${buttonThemeData.height}');
  print('  textTheme: ${buttonThemeData.textTheme}');

  // ========== ELEVATED BUTTON THEME DATA ==========
  print('--- ElevatedButtonThemeData Tests ---');

  final elevatedStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.blue),
    foregroundColor: WidgetStateProperty.all(Colors.white),
    elevation: WidgetStateProperty.all(4.0),
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
    ),
  );
  final elevatedButtonThemeData = ElevatedButtonThemeData(style: elevatedStyle);
  print('ElevatedButtonThemeData created');
  print('  style: ${elevatedButtonThemeData.style}');

  // ========== TEXT BUTTON THEME DATA ==========
  print('--- TextButtonThemeData Tests ---');

  final textButtonStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.indigo),
    padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 16.0)),
    textStyle: WidgetStateProperty.all(TextStyle(fontSize: 14.0)),
  );
  final textButtonThemeData = TextButtonThemeData(style: textButtonStyle);
  print('TextButtonThemeData created');
  print('  style: ${textButtonThemeData.style}');

  // ========== OUTLINED BUTTON THEME DATA ==========
  print('--- OutlinedButtonThemeData Tests ---');

  final outlinedStyle = ButtonStyle(
    foregroundColor: WidgetStateProperty.all(Colors.teal),
    side: WidgetStateProperty.all(BorderSide(color: Colors.teal, width: 2.0)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
    ),
  );
  final outlinedButtonThemeData = OutlinedButtonThemeData(style: outlinedStyle);
  print('OutlinedButtonThemeData created');
  print('  style: ${outlinedButtonThemeData.style}');

  // ========== FILLED BUTTON THEME DATA ==========
  print('--- FilledButtonThemeData Tests ---');

  final filledStyle = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Colors.deepPurple),
    foregroundColor: WidgetStateProperty.all(Colors.white),
    elevation: WidgetStateProperty.all(0.0),
  );
  final filledButtonThemeData = FilledButtonThemeData(style: filledStyle);
  print('FilledButtonThemeData created');
  print('  style: ${filledButtonThemeData.style}');

  // ========== ICON BUTTON THEME DATA ==========
  print('--- IconButtonThemeData Tests ---');

  final iconButtonStyle = ButtonStyle(
    iconColor: WidgetStateProperty.all(Colors.orange),
    iconSize: WidgetStateProperty.all(28.0),
    padding: WidgetStateProperty.all(EdgeInsets.all(8.0)),
  );
  final iconButtonThemeData = IconButtonThemeData(style: iconButtonStyle);
  print('IconButtonThemeData created');
  print('  style: ${iconButtonThemeData.style}');

  // ========== FLOATING ACTION BUTTON THEME DATA ==========
  print('--- FloatingActionButtonThemeData Tests ---');

  final fabThemeData = FloatingActionButtonThemeData(
    backgroundColor: Colors.green,
    foregroundColor: Colors.white,
    elevation: 6.0,
    focusElevation: 8.0,
    hoverElevation: 10.0,
    highlightElevation: 12.0,
    splashColor: Colors.greenAccent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    iconSize: 24.0,
    sizeConstraints: BoxConstraints.tightFor(width: 56.0, height: 56.0),
  );
  print('FloatingActionButtonThemeData created');
  print('  backgroundColor: ${fabThemeData.backgroundColor}');
  print('  foregroundColor: ${fabThemeData.foregroundColor}');
  print('  elevation: ${fabThemeData.elevation}');
  print('  iconSize: ${fabThemeData.iconSize}');

  // ========== WRAP IN THEME WIDGET ==========
  print('--- Theme Integration ---');

  final themeData = ThemeData(
    buttonTheme: buttonThemeData,
    elevatedButtonTheme: elevatedButtonThemeData,
    textButtonTheme: textButtonThemeData,
    outlinedButtonTheme: outlinedButtonThemeData,
    filledButtonTheme: filledButtonThemeData,
    iconButtonTheme: iconButtonThemeData,
    floatingActionButtonTheme: fabThemeData,
  );
  print('ThemeData with all button themes created');

  return Theme(
    data: themeData,
    child: Builder(builder: (ctx) {
      final resolvedTheme = Theme.of(ctx);
      print('Theme.of resolved');
      print('  elevatedButtonTheme: ${resolvedTheme.elevatedButtonTheme}');
      print('  textButtonTheme: ${resolvedTheme.textButtonTheme}');
      print('  floatingActionButtonTheme.backgroundColor: ${resolvedTheme.floatingActionButtonTheme.backgroundColor}');

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ButtonTheme(
            data: buttonThemeData,
            child: Text('ButtonTheme applied'),
          ),
          ElevatedButtonTheme(
            data: elevatedButtonThemeData,
            child: ElevatedButton(onPressed: () {}, child: Text('Elevated')),
          ),
          TextButtonTheme(
            data: textButtonThemeData,
            child: TextButton(onPressed: () {}, child: Text('Text')),
          ),
          OutlinedButtonTheme(
            data: outlinedButtonThemeData,
            child: OutlinedButton(onPressed: () {}, child: Text('Outlined')),
          ),
          FilledButtonTheme(
            data: filledButtonThemeData,
            child: FilledButton(onPressed: () {}, child: Text('Filled')),
          ),
          IconButtonTheme(
            data: iconButtonThemeData,
            child: IconButton(onPressed: () {}, icon: Icon(Icons.star)),
          ),
          FloatingActionButtonTheme(
            data: fabThemeData,
            child: FloatingActionButton(onPressed: () {}, child: Icon(Icons.add)),
          ),
          Text('All button theme tests passed'),
        ],
      );
    }),
  );
}
