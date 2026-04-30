// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Cupertino class overview from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino class overview test executing');

  // ========== CupertinoApp ==========
  print('--- CupertinoApp ---');
  final app = CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Test'),
      ),
      child: Center(child: Text('Hello')),
    ),
  );
  print('  CupertinoApp created');
  print('  type: ${app.runtimeType}');

  // ========== CupertinoThemeData ==========
  print('--- CupertinoThemeData ---');
  final theme = CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.activeBlue,
    scaffoldBackgroundColor: CupertinoColors.black,
    barBackgroundColor: CupertinoColors.darkBackgroundGray,
  );
  print('  brightness: ${theme.brightness}');
  print('  primaryColor: ${theme.primaryColor}');
  print('  scaffoldBackgroundColor: ${theme.scaffoldBackgroundColor}');

  // ========== CupertinoTextThemeData ==========
  print('--- CupertinoTextThemeData ---');
  final textTheme = CupertinoTextThemeData(
    primaryColor: CupertinoColors.activeBlue,
  );
  print('  textStyle: ${textTheme.textStyle}');
  print('  navTitleTextStyle: ${textTheme.navTitleTextStyle}');
  print('  navLargeTitleTextStyle: ${textTheme.navLargeTitleTextStyle}');

  // ========== CupertinoColors ==========
  print('--- CupertinoColors ---');
  final colors = <(String, Color)>[
    ('activeBlue', CupertinoColors.activeBlue),
    ('activeGreen', CupertinoColors.activeGreen),
    ('activeOrange', CupertinoColors.activeOrange),
    ('white', CupertinoColors.white),
    ('black', CupertinoColors.black),
    ('lightBackgroundGray', CupertinoColors.lightBackgroundGray),
    ('darkBackgroundGray', CupertinoColors.darkBackgroundGray),
    ('systemRed', CupertinoColors.systemRed),
    ('systemGreen', CupertinoColors.systemGreen),
    ('systemBlue', CupertinoColors.systemBlue),
    ('systemYellow', CupertinoColors.systemYellow),
    ('systemPurple', CupertinoColors.systemPurple),
    ('systemPink', CupertinoColors.systemPink),
    ('systemGrey', CupertinoColors.systemGrey),
  ];
  for (final c in colors) {
    print('  ${c.$1}: ${c.$2}');
  }

  // ========== CupertinoIcons ==========
  print('--- CupertinoIcons ---');
  final icons = <(String, IconData)>[
    ('back', CupertinoIcons.back),
    ('forward', CupertinoIcons.forward),
    ('add', CupertinoIcons.add),
    ('search', CupertinoIcons.search),
    ('settings', CupertinoIcons.settings),
    ('heart', CupertinoIcons.heart),
    ('heartFill', CupertinoIcons.heart_fill),
    ('home', CupertinoIcons.home),
    ('trash', CupertinoIcons.trash),
    ('gear', CupertinoIcons.gear),
  ];
  for (final i in icons) {
    print('  ${i.$1}: codePoint=${i.$2.codePoint}');
  }

  print('Cupertino class overview test completed');
  return CupertinoApp(
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino Class Overview'),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CupertinoThemeData', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              Text('  brightness: ${theme.brightness}'),
              Text('  primaryColor: ${theme.primaryColor}'),
              SizedBox(height: 12.0),
              Text('CupertinoColors', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              for (final c in colors)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2.0),
                  child: Row(children: [
                    Container(width: 24.0, height: 24.0, color: c.$2),
                    SizedBox(width: 8.0),
                    Text(c.$1),
                  ]),
                ),
              SizedBox(height: 12.0),
              Text('CupertinoIcons', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
              Wrap(
                spacing: 12.0,
                runSpacing: 8.0,
                children: [
                  for (final i in icons)
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(i.$2, size: 28.0),
                        Text(i.$1, style: TextStyle(fontSize: 10.0)),
                      ],
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
