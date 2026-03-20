// D4rt test script: Deep demo for Constraints from rendering
//
// Constraints is the abstract base class for all constraint types.
// Constraints define bounds within which a RenderObject must size itself.
//
// Key subclasses:
//   - BoxConstraints: 2D width/height constraints
//   - SliverConstraints: Sliver scrolling constraints
//
// BoxConstraints properties:
//   - minWidth, maxWidth: Width bounds
//   - minHeight, maxHeight: Height bounds
//
// Constraint types:
//   - Tight: min == max (exact size)
//   - Loose: min == 0 (can be any size up to max)
//   - Bounded: Has finite max values
//   - Unbounded: Has infinite max (scrollable)
//
// Key methods:
//   - isTight: True if min == max
//   - isSatisfiedBy: Check if size fits
//   - constrain: Clamp size to bounds
//   - copyWith: Create modified copy
//
// This demo visualizes constraint behaviors.

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [const Color(0xFF5D4037), const Color(0xFF8D6E63)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF5D4037).withAlpha(100),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.straighten, size: 48, color: Colors.white),
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 14, color: Colors.white.withAlpha(200)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF8D6E63).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF5D4037), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D4037),
          ),
        ),
      ],
    ),
  );
}

Widget _buildConceptCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.margin, color: const Color(0xFF5D4037)),
            const SizedBox(width: 8),
            const Text(
              'What are Constraints?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: CustomPaint(
            size: const Size(double.infinity, 120),
            painter: _ConceptPainter(),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFEFEBE9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Parent tells child: "You must be\n'
            'between these min and max sizes"',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

class _ConceptPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;

    // Outer bounds (max)
    final maxRect = Rect.fromCenter(
      center: Offset(centerX, 55),
      width: 180,
      height: 90,
    );
    final maxPaint = Paint()
      ..color = const Color(0xFF8D6E63).withAlpha(50)
      ..style = PaintingStyle.fill;
    canvas.drawRect(maxRect, maxPaint);

    // Border
    final borderPaint = Paint()
      ..color = const Color(0xFF5D4037)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawRect(maxRect, borderPaint);

    // Inner bounds (min)
    final minRect = Rect.fromCenter(
      center: Offset(centerX, 55),
      width: 80,
      height: 40,
    );
    final minPaint = Paint()
      ..color = const Color(0xFF5D4037).withAlpha(30)
      ..style = PaintingStyle.fill;
    canvas.drawRect(minRect, minPaint);

    // Min border (dashed effect)
    borderPaint.color = const Color(0xFF5D4037);
    borderPaint.strokeWidth = 1;
    canvas.drawRect(minRect, borderPaint);

    // Labels
    _drawLabel(canvas, 'max', Offset(maxRect.right + 5, maxRect.center.dy - 5));
    _drawLabel(canvas, 'min', Offset(minRect.right + 5, minRect.center.dy - 5));

    // Arrows for dimensions
    _drawDimensionArrow(
      canvas,
      Offset(maxRect.left, maxRect.bottom + 10),
      Offset(maxRect.right, maxRect.bottom + 10),
      'maxWidth',
    );
  }

  void _drawDimensionArrow(
    Canvas canvas,
    Offset start,
    Offset end,
    String label,
  ) {
    final paint = Paint()
      ..color = const Color(0xFF5D4037)
      ..strokeWidth = 1;

    // Line
    canvas.drawLine(start, end, paint);

    // Arrowheads
    canvas.drawLine(start, Offset(start.dx + 5, start.dy - 3), paint);
    canvas.drawLine(start, Offset(start.dx + 5, start.dy + 3), paint);
    canvas.drawLine(end, Offset(end.dx - 5, end.dy - 3), paint);
    canvas.drawLine(end, Offset(end.dx - 5, end.dy + 3), paint);

    // Label
    final tp = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: Color(0xFF5D4037),
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(
      canvas,
      Offset((start.dx + end.dx) / 2 - tp.width / 2, start.dy + 3),
    );
  }

  void _drawLabel(Canvas canvas, String text, Offset pos) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Color(0xFF5D4037),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, pos);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildConstraintTypesCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.category, color: const Color(0xFF5D4037)),
            const SizedBox(width: 8),
            const Text(
              'Constraint Types',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 150,
          child: CustomPaint(
            size: const Size(double.infinity, 150),
            painter: _ConstraintTypesPainter(),
          ),
        ),
      ],
    ),
  );
}

