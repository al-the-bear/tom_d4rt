// ignore_for_file: avoid_print
// D4rt test script: Tests AppBarThemeData from material
// Shows multiple AppBar-like constructions with different themes
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(bottom: 8, top: 16),
    decoration: BoxDecoration(
      color: Colors.blue.shade800,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

// Helper to build a simulated app bar
Widget buildSimulatedAppBar({
  required String title,
  required Color backgroundColor,
  required Color foregroundColor,
  double elevation = 4,
  bool centerTitle = false,
  IconData? leadingIcon,
  List<IconData> actions = const [],
  TextStyle? titleStyle,
  double toolbarHeight = 56,
}) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Material(
      elevation: elevation,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: toolbarHeight,
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            if (leadingIcon != null) ...[
              Icon(leadingIcon, color: foregroundColor, size: 24),
              SizedBox(width: 16),
            ],
            if (centerTitle) Expanded(child: SizedBox()) else SizedBox(),
            Expanded(
              flex: centerTitle ? 0 : 1,
              child: Text(
                title,
                style:
                    titleStyle ??
                    TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: foregroundColor,
                    ),
              ),
            ),
            if (centerTitle) Expanded(child: SizedBox()),
            ...actions.map(
              (icon) => Padding(
                padding: EdgeInsets.only(left: 12),
                child: Icon(icon, color: foregroundColor, size: 24),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Helper to build AppBarTheme info card
Widget buildThemeInfoCard(
  String name,
  Color bgColor,
  Color fgColor,
  double elevation,
  String fontInfo,
  bool centerTitle,
  double toolbarHeight,
) {
  return Card(
    elevation: 2,
    margin: EdgeInsets.symmetric(vertical: 6),
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    'Ab',
                    style: TextStyle(
                      color: fgColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Text(
                name,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 8),
          buildPropertyRow('Background', colorToHex(bgColor), bgColor),
          buildPropertyRow('Foreground', colorToHex(fgColor), fgColor),
          buildPropertyTextRow('Elevation', '$elevation'),
          buildPropertyTextRow('Center Title', '$centerTitle'),
          buildPropertyTextRow('Toolbar Height', '${toolbarHeight.toInt()}px'),
          buildPropertyTextRow('Font', fontInfo),
        ],
      ),
    ),
  );
}

Widget buildPropertyRow(String label, String value, Color colorPreview) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ),
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: colorPreview,
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        SizedBox(width: 6),
        Text(value, style: TextStyle(fontSize: 12)),
      ],
    ),
  );
}

Widget buildPropertyTextRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
        ),
        Text(value, style: TextStyle(fontSize: 12)),
      ],
    ),
  );
}

String colorToHex(Color c) {
  return '#${c.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}';
}

// Helper to build elevation comparison
Widget buildElevationComparison(Color bgColor, Color fgColor) {
  List<double> elevations = [0, 1, 2, 4, 8, 16];
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: elevations.map((elev) {
        return buildSimulatedAppBar(
          title: 'Elevation: $elev',
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          elevation: elev,
          leadingIcon: Icons.menu,
          actions: [Icons.search],
        );
      }).toList(),
    ),
  );
}

// Helper to build a complete app bar scene
Widget buildAppBarScene(
  String sceneName,
  Color backgroundColor,
  Color foregroundColor,
  double elevation,
  String description,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.grey.shade300),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      children: [
        Container(
          height: 56,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: backgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(
                  (elevation * 10).toInt().clamp(0, 80),
                ),
                blurRadius: elevation * 2,
                offset: Offset(0, elevation),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.menu, color: foregroundColor),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  sceneName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: foregroundColor,
                  ),
                ),
              ),
              Icon(Icons.search, color: foregroundColor),
              SizedBox(width: 16),
              Icon(Icons.more_vert, color: foregroundColor),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          color: Colors.grey.shade50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                sceneName,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: backgroundColor.withAlpha(30),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person, color: backgroundColor, size: 24),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 10,
                          width: 120,
                          color: Colors.grey.shade200,
                        ),
                        SizedBox(height: 6),
                        Container(
                          height: 10,
                          width: 200,
                          color: Colors.grey.shade100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper to build toolbar height comparison
Widget buildToolbarHeightComparison(Color bgColor, Color fgColor) {
  List<double> heights = [48, 56, 64, 72, 80];
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: heights.map((h) {
      return buildSimulatedAppBar(
        title: 'Height: ${h.toInt()}px',
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        elevation: 2,
        leadingIcon: Icons.arrow_back,
        toolbarHeight: h,
      );
    }).toList(),
  );
}

