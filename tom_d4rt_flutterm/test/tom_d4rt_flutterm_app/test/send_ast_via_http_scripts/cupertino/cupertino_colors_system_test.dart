// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests CupertinoColors, CupertinoDynamicColor,
// CupertinoThemeData advanced, CupertinoTextThemeData,
// CupertinoIconThemeData, CupertinoSystemColors, CupertinoSlidingSegmentedControl,
// CupertinoSegmentedControl
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino colors and system test executing');

  // ========== CupertinoColors ==========
  print('--- CupertinoColors Tests ---');
  final colors = {
    'activeBlue': CupertinoColors.activeBlue,
    'activeGreen': CupertinoColors.activeGreen,
    'activeOrange': CupertinoColors.activeOrange,
    'white': CupertinoColors.white,
    'black': CupertinoColors.black,
    'lightBackgroundGray': CupertinoColors.lightBackgroundGray,
    'extraLightBackgroundGray': CupertinoColors.extraLightBackgroundGray,
    'darkBackgroundGray': CupertinoColors.darkBackgroundGray,
    'inactiveGray': CupertinoColors.inactiveGray,
    'destructiveRed': CupertinoColors.destructiveRed,
    'systemBlue': CupertinoColors.systemBlue,
    'systemGreen': CupertinoColors.systemGreen,
    'systemIndigo': CupertinoColors.systemIndigo,
    'systemOrange': CupertinoColors.systemOrange,
    'systemPink': CupertinoColors.systemPink,
    'systemPurple': CupertinoColors.systemPurple,
    'systemRed': CupertinoColors.systemRed,
    'systemTeal': CupertinoColors.systemTeal,
    'systemYellow': CupertinoColors.systemYellow,
  };
  for (final entry in colors.entries) {
    print('  CupertinoColors.${entry.key}: ${entry.value}');
  }

  // ========== CupertinoColors system grays ==========
  print('--- CupertinoColors Grays ---');
  final grays = {
    'systemGrey': CupertinoColors.systemGrey,
    'systemGrey2': CupertinoColors.systemGrey2,
    'systemGrey3': CupertinoColors.systemGrey3,
    'systemGrey4': CupertinoColors.systemGrey4,
    'systemGrey5': CupertinoColors.systemGrey5,
    'systemGrey6': CupertinoColors.systemGrey6,
  };
  for (final entry in grays.entries) {
    print('  CupertinoColors.${entry.key}: ${entry.value}');
  }

  // ========== CupertinoColors semantic ==========
  print('--- CupertinoColors Semantic ---');
  final semantic = {
    'label': CupertinoColors.label,
    'secondaryLabel': CupertinoColors.secondaryLabel,
    'tertiaryLabel': CupertinoColors.tertiaryLabel,
    'quaternaryLabel': CupertinoColors.quaternaryLabel,
    'systemFill': CupertinoColors.systemFill,
    'secondarySystemFill': CupertinoColors.secondarySystemFill,
    'tertiarySystemFill': CupertinoColors.tertiarySystemFill,
    'quaternarySystemFill': CupertinoColors.quaternarySystemFill,
    'placeholderText': CupertinoColors.placeholderText,
    'systemBackground': CupertinoColors.systemBackground,
    'secondarySystemBackground': CupertinoColors.secondarySystemBackground,
    'tertiarySystemBackground': CupertinoColors.tertiarySystemBackground,
    'systemGroupedBackground': CupertinoColors.systemGroupedBackground,
    'secondarySystemGroupedBackground':
        CupertinoColors.secondarySystemGroupedBackground,
    'tertiarySystemGroupedBackground':
        CupertinoColors.tertiarySystemGroupedBackground,
    'separator': CupertinoColors.separator,
    'opaqueSeparator': CupertinoColors.opaqueSeparator,
    'link': CupertinoColors.link,
  };
  for (final entry in semantic.entries) {
    print('  CupertinoColors.${entry.key}: ${entry.value}');
  }

  // ========== CupertinoDynamicColor ==========
  print('--- CupertinoDynamicColor Tests ---');
  final dynamicColor = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF000000),
    darkColor: Color(0xFFFFFFFF),
  );
  print('CupertinoDynamicColor.withBrightness created [${dynamicColor.hashCode }]');

  final dynamicColor2 = CupertinoDynamicColor(
    color: Color(0xFF000000),
    darkColor: Color(0xFFFFFFFF),
    highContrastColor: Color(0xFF000000),
    darkHighContrastColor: Color(0xFFFFFFFF),
    elevatedColor: Color(0xFF222222),
    darkElevatedColor: Color(0xFFDDDDDD),
    highContrastElevatedColor: Color(0xFF111111),
    darkHighContrastElevatedColor: Color(0xFFEEEEEE),
  );
  print('CupertinoDynamicColor full created [${dynamicColor2.hashCode }]');

  // ========== CupertinoThemeData advanced ==========
  print('--- CupertinoThemeData Advanced Tests ---');
  final cupertinoTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.activeBlue,
    primaryContrastingColor: CupertinoColors.white,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
    barBackgroundColor: CupertinoColors.systemBackground,
    applyThemeToAll: true,
    textTheme: CupertinoTextThemeData(
      primaryColor: CupertinoColors.activeBlue,
      textStyle: TextStyle(fontSize: 17, color: CupertinoColors.label),
      actionTextStyle: TextStyle(
        fontSize: 17,
        color: CupertinoColors.activeBlue,
      ),
      tabLabelTextStyle: TextStyle(fontSize: 10),
      navTitleTextStyle: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
      navLargeTitleTextStyle: TextStyle(
        fontSize: 34,
        fontWeight: FontWeight.bold,
      ),
      navActionTextStyle: TextStyle(
        fontSize: 17,
        color: CupertinoColors.activeBlue,
      ),
      pickerTextStyle: TextStyle(fontSize: 21),
      dateTimePickerTextStyle: TextStyle(fontSize: 21),
    ),
  );
  print('CupertinoThemeData created');
  print('  brightness: ${cupertinoTheme.brightness}');
  print('  primaryColor: ${cupertinoTheme.primaryColor}');

  // ========== CupertinoTextThemeData ==========
  print('--- CupertinoTextThemeData Tests ---');
  final textTheme = cupertinoTheme.textTheme;
  print('CupertinoTextThemeData accessed');
  print('  textStyle: ${textTheme.textStyle}');
  print('  actionTextStyle: ${textTheme.actionTextStyle}');
  print('  navTitleTextStyle: ${textTheme.navTitleTextStyle}');

  // ========== CupertinoSlidingSegmentedControl ==========
  print('--- CupertinoSlidingSegmentedControl Tests ---');
  final slidingSegmented = CupertinoSlidingSegmentedControl<int>(
    groupValue: 0,
    onValueChanged: (value) => print('  Sliding segment: $value'),
    children: {
      0: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text('First'),
      ),
      1: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text('Second'),
      ),
      2: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text('Third'),
      ),
    },
    thumbColor: CupertinoColors.white,
    backgroundColor: CupertinoColors.systemGrey5,
    padding: EdgeInsets.all(2),
  );
  print('CupertinoSlidingSegmentedControl created');

  // ========== CupertinoSegmentedControl ==========
  print('--- CupertinoSegmentedControl Tests ---');
  final segmentedControl = CupertinoSegmentedControl<int>(
    groupValue: 0,
    onValueChanged: (value) => print('  Segment: $value'),
    children: {0: Text('One'), 1: Text('Two'), 2: Text('Three')},
    selectedColor: CupertinoColors.activeBlue,
    unselectedColor: CupertinoColors.white,
    borderColor: CupertinoColors.activeBlue,
    pressedColor: CupertinoColors.systemGrey4,
    padding: EdgeInsets.symmetric(horizontal: 16),
  );
  print('CupertinoSegmentedControl created');

  print('All cupertino colors/system tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    theme: cupertinoTheme,
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Colors')),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16),
            slidingSegmented,
            SizedBox(height: 16),
            segmentedControl,
          ],
        ),
      ),
    ),
  );
}