class _ConstraintTypesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final types = [
      {'name': 'Tight', 'min': 0.8, 'max': 0.8, 'desc': 'min == max'},
      {'name': 'Loose', 'min': 0.0, 'max': 0.8, 'desc': 'min == 0'},
      {'name': 'Bounded', 'min': 0.3, 'max': 0.8, 'desc': 'finite bounds'},
      {'name': 'Unbounded', 'min': 0.0, 'max': 1.0, 'desc': 'max = ∞'},
    ];

    final cellW = size.width / 4;
    // Note: cellH = size.height available if needed for vertical layouts

    for (var i = 0; i < types.length; i++) {
      final t = types[i];
      final cx = cellW * i + cellW / 2;

      // Draw constraint visualization
      final boxH = 80.0;
      final boxW = 50.0;
      final minH = boxH * (t['min'] as double);
      final maxH = boxH * (t['max'] as double);

      // Max box
      final maxPaint = Paint()
        ..color = const Color(0xFF8D6E63).withAlpha(50)
        ..style = PaintingStyle.fill;
      canvas.drawRect(
        Rect.fromLTWH(cx - boxW / 2, 20 + (boxH - maxH), boxW, maxH),
        maxPaint,
      );

      // Border
      final borderPaint = Paint()
        ..color = const Color(0xFF5D4037)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRect(
        Rect.fromLTWH(cx - boxW / 2, 20 + (boxH - maxH), boxW, maxH),
        borderPaint,
      );

      // Min line
      if (minH > 0) {
        final minY = 20 + boxH - minH;
        borderPaint.strokeWidth = 1;
        borderPaint.color = Colors.red;
        canvas.drawLine(
          Offset(cx - boxW / 2 + 2, minY),
          Offset(cx + boxW / 2 - 2, minY),
          borderPaint,
        );
        _drawLabel(
          canvas,
          'min',
          Offset(cx + boxW / 2 + 2, minY - 5),
          8,
          Colors.red,
        );
      }

      // Labels
      _drawLabel(canvas, t['name'] as String, Offset(cx, 105), 11);
      _drawLabel(canvas, t['desc'] as String, Offset(cx, 118), 8, Colors.grey);

      // Infinity symbol for unbounded
      if (i == 3) {
        _drawLabel(canvas, '∞', Offset(cx + boxW / 2 + 5, 18), 14);
      }
    }
  }

  void _drawLabel(
    Canvas canvas,
    String text,
    Offset pos, [
    double fontSize = 10,
    Color? color,
  ]) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color ?? const Color(0xFF5D4037),
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(pos.dx - tp.width / 2, pos.dy));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildBoxConstraintsDemo(
  BoxConstraints c1,
  BoxConstraints c2,
  BoxConstraints c3,
) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.crop, color: const Color(0xFF5D4037)),
            const SizedBox(width: 8),
            const Text(
              'BoxConstraints Examples',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildConstraintRow('Tight', c1),
        _buildConstraintRow('Loose', c2),
        _buildConstraintRow('Bounded', c3),
      ],
    ),
  );
}

Widget _buildConstraintRow(String label, BoxConstraints c) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          width: 60,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFF5D4037),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFEFEBE9),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDim(
                  'W',
                  '${c.minWidth.toInt()}-${_formatMax(c.maxWidth)}',
                ),
                _buildDim(
                  'H',
                  '${c.minHeight.toInt()}-${_formatMax(c.maxHeight)}',
                ),
                _buildProp('tight', c.isTight),
                _buildProp('bounded', c.hasBoundedWidth && c.hasBoundedHeight),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

String _formatMax(double v) {
  return v.isFinite ? v.toInt().toString() : '∞';
}

Widget _buildDim(String label, String value) {
  return Column(
    children: [
      Text(label, style: const TextStyle(fontSize: 8, color: Colors.grey)),
      Text(
        value,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          fontFamily: 'monospace',
        ),
      ),
    ],
  );
}

Widget _buildProp(String label, bool value) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(
        value ? Icons.check_circle : Icons.cancel,
        size: 12,
        color: value ? const Color(0xFF4CAF50) : Colors.grey,
      ),
      const SizedBox(width: 2),
      Text(label, style: const TextStyle(fontSize: 9)),
    ],
  );
}

