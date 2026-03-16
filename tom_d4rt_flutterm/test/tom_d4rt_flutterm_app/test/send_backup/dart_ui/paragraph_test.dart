import 'dart:ui' as ui;
import 'package:flutter/material.dart';

/// Deep visual demo for Paragraph - laid out text.
/// Demonstrates paragraph layout with styles and constraints.
dynamic build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(title: const Text('Paragraph Demo')),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Paragraph', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Low-level text layout object', style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius: BorderRadius.circular(12)),
            child: SizedBox(
              height: 150,
              child: CustomPaint(
                painter: _ParagraphPainter(),
                size: const Size(double.infinity, 150),
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildProp('width', 'Layout width constraint'),
          _buildProp('height', 'Computed height'),
          _buildProp('minIntrinsicWidth', 'Min width without wrapping'),
          _buildProp('maxIntrinsicWidth', 'Max width with all content'),
          _buildProp('getPositionForOffset', 'Character at point'),
        ],
      ),
    ),
  );
}

Widget _buildProp(String name, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [
      Text(name, style: const TextStyle(fontFamily: 'monospace', fontWeight: FontWeight.w500)),
      const SizedBox(width: 12),
      Text(desc, style: TextStyle(color: Colors.grey.shade600)),
    ]),
  );
}

class _ParagraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final builder = ui.ParagraphBuilder(ui.ParagraphStyle(textAlign: ui.TextAlign.left, fontSize: 14))
      ..pushStyle(ui.TextStyle(color: const Color(0xFF000000)))
      ..addText('Flutter uses ParagraphBuilder to create Paragraph objects for text layout. '
                'The Paragraph holds the computed layout results.');
    
    final paragraph = builder.build()..layout(ui.ParagraphConstraints(width: size.width));
    canvas.drawParagraph(paragraph, Offset.zero);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
