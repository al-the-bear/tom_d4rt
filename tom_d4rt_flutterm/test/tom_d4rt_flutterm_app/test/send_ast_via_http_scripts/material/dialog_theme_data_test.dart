// ignore_for_file: avoid_print
// D4rt test script: Tests DialogThemeData concepts from package:flutter/material.dart
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  debugPrint('=== DialogThemeData Visual Demo ===');
  debugPrint(
    'Demonstrating dialog theme configurations: colors, shapes, elevations, and text styles',
  );

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DialogThemeData Demo'),
        backgroundColor: Color(0xFF5D4037),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('Background Color Themes'),
            SizedBox(height: 8),
            _buildBackgroundColorThemes(),
            SizedBox(height: 24),
            _buildSectionHeader('Title Text Styles'),
            SizedBox(height: 8),
            _buildTitleTextStyles(),
            SizedBox(height: 24),
            _buildSectionHeader('Content Text Styles'),
            SizedBox(height: 8),
            _buildContentTextStyles(),
            SizedBox(height: 24),
            _buildSectionHeader('Elevation Variations'),
            SizedBox(height: 8),
            _buildElevationVariations(),
            SizedBox(height: 24),
            _buildSectionHeader('Shape / Border Radius'),
            SizedBox(height: 8),
            _buildShapeVariations(),
            SizedBox(height: 24),
            _buildSectionHeader('Surface Tint Color'),
            SizedBox(height: 8),
            _buildSurfaceTintColors(),
            SizedBox(height: 24),
            _buildSectionHeader('Alignment Options'),
            SizedBox(height: 8),
            _buildAlignmentOptions(),
            SizedBox(height: 24),
            _buildSectionHeader('Icon Color Themes'),
            SizedBox(height: 8),
            _buildIconColorThemes(),
            SizedBox(height: 24),
            _buildSectionHeader('Action Button Styles'),
            SizedBox(height: 8),
            _buildActionButtonStyles(),
            SizedBox(height: 24),
            _buildSectionHeader('Theme Composition'),
            SizedBox(height: 8),
            _buildThemeComposition(),
            SizedBox(height: 32),
          ],
        ),
      ),
    ),
  );
}