Widget _buildMethodsCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.functions, color: const Color(0xFF5D4037)),
            const SizedBox(width: 8),
            const Text(
              'Key Methods',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildMethodRow('constrain(size)', 'Clamps size to bounds'),
        _buildMethodRow('isSatisfiedBy(size)', 'Check if size fits'),
        _buildMethodRow('copyWith(...)', 'Create modified copy'),
        _buildMethodRow('enforce(c)', 'Combine constraint'),
        _buildMethodRow('loosen()', 'Set min to 0'),
        _buildMethodRow('tighten(w,h)', 'Make min == max'),
      ],
    ),
  );
}

Widget _buildMethodRow(String method, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 120,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: const Color(0xFFEFEBE9),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            method,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Color(0xFF5D4037),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 11, color: Colors.grey[700]),
          ),
        ),
      ],
    ),
  );
}

Widget _buildConstrainDemo(BoxConstraints c) {
  final testSizes = [
    const Size(50, 50), // Too small
    const Size(100, 100), // Just right
    const Size(200, 200), // Too big
  ];

  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.transform, color: const Color(0xFF5D4037)),
            const SizedBox(width: 8),
            const Text(
              'constrain() Demo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Constraints: W ${c.minWidth.toInt()}-${c.maxWidth.toInt()}, H ${c.minHeight.toInt()}-${c.maxHeight.toInt()}',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            color: Color(0xFF5D4037),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: testSizes.map((testSize) {
            final result = c.constrain(testSize);
            final changed = result != testSize;
            return Column(
              children: [
                Text(
                  '${testSize.width.toInt()}x${testSize.height.toInt()}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Icon(
                  Icons.arrow_downward,
                  size: 14,
                  color: changed ? Colors.orange : const Color(0xFF4CAF50),
                ),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: changed
                        ? Colors.orange.withAlpha(30)
                        : const Color(0xFF4CAF50).withAlpha(30),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: changed ? Colors.orange : const Color(0xFF4CAF50),
                    ),
                  ),
                  child: Text(
                    '${result.width.toInt()}x${result.height.toInt()}',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: changed ? Colors.orange : const Color(0xFF4CAF50),
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  changed ? 'Clamped' : 'OK',
                  style: TextStyle(
                    fontSize: 8,
                    color: changed ? Colors.orange : const Color(0xFF4CAF50),
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _buildCodeSnippet(String code) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 10,
        color: Color(0xFFD4D4D4),
        height: 1.4,
      ),
    ),
  );
}

Widget _buildUsageCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: const Color(0xFF5D4037)),
            const SizedBox(width: 8),
            const Text(
              'Common Usage',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildCodeSnippet(
          '// Create constraints\n'
          'final tight = BoxConstraints.tight(Size(100, 100));\n'
          'final loose = BoxConstraints.loose(Size(100, 100));\n'
          'final expand = BoxConstraints.expand();\n'
          '\n'
          '// Use in layout\n'
          'final size = constraints.constrain(Size(80, 80));\n'
          'if (constraints.isSatisfiedBy(size)) { ... }',
        ),
      ],
    ),
  );
}

Widget _buildSliverConstraintsCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.view_list, color: const Color(0xFF5D4037)),
            const SizedBox(width: 8),
            const Text(
              'SliverConstraints',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildPropertyRow('scrollOffset', 'Current scroll position'),
        _buildPropertyRow('remainingPaintExtent', 'Visible area'),
        _buildPropertyRow('crossAxisExtent', 'Width (vertical scroll)'),
        _buildPropertyRow('viewportMainAxisExtent', 'Viewport height'),
        _buildPropertyRow('overlap', 'Previous sliver overlap'),
      ],
    ),
  );
}

Widget _buildPropertyRow(String name, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Container(
          width: 130,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF5D4037),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 10, color: Colors.grey[700]),
          ),
        ),
      ],
    ),
  );
}

Widget _buildResultsCard(bool created, String type, bool tight, bool bounded) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.check_circle, color: const Color(0xFF4CAF50)),
            const SizedBox(width: 8),
            const Text(
              'Test Results',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildResultRow('Constraints created', created ? 'Yes' : 'No', created),
        _buildResultRow('Type', type, true),
        _buildResultRow('isTight', tight ? 'true' : 'false', tight),
        _buildResultRow('isBounded', bounded ? 'true' : 'false', bounded),
      ],
    ),
  );
}

