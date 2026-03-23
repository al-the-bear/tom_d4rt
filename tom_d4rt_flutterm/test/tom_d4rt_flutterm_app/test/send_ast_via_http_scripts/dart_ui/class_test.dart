// ignore_for_file: avoid_print
// D4rt test script: Tests dart:ui core class availability and type system
// Comprehensive overview of dart:ui class hierarchy and categories
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: dart:ui Introduction
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: Geometry Classes
  // ═══════════════════════════════════════════════════════════════════════════

  // Offset

  // Size

  // Rect
  final rect = Rect.fromLTWH(0, 0, 100, 100);

  // RRect

  // Radius

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: OffsetBase Hierarchy
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: Painting Classes
  // ═══════════════════════════════════════════════════════════════════════════

  // Paint
  final paint = Paint()
    ..color = const Color(0xFF2196F3)
    ..style = PaintingStyle.fill
    ..strokeWidth = 2.0;

  // Color

  // Path

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Text Classes
  // ═══════════════════════════════════════════════════════════════════════════

  // ParagraphStyle

  // ui.TextStyle

  // TextPosition

  // TextRange

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Recording & Scene Classes
  // ═══════════════════════════════════════════════════════════════════════════

  // PictureRecorder
  final recorder = ui.PictureRecorder();

  // Create a Canvas from recorder
  final canvas = Canvas(recorder);

  // Draw something
  canvas.drawRect(rect, paint);

  // Get Picture
  final picture = recorder.endRecording();
  picture.dispose();

  // SceneBuilder
  final sb = ui.SceneBuilder();
  sb.build().dispose();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Semantics Classes
  // ═══════════════════════════════════════════════════════════════════════════

  // SemanticsUpdateBuilder
  final sub = ui.SemanticsUpdateBuilder();

  final update = sub.build();
  update.dispose();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Image & Codec Classes
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: Platform Channel Classes
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: Window & View Classes
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: Shader & Effect Classes
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 12: Enums in dart:ui
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 13: Native Resources & Disposal
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 14: Class Categories Summary
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 15: Summary
  // ═══════════════════════════════════════════════════════════════════════════

  // Return visual UI showing class categories
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.indigo.shade50, Colors.purple.shade50],
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.indigo.shade700,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.data_object, color: Colors.white, size: 32),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'dart:ui Classes',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Core Flutter Rendering API',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Class categories grid
        Text(
          'Class Categories',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _CategoryChip(
              icon: Icons.crop_square,
              label: 'Geometry',
              examples: 'Offset, Size, Rect',
              color: Colors.blue,
            ),
            _CategoryChip(
              icon: Icons.brush,
              label: 'Painting',
              examples: 'Paint, Path, Canvas',
              color: Colors.orange,
            ),
            _CategoryChip(
              icon: Icons.text_fields,
              label: 'Text',
              examples: 'Paragraph, TextStyle',
              color: Colors.green,
            ),
            _CategoryChip(
              icon: Icons.image,
              label: 'Image',
              examples: 'Image, Codec',
              color: Colors.purple,
            ),
            _CategoryChip(
              icon: Icons.auto_fix_high,
              label: 'Effects',
              examples: 'Shader, Filter',
              color: Colors.pink,
            ),
            _CategoryChip(
              icon: Icons.fiber_manual_record,
              label: 'Recording',
              examples: 'Picture, Scene',
              color: Colors.teal,
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Hierarchy example
        Text(
          'Type Hierarchy Example',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.indigo.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OffsetBase (abstract)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '├── ',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Offset',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' (dx, dy)',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '└── ',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          'Size',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          ' (width, height)',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Key info
        Row(
          children: [
            Expanded(
              child: _InfoCard(
                icon: Icons.memory,
                title: 'Native',
                content: 'Dispose required',
                color: Colors.red,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _InfoCard(
                icon: Icons.layers,
                title: 'Low-level',
                content: 'Foundation API',
                color: Colors.purple,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _InfoCard(
                icon: Icons.upload,
                title: 'Re-exported',
                content: 'In flutter/',
                color: Colors.blue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Bottom summary
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.indigo.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.indigo.shade600, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'dart:ui provides the core rendering primitives that Flutter widgets are built upon',
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

// Helper widget for category chips
class _CategoryChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String examples;
  final MaterialColor color;

  const _CategoryChip({
    required this.icon,
    required this.label,
    required this.examples,
    required this.color, // MaterialColor for shade access
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.shade300),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color.shade700),
          const SizedBox(width: 6),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: color.shade700,
                ),
              ),
              Text(
                examples,
                style: TextStyle(fontSize: 9, color: color.shade600),
              ),
            ],
          ),
        ],
      ),
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
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.shade200),
      ),
      child: Column(
        children: [
          Icon(icon, color: color.shade600, size: 20),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: color.shade700,
            ),
          ),
          Text(
            content,
            style: TextStyle(fontSize: 9, color: color.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
