// D4rt test script: Tests DataTableTheme from material
import 'package:flutter/material.dart';

// Helper to build a section header
Widget buildSectionHeader(String title) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    margin: EdgeInsets.only(top: 20, bottom: 10),
    decoration: BoxDecoration(
      color: Color(0xFF1B5E20),
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
          width: 150,
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
Widget buildThemedHeader(List<String> columns, Color bgColor, Color textColor) {
  return Container(
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
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
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
) {
  return Container(
    decoration: BoxDecoration(
      color: bgColor,
      border: Border(bottom: BorderSide(color: borderColor, width: 0.5)),
    ),
    child: Row(
      children: values.map((val) {
        return Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text(val, style: TextStyle(fontSize: 13, color: textColor)),
          ),
        );
      }).toList(),
    ),
  );
}

// Helper: full themed mini-table
Widget buildMiniTable(
  String name,
  Color headerBg,
  Color headerFg,
  Color rowBg1,
  Color rowBg2,
  Color rowFg,
  Color border,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildThemedHeader(['Name', 'Value', 'Type'], headerBg, headerFg),
      buildThemedRow(['Alpha', '200', 'Int'], rowBg1, rowFg, border),
      buildThemedRow(['Beta', '3.14', 'Double'], rowBg2, rowFg, border),
      buildThemedRow(['Gamma', 'true', 'Bool'], rowBg1, rowFg, border),
    ],
  );
}

// Helper: theme inheritance diagram block
Widget buildThemeBlock(String label, Color color, double indent) {
  return Padding(
    padding: EdgeInsets.only(left: indent),
    child: Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (indent > 0)
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: Icon(
                Icons.subdirectory_arrow_right,
                color: Color(0xFFFFFFFF),
                size: 16,
              ),
            ),
          Text(
            label,
            style: TextStyle(
              color: Color(0xFFFFFFFF),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    ),
  );
}

// Helper: comparison column
Widget buildComparisonColumn(
  String title,
  Color accentColor,
  List<String> properties,
) {
  return Expanded(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accentColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              title,
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          ...properties.map((p) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Icon(Icons.circle, size: 6, color: accentColor),
                  SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      p,
                      style: TextStyle(fontSize: 11, color: Color(0xFF424242)),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    ),
  );
}

