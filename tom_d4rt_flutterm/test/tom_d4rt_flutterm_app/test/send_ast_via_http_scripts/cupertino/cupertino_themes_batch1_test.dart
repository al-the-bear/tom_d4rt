// D4rt test script: Tests CupertinoThemeData properties, CupertinoTextThemeData, CupertinoTheme.of from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('Cupertino themes batch 1 test executing');

  // ========== CUPERTINOTHEMEDATA DEEP DIVE ==========
  print('--- CupertinoThemeData Properties Tests ---');

  // Test CupertinoThemeData with primaryColor
  final primaryTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemRed,
  );
  print('CupertinoThemeData with primaryColor created');
  print('  primaryColor: ${primaryTheme.primaryColor}');

  // Test CupertinoThemeData with primaryContrastingColor
  final contrastTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
    primaryContrastingColor: CupertinoColors.white,
  );
  print('CupertinoThemeData with primaryContrastingColor created');
  print('  primaryColor: ${contrastTheme.primaryColor}');
  print('  primaryContrastingColor: ${contrastTheme.primaryContrastingColor}');

  // Test CupertinoThemeData with barBackgroundColor
  final barBgTheme = CupertinoThemeData(
    barBackgroundColor: CupertinoColors.systemGroupedBackground,
  );
  print('CupertinoThemeData with barBackgroundColor created');
  print('  barBackgroundColor: ${barBgTheme.barBackgroundColor}');

  // Test CupertinoThemeData with scaffoldBackgroundColor
  final scaffoldBgTheme = CupertinoThemeData(
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
  );
  print('CupertinoThemeData with scaffoldBackgroundColor created');
  print(
    '  scaffoldBackgroundColor: ${scaffoldBgTheme.scaffoldBackgroundColor}',
  );

  // Test CupertinoThemeData with brightness
  final lightTheme = CupertinoThemeData(brightness: Brightness.light);
  print('CupertinoThemeData with brightness=light created');
  print('  brightness: ${lightTheme.brightness}');

  final darkTheme = CupertinoThemeData(brightness: Brightness.dark);
  print('CupertinoThemeData with brightness=dark created');
  print('  brightness: ${darkTheme.brightness}');

  // Test CupertinoThemeData with applyThemeToAll
  final applyAllTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemPurple,
    applyThemeToAll: true,
  );
  print('CupertinoThemeData with applyThemeToAll created');
  print('  applyThemeToAll: ${applyAllTheme.applyThemeToAll}');

  // Test CupertinoThemeData with all properties
  final fullTheme = CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.systemIndigo,
    primaryContrastingColor: CupertinoColors.white,
    barBackgroundColor: CupertinoColors.extraLightBackgroundGray,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
    applyThemeToAll: false,
  );
  print('Full CupertinoThemeData created');
  print('  brightness: ${fullTheme.brightness}');
  print('  primaryColor: ${fullTheme.primaryColor}');
  print('  primaryContrastingColor: ${fullTheme.primaryContrastingColor}');
  print('  barBackgroundColor: ${fullTheme.barBackgroundColor}');
  print('  scaffoldBackgroundColor: ${fullTheme.scaffoldBackgroundColor}');

  // ========== CUPERTINOTEXTTHEMEDATA ==========
  print('--- CupertinoTextThemeData Tests ---');

  // Test basic CupertinoTextThemeData
  final basicTextTheme = CupertinoTextThemeData();
  print('Basic CupertinoTextThemeData created');

  // Test CupertinoTextThemeData with primaryColor
  final coloredTextTheme = CupertinoTextThemeData(
    primaryColor: CupertinoColors.systemBlue,
  );
  print('CupertinoTextThemeData with primaryColor created');

  // Test CupertinoTextThemeData with custom text styles
  final customTextTheme = CupertinoTextThemeData(
    textStyle: TextStyle(fontSize: 16.0, color: CupertinoColors.label),
    actionTextStyle: TextStyle(
      fontSize: 16.0,
      color: CupertinoColors.activeBlue,
    ),
    tabLabelTextStyle: TextStyle(
      fontSize: 10.0,
      color: CupertinoColors.inactiveGray,
    ),
    navTitleTextStyle: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: CupertinoColors.label,
    ),
    navLargeTitleTextStyle: TextStyle(
      fontSize: 34.0,
      fontWeight: FontWeight.bold,
      color: CupertinoColors.label,
    ),
    navActionTextStyle: TextStyle(
      fontSize: 16.0,
      color: CupertinoColors.activeBlue,
    ),
    pickerTextStyle: TextStyle(fontSize: 22.0, color: CupertinoColors.label),
    dateTimePickerTextStyle: TextStyle(
      fontSize: 20.0,
      color: CupertinoColors.label,
    ),
  );
  print('CupertinoTextThemeData with custom styles created');
  print('  textStyle: ${customTextTheme.textStyle}');
  print('  actionTextStyle: ${customTextTheme.actionTextStyle}');
  print('  tabLabelTextStyle: ${customTextTheme.tabLabelTextStyle}');
  print('  navTitleTextStyle: ${customTextTheme.navTitleTextStyle}');
  print('  navLargeTitleTextStyle: ${customTextTheme.navLargeTitleTextStyle}');
  print('  navActionTextStyle: ${customTextTheme.navActionTextStyle}');
  print('  pickerTextStyle: ${customTextTheme.pickerTextStyle}');
  print(
    '  dateTimePickerTextStyle: ${customTextTheme.dateTimePickerTextStyle}',
  );

  // Test CupertinoThemeData with textTheme
  final themedWithText = CupertinoThemeData(
    primaryColor: CupertinoColors.systemGreen,
    textTheme: customTextTheme,
  );
  print('CupertinoThemeData with textTheme created');
  print('  textTheme.textStyle: ${themedWithText.textTheme.textStyle}');

  // ========== CUPERTINOTHEME.OF ==========
  print('--- CupertinoTheme.of Tests ---');

  // CupertinoTheme.of(context) will be tested in the widget tree
  print('CupertinoTheme.of will be tested in widget tree');

  // ========== CUPERTINOTHEMEDATA.COPYWITH ==========
  print('--- CupertinoThemeData.copyWith Tests ---');

  final baseTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
    brightness: Brightness.light,
  );

  final copiedTheme = baseTheme.copyWith(
    primaryColor: CupertinoColors.systemRed,
  );
  print('CupertinoThemeData.copyWith created');
  print('  original primaryColor: ${baseTheme.primaryColor}');
  print('  copied primaryColor: ${copiedTheme.primaryColor}');
  print('  copied brightness (inherited): ${copiedTheme.brightness}');

  final copiedTheme2 = baseTheme.copyWith(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: CupertinoColors.black,
  );
  print('CupertinoThemeData.copyWith with brightness change');
  print('  brightness: ${copiedTheme2.brightness}');
  print('  scaffoldBackgroundColor: ${copiedTheme2.scaffoldBackgroundColor}');

  print('All Cupertino themes batch 1 tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    theme: fullTheme,
    home: Builder(
      builder: (BuildContext innerContext) {
        // Test CupertinoTheme.of inside widget tree
        final resolvedTheme = CupertinoTheme.of(innerContext);
        print('CupertinoTheme.of resolved');
        print('  resolved primaryColor: ${resolvedTheme.primaryColor}');
        print('  resolved brightness: ${resolvedTheme.brightness}');

        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(middle: Text('Themes Batch 1')),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CupertinoThemeData Properties:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text('Primary: ${resolvedTheme.primaryColor}'),
                  Text('Brightness: ${resolvedTheme.brightness}'),
                  Text('Bar bg: ${resolvedTheme.barBackgroundColor}'),
                  Text('Scaffold bg: ${resolvedTheme.scaffoldBackgroundColor}'),
                  SizedBox(height: 16.0),
                  Text(
                    'CupertinoTextThemeData:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text('Text style: ${resolvedTheme.textTheme.textStyle}'),
                  Text(
                    'Nav title: ${resolvedTheme.textTheme.navTitleTextStyle}',
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTheme(
                    data: CupertinoThemeData(
                      primaryColor: CupertinoColors.systemRed,
                    ),
                    child: Builder(
                      builder: (BuildContext nestedContext) {
                        final nested = CupertinoTheme.of(nestedContext);
                        return Text(
                          'Nested theme primary: ${nested.primaryColor}',
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTheme(
                    data: CupertinoThemeData(
                      primaryColor: CupertinoColors.systemGreen,
                      textTheme: CupertinoTextThemeData(
                        primaryColor: CupertinoColors.systemGreen,
                      ),
                    ),
                    child: CupertinoButton.filled(
                      child: Text('Green Theme Button'),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 16.0),
                  CupertinoTheme(
                    data: CupertinoThemeData(
                      primaryColor: CupertinoColors.systemPurple,
                    ),
                    child: CupertinoButton.filled(
                      child: Text('Purple Theme Button'),
                      onPressed: () {},
                    ),
                  ),
                  SizedBox(height: 24.0),
                  Text(
                    'Tests Completed:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text('• CupertinoThemeData properties'),
                  Text('• CupertinoThemeData.copyWith'),
                  Text('• CupertinoTextThemeData'),
                  Text('• CupertinoTheme.of'),
                  Text('• Nested CupertinoTheme'),
                ],
              ),
            ),
          ),
        );
      },
    ),
  );
}
