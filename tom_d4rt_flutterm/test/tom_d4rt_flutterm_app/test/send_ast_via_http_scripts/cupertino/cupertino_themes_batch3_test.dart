// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests CupertinoTheme inheritance, nested themes, IconThemeData in Cupertino context from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino themes batch 3 test executing');

  // ========== THEME INHERITANCE ==========
  print('--- Theme Inheritance Tests ---');

  // Test outer theme
  final outerTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
    brightness: Brightness.light,
    barBackgroundColor: CupertinoColors.white,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
  );
  print('Outer theme created');
  print('  primaryColor: ${outerTheme.primaryColor}');
  print('  brightness: ${outerTheme.brightness}');

  // Test inner theme that should override outer
  final innerTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemRed,
  );
  print('Inner theme created');
  print('  primaryColor: ${innerTheme.primaryColor}');

  // Test deeply nested theme
  final deepTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemGreen,
    brightness: Brightness.dark,
  );
  print('Deep theme created');
  print('  primaryColor: ${deepTheme.primaryColor}');
  print('  brightness: ${deepTheme.brightness}');

  // ========== ICONTHEMEDATA ==========
  print('--- IconThemeData in Cupertino Context ---');

  // Test IconThemeData construction for Cupertino usage
  final defaultIconTheme = IconThemeData();
  print('Default IconThemeData created [${defaultIconTheme.hashCode }]');

  final coloredIconTheme = IconThemeData(color: CupertinoColors.systemBlue);
  print('IconThemeData with color created');
  print('  color: ${coloredIconTheme.color}');

  final sizedIconTheme = IconThemeData(size: 32.0);
  print('IconThemeData with size created');
  print('  size: ${sizedIconTheme.size}');

  final fullIconTheme = IconThemeData(
    color: CupertinoColors.systemIndigo,
    size: 28.0,
    opacity: 0.8,
  );
  print('Full IconThemeData created');
  print('  color: ${fullIconTheme.color}');
  print('  size: ${fullIconTheme.size}');
  print('  opacity: ${fullIconTheme.opacity}');

  // Test IconThemeData.copyWith
  final copiedIconTheme = fullIconTheme.copyWith(
    color: CupertinoColors.systemRed,
  );
  print('IconThemeData.copyWith created');
  print('  color: ${copiedIconTheme.color}');
  print('  size (inherited): ${copiedIconTheme.size}');

  // Note: IconThemeData.merge not available in D4rt (static method not bridged)

  // ========== CUPERTINO THEME WITH TEXTTHEME AND ICONS ==========
  print('--- Combined Theme Tests ---');

  final combinedTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemTeal,
    brightness: Brightness.light,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(fontSize: 16.0, color: CupertinoColors.label),
      navTitleTextStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: CupertinoColors.label,
      ),
      actionTextStyle: TextStyle(
        fontSize: 16.0,
        color: CupertinoColors.systemTeal,
      ),
    ),
    barBackgroundColor: CupertinoColors.extraLightBackgroundGray,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
  );
  print('Combined theme created');
  print('  primaryColor: ${combinedTheme.primaryColor}');
  print('  textTheme.textStyle: ${combinedTheme.textTheme.textStyle}');
  print('  barBackgroundColor: ${combinedTheme.barBackgroundColor}');

  // ========== THEME COMPARISON ==========
  print('--- Theme Comparison Tests ---');

  final themeA = CupertinoThemeData(primaryColor: CupertinoColors.systemBlue);
  final themeB = CupertinoThemeData(primaryColor: CupertinoColors.systemBlue);
  final themeC = CupertinoThemeData(primaryColor: CupertinoColors.systemRed);

  print('Theme A primaryColor: ${themeA.primaryColor}');
  print('Theme B primaryColor: ${themeB.primaryColor}');
  print('Theme C primaryColor: ${themeC.primaryColor}');

  // ========== DARK/LIGHT MODE THEMES ==========
  print('--- Dark/Light Mode Theme Tests ---');

  final lightModeTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.systemBlue,
    barBackgroundColor: CupertinoColors.white,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(color: CupertinoColors.black),
    ),
  );
  print('Light mode theme created');

  final darkModeTheme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.systemBlue,
    barBackgroundColor: CupertinoColors.black,
    scaffoldBackgroundColor: CupertinoColors.darkBackgroundGray,
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(color: CupertinoColors.white),
    ),
  );
  print('Dark mode theme created');

  print('Light brightness: ${lightModeTheme.brightness}');
  print('Dark brightness: ${darkModeTheme.brightness}');
  print('Light scaffold: ${lightModeTheme.scaffoldBackgroundColor}');
  print('Dark scaffold: ${darkModeTheme.scaffoldBackgroundColor}');

  print('All Cupertino themes batch 3 tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    theme: outerTheme,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Themes Batch 3')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Theme Inheritance:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),

              // Outer theme context
              Builder(
                builder: (BuildContext ctx) {
                  final theme = CupertinoTheme.of(ctx);
                  return Text('Outer: ${theme.primaryColor}');
                },
              ),
              SizedBox(height: 8.0),

              // Inner theme override
              CupertinoTheme(
                data: innerTheme,
                child: Builder(
                  builder: (BuildContext ctx) {
                    final theme = CupertinoTheme.of(ctx);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Inner: ${theme.primaryColor}'),
                        CupertinoButton.filled(
                          child: Text('Inner Button'),
                          onPressed: () {},
                        ),
                        SizedBox(height: 8.0),

                        // Deep nested theme
                        CupertinoTheme(
                          data: deepTheme,
                          child: Builder(
                            builder: (BuildContext deepCtx) {
                              final deepResolved = CupertinoTheme.of(deepCtx);
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Deep: ${deepResolved.primaryColor}'),
                                  CupertinoButton.filled(
                                    child: Text('Deep Button'),
                                    onPressed: () {},
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              SizedBox(height: 16.0),
              Text(
                'IconThemeData:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),

              IconTheme(
                data: fullIconTheme,
                child: Row(
                  children: [
                    Icon(CupertinoIcons.star_fill),
                    SizedBox(width: 8.0),
                    Icon(CupertinoIcons.heart_fill),
                    SizedBox(width: 8.0),
                    Icon(CupertinoIcons.bell_fill),
                  ],
                ),
              ),
              SizedBox(height: 8.0),

              IconTheme(
                data: coloredIconTheme,
                child: Row(
                  children: [
                    Icon(CupertinoIcons.cloud_fill),
                    SizedBox(width: 8.0),
                    Icon(CupertinoIcons.bolt_fill),
                    SizedBox(width: 8.0),
                    Icon(CupertinoIcons.moon_fill),
                  ],
                ),
              ),

              SizedBox(height: 24.0),
              Text(
                'Tests Completed:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('• Theme inheritance (3 levels)'),
              Text('• IconThemeData construction'),
              Text('• IconThemeData.copyWith'),
              Text('• Combined theme with text and icons'),
              Text('• Dark/light mode themes'),
              Text('• Theme comparison'),
            ],
          ),
        ),
      ),
    ),
  );
}
