// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for BoxHeightStyle from dart:ui
// BoxHeightStyle controls how text selection rectangles are calculated vertically
// Used in Paragraph.getBoxesForRange() and TextPainter
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== BoxHeightStyle Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: BoxHeightStyle Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  print('BoxHeightStyle controls the vertical extent of selection rectangles');
  print('All values: ${ui.BoxHeightStyle.values}');
  print('Count: ${ui.BoxHeightStyle.values.length}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All BoxHeightStyle Values with Details
  // ═══════════════════════════════════════════════════════════════════════════

  final styleDetails = <ui.BoxHeightStyle, String>{
    ui.BoxHeightStyle.tight: 'Hugs the glyph bounds tightly',
    ui.BoxHeightStyle.max: 'Uses maximum line metrics height',
    ui.BoxHeightStyle.strut: 'Uses strut metrics for consistent height',
    ui.BoxHeightStyle.includeLineSpacingTop: 'Adds line spacing at top',
    ui.BoxHeightStyle.includeLineSpacingMiddle: 'Splits line spacing evenly',
    ui.BoxHeightStyle.includeLineSpacingBottom: 'Adds line spacing at bottom',
  };

  for (final e in styleDetails.entries) {
    print('${e.key.name} (index ${e.key.index}): ${e.value}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: BoxHeightStyle.tight
  // ═══════════════════════════════════════════════════════════════════════════

  final tight = ui.BoxHeightStyle.tight;
  print('\ntight: ${tight.name}, index=${tight.index}');
  print('tight is the default: fits exactly around glyph bounds');
  print('Best for: inline highlighting, badges, chips');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: BoxHeightStyle.max
  // ═══════════════════════════════════════════════════════════════════════════

  final maxStyle = ui.BoxHeightStyle.max;
  print('\nmax: ${maxStyle.name}, index=${maxStyle.index}');
  print('Uses the full line height from font metrics');
  print('Best for: block-level selections, full line highlighting');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: BoxHeightStyle.strut
  // ═══════════════════════════════════════════════════════════════════════════

  final strut = ui.BoxHeightStyle.strut;
  print('\nstrut: ${strut.name}, index=${strut.index}');
  print('Uses StrutStyle metrics for consistent height across mixed fonts');
  print('Best for: code editors, uniform line height across mixed-size text');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: includeLineSpacingTop
  // ═══════════════════════════════════════════════════════════════════════════

  final spacingTop = ui.BoxHeightStyle.includeLineSpacingTop;
  print('\nincludeLineSpacingTop: index=${spacingTop.index}');
  print('Extends selection upward to include line spacing');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: includeLineSpacingMiddle
  // ═══════════════════════════════════════════════════════════════════════════

  final spacingMiddle = ui.BoxHeightStyle.includeLineSpacingMiddle;
  print('\nincludeLineSpacingMiddle: index=${spacingMiddle.index}');
  print('Splits line spacing 50/50 between top and bottom');
  print('Creates seamless selection for multi-line text');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: includeLineSpacingBottom
  // ═══════════════════════════════════════════════════════════════════════════

  final spacingBottom = ui.BoxHeightStyle.includeLineSpacingBottom;
  print('\nincludeLineSpacingBottom: index=${spacingBottom.index}');
  print('Extends selection downward to include line spacing');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: Equality & Comparison
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Equality Tests ---');
  print('tight == tight: ${tight == ui.BoxHeightStyle.tight}');
  print('tight == max: ${tight == maxStyle}');
  print('strut == strut: ${strut == ui.BoxHeightStyle.strut}');
  print(
    'index ordering: ${ui.BoxHeightStyle.values.map((v) => '${v.name}=${v.index}').join(', ')}',
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: Platform Behavior Notes
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Platform Notes ---');
  print('Android: respects all styles');
  print('iOS: tight is default for selection');
  print('Web: behavior depends on rendering backend');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL HELPERS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget styleCard(
    ui.BoxHeightStyle style,
    String desc,
    Color color,
    double topPad,
    double bottomPad,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  style.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: color,
                  ),
                ),
                Text(
                  'index ${style.index}',
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                ),
                SizedBox(height: 2),
                Text(
                  desc,
                  style: TextStyle(fontSize: 10, color: Colors.grey[700]),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top: topPad, bottom: bottomPad),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                border: Border.all(color: color.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.25),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Text(
                  'Selected Text',
                  style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoCard(IconData icon, String title, String content, Color color) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            content,
            style: TextStyle(fontSize: 10, color: Colors.grey[700]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget comparisonRow(String label, double height, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: TextStyle(fontSize: 10)),
          ),
          Container(
            width: 140,
            height: height,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.3),
              border: Border.all(color: color),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Center(
              child: Text(
                '${height.toInt()}px',
                style: TextStyle(fontSize: 9, color: color),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD LAYOUT
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title banner
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.deepPurple],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.height, color: Colors.white, size: 36),
              SizedBox(height: 8),
              Text(
                'BoxHeightStyle Deep Demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Vertical text selection rectangle control',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Values overview
        Text(
          '1. All BoxHeightStyle Values',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final e in styleDetails.entries)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: [
                    Colors.green,
                    Colors.blue,
                    Colors.purple,
                    Colors.orange,
                    Colors.teal,
                    Colors.pink,
                  ][e.key.index].withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: [
                      Colors.green,
                      Colors.blue,
                      Colors.purple,
                      Colors.orange,
                      Colors.teal,
                      Colors.pink,
                    ][e.key.index].withValues(alpha: 0.5),
                    width: 1.5,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      e.key.name,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'index: ${e.key.index}',
                      style: TextStyle(fontSize: 9, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(height: 16),

        // Visual comparison of each style
        Text(
          '2. Visual Height Comparison',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'How each style affects the selection box height',
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
        SizedBox(height: 8),
        styleCard(tight, 'Hugs glyphs tightly', Colors.green, 0, 0),
        styleCard(maxStyle, 'Full line height', Colors.blue, 4, 4),
        styleCard(strut, 'Strut metrics', Colors.purple, 6, 6),
        styleCard(spacingTop, 'Spacing at top', Colors.orange, 12, 0),
        styleCard(spacingMiddle, 'Split spacing', Colors.teal, 6, 6),
        styleCard(spacingBottom, 'Spacing at bottom', Colors.pink, 0, 12),
        SizedBox(height: 16),

        // Height comparison bars
        Text(
          '3. Relative Heights',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        comparisonRow('tight', 20, Colors.green),
        comparisonRow('max', 28, Colors.blue),
        comparisonRow('strut', 32, Colors.purple),
        comparisonRow('spacingTop', 32, Colors.orange),
        comparisonRow('spacingMiddle', 32, Colors.teal),
        comparisonRow('spacingBottom', 32, Colors.pink),
        SizedBox(height: 16),

        // Multi-line scenario
        Text(
          '4. Multi-Line Selection Scenario',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'When selecting across multiple lines:',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 8),
              for (final pair in [
                MapEntry('tight', 'Gaps may appear between lines'),
                MapEntry('max', 'No gaps, uses maximum line metrics'),
                MapEntry('strut', 'Consistent height regardless of font size'),
                MapEntry(
                  'spacingMiddle',
                  'Seamless selection with shared spacing',
                ),
              ])
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        margin: EdgeInsets.only(top: 4, right: 8),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.indigo,
                        ),
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          pair.key,
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          pair.value,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Info cards
        Text(
          '5. Usage Context',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: infoCard(
                Icons.format_size,
                'Primary Use',
                'Paragraph\n.getBoxesForRange()',
                Colors.blue,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: infoCard(
                Icons.select_all,
                'Affects',
                'Selection box\nvertical extent',
                Colors.green,
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: infoCard(
                Icons.text_fields,
                'Related',
                'BoxWidthStyle\nfor horizontal',
                Colors.orange,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // Platform notes
        Text(
          '6. Platform Behavior',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        for (final p in [
          MapEntry('Android', 'Respects all styles'),
          MapEntry('iOS', 'tight is default for text selection'),
          MapEntry('Web', 'Depends on HTML/CanvasKit renderer'),
        ])
          Container(
            margin: EdgeInsets.symmetric(vertical: 2),
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              children: [
                Container(
                  width: 70,
                  child: Text(
                    p.key,
                    style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Text(
                    p.value,
                    style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
          ),
        SizedBox(height: 16),

        // Summary
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.indigo, size: 20),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${ui.BoxHeightStyle.values.length} styles • Use with TextPainter or Paragraph • Most relevant for multi-line text selection',
                  style: TextStyle(fontSize: 11, color: Colors.indigo),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 24),
      ],
    ),
  );
}
