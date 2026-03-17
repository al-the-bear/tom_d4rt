// D4rt test script: Tests BoxHeightStyle from dart_ui
// BoxHeightStyle controls how text selection rectangles are calculated vertically
// Used in Paragraph.getBoxesForRange() and TextPainter
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║               BoxHeightStyle - Deep Demo                           ║');
  print('║     Vertical Height Calculation for Text Selection Boxes           ║');
  print('╚════════════════════════════════════════════════════════════════════╝');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: BoxHeightStyle Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 1: BoxHeightStyle Fundamentals                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('BoxHeightStyle is an enum that determines how the HEIGHT of');
  print('selection boxes is calculated when getting text ranges.');
  print('');
  print('Primary use case:');
  print('  - Paragraph.getBoxesForRange(start, end, boxHeightStyle, boxWidthStyle)');
  print('  - TextPainter.getBoxesForSelection(selection, boxHeightStyle, boxWidthStyle)');
  print('');
  print('The style affects how vertical space is allocated in selection boxes,');
  print('which is especially relevant for multi-line text with varying font sizes.');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All BoxHeightStyle Values
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 2: All BoxHeightStyle Values                              │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('BoxHeightStyle enum values:');
  for (final style in ui.BoxHeightStyle.values) {
    print('  [${style.index}] ${style.name}: $style');
  }
  print('');
  print('Total values: ${ui.BoxHeightStyle.values.length}');
  print('');
  final first = ui.BoxHeightStyle.values.first;
  final last = ui.BoxHeightStyle.values.last;
  print('First value: $first (index: ${first.index})');
  print('Last value: $last (index: ${last.index})');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: BoxHeightStyle.tight
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 3: BoxHeightStyle.tight                                   │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  const tight = ui.BoxHeightStyle.tight;
  print('BoxHeightStyle.tight:');
  print('  - Name: ${tight.name}');
  print('  - Index: ${tight.index}');
  print('');
  print('Behavior:');
  print('  - Selection boxes hug the actual glyph bounds');
  print('  - Height is determined by the tallest glyph in the range');
  print('  - No extra line spacing is included');
  print('  - Most compact representation');
  print('');
  print('Use cases:');
  print('  - Inline text highlighting');
  print('  - Precise glyph-level selection');
  print('  - When you want selection to match exact content bounds');
  print('');
  print('Visual example (side view):');
  print('  ┌─────┐  ← Top of tallest glyph');
  print('  │Hello│  ← Selection box (tight)');
  print('  └─────┘  ← Bottom of glyphs (baseline)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: BoxHeightStyle.max
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 4: BoxHeightStyle.max                                     │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  const max = ui.BoxHeightStyle.max;
  print('BoxHeightStyle.max:');
  print('  - Name: ${max.name}');
  print('  - Index: ${max.index}');
  print('');
  print('Behavior:');
  print('  - Uses the maximum height of all line boxes');
  print('  - Height spans from lowest descent to highest ascent');
  print('  - Includes full line height metrics');
  print('');
  print('Use cases:');
  print('  - Full line selection');
  print('  - Ensuring uniform selection height');
  print('  - When selection should extend to line boundaries');
  print('');
  print('Visual example:');
  print('  ┌─────────────┐  ← Maximum ascent');
  print('  │Hello World  │  ← Selection extends full line');
  print('  └─────────────┘  ← Maximum descent');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: BoxHeightStyle.strut
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 5: BoxHeightStyle.strut                                   │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  const strut = ui.BoxHeightStyle.strut;
  print('BoxHeightStyle.strut:');
  print('  - Name: ${strut.name}');
  print('  - Index: ${strut.index}');
  print('');
  print('Behavior:');
  print('  - Uses StrutStyle metrics for height calculation');
  print('  - Height based on configured strut leading, ascent, descent');
  print('  - Provides consistent line height regardless of actual glyphs');
  print('');
  print('Strut basics:');
  print('  - Strut is a typographic concept (like leading)');
  print('  - Defines minimum line height');
  print('  - Can be set via StrutStyle in TextStyle');
  print('');
  print('Use cases:');
  print('  - Uniform selection height across mixed fonts');
  print('  - When using StrutStyle for consistent typography');
  print('  - Design systems with strict vertical rhythm');
  print('');
  print('Example strut configuration:');
  print('  StrutStyle(');
  print('    forceStrutHeight: true,');
  print('    height: 1.5,');
  print('    leading: 0.5,');
  print('  )');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: BoxHeightStyle.includeLineSpacingTop
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 6: BoxHeightStyle.includeLineSpacingTop                   │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  const spacingTop = ui.BoxHeightStyle.includeLineSpacingTop;
  print('BoxHeightStyle.includeLineSpacingTop:');
  print('  - Name: ${spacingTop.name}');
  print('  - Index: ${spacingTop.index}');
  print('');
  print('Behavior:');
  print('  - Includes line spacing at the TOP of selection boxes');
  print('  - Extra space above the ascent line');
  print('  - Bottom of box aligns with descent');
  print('');
  print('Visual example:');
  print('  ─────────────────  ← Line spacing (included above)');
  print('  ┌─────────────┐');
  print('  │  Hello      │  ← Selection includes top spacing');
  print('  └─────────────┘  ← Descent (no extra spacing below)');
  print('');
  print('Use cases:');
  print('  - Selection that extends to previous line boundary');
  print('  - Leading text selection');
  print('  - When lines have space between them at top');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: BoxHeightStyle.includeLineSpacingMiddle
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 7: BoxHeightStyle.includeLineSpacingMiddle                │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  const spacingMiddle = ui.BoxHeightStyle.includeLineSpacingMiddle;
  print('BoxHeightStyle.includeLineSpacingMiddle:');
  print('  - Name: ${spacingMiddle.name}');
  print('  - Index: ${spacingMiddle.index}');
  print('');
  print('Behavior:');
  print('  - Distributes line spacing BOTH above and below');
  print('  - Half of spacing goes to top, half to bottom');
  print('  - Creates balanced selection boxes');
  print('');
  print('Visual example:');
  print('  ─────────  ← Half spacing above');
  print('  ┌───────┐');
  print('  │ Hello │  ← Selection with balanced spacing');
  print('  └───────┘');
  print('  ─────────  ← Half spacing below');
  print('');
  print('Use cases:');
  print('  - Balanced multi-line selection');
  print('  - Symmetric selection appearance');
  print('  - When lines have space evenly distributed');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: BoxHeightStyle.includeLineSpacingBottom
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 8: BoxHeightStyle.includeLineSpacingBottom                │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  const spacingBottom = ui.BoxHeightStyle.includeLineSpacingBottom;
  print('BoxHeightStyle.includeLineSpacingBottom:');
  print('  - Name: ${spacingBottom.name}');
  print('  - Index: ${spacingBottom.index}');
  print('');
  print('Behavior:');
  print('  - Includes line spacing at the BOTTOM of selection boxes');
  print('  - Top of box aligns with ascent');
  print('  - Extra space below the descent line');
  print('');
  print('Visual example:');
  print('  ┌─────────────┐  ← Top at ascent (no extra spacing)');
  print('  │  Hello      │  ← Selection');
  print('  └─────────────┘');
  print('  ─────────────────  ← Line spacing (included below)');
  print('');
  print('Use cases:');
  print('  - Selection that extends to next line boundary');
  print('  - Trailing text selection');
  print('  - When lines have space between them at bottom');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: Comparing Height Styles
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 9: Comparing Height Styles                                │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Comparison matrix for line height = 24, font size = 16:');
  print('');
  print('┌─────────────────────────┬────────┬─────────┬───────────────────────┐');
  print('│ Style                   │ Height │ Top     │ Bottom                │');
  print('├─────────────────────────┼────────┼─────────┼───────────────────────┤');
  print('│ tight                   │ ~16    │ glyph   │ glyph                 │');
  print('│ max                     │ ~20    │ ascent  │ descent               │');
  print('│ strut                   │ strut  │ strut   │ strut                 │');
  print('│ includeLineSpacingTop   │ ~22    │ +space  │ descent               │');
  print('│ includeLineSpacingMiddle│ ~24    │ +half   │ +half                 │');
  print('│ includeLineSpacingBottom│ ~22    │ ascent  │ +space                │');
  print('└─────────────────────────┴────────┴─────────┴───────────────────────┘');
  print('');
  print('Key differences:');
  print('  - tight: Smallest, glyph-only');
  print('  - max: Uses full line metrics without extra spacing');
  print('  - strut: Uses configured strut, ignores actual glyphs');
  print('  - spacing variants: Include line leading in different ways');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: Usage with Paragraph
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 10: Usage with Paragraph                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Using BoxHeightStyle with Paragraph.getBoxesForRange():');
  print('');
  print('Example code:');
  print('  final paragraph = paragraphBuilder.build();');
  print('  paragraph.layout(ParagraphConstraints(width: 300));');
  print('');
  print('  // Get selection boxes with different height styles:');
  print('');
  print('  // Tight - minimal height around glyphs');
  print('  final tightBoxes = paragraph.getBoxesForRange(');
  print('    0, 10,');
  print('    boxHeightStyle: BoxHeightStyle.tight,');
  print('    boxWidthStyle: BoxWidthStyle.tight,');
  print('  );');
  print('');
  print('  // Max - full line height');
  print('  final maxBoxes = paragraph.getBoxesForRange(');
  print('    0, 10,');
  print('    boxHeightStyle: BoxHeightStyle.max,');
  print('    boxWidthStyle: BoxWidthStyle.tight,');
  print('  );');
  print('');
  print('  // With line spacing distributed');
  print('  final spacedBoxes = paragraph.getBoxesForRange(');
  print('    0, 10,');
  print('    boxHeightStyle: BoxHeightStyle.includeLineSpacingMiddle,');
  print('    boxWidthStyle: BoxWidthStyle.tight,');
  print('  );');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: Usage with TextPainter
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 11: Usage with TextPainter                                │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Using BoxHeightStyle with TextPainter.getBoxesForSelection():');
  print('');
  print('Example code:');
  print('  final textPainter = TextPainter(');
  print('    text: TextSpan(');
  print('      text: "Hello World",');
  print('      style: TextStyle(fontSize: 16),');
  print('    ),');
  print('    textDirection: TextDirection.ltr,');
  print('  );');
  print('  textPainter.layout();');
  print('');
  print('  // Get selection boxes');
  print('  final selection = TextSelection(baseOffset: 0, extentOffset: 5);');
  print('  final boxes = textPainter.getBoxesForSelection(');
  print('    selection,');
  print('    boxHeightStyle: BoxHeightStyle.tight,');
  print('    boxWidthStyle: BoxWidthStyle.tight,');
  print('  );');
  print('');
  print('  // Draw selection rectangles');
  print('  for (final box in boxes) {');
  print('    canvas.drawRect(box.toRect(), selectionPaint);');
  print('  }');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 12: Multi-Line Selection Considerations
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 12: Multi-Line Selection Considerations                   │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('BoxHeightStyle is most important for multi-line text:');
  print('');
  print('Single line:');
  print('  - All styles produce similar results');
  print('  - Differences are minimal');
  print('');
  print('Multi-line with same font:');
  print('  - tight: Each line has same height');
  print('  - spacing styles: Account for leading between lines');
  print('');
  print('Multi-line with mixed fonts/sizes:');
  print('  - tight: Each line height varies with content');
  print('  - max: Consistent height per line based on metrics');
  print('  - strut: Uniform height if strut configured');
  print('');
  print('Visual comparison (multi-line):');
  print('');
  print('  tight:                    includeLineSpacingMiddle:');
  print('  ┌───────────┐             ┌───────────────────────┐');
  print('  │ Line 1    │             │                       │');
  print('  └───────────┘             │     Line 1            │');
  print('  ┌───────────┐             │                       │');
  print('  │ Line 2    │             ├───────────────────────┤');
  print('  └───────────┘             │                       │');
  print('       ↑                    │     Line 2            │');
  print('   Gap between              │                       │');
  print('                            └───────────────────────┘');
  print('                                     ↑');
  print('                             No gap, boxes touch');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 13: Platform-Specific Behavior
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 13: Platform-Specific Behavior                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('BoxHeightStyle may have subtle platform differences:');
  print('');
  print('iOS/macOS (Skia/Impeller):');
  print('  - Uses CoreText metrics');
  print('  - Height calculations follow Apple typography');
  print('');
  print('Android (Skia):');
  print('  - Uses Minikin text shaping');
  print('  - Height based on font metrics');
  print('');
  print('Windows (Skia):');
  print('  - Uses DirectWrite');
  print('  - Windows font hinting may affect metrics');
  print('');
  print('Web:');
  print('  - Uses browser text rendering');
  print('  - Canvas-based measurements');
  print('  - May have slight differences from native');
  print('');
  print('Best practice:');
  print('  - Test selection appearance on target platforms');
  print('  - Use consistent styles throughout app');
  print('  - Consider using strut for strict consistency');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 14: Practical Selection Implementation
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 14: Practical Selection Implementation                    │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Common patterns for text selection:');
  print('');
  print('1. Code editor style (tight boxes):');
  print('   BoxHeightStyle.tight + BoxWidthStyle.tight');
  print('   - Compact selection around text');
  print('   - Shows exact character bounds');
  print('');
  print('2. Word processor style (full line):');
  print('   BoxHeightStyle.max + BoxWidthStyle.max');
  print('   - Selection covers full line height');
  print('   - More traditional feel');
  print('');
  print('3. Document style (with spacing):');
  print('   BoxHeightStyle.includeLineSpacingMiddle + BoxWidthStyle.tight');
  print('   - Selection includes inter-line spacing');
  print('   - Good for double-spaced text');
  print('');
  print('4. Uniform style (strut-based):');
  print('   BoxHeightStyle.strut + BoxWidthStyle.tight');
  print('   - Consistent height regardless of content');
  print('   - Good with custom StrutStyle');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 15: Summary
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 15: Summary                                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('BoxHeightStyle summary:');
  print('');
  print('┌───────────────────────────┬────────────────────────────────────────┐');
  print('│ Style                     │ Best For                               │');
  print('├───────────────────────────┼────────────────────────────────────────┤');
  print('│ tight                     │ Compact, precise selection             │');
  print('│ max                       │ Full line selection                    │');
  print('│ strut                     │ Uniform height with StrutStyle         │');
  print('│ includeLineSpacingTop     │ Selection extending above              │');
  print('│ includeLineSpacingMiddle  │ Balanced multi-line selection          │');
  print('│ includeLineSpacingBottom  │ Selection extending below              │');
  print('└───────────────────────────┴────────────────────────────────────────┘');
  print('');
  print('Key points:');
  print('  1. Used with Paragraph.getBoxesForRange() and TextPainter');
  print('  2. Affects vertical bounds of selection rectangles');
  print('  3. Most noticeable in multi-line text');
  print('  4. Works in combination with BoxWidthStyle');
  print('  5. Consider platform differences for pixel-perfect results');
  print('');
  print('═══════════════════════════════════════════════════════════════════════');
  print('BoxHeightStyle deep demo completed');

  // Return visual UI
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.blue.shade50, Colors.indigo.shade50],
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.indigo.shade600,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.height, color: Colors.white, size: 32),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BoxHeightStyle',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Text Selection Vertical Height Control',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(height: 24),

        // Values grid
        Text(
          'All BoxHeightStyle Values',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: ui.BoxHeightStyle.values.map((style) {
            final colors = {
              ui.BoxHeightStyle.tight: Colors.green,
              ui.BoxHeightStyle.max: Colors.blue,
              ui.BoxHeightStyle.strut: Colors.purple,
              ui.BoxHeightStyle.includeLineSpacingTop: Colors.orange,
              ui.BoxHeightStyle.includeLineSpacingMiddle: Colors.teal,
              ui.BoxHeightStyle.includeLineSpacingBottom: Colors.pink,
            };
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: colors[style]?.shade100 ?? Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: colors[style]?.shade400 ?? Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: Column(
                children: [
                  Text(
                    style.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: colors[style]?.shade700 ?? Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    'index: ${style.index}',
                    style: TextStyle(
                      fontSize: 10,
                      color: colors[style]?.shade500 ?? Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 24),

        // Visual comparison
        Text(
          'Height Style Comparison',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _HeightStyleVisual(
                label: 'tight',
                description: 'Hugs glyphs',
                topPadding: 0,
                bottomPadding: 0,
                color: Colors.green,
              ),
              SizedBox(height: 16),
              _HeightStyleVisual(
                label: 'max',
                description: 'Full line metrics',
                topPadding: 4,
                bottomPadding: 4,
                color: Colors.blue,
              ),
              SizedBox(height: 16),
              _HeightStyleVisual(
                label: 'includeLineSpacingMiddle',
                description: 'Balanced spacing',
                topPadding: 8,
                bottomPadding: 8,
                color: Colors.teal,
              ),
            ],
          ),
        ),
        SizedBox(height: 24),

        // Info cards
        Row(
          children: [
            Expanded(
              child: _InfoCard(
                icon: Icons.format_size,
                title: 'Primary Use',
                content: 'Paragraph.getBoxesForRange()',
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _InfoCard(
                icon: Icons.select_all,
                title: 'Affects',
                content: 'Selection box height',
                color: Colors.green,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _InfoCard(
                icon: Icons.text_fields,
                title: 'Related',
                content: 'BoxWidthStyle',
                color: Colors.orange,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // Bottom summary
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.indigo.shade600, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${ui.BoxHeightStyle.values.length} styles available • Use with TextPainter or Paragraph • Most relevant for multi-line text',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.indigo.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper widget to visualize height styles
class _HeightStyleVisual extends StatelessWidget {
  final String label;
  final String description;
  final double topPadding;
  final double bottomPadding;
  final Color color;

  const _HeightStyleVisual({
    required this.label,
    required this.description,
    required this.topPadding,
    required this.bottomPadding,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color.shade700,
                ),
              ),
              Text(
                description,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: topPadding, bottom: bottomPadding),
            decoration: BoxDecoration(
              color: color.shade100,
              border: Border.all(color: color.shade300),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: color.shade200,
                borderRadius: BorderRadius.circular(2),
              ),
              child: Text(
                'Selected Text',
                style: TextStyle(
                  color: color.shade800,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Helper widget for info cards
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final Color color;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, color: color.shade600, size: 24),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color.shade700,
            ),
          ),
          Text(
            content,
            style: TextStyle(
              fontSize: 10,
              color: color.shade600,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
