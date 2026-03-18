// D4rt test script: Tests CupertinoTheme, CupertinoThemeData, CupertinoTextThemeData, CupertinoColors from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino theme test executing');

  // ========== CUPERTINOCOLORS ==========
  print('--- CupertinoColors Tests ---');

  // Test system colors
  final systemBlue = CupertinoColors.systemBlue;
  final systemGreen = CupertinoColors.systemGreen;
  final systemIndigo = CupertinoColors.systemIndigo;
  final systemOrange = CupertinoColors.systemOrange;
  final systemPink = CupertinoColors.systemPink;
  final systemPurple = CupertinoColors.systemPurple;
  final systemRed = CupertinoColors.systemRed;
  final systemTeal = CupertinoColors.systemTeal;
  final systemYellow = CupertinoColors.systemYellow;
  print('System colors accessed [${systemYellow.hashCode }] [${systemTeal.hashCode }] [${systemRed.hashCode }] [${systemPurple.hashCode }] [${systemPink.hashCode }] [${systemOrange.hashCode }] [${systemIndigo.hashCode }] [${systemGreen.hashCode }] [${systemBlue.hashCode }]');

  // Test grey colors
  final grey = CupertinoColors.systemGrey;
  final grey2 = CupertinoColors.systemGrey2;
  final grey3 = CupertinoColors.systemGrey3;
  final grey4 = CupertinoColors.systemGrey4;
  final grey5 = CupertinoColors.systemGrey5;
  final grey6 = CupertinoColors.systemGrey6;
  print('System grey colors accessed [${grey6.hashCode }] [${grey5.hashCode }] [${grey4.hashCode }] [${grey3.hashCode }] [${grey2.hashCode }] [${grey.hashCode }]');

  // Test label colors
  final label = CupertinoColors.label;
  final secondaryLabel = CupertinoColors.secondaryLabel;
  final tertiaryLabel = CupertinoColors.tertiaryLabel;
  final quaternaryLabel = CupertinoColors.quaternaryLabel;
  print('Label colors accessed [${quaternaryLabel.hashCode }] [${tertiaryLabel.hashCode }] [${secondaryLabel.hashCode }] [${label.hashCode }]');

  // Test fill colors
  final systemFill = CupertinoColors.systemFill;
  final secondarySystemFill = CupertinoColors.secondarySystemFill;
  final tertiarySystemFill = CupertinoColors.tertiarySystemFill;
  final quaternarySystemFill = CupertinoColors.quaternarySystemFill;
  print('System fill colors accessed [${quaternarySystemFill.hashCode }] [${tertiarySystemFill.hashCode }] [${secondarySystemFill.hashCode }] [${systemFill.hashCode }]');

  // Test background colors
  final systemBackground = CupertinoColors.systemBackground;
  final secondaryBackground = CupertinoColors.secondarySystemBackground;
  final tertiaryBackground = CupertinoColors.tertiarySystemBackground;
  print('System background colors accessed [${tertiaryBackground.hashCode }] [${secondaryBackground.hashCode }] [${systemBackground.hashCode }]');

  // Test grouped background colors
  final groupedBackground = CupertinoColors.systemGroupedBackground;
  final secondaryGroupedBg = CupertinoColors.secondarySystemGroupedBackground;
  final tertiaryGroupedBg = CupertinoColors.tertiarySystemGroupedBackground;
  print('System grouped background colors accessed [${tertiaryGroupedBg.hashCode }] [${secondaryGroupedBg.hashCode }] [${groupedBackground.hashCode }]');

  // Test separator colors
  final separator = CupertinoColors.separator;
  final opaqueSeparator = CupertinoColors.opaqueSeparator;
  print('Separator colors accessed [${opaqueSeparator.hashCode }] [${separator.hashCode }]');

  // Test link color
  final link = CupertinoColors.link;
  print('Link color accessed [${link.hashCode }]');

  // Test basic colors
  final white = CupertinoColors.white;
  final black = CupertinoColors.black;
  final lightBackgroundGray = CupertinoColors.lightBackgroundGray;
  final extraLightBackgroundGray = CupertinoColors.extraLightBackgroundGray;
  final darkBackgroundGray = CupertinoColors.darkBackgroundGray;
  final inactiveGray = CupertinoColors.inactiveGray;
  final destructiveRed = CupertinoColors.destructiveRed;
  final activeBlue = CupertinoColors.activeBlue;
  final activeGreen = CupertinoColors.activeGreen;
  final activeOrange = CupertinoColors.activeOrange;
  print('Basic colors accessed [${activeOrange.hashCode }] [${activeGreen.hashCode }] [${activeBlue.hashCode }] [${destructiveRed.hashCode }] [${inactiveGray.hashCode }] [${darkBackgroundGray.hashCode }] [${extraLightBackgroundGray.hashCode }] [${lightBackgroundGray.hashCode }] [${black.hashCode }] [${white.hashCode }]');

  // ========== CUPERTINODYNAMICCOLOR ==========
  print('--- CupertinoDynamicColor Tests ---');

  // Test basic CupertinoDynamicColor
  final dynamicColor = CupertinoDynamicColor.withBrightness(
    color: CupertinoColors.black,
    darkColor: CupertinoColors.white,
  );
  print('CupertinoDynamicColor.withBrightness created [${dynamicColor.hashCode }]');

  // Test CupertinoDynamicColor full constructor
  final fullDynamicColor = CupertinoDynamicColor(
    color: Color(0xFF000000),
    darkColor: Color(0xFFFFFFFF),
    highContrastColor: Color(0xFF333333),
    darkHighContrastColor: Color(0xFFCCCCCC),
    elevatedColor: Color(0xFF111111),
    darkElevatedColor: Color(0xFFEEEEEE),
    highContrastElevatedColor: Color(0xFF222222),
    darkHighContrastElevatedColor: Color(0xFFDDDDDD),
  );
  print('CupertinoDynamicColor full constructor created [${fullDynamicColor.hashCode }]');

  // Test CupertinoDynamicColor.withBrightnessAndContrast
  final contrastDynamicColor = CupertinoDynamicColor.withBrightnessAndContrast(
    color: Color(0xFF007AFF),
    darkColor: Color(0xFF0A84FF),
    highContrastColor: Color(0xFF0040DD),
    darkHighContrastColor: Color(0xFF409CFF),
  );
  print('CupertinoDynamicColor.withBrightnessAndContrast created [${contrastDynamicColor.hashCode }]');

  // Test CupertinoDynamicColor.resolve
  // Note: resolve requires context
  print('CupertinoDynamicColor.resolve concept noted');

  // ========== CUPERTINOTEXTTHEMEDATA ==========
  print('--- CupertinoTextThemeData Tests ---');

  // Test basic CupertinoTextThemeData
  final basicTextTheme = CupertinoTextThemeData();
  print('Basic CupertinoTextThemeData created');

  // Test CupertinoTextThemeData with primaryColor
  final primaryColorTextTheme = CupertinoTextThemeData(
    primaryColor: CupertinoColors.systemBlue,
  );
  print('CupertinoTextThemeData with primaryColor created [${primaryColorTextTheme.hashCode }]');

  // Test CupertinoTextThemeData with textStyle
  final customTextTheme = CupertinoTextThemeData(
    textStyle: TextStyle(fontSize: 16.0, color: CupertinoColors.label),
  );
  print('CupertinoTextThemeData with textStyle created [${customTextTheme.hashCode }]');

  // Test CupertinoTextThemeData with actionTextStyle
  final actionTextTheme = CupertinoTextThemeData(
    actionTextStyle: TextStyle(
      fontSize: 17.0,
      color: CupertinoColors.activeBlue,
    ),
  );
  print('CupertinoTextThemeData with actionTextStyle created [${actionTextTheme.hashCode }]');

  // Test CupertinoTextThemeData with tabLabelTextStyle
  final tabLabelTextTheme = CupertinoTextThemeData(
    tabLabelTextStyle: TextStyle(
      fontSize: 10.0,
      color: CupertinoColors.inactiveGray,
    ),
  );
  print('CupertinoTextThemeData with tabLabelTextStyle created [${tabLabelTextTheme.hashCode }]');

  // Test CupertinoTextThemeData with navTitleTextStyle
  final navTitleTextTheme = CupertinoTextThemeData(
    navTitleTextStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w600),
  );
  print('CupertinoTextThemeData with navTitleTextStyle created [${navTitleTextTheme.hashCode }]');

  // Test CupertinoTextThemeData with navLargeTitleTextStyle
  final navLargeTitleTextTheme = CupertinoTextThemeData(
    navLargeTitleTextStyle: TextStyle(
      fontSize: 34.0,
      fontWeight: FontWeight.bold,
    ),
  );
  print('CupertinoTextThemeData with navLargeTitleTextStyle created [${navLargeTitleTextTheme.hashCode }]');

  // Test CupertinoTextThemeData with navActionTextStyle
  final navActionTextTheme = CupertinoTextThemeData(
    navActionTextStyle: TextStyle(
      fontSize: 17.0,
      color: CupertinoColors.activeBlue,
    ),
  );
  print('CupertinoTextThemeData with navActionTextStyle created [${navActionTextTheme.hashCode }]');

  // Test CupertinoTextThemeData with pickerTextStyle
  final pickerTextTheme = CupertinoTextThemeData(
    pickerTextStyle: TextStyle(fontSize: 21.0),
  );
  print('CupertinoTextThemeData with pickerTextStyle created [${pickerTextTheme.hashCode }]');

  // Test CupertinoTextThemeData with dateTimePickerTextStyle
  final datePickerTextTheme = CupertinoTextThemeData(
    dateTimePickerTextStyle: TextStyle(fontSize: 21.0),
  );
  print('CupertinoTextThemeData with dateTimePickerTextStyle created [${datePickerTextTheme.hashCode }]');

  // Test CupertinoTextThemeData copyWith
  final copiedTextTheme = basicTextTheme.copyWith(
    primaryColor: CupertinoColors.systemPurple,
  );
  print('CupertinoTextThemeData copyWith created [${copiedTextTheme.hashCode }]');

  // ========== CUPERTINOTHEMEDATA ==========
  print('--- CupertinoThemeData Tests ---');

  // Test basic CupertinoThemeData
  final basicThemeData = CupertinoThemeData();
  print('Basic CupertinoThemeData created');

  // Test CupertinoThemeData with brightness
  final lightThemeData = CupertinoThemeData(brightness: Brightness.light);
  print('CupertinoThemeData with brightness: light created [${lightThemeData.hashCode }]');

  final darkThemeData = CupertinoThemeData(brightness: Brightness.dark);
  print('CupertinoThemeData with brightness: dark created [${darkThemeData.hashCode }]');

  // Test CupertinoThemeData with primaryColor
  final primaryColorThemeData = CupertinoThemeData(
    primaryColor: CupertinoColors.systemPurple,
  );
  print('CupertinoThemeData with primaryColor created [${primaryColorThemeData.hashCode }]');

  // Test CupertinoThemeData with primaryContrastingColor
  final contrastThemeData = CupertinoThemeData(
    primaryContrastingColor: CupertinoColors.white,
  );
  print('CupertinoThemeData with primaryContrastingColor created [${contrastThemeData.hashCode }]');

  // Test CupertinoThemeData with textTheme
  final textThemeData = CupertinoThemeData(
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(fontFamily: 'SF Pro'),
    ),
  );
  print('CupertinoThemeData with textTheme created [${textThemeData.hashCode }]');

  // Test CupertinoThemeData with barBackgroundColor
  final barBgThemeData = CupertinoThemeData(
    barBackgroundColor: CupertinoColors.systemGrey6,
  );
  print('CupertinoThemeData with barBackgroundColor created [${barBgThemeData.hashCode }]');

  // Test CupertinoThemeData with scaffoldBackgroundColor
  final scaffoldBgThemeData = CupertinoThemeData(
    scaffoldBackgroundColor: CupertinoColors.systemGroupedBackground,
  );
  print('CupertinoThemeData with scaffoldBackgroundColor created [${scaffoldBgThemeData.hashCode }]');

  // Test CupertinoThemeData with applyThemeToAll
  final applyAllThemeData = CupertinoThemeData(
    applyThemeToAll: true,
    primaryColor: CupertinoColors.systemOrange,
  );
  print('CupertinoThemeData with applyThemeToAll created [${applyAllThemeData.hashCode }]');

  // Test CupertinoThemeData copyWith
  final copiedThemeData = basicThemeData.copyWith(
    primaryColor: CupertinoColors.systemTeal,
    brightness: Brightness.dark,
  );
  print('CupertinoThemeData copyWith created [${copiedThemeData.hashCode }]');

  // Test CupertinoThemeData with all properties
  final fullThemeData = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.systemBlue,
    primaryContrastingColor: CupertinoColors.white,
    textTheme: CupertinoTextThemeData(),
    barBackgroundColor: CupertinoColors.systemBackground,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
    applyThemeToAll: false,
  );
  print('CupertinoThemeData with all properties created [${fullThemeData.hashCode }]');

  // ========== CUPERTINOTHEME WIDGET ==========
  print('--- CupertinoTheme Widget Tests ---');

  // Test basic CupertinoTheme
  final basicTheme = CupertinoTheme(
    data: CupertinoThemeData(primaryColor: CupertinoColors.systemRed),
    child: Text('Themed content'),
  );
  print('Basic CupertinoTheme widget created [${basicTheme.hashCode }]');

  // Test CupertinoTheme with dark mode
  final darkTheme = CupertinoTheme(
    data: CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: CupertinoColors.systemIndigo,
    ),
    child: Text('Dark themed content'),
  );
  print('CupertinoTheme with dark mode created [${darkTheme.hashCode }]');

  // Test CupertinoTheme with full customization
  final fullTheme = CupertinoTheme(
    data: CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: CupertinoColors.systemOrange,
      primaryContrastingColor: CupertinoColors.black,
      barBackgroundColor: CupertinoColors.systemGrey5.withValues(alpha: 0.8),
      scaffoldBackgroundColor: CupertinoColors.extraLightBackgroundGray,
      textTheme: CupertinoTextThemeData(
        primaryColor: CupertinoColors.systemOrange,
      ),
    ),
    child: Text('Fully themed content'),
  );
  print('CupertinoTheme with full customization created [${fullTheme.hashCode }]');

  // Test CupertinoTheme.of
  // Note: CupertinoTheme.of(context) requires actual widget tree
  print('CupertinoTheme.of concept noted');

  // Test CupertinoTheme.brightnessOf
  // Note: CupertinoTheme.brightnessOf(context) requires actual widget tree
  print('CupertinoTheme.brightnessOf concept noted');

  print('Cupertino theme test completed');

  // Return a visual representation
  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    theme: CupertinoThemeData(primaryColor: CupertinoColors.systemIndigo),
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Theme Tests')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'System Colors:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    color: CupertinoColors.systemBlue,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: CupertinoColors.systemGreen,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: CupertinoColors.systemIndigo,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: CupertinoColors.systemOrange,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: CupertinoColors.systemPink,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: CupertinoColors.systemPurple,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: CupertinoColors.systemRed,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: CupertinoColors.systemTeal,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: CupertinoColors.systemYellow,
                  ),
                ],
              ),

              SizedBox(height: 24.0),
              Text(
                'Grey Colors:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    color: CupertinoColors.systemGrey,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: CupertinoColors.systemGrey2,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: CupertinoColors.systemGrey3,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: CupertinoColors.systemGrey4,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: CupertinoColors.systemGrey5,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    color: CupertinoColors.systemGrey6,
                  ),
                ],
              ),

              SizedBox(height: 24.0),
              Text(
                'Themed Buttons:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              CupertinoTheme(
                data: CupertinoThemeData(
                  primaryColor: CupertinoColors.systemRed,
                ),
                child: CupertinoButton.filled(
                  child: Text('Red Theme'),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 8.0),
              CupertinoTheme(
                data: CupertinoThemeData(
                  primaryColor: CupertinoColors.systemGreen,
                ),
                child: CupertinoButton.filled(
                  child: Text('Green Theme'),
                  onPressed: () {},
                ),
              ),
              SizedBox(height: 8.0),
              CupertinoTheme(
                data: CupertinoThemeData(
                  primaryColor: CupertinoColors.systemPurple,
                ),
                child: CupertinoButton.filled(
                  child: Text('Purple Theme'),
                  onPressed: () {},
                ),
              ),

              SizedBox(height: 24.0),
              Text(
                'Tests Completed:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('• CupertinoColors'),
              Text('• CupertinoDynamicColor'),
              Text('• CupertinoTextThemeData'),
              Text('• CupertinoThemeData'),
              Text('• CupertinoTheme widget'),
            ],
          ),
        ),
      ),
    ),
  );
}
