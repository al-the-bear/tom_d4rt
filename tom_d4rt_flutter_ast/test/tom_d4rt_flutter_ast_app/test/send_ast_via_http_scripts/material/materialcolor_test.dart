// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MaterialColor, MaterialAccentColor from material
// Deep Demo: Visual demonstration of the Material color system, swatches,
// custom MaterialColor construction, accent colors, and themed UI fragments.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MaterialColor Deep Demo executing');

  // ============================================================
  // SECTION 1: Understanding the Material Color System
  // ============================================================
  print('=== Section 1: Material Color System Overview ===');

  final conceptCards = <Widget>[];

  // Concept 1: What is a MaterialColor
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.indigo.shade50, Colors.blue.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.indigo.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.palette, size: 48.0, color: Colors.indigo),
          SizedBox(height: 12.0),
          Text(
            'MaterialColor',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'A primary color with 10 tonal shades:\n50, 100, 200 ... 900',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 2: What is a MaterialAccentColor
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.pink.shade50, Colors.deepPurple.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.pink.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.auto_awesome, size: 48.0, color: Colors.pink),
          SizedBox(height: 12.0),
          Text(
            'MaterialAccentColor',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.pink.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Bright accents for highlights:\n100, 200, 400, 700',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.pink.shade700),
          ),
        ],
      ),
    ),
  );

  // Concept 3: Lookup syntax
  conceptCards.add(
    Container(
      width: 240.0,
      margin: EdgeInsets.all(12.0),
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal.shade50, Colors.green.shade50],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Colors.teal.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withValues(alpha: 0.2),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.search, size: 48.0, color: Colors.teal),
          SizedBox(height: 12.0),
          Text(
            'Shade Lookup',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.teal.shade900,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Use .shade500 or [500]\nto access individual shades',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.0, color: Colors.teal.shade700),
          ),
        ],
      ),
    ),
  );

  print('Created ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Full Blue Swatch (all 10 shades)
  // ============================================================
  print('=== Section 2: Colors.blue full swatch (50..900) ===');

  final blueShadeData = <Map<String, dynamic>>[
    {'key': 50, 'color': Colors.blue.shade50, 'dark': false},
    {'key': 100, 'color': Colors.blue.shade100, 'dark': false},
    {'key': 200, 'color': Colors.blue.shade200, 'dark': false},
    {'key': 300, 'color': Colors.blue.shade300, 'dark': false},
    {'key': 400, 'color': Colors.blue.shade400, 'dark': true},
    {'key': 500, 'color': Colors.blue.shade500, 'dark': true},
    {'key': 600, 'color': Colors.blue.shade600, 'dark': true},
    {'key': 700, 'color': Colors.blue.shade700, 'dark': true},
    {'key': 800, 'color': Colors.blue.shade800, 'dark': true},
    {'key': 900, 'color': Colors.blue.shade900, 'dark': true},
  ];

  final blueSwatchTiles = <Widget>[];
  for (final entry in blueShadeData) {
    final key = entry['key'] as int;
    final color = entry['color'] as Color;
    final dark = entry['dark'] as bool;
    final textColor = dark ? Colors.white : Colors.black87;

    print('Colors.blue.shade$key created');

    blueSwatchTiles.add(
      Container(
        width: 90.0,
        height: 90.0,
        margin: EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$key',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: 4.0),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: dark
                    ? Colors.white.withValues(alpha: 0.2)
                    : Colors.black.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                'blue',
                style: TextStyle(
                  fontSize: 10.0,
                  color: textColor,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  print('Created ${blueSwatchTiles.length} blue swatch tiles');

  // Show the bracket lookup variant
  final bracketLookupRow = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.blue.shade200, width: 1.5),
    ),
    child: Row(
      children: [
        Icon(Icons.code, color: Colors.blue.shade700, size: 20.0),
        SizedBox(width: 8.0),
        Expanded(
          child: Text(
            'Colors.blue[200] == Colors.blue.shade200',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              color: Colors.blue.shade900,
            ),
          ),
        ),
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: Colors.blue[200],
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: Colors.blue.shade400, width: 1.0),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Multi-Swatch Comparison
  // ============================================================
  print('=== Section 3: Multi-swatch comparison ===');

  final swatchSeries = <Map<String, dynamic>>[
    {'name': 'red', 'swatch': Colors.red, 'icon': Icons.local_fire_department},
    {'name': 'green', 'swatch': Colors.green, 'icon': Icons.eco},
    {'name': 'orange', 'swatch': Colors.orange, 'icon': Icons.wb_sunny},
    {'name': 'purple', 'swatch': Colors.purple, 'icon': Icons.spa},
    {'name': 'teal', 'swatch': Colors.teal, 'icon': Icons.waves},
    {'name': 'indigo', 'swatch': Colors.indigo, 'icon': Icons.nightlight_round},
    {'name': 'brown', 'swatch': Colors.brown, 'icon': Icons.park},
    {'name': 'blueGrey', 'swatch': Colors.blueGrey, 'icon': Icons.cloud},
  ];

  final shadeKeys = <int>[50, 100, 200, 300, 400, 500, 600, 700, 800, 900];

  Widget buildSwatchRow(Map<String, dynamic> entry) {
    final name = entry['name'] as String;
    final swatch = entry['swatch'] as MaterialColor;
    final icon = entry['icon'] as IconData;

    final tiles = <Widget>[];
    for (final key in shadeKeys) {
      Color shade;
      switch (key) {
        case 50:
          shade = swatch.shade50;
          break;
        case 100:
          shade = swatch.shade100;
          break;
        case 200:
          shade = swatch.shade200;
          break;
        case 300:
          shade = swatch.shade300;
          break;
        case 400:
          shade = swatch.shade400;
          break;
        case 500:
          shade = swatch.shade500;
          break;
        case 600:
          shade = swatch.shade600;
          break;
        case 700:
          shade = swatch.shade700;
          break;
        case 800:
          shade = swatch.shade800;
          break;
        default:
          shade = swatch.shade900;
      }
      final dark = key >= 400;
      tiles.add(
        Expanded(
          child: Container(
            height: 44.0,
            margin: EdgeInsets.symmetric(horizontal: 2.0),
            decoration: BoxDecoration(
              color: shade,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Center(
              child: Text(
                '$key',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                  color: dark ? Colors.white : Colors.black87,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey.shade300, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 28.0,
                height: 28.0,
                decoration: BoxDecoration(
                  color: swatch,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 16.0, color: Colors.white),
              ),
              SizedBox(width: 10.0),
              Text(
                'Colors.$name',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: swatch.shade900,
                ),
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                decoration: BoxDecoration(
                  color: swatch.shade100,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  '10 shades',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: swatch.shade900,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(children: tiles),
        ],
      ),
    );
  }

  final swatchRows = <Widget>[];
  for (final entry in swatchSeries) {
    swatchRows.add(buildSwatchRow(entry));
    print('Built swatch row for ${entry['name']}');
  }

  // ============================================================
  // SECTION 4: MaterialAccentColor Variants
  // ============================================================
  print('=== Section 4: MaterialAccentColor variants ===');

  final accentSeries = <Map<String, dynamic>>[
    {'name': 'redAccent', 'swatch': Colors.redAccent},
    {'name': 'pinkAccent', 'swatch': Colors.pinkAccent},
    {'name': 'purpleAccent', 'swatch': Colors.purpleAccent},
    {'name': 'deepPurpleAccent', 'swatch': Colors.deepPurpleAccent},
    {'name': 'indigoAccent', 'swatch': Colors.indigoAccent},
    {'name': 'blueAccent', 'swatch': Colors.blueAccent},
    {'name': 'lightBlueAccent', 'swatch': Colors.lightBlueAccent},
    {'name': 'cyanAccent', 'swatch': Colors.cyanAccent},
    {'name': 'tealAccent', 'swatch': Colors.tealAccent},
    {'name': 'greenAccent', 'swatch': Colors.greenAccent},
    {'name': 'orangeAccent', 'swatch': Colors.orangeAccent},
    {'name': 'deepOrangeAccent', 'swatch': Colors.deepOrangeAccent},
  ];

  final accentKeys = <int>[100, 200, 400, 700];

  Widget buildAccentTile(MaterialAccentColor swatch, String name) {
    final tiles = <Widget>[];
    for (final key in accentKeys) {
      Color shade;
      switch (key) {
        case 100:
          shade = swatch.shade100;
          break;
        case 200:
          shade = swatch.shade200;
          break;
        case 400:
          shade = swatch.shade400;
          break;
        default:
          shade = swatch.shade700;
      }
      final dark = key >= 400;
      tiles.add(
        Container(
          width: 36.0,
          height: 32.0,
          margin: EdgeInsets.symmetric(horizontal: 2.0),
          decoration: BoxDecoration(
            color: shade,
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Center(
            child: Text(
              '$key',
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: dark ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      width: 220.0,
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: swatch.shade200, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: swatch.withValues(alpha: 0.15),
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
              Container(
                width: 14.0,
                height: 14.0,
                decoration: BoxDecoration(
                  color: swatch,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: swatch.shade700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(mainAxisSize: MainAxisSize.min, children: tiles),
        ],
      ),
    );
  }

  final accentTiles = <Widget>[];
  for (final entry in accentSeries) {
    final swatch = entry['swatch'] as MaterialAccentColor;
    final name = entry['name'] as String;
    accentTiles.add(buildAccentTile(swatch, name));
    print('Built accent tile for $name');
  }

  // ============================================================
  // SECTION 5: Custom MaterialColor Construction
  // ============================================================
  print('=== Section 5: Custom MaterialColor construction ===');

  // Brand A: Tom Green
  final brandTomGreen = MaterialColor(0xFF2E7D55, <int, Color>{
    50: Color(0xFFE3F4EC),
    100: Color(0xFFBAE3CF),
    200: Color(0xFF8DD1B0),
    300: Color(0xFF5FBE91),
    400: Color(0xFF3CB07A),
    500: Color(0xFF2E7D55),
    600: Color(0xFF29714D),
    700: Color(0xFF236244),
    800: Color(0xFF1D533B),
    900: Color(0xFF13392A),
  });
  print('Custom MaterialColor brandTomGreen created');

  // Brand B: Tom Sunset
  final brandTomSunset = MaterialColor(0xFFE65A2E, <int, Color>{
    50: Color(0xFFFDECE5),
    100: Color(0xFFFACEBE),
    200: Color(0xFFF7AD92),
    300: Color(0xFFF38B66),
    400: Color(0xFFF07246),
    500: Color(0xFFE65A2E),
    600: Color(0xFFDD522A),
    700: Color(0xFFD24824),
    800: Color(0xFFC73E1E),
    900: Color(0xFFB52D14),
  });
  print('Custom MaterialColor brandTomSunset created');

  Widget buildCustomBrandPanel(
    String label,
    MaterialColor swatch,
    String hexPrimary,
  ) {
    final tiles = <Widget>[];
    for (final key in shadeKeys) {
      Color shade;
      switch (key) {
        case 50:
          shade = swatch.shade50;
          break;
        case 100:
          shade = swatch.shade100;
          break;
        case 200:
          shade = swatch.shade200;
          break;
        case 300:
          shade = swatch.shade300;
          break;
        case 400:
          shade = swatch.shade400;
          break;
        case 500:
          shade = swatch.shade500;
          break;
        case 600:
          shade = swatch.shade600;
          break;
        case 700:
          shade = swatch.shade700;
          break;
        case 800:
          shade = swatch.shade800;
          break;
        default:
          shade = swatch.shade900;
      }
      final dark = key >= 400;
      tiles.add(
        Container(
          width: 50.0,
          height: 50.0,
          margin: EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            color: shade,
            borderRadius: BorderRadius.circular(7.0),
          ),
          child: Center(
            child: Text(
              '$key',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: dark ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      width: 320.0,
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: swatch.shade300, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: swatch.withValues(alpha: 0.25),
            blurRadius: 10.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.0,
                height: 40.0,
                decoration: BoxDecoration(
                  color: swatch,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(Icons.brush, color: Colors.white, size: 22.0),
              ),
              SizedBox(width: 10.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: swatch.shade900,
                      ),
                    ),
                    Text(
                      hexPrimary,
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 11.0,
                        color: swatch.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          Wrap(children: tiles),
          SizedBox(height: 10.0),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: swatch.shade50,
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              'primary == .shade500',
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: swatch.shade800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final brandPanels = Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildCustomBrandPanel('Tom Green', brandTomGreen, '#2E7D55'),
      buildCustomBrandPanel('Tom Sunset', brandTomSunset, '#E65A2E'),
    ],
  );

  // Dark code panel showing custom construction
  final customConstructionPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Custom MaterialColor Construction',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'final brandTomGreen = MaterialColor(\n'
            '  0xFF2E7D55,\n'
            '  <int, Color>{\n'
            '    50:  Color(0xFFE3F4EC),\n'
            '    100: Color(0xFFBAE3CF),\n'
            '    200: Color(0xFF8DD1B0),\n'
            '    300: Color(0xFF5FBE91),\n'
            '    400: Color(0xFF3CB07A),\n'
            '    500: Color(0xFF2E7D55),\n'
            '    600: Color(0xFF29714D),\n'
            '    700: Color(0xFF236244),\n'
            '    800: Color(0xFF1D533B),\n'
            '    900: Color(0xFF13392A),\n'
            '  },\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Real-World Themed UI Fragment
  // ============================================================
  print('=== Section 6: Real-world themed UI fragment ===');

  final themed = brandTomGreen;

  Widget themedAppBar = Container(
    padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
    decoration: BoxDecoration(
      color: themed.shade700,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      ),
      boxShadow: [
        BoxShadow(
          color: themed.withValues(alpha: 0.4),
          blurRadius: 8.0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(Icons.menu, color: Colors.white, size: 22.0),
        SizedBox(width: 12.0),
        Text(
          'Tom Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(Icons.search, color: Colors.white, size: 22.0),
        SizedBox(width: 14.0),
        Icon(Icons.notifications_none, color: Colors.white, size: 22.0),
        SizedBox(width: 14.0),
        Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: themed.shade300,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2.0),
          ),
          child: Icon(Icons.person, color: Colors.white, size: 16.0),
        ),
      ],
    ),
  );

  Widget themedChip(String label, IconData icon, int shadeKey) {
    Color bg;
    switch (shadeKey) {
      case 100:
        bg = themed.shade100;
        break;
      case 200:
        bg = themed.shade200;
        break;
      case 300:
        bg = themed.shade300;
        break;
      default:
        bg = themed.shade50;
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: themed.shade400, width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14.0, color: themed.shade800),
          SizedBox(width: 6.0),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              color: themed.shade900,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget themedCard(String title, String value, IconData icon, int shadeKey) {
    Color accent;
    switch (shadeKey) {
      case 400:
        accent = themed.shade400;
        break;
      case 500:
        accent = themed.shade500;
        break;
      case 600:
        accent = themed.shade600;
        break;
      default:
        accent = themed.shade700;
    }
    return Container(
      width: 150.0,
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border(
          left: BorderSide(color: accent, width: 4.0),
        ),
        boxShadow: [
          BoxShadow(
            color: themed.withValues(alpha: 0.15),
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
              Icon(icon, size: 18.0, color: accent),
              SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12.0,
                  color: themed.shade700,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: themed.shade900,
            ),
          ),
        ],
      ),
    );
  }

  final themedFragment = Container(
    margin: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: themed.shade50,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: themed.shade200, width: 1.5),
    ),
    child: Column(
      children: [
        themedAppBar,
        Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Project filters',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: themed.shade800,
                ),
              ),
              SizedBox(height: 6.0),
              Wrap(
                children: [
                  themedChip('Active', Icons.check_circle_outline, 100),
                  themedChip('Pending', Icons.hourglass_top, 200),
                  themedChip('Archived', Icons.archive, 50),
                  themedChip('Starred', Icons.star_border, 300),
                  themedChip('Shared', Icons.group, 100),
                ],
              ),
              SizedBox(height: 12.0),
              Text(
                'Metrics',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: themed.shade800,
                ),
              ),
              SizedBox(height: 6.0),
              Wrap(
                children: [
                  themedCard('Tasks', '128', Icons.task_alt, 500),
                  themedCard('Build OK', '94%', Icons.verified, 600),
                  themedCard('Open PRs', '12', Icons.merge_type, 400),
                  themedCard('Alerts', '3', Icons.warning_amber, 700),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Code Examples
  // ============================================================
  print('=== Section 7: Code examples ===');

  final codeExamples = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.terminal, color: Colors.cyan.shade400, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Usage Patterns',
              style: TextStyle(
                color: Colors.cyan.shade400,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Predefined MaterialColors\n'
            'final swatch = Colors.blue;            // MaterialColor\n'
            'final primary = swatch.shade500;        // == swatch[500]\n'
            'final pale = Colors.blue.shade50;       // very light\n'
            'final deep = Colors.blue.shade900;      // very dark\n'
            '\n'
            '// Bracket lookup is equivalent\n'
            'final mid = Colors.blue[200];           // shade200',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// MaterialAccentColor has only 4 shades:\n'
            '//   100, 200, 400, 700\n'
            'final accent = Colors.pinkAccent;       // MaterialAccentColor\n'
            'final hot = Colors.pinkAccent.shade400; // bright accent\n'
            'final pop = Colors.pinkAccent.shade700; // strong accent',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.purple.shade300,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade800,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Use a custom swatch as a theme primary\n'
            'MaterialApp(\n'
            '  theme: ThemeData(primarySwatch: brandTomGreen),\n'
            '  home: HomePage(),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.amber.shade300,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Summary Panel
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade100, Colors.purple.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade300, width: 2.0),
    ),
    child: Column(
      children: [
        Text(
          'Key Takeaways',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade900,
          ),
        ),
        SizedBox(height: 16.0),
        _buildSummaryItem(
          Icons.palette,
          'MaterialColor = swatch + 10 shades',
          '50, 100, 200, 300, 400, 500, 600, 700, 800, 900',
          Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.auto_awesome,
          'MaterialAccentColor = 4 bright shades',
          'Only 100, 200, 400, 700 are defined',
          Colors.pink,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.search,
          'Lookup: .shadeNNN or [NNN]',
          'Colors.blue.shade200 == Colors.blue[200]',
          Colors.blue,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.brush,
          'Custom swatches via constructor',
          'MaterialColor(primary, <int, Color>{50: ..., 900: ...})',
          Colors.green,
        ),
        SizedBox(height: 8.0),
        _buildSummaryItem(
          Icons.style,
          'Drive entire themes',
          'Use a MaterialColor as primarySwatch in ThemeData',
          Colors.orange,
        ),
      ],
    ),
  );

  print('MaterialColor Deep Demo completed successfully');

  // ============================================================
  // Return complete visual layout wrapped in MaterialApp
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo, Colors.purple, Colors.pink],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.purple.withValues(alpha: 0.3),
                    blurRadius: 12.0,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Icon(Icons.palette, size: 56.0, color: Colors.white),
                  SizedBox(height: 8.0),
                  Text(
                    'MaterialColor',
                    style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'The Material color system, swatches & themes',
                    style: TextStyle(fontSize: 14.0, color: Colors.white70),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),

            // Section 1
            Text(
              '1. Understanding the Material Color System',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(
              alignment: WrapAlignment.center,
              children: conceptCards,
            ),
            SizedBox(height: 32.0),

            // Section 2
            Text(
              '2. Colors.blue Full Swatch (50..900)',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(alignment: WrapAlignment.center, children: blueSwatchTiles),
            bracketLookupRow,
            SizedBox(height: 32.0),

            // Section 3
            Text(
              '3. Multi-Swatch Comparison',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Column(children: swatchRows),
            SizedBox(height: 32.0),

            // Section 4
            Text(
              '4. MaterialAccentColor Variants (100/200/400/700)',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Wrap(alignment: WrapAlignment.center, children: accentTiles),
            SizedBox(height: 32.0),

            // Section 5
            Text(
              '5. Custom MaterialColor Construction',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            customConstructionPanel,
            SizedBox(height: 12.0),
            brandPanels,
            SizedBox(height: 32.0),

            // Section 6
            Text(
              '6. Real-World Themed UI Fragment',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            themedFragment,
            SizedBox(height: 32.0),

            // Section 7
            Text(
              '7. Code Examples',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            codeExamples,
            SizedBox(height: 32.0),

            // Section 8
            Text(
              '8. Summary',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            summaryPanel,
          ],
        ),
      ),
    ),
  );
}

// Helper: Build summary item
Widget _buildSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3), width: 1.0),
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
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
