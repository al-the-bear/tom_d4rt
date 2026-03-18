// D4rt test script: Tests CupertinoColors extended, CupertinoTheme,
// CupertinoThemeData, CupTextThemeData, CupertinoIconThemeData
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino theming test executing');

  // ========== CupertinoColors extended palette ==========
  print('--- CupertinoColors Tests ---');
  final colors = <String, CupertinoDynamicColor>{
    'systemRed': CupertinoColors.systemRed,
    'systemGreen': CupertinoColors.systemGreen,
    'systemBlue': CupertinoColors.systemBlue,
    'systemOrange': CupertinoColors.systemOrange,
    'systemYellow': CupertinoColors.systemYellow,
    'systemPink': CupertinoColors.systemPink,
    'systemPurple': CupertinoColors.systemPurple,
    'systemTeal': CupertinoColors.systemTeal,
    'systemIndigo': CupertinoColors.systemIndigo,
  };
  for (final entry in colors.entries) {
    print('CupertinoColors.${entry.key}: ${entry.value}');
  }

  final greys = <String, CupertinoDynamicColor>{
    'systemGrey': CupertinoColors.systemGrey,
    'systemGrey2': CupertinoColors.systemGrey2,
    'systemGrey3': CupertinoColors.systemGrey3,
    'systemGrey4': CupertinoColors.systemGrey4,
    'systemGrey5': CupertinoColors.systemGrey5,
    'systemGrey6': CupertinoColors.systemGrey6,
  };
  for (final entry in greys.entries) {
    print('CupertinoColors.${entry.key}: ${entry.value}');
  }

  // ========== CupertinoThemeData ==========
  print('--- CupertinoThemeData Tests ---');
  final themeData = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.activeBlue,
    primaryContrastingColor: CupertinoColors.white,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
    barBackgroundColor: CupertinoColors.systemBackground,
    textTheme: CupertinoTextThemeData(
      primaryColor: CupertinoColors.activeBlue,
      textStyle: TextStyle(fontSize: 16.0, color: CupertinoColors.label),
      navTitleTextStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
      navLargeTitleTextStyle: TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.bold,
      ),
      tabLabelTextStyle: TextStyle(fontSize: 10.0),
      actionTextStyle: TextStyle(
        fontSize: 17.0,
        color: CupertinoColors.activeBlue,
      ),
    ),
  );
  print('CupertinoThemeData created');
  print('  brightness: ${themeData.brightness}');
  print('  primaryColor: ${themeData.primaryColor}');

  // ========== CupertinoTextThemeData ==========
  print('--- CupertinoTextThemeData Tests ---');
  final textTheme = CupertinoTextThemeData(
    primaryColor: CupertinoColors.activeBlue,
  );
  print('CupertinoTextThemeData created');

  // ========== CupertinoTheme widget ==========
  print('--- CupertinoTheme widget Tests ---');
  final themeWidget = CupertinoTheme(data: themeData, child: Text('Themed'));
  print('CupertinoTheme widget created');

  // ========== CupertinoIconThemeData ==========
  print('--- CupertinoIconThemeData Tests ---');
  final iconTheme = IconThemeData(
    color: CupertinoColors.activeBlue,
    size: 24.0,
    opacity: 1.0,
  );
  print('IconThemeData for Cupertino: size=${iconTheme.size}');

  print('All cupertino theming tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    theme: themeData,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Theme Test')),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'System Colors:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                children: [
                  for (final entry in colors.entries)
                    Container(width: 30, height: 30, color: entry.value),
                ],
              ),
              SizedBox(height: 16.0),
              Text(
                'Grey Scale:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                children: [
                  for (final entry in greys.entries)
                    Container(width: 30, height: 30, color: entry.value),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
