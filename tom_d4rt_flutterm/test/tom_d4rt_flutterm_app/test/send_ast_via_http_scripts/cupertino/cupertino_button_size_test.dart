// D4rt test script: Deep Demo for CupertinoButtonSize from cupertino
// CupertinoButtonSize enum defines iOS-style button sizes: small, medium, large
// Part of the Cupertino design system for iOS-like Flutter apps
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║               CUPERTINO BUTTON SIZE DEEP DEMO                     ║',
  );
  print(
    '║           iOS-style Button Sizing for Cupertino Design            ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CUPERTINO BUTTON SIZE FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: CUPERTINO BUTTON SIZE FUNDAMENTALS                     │',
  );
  print(
    '│ Understanding iOS button size specifications                      │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('CupertinoButtonSize enum provides:');
  print('  • Standard iOS button sizes');
  print('  • Consistent touch targets');
  print('  • Apple Human Interface Guidelines compliance');
  print('  • Accessible sizing for all users');
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
    '│ Complete list of CupertinoButtonSize options                      │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final allValues = CupertinoButtonSize.values;
  final valueResults = <Map<String, dynamic>>[];

  print('CupertinoButtonSize enum values:');
  print(
    '┌──────────┬───────────────┬────────────────────────────────────────────┐',
  );
  print(
    '│  Index   │     Name      │   Description                              │',
  );
  print(
    '├──────────┼───────────────┼────────────────────────────────────────────┤',
  );

  for (final size in allValues) {
    String description;
    switch (size) {
      case CupertinoButtonSize.small:
        description = 'Compact size for dense layouts';
        break;
      case CupertinoButtonSize.medium:
        description = 'Default size - balanced visibility';
        break;
      case CupertinoButtonSize.large:
        description = 'Prominent size for primary actions';
        break;
    }
    valueResults.add({
      'size': size,
      'index': size.index,
      'name': size.name,
      'description': description,
    });
    print(
      '│    ${size.index}     │  ${size.name.padRight(11)} │ ${description.padRight(38)} │',
    );
  }
  print(
    '└──────────┴───────────────┴────────────────────────────────────────────┘',
  );
  print('');
  print('Total values: ${allValues.length}');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: SMALL SIZE ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: SMALL SIZE ANALYSIS                                    │',
  );
  print(
    '│ Compact button for space-constrained UIs                          │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final smallSize = CupertinoButtonSize.small;
  print('CupertinoButtonSize.small properties:');
  print('  • name: ${smallSize.name}');
  print('  • index: ${smallSize.index}');
  print('  • toString: $smallSize');
  print('');
  print('Use cases for small buttons:');
  print('  • Toolbar buttons');
  print('  • Navigation bar actions');
  print('  • Table row actions');
  print('  • Dense form layouts');
  print('  • Secondary actions in dialogs');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: MEDIUM SIZE ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: MEDIUM SIZE ANALYSIS                                   │',
  );
  print(
    '│ Default button size for most use cases                            │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final mediumSize = CupertinoButtonSize.medium;
  print('CupertinoButtonSize.medium properties:');
  print('  • name: ${mediumSize.name}');
  print('  • index: ${mediumSize.index}');
  print('  • toString: $mediumSize');
  print('');
  print('Use cases for medium buttons:');
  print('  • Standard form submissions');
  print('  • Content area actions');
  print('  • Modal buttons');
  print('  • Settings toggles');
  print('  • List item actions');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: LARGE SIZE ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: LARGE SIZE ANALYSIS                                    │',
  );
  print(
    '│ Prominent button for primary actions                              │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final largeSize = CupertinoButtonSize.large;
  print('CupertinoButtonSize.large properties:');
  print('  • name: ${largeSize.name}');
  print('  • index: ${largeSize.index}');
  print('  • toString: $largeSize');
  print('');
  print('Use cases for large buttons:');
  print('  • Call-to-action buttons');
  print('  • Sign up / Sign in');
  print('  • Purchase / Checkout');
  print('  • Full-width form actions');
  print('  • Bottom sheet primary actions');
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
    '│ Comparing enum values                                             │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Equality and ordering:');
  print(
    '┌─────────────────────────────────┬───────────────────────────────────┐',
  );
  print(
    '│          Comparison             │           Result                  │',
  );
  print(
    '├─────────────────────────────────┼───────────────────────────────────┤',
  );

  // Equality comparisons
  print(
    '│ small == small                  │ ${smallSize == CupertinoButtonSize.small}                              │',
  );
  print(
    '│ small == medium                 │ ${smallSize == mediumSize}                             │',
  );
  print(
    '│ small.index < medium.index      │ ${smallSize.index < mediumSize.index}                              │',
  );
  print(
    '│ medium.index < large.index      │ ${mediumSize.index < largeSize.index}                              │',
  );
  print(
    '│ small.index < large.index       │ ${smallSize.index < largeSize.index}                              │',
  );
  print(
    '└─────────────────────────────────┴───────────────────────────────────┘',
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

  print('Reverse iteration:');
  for (var i = allValues.length - 1; i >= 0; i--) {
    print('  values[$i]: ${allValues[i].name}');
  }
  print('');

  print('Using forEach:');
  for (var size in allValues) {
    print('  Processing: ${size.name}');
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

  final testNames = ['small', 'medium', 'large', 'SMALL', 'Medium'];

  print('Parsing string names:');
  print(
    '┌─────────────────┬──────────────────┬──────────────────────────────┐',
  );
  print(
    '│   Input String  │   Parsed Value   │   Method                     │',
  );
  print(
    '├─────────────────┼──────────────────┼──────────────────────────────┤',
  );

  for (final name in testNames) {
    try {
      final parsed = CupertinoButtonSize.values.byName(name.toLowerCase());
      print(
        '│ "${name.padRight(12)}" │ ${parsed.name.padRight(14)} │ byName(lowercase)            │',
      );
    } catch (e) {
      print(
        '│ "${name.padRight(12)}" │ Error            │ Not found                    │',
      );
    }
  }
  print(
    '└─────────────────┴──────────────────┴──────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: WITH CUPERTINO BUTTON
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: WITH CUPERTINO BUTTON                                  │',
  );
  print(
    '│ Using size enum with actual buttons                               │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('CupertinoButton size parameter usage:');
  print('');
  print('  CupertinoButton(');
  print('    sizeStyle: CupertinoButtonSize.small,');
  print('    child: Text("Small"),');
  print('    onPressed: () {},');
  print('  )');
  print('');
  print('  CupertinoButton(');
  print('    sizeStyle: CupertinoButtonSize.medium,');
  print('    child: Text("Medium"),');
  print('    onPressed: () {},');
  print('  )');
  print('');
  print('  CupertinoButton(');
  print('    sizeStyle: CupertinoButtonSize.large,');
  print('    child: Text("Large"),');
  print('    onPressed: () {},');
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
    '│ Real-world button size decisions                                  │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('1. Navigation Bars → small');
  print('   Compact actions that don\'t dominate the bar');
  print('');

  print('2. Form Submit → medium');
  print('   Balanced visibility for standard forms');
  print('');

  print('3. Call-to-Action → large');
  print('   Maximum prominence for conversion');
  print('');

  print('4. Accessibility:');
  print('   • All sizes meet minimum touch targets');
  print('   • large = 44pt (Apple minimum)');
  print('   • Consider large for elderly users');
  print('');

  print('5. Responsive Design:');
  print('   • Use small on compact horizontal sizes');
  print('   • Scale to large on tablets');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║              CUPERTINO BUTTON SIZE SUMMARY                        ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('CupertinoButtonSize key features:');
  print('  • 3 standard sizes: small, medium, large');
  print('  • iOS Human Interface Guidelines compliant');
  print('  • Consistent touch targets');
  print('  • Easy enum-based selection');
  print('');
  print('Size recommendations:');
  print('  • small: Toolbars, nav bars, secondary');
  print('  • medium: Standard forms, content');
  print('  • large: CTAs, primary actions');
  print('');
  print('CupertinoButtonSize Deep Demo completed');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFFF9500), Color(0xFFFFCC00)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'CupertinoButtonSize',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'iOS-style Button Sizing',
                  style: TextStyle(fontSize: 14.0, color: Color(0xFFFFF8E1)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Enum Values Card
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ENUM VALUES',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE65100),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...valueResults.map((r) => _buildEnumRow(r)),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Live Button Demo
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'LIVE BUTTON DEMO',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF424242),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 16.0),
                _buildButtonSizeDemo('Small', CupertinoButtonSize.small),
                SizedBox(height: 12.0),
                _buildButtonSizeDemo('Medium', CupertinoButtonSize.medium),
                SizedBox(height: 12.0),
                _buildButtonSizeDemo('Large', CupertinoButtonSize.large),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Use Case Recommendations
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'RECOMMENDATIONS',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildRecommendation(
                  'small',
                  'Toolbars, nav bars',
                  CupertinoColors.systemBlue,
                ),
                _buildRecommendation(
                  'medium',
                  'Forms, content',
                  CupertinoColors.systemGreen,
                ),
                _buildRecommendation(
                  'large',
                  'CTAs, primary',
                  CupertinoColors.systemOrange,
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Comparison Visual
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'SIZE COMPARISON',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSizeCompareBox('S', 40, CupertinoColors.systemBlue),
                    _buildSizeCompareBox('M', 55, CupertinoColors.systemGreen),
                    _buildSizeCompareBox('L', 70, CupertinoColors.systemOrange),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Summary Stats
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF37474F),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'SUMMARY',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
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
          SizedBox(height: 24.0),

          // Footer
          Center(
            child: Text(
              'Deep Demo • CupertinoButtonSize • Flutter Cupertino',
              style: TextStyle(
                fontSize: 12.0,
                color: Color(0xFF9E9E9E),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildEnumRow(Map<String, dynamic> r) {
  final size = r['size'] as CupertinoButtonSize;
  final name = r['name'] as String;
  final description = r['description'] as String;

  Color color;
  switch (size) {
    case CupertinoButtonSize.small:
      color = CupertinoColors.systemBlue;
      break;
    case CupertinoButtonSize.medium:
      color = CupertinoColors.systemGreen;
      break;
    case CupertinoButtonSize.large:
      color = CupertinoColors.systemOrange;
      break;
  }

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 60,
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 11,
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
            style: TextStyle(fontSize: 11, color: Color(0xFF616161)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildButtonSizeDemo(String label, CupertinoButtonSize size) {
  return Row(
    children: [
      SizedBox(
        width: 60,
        child: Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
      ),
      Expanded(
        child: CupertinoButton(
          sizeStyle: size,
          color: CupertinoColors.activeBlue,
          onPressed: () {},
          child: Text('Button'),
        ),
      ),
    ],
  );
}

Widget _buildRecommendation(String size, String useCase, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 50,
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              size,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: CupertinoColors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Icon(CupertinoIcons.arrow_right, size: 12, color: Color(0xFF616161)),
        SizedBox(width: 8),
        Text(useCase, style: TextStyle(fontSize: 12)),
      ],
    ),
  );
}

Widget _buildSizeCompareBox(String label, double size, Color color) {
  return Column(
    children: [
      Container(
        width: size,
        height: size * 0.6,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: CupertinoColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      SizedBox(height: 4),
      Text(
        '${size.toInt()}pt',
        style: TextStyle(fontSize: 10, color: Color(0xFF90A4AE)),
      ),
    ],
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
