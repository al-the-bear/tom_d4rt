// ignore_for_file: avoid_print
// D4rt test script: Tests BoxWidthStyle from dart_ui
// BoxWidthStyle controls how text selection rectangles are calculated horizontally
// Used in Paragraph.getBoxesForRange() and TextPainter
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: BoxWidthStyle Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All BoxWidthStyle Values
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: BoxWidthStyle.tight
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: BoxWidthStyle.max
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Comparing Width Styles
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Multi-Line Selection Behavior
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: RTL and Bidirectional Text
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Usage with Paragraph
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: Usage with TextPainter
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: Combining with BoxHeightStyle
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: Selection Boxes Return Value
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 12: Line Breaking Considerations
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 13: Performance Considerations
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 14: Common Selection Patterns
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
                    style: TextStyle(fontSize: 14, color: Colors.white70),
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
                      color: isMax
                          ? Colors.blue.shade700
                          : Colors.green.shade700,
                      size: 32,
                    ),
                    SizedBox(height: 8),
                    Text(
                      style.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isMax
                            ? Colors.blue.shade700
                            : Colors.green.shade700,
                      ),
                    ),
                    Text(
                      'index: ${style.index}',
                      style: TextStyle(
                        fontSize: 12,
                        color: isMax
                            ? Colors.blue.shade500
                            : Colors.green.shade500,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      isMax ? 'Full paragraph width' : 'Content width only',
                      style: TextStyle(
                        fontSize: 11,
                        color: isMax
                            ? Colors.blue.shade600
                            : Colors.green.shade600,
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
                style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
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
                  style: TextStyle(fontSize: 12, color: Colors.teal.shade700),
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
                        decoration: BoxDecoration(color: Colors.blue.shade100),
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
          style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
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
