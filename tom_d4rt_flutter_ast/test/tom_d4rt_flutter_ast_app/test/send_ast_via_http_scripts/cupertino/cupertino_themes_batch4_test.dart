// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests CupertinoTheme brightness cascade, MaterialBasedCupertinoThemeData, NoDefaultCupertinoThemeData
// Deep Demo: Visual demonstration of brightness handling, material<->cupertino bridging, system color resolution
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Cupertino Themes Batch 4 Deep Demo executing');

  // ============================================================
  // SECTION 1: Brightness Concept Overview (Light vs Dark)
  // ============================================================
  print('=== Section 1: Brightness Concept Overview ===');

  final lightBrightnessPanel = Container(
    width: 220.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFAFAFA), Color(0xFFE3F2FD)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFB0BEC5), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0x33000000),
          blurRadius: 6.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(CupertinoIcons.sun_max_fill, color: Color(0xFFFFC107), size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Brightness.light',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF263238),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Light surfaces, dark text.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFF455A64)),
        ),
        SizedBox(height: 8.0),
        Text(
          'Default for iOS unless\noverridden.',
          style: TextStyle(fontSize: 11.0, color: Color(0xFF607D8B)),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Color(0xFFE1F5FE),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'systemBackground -> white',
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Color(0xFF0277BD),
            ),
          ),
        ),
      ],
    ),
  );

  final darkBrightnessPanel = Container(
    width: 220.0,
    margin: EdgeInsets.all(8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF263238), Color(0xFF102027)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF455A64), width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 6.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(CupertinoIcons.moon_fill, color: Color(0xFFBBDEFB), size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Brightness.dark',
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFECEFF1),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'Dark surfaces, light text.',
          style: TextStyle(fontSize: 12.0, color: Color(0xFFCFD8DC)),
        ),
        SizedBox(height: 8.0),
        Text(
          'Resolved dynamic colors\nflip to dark variants.',
          style: TextStyle(fontSize: 11.0, color: Color(0xFFB0BEC5)),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          decoration: BoxDecoration(
            color: Color(0xFF37474F),
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Text(
            'systemBackground -> black',
            style: TextStyle(
              fontSize: 10.0,
              fontFamily: 'monospace',
              color: Color(0xFF81D4FA),
            ),
          ),
        ),
      ],
    ),
  );
  print('Created light/dark brightness panels');

  // ============================================================
  // SECTION 2: Brightness Cascade Demo
  // ============================================================
  print('=== Section 2: Brightness Cascade ===');

  // Same CupertinoButton wrapped in three different brightness contexts
  final cascadeLightSubtree = CupertinoTheme(
    data: CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: CupertinoColors.activeBlue,
    ),
    child: Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F7),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color(0xFFD1D1D6), width: 1.0),
      ),
      child: Column(
        children: [
          Text(
            'brightness: light',
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Color(0xFF3C3C43),
            ),
          ),
          SizedBox(height: 8.0),
          Builder(
            builder: (BuildContext ctx) {
              final theme = CupertinoTheme.of(ctx);
              print('Cascade light primary=${theme.primaryColor}');
              return CupertinoButton.filled(
                child: Text('Confirm'),
                onPressed: () {},
              );
            },
          ),
          SizedBox(height: 6.0),
          Text(
            'Default iOS look',
            style: TextStyle(fontSize: 10.0, color: Color(0xFF8E8E93)),
          ),
        ],
      ),
    ),
  );

  final cascadeDarkSubtree = CupertinoTheme(
    data: CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: CupertinoColors.activeBlue,
    ),
    child: Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color(0xFF3A3A3C), width: 1.0),
      ),
      child: Column(
        children: [
          Text(
            'brightness: dark',
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Color(0xFFEBEBF5),
            ),
          ),
          SizedBox(height: 8.0),
          Builder(
            builder: (BuildContext ctx) {
              final theme = CupertinoTheme.of(ctx);
              print('Cascade dark primary=${theme.primaryColor}');
              return CupertinoButton.filled(
                child: Text('Confirm'),
                onPressed: () {},
              );
            },
          ),
          SizedBox(height: 6.0),
          Text(
            'Inverted surface',
            style: TextStyle(fontSize: 10.0, color: Color(0xFF8E8E93)),
          ),
        ],
      ),
    ),
  );

  final cascadeCustomSubtree = CupertinoTheme(
    data: CupertinoThemeData(
      brightness: Brightness.dark,
      primaryColor: CupertinoColors.systemPink,
    ),
    child: Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color(0xFFFF2D55), width: 1.5),
      ),
      child: Column(
        children: [
          Text(
            'dark + systemPink primary',
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Color(0xFFFFB1C0),
            ),
          ),
          SizedBox(height: 8.0),
          Builder(
            builder: (BuildContext ctx) {
              final theme = CupertinoTheme.of(ctx);
              print('Cascade dark+pink primary=${theme.primaryColor}');
              return CupertinoButton.filled(
                child: Text('Confirm'),
                onPressed: () {},
              );
            },
          ),
          SizedBox(height: 6.0),
          Text(
            'Custom primary in dark',
            style: TextStyle(fontSize: 10.0, color: Color(0xFFFFB1C0)),
          ),
        ],
      ),
    ),
  );
  print('Created brightness cascade subtrees');

  // ============================================================
  // SECTION 3: MaterialBased <-> Cupertino Bridging
  // ============================================================
  print('=== Section 3: MaterialBasedCupertinoThemeData Bridging ===');

  final lightMaterialTheme = ThemeData.light();
  final darkMaterialTheme = ThemeData.dark();
  final customMaterialTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  );
  final tealMaterialTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
  );

  final mbLight = MaterialBasedCupertinoThemeData(materialTheme: lightMaterialTheme);
  final mbDark = MaterialBasedCupertinoThemeData(materialTheme: darkMaterialTheme);
  final mbPurple = MaterialBasedCupertinoThemeData(materialTheme: customMaterialTheme);
  final mbTeal = MaterialBasedCupertinoThemeData(materialTheme: tealMaterialTheme);

  print('MaterialBased(light) primary=${mbLight.primaryColor}');
  print('MaterialBased(dark) primary=${mbDark.primaryColor}');
  print('MaterialBased(purple) primary=${mbPurple.primaryColor}');
  print('MaterialBased(teal) primary=${mbTeal.primaryColor}');

  final bridgingDiagram = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF3E0), Color(0xFFFCE4EC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFFFAB91), width: 1.5),
    ),
    child: Column(
      children: [
        Text(
          'Material  -->  MaterialBasedCupertinoThemeData  -->  Cupertino',
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
            color: Color(0xFFBF360C),
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Icon(Icons.android, color: Color(0xFF689F38), size: 32.0),
                Text('Material', style: TextStyle(fontSize: 11.0)),
              ],
            ),
            Icon(CupertinoIcons.arrow_right_circle_fill, color: Color(0xFFFF7043), size: 24.0),
            Column(
              children: [
                Icon(CupertinoIcons.cube_box_fill, color: Color(0xFFFF7043), size: 32.0),
                Text('Bridge', style: TextStyle(fontSize: 11.0)),
              ],
            ),
            Icon(CupertinoIcons.arrow_right_circle_fill, color: Color(0xFFFF7043), size: 24.0),
            Column(
              children: [
                Icon(CupertinoIcons.device_phone_portrait, color: Color(0xFF455A64), size: 32.0),
                Text('Cupertino', style: TextStyle(fontSize: 11.0)),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  final bridgingSampleSubtree1 = CupertinoTheme(
    data: mbLight,
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color(0xFFFAFAFA),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color(0xFFE0E0E0)),
      ),
      child: Builder(
        builder: (BuildContext ctx) {
          final theme = CupertinoTheme.of(ctx);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'mbLight',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Color(0xFF424242),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'primary: ${theme.primaryColor}',
                style: TextStyle(fontSize: 10.0, color: Color(0xFF616161)),
              ),
              SizedBox(height: 8.0),
              CupertinoButton.filled(
                child: Text('Light'),
                onPressed: () {},
              ),
            ],
          );
        },
      ),
    ),
  );

  final bridgingSampleSubtree2 = CupertinoTheme(
    data: mbDark,
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color(0xFF212121),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color(0xFF424242)),
      ),
      child: Builder(
        builder: (BuildContext ctx) {
          final theme = CupertinoTheme.of(ctx);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'mbDark',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Color(0xFFEEEEEE),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'primary: ${theme.primaryColor}',
                style: TextStyle(fontSize: 10.0, color: Color(0xFFBDBDBD)),
              ),
              SizedBox(height: 8.0),
              CupertinoButton.filled(
                child: Text('Dark'),
                onPressed: () {},
              ),
            ],
          );
        },
      ),
    ),
  );

  final bridgingSampleSubtree3 = CupertinoTheme(
    data: mbPurple,
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color(0xFFEDE7F6),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color(0xFFB39DDB)),
      ),
      child: Builder(
        builder: (BuildContext ctx) {
          final theme = CupertinoTheme.of(ctx);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'mbPurple',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Color(0xFF4527A0),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'primary: ${theme.primaryColor}',
                style: TextStyle(fontSize: 10.0, color: Color(0xFF512DA8)),
              ),
              SizedBox(height: 8.0),
              CupertinoButton.filled(
                child: Text('Purple'),
                onPressed: () {},
              ),
            ],
          );
        },
      ),
    ),
  );

  final bridgingSampleSubtree4 = CupertinoTheme(
    data: mbTeal,
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color(0xFFE0F2F1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color(0xFF80CBC4)),
      ),
      child: Builder(
        builder: (BuildContext ctx) {
          final theme = CupertinoTheme.of(ctx);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'mbTeal',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Color(0xFF004D40),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'primary: ${theme.primaryColor}',
                style: TextStyle(fontSize: 10.0, color: Color(0xFF00695C)),
              ),
              SizedBox(height: 8.0),
              CupertinoButton.filled(
                child: Text('Teal'),
                onPressed: () {},
              ),
            ],
          );
        },
      ),
    ),
  );
  print('Created bridging samples');

  // ============================================================
  // SECTION 4: NoDefaultCupertinoThemeData Partial Override
  // ============================================================
  print('=== Section 4: NoDefaultCupertinoThemeData Partial Override ===');

  // Four cards: what gets inherited, what gets overridden, what defaults
  final partialOverrideCards = <Widget>[];

  // Card A: only primaryColor overridden
  final ndA = NoDefaultCupertinoThemeData(
    primaryColor: CupertinoColors.systemOrange,
  );
  print('NoDefault A primary=${ndA.primaryColor} brightness=${ndA.brightness}');

  partialOverrideCards.add(
    Container(
      width: 230.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color(0xFFFFB74D), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Color(0xFFFFB74D),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'A',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                'primaryColor only',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFE65100),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            'Set: primaryColor',
            style: TextStyle(fontSize: 11.0, color: Color(0xFFBF360C)),
          ),
          Text(
            'Null: brightness, textTheme,\nbarBackgroundColor, ...',
            style: TextStyle(fontSize: 10.0, color: Color(0xFF8D6E63)),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Color(0xFFFF9800),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'primary=${ndA.primaryColor}'.substring(0, 24),
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 10.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Card B: brightness + primary overridden
  final ndB = NoDefaultCupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: CupertinoColors.systemTeal,
  );
  print('NoDefault B primary=${ndB.primaryColor} brightness=${ndB.brightness}');

  partialOverrideCards.add(
    Container(
      width: 230.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Color(0xFFE0F7FA),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color(0xFF4DD0E1), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Color(0xFF26C6DA),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'B',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                'brightness + primary',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF006064),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            'Set: brightness, primaryColor',
            style: TextStyle(fontSize: 11.0, color: Color(0xFF00838F)),
          ),
          Text(
            'Null: textTheme, contrasts,\nscaffoldBackgroundColor',
            style: TextStyle(fontSize: 10.0, color: Color(0xFF00695C)),
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Color(0xFF00ACC1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              'brightness=${ndB.brightness}',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 10.0,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    ),
  );

  // Card C: textTheme only
  final ndC = NoDefaultCupertinoThemeData(
    textTheme: CupertinoTextThemeData(
      textStyle: TextStyle(fontSize: 20.0, color: CupertinoColors.label),
      navLargeTitleTextStyle: TextStyle(
        fontSize: 34.0,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
  print('NoDefault C textTheme set (hash=${ndC.hashCode})');

  partialOverrideCards.add(
    Container(
      width: 230.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color(0xFFBA68C8), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Color(0xFFAB47BC),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'C',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                'textTheme only',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            'Set: textTheme (partial)',
            style: TextStyle(fontSize: 11.0, color: Color(0xFF6A1B9A)),
          ),
          Text(
            'Null: colors, brightness',
            style: TextStyle(fontSize: 10.0, color: Color(0xFF8E24AA)),
          ),
          SizedBox(height: 8.0),
          Text(
            'Aa',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF6A1B9A),
            ),
          ),
        ],
      ),
    ),
  );

  // Card D: full override
  final ndD = NoDefaultCupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: CupertinoColors.systemIndigo,
    primaryContrastingColor: CupertinoColors.white,
    barBackgroundColor: CupertinoColors.extraLightBackgroundGray,
    scaffoldBackgroundColor: CupertinoColors.systemBackground,
  );
  final ndDCopy = ndD.copyWith(primaryColor: CupertinoColors.systemRed);
  print('NoDefault D full override (copy primary=${ndDCopy.primaryColor})');

  partialOverrideCards.add(
    Container(
      width: 230.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Color(0xFFE8EAF6),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Color(0xFF7986CB), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: Color(0xFF5C6BC0),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'D',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 8.0),
              Text(
                'full + copyWith',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            'Set: all 5 properties',
            style: TextStyle(fontSize: 11.0, color: Color(0xFF283593)),
          ),
          Text(
            'copyWith overrides primary',
            style: TextStyle(fontSize: 10.0, color: Color(0xFF3949AB)),
          ),
          SizedBox(height: 8.0),
          Row(
            children: [
              Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: Color(0xFF5856D6),
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 4.0),
              Icon(CupertinoIcons.arrow_right, size: 16.0, color: Color(0xFF3949AB)),
              SizedBox(width: 4.0),
              Container(
                width: 24.0,
                height: 24.0,
                decoration: BoxDecoration(
                  color: Color(0xFFFF3B30),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
  print('Created ${partialOverrideCards.length} partial-override cards');

  // ============================================================
  // SECTION 5: CupertinoSystemColors Light/Dark Resolution Table
  // ============================================================
  print('=== Section 5: CupertinoSystemColors Light/Dark Resolution ===');

  // 8 system colors x 2 brightness modes
  final systemColorEntries = <Map<String, dynamic>>[
    {'name': 'systemRed', 'light': Color(0xFFFF3B30), 'dark': Color(0xFFFF453A)},
    {'name': 'systemOrange', 'light': Color(0xFFFF9500), 'dark': Color(0xFFFF9F0A)},
    {'name': 'systemYellow', 'light': Color(0xFFFFCC00), 'dark': Color(0xFFFFD60A)},
    {'name': 'systemGreen', 'light': Color(0xFF34C759), 'dark': Color(0xFF30D158)},
    {'name': 'systemTeal', 'light': Color(0xFF30B0C7), 'dark': Color(0xFF40C8E0)},
    {'name': 'systemBlue', 'light': Color(0xFF007AFF), 'dark': Color(0xFF0A84FF)},
    {'name': 'systemIndigo', 'light': Color(0xFF5856D6), 'dark': Color(0xFF5E5CE6)},
    {'name': 'systemPurple', 'light': Color(0xFFAF52DE), 'dark': Color(0xFFBF5AF2)},
  ];

  final systemColorRows = <Widget>[];
  // Header row
  systemColorRows.add(
    Container(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Color(0xFF1C1C1E),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              'Color name',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                fontSize: 11.0,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(CupertinoIcons.sun_max, color: Color(0xFFFFCC00), size: 14.0),
                SizedBox(width: 4.0),
                Text(
                  'Light',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Icon(CupertinoIcons.moon, color: Color(0xFFBBDEFB), size: 14.0),
                SizedBox(width: 4.0),
                Text(
                  'Dark',
                  style: TextStyle(
                    color: Color(0xFFFFFFFF),
                    fontWeight: FontWeight.bold,
                    fontSize: 11.0,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );

  for (int i = 0; i < systemColorEntries.length; i++) {
    final entry = systemColorEntries[i];
    final isEven = i % 2 == 0;
    systemColorRows.add(
      Container(
        margin: EdgeInsets.only(top: 4.0),
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: isEven ? Color(0xFFF2F2F7) : Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: Color(0xFFE5E5EA), width: 0.5),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                entry['name'] as String,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.0,
                  color: Color(0xFF1C1C1E),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: entry['light'] as Color,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: Color(0xFFC7C7CC)),
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    '#${(entry['light'] as Color).value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 9.0,
                      color: Color(0xFF3C3C43),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                children: [
                  Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: entry['dark'] as Color,
                      borderRadius: BorderRadius.circular(4.0),
                      border: Border.all(color: Color(0xFF48484A)),
                    ),
                  ),
                  SizedBox(width: 6.0),
                  Text(
                    '#${(entry['dark'] as Color).value.toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}',
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 9.0,
                      color: Color(0xFF3C3C43),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    print('Row ${entry['name']}: light vs dark resolved');
  }

  // ============================================================
  // SECTION 6: Cupertino Widget Text-Style Override Gallery
  // ============================================================
  print('=== Section 6: Text-Style Override Gallery ===');

  // Default CupertinoButton vs themed CupertinoButton
  final defaultButtonSubtree = CupertinoTheme(
    data: CupertinoThemeData(),
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color(0xFFE5E5EA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Default CupertinoButton',
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1C1C1E),
            ),
          ),
          SizedBox(height: 8.0),
          CupertinoButton(
            child: Text('Tap me'),
            onPressed: () {},
          ),
          SizedBox(height: 4.0),
          Text(
            'inherits actionTextStyle\nfrom CupertinoTextThemeData',
            style: TextStyle(fontSize: 9.0, color: Color(0xFF8E8E93)),
          ),
        ],
      ),
    ),
  );

  final themedButtonSubtree = CupertinoTheme(
    data: CupertinoThemeData(
      primaryColor: CupertinoColors.systemPurple,
      textTheme: CupertinoTextThemeData(
        actionTextStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
          color: CupertinoColors.systemPurple,
        ),
      ),
    ),
    child: Container(
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color(0xFFBA68C8)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Themed CupertinoButton',
            style: TextStyle(
              fontSize: 11.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF4A148C),
            ),
          ),
          SizedBox(height: 8.0),
          CupertinoButton(
            child: Text('Tap me'),
            onPressed: () {},
          ),
          SizedBox(height: 4.0),
          Text(
            'actionTextStyle: 18pt w800\nsystemPurple',
            style: TextStyle(fontSize: 9.0, color: Color(0xFF6A1B9A)),
          ),
        ],
      ),
    ),
  );

  // Default vs themed CupertinoNavigationBar
  final defaultNavBarSubtree = CupertinoTheme(
    data: CupertinoThemeData(),
    child: Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color(0xFFE5E5EA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              'Default CupertinoNavigationBar',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1C1C1E),
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Container(
            height: 44.0,
            decoration: BoxDecoration(
              color: Color(0xFFF9F9F9),
              border: Border(bottom: BorderSide(color: Color(0xFFD1D1D6))),
            ),
            alignment: Alignment.center,
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 17.0,
                fontWeight: FontWeight.w600,
                color: Color(0xFF000000),
              ),
            ),
          ),
        ],
      ),
    ),
  );

  final themedNavBarSubtree = CupertinoTheme(
    data: CupertinoThemeData(
      primaryColor: CupertinoColors.systemTeal,
      barBackgroundColor: Color(0xFF003F4A),
      brightness: Brightness.dark,
      textTheme: CupertinoTextThemeData(
        navTitleTextStyle: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
          color: CupertinoColors.systemTeal,
        ),
      ),
    ),
    child: Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Color(0xFF002A33),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color(0xFF40C8E0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(4.0),
            child: Text(
              'Themed CupertinoNavigationBar',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE0F7FA),
              ),
            ),
          ),
          SizedBox(height: 6.0),
          Container(
            height: 44.0,
            decoration: BoxDecoration(
              color: Color(0xFF003F4A),
              border: Border(bottom: BorderSide(color: Color(0xFF40C8E0))),
            ),
            alignment: Alignment.center,
            child: Text(
              'Settings',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w900,
                color: Color(0xFF40C8E0),
              ),
            ),
          ),
        ],
      ),
    ),
  );
  print('Created text-style override gallery');

  // ============================================================
  // SECTION 7: CupertinoTheme inside MaterialApp embedding
  // ============================================================
  print('=== Section 7: CupertinoTheme inside MaterialApp ===');

  final embeddingDiagram = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFE8F5E9),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF66BB6A), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.layers, color: Color(0xFF2E7D32), size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Embedding stack',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
                color: Color(0xFF1B5E20),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFC8E6C9),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'MaterialApp(theme: ...)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B5E20),
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Icon(CupertinoIcons.arrow_down, color: Color(0xFF388E3C), size: 18.0),
        ),
        SizedBox(height: 4.0),
        Container(
          margin: EdgeInsets.only(left: 16.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFA5D6A7),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'CupertinoTheme(data: ...)',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B5E20),
            ),
          ),
        ),
        SizedBox(height: 4.0),
        Padding(
          padding: EdgeInsets.only(left: 32.0),
          child: Icon(CupertinoIcons.arrow_down, color: Color(0xFF388E3C), size: 18.0),
        ),
        SizedBox(height: 4.0),
        Container(
          margin: EdgeInsets.only(left: 32.0),
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF81C784),
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            'CupertinoButton / CupertinoTextField',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ),
      ],
    ),
  );

  // Inline demo: CupertinoTheme inside a Material context
  final embeddingDemoSubtree = Container(
    margin: EdgeInsets.all(12.0),
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFBDBDBD)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Inside a Material surface:',
          style: TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(height: 8.0),
        Material(
          color: Color(0xFFE3F2FD),
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(Icons.dashboard, color: Color(0xFF1976D2)),
                SizedBox(width: 8.0),
                Text(
                  'Material widget',
                  style: TextStyle(color: Color(0xFF0D47A1)),
                ),
                Spacer(),
                CupertinoTheme(
                  data: CupertinoThemeData(
                    primaryColor: CupertinoColors.systemBlue,
                    brightness: Brightness.light,
                  ),
                  child: CupertinoButton(
                    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    color: CupertinoColors.systemBlue,
                    child: Text(
                      'iOS button',
                      style: TextStyle(fontSize: 13.0),
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'CupertinoTheme overrides only its subtree.',
          style: TextStyle(fontSize: 10.0, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
  print('Created embedding diagram + demo');

  // ============================================================
  // SECTION 8: Code Example Panels (dark Container)
  // ============================================================
  print('=== Section 8: Code Examples ===');

  final codeExamplesPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(CupertinoIcons.chevron_left_slash_chevron_right, color: Color(0xFF4FC3F7), size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'CupertinoTheme code patterns',
              style: TextStyle(
                color: Color(0xFF4FC3F7),
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Brightness cascade\n'
            'CupertinoTheme(\n'
            '  data: CupertinoThemeData(\n'
            '    brightness: Brightness.dark,\n'
            '    primaryColor: CupertinoColors.systemPink,\n'
            '  ),\n'
            '  child: CupertinoButton.filled(\n'
            '    child: Text("Save"),\n'
            '    onPressed: () {},\n'
            '  ),\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFA5D6A7),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Material -> Cupertino bridge\n'
            'final mb = MaterialBasedCupertinoThemeData(\n'
            '  materialTheme: ThemeData.dark(),\n'
            ');\n'
            'CupertinoTheme(data: mb, child: ...);',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFCE93D8),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// brightnessOf resolution\n'
            'final b = CupertinoTheme.brightnessOf(context);\n'
            'final isDark = b == Brightness.dark;\n'
            '// Falls back to MediaQuery if not set.',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFFFCC80),
            ),
          ),
        ),
        SizedBox(height: 10.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF2D2D2D),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Partial override (NoDefault)\n'
            'NoDefaultCupertinoThemeData(\n'
            '  primaryColor: CupertinoColors.systemOrange,\n'
            ')  // brightness/textTheme are NULL\n',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFFFFAB91),
            ),
          ),
        ),
      ],
    ),
  );
  print('Created code examples panel');

  // ============================================================
  // SECTION 9: Summary Takeaways
  // ============================================================
  print('=== Section 9: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE3F2FD), Color(0xFFF3E5F5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF90CAF9), width: 1.5),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0D47A1),
          ),
        ),
        SizedBox(height: 16.0),
        _buildTakeaway(
          CupertinoIcons.sun_max_fill,
          'Brightness is the master switch',
          'It controls how CupertinoDynamicColor resolves across the subtree.',
          Color(0xFFFFC107),
        ),
        SizedBox(height: 8.0),
        _buildTakeaway(
          CupertinoIcons.cube_box_fill,
          'MaterialBasedCupertinoThemeData bridges',
          'Generated from a ThemeData; primary, brightness, scaffold derived automatically.',
          Color(0xFFFF7043),
        ),
        SizedBox(height: 8.0),
        _buildTakeaway(
          CupertinoIcons.square_stack_3d_up,
          'NoDefault is partial',
          'Properties may be null; resolution falls back to the parent CupertinoTheme.',
          Color(0xFFAB47BC),
        ),
        SizedBox(height: 8.0),
        _buildTakeaway(
          CupertinoIcons.color_filter,
          'System colors flip on brightness',
          '8+ system colors have separate light/dark resolved variants.',
          Color(0xFF42A5F5),
        ),
        SizedBox(height: 8.0),
        _buildTakeaway(
          CupertinoIcons.textformat_alt,
          'TextStyles propagate',
          'Override actionTextStyle / navTitleTextStyle to restyle specific widgets.',
          Color(0xFF26A69A),
        ),
        SizedBox(height: 8.0),
        _buildTakeaway(
          CupertinoIcons.layers_alt_fill,
          'Embed inside MaterialApp',
          'Wrap a Cupertino subtree to mix iOS-styled widgets in a Material shell.',
          Color(0xFF66BB6A),
        ),
      ],
    ),
  );
  print('Created summary panel');

  print('Cupertino Themes Batch 4 Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout
  // ============================================================
  return SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header banner
        Container(
          padding: EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1C1C1E), Color(0xFF3A3A3C)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Color(0x44000000),
                blurRadius: 10.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.sun_max_fill, color: Color(0xFFFFD60A), size: 36.0),
                  SizedBox(width: 8.0),
                  Icon(CupertinoIcons.moon_stars_fill, color: Color(0xFF64D2FF), size: 36.0),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                'Cupertino Themes - Batch 4',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFFFFFF),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'Brightness, Bridging, NoDefault, System Colors',
                style: TextStyle(fontSize: 13.0, color: Color(0xFFBBDEFB)),
              ),
            ],
          ),
        ),
        SizedBox(height: 24.0),

        // Section 1
        Text(
          '1. Brightness Concept Overview',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [lightBrightnessPanel, darkBrightnessPanel],
        ),
        SizedBox(height: 32.0),

        // Section 2
        Text(
          '2. Brightness Cascade (same button, different themes)',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            SizedBox(width: 200.0, child: cascadeLightSubtree),
            SizedBox(width: 200.0, child: cascadeDarkSubtree),
            SizedBox(width: 200.0, child: cascadeCustomSubtree),
          ],
        ),
        SizedBox(height: 32.0),

        // Section 3
        Text(
          '3. MaterialBasedCupertinoThemeData Bridging',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        bridgingDiagram,
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            SizedBox(width: 180.0, child: bridgingSampleSubtree1),
            SizedBox(width: 180.0, child: bridgingSampleSubtree2),
            SizedBox(width: 180.0, child: bridgingSampleSubtree3),
            SizedBox(width: 180.0, child: bridgingSampleSubtree4),
          ],
        ),
        SizedBox(height: 32.0),

        // Section 4
        Text(
          '4. NoDefaultCupertinoThemeData Partial Override',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: partialOverrideCards,
        ),
        SizedBox(height: 32.0),

        // Section 5
        Text(
          '5. CupertinoSystemColors Resolution Table',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(children: systemColorRows),
        ),
        SizedBox(height: 32.0),

        // Section 6
        Text(
          '6. Cupertino Widget Text-Style Override Gallery',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.spaceEvenly,
          spacing: 12.0,
          runSpacing: 12.0,
          children: [
            SizedBox(width: 260.0, child: defaultButtonSubtree),
            SizedBox(width: 260.0, child: themedButtonSubtree),
            SizedBox(width: 260.0, child: defaultNavBarSubtree),
            SizedBox(width: 260.0, child: themedNavBarSubtree),
          ],
        ),
        SizedBox(height: 32.0),

        // Section 7
        Text(
          '7. CupertinoTheme inside MaterialApp',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 12.0),
        embeddingDiagram,
        embeddingDemoSubtree,
        SizedBox(height: 32.0),

        // Section 8
        Text(
          '8. Code Examples',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        codeExamplesPanel,
        SizedBox(height: 32.0),

        // Section 9
        Text(
          '9. Summary',
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
        summaryPanel,
      ],
    ),
  );
}

// Helper: build summary takeaway row
Widget _buildTakeaway(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF).withValues(alpha: 0.75),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.4), width: 1.0),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 13.0,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Color(0xFF424242)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
