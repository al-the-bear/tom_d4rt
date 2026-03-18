// D4rt test script: Deep Demo for CupertinoListSectionType from cupertino
// CupertinoListSectionType enum defines iOS-style list section styling
// Controls the visual grouping and inset styling of list sections
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║           CUPERTINO LIST SECTION TYPE DEEP DEMO                   ║',
  );
  print(
    '║        iOS-style List Section Styling for Settings UI             ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: LIST SECTION TYPE FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: LIST SECTION TYPE FUNDAMENTALS                         │',
  );
  print(
    '│ Understanding iOS list section visual styles                      │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('CupertinoListSectionType defines:');
  print('  • Visual grouping style for list sections');
  print('  • Matches iOS Settings app appearance');
  print('  • Controls background, margins, and borders');
  print('  • Two main styles: base and insetGrouped');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: ALL ENUM VALUES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 2: ALL ENUM VALUES                                        │',
  );
  print(
    '│ Complete list of section type options                             │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final allValues = CupertinoListSectionType.values;
  final valueResults = <Map<String, dynamic>>[];

  print('CupertinoListSectionType enum values:');
  print(
    '┌──────────┬───────────────┬────────────────────────────────────────────┐',
  );
  print(
    '│  Index   │     Name      │   Description                              │',
  );
  print(
    '├──────────┼───────────────┼────────────────────────────────────────────┤',
  );

  for (final type in allValues) {
    String description;
    switch (type) {
      case CupertinoListSectionType.base:
        description = 'Full-width background with dividers';
        break;
      case CupertinoListSectionType.insetGrouped:
        description = 'Rounded corners with side margins';
        break;
    }
    valueResults.add({
      'type': type,
      'index': type.index,
      'name': type.name,
      'description': description,
    });
    print(
      '│    ${type.index}     │ ${type.name.padRight(13)} │ ${description.padRight(38)} │',
    );
  }
  print(
    '└──────────┴───────────────┴────────────────────────────────────────────┘',
  );
  print('');
  print('Total values: ${allValues.length}');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: BASE STYLE ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: BASE STYLE ANALYSIS                                    │',
  );
  print(
    '│ Full-width list section styling                                   │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final baseType = CupertinoListSectionType.base;
  print('CupertinoListSectionType.base properties:');
  print('  • name: ${baseType.name}');
  print('  • index: ${baseType.index}');
  print('  • toString: $baseType');
  print('');
  print('Visual characteristics:');
  print('  • Full-width white/dark background');
  print('  • No side margins');
  print('  • Standard divider lines');
  print('  • Simpler appearance');
  print('');
  print('Use cases for base style:');
  print('  • Simple list views');
  print('  • Action menus');
  print('  • Non-settings contexts');
  print('  • Dense information lists');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: INSET GROUPED STYLE ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: INSET GROUPED STYLE ANALYSIS                           │',
  );
  print(
    '│ Rounded, inset list section styling                               │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final insetGroupedType = CupertinoListSectionType.insetGrouped;
  print('CupertinoListSectionType.insetGrouped properties:');
  print('  • name: ${insetGroupedType.name}');
  print('  • index: ${insetGroupedType.index}');
  print('  • toString: $insetGroupedType');
  print('');
  print('Visual characteristics:');
  print('  • Rounded corner container');
  print('  • Side margins (inset from edges)');
  print('  • Grouped background card');
  print('  • Modern iOS Settings appearance');
  print('');
  print('Use cases for insetGrouped style:');
  print('  • Settings screens');
  print('  • Preference panels');
  print('  • Form sections');
  print('  • Grouped options');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: VISUAL COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: VISUAL COMPARISON                                      │',
  );
  print(
    '│ Side-by-side style differences                                    │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('VISUAL STYLE COMPARISON:');
  print('');
  print('BASE STYLE:                    INSET GROUPED STYLE:');
  print('┌──────────────────────────┐   ┌────────────────────────────┐');
  print('│ ======================== │   │  ┌────────────────────────┐│');
  print('│ Item 1                   │   │  │ Item 1                 ││');
  print('│ ──────────────────────── │   │  │ ────────────────────── ││');
  print('│ Item 2                   │   │  │ Item 2                 ││');
  print('│ ──────────────────────── │   │  │ ────────────────────── ││');
  print('│ Item 3                   │   │  │ Item 3                 ││');
  print('│ ======================== │   │  └────────────────────────┘│');
  print('│                          │   │                            │');
  print('│ [Full width, no margins] │   │  [Rounded, with margins]   │');
  print('└──────────────────────────┘   └────────────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: ENUM COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 6: ENUM COMPARISON                                        │',
  );
  print(
    '│ Equality and ordering                                             │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Equality comparisons:');
  print(
    '┌─────────────────────────────────────┬─────────────────────────────┐',
  );
  print(
    '│          Comparison                 │         Result              │',
  );
  print(
    '├─────────────────────────────────────┼─────────────────────────────┤',
  );
  print(
    '│ base == base                        │ ${baseType == CupertinoListSectionType.base}                        │',
  );
  print(
    '│ base == insetGrouped                │ ${baseType == insetGroupedType}                       │',
  );
  print(
    '│ base.index < insetGrouped.index     │ ${baseType.index < insetGroupedType.index}                        │',
  );
  print(
    '└─────────────────────────────────────┴─────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: ITERATION PATTERNS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: ITERATION PATTERNS                                     │',
  );
  print(
    '│ Working with enum collections                                     │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Forward iteration:');
  for (var i = 0; i < allValues.length; i++) {
    print('  values[$i]: ${allValues[i].name}');
  }
  print('');

  print('Using forEach:');
  for (var type in allValues) {
    print('  Processing: ${type.name}');
  }
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: NAME PARSING
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: NAME PARSING                                           │',
  );
  print(
    '│ Converting strings to enum values                                 │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final testNames = ['base', 'insetGrouped', 'Base', 'insetgrouped'];

  print('Parsing string names:');
  print(
    '┌─────────────────────┬──────────────────┬────────────────────────────┐',
  );
  print(
    '│   Input String      │   Parsed Value   │   Method                   │',
  );
  print(
    '├─────────────────────┼──────────────────┼────────────────────────────┤',
  );

  for (final name in testNames) {
    try {
      final parsed = CupertinoListSectionType.values.firstWhere(
        (e) => e.name.toLowerCase() == name.toLowerCase(),
      );
      print(
        '│ "${name.padRight(17)}" │ ${parsed.name.padRight(14)} │ case-insensitive match     │',
      );
    } catch (e) {
      print(
        '│ "${name.padRight(17)}" │ Error            │ Not found                  │',
      );
    }
  }
  print(
    '└─────────────────────┴──────────────────┴────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: WITH CUPERTINO LIST SECTION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: WITH CUPERTINO LIST SECTION                            │',
  );
  print(
    '│ Using section type in list sections                               │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('CupertinoListSection usage:');
  print('');
  print('  // Base style (full width)');
  print('  CupertinoListSection(');
  print('    type: CupertinoListSectionType.base,');
  print('    children: [...],');
  print('  )');
  print('');
  print('  // Inset grouped style (rounded)');
  print('  CupertinoListSection.insetGrouped(');
  print('    children: [...],');
  print('  )');
  print('');
  print('  // Or explicitly with type');
  print('  CupertinoListSection(');
  print('    type: CupertinoListSectionType.insetGrouped,');
  print('    children: [...],');
  print('  )');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: PRACTICAL USE CASES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 10: PRACTICAL USE CASES                                   │',
  );
  print(
    '│ When to use each section type                                     │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('1. Settings Screens → insetGrouped');
  print('   Matches iOS Settings app appearance');
  print('');

  print('2. Action Menus → base');
  print('   Full-width options like share sheets');
  print('');

  print('3. Form Sections → insetGrouped');
  print('   Grouped input fields with clear boundaries');
  print('');

  print('4. Information Lists → base');
  print('   Dense data without visual grouping');
  print('');

  print('5. Preference Panels → insetGrouped');
  print('   User settings with grouped categories');
  print('');

  print('6. Mixed Content:');
  print('   Use both in same view for visual hierarchy');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║           CUPERTINO LIST SECTION TYPE SUMMARY                     ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('CupertinoListSectionType key features:');
  print('  • 2 styles: base and insetGrouped');
  print('  • Matches iOS native list appearance');
  print('  • Controls margins, corners, backgrounds');
  print('  • Simple enum-based selection');
  print('');
  print('Style recommendations:');
  print('  • base: Full-width, simpler layouts');
  print('  • insetGrouped: Settings, forms, grouped content');
  print('');
  print('CupertinoListSectionType Deep Demo completed');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════
  return CupertinoPageScaffold(
    backgroundColor: CupertinoColors.systemGroupedBackground,
    child: SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF5856D6), Color(0xFFAF52DE)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    'CupertinoListSectionType',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'iOS-style List Section Styling',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: CupertinoColors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),

            // Enum Values
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ENUM VALUES',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5856D6),
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  ...valueResults.map((r) => _buildEnumRow(r)),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Base Style Demo
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'BASE STYLE',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ),
            CupertinoListSection(
              header: Text('Base Section'),
              children: [
                CupertinoListTile(title: Text('Item 1')),
                CupertinoListTile(title: Text('Item 2')),
                CupertinoListTile(title: Text('Item 3')),
              ],
            ),

            // Inset Grouped Style Demo
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'INSET GROUPED STYLE',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: CupertinoColors.systemGrey,
                ),
              ),
            ),
            CupertinoListSection.insetGrouped(
              header: Text('Inset Grouped Section'),
              children: [
                CupertinoListTile(title: Text('Settings Item 1')),
                CupertinoListTile(title: Text('Settings Item 2')),
                CupertinoListTile(title: Text('Settings Item 3')),
              ],
            ),

            // Recommendations
            Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: CupertinoColors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'RECOMMENDATIONS',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF5856D6),
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  _buildRecommendation('base', 'Action menus, dense lists'),
                  _buildRecommendation(
                    'insetGrouped',
                    'Settings, forms, preferences',
                  ),
                ],
              ),
            ),

            // Summary Stats
            Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF263238),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'SUMMARY',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryStat('Values', '${allValues.length}'),
                      _buildSummaryStat('Type', 'Enum'),
                      _buildSummaryStat('Sections', '10'),
                    ],
                  ),
                ],
              ),
            ),

            // Footer
            Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Deep Demo • CupertinoListSectionType • Flutter Cupertino',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: CupertinoColors.systemGrey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget _buildEnumRow(Map<String, dynamic> r) {
  final type = r['type'] as CupertinoListSectionType;
  final name = r['name'] as String;
  final description = r['description'] as String;

  Color color = type == CupertinoListSectionType.base
      ? Color(0xFF007AFF)
      : Color(0xFF5856D6);

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 90,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRecommendation(String style, String useCase) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 80,
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Color(0xFF5856D6),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              style,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Icon(
          CupertinoIcons.arrow_right,
          size: 12,
          color: CupertinoColors.systemGrey,
        ),
        SizedBox(width: 8),
        Expanded(child: Text(useCase, style: TextStyle(fontSize: 11))),
      ],
    ),
  );
}

Widget _buildSummaryStat(String label, String value) {
  return Column(
    children: [
      Text(
        value,
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4DD0E1),
        ),
      ),
      Text(label, style: TextStyle(fontSize: 10.0, color: Color(0xFF90A4AE))),
    ],
  );
}
