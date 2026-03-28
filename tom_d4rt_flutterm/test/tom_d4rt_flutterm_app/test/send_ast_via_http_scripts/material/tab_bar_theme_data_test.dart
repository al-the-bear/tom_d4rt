// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TabBarThemeData from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TabBarThemeData test executing');
  print('=' * 50);

  // TabBarThemeData overview
  print('TabBarThemeData overview:');
  print('  - Theme data for TabBar');
  print('  - Customizes tab appearance');
  print('  - Used with TabBarTheme');

  // Test default constructor
  print('\nTest default constructor:');
  final theme1 = TabBarThemeData();
  print('  Created: ${theme1.runtimeType}');
  print('  Indicator: ${theme1.indicator}');
  print('  IndicatorSize: ${theme1.indicatorSize}');

  // Test with indicator
  print('\nTest with indicator:');
  final theme2 = TabBarThemeData(
    indicator: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.blue, width: 2)),
    ),
    indicatorSize: TabBarIndicatorSize.tab,
  );
  print('  Indicator: ${theme2.indicator}');
  print('  IndicatorSize: ${theme2.indicatorSize}');

  // Test label styling
  print('\nTest label styling:');
  final theme3 = TabBarThemeData(
    labelColor: Colors.blue,
    unselectedLabelColor: Colors.grey,
    labelStyle: TextStyle(fontWeight: FontWeight.bold),
    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
    labelPadding: EdgeInsets.symmetric(horizontal: 16),
  );
  print('  LabelColor: ${theme3.labelColor}');
  print('  UnselectedLabelColor: ${theme3.unselectedLabelColor}');
  print('  LabelPadding: ${theme3.labelPadding}');

  // Test overlay colors
  print('\nTest overlay colors:');
  final theme4 = TabBarThemeData(
    overlayColor: WidgetStateProperty.all(Colors.blue.withAlpha(25)),
    splashFactory: InkRipple.splashFactory,
  );
  print('  Has overlayColor: ${theme4.overlayColor != null}');
  print('  SplashFactory: ${theme4.splashFactory}');

  // Test tab alignment
  print('\nTest tab alignment:');
  final theme5 = TabBarThemeData(
    tabAlignment: TabAlignment.start,
  );
  print('  TabAlignment: ${theme5.tabAlignment}');

  // TabBarIndicatorSize enum
  print('\nTabBarIndicatorSize values:');
  for (final size in TabBarIndicatorSize.values) {
    print('  - ${size.name}');
  }

  // Test copyWith
  print('\nTest copyWith:');
  final copied = theme1.copyWith(
    labelColor: Colors.red,
  );
  print('  Original labelColor: ${theme1.labelColor}');
  print('  Copied labelColor: ${copied.labelColor}');

  // Test lerp
  print('\nTest lerp:');
  final lerped = TabBarThemeData.lerp(theme1, theme3, 0.5);
  print('  Lerped: ${lerped.runtimeType}');

  print('\n' + '=' * 50);
  print('TabBarThemeData test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TabBarThemeData Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: ThemeData class'),
      Text('Purpose: TabBar theming'),
    ],
  );
}
