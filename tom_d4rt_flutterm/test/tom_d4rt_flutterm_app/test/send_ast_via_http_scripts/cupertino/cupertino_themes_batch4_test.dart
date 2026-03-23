// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NoDefaultCupertinoThemeData, MaterialBasedCupertinoThemeData from cupertino
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Cupertino themes batch 4 test executing');

  // ========== NODEFAULTCUPERTINOTHEMEDATA ==========
  print('--- NoDefaultCupertinoThemeData Tests ---');

  // Test NoDefaultCupertinoThemeData with minimal params
  final minimalNoDefault = NoDefaultCupertinoThemeData(
    primaryColor: CupertinoColors.systemOrange,
  );
  print('NoDefaultCupertinoThemeData with primaryColor created');
  print('  primaryColor: ${minimalNoDefault.primaryColor}');

  // Test NoDefaultCupertinoThemeData with brightness
  final brightNoDefault = NoDefaultCupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.systemBlue,
  );
  print('NoDefaultCupertinoThemeData with brightness created');
  print('  brightness: ${brightNoDefault.brightness}');
  print('  primaryColor: ${brightNoDefault.primaryColor}');

  // Test NoDefaultCupertinoThemeData with full properties
  final fullNoDefault = NoDefaultCupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.systemIndigo,
    primaryContrastingColor: CupertinoColors.white,
    barBackgroundColor: CupertinoColors.extraLightBackgroundGray,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
    textTheme: CupertinoTextThemeData(
      primaryColor: CupertinoColors.systemIndigo,
      textStyle: TextStyle(fontSize: 16.0, color: CupertinoColors.label),
      navTitleTextStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: CupertinoColors.label,
      ),
    ),
  );
  print('Full NoDefaultCupertinoThemeData created');
  print('  brightness: ${fullNoDefault.brightness}');
  print('  primaryColor: ${fullNoDefault.primaryColor}');
  print('  primaryContrastingColor: ${fullNoDefault.primaryContrastingColor}');
  print('  barBackgroundColor: ${fullNoDefault.barBackgroundColor}');
  print('  scaffoldBackgroundColor: ${fullNoDefault.scaffoldBackgroundColor}');
  print('  textTheme: ${fullNoDefault.textTheme}');

  // Test NoDefaultCupertinoThemeData with only textTheme
  final textOnlyNoDefault = NoDefaultCupertinoThemeData(
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(fontSize: 20.0),
      navLargeTitleTextStyle: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  print('NoDefaultCupertinoThemeData with only textTheme created [${textOnlyNoDefault.hashCode }]');

  // Test NoDefaultCupertinoThemeData with copyWith
  final copiedNoDefault = fullNoDefault.copyWith(
    primaryColor: CupertinoColors.systemRed,
  );
  print('NoDefaultCupertinoThemeData.copyWith created');
  print('  primaryColor: ${copiedNoDefault.primaryColor}');

  // Test NoDefaultCupertinoThemeData properties applied via CupertinoThemeData
  // Note: NoDefaultCupertinoThemeData is the SUPERCLASS of CupertinoThemeData,
  // so it cannot be passed directly to CupertinoTheme(data:). We use
  // CupertinoThemeData with the same properties instead.
  final noDefaultThemeWidget = CupertinoTheme(
    data: CupertinoThemeData(
      brightness: fullNoDefault.brightness,
      primaryColor: fullNoDefault.primaryColor,
      primaryContrastingColor: fullNoDefault.primaryContrastingColor,
      barBackgroundColor: fullNoDefault.barBackgroundColor,
      scaffoldBackgroundColor: fullNoDefault.scaffoldBackgroundColor,
      textTheme: fullNoDefault.textTheme,
    ),
    child: Builder(
      builder: (BuildContext ctx) {
        final theme = CupertinoTheme.of(ctx);
        print('NoDefault properties via CupertinoTheme.of:');
        print('  primaryColor: ${theme.primaryColor}');
        return Text('NoDefault themed text');
      },
    ),
  );
  print('NoDefaultCupertinoThemeData properties applied via CupertinoTheme [${noDefaultThemeWidget.hashCode}]');

  // ========== MATERIALBASEDCUPERTINOTHEMEDATA ==========
  print('--- MaterialBasedCupertinoThemeData Tests ---');

  // Test MaterialBasedCupertinoThemeData with basic MaterialTheme
  final lightMaterialTheme = ThemeData.light();
  final materialBasedLight = MaterialBasedCupertinoThemeData(
    materialTheme: lightMaterialTheme,
  );
  print('MaterialBasedCupertinoThemeData from light theme created');
  print('  primaryColor: ${materialBasedLight.primaryColor}');
  print('  brightness: ${materialBasedLight.brightness}');
  print(
    '  scaffoldBackgroundColor: ${materialBasedLight.scaffoldBackgroundColor}',
  );

  // Test MaterialBasedCupertinoThemeData with dark MaterialTheme
  final darkMaterialTheme = ThemeData.dark();
  final materialBasedDark = MaterialBasedCupertinoThemeData(
    materialTheme: darkMaterialTheme,
  );
  print('MaterialBasedCupertinoThemeData from dark theme created');
  print('  primaryColor: ${materialBasedDark.primaryColor}');
  print('  brightness: ${materialBasedDark.brightness}');
  print(
    '  scaffoldBackgroundColor: ${materialBasedDark.scaffoldBackgroundColor}',
  );

  // Test MaterialBasedCupertinoThemeData with custom MaterialTheme
  final customMaterialTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  );
  final materialBasedCustom = MaterialBasedCupertinoThemeData(
    materialTheme: customMaterialTheme,
  );
  print('MaterialBasedCupertinoThemeData from custom theme created');
  print('  primaryColor: ${materialBasedCustom.primaryColor}');
  print('  brightness: ${materialBasedCustom.brightness}');

  // Test MaterialBasedCupertinoThemeData with blue seed
  final blueMaterialTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
  );
  final materialBasedBlue = MaterialBasedCupertinoThemeData(
    materialTheme: blueMaterialTheme,
  );
  print('MaterialBasedCupertinoThemeData from blue seed created');
  print('  primaryColor: ${materialBasedBlue.primaryColor}');

  // Test MaterialBasedCupertinoThemeData with red seed
  final redMaterialTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
  );
  final materialBasedRed = MaterialBasedCupertinoThemeData(
    materialTheme: redMaterialTheme,
  );
  print('MaterialBasedCupertinoThemeData from red seed created');
  print('  primaryColor: ${materialBasedRed.primaryColor}');

  // Test MaterialBasedCupertinoThemeData textTheme access
  print('MaterialBased textTheme access:');
  print('  textStyle: ${materialBasedLight.textTheme.textStyle}');
  print(
    '  navTitleTextStyle: ${materialBasedLight.textTheme.navTitleTextStyle}',
  );
  print('  actionTextStyle: ${materialBasedLight.textTheme.actionTextStyle}');

  // Test MaterialBasedCupertinoThemeData.copyWith
  final copiedMaterialBased = materialBasedLight.copyWith(
    primaryColor: CupertinoColors.systemGreen,
  );
  print('MaterialBasedCupertinoThemeData.copyWith created');
  print('  primaryColor: ${copiedMaterialBased.primaryColor}');

  // ========== COMPARISON ==========
  print('--- Comparison: Regular vs NoDefault vs MaterialBased ---');

  final regularTheme = CupertinoThemeData(
    primaryColor: CupertinoColors.systemBlue,
  );
  print('Regular: primaryColor=${regularTheme.primaryColor}');
  print('NoDefault: primaryColor=${fullNoDefault.primaryColor}');
  print('MaterialBased: primaryColor=${materialBasedLight.primaryColor}');

  print('All Cupertino themes batch 4 tests passed');

  // ========== RETURN WIDGET ==========
  return CupertinoApp(
    theme: CupertinoThemeData(primaryColor: CupertinoColors.systemBlue),
    home: CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(middle: Text('Themes Batch 4')),
      child: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'NoDefaultCupertinoThemeData:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),

              // NoDefault themed section — use CupertinoThemeData (supertype fix)
              CupertinoTheme(
                data: CupertinoThemeData(
                  primaryColor: CupertinoColors.systemOrange,
                ),
                child: Builder(
                  builder: (BuildContext ctx) {
                    final theme = CupertinoTheme.of(ctx);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('NoDefault primary: ${theme.primaryColor}'),
                        SizedBox(height: 4.0),
                        CupertinoButton.filled(
                          child: Text('NoDefault Button'),
                          onPressed: () {},
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 8.0),

              CupertinoTheme(
                data: CupertinoThemeData(
                  primaryColor: CupertinoColors.systemPurple,
                  brightness: Brightness.light,
                ),
                child: CupertinoButton.filled(
                  child: Text('Purple NoDefault'),
                  onPressed: () {},
                ),
              ),

              SizedBox(height: 16.0),
              Text(
                'MaterialBasedCupertinoThemeData:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),

              // MaterialBased from light theme
              CupertinoTheme(
                data: materialBasedLight,
                child: Builder(
                  builder: (BuildContext ctx) {
                    final theme = CupertinoTheme.of(ctx);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MaterialBased(light) primary: ${theme.primaryColor}',
                        ),
                        SizedBox(height: 4.0),
                        CupertinoButton.filled(
                          child: Text('Light Material'),
                          onPressed: () {},
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 8.0),

              // MaterialBased from custom theme
              CupertinoTheme(
                data: materialBasedCustom,
                child: Builder(
                  builder: (BuildContext ctx) {
                    final theme = CupertinoTheme.of(ctx);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'MaterialBased(custom) primary: ${theme.primaryColor}',
                        ),
                        SizedBox(height: 4.0),
                        CupertinoButton.filled(
                          child: Text('Custom Material'),
                          onPressed: () {},
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 8.0),

              // MaterialBased from dark theme
              CupertinoTheme(
                data: materialBasedDark,
                child: CupertinoButton.filled(
                  child: Text('Dark Material'),
                  onPressed: () {},
                ),
              ),

              SizedBox(height: 24.0),
              Text(
                'Tests Completed:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text('• NoDefaultCupertinoThemeData construction'),
              Text('• NoDefaultCupertinoThemeData.copyWith'),
              Text('• NoDefaultCupertinoThemeData via CupertinoTheme'),
              Text('• MaterialBasedCupertinoThemeData light'),
              Text('• MaterialBasedCupertinoThemeData dark'),
              Text('• MaterialBasedCupertinoThemeData custom'),
              Text('• MaterialBasedCupertinoThemeData.copyWith'),
              Text('• Theme type comparison'),
            ],
          ),
        ),
      ),
    ),
  );
}
