// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Theme, ThemeData, ColorScheme, TextTheme from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Theme widgets test executing');

  // ========== COLORSCHEME ==========
  print('--- ColorScheme Tests ---');

  // Test ColorScheme.light
  final lightColorScheme = ColorScheme.light(
    primary: Colors.blue,
    onPrimary: Colors.white,
    secondary: Colors.orange,
    onSecondary: Colors.black,
  );
  print('ColorScheme.light created');
  print('  primary: ${lightColorScheme.primary}');
  print('  secondary: ${lightColorScheme.secondary}');

  // Test ColorScheme.dark
  final darkColorScheme = ColorScheme.dark(
    primary: Colors.purple,
    onPrimary: Colors.white,
    secondary: Colors.teal,
    onSecondary: Colors.white,
  );
  print('ColorScheme.dark created');

  // Test ColorScheme.fromSeed
  final seedColorScheme = ColorScheme.fromSeed(seedColor: Colors.green);
  print('ColorScheme.fromSeed created');
  print('  primary: ${seedColorScheme.primary}');

  // Test ColorScheme.fromSeed dark
  final seedDarkColorScheme = ColorScheme.fromSeed(
    seedColor: Colors.blue,
    brightness: Brightness.dark,
  );
  print('ColorScheme.fromSeed (dark) created');

  // Test ColorScheme.highContrastLight
  final highContrastLight = ColorScheme.highContrastLight();
  print('ColorScheme.highContrastLight created');

  // Test ColorScheme.highContrastDark
  final highContrastDark = ColorScheme.highContrastDark();
  print('ColorScheme.highContrastDark created');

  // Test ColorScheme copyWith
  final copiedColorScheme = lightColorScheme.copyWith(
    primary: Colors.red,
    error: Colors.pink,
  );
  print('ColorScheme.copyWith created');
  print('  new primary: ${copiedColorScheme.primary}');

  // Test full ColorScheme constructor
  final fullColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Colors.indigo,
    onPrimary: Colors.white,
    primaryContainer: Colors.indigo.shade100,
    onPrimaryContainer: Colors.indigo.shade900,
    secondary: Colors.amber,
    onSecondary: Colors.black,
    secondaryContainer: Colors.amber.shade100,
    onSecondaryContainer: Colors.amber.shade900,
    tertiary: Colors.teal,
    onTertiary: Colors.white,
    tertiaryContainer: Colors.teal.shade100,
    onTertiaryContainer: Colors.teal.shade900,
    error: Colors.red,
    onError: Colors.white,
    errorContainer: Colors.red.shade100,
    onErrorContainer: Colors.red.shade900,
    surface: Colors.white,
    onSurface: Colors.black,
    surfaceContainerHighest: Colors.grey.shade200,
    onSurfaceVariant: Colors.grey.shade700,
    outline: Colors.grey,
    outlineVariant: Colors.grey.shade300,
    shadow: Colors.black,
    scrim: Colors.black54,
    inverseSurface: Colors.grey.shade900,
    onInverseSurface: Colors.white,
    inversePrimary: Colors.indigo.shade200,
  );
  print('Full ColorScheme constructor created');

  // ========== TEXTTHEME ==========
  print('--- TextTheme Tests ---');

  // Test basic TextTheme
  final basicTextTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 57.0, fontWeight: FontWeight.w400),
    displayMedium: TextStyle(fontSize: 45.0, fontWeight: FontWeight.w400),
    displaySmall: TextStyle(fontSize: 36.0, fontWeight: FontWeight.w400),
    headlineLarge: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w400),
    headlineMedium: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w400),
    headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w400),
    titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w500),
    titleMedium: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
    ),
    titleSmall: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    bodyLarge: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.5,
    ),
    bodyMedium: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    bodySmall: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
    labelLarge: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    labelMedium: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
    labelSmall: TextStyle(
      fontSize: 11.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
  );
  print('Basic TextTheme created');
  print('  displayLarge: ${basicTextTheme.displayLarge?.fontSize}');
  print('  bodyMedium: ${basicTextTheme.bodyMedium?.fontSize}');

  // Test TextTheme copyWith
  final copiedTextTheme = basicTextTheme.copyWith(
    displayLarge: TextStyle(
      fontSize: 60.0,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    ),
  );
  print('TextTheme.copyWith created');

  // Test TextTheme apply
  final appliedTextTheme = basicTextTheme.apply(
    fontFamily: 'Roboto',
    bodyColor: Colors.grey.shade800,
    displayColor: Colors.grey.shade900,
  );
  print('TextTheme.apply created');

  // Test TextTheme merge
  final mergedTextTheme = basicTextTheme.merge(
    TextTheme(bodyLarge: TextStyle(color: Colors.red)),
  );
  print('TextTheme.merge created');

  // ========== THEMEDATA ==========
  print('--- ThemeData Tests ---');

  // Test ThemeData with colorScheme
  final colorSchemeTheme = ThemeData(
    colorScheme: seedColorScheme,
    useMaterial3: true,
  );
  print('ThemeData with colorScheme created');

  // Test ThemeData.light
  final lightTheme = ThemeData.light(useMaterial3: true);
  print('ThemeData.light created');

  // Test ThemeData.dark
  final darkTheme = ThemeData.dark(useMaterial3: true);
  print('ThemeData.dark created');

  // Test ThemeData with colorSchemeSeed
  final seedTheme = ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true);
  print('ThemeData with colorSchemeSeed created');

  // Test ThemeData with brightness
  final brightTheme = ThemeData(
    brightness: Brightness.dark,
    colorSchemeSeed: Colors.purple,
    useMaterial3: true,
  );
  print('ThemeData with brightness created');

  // Test ThemeData with textTheme
  final textThemeTheme = ThemeData(
    textTheme: basicTextTheme,
    useMaterial3: true,
  );
  print('ThemeData with textTheme created');

  // Test ThemeData with primaryColor
  final primaryColorTheme = ThemeData(
    primaryColor: Colors.indigo,
    useMaterial3: true,
  );
  print('ThemeData with primaryColor created');

  // Test ThemeData with scaffoldBackgroundColor
  final scaffoldBgTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey.shade100,
    useMaterial3: true,
  );
  print('ThemeData with scaffoldBackgroundColor created');

  // Test ThemeData with appBarTheme
  final appBarThemeData = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.purple,
      foregroundColor: Colors.white,
      elevation: 4.0,
      centerTitle: true,
      titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
    ),
    useMaterial3: true,
  );
  print('ThemeData with appBarTheme created');

  // Test ThemeData with elevatedButtonTheme
  final buttonThemeData = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      ),
    ),
    useMaterial3: true,
  );
  print('ThemeData with elevatedButtonTheme created');

  // Test ThemeData with cardTheme
  final cardThemeData = ThemeData(
    cardTheme: CardThemeData(
      color: Colors.blue.shade50,
      elevation: 8.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
    ),
    useMaterial3: true,
  );
  print('ThemeData with cardTheme created');

  // Test ThemeData with inputDecorationTheme
  final inputThemeData = ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      filled: true,
      fillColor: Colors.grey.shade100,
      labelStyle: TextStyle(color: Colors.blue),
    ),
    useMaterial3: true,
  );
  print('ThemeData with inputDecorationTheme created');

  // Test ThemeData with iconTheme
  final iconThemeData = ThemeData(
    iconTheme: IconThemeData(color: Colors.orange, size: 28.0),
    useMaterial3: true,
  );
  print('ThemeData with iconTheme created');

  // Test ThemeData with dividerTheme
  final dividerThemeData = ThemeData(
    dividerTheme: DividerThemeData(
      color: Colors.red,
      thickness: 2.0,
      indent: 16.0,
      endIndent: 16.0,
    ),
    useMaterial3: true,
  );
  print('ThemeData with dividerTheme created');

  // Test ThemeData with floatingActionButtonTheme
  final fabThemeData = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.pink,
      foregroundColor: Colors.white,
      elevation: 12.0,
      shape: CircleBorder(),
    ),
    useMaterial3: true,
  );
  print('ThemeData with floatingActionButtonTheme created');

  // Test ThemeData copyWith
  final copiedTheme = lightTheme.copyWith(
    colorScheme: lightTheme.colorScheme.copyWith(primary: Colors.red),
  );
  print('ThemeData.copyWith created');

  // ========== THEME WIDGET ==========
  print('--- Theme Widget Tests ---');

  // Test Theme widget
  final themedWidget = Theme(
    data: seedTheme,
    child: Card(
      child: Padding(padding: EdgeInsets.all(16.0), child: Text('Themed Card')),
    ),
  );
  print('Theme widget created');

  // Test Theme.of
  final themeOfExample = Builder(
    builder: (BuildContext context) {
      final theme = Theme.of(context);
      print('Theme.of: primary=${theme.colorScheme.primary}');
      return Text(
        'Using Theme.of',
        style: TextStyle(color: theme.colorScheme.primary),
      );
    },
  );
  print('Theme.of example created');

  print('Theme widgets test completed');

  return Theme(
    data: ThemeData(colorSchemeSeed: Colors.blue, useMaterial3: true),
    child: SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Theme Widgets Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'ColorScheme Examples:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Container(width: 40, height: 40, color: lightColorScheme.primary),
              SizedBox(width: 4),
              Container(
                width: 40,
                height: 40,
                color: lightColorScheme.secondary,
              ),
              SizedBox(width: 4),
              Container(width: 40, height: 40, color: seedColorScheme.primary),
              SizedBox(width: 4),
              Container(
                width: 40,
                height: 40,
                color: seedColorScheme.secondary,
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            'Light scheme: blue primary, orange secondary',
            style: TextStyle(fontSize: 12),
          ),
          Text('Seed scheme from green', style: TextStyle(fontSize: 12)),

          SizedBox(height: 24.0),
          Text(
            'TextTheme Styles:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('Display Large', style: basicTextTheme.displayLarge),
          Text('Headline Medium', style: basicTextTheme.headlineMedium),
          Text('Title Large', style: basicTextTheme.titleLarge),
          Text('Body Medium', style: basicTextTheme.bodyMedium),
          Text('Label Small', style: basicTextTheme.labelSmall),

          SizedBox(height: 24.0),
          Text(
            'ThemeData Examples:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),

          // Themed Card
          Theme(
            data: cardThemeData,
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('Card with custom CardTheme'),
              ),
            ),
          ),
          SizedBox(height: 8.0),

          // Themed Button
          Theme(
            data: buttonThemeData,
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Themed Button'),
            ),
          ),
          SizedBox(height: 8.0),

          // Themed TextField
          Theme(
            data: inputThemeData,
            child: TextField(
              decoration: InputDecoration(labelText: 'Themed Input'),
            ),
          ),
          SizedBox(height: 16.0),

          // Dark theme example
          Theme(
            data: darkTheme,
            child: Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: darkTheme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dark Theme Preview',
                    style: TextStyle(
                      color: darkTheme.colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'This uses ThemeData.dark()',
                    style: TextStyle(color: darkTheme.colorScheme.onSurface),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 16.0),
          themeOfExample,
        ],
      ),
    ),
  );
}
