// D4rt test script: Tests ClipOp from dart_ui
// ClipOp defines operations for combining clip regions on Canvas
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ClipOp Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All ClipOp Values
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: ClipOp.intersect
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: ClipOp.difference
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: Canvas.clipRect with ClipOp
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: Canvas.clipPath with ClipOp
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: Canvas.clipRRect with ClipOp
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: Practical Use Cases
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: CustomPainter Example - Intersect
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: CustomPainter Example - Difference
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 11: Spotlight/Reveal Effect
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 12: Save/Restore with Clips
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 13: Performance Considerations
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 14: Comparison with PathOperation
  // ═══════════════════════════════════════════════════════════════════════════

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 15: Summary
  // ═══════════════════════════════════════════════════════════════════════════

  // Return visual UI demonstrating ClipOp operations
  return Container(
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
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
            color: Colors.blue.shade700,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.crop, color: Colors.white, size: 32),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ClipOp',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Canvas Clip Region Operations',
                    style: TextStyle(fontSize: 14, color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        // Values display
        Text(
          'All ClipOp Values',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: ui.ClipOp.values.map((op) {
            final isIntersect = op == ui.ClipOp.intersect;
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: isIntersect ? 12 : 0),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isIntersect
                      ? Colors.green.shade50
                      : Colors.orange.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isIntersect
                        ? Colors.green.shade400
                        : Colors.orange.shade400,
                    width: 2,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      isIntersect
                          ? Icons.filter_center_focus
                          : Icons.content_cut,
                      size: 40,
                      color: isIntersect
                          ? Colors.green.shade700
                          : Colors.orange.shade700,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      op.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isIntersect
                            ? Colors.green.shade700
                            : Colors.orange.shade700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isIntersect
                          ? 'Keep intersection\n(default)'
                          : 'Create hole\n(cutout)',
                      style: TextStyle(
                        fontSize: 11,
                        color: isIntersect
                            ? Colors.green.shade600
                            : Colors.orange.shade600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),

        // Visual demonstration
        Text(
          'Visual Demonstration',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.blue.shade800,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _ClipOpDemo(
                title: 'intersect',
                subtitle: 'A ∩ B',
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ClipOpDemo(
                title: 'difference',
                subtitle: 'A - B',
                color: Colors.orange,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Use cases
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Common Use Cases:',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'intersect:',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                        Text(
                          '• Viewport clipping',
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          '• Image cropping',
                          style: TextStyle(fontSize: 10),
                        ),
                        Text('• Nested clips', style: TextStyle(fontSize: 10)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'difference:',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade700,
                          ),
                        ),
                        Text('• Donut shapes', style: TextStyle(fontSize: 10)),
                        Text(
                          '• Spotlight reveals',
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          '• Window cutouts',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Bottom summary
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.blue.shade200),
          ),
          child: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.blue.shade600, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${ui.ClipOp.values.length} operations • Used with Canvas.clipRect • clipPath/clipRRect always intersect',
                  style: TextStyle(fontSize: 12, color: Colors.blue.shade700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// Helper widget for ClipOp visual demonstration
class _ClipOpDemo extends StatelessWidget {
  final String title;
  final String subtitle;
  final MaterialColor color;

  const _ClipOpDemo({
    required this.title,
    required this.subtitle,
    required this.color, // MaterialColor for shade access
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: color.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.shade300),
      ),
      child: Stack(
        children: [
          // First rect
          Positioned(
            left: 10,
            top: 10,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.shade200.withAlpha(150),
                border: Border.all(color: color.shade400),
              ),
            ),
          ),
          // Second rect
          Positioned(
            left: 35,
            top: 35,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.shade300.withAlpha(150),
                border: Border.all(color: color.shade500),
              ),
            ),
          ),
          // Label
          Positioned(
            right: 8,
            bottom: 8,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color.shade700,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 10, color: color.shade600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
