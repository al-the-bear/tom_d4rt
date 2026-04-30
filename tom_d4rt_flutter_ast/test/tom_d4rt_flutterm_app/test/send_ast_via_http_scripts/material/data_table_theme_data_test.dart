// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DataTableThemeData from material
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(top: 20, bottom: 10),
    decoration: BoxDecoration(
      color: Color(0xFF283593),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xFFFFFFFF),
      ),
    ),
  );
}

// Helper to build a demo card
Widget buildDemoCard(String label, Widget child) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0xFFBDBDBD), width: 1),
      boxShadow: [
        BoxShadow(
          color: Color(0x1A000000),
          blurRadius: 4,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(height: 12),
        child,
      ],
    ),
  );
}

// Helper: info row
Widget buildInfoRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 160,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Color(0xFF616161),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 13, color: Color(0xFF212121)),
          ),
        ),
      ],
    ),
  );
}

// Helper: themed table header
Widget buildThemedTableHeader(
  List<String> columns,
  Color bgColor,
  Color textColor,
  double height,
) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ),
    ),
    child: Row(
      children: columns.map((col) {
        return Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              col,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: textColor,
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}

// Helper: themed table row
Widget buildThemedRow(
  List<String> values,
  Color bgColor,
  Color textColor,
  Color borderColor,
  double height,
) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      color: bgColor,
      border: Border(bottom: BorderSide(color: borderColor, width: 1)),
    ),
    child: Row(
      children: values.map((val) {
        return Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerLeft,
            child: Text(val, style: TextStyle(fontSize: 13, color: textColor)),
          ),
        );
      }).toList(),
    ),
  );
}

// Helper: full themed table
Widget buildThemedTable(
  String themeName,
  Color headerBg,
  Color headerFg,
  Color rowBg1,
  Color rowBg2,
  Color rowFg,
  Color borderColor,
  double headerHeight,
  double rowHeight,
  double dividerThickness,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        margin: EdgeInsets.only(bottom: 4),
        decoration: BoxDecoration(
          color: headerBg,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          themeName,
          style: TextStyle(
            color: headerFg,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      buildThemedTableHeader(
        ['Product', 'Category', 'Price'],
        headerBg,
        headerFg,
        headerHeight,
      ),
      buildThemedRow(
        ['Widget A', 'Tools', '\$29.99'],
        rowBg1,
        rowFg,
        borderColor,
        rowHeight,
      ),
      buildThemedRow(
        ['Gadget B', 'Electronics', '\$49.99'],
        rowBg2,
        rowFg,
        borderColor,
        rowHeight,
      ),
      buildThemedRow(
        ['Service C', 'Cloud', '\$9.99/mo'],
        rowBg1,
        rowFg,
        borderColor,
        rowHeight,
      ),
      Container(height: dividerThickness, color: borderColor),
    ],
  );
}