// Helper: merge indicator
Widget buildMergeIndicator(
  String parent,
  String child,
  String result,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFFE0E0E0)),
    ),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              parent,
              style: TextStyle(fontSize: 11, color: Color(0xFF2E7D32)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.add, size: 16, color: Color(0xFF757575)),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              child,
              style: TextStyle(fontSize: 11, color: Color(0xFF1565C0)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Icon(Icons.arrow_forward, size: 16, color: color),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              result,
              style: TextStyle(fontSize: 11, color: Color(0xFFFFFFFF)),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper: code-like property display
Widget buildPropertyDisplay(String property, String value, bool isOverridden) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 2),
    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
    decoration: BoxDecoration(
      color: isOverridden ? Color(0xFFE8F5E9) : Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(
        color: isOverridden ? Color(0xFF81C784) : Color(0xFFE0E0E0),
      ),
    ),
    child: Row(
      children: [
        if (isOverridden) Icon(Icons.edit, size: 12, color: Color(0xFF4CAF50)),
        if (isOverridden) SizedBox(width: 6),
        Text(
          '$property: ',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1B5E20),
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(fontSize: 12, color: Color(0xFF424242)),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  debugPrint('=== DataTableTheme Deep Demo ===');
  debugPrint('Testing DataTableTheme inheritance, wrapping, and composition');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text('DataTableTheme Deep Demo'),
        backgroundColor: Color(0xFF1B5E20),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section 1: DataTableTheme Overview
            buildSectionHeader('1. DataTableTheme Overview'),
            buildDemoCard(
              'DataTableTheme wraps children with DataTableThemeData',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow(
                    'Purpose',
                    'Apply DataTableThemeData to descendant DataTables',
                  ),
                  buildInfoRow('Type', 'InheritedTheme widget'),
                  buildInfoRow('Access', 'DataTableTheme.of(context)'),
                  buildInfoRow(
                    'Merging',
                    'Child themes override parent properties',
                  ),
                  buildInfoRow(
                    'Fallback',
                    'Uses ThemeData.dataTableTheme if no ancestor',
                  ),
                ],
              ),
            ),
            Text(
              'Section 1: Overview displayed',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 2: Theme Inheritance Hierarchy
            buildSectionHeader('2. Theme Inheritance Hierarchy'),
            buildDemoCard(
              'How DataTableTheme cascades through the widget tree',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildThemeBlock(
                    'MaterialApp (ThemeData.dataTableTheme)',
                    Color(0xFF1B5E20),
                    0,
                  ),
                  buildThemeBlock(
                    'DataTableTheme (outer)',
                    Color(0xFF2E7D32),
                    24,
                  ),
                  buildThemeBlock(
                    'DataTableTheme (inner)',
                    Color(0xFF43A047),
                    48,
                  ),
                  buildThemeBlock(
                    'DataTable (uses closest)',
                    Color(0xFF66BB6A),
                    72,
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F8E9),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'DataTable looks up the nearest DataTableTheme ancestor. Properties not set in the closest theme fall through to parent themes.',
                      style: TextStyle(fontSize: 12, color: Color(0xFF33691E)),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Section 2: Inheritance hierarchy rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 3: Outer Theme Table
            buildSectionHeader('3. Outer (Parent) Theme'),
            buildDemoCard(
              'Table using green outer DataTableTheme',
              buildMiniTable(
                'Green Parent Theme',
                Color(0xFF1B5E20),
                Color(0xFFFFFFFF),
                Color(0xFFE8F5E9),
                Color(0xFFC8E6C9),
                Color(0xFF1B5E20),
                Color(0xFFA5D6A7),
              ),
            ),
            buildDemoCard(
              'Parent theme configuration',
              Column(
                children: [
                  buildPropertyDisplay(
                    'headingRowColor',
                    'Color(0xFF1B5E20)',
                    false,
                  ),
                  buildPropertyDisplay(
                    'headingTextStyle',
                    'bold, white',
                    false,
                  ),
                  buildPropertyDisplay(
                    'dataRowColor',
                    'alternating green tints',
                    false,
                  ),
                  buildPropertyDisplay('dividerThickness', '1.0', false),
                  buildPropertyDisplay('columnSpacing', '24.0', false),
                ],
              ),
            ),
            Text(
              'Section 3: Outer theme rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 4: Inner Theme Override
            buildSectionHeader('4. Inner (Child) Theme Override'),
            buildDemoCard(
              'Table using blue inner DataTableTheme that overrides the parent',
              buildMiniTable(
                'Blue Child Theme',
                Color(0xFF1565C0),
                Color(0xFFFFFFFF),
                Color(0xFFE3F2FD),
                Color(0xFFBBDEFB),
                Color(0xFF0D47A1),
                Color(0xFF90CAF9),
              ),
            ),
            buildDemoCard(
              'Child overrides (parent values kept where not overridden)',
              Column(
                children: [
                  buildPropertyDisplay(
                    'headingRowColor',
                    'Color(0xFF1565C0)',
                    true,
                  ),
                  buildPropertyDisplay(
                    'headingTextStyle',
                    'bold, white',
                    false,
                  ),
                  buildPropertyDisplay(
                    'dataRowColor',
                    'alternating blue tints',
                    true,
                  ),
                  buildPropertyDisplay(
                    'dividerThickness',
                    '1.0 (from parent)',
                    false,
                  ),
                  buildPropertyDisplay('columnSpacing', '32.0', true),
                ],
              ),
            ),
            Text(
              'Section 4: Inner override rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 5: Theme Merge Visualization
            buildSectionHeader('5. Theme Merge Behavior'),
            buildDemoCard(
              'How parent and child theme properties merge',
              Column(
                children: [
                  buildMergeIndicator(
                    'Parent header: Green',
                    'Child header: Blue',
                    'Result: Blue',
                    Color(0xFF1565C0),
                  ),
                  buildMergeIndicator(
                    'Parent rows: Green tint',
                    'Child rows: Blue tint',
                    'Result: Blue tint',
                    Color(0xFF1565C0),
                  ),
                  buildMergeIndicator(
                    'Parent divider: 1.0',
                    'Child divider: (not set)',
                    'Result: 1.0',
                    Color(0xFF1B5E20),
                  ),
                  buildMergeIndicator(
                    'Parent spacing: 24',
                    'Child spacing: 32',
                    'Result: 32',
                    Color(0xFF1565C0),
                  ),
                  buildMergeIndicator(
                    'Parent height: 56',
                    'Child height: (not set)',
                    'Result: 56',
                    Color(0xFF1B5E20),
                  ),
                ],
              ),
            ),
            Text(
              'Section 5: Merge behavior rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 6: Side-by-Side Comparison
            buildSectionHeader('6. Theme Comparison'),
            buildDemoCard(
              'Three themed tables side by side',
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildComparisonColumn('Green Theme', Color(0xFF1B5E20), [
                        'Header: Green 900',
                        'Rows: Green tints',
                        'Border: Green 300',
                        'Spacing: 24px',
                        'Height: 56px',
                      ]),
                      buildComparisonColumn('Blue Theme', Color(0xFF1565C0), [
                        'Header: Blue 800',
                        'Rows: Blue tints',
                        'Border: Blue 300',
                        'Spacing: 32px',
                        'Height: 48px',
                      ]),
                      buildComparisonColumn('Purple Theme', Color(0xFF6A1B9A), [
                        'Header: Purple 800',
                        'Rows: Purple tints',
                        'Border: Purple 300',
                        'Spacing: 28px',
                        'Height: 52px',
                      ]),
                    ],
                  ),
                ],
              ),
            ),
            Text(
              'Section 6: Comparison rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 7: Nested Theme Demo
            buildSectionHeader('7. Nested Theme Tables'),
            buildDemoCard(
              'Level 0: No theme (default)',
              buildMiniTable(
                'Default',
                Color(0xFFBDBDBD),
                Color(0xFF212121),
                Color(0xFFFFFFFF),
                Color(0xFFF5F5F5),
                Color(0xFF212121),
                Color(0xFFE0E0E0),
              ),
            ),
            buildDemoCard(
              'Level 1: Green theme',
              buildMiniTable(
                'L1 Green',
                Color(0xFF2E7D32),
                Color(0xFFFFFFFF),
                Color(0xFFE8F5E9),
                Color(0xFFC8E6C9),
                Color(0xFF1B5E20),
                Color(0xFFA5D6A7),
              ),
            ),
            buildDemoCard(
              'Level 2: Green -> Orange override',
              buildMiniTable(
                'L2 Orange',
                Color(0xFFE65100),
                Color(0xFFFFFFFF),
                Color(0xFFFFF3E0),
                Color(0xFFFFE0B2),
                Color(0xFFBF360C),
                Color(0xFFFFCC80),
              ),
            ),
            buildDemoCard(
              'Level 3: Green -> Orange -> Teal override',
              buildMiniTable(
                'L3 Teal',
                Color(0xFF00695C),
                Color(0xFFFFFFFF),
                Color(0xFFE0F7FA),
                Color(0xFFB2EBF2),
                Color(0xFF004D40),
                Color(0xFF80CBC4),
              ),
            ),
            Text(
              'Section 7: Nested themes rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 8: Theme.of(context) Resolution
            buildSectionHeader('8. Theme Resolution'),
            buildDemoCard(
              'DataTableTheme.of(context) resolution order',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F8E9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF1B5E20),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '1',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Check nearest DataTableTheme ancestor',
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF2E7D32),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '2',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'Merge with parent DataTableTheme if present',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF43A047),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '3',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'Fall back to ThemeData.dataTableTheme',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Color(0xFF66BB6A),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '4',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'Use defaults from DataTableThemeData()',
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Section 8: Resolution order rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 9: Wrap vs Apply
            buildSectionHeader('9. DataTableTheme.wrap()'),
            buildDemoCard(
              'DataTableTheme.wrap merges with existing ancestor theme',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow(
                    'wrap()',
                    'Merges child theme with closest ancestor',
                  ),
                  buildInfoRow(
                    'Behavior',
                    'Child overrides only specified properties',
                  ),
                  buildInfoRow(
                    'Contrast',
                    'Plain DataTableTheme replaces entirely',
                  ),
                  SizedBox(height: 8),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Color(0xFFA5D6A7)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Example:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Color(0xFF1B5E20),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Parent: headingRowColor=green, columnSpacing=24',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF424242),
                          ),
                        ),
                        Text(
                          'wrap: headingRowColor=blue (only this overridden)',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF424242),
                          ),
                        ),
                        Text(
                          'Result: headingRowColor=blue, columnSpacing=24',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF424242),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Section 9: Wrap behavior rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 10: Theme in MaterialApp
            buildSectionHeader('10. Theme in MaterialApp'),
            buildDemoCard(
              'Setting DataTableThemeData in MaterialApp theme',
              Column(
                children: [
                  buildPropertyDisplay(
                    'MaterialApp.theme',
                    'ThemeData(...)',
                    false,
                  ),
                  buildPropertyDisplay(
                    '  dataTableTheme',
                    'DataTableThemeData(...)',
                    true,
                  ),
                  buildPropertyDisplay(
                    '    headingRowColor',
                    'MaterialStateColor',
                    true,
                  ),
                  buildPropertyDisplay(
                    '    dataRowColor',
                    'MaterialStateColor',
                    true,
                  ),
                  buildPropertyDisplay(
                    '    headingTextStyle',
                    'TextStyle(bold)',
                    true,
                  ),
                  buildPropertyDisplay('    dividerThickness', '1.0', true),
                ],
              ),
            ),
            buildDemoCard(
              'Result: all DataTables in app get this theme',
              buildMiniTable(
                'App-wide Theme',
                Color(0xFF1B5E20),
                Color(0xFFFFFFFF),
                Color(0xFFE8F5E9),
                Color(0xFFC8E6C9),
                Color(0xFF1B5E20),
                Color(0xFFA5D6A7),
              ),
            ),
            Text(
              'Section 10: MaterialApp theme rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Section 11: Real-world Pattern
            buildSectionHeader('11. Real-World Theme Pattern'),
            buildDemoCard(
              'Admin dashboard: different table themes per section',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Users Section',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1565C0),
                    ),
                  ),
                  SizedBox(height: 4),
                  buildMiniTable(
                    'Users',
                    Color(0xFF1565C0),
                    Color(0xFFFFFFFF),
                    Color(0xFFE3F2FD),
                    Color(0xFFBBDEFB),
                    Color(0xFF0D47A1),
                    Color(0xFF90CAF9),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Products Section',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE65100),
                    ),
                  ),
                  SizedBox(height: 4),
                  buildMiniTable(
                    'Products',
                    Color(0xFFE65100),
                    Color(0xFFFFFFFF),
                    Color(0xFFFFF3E0),
                    Color(0xFFFFE0B2),
                    Color(0xFFBF360C),
                    Color(0xFFFFCC80),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Analytics Section',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6A1B9A),
                    ),
                  ),
                  SizedBox(height: 4),
                  buildMiniTable(
                    'Analytics',
                    Color(0xFF6A1B9A),
                    Color(0xFFFFFFFF),
                    Color(0xFFF3E5F5),
                    Color(0xFFE1BEE7),
                    Color(0xFF4A148C),
                    Color(0xFFCE93D8),
                  ),
                ],
              ),
            ),
            Text(
              'Section 11: Real-world pattern rendered',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            // Summary
            buildSectionHeader('Summary'),
            buildDemoCard(
              'DataTableTheme Features Demonstrated',
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildInfoRow('1', 'DataTableTheme overview and purpose'),
                  buildInfoRow('2', 'Theme inheritance hierarchy'),
                  buildInfoRow('3', 'Outer (parent) theme application'),
                  buildInfoRow('4', 'Inner (child) theme overrides'),
                  buildInfoRow('5', 'Theme merge behavior'),
                  buildInfoRow('6', 'Side-by-side theme comparison'),
                  buildInfoRow('7', 'Nested theme tables'),
                  buildInfoRow('8', 'Theme.of(context) resolution order'),
                  buildInfoRow('9', 'DataTableTheme.wrap() behavior'),
                  buildInfoRow('10', 'Theme in MaterialApp'),
                  buildInfoRow('11', 'Real-world admin dashboard pattern'),
                ],
              ),
            ),
            Text(
              '=== DataTableTheme Deep Demo Complete ===',
              style: TextStyle(fontSize: 10, color: Colors.grey),
            ),

            SizedBox(height: 40),
          ],
        ),
      ),
    ),
  );
}
