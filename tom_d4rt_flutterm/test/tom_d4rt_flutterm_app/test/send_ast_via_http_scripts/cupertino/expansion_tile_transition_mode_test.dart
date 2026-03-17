// D4rt test script: Deep Demo for ExpansionTileTransitionMode from cupertino
// ExpansionTileTransitionMode controls expand/collapse animation behavior
// Used with CupertinoExpansionTile for iOS-style expandable content
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║          EXPANSION TILE TRANSITION MODE DEEP DEMO                 ║');
  print('║      Animation Control for Expandable Cupertino Tiles             ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: TRANSITION MODE FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 1: TRANSITION MODE FUNDAMENTALS                           │');
  print('│ Understanding expansion tile animation options                    │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('ExpansionTileTransitionMode defines:');
  print('  • How tiles animate when expanding/collapsing');
  print('  • Size change animation behavior');
  print('  • Visual transition styles');
  print('  • Performance characteristics');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: ALL ENUM VALUES
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 2: ALL ENUM VALUES                                        │');
  print('│ Complete list of transition mode options                          │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final allValues = ExpansionTileTransitionMode.values;
  final valueResults = <Map<String, dynamic>>[];
  
  print('ExpansionTileTransitionMode enum values:');
  print('┌──────────┬───────────────────┬──────────────────────────────────────┐');
  print('│  Index   │       Name        │   Description                        │');
  print('├──────────┼───────────────────┼──────────────────────────────────────┤');
  
  for (final mode in allValues) {
    String description;
    switch (mode) {
      case ExpansionTileTransitionMode.heightFactor:
        description = 'Animate via height factor (reveals)';
        break;
      case ExpansionTileTransitionMode.opacity:
        description = 'Animate via opacity (fades)';
        break;
    }
    valueResults.add({'mode': mode, 'index': mode.index, 'name': mode.name, 'description': description});
    print('│    ${mode.index}     │ ${mode.name.padRight(17)} │ ${description.padRight(32)} │');
  }
  print('└──────────┴───────────────────┴──────────────────────────────────────┘');
  print('');
  print('Total values: ${allValues.length}');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: HEIGHT FACTOR MODE ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 3: HEIGHT FACTOR MODE ANALYSIS                            │');
  print('│ Revealing content by animating height                             │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final heightFactorMode = ExpansionTileTransitionMode.heightFactor;
  print('ExpansionTileTransitionMode.heightFactor properties:');
  print('  • name: ${heightFactorMode.name}');
  print('  • index: ${heightFactorMode.index}');
  print('  • toString: $heightFactorMode');
  print('');
  print('Animation characteristics:');
  print('  • Content slides/reveals from top');
  print('  • Height animates from 0.0 to 1.0');
  print('  • Standard expansion tile behavior');
  print('  • May cause layout shifts');
  print('');
  print('Visual description:');
  print('  Collapsed: ┌──────────────────┐');
  print('             │ Title            │');
  print('             └──────────────────┘');
  print('                    ↓ animate');
  print('  Expanding: ┌──────────────────┐');
  print('             │ Title            │');
  print('             │ ─────────────    │');
  print('             │ Content revealed │');
  print('             │ line by line     │');
  print('             └──────────────────┘');
  print('');

  print('Use cases for heightFactor:');
  print('  • Standard accordions');
  print('  • Form field groups');
  print('  • Navigation menus');
  print('  • FAQ sections');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: OPACITY MODE ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 4: OPACITY MODE ANALYSIS                                  │');
  print('│ Fading content in/out                                             │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final opacityMode = ExpansionTileTransitionMode.opacity;
  print('ExpansionTileTransitionMode.opacity properties:');
  print('  • name: ${opacityMode.name}');
  print('  • index: ${opacityMode.index}');
  print('  • toString: $opacityMode');
  print('');
  print('Animation characteristics:');
  print('  • Content fades in/out');
  print('  • Opacity animates 0.0 to 1.0');
  print('  • Smoother visual transition');
  print('  • Space always reserved');
  print('');
  print('Visual description:');
  print('  Collapsed: ┌──────────────────┐');
  print('             │ Title            │');
  print('             │ [space reserved] │  (invisible)');
  print('             └──────────────────┘');
  print('                    ↓ animate');
  print('  Expanding: ┌──────────────────┐');
  print('             │ Title            │');
  print('             │ Content fades    │  opacity: 0.3');
  print('             │ in gradually     │  opacity: 0.6');
  print('             │ ...visible       │  opacity: 1.0');
  print('             └──────────────────┘');
  print('');

  print('Use cases for opacity:');
  print('  • Smooth content reveals');
  print('  • Fixed-size containers');
  print('  • Avoiding layout jumps');
  print('  • Animated overlays');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: VISUAL COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 5: VISUAL COMPARISON                                      │');
  print('│ Side-by-side animation differences                                │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('HEIGHT FACTOR vs OPACITY at 50% expansion:');
  print('');
  print('HEIGHT FACTOR (t=0.5):          OPACITY (t=0.5):');
  print('┌──────────────────────────┐   ┌──────────────────────────┐');
  print('│ Title ▼                  │   │ Title ▼                  │');
  print('│ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ │   │ Content visible          │ 50% alpha');
  print('│ Half of content          │   │ but faded                │');
  print('│ visible, cut off         │   │                          │');
  print('└──────────────────────────┘   └──────────────────────────┘');
  print('   [reveals from top]            [fades in place]');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: ANIMATION TIMELINE
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 6: ANIMATION TIMELINE                                     │');
  print('│ Tracking animation progress                                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Animation progress simulation:');
  print('┌──────────┬─────────────────────────┬─────────────────────────┐');
  print('│ Progress │    Height Factor        │    Opacity              │');
  print('├──────────┼─────────────────────────┼─────────────────────────┤');
  
  for (final progress in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final hfBar = '█' * (progress * 20).round() + '░' * (20 - (progress * 20).round());
    final opBar = '▓' * 20; // Always full width
    final opAlpha = (progress * 100).round();
    print('│   ${(progress * 100).toStringAsFixed(0).padLeft(3)}%   │ Height: $hfBar │ Opacity: ${opAlpha.toString().padLeft(3)}% ($opBar) │');
  }
  print('└──────────┴─────────────────────────┴─────────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: ENUM COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 7: ENUM COMPARISON                                        │');
  print('│ Equality and ordering                                             │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Equality comparisons:');
  print('┌───────────────────────────────────────┬─────────────────────────┐');
  print('│           Comparison                  │         Result          │');
  print('├───────────────────────────────────────┼─────────────────────────┤');
  print('│ heightFactor == heightFactor          │ ${heightFactorMode == ExpansionTileTransitionMode.heightFactor}                    │');
  print('│ heightFactor == opacity               │ ${heightFactorMode == opacityMode}                   │');
  print('│ heightFactor.index < opacity.index    │ ${heightFactorMode.index < opacityMode.index}                    │');
  print('└───────────────────────────────────────┴─────────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: ITERATION PATTERNS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 8: ITERATION PATTERNS                                     │');
  print('│ Working with enum collections                                     │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Forward iteration:');
  for (var i = 0; i < allValues.length; i++) {
    print('  values[$i]: ${allValues[i].name}');
  }
  print('');

  print('Using forEach:');
  allValues.forEach((mode) {
    print('  Processing: ${mode.name}');
  });
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: WITH CUPERTINO EXPANSION TILE
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 9: WITH CUPERTINO EXPANSION TILE                          │');
  print('│ Using transition mode in expansion tiles                          │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('CupertinoExpansionTile usage:');
  print('');
  print('  // Height factor mode (default)');
  print('  CupertinoExpansionTile(');
  print('    transitionMode: ExpansionTileTransitionMode.heightFactor,');
  print('    title: Text("Expand Me"),');
  print('    children: [...],');
  print('  )');
  print('');
  print('  // Opacity mode');
  print('  CupertinoExpansionTile(');
  print('    transitionMode: ExpansionTileTransitionMode.opacity,');
  print('    title: Text("Fade Me"),');
  print('    children: [...],');
  print('  )');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: PRACTICAL USE CASES
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 10: PRACTICAL USE CASES                                   │');
  print('│ When to use each transition mode                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('1. FAQ Sections → heightFactor');
  print('   Traditional accordion behavior');
  print('');

  print('2. Settings Groups → heightFactor');
  print('   Revealing options progressively');
  print('');

  print('3. Image Galleries → opacity');
  print('   Smooth fade without layout shift');
  print('');

  print('4. Fixed-height Cards → opacity');
  print('   When space is already reserved');
  print('');

  print('5. Performance Considerations:');
  print('   • heightFactor: More layout recalculation');
  print('   • opacity: Less layout work, smoother');
  print('');

  print('6. User Experience:');
  print('   • heightFactor: Familiar accordion feel');
  print('   • opacity: Modern, elegant transitions');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║          EXPANSION TILE TRANSITION MODE SUMMARY                   ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
  print('');
  print('ExpansionTileTransitionMode key features:');
  print('  • 2 modes: heightFactor and opacity');
  print('  • Controls expand/collapse animation');
  print('  • Different visual and performance traits');
  print('  • Simple enum-based selection');
  print('');
  print('Mode recommendations:');
  print('  • heightFactor: Accordions, standard expansion');
  print('  • opacity: Smooth fades, fixed layouts');
  print('');
  print('ExpansionTileTransitionMode Deep Demo completed');

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
                  colors: [Color(0xFF00BCD4), Color(0xFF00ACC1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
              padding: EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    'ExpansionTileTransitionMode',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: CupertinoColors.white,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    'Animate Expansion Tiles',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: CupertinoColors.white.withOpacity(0.8),
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
                      color: Color(0xFF00BCD4),
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  ...valueResults.map((r) => _buildEnumRow(r)),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            // Height Factor Demo
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('HEIGHT FACTOR MODE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: CupertinoColors.systemGrey)),
            ),
            SizedBox(height: 8),
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoExpansionTile(
                  transitionMode: ExpansionTileTransitionMode.heightFactor,
                  title: Text('Tap to Expand (Height)'),
                  children: [
                    CupertinoListTile(title: Text('Revealed Item 1')),
                    CupertinoListTile(title: Text('Revealed Item 2')),
                    CupertinoListTile(title: Text('Revealed Item 3')),
                  ],
                ),
              ],
            ),

            // Opacity Demo
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('OPACITY MODE', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: CupertinoColors.systemGrey)),
            ),
            SizedBox(height: 8),
            CupertinoListSection.insetGrouped(
              children: [
                CupertinoExpansionTile(
                  transitionMode: ExpansionTileTransitionMode.opacity,
                  title: Text('Tap to Expand (Opacity)'),
                  children: [
                    CupertinoListTile(title: Text('Faded Item 1')),
                    CupertinoListTile(title: Text('Faded Item 2')),
                    CupertinoListTile(title: Text('Faded Item 3')),
                  ],
                ),
              ],
            ),

            // Comparison Visual
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
                    'ANIMATION COMPARISON',
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
                      _buildModeVisual('Height', 'Reveals', CupertinoColors.activeBlue),
                      _buildModeVisual('Opacity', 'Fades', CupertinoColors.activeGreen),
                    ],
                  ),
                ],
              ),
            ),

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
                      color: Color(0xFF00BCD4),
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 12.0),
                  _buildRecommendation('heightFactor', 'Accordions, FAQs'),
                  _buildRecommendation('opacity', 'Smooth fades, fixed layouts'),
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
                  'Deep Demo • ExpansionTileTransitionMode • Flutter Cupertino',
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
  final mode = r['mode'] as ExpansionTileTransitionMode;
  final name = r['name'] as String;
  final description = r['description'] as String;
  
  Color color = mode == ExpansionTileTransitionMode.heightFactor 
    ? CupertinoColors.activeBlue 
    : CupertinoColors.activeGreen;
  
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
          child: Center(child: Text(name, style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: CupertinoColors.white))),
        ),
        SizedBox(width: 12),
        Expanded(child: Text(description, style: TextStyle(fontSize: 11, color: CupertinoColors.systemGrey))),
      ],
    ),
  );
}

Widget _buildModeVisual(String mode, String action, Color color) {
  return Column(
    children: [
      Container(
        width: 80,
        height: 60,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            mode,
            style: TextStyle(color: CupertinoColors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SizedBox(height: 8),
      Text(action, style: TextStyle(fontSize: 11, color: Color(0xFF90A4AE))),
    ],
  );
}

Widget _buildRecommendation(String mode, String useCase) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 80,
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Color(0xFF00BCD4),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(child: Text(mode, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: CupertinoColors.white))),
        ),
        SizedBox(width: 12),
        Icon(CupertinoIcons.arrow_right, size: 12, color: CupertinoColors.systemGrey),
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
      Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          color: Color(0xFF90A4AE),
        ),
      ),
    ],
  );
}