// Helper: property swatch
Widget buildPropertySwatch(String property, String value, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Color(0xFFBDBDBD)),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                property,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper: checkbox variant row
Widget buildCheckboxVariant(
  String label,
  bool isChecked,
  Color checkColor,
  Color fillColor,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: isChecked ? fillColor : Color(0xFFFFFFFF),
            border: Border.all(
              color: isChecked ? fillColor : Color(0xFFBDBDBD),
              width: 2,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: isChecked
              ? Icon(Icons.check, size: 16, color: checkColor)
              : SizedBox(),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
              ),
              Text(
                'Check: ${checkColor.toARGB32().toRadixString(16)} / Fill: ${fillColor.toARGB32().toRadixString(16)}',
                style: TextStyle(fontSize: 10, color: Color(0xFF9E9E9E)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper: dimension示 indicator
Widget buildDimensionIndicator(String label, double value, Color color) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Container(
            height: value.clamp(4.0, 60.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
        SizedBox(width: 8),
        Text(
          '${value}px',
          style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

// Helper: theme color palette card
Widget buildThemeColorPalette(
  String themeName,
  List<Color> colors,
  List<String> labels,
) {
  List<Widget> items = [];
  for (int i = 0; i < colors.length && i < labels.length; i++) {
    items.add(
      Expanded(
        child: Column(
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: colors[i],
                borderRadius: i == 0
                    ? BorderRadius.only(topLeft: Radius.circular(6))
                    : i == colors.length - 1
                    ? BorderRadius.only(topRight: Radius.circular(6))
                    : BorderRadius.zero,
              ),
            ),
            SizedBox(height: 2),
            Text(
              labels[i],
              style: TextStyle(fontSize: 8, color: Color(0xFF757575)),
            ),
          ],
        ),
      ),
    );
  }
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        themeName,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Color(0xFF424242),
        ),
      ),
      SizedBox(height: 4),
      Row(children: items),
      SizedBox(height: 8),
    ],
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== DataTableThemeData Deep Demo ===');
  debugPrint('Testing DataTableThemeData configurations and visual effects');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DataTableThemeData Deep Demo'),
        backgroundColor: Color(0xFF283593),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: Theme Properties
            buildSectionHeader('1. DataTableThemeData Properties'),
            buildDemoCard(
              'All configurable properties',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('decoration', 'Table background decoration'),
                  buildInfoRow('dataRowColor', 'Data row background color'),
                  buildInfoRow('dataRowMinHeight', 'Minimum data row height'),
                  buildInfoRow('dataRowMaxHeight', 'Maximum data row height'),
                  buildInfoRow('dataTextStyle', 'Text style for data cells'),
                  buildInfoRow(
                    'headingRowColor',
                    'Header row background color',
                  ),
                  buildInfoRow('headingRowHeight', 'Header row height'),
                  buildInfoRow('headingTextStyle', 'Text style for headers'),
                  buildInfoRow('horizontalMargin', 'Horizontal edge margin'),
                  buildInfoRow('columnSpacing', 'Spacing between columns'),
                  buildInfoRow('dividerThickness', 'Row divider thickness'),
                  buildInfoRow(
                    'checkboxHorizontalMargin',
                    'Checkbox horizontal margin',
                  ),
                ],
              ),
            ),
            Text(
              'Section 1: Properties listed',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 2: Default Theme
            buildSectionHeader('2. Default Theme'),
            buildDemoCard(
              'Default DataTableThemeData appearance',
              buildThemedTable(
                'Default',
                Color(0xFFE0E0E0),
                Color(0xFF212121),
                Color(0xFFFFFFFF),
                Color(0xFFFAFAFA),
                Color(0xFF212121),
                Color(0xFFE0E0E0),
                56,
                52,
                1,
              ),
            ),
            Text(
              'Section 2: Default theme rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 3: Bold Header Theme
            buildSectionHeader('3. Bold Header Theme'),
            buildDemoCard(
              'Prominent header with larger height',
              buildThemedTable(
                'Bold Headers',
                Color(0xFF283593),
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
                Color(0xFFE8EAF6),
                Color(0xFF212121),
                Color(0xFFC5CAE9),
                64,
                48,
                2,
              ),
            ),
            Text(
              'Section 3: Bold header theme rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 4: Compact Theme
            buildSectionHeader('4. Compact Theme'),
            buildDemoCard(
              'Reduced row heights for dense data',
              buildThemedTable(
                'Compact',
                Color(0xFF37474F),
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
                Color(0xFFF5F5F5),
                Color(0xFF424242),
                Color(0xFFEEEEEE),
                40,
                32,
                0.5,
              ),
            ),
            buildDemoCard(
              'Ultra-compact variant',
              buildThemedTable(
                'Ultra Compact',
                Color(0xFF455A64),
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
                Color(0xFFFAFAFA),
                Color(0xFF616161),
                Color(0xFFF5F5F5),
                36,
                28,
                0.25,
              ),
            ),
            Text(
              'Section 4: Compact themes rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 5: Colorful Theme
            buildSectionHeader('5. Colorful Theme'),
            buildDemoCard(
              'Vibrant colored table',
              buildThemedTable(
                'Colorful',
                Color(0xFFAD1457),
                Color(0xFFFFFFFF),
                Color(0xFFFCE4EC),
                Color(0xFFF8BBD0),
                Color(0xFF880E4F),
                Color(0xFFF48FB1),
                56,
                48,
                1.5,
              ),
            ),
            buildDemoCard(
              'Ocean theme',
              buildThemedTable(
                'Ocean',
                Color(0xFF006064),
                Color(0xFFFFFFFF),
                Color(0xFFE0F7FA),
                Color(0xFFB2EBF2),
                Color(0xFF00363A),
                Color(0xFF80DEEA),
                56,
                48,
                1.5,
              ),
            ),
            Text(
              'Section 5: Colorful themes rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 6: Dark Theme
            buildSectionHeader('6. Dark Theme'),
            buildDemoCard(
              'Dark mode data table',
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF121212),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: buildThemedTable(
                  'Dark Mode',
                  Color(0xFF1E1E1E),
                  Color(0xFFE0E0E0),
                  Color(0xFF2C2C2C),
                  Color(0xFF1E1E1E),
                  Color(0xFFE0E0E0),
                  Color(0xFF424242),
                  56,
                  52,
                  0.5,
                ),
              ),
            ),
            buildDemoCard(
              'AMOLED dark theme',
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFF000000),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: buildThemedTable(
                  'AMOLED',
                  Color(0xFF000000),
                  Color(0xFFBB86FC),
                  Color(0xFF121212),
                  Color(0xFF000000),
                  Color(0xFFE0E0E0),
                  Color(0xFF333333),
                  56,
                  52,
                  0.5,
                ),
              ),
            ),
            Text(
              'Section 6: Dark themes rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 7: Property Color Swatches
            buildSectionHeader('7. Theme Color Properties'),
            buildDemoCard(
              'Visual color property mapping',
              Column(
                children: [
                  buildPropertySwatch(
                    'headingRowColor',
                    '0xFF283593 (Indigo 800)',
                    Color(0xFF283593),
                  ),
                  buildPropertySwatch(
                    'dataRowColor (even)',
                    '0xFFFFFFFF (White)',
                    Color(0xFFFFFFFF),
                  ),
                  buildPropertySwatch(
                    'dataRowColor (odd)',
                    '0xFFE8EAF6 (Indigo 50)',
                    Color(0xFFE8EAF6),
                  ),
                  buildPropertySwatch(
                    'dividerColor',
                    '0xFFC5CAE9 (Indigo 100)',
                    Color(0xFFC5CAE9),
                  ),
                  buildPropertySwatch(
                    'decoration bg',
                    '0xFFF5F5F5 (Grey 100)',
                    Color(0xFFF5F5F5),
                  ),
                ],
              ),
            ),
            Text(
              'Section 7: Color swatches rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 8: Checkbox Theme Variants
            buildSectionHeader('8. Checkbox in DataTable'),
            buildDemoCard(
              'Checkbox appearance with different themes',
              Column(
                children: [
                  buildCheckboxVariant(
                    'Default checked',
                    true,
                    Color(0xFFFFFFFF),
                    Color(0xFF1976D2),
                  ),
                  buildCheckboxVariant(
                    'Default unchecked',
                    false,
                    Color(0xFFFFFFFF),
                    Color(0xFF1976D2),
                  ),
                  buildCheckboxVariant(
                    'Indigo theme checked',
                    true,
                    Color(0xFFFFFFFF),
                    Color(0xFF283593),
                  ),
                  buildCheckboxVariant(
                    'Green theme checked',
                    true,
                    Color(0xFFFFFFFF),
                    Color(0xFF2E7D32),
                  ),
                  buildCheckboxVariant(
                    'Red theme checked',
                    true,
                    Color(0xFFFFFFFF),
                    Color(0xFFC62828),
                  ),
                  buildCheckboxVariant(
                    'Custom check color',
                    true,
                    Color(0xFF000000),
                    Color(0xFFFFEB3B),
                  ),
                ],
              ),
            ),
            Text(
              'Section 8: Checkbox variants rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 9: Row Height Variants
            buildSectionHeader('9. Row Height Configuration'),
            buildDemoCard(
              'Various dataRowMinHeight / dataRowMaxHeight',
              Column(
                children: [
                  buildDimensionIndicator(
                    'min: 24, max: 24',
                    24,
                    Color(0xFF283593),
                  ),
                  buildDimensionIndicator(
                    'min: 32, max: 32',
                    32,
                    Color(0xFF1565C0),
                  ),
                  buildDimensionIndicator(
                    'min: 48, max: 48',
                    48,
                    Color(0xFF1976D2),
                  ),
                  buildDimensionIndicator(
                    'min: 52, max: 52',
                    52,
                    Color(0xFF1E88E5),
                  ),
                  buildDimensionIndicator(
                    'min: 64, max: 64',
                    60,
                    Color(0xFF42A5F5),
                  ),
                  buildDimensionIndicator('heading: 56', 56, Color(0xFF90CAF9)),
                ],
              ),
            ),
            Text(
              'Section 9: Row heights rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 10: Divider Thickness and Spacing
            buildSectionHeader('10. Divider & Spacing'),
            buildDemoCard(
              'dividerThickness variations',
              Column(
                children: [
                  buildDimensionIndicator('0.0 (none)', 4, Color(0xFFE0E0E0)),
                  buildDimensionIndicator('0.5 (thin)', 4, Color(0xFFBDBDBD)),
                  buildDimensionIndicator(
                    '1.0 (default)',
                    4,
                    Color(0xFF9E9E9E),
                  ),
                  buildDimensionIndicator('2.0 (medium)', 6, Color(0xFF757575)),
                  buildDimensionIndicator('4.0 (thick)', 8, Color(0xFF616161)),
                ],
              ),
            ),
            buildDemoCard(
              'columnSpacing and horizontalMargin',
              Column(
                children: [
                  buildInfoRow('columnSpacing: 16', 'Tight columns'),
                  buildInfoRow('columnSpacing: 24', 'Default spacing'),
                  buildInfoRow('columnSpacing: 40', 'Wide spacing'),
                  buildInfoRow('horizontalMargin: 8', 'Minimal edge margin'),
                  buildInfoRow('horizontalMargin: 24', 'Default edge margin'),
                  buildInfoRow('horizontalMargin: 48', 'Wide edge margin'),
                ],
              ),
            ),
            Text(
              'Section 10: Divider & spacing rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 11: Theme Color Palettes
            buildSectionHeader('11. Theme Color Palettes'),
            buildDemoCard(
              'Complete color sets for different themes',
              Column(
                children: [
                  buildThemeColorPalette(
                    'Indigo Theme',
                    [
                      Color(0xFF283593),
                      Color(0xFF3949AB),
                      Color(0xFF5C6BC0),
                      Color(0xFFC5CAE9),
                      Color(0xFFE8EAF6),
                    ],
                    ['Header', 'Accent', 'Hover', 'Border', 'Row Alt'],
                  ),
                  buildThemeColorPalette(
                    'Teal Theme',
                    [
                      Color(0xFF00695C),
                      Color(0xFF00897B),
                      Color(0xFF26A69A),
                      Color(0xFF80CBC4),
                      Color(0xFFE0F2F1),
                    ],
                    ['Header', 'Accent', 'Hover', 'Border', 'Row Alt'],
                  ),
                  buildThemeColorPalette(
                    'Orange Theme',
                    [
                      Color(0xFFE65100),
                      Color(0xFFF57C00),
                      Color(0xFFFFA726),
                      Color(0xFFFFCC80),
                      Color(0xFFFFF3E0),
                    ],
                    ['Header', 'Accent', 'Hover', 'Border', 'Row Alt'],
                  ),
                  buildThemeColorPalette(
                    'Grey Theme',
                    [
                      Color(0xFF37474F),
                      Color(0xFF546E7A),
                      Color(0xFF78909C),
                      Color(0xFFB0BEC5),
                      Color(0xFFECEFF1),
                    ],
                    ['Header', 'Accent', 'Hover', 'Border', 'Row Alt'],
                  ),
                ],
              ),
            ),
            Text(
              'Section 11: Theme palettes rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Summary
            buildSectionHeader('Summary'),
            buildDemoCard(
              'DataTableThemeData Features Demonstrated',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('1', 'All DataTableThemeData properties'),
                  buildInfoRow('2', 'Default theme appearance'),
                  buildInfoRow('3', 'Bold header theme'),
                  buildInfoRow('4', 'Compact and ultra-compact themes'),
                  buildInfoRow('5', 'Colorful and ocean themes'),
                  buildInfoRow('6', 'Dark and AMOLED themes'),
                  buildInfoRow('7', 'Color property swatches'),
                  buildInfoRow('8', 'Checkbox theme variants'),
                  buildInfoRow('9', 'Row height configurations'),
                  buildInfoRow('10', 'Divider thickness and spacing'),
                  buildInfoRow('11', 'Complete theme color palettes'),
                ],
              ),
            ),
            Text(
              '=== DataTableThemeData Deep Demo Complete ===',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}