// Helper to build title style comparison
Widget buildTitleStyleComparison(Color bgColor, Color fgColor) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildSimulatedAppBar(
        title: 'Bold Title',
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        elevation: 2,
        leadingIcon: Icons.menu,
        titleStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: fgColor,
        ),
      ),
      buildSimulatedAppBar(
        title: 'Light Title',
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        elevation: 2,
        leadingIcon: Icons.menu,
        titleStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w300,
          color: fgColor,
        ),
      ),
      buildSimulatedAppBar(
        title: 'UPPERCASE TITLE',
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        elevation: 2,
        leadingIcon: Icons.menu,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 2,
          color: fgColor,
        ),
      ),
      buildSimulatedAppBar(
        title: 'Small Title',
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        elevation: 2,
        leadingIcon: Icons.menu,
        titleStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: fgColor,
        ),
      ),
      buildSimulatedAppBar(
        title: 'Italic Title',
        backgroundColor: bgColor,
        foregroundColor: fgColor,
        elevation: 2,
        leadingIcon: Icons.menu,
        titleStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          fontStyle: FontStyle.italic,
          color: fgColor,
        ),
      ),
    ],
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== AppBarThemeData Test Script ===');
  debugPrint('Testing AppBarThemeData with different visual configurations');

  ThemeData currentTheme = Theme.of(context);
  debugPrint('Current theme brightness: ${currentTheme.brightness}');
  debugPrint('Current primary color: ${currentTheme.colorScheme.primary}');

  debugPrint('Demonstrating AppBarTheme properties:');
  debugPrint('  - backgroundColor, foregroundColor');
  debugPrint('  - elevation, shadowColor');
  debugPrint('  - centerTitle, titleTextStyle');
  debugPrint('  - toolbarHeight');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade800, Colors.indigo.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'AppBarThemeData Demo',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Different AppBar visual configurations and themes',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        ),

        // Section 1: Color Variations
        buildSectionHeader('1. Background Color Variations'),
        buildSimulatedAppBar(
          title: 'Default Blue',
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          leadingIcon: Icons.menu,
          actions: [Icons.search, Icons.more_vert],
        ),
        buildSimulatedAppBar(
          title: 'Deep Purple',
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          leadingIcon: Icons.menu,
          actions: [Icons.search, Icons.more_vert],
        ),
        buildSimulatedAppBar(
          title: 'Teal',
          backgroundColor: Colors.teal,
          foregroundColor: Colors.white,
          leadingIcon: Icons.menu,
          actions: [Icons.search, Icons.more_vert],
        ),
        buildSimulatedAppBar(
          title: 'Red',
          backgroundColor: Colors.red.shade700,
          foregroundColor: Colors.white,
          leadingIcon: Icons.menu,
          actions: [Icons.search, Icons.more_vert],
        ),
        buildSimulatedAppBar(
          title: 'Surface (Light)',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 2,
          leadingIcon: Icons.menu,
          actions: [Icons.search, Icons.more_vert],
        ),
        buildSimulatedAppBar(
          title: 'Surface (Dark)',
          backgroundColor: Colors.grey.shade900,
          foregroundColor: Colors.white,
          elevation: 2,
          leadingIcon: Icons.menu,
          actions: [Icons.search, Icons.more_vert],
        ),
        buildSimulatedAppBar(
          title: 'Amber',
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black87,
          leadingIcon: Icons.menu,
          actions: [Icons.search, Icons.more_vert],
        ),
        buildSimulatedAppBar(
          title: 'Pink',
          backgroundColor: Colors.pink,
          foregroundColor: Colors.white,
          leadingIcon: Icons.menu,
          actions: [Icons.search, Icons.more_vert],
        ),

        // Section 2: Elevation Comparison
        buildSectionHeader('2. Elevation Comparison'),
        buildElevationComparison(Colors.indigo, Colors.white),

        // Section 3: Center Title vs Left Title
        buildSectionHeader('3. Title Alignment'),
        Text(
          '  Left aligned (default):',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        buildSimulatedAppBar(
          title: 'Left Aligned Title',
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          centerTitle: false,
          leadingIcon: Icons.menu,
          actions: [Icons.search],
        ),
        SizedBox(height: 4),
        Text(
          '  Center aligned:',
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        buildSimulatedAppBar(
          title: 'Center Aligned Title',
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          centerTitle: true,
          leadingIcon: Icons.menu,
          actions: [Icons.search],
        ),

        // Section 4: Title Text Styles
        buildSectionHeader('4. Title Text Styles'),
        buildTitleStyleComparison(Colors.blue.shade800, Colors.white),

        // Section 5: Toolbar Height
        buildSectionHeader('5. Toolbar Height Comparison'),
        buildToolbarHeightComparison(Colors.green.shade700, Colors.white),

        // Section 6: Theme Info Cards
        buildSectionHeader('6. AppBarTheme Configurations'),
        buildThemeInfoCard(
          'Material Default',
          Colors.blue,
          Colors.white,
          4,
          'Roboto 20px w500',
          false,
          56,
        ),
        buildThemeInfoCard(
          'Surface Variant',
          Colors.white,
          Colors.black87,
          0,
          'Roboto 22px w600',
          true,
          56,
        ),
        buildThemeInfoCard(
          'Dark Theme',
          Colors.grey.shade900,
          Colors.white,
          4,
          'Roboto 20px w500',
          false,
          56,
        ),
        buildThemeInfoCard(
          'Compact',
          Colors.indigo,
          Colors.white,
          2,
          'Roboto 18px w500',
          true,
          48,
        ),
        buildThemeInfoCard(
          'Tall Relaxed',
          Colors.teal,
          Colors.white,
          6,
          'Roboto 24px w400',
          false,
          72,
        ),

        // Section 7: App Bar Scenes
        buildSectionHeader('7. Complete App Bar Scenes'),
        buildAppBarScene(
          'Messages',
          Colors.blue.shade700,
          Colors.white,
          4,
          'Standard messaging app with search and menu.',
        ),
        buildAppBarScene(
          'Settings',
          Colors.white,
          Colors.black87,
          1,
          'Settings page with surface-colored app bar.',
        ),
        buildAppBarScene(
          'Media Player',
          Colors.grey.shade900,
          Colors.white,
          0,
          'Dark media player with flat app bar.',
        ),
        buildAppBarScene(
          'Shopping',
          Colors.orange.shade700,
          Colors.white,
          3,
          'E-commerce app with branded accent color.',
        ),

        // Section 8: Leading Icon Variations
        buildSectionHeader('8. Leading Icon Variations'),
        buildSimulatedAppBar(
          title: 'Menu Leading',
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          leadingIcon: Icons.menu,
        ),
        buildSimulatedAppBar(
          title: 'Back Arrow Leading',
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          leadingIcon: Icons.arrow_back,
        ),
        buildSimulatedAppBar(
          title: 'Close Leading',
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
          leadingIcon: Icons.close,
        ),
        buildSimulatedAppBar(
          title: 'No Leading Icon',
          backgroundColor: Colors.blue.shade700,
          foregroundColor: Colors.white,
        ),

        // Section 9: Action Icon Combinations
        buildSectionHeader('9. Action Combinations'),
        buildSimulatedAppBar(
          title: 'No Actions',
          backgroundColor: Colors.purple.shade700,
          foregroundColor: Colors.white,
          leadingIcon: Icons.menu,
        ),
        buildSimulatedAppBar(
          title: 'Single Action',
          backgroundColor: Colors.purple.shade700,
          foregroundColor: Colors.white,
          leadingIcon: Icons.menu,
          actions: [Icons.search],
        ),
        buildSimulatedAppBar(
          title: 'Two Actions',
          backgroundColor: Colors.purple.shade700,
          foregroundColor: Colors.white,
          leadingIcon: Icons.menu,
          actions: [Icons.search, Icons.more_vert],
        ),
        buildSimulatedAppBar(
          title: 'Three Actions',
          backgroundColor: Colors.purple.shade700,
          foregroundColor: Colors.white,
          leadingIcon: Icons.menu,
          actions: [Icons.search, Icons.favorite, Icons.more_vert],
        ),
        buildSimulatedAppBar(
          title: 'Many Actions',
          backgroundColor: Colors.purple.shade700,
          foregroundColor: Colors.white,
          leadingIcon: Icons.menu,
          actions: [
            Icons.search,
            Icons.favorite,
            Icons.share,
            Icons.notifications,
            Icons.more_vert,
          ],
        ),

        SizedBox(height: 32),
        Center(
          child: Text(
            'End of AppBarThemeData Demo',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
