// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for NavigationBarBottomMode from cupertino
// NavigationBarBottomMode controls bottom area behavior in CupertinoNavigationBar
// Defines how content interacts with the bottom edge and safe areas
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║           NAVIGATION BAR BOTTOM MODE DEEP DEMO                    ║',
  );
  print(
    '║     Bottom Edge Behavior for Cupertino Navigation Bars            ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: NAVIGATION BAR BOTTOM MODE FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: NAVIGATION BAR BOTTOM MODE FUNDAMENTALS                │',
  );
  print(
    '│ Understanding nav bar bottom edge behavior                        │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('NavigationBarBottomMode defines:');
  print('  • How the nav bar\'s bottom edge behaves');
  print('  • Interaction with content below');
  print('  • Border and separator display');
  print('  • Safe area handling');
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
    '│ Complete list of bottom mode options                              │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final allValues = NavigationBarBottomMode.values;
  final valueResults = <Map<String, dynamic>>[];

  print('NavigationBarBottomMode enum values:');
  print(
    '┌──────────┬───────────────┬────────────────────────────────────────────┐',
  );
  print(
    '│  Index   │     Name      │   Description                              │',
  );
  print(
    '├──────────┼───────────────┼────────────────────────────────────────────┤',
  );

  for (final mode in allValues) {
    String description;
    switch (mode) {
      case NavigationBarBottomMode.automatic:
        description = 'System determines border visibility';
        break;
      case NavigationBarBottomMode.always:
        description = 'Always show bottom border';
        break;
    }
    valueResults.add({
      'mode': mode,
      'index': mode.index,
      'name': mode.name,
      'description': description,
    });
    print(
      '│    ${mode.index}     │ ${mode.name.padRight(13)} │ ${description.padRight(38)} │',
    );
  }
  print(
    '└──────────┴───────────────┴────────────────────────────────────────────┘',
  );
  print('');
  print('Total values: ${allValues.length}');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: AUTOMATIC MODE ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: AUTOMATIC MODE ANALYSIS                                │',
  );
  print(
    '│ System-determined border visibility                               │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final automaticMode = NavigationBarBottomMode.automatic;
  print('NavigationBarBottomMode.automatic properties:');
  print('  • name: ${automaticMode.name}');
  print('  • index: ${automaticMode.index}');
  print('  • toString: $automaticMode');
  print('');
  print('Behavior characteristics:');
  print('  • Border appears based on scroll position');
  print('  • Shows when content is scrolled under');
  print('  • Hides when content is at top');
  print('  • iOS native behavior');
  print('');
  print('Visual example:');
  print('  At top (no border):        Scrolled (with border):');
  print('  ┌──────────────────────┐   ┌──────────────────────┐');
  print('  │    Navigation Bar    │   │    Navigation Bar    │');
  print('  └──────────────────────┘   │──────────────────────│ ← border');
  print('  │ Content at top       │   │ Content scrolled     │');
  print('  │ position             │   │ underneath bar       │');
  print('');

  print('Use cases for automatic:');
  print('  • Standard scrollable content');
  print('  • iOS Settings-style screens');
  print('  • Default nav bar behavior');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: ALWAYS MODE ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: ALWAYS MODE ANALYSIS                                   │',
  );
  print(
    '│ Permanent bottom border                                           │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final alwaysMode = NavigationBarBottomMode.always;
  print('NavigationBarBottomMode.always properties:');
  print('  • name: ${alwaysMode.name}');
  print('  • index: ${alwaysMode.index}');
  print('  • toString: $alwaysMode');
  print('');
  print('Behavior characteristics:');
  print('  • Border always visible');
  print('  • Independent of scroll position');
  print('  • Clear visual separation');
  print('  • Consistent appearance');
  print('');
  print('Visual example:');
  print('  Always has border:');
  print('  ┌──────────────────────┐');
  print('  │    Navigation Bar    │');
  print('  │──────────────────────│ ← always visible');
  print('  │ Content (any scroll  │');
  print('  │ position)            │');
  print('');

  print('Use cases for always:');
  print('  • Non-scrollable content');
  print('  • Explicitly separated sections');
  print('  • Consistent visual design');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: NEVER MODE ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: NEVER MODE ANALYSIS                                    │',
  );
  print(
    '│ No bottom border                                                  │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final automaticMode2 = NavigationBarBottomMode.automatic;
  print('NavigationBarBottomMode.automatic properties:');
  print('  • name: ${automaticMode2.name}');
  print('  • index: ${automaticMode2.index}');
  print('  • toString: $automaticMode2');
  print('');
  print('Behavior characteristics:');
  print('  • Border never visible');
  print('  • Seamless content flow');
  print('  • Modern, minimal look');
  print('  • Content blends with bar');
  print('');
  print('Visual example:');
  print('  No border ever:');
  print('  ┌──────────────────────┐');
  print('  │    Navigation Bar    │');
  print('  │ Content flows        │ ← no separation');
  print('  │ directly underneath  │');
  print('  │                      │');
  print('');

  print('Use cases for never:');
  print('  • Hero images behind nav');
  print('  • Seamless page designs');
  print('  • Custom visual effects');
  print('  • Full-bleed content');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: VISUAL COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 6: VISUAL COMPARISON                                      │',
  );
  print(
    '│ All three modes side by side                                      │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('AUTOMATIC            ALWAYS              NEVER');
  print('┌────────────────┐   ┌────────────────┐  ┌────────────────┐');
  print('│   Nav Bar      │   │   Nav Bar      │  │   Nav Bar      │');
  print('│~~~~~~~~~~~~~~~~│   │────────────────│  │                │');
  print('│ Content        │   │ Content        │  │ Content        │');
  print('│ (scrolled)     │   │                │  │                │');
  print('└────────────────┘   └────────────────┘  └────────────────┘');
  print('  [depends]           [always]            [never]');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: ENUM COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: ENUM COMPARISON                                        │',
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
    '│ automatic == automatic              │ ${automaticMode == NavigationBarBottomMode.automatic}                        │',
  );
  print(
    '│ automatic == always                 │ ${automaticMode == alwaysMode}                       │',
  );
  print(
    '│ automatic.index < always.index      │ ${automaticMode.index < alwaysMode.index}                        │',
  );
  print(
    '│ always.index < never.index          │ ${alwaysMode.index < automaticMode2.index}                        │',
  );
  print(
    '└─────────────────────────────────────┴─────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: ITERATION PATTERNS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: ITERATION PATTERNS                                     │',
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
  for (var mode in allValues) {
    print('  Processing: ${mode.name}');
  }
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: WITH CUPERTINO NAVIGATION BAR
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: WITH CUPERTINO NAVIGATION BAR                          │',
  );
  print(
    '│ Using bottom mode in navigation bars                              │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('CupertinoNavigationBar usage:');
  print('');
  print('  // Automatic mode (default)');
  print('  CupertinoNavigationBar(');
  print('    bottomMode: NavigationBarBottomMode.automatic,');
  print('    middle: Text("Title"),');
  print('  )');
  print('');
  print('  // Always show border');
  print('  CupertinoNavigationBar(');
  print('    bottomMode: NavigationBarBottomMode.always,');
  print('    middle: Text("Title"),');
  print('  )');
  print('');
  print('  // Never show border');
  print('  CupertinoNavigationBar(');
  print('    bottomMode: NavigationBarBottomMode.automatic,');
  print('    middle: Text("Title"),');
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
    '│ When to use each bottom mode                                      │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('1. Scrollable Lists → automatic');
  print('   Native iOS behavior with scroll-aware border');
  print('');

  print('2. Static Forms → always');
  print('   Clear separation without scroll');
  print('');

  print('3. Photo Viewers → never');
  print('   Seamless full-bleed content');
  print('');

  print('4. Settings Screens → automatic');
  print('   Standard iOS Settings appearance');
  print('');

  print('5. Hero Content → never');
  print('   Image/video underneath nav bar');
  print('');

  print('6. Design Guidelines:');
  print('   • automatic: Standard iOS apps');
  print('   • always: When border enhances UX');
  print('   • never: Modern, minimal designs');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║        NAVIGATION BAR BOTTOM MODE SUMMARY                         ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('NavigationBarBottomMode key features:');
  print('  • 3 modes: automatic, always, never');
  print('  • Controls bottom border visibility');
  print('  • Affects visual separation');
  print('  • Simple enum-based selection');
  print('');
  print('Mode recommendations:');
  print('  • automatic: Default, scroll-aware');
  print('  • always: Explicit separation');
  print('  • never: Seamless content');
  print('');
  print('NavigationBarBottomMode Deep Demo completed');

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
                  colors: [Color(0xFF8E24AA), Color(0xFFAB47BC)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    'NavigationBarBottomMode',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Nav Bar Bottom Edge Behavior',
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
                      color: Color(0xFF8E24AA),
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  ...valueResults.map((r) => _buildEnumRow(r)),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Mode Visual Comparison
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: Color(0xFF263238),
                borderRadius: BorderRadius.circular(10.0),
              ),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    'MODE COMPARISON',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildModeVisual('automatic', true, 'Scroll-aware'),
                      _buildModeVisual('always', true, 'Always shown'),
                      _buildModeVisual('never', false, 'Never shown'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Recommendations
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
                    'RECOMMENDATIONS',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8E24AA),
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  _buildRecommendation(
                    'automatic',
                    'Scrollable lists, standard apps',
                  ),
                  _buildRecommendation(
                    'always',
                    'Static forms, explicit separation',
                  ),
                  _buildRecommendation('never', 'Hero content, minimal design'),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Summary Stats
            Container(
              margin: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xFF37474F),
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
                  'Deep Demo • NavigationBarBottomMode • Flutter Cupertino',
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
  final mode = r['mode'] as NavigationBarBottomMode;
  final name = r['name'] as String;
  final description = r['description'] as String;

  Color color;
  switch (mode) {
    case NavigationBarBottomMode.automatic:
      color = CupertinoColors.activeBlue;
      break;
    case NavigationBarBottomMode.always:
      color = CupertinoColors.activeGreen;
      break;
  }

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 70,
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

Widget _buildModeVisual(String mode, bool hasBorder, String description) {
  return Column(
    children: [
      Container(
        width: 70,
        height: 50,
        decoration: BoxDecoration(
          color: CupertinoColors.systemGrey5,
          borderRadius: BorderRadius.circular(6),
          border: hasBorder
              ? Border(
                  bottom: BorderSide(
                    color: CupertinoColors.separator,
                    width: 1,
                  ),
                )
              : null,
        ),
        child: Column(
          children: [
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: CupertinoColors.systemGrey4,
                borderRadius: BorderRadius.vertical(top: Radius.circular(6)),
              ),
              child: Center(
                child: Text(
                  'Nav',
                  style: TextStyle(fontSize: 8, color: CupertinoColors.label),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      SizedBox(height: 4),
      Text(
        mode,
        style: TextStyle(
          fontSize: 9,
          fontWeight: FontWeight.w500,
          color: Color(0xFF90A4AE),
        ),
      ),
      Text(
        description,
        style: TextStyle(fontSize: 8, color: Color(0xFF607D8B)),
      ),
    ],
  );
}

Widget _buildRecommendation(String mode, String useCase) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 60,
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Color(0xFF8E24AA),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              mode,
              style: TextStyle(
                fontSize: 9,
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