Widget _buildResultRow(String label, String value, bool success) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Icon(
          success ? Icons.check_circle : Icons.info,
          size: 14,
          color: success ? const Color(0xFF4CAF50) : Colors.blue,
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 120,
          child: Text(label, style: const TextStyle(fontSize: 11)),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== Constraints Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Constraints Overview ---');
  print('Abstract base class for layout constraints');
  print('Defines bounds for RenderObject sizing');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: BOX CONSTRAINTS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- BoxConstraints Examples ---');

  // Tight constraints (exact size)
  final tightConstraints = BoxConstraints.tight(const Size(100, 100));
  print('Tight: $tightConstraints');
  print('  isTight: ${tightConstraints.isTight}');

  // Loose constraints (any size up to max)
  final looseConstraints = BoxConstraints.loose(const Size(150, 150));
  print('Loose: $looseConstraints');
  print('  isTight: ${looseConstraints.isTight}');

  // Bounded constraints
  final boundedConstraints = const BoxConstraints(
    minWidth: 50,
    maxWidth: 150,
    minHeight: 50,
    maxHeight: 150,
  );
  print('Bounded: $boundedConstraints');
  print(
    '  isBounded: ${boundedConstraints.hasBoundedWidth && boundedConstraints.hasBoundedHeight}',
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: CONSTRAIN METHOD
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- constrain() Method ---');
  final testSize = const Size(200, 200);
  final constrained = boundedConstraints.constrain(testSize);
  print('Input: $testSize');
  print('Constrained: $constrained');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: CONSTRAINT CHECKS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Constraint Checks ---');
  print(
    'isSatisfiedBy(100x100): ${boundedConstraints.isSatisfiedBy(const Size(100, 100))}',
  );
  print(
    'isSatisfiedBy(200x200): ${boundedConstraints.isSatisfiedBy(const Size(200, 200))}',
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: CONSTRAINT TYPES
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Constraint Types ---');
  print('BoxConstraints: 2D width/height bounds');
  print('SliverConstraints: Scrolling constraints');

  print('\n=== Constraints Deep Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL UI
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader('Constraints', 'Layout Bounds for Widgets'),
        const SizedBox(height: 20),

        // Concept
        _buildSectionTitle('Concept', Icons.margin),
        _buildConceptCard(),
        const SizedBox(height: 20),

        // Types
        _buildSectionTitle('Constraint Types', Icons.category),
        _buildConstraintTypesCard(),
        const SizedBox(height: 20),

        // BoxConstraints
        _buildSectionTitle('BoxConstraints', Icons.crop),
        _buildBoxConstraintsDemo(
          tightConstraints,
          looseConstraints,
          boundedConstraints,
        ),
        const SizedBox(height: 20),

        // Constrain demo
        _buildSectionTitle('constrain() Demo', Icons.transform),
        _buildConstrainDemo(boundedConstraints),
        const SizedBox(height: 20),

        // Methods
        _buildSectionTitle('Key Methods', Icons.functions),
        _buildMethodsCard(),
        const SizedBox(height: 20),

        // Usage
        _buildSectionTitle('Common Usage', Icons.code),
        _buildUsageCard(),
        const SizedBox(height: 20),

        // Sliver
        _buildSectionTitle('SliverConstraints', Icons.view_list),
        _buildSliverConstraintsCard(),
        const SizedBox(height: 20),

        // Results
        _buildSectionTitle('Test Results', Icons.check_circle),
        _buildResultsCard(
          true,
          'BoxConstraints',
          tightConstraints.isTight,
          boundedConstraints.hasBoundedWidth &&
              boundedConstraints.hasBoundedHeight,
        ),
        const SizedBox(height: 20),

        // Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEFEBE9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Summary',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Color(0xFF5D4037),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• Constraints define sizing bounds\n'
                '• BoxConstraints: 2D min/max width/height\n'
                '• Tight: min == max (exact size)\n'
                '• Loose: min == 0 (flexible)\n'
                '• constrain() clamps size to bounds\n'
                '• isSatisfiedBy() checks if size fits',
                style: TextStyle(fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    ),
  );
}
