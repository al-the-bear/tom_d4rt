// D4rt test script: Tests BoxHeightStyle from dart_ui
// BoxHeightStyle controls how text selection rectangles are calculated vertically
// Used in Paragraph.getBoxesForRange() and TextPainter
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: BoxHeightStyle Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All BoxHeightStyle Values
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: BoxHeightStyle.tight
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: BoxHeightStyle.max
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: BoxHeightStyle.strut
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: BoxHeightStyle.includeLineSpacingTop
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: BoxHeightStyle.includeLineSpacingMiddle
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: BoxHeightStyle.includeLineSpacingBottom
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: Comparing Height Styles
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: Usage with Paragraph
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: Usage with TextPainter
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 12: Multi-Line Selection Considerations
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 13: Platform-Specific Behavior
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 14: Practical Selection Implementation
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 15: Summary
  // ═══════════════════════════════════════════════════════════════════════════

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
                    style: TextStyle(fontSize: 14, color: Colors.white70),
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
                  style: TextStyle(fontSize: 12, color: Colors.indigo.shade700),
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
  final MaterialColor color;

  const _HeightStyleVisual({
    required this.label,
    required this.description,
    required this.topPadding,
    required this.bottomPadding,
    required this.color, // MaterialColor for shade access
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
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
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
  final MaterialColor color;

  const _InfoCard({
    required this.icon,
    required this.title,
    required this.content,
    required this.color, // MaterialColor for shade access
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
            style: TextStyle(fontSize: 10, color: color.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