Widget _buildSectionHeader(String title) {
  debugPrint('Building section: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Color(0xFF5D4037),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        color: Color(0xFFFFFFFF),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

Widget _buildBackgroundColorThemes() {
  debugPrint('Building background color themes');
  List<Map<String, dynamic>> themes = [
    {
      'label': 'Default White',
      'bg': Color(0xFFFFFFFF),
      'text': Color(0xFF212121),
      'border': Color(0xFFE0E0E0),
    },
    {
      'label': 'Surface Variant',
      'bg': Color(0xFFF5F5F5),
      'text': Color(0xFF424242),
      'border': Color(0xFFBDBDBD),
    },
    {
      'label': 'Dark Theme',
      'bg': Color(0xFF424242),
      'text': Color(0xFFEEEEEE),
      'border': Color(0xFF616161),
    },
    {
      'label': 'Warm Sepia',
      'bg': Color(0xFFFFF8E1),
      'text': Color(0xFF5D4037),
      'border': Color(0xFFBCAAA4),
    },
    {
      'label': 'Cool Blue',
      'bg': Color(0xFFE3F2FD),
      'text': Color(0xFF1565C0),
      'border': Color(0xFF90CAF9),
    },
    {
      'label': 'Mint Green',
      'bg': Color(0xFFE0F2F1),
      'text': Color(0xFF00695C),
      'border': Color(0xFF80CBC4),
    },
  ];
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: themes.map((t) {
      return Container(
        width: 170,
        decoration: BoxDecoration(
          color: t['bg'] as Color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: t['border'] as Color, width: 2),
          boxShadow: [
            BoxShadow(
              color: Color(0x22000000),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    t['label'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: t['text'] as Color,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Dialog body text with the theme-defined background and foreground colors applied.',
                    style: TextStyle(
                      fontSize: 10,
                      color: (t['text'] as Color).withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Cancel',
                    style: TextStyle(
                      color: (t['text'] as Color).withValues(alpha: 0.6),
                      fontSize: 11,
                    ),
                  ),
                  SizedBox(width: 12),
                  Text(
                    'OK',
                    style: TextStyle(
                      color: t['text'] as Color,
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildTitleTextStyles() {
  debugPrint('Building title text styles');
  List<Map<String, dynamic>> styles = [
    {
      'label': 'Default',
      'size': 20.0,
      'weight': FontWeight.w500,
      'color': Color(0xFF212121),
    },
    {
      'label': 'Bold Large',
      'size': 24.0,
      'weight': FontWeight.bold,
      'color': Color(0xFF1565C0),
    },
    {
      'label': 'Light Medium',
      'size': 18.0,
      'weight': FontWeight.w300,
      'color': Color(0xFF616161),
    },
    {
      'label': 'Compact',
      'size': 16.0,
      'weight': FontWeight.w600,
      'color': Color(0xFF5D4037),
    },
    {
      'label': 'Display',
      'size': 28.0,
      'weight': FontWeight.w700,
      'color': Color(0xFF6A1B9A),
    },
  ];
  return Column(
    children: styles.map((s) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 90,
              child: Text(
                s['label'] as String,
                style: TextStyle(
                  fontSize: 11,
                  color: Color(0xFF757575),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: Text(
                'Dialog Title',
                style: TextStyle(
                  fontSize: s['size'] as double,
                  fontWeight: s['weight'] as FontWeight,
                  color: s['color'] as Color,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '${(s['size'] as double).toInt()}sp',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: Color(0xFF757575),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildContentTextStyles() {
  debugPrint('Building content text styles');
  List<Map<String, dynamic>> styles = [
    {
      'label': 'Body Medium',
      'size': 14.0,
      'height': 1.4,
      'color': Color(0xFF616161),
    },
    {
      'label': 'Body Large',
      'size': 16.0,
      'height': 1.5,
      'color': Color(0xFF424242),
    },
    {
      'label': 'Body Small',
      'size': 12.0,
      'height': 1.3,
      'color': Color(0xFF757575),
    },
    {
      'label': 'Emphasis',
      'size': 14.0,
      'height': 1.4,
      'color': Color(0xFF212121),
    },
  ];
  return Column(
    children: styles.map((s) {
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  s['label'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Color(0xFF5D4037),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
                  decoration: BoxDecoration(
                    color: Color(0xFFEFEBE9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '${(s['size'] as double).toInt()}sp / ${s['height']}x',
                    style: TextStyle(fontSize: 9, fontFamily: 'monospace'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6),
            Text(
              'This is sample dialog content text to show how body text looks with the defined text style, size, line height, and color settings.',
              style: TextStyle(
                fontSize: s['size'] as double,
                height: s['height'] as double,
                color: s['color'] as Color,
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildElevationVariations() {
  debugPrint('Building elevation variations');
  List<Map<String, dynamic>> elevations = [
    {'label': 'Flat (0)', 'value': 0.0},
    {'label': 'Low (2)', 'value': 2.0},
    {'label': 'Default (6)', 'value': 6.0},
    {'label': 'High (12)', 'value': 12.0},
    {'label': 'Max (24)', 'value': 24.0},
  ];
  return Row(
    children: elevations.map((e) {
      double elev = e['value'] as double;
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE0E0E0)),
            boxShadow: [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: elev,
                offset: Offset(0, elev / 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Text(
                e['label'] as String,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
              ),
              SizedBox(height: 6),
              Container(
                height: 4,
                width: 40,
                decoration: BoxDecoration(
                  color: Color(0xFF5D4037),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 4),
              Container(
                height: 4,
                width: 30,
                decoration: BoxDecoration(
                  color: Color(0xFFBCAAA4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'OK',
                style: TextStyle(
                  color: Color(0xFF5D4037),
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

Widget _buildShapeVariations() {
  debugPrint('Building shape variations');
  List<Map<String, dynamic>> shapes = [
    {'label': 'Rectangle', 'radius': 0.0, 'color': Color(0xFFF44336)},
    {'label': 'Rounded-SM', 'radius': 4.0, 'color': Color(0xFFFF9800)},
    {'label': 'Rounded-MD', 'radius': 12.0, 'color': Color(0xFF4CAF50)},
    {'label': 'Rounded-LG', 'radius': 28.0, 'color': Color(0xFF2196F3)},
    {'label': 'Rounded-XL', 'radius': 36.0, 'color': Color(0xFF9C27B0)},
  ];
  return Row(
    children: shapes.map((s) {
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4),
          height: 100,
          decoration: BoxDecoration(
            color: (s['color'] as Color).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(s['radius'] as double),
            border: Border.all(color: s['color'] as Color, width: 2),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  s['label'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: s['color'] as Color,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'r=${(s['radius'] as double).toInt()}',
                  style: TextStyle(
                    fontSize: 9,
                    fontFamily: 'monospace',
                    color: Color(0xFF757575),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }).toList(),
  );
}

Widget _buildSurfaceTintColors() {
  debugPrint('Building surface tint colors');
  List<Map<String, dynamic>> tints = [
    {'label': 'No Tint', 'tint': Color(0x00000000), 'bg': Color(0xFFFFFFFF)},
    {
      'label': 'Primary Tint',
      'tint': Color(0x1A6200EA),
      'bg': Color(0xFFEDE7F6),
    },
    {'label': 'Warm Tint', 'tint': Color(0x1AFF6F00), 'bg': Color(0xFFFFF3E0)},
    {'label': 'Cool Tint', 'tint': Color(0x1A00ACC1), 'bg': Color(0xFFE0F7FA)},
    {
      'label': 'Success Tint',
      'tint': Color(0x1A4CAF50),
      'bg': Color(0xFFE8F5E9),
    },
    {'label': 'Error Tint', 'tint': Color(0x1AF44336), 'bg': Color(0xFFFFEBEE)},
  ];
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: tints.map((t) {
      return Container(
        width: 170,
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: t['bg'] as Color,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xFFE0E0E0)),
          boxShadow: [BoxShadow(color: Color(0x11000000), blurRadius: 4)],
        ),
        child: Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: t['tint'] as Color,
                shape: BoxShape.circle,
                border: Border.all(color: Color(0xFFBDBDBD)),
              ),
            ),
            SizedBox(height: 8),
            Text(
              t['label'] as String,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            ),
            SizedBox(height: 4),
            Text(
              'Surface tint overlays the dialog background to create depth cues.',
              style: TextStyle(fontSize: 9, color: Color(0xFF757575)),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildAlignmentOptions() {
  debugPrint('Building alignment options');
  List<Map<String, dynamic>> alignments = [
    {
      'label': 'Center (default)',
      'alignment': Alignment.center,
      'color': Color(0xFF5D4037),
    },
    {
      'label': 'Top Center',
      'alignment': Alignment.topCenter,
      'color': Color(0xFF1565C0),
    },
    {
      'label': 'Bottom Center',
      'alignment': Alignment.bottomCenter,
      'color': Color(0xFF2E7D32),
    },
    {
      'label': 'Center Left',
      'alignment': Alignment.centerLeft,
      'color': Color(0xFFFF6F00),
    },
    {
      'label': 'Center Right',
      'alignment': Alignment.centerRight,
      'color': Color(0xFF6A1B9A),
    },
  ];
  return Column(
    children: alignments.map((a) {
      Alignment align = a['alignment'] as Alignment;
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: align,
                child: Container(
                  width: 120,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: a['color'] as Color, width: 2),
                    boxShadow: [
                      BoxShadow(color: Color(0x22000000), blurRadius: 4),
                    ],
                  ),
                  child: Text(
                    a['label'] as String,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: a['color'] as Color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildIconColorThemes() {
  debugPrint('Building icon color themes');
  List<Map<String, dynamic>> iconThemes = [
    {
      'label': 'Default',
      'color': Color(0xFF757575),
      'icon': Icons.info_outline,
    },
    {'label': 'Primary', 'color': Color(0xFF5D4037), 'icon': Icons.info},
    {
      'label': 'Warning',
      'color': Color(0xFFFF9800),
      'icon': Icons.warning_amber,
    },
    {'label': 'Error', 'color': Color(0xFFF44336), 'icon': Icons.error_outline},
    {
      'label': 'Success',
      'color': Color(0xFF4CAF50),
      'icon': Icons.check_circle_outline,
    },
    {'label': 'Info', 'color': Color(0xFF2196F3), 'icon': Icons.info_outline},
  ];
  return Row(
    children: iconThemes.map((t) {
      return Expanded(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 3),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: (t['color'] as Color).withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: t['color'] as Color),
          ),
          child: Column(
            children: [
              Icon(t['icon'] as IconData, color: t['color'] as Color, size: 30),
              SizedBox(height: 6),
              Text(
                t['label'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 10,
                  color: t['color'] as Color,
                ),
              ),
            ],
          ),
        ),
      );
    }).toList(),
  );
}

Widget _buildActionButtonStyles() {
  debugPrint('Building action button styles');
  List<Map<String, dynamic>> btnStyles = [
    {
      'label': 'Text Buttons',
      'style': 'flat',
      'primary': Color(0xFF5D4037),
      'secondary': Color(0xFF757575),
    },
    {
      'label': 'Filled Primary',
      'style': 'filled',
      'primary': Color(0xFF5D4037),
      'secondary': Color(0xFF757575),
    },
    {
      'label': 'Outlined',
      'style': 'outlined',
      'primary': Color(0xFF1565C0),
      'secondary': Color(0xFF90CAF9),
    },
    {
      'label': 'Tonal',
      'style': 'tonal',
      'primary': Color(0xFF6A1B9A),
      'secondary': Color(0xFFE1BEE7),
    },
  ];
  return Column(
    children: btnStyles.map((bs) {
      bool isFilled = bs['style'] == 'filled';
      bool isOutlined = bs['style'] == 'outlined';
      bool isTonal = bs['style'] == 'tonal';
      return Container(
        margin: EdgeInsets.only(bottom: 8),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Color(0xFFFFFFFF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFE0E0E0)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 110,
              child: Text(
                bs['label'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Color(0xFF757575),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isTonal
                          ? (bs['secondary'] as Color).withValues(alpha: 0.3)
                          : Color(0x00000000),
                      borderRadius: BorderRadius.circular(20),
                      border: isOutlined
                          ? Border.all(color: bs['secondary'] as Color)
                          : null,
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: bs['secondary'] as Color,
                        fontSize: 12,
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isFilled
                          ? bs['primary'] as Color
                          : (isTonal
                                ? (bs['primary'] as Color).withValues(
                                    alpha: 0.15,
                                  )
                                : Color(0x00000000)),
                      borderRadius: BorderRadius.circular(20),
                      border: isOutlined
                          ? Border.all(color: bs['primary'] as Color)
                          : null,
                    ),
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        color: isFilled
                            ? Color(0xFFFFFFFF)
                            : bs['primary'] as Color,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildThemeComposition() {
  debugPrint('Building theme composition');
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DialogTheme Data Hierarchy',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 12),
        _buildHierarchyItem(
          0,
          'ThemeData',
          'Root application theme',
          Color(0xFF5D4037),
        ),
        _buildHierarchyItem(
          1,
          'DialogTheme',
          'Dialog-specific overrides',
          Color(0xFF1565C0),
        ),
        _buildHierarchyItem(
          2,
          'backgroundColor',
          'Dialog surface color',
          Color(0xFF4CAF50),
        ),
        _buildHierarchyItem(
          2,
          'elevation',
          'Shadow depth (dp)',
          Color(0xFF4CAF50),
        ),
        _buildHierarchyItem(
          2,
          'shadowColor',
          'Shadow color',
          Color(0xFF4CAF50),
        ),
        _buildHierarchyItem(
          2,
          'surfaceTintColor',
          'Tint overlay color',
          Color(0xFF4CAF50),
        ),
        _buildHierarchyItem(
          2,
          'shape',
          'OutlinedBorder shape',
          Color(0xFF4CAF50),
        ),
        _buildHierarchyItem(
          2,
          'alignment',
          'Dialog alignment on screen',
          Color(0xFF4CAF50),
        ),
        _buildHierarchyItem(
          2,
          'titleTextStyle',
          'TextStyle for title',
          Color(0xFFFF9800),
        ),
        _buildHierarchyItem(
          2,
          'contentTextStyle',
          'TextStyle for body',
          Color(0xFFFF9800),
        ),
        _buildHierarchyItem(
          2,
          'actionsPadding',
          'Padding for actions',
          Color(0xFF9C27B0),
        ),
        _buildHierarchyItem(
          2,
          'iconColor',
          'Color for dialog icon',
          Color(0xFF9C27B0),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFEFEBE9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb_outline, color: Color(0xFF5D4037), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'DialogTheme can be set globally in ThemeData or overridden locally per dialog instance. Local values take precedence.',
                  style: TextStyle(fontSize: 11, color: Color(0xFF5D4037)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildHierarchyItem(int depth, String name, String desc, Color color) {
  return Container(
    margin: EdgeInsets.only(bottom: 4),
    padding: EdgeInsets.only(
      left: depth * 20.0 + 8,
      top: 6,
      bottom: 6,
      right: 8,
    ),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            fontSize: 12,
            color: color,
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
          ),
        ),
      ],
    ),
  );
}
