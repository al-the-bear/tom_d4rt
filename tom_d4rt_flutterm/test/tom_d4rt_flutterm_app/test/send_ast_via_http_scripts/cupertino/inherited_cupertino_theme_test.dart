// ignore_for_file: avoid_print
// D4rt test script: Tests InheritedCupertinoTheme from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('InheritedCupertinoTheme test executing');

  // ===== 1. CupertinoTheme wraps InheritedCupertinoTheme internally =====
  print('--- CupertinoTheme (wraps InheritedCupertinoTheme) ---');
  final lightTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.activeBlue,
    scaffoldBackgroundColor: CupertinoColors.white,
  );
  print('  light theme: brightness=${lightTheme.brightness}');
  print('  primaryColor: ${lightTheme.primaryColor}');

  // ===== 2. Dark theme =====
  print('--- Dark theme ---');
  final darkTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.activeOrange,
    scaffoldBackgroundColor: CupertinoColors.black,
  );
  print('  dark theme: brightness=${darkTheme.brightness}');

  // ===== 3. Access theme from context =====
  print('--- Theme.of(context) ---');
  final currentTheme = CupertinoTheme.of(context);
  print('  current brightness: ${currentTheme.brightness}');
  print('  current primaryColor: ${currentTheme.primaryColor}');
  print('  current barBackgroundColor: ${currentTheme.barBackgroundColor}');
  print('  current scaffoldBackgroundColor: ${currentTheme.scaffoldBackgroundColor}');

  // ===== 4. Text theme from inherited theme =====
  print('--- TextThemeData ---');
  final textTheme = currentTheme.textTheme;
  print('  textStyle: ${textTheme.textStyle}');
  print('  navTitleTextStyle: ${textTheme.navTitleTextStyle}');
  print('  navLargeTitleTextStyle: ${textTheme.navLargeTitleTextStyle}');
  print('  tabLabelTextStyle: ${textTheme.tabLabelTextStyle}');
  print('  actionTextStyle: ${textTheme.actionTextStyle}');

  // ===== 5. Custom text theme =====
  print('--- Custom CupertinoTextThemeData ---');
  final customTextTheme = CupertinoTextThemeData(
    primaryColor: CupertinoColors.systemGreen,
  );
  final customTheme = CupertinoThemeData(
    textTheme: customTextTheme,
  );
  print('  custom text theme created with primaryColor override [${customTheme.hashCode }]');

  // ===== 6. Nested themes (theme overrides) =====
  print('--- Nested themes ---');
  final outerContent = CupertinoTheme(
    data: lightTheme,
    child: Column(
      children: [
        Text('Light theme area'),
        CupertinoTheme(
          data: darkTheme,
          child: Container(
            color: CupertinoColors.darkBackgroundGray,
            padding: EdgeInsets.all(8.0),
            child: Text('Dark theme area', style: TextStyle(color: CupertinoColors.white)),
          ),
        ),
      ],
    ),
  );
  print('  nested themes created');

  // ===== 7. Theme with all properties =====
  print('--- Full theme customization ---');
  final fullTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF6366F1),
    primaryContrastingColor: CupertinoColors.white,
    scaffoldBackgroundColor: Color(0xFFF8FAFC),
    barBackgroundColor: Color(0xFFFFFFFF),
    textTheme: CupertinoTextThemeData(
      primaryColor: Color(0xFF6366F1),
    ),
  );
  print('  full theme brightness: ${fullTheme.brightness}');
  print('  full theme primaryColor: ${fullTheme.primaryColor}');
  print('  full theme scaffold: ${fullTheme.scaffoldBackgroundColor}');
  print('  full theme bar: ${fullTheme.barBackgroundColor}');

  // ===== 8. resolveFrom for adaptive colors =====
  print('--- Adaptive colors ---');
  final adaptiveColor = CupertinoColors.systemBlue;
  print('  systemBlue: $adaptiveColor');
  print('  resolved: ${CupertinoDynamicColor.resolve(adaptiveColor, context)}');

  print('InheritedCupertinoTheme test completed');
  return CupertinoApp(
    theme: fullTheme,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('InheritedTheme')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Theme Tests', style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
              SizedBox(height: 12.0),
              Text('Current brightness: ${currentTheme.brightness}'),
              Text('Primary: ${currentTheme.primaryColor}'),
              SizedBox(height: 16.0),
              outerContent,
              SizedBox(height: 16.0),
              CupertinoButton.filled(
                child: Text('Themed Button'),
                onPressed: () {},
              ),
              SizedBox(height: 8.0),
              CupertinoTextField(placeholder: 'Themed TextField'),
            ],
          ),
        ),
      ),
    ),
  );
}
