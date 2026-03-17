// D4rt test script: Tests BoxWidthStyle from dart_ui
// BoxWidthStyle controls how text selection rectangles are calculated horizontally
// Used in Paragraph.getBoxesForRange() and TextPainter
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║               BoxWidthStyle - Deep Demo                            ║');
  print('║     Horizontal Width Calculation for Text Selection Boxes          ║');
  print('╚════════════════════════════════════════════════════════════════════╝');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: BoxWidthStyle Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 1: BoxWidthStyle Fundamentals                             │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('BoxWidthStyle is an enum that determines how the WIDTH of');
  print('selection boxes is calculated when getting text ranges.');
  print('');
  print('Primary use case:');
  print('  - Paragraph.getBoxesForRange(start, end, boxHeightStyle, boxWidthStyle)');
  print('  - TextPainter.getBoxesForSelection(selection, boxHeightStyle, boxWidthStyle)');
  print('');
  print('The style affects how horizontal space is allocated in selection boxes,');
  print('which is especially relevant for partial line selection and RTL text.');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All BoxWidthStyle Values
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 2: All BoxWidthStyle Values                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('BoxWidthStyle enum values:');
  for (final style in ui.BoxWidthStyle.values) {
    print('  [${style.index}] ${style.name}: $style');
  }
  print('');
  print('Total values: ${ui.BoxWidthStyle.values.length}');
  print('');
  final first = ui.BoxWidthStyle.values.first;
  final last = ui.BoxWidthStyle.values.last;
  print('First value: $first (index: ${first.index})');
  print('Last value: $last (index: ${last.index})');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: BoxWidthStyle.tight
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 3: BoxWidthStyle.tight                                    │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  const tight = ui.BoxWidthStyle.tight;
  print('BoxWidthStyle.tight:');
  print('  - Name: ${tight.name}');
  print('  - Index: ${tight.index}');
  print('');
  print('Behavior:');
  print('  - Selection boxes are as wide as the selected text');
  print('  - Width determined by actual glyph bounds');
  print('  - No extension to line boundaries');
  print('  - Most common and default style');
  print('');
  print('Use cases:');
  print('  - Standard text selection');
  print('  - Inline highlighting');
  print('  - Precise character-level selection');
  print('  - Code editors');
  print('');
  print('Visual example:');
  print('  The quick brown fox jumps over');
  print('      ┌─────┐');
  print('      │quick│  ← Selection box (tight)');
  print('      └─────┘');
  print('');
  print('Characteristics:');
  print('  - Left edge: Start of first selected character');
  print('  - Right edge: End of last selected character');
  print('  - Width varies with content');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: BoxWidthStyle.max
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 4: BoxWidthStyle.max                                      │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  const max = ui.BoxWidthStyle.max;
  print('BoxWidthStyle.max:');
  print('  - Name: ${max.name}');
  print('  - Index: ${max.index}');
  print('');
  print('Behavior:');
  print('  - Selection boxes extend to the full paragraph width');
  print('  - Width spans from start to end of line');
  print('  - Includes trailing spaces up to line boundary');
  print('');
  print('Use cases:');
  print('  - Full-line selection');
  print('  - Block selection');
  print('  - Document-style selection');
  print('  - When selection should reach margins');
  print('');
  print('Visual example:');
  print('  The quick brown fox jumps over');
  print('  ┌───────────────────────────────────┐');
  print('  │The quick brown fox jumps over     │  ← Selection (max width)');
  print('  └───────────────────────────────────┘');
  print('');
  print('Characteristics:');
  print('  - Left edge: Start of paragraph/line');
  print('  - Right edge: End of paragraph/line (or max width)');
  print('  - Consistent width per line');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Comparing Width Styles
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 5: Comparing Width Styles                                 │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Comparison of tight vs max:');
  print('');
  print('┌─────────────────────────────────────────────────────────────────────┐');
  print('│ Text: "The quick brown fox"                                        │');
  print('│ Selected: "quick brown"                                            │');
  print('├─────────────────────────────────────────────────────────────────────┤');
  print('│                                                                     │');
  print('│ tight:                                                              │');
  print('│   The ┌───────────┐ fox                                            │');
  print('│       │quick brown│                                                 │');
  print('│       └───────────┘                                                 │');
  print('│                                                                     │');
  print('│ max:                                                                │');
  print('│   ┌───────────────────────────────────────────────────────────────┐│');
  print('│   │The quick brown fox                                            ││');
  print('│   └───────────────────────────────────────────────────────────────┘│');
  print('│                                                                     │');
  print('└─────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Key differences:');
  print('  - tight: Minimal, content-bound');
  print('  - max: Full-width, line-bound');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Multi-Line Selection Behavior
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 6: Multi-Line Selection Behavior                          │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Multi-line selection with different width styles:');
  print('');
  print('Tight style (selecting "quick brown fox\\njumps over the"):');
  print('');
  print('  The ┌──────────────┐');
  print('      │quick brown fox│');
  print('  ┌───────────────┐   ');
  print('  │jumps over the │lazy');
  print('  └───────────────┘   ');
  print('');
  print('Max style (same selection):');
  print('');
  print('  ┌─────────────────────────────────────┐');
  print('  │The quick brown fox                  │');
  print('  ├─────────────────────────────────────┤');
  print('  │jumps over the lazy                  │');
  print('  └─────────────────────────────────────┘');
  print('');
  print('Impact on selection appearance:');
  print('  - tight: Each line\'s box width varies');
  print('  - max: All lines have same width (paragraph width)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: RTL and Bidirectional Text
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 7: RTL and Bidirectional Text                             │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('BoxWidthStyle behavior with RTL text:');
  print('');
  print('LTR text (English):');
  print('  tight: ┌──────┐');
  print('         │Hello │  → left to right');
  print('         └──────┘');
  print('');
  print('RTL text (Arabic/Hebrew):');
  print('  tight: ┌──────┐');
  print('         │ مرحبا │  ← right to left');
  print('         └──────┘');
  print('');
  print('Mixed bidirectional text:');
  print('  Hello مرحبا World');
  print('');
  print('  Selecting "مرحبا" with tight:');
  print('  - Box positioned at RTL location');
  print('  - Width matches Arabic text width');
  print('');
  print('  Selecting "مرحبا" with max:');
  print('  - Box extends to full line width');
  print('  - Same as LTR max behavior');
  print('');
  print('Note: The actual rendering direction doesn\'t change,');
  print('only the box bounds calculation is affected.');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Usage with Paragraph
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 8: Usage with Paragraph                                   │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Using BoxWidthStyle with Paragraph.getBoxesForRange():');
  print('');
  print('Example code:');
  print('  final paragraphBuilder = ParagraphBuilder(ParagraphStyle(');
  print('    textDirection: TextDirection.ltr,');
  print('  ))..addText("The quick brown fox");');
  print('');
  print('  final paragraph = paragraphBuilder.build();');
  print('  paragraph.layout(ParagraphConstraints(width: 300));');
  print('');
  print('  // Tight width - boxes match selected chars');
  print('  final tightBoxes = paragraph.getBoxesForRange(');
  print('    4, 15,  // "quick brown"');
  print('    boxHeightStyle: BoxHeightStyle.tight,');
  print('    boxWidthStyle: BoxWidthStyle.tight,');
  print('  );');
  print('');
  print('  // Max width - boxes extend to paragraph width');
  print('  final maxBoxes = paragraph.getBoxesForRange(');
  print('    4, 15,');
  print('    boxHeightStyle: BoxHeightStyle.tight,');
  print('    boxWidthStyle: BoxWidthStyle.max,');
  print('  );');
  print('');
  print('  // Comparing results');
  print('  print("Tight boxes: \${tightBoxes.length}");');
  print('  for (final box in tightBoxes) {');
  print('    print("  \${box.left} - \${box.right}, width: \${box.right - box.left}");');
  print('  }');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: Usage with TextPainter
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 9: Usage with TextPainter                                 │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Using BoxWidthStyle with TextPainter:');
  print('');
  print('Example code:');
  print('  final textPainter = TextPainter(');
  print('    text: TextSpan(');
  print('      text: "Hello World",');
  print('      style: TextStyle(fontSize: 16),');
  print('    ),');
  print('    textDirection: TextDirection.ltr,');
  print('  );');
  print('  textPainter.layout(maxWidth: 200);');
  print('');
  print('  // Get selection with tight width');
  print('  final selection = TextSelection(baseOffset: 0, extentOffset: 5);');
  print('  final boxes = textPainter.getBoxesForSelection(');
  print('    selection,');
  print('    boxHeightStyle: BoxHeightStyle.tight,');
  print('    boxWidthStyle: BoxWidthStyle.tight,');
  print('  );');
  print('');
  print('  // Draw selection');
  print('  final selectionPaint = Paint()');
  print('    ..color = Colors.blue.withOpacity(0.3);');
  print('  for (final box in boxes) {');
  print('    canvas.drawRect(box.toRect(), selectionPaint);');
  print('  }');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: Combining with BoxHeightStyle
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 10: Combining with BoxHeightStyle                         │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('BoxWidthStyle and BoxHeightStyle work together:');
  print('');
  print('Common combinations:');
  print('');
  print('1. Tight + Tight (minimal selection):');
  print('   BoxHeightStyle.tight, BoxWidthStyle.tight');
  print('   ┌────┐');
  print('   │Text│');
  print('   └────┘');
  print('   Best for: Code editors, precise selection');
  print('');
  print('2. Max + Max (full block selection):');
  print('   BoxHeightStyle.max, BoxWidthStyle.max');
  print('   ┌─────────────────────────────┐');
  print('   │                             │');
  print('   │ Text                        │');
  print('   │                             │');
  print('   └─────────────────────────────┘');
  print('   Best for: Block/column selection');
  print('');
  print('3. Tight + Max (line selection):');
  print('   BoxHeightStyle.tight, BoxWidthStyle.max');
  print('   ┌─────────────────────────────┐');
  print('   │ Text                        │');
  print('   └─────────────────────────────┘');
  print('   Best for: Line-based selection');
  print('');
  print('4. includeLineSpacingMiddle + Tight (spaced selection):');
  print('   BoxHeightStyle.includeLineSpacingMiddle, BoxWidthStyle.tight');
  print('   Best for: Readable multi-line selection');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: Selection Boxes Return Value
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 11: Selection Boxes Return Value                          │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('getBoxesForRange() returns List<TextBox>:');
  print('');
  print('TextBox properties:');
  print('  - left: Left edge of the box');
  print('  - top: Top edge of the box');
  print('  - right: Right edge of the box');
  print('  - bottom: Bottom edge of the box');
  print('  - direction: TextDirection (ltr or rtl)');
  print('');
  print('Example with tight width:');
  print('  TextBox(left: 45.0, top: 2.0, right: 120.0, bottom: 18.0)');
  print('  Width = 75.0 (actual text width)');
  print('');
  print('Example with max width:');
  print('  TextBox(left: 0.0, top: 2.0, right: 300.0, bottom: 18.0)');
  print('  Width = 300.0 (paragraph width)');
  print('');
  print('Converting to Rect:');
  print('  final Rect rect = textBox.toRect();');
  print('  canvas.drawRect(rect, paint);');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 12: Line Breaking Considerations
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 12: Line Breaking Considerations                          │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('When text wraps to multiple lines:');
  print('');
  print('Tight width behavior:');
  print('  - Each line gets its own TextBox');
  print('  - Box width varies per line based on content');
  print('  - Partial lines have partial width');
  print('');
  print('Max width behavior:');
  print('  - Each line gets its own TextBox');
  print('  - All boxes have same width (paragraph width)');
  print('  - Even partial content fills full width');
  print('');
  print('Example with wrapped text:');
  print('  "The quick brown fox\\njumps over"');
  print('  Paragraph width: 200');
  print('  Selected: entire text');
  print('');
  print('  Tight returns:');
  print('    Box 1: width = 150 (actual "The quick brown fox")');
  print('    Box 2: width = 100 (actual "jumps over")');
  print('');
  print('  Max returns:');
  print('    Box 1: width = 200 (full paragraph)');
  print('    Box 2: width = 200 (full paragraph)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 13: Performance Considerations
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 13: Performance Considerations                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('BoxWidthStyle performance:');
  print('');
  print('Both styles have similar performance:');
  print('  - Same number of boxes returned');
  print('  - Calculation complexity is equivalent');
  print('  - No significant difference in memory usage');
  print('');
  print('Performance tips for text selection:');
  print('');
  print('1. Cache TextPainter for repeated selection:');
  print('   - Don\'t recreate TextPainter every frame');
  print('   - Call layout() only when text changes');
  print('');
  print('2. Minimize getBoxesForSelection calls:');
  print('   - Cache results when selection doesn\'t change');
  print('   - Batch multiple selection queries');
  print('');
  print('3. Use tight when max isn\'t needed:');
  print('   - Tight boxes are easier to hit-test');
  print('   - More precise for cursor positioning');
  print('');
  print('4. Consider caret position vs selection:');
  print('   - For caret, use getPositionForOffset');
  print('   - For selection, use getBoxesForSelection');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 14: Common Selection Patterns
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 14: Common Selection Patterns                             │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('Selection patterns by application type:');
  print('');
  print('1. Text Editor (like VS Code):');
  print('   - Primary: tight + tight');
  print('   - Column select: tight height, custom width calculation');
  print('');
  print('2. Word Processor (like Google Docs):');
  print('   - Primary: tight + tight');
  print('   - Line select: tight + max');
  print('');
  print('3. Rich Text Viewer:');
  print('   - Primary: includeLineSpacingMiddle + tight');
  print('   - Better readability with line spacing');
  print('');
  print('4. Terminal Emulator:');
  print('   - All: max + max');
  print('   - Block-based selection');
  print('');
  print('5. Mobile Text Selection:');
  print('   - Primary: tight + tight');
  print('   - Handles positioned at box edges');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 15: Summary
  // ═══════════════════════════════════════════════════════════════════════════
  print('');
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 15: Summary                                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  print('BoxWidthStyle summary:');
  print('');
  print('┌───────────┬────────────────────────────────────────────────────────┐');
  print('│ Style     │ Description                                            │');
  print('├───────────┼────────────────────────────────────────────────────────┤');
  print('│ tight     │ Width matches selected text (default)                  │');
  print('│ max       │ Width extends to paragraph width                       │');
  print('└───────────┴────────────────────────────────────────────────────────┘');
  print('');
  print('Key points:');
  print('  1. Only 2 values: tight and max');
  print('  2. Used with Paragraph.getBoxesForRange() or TextPainter');
  print('  3. Affects horizontal bounds of selection boxes');
  print('  4. Works in combination with BoxHeightStyle');
  print('  5. tight is default and most common');
  print('  6. max is useful for full-line or block selection');
  print('  7. Same performance characteristics for both');
  print('');
  print('═══════════════════════════════════════════════════════════════════════');
  print('BoxWidthStyle deep demo completed');

  // Return visual UI
  return Container(
    padding: EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.green.shade50, Colors.teal.shade50],
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
            color: Colors.teal.shade600,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.width_normal, color: Colors.white, size: 32),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BoxWidthStyle',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Text Selection Horizontal Width Control',
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

        // Values display
        Text(
          'BoxWidthStyle Values',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade800,
          ),
        ),
        SizedBox(height: 12),
        Row(
          children: ui.BoxWidthStyle.values.map((style) {
            final isMax = style == ui.BoxWidthStyle.max;
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: isMax ? 0 : 12),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isMax ? Colors.blue.shade100 : Colors.green.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: isMax ? Colors.blue.shade400 : Colors.green.shade400,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      isMax ? Icons.fullscreen : Icons.fit_screen,
                      color: isMax ? Colors.blue.shade700 : Colors.green.shade700,
                      size: 32,
                    ),
                    SizedBox(height: 8),
                    Text(
                      style.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isMax ? Colors.blue.shade700 : Colors.green.shade700,
                      ),
                    ),
                    Text(
                      'index: ${style.index}',
                      style: TextStyle(
                        fontSize: 12,
                        color: isMax ? Colors.blue.shade500 : Colors.green.shade500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      isMax ? 'Full paragraph width' : 'Content width only',
                      style: TextStyle(
                        fontSize: 11,
                        color: isMax ? Colors.blue.shade600 : Colors.green.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 24),

        // Visual comparison
        Text(
          'Visual Comparison',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal.shade800,
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
              Text(
                'Text: "The quick brown fox"',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              Text(
                'Selected: "quick"',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 16),
              _WidthStyleVisual(
                label: 'tight',
                description: 'Width = selected text only',
                isMax: false,
              ),
              SizedBox(height: 12),
              _WidthStyleVisual(
                label: 'max',
                description: 'Width = full paragraph',
                isMax: true,
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
                title: 'Used With',
                content: 'Paragraph &\nTextPainter',
                color: Colors.teal,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _InfoCard(
                icon: Icons.compare_arrows,
                title: 'Partner',
                content: 'BoxHeightStyle',
                color: Colors.indigo,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _InfoCard(
                icon: Icons.check_circle,
                title: 'Default',
                content: 'tight',
                color: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // Bottom summary
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.teal.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.teal.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.teal.shade600, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${ui.BoxWidthStyle.values.length} values: tight (content-bound) and max (full-width) • Use for text selection boxes',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.teal.shade700,
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

// Helper widget to visualize width styles
class _WidthStyleVisual extends StatelessWidget {
  final String label;
  final String description;
  final bool isMax;

  const _WidthStyleVisual({
    required this.label,
    required this.description,
    required this.isMax,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isMax ? Colors.blue.shade700 : Colors.green.shade700,
          ),
        ),
        SizedBox(height: 4),
        Container(
          height: 32,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Text('  The ', style: TextStyle(color: Colors.grey.shade700)),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: isMax ? Colors.blue.shade200 : Colors.green.shade200,
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  'quick',
                  style: TextStyle(
                    color: isMax ? Colors.blue.shade800 : Colors.green.shade800,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: isMax
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.blue.shade100,
                        ),
                        child: Text(
                          ' brown fox',
                          style: TextStyle(color: Colors.blue.shade400),
                        ),
                      )
                    : Text(
                        ' brown fox',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
              ),
            ],
          ),
        ),
        Text(
          description,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
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
