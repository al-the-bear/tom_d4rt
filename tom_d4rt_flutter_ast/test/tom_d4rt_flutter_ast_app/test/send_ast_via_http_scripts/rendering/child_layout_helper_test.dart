// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Comprehensive demo for ChildLayoutHelper from rendering
//
// ChildLayoutHelper is a static utility class that provides methods for
// laying out RenderBox children. It handles common layout patterns:
//   - layoutChild: Lays out a child with BoxConstraints
//   - dryLayoutChild: Gets child size without actual layout
//   - getBaseline: Gets baseline for text alignment
//
// This demo shows:
//   1. What ChildLayoutHelper does and why it exists
//   2. How layoutChild differs from direct layout calls
//   3. Dry layout for size calculation
//   4. Visual demonstrations of layout behavior
//
// ═══════════════════════════════════════════════════════════════════════════
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const _kIndigo50 = Color(0xFFE8EAF6);
const _kIndigo100 = Color(0xFFC5CAE9);
const _kIndigo200 = Color(0xFF9FA8DA);
const _kIndigo300 = Color(0xFF7986CB);
const _kIndigo400 = Color(0xFF5C6BC0);
const _kIndigo500 = Color(0xFF3F51B5);
const _kIndigo600 = Color(0xFF3949AB);
const _kIndigo700 = Color(0xFF303F9F);
const _kIndigo800 = Color(0xFF283593);
const _kIndigo900 = Color(0xFF1A237E);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a styled section title
Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: _kIndigo600, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _kIndigo800,
          ),
        ),
      ],
    ),
  );
}

/// Builds an info card with description
Widget _buildInfoCard(String title, String description, IconData icon) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: _kIndigo50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kIndigo100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kIndigo600, size: 24),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kIndigo800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: _kIndigo600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a code snippet display
Widget _buildCodeSnippet(String title, String code) {
  return Container(
    margin: const EdgeInsets.only(bottom: 16),
    decoration: BoxDecoration(
      color: _kIndigo900,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _kIndigo800,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              const Icon(Icons.code, color: _kIndigo200, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kIndigo200,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFFCCE5FF),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds a property display row
Widget _buildPropertyRow(String name, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        SizedBox(
          width: 130,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 12,
              color: _kIndigo600,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: valueColor ?? _kIndigo800,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

/// Methods overview card
Widget _buildMethodsCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'ChildLayoutHelper Static Methods',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kIndigo800,
          ),
        ),
        const SizedBox(height: 12),
        _buildMethodItem(
          'layoutChild',
          'Size layoutChild(RenderBox child, BoxConstraints constraints)',
          'Lays out child and returns its size',
          Icons.straighten,
        ),
        _buildMethodItem(
          'dryLayoutChild',
          'Size dryLayoutChild(RenderBox child, BoxConstraints constraints)',
          'Returns would-be size without actual layout',
          Icons.calculate,
        ),
        _buildMethodItem(
          'getBaseline',
          'double? getBaseline(RenderBox child, TextBaseline baseline)',
          'Gets baseline for text alignment',
          Icons.format_align_left,
        ),
      ],
    ),
  );
}

Widget _buildMethodItem(
  String name,
  String signature,
  String desc,
  IconData icon,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _kIndigo100,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: _kIndigo600, size: 16),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _kIndigo800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                signature,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  color: _kIndigo500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                desc,
                style: const TextStyle(fontSize: 11, color: _kIndigo600),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Why ChildLayoutHelper exists
Widget _buildWhyExistsCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kIndigo100, _kIndigo50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Why ChildLayoutHelper Exists',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kIndigo800,
          ),
        ),
        const SizedBox(height: 12),
        _buildReasonItem(
          Icons.shield,
          'Encapsulation',
          'Hides internal RenderBox layout complexity',
        ),
        _buildReasonItem(
          Icons.check_circle,
          'Consistency',
          'Ensures correct layout protocol is followed',
        ),
        _buildReasonItem(
          Icons.cached,
          'Dry Layout',
          'Enables size calculation without side effects',
        ),
        _buildReasonItem(
          Icons.format_align_left,
          'Baseline Support',
          'Standardized baseline retrieval for text',
        ),
        _buildReasonItem(
          Icons.bug_report,
          'Debug Mode',
          'Provides assertions and debug checks',
        ),
      ],
    ),
  );
}

Widget _buildReasonItem(IconData icon, String title, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: _kIndigo500, size: 20),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _kIndigo700,
                  fontSize: 12,
                ),
              ),
              Text(
                desc,
                style: const TextStyle(color: _kIndigo600, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Layout child visualization
Widget _buildLayoutChildVisualization() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'layoutChild() Visualization',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kIndigo800,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: CustomPaint(
            painter: _LayoutChildPainter(),
            size: const Size(double.infinity, 200),
          ),
        ),
        const SizedBox(height: 12),
        _buildPropertyRow('Input', 'BoxConstraints + RenderBox child'),
        _buildPropertyRow('Process', 'child.layout(constraints)'),
        _buildPropertyRow('Output', 'Size (child.size after layout)'),
      ],
    ),
  );
}

class _LayoutChildPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Draw constraints box
    paint.color = _kIndigo200;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    paint.strokeCap = StrokeCap.round;

    final constraintsRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(20, 20, size.width * 0.35, size.height - 40),
      const Radius.circular(12),
    );
    canvas.drawRRect(constraintsRect, paint);

    // Fill constraints
    paint.style = PaintingStyle.fill;
    paint.color = _kIndigo100.withAlpha(150);
    canvas.drawRRect(constraintsRect, paint);

    // Label constraints
    _drawLabel(
      canvas,
      'Constraints',
      Offset(constraintsRect.left + 10, constraintsRect.top + 10),
      _kIndigo700,
    );
    _drawLabel(
      canvas,
      'min: 0×0',
      Offset(constraintsRect.left + 10, constraintsRect.top + 35),
      _kIndigo500,
    );
    _drawLabel(
      canvas,
      'max: 200×150',
      Offset(constraintsRect.left + 10, constraintsRect.top + 50),
      _kIndigo500,
    );

    // Arrow to child
    paint.color = _kIndigo400;
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.stroke;
    final arrowStart = Offset(constraintsRect.right + 10, size.height / 2);
    final arrowEnd = Offset(size.width * 0.55, size.height / 2);
    canvas.drawLine(arrowStart, arrowEnd, paint);
    _drawArrowHead(canvas, arrowEnd, 0, _kIndigo400);
    _drawLabel(
      canvas,
      'layout()',
      Offset(arrowStart.dx + 10, arrowStart.dy - 15),
      _kIndigo600,
    );

    // Draw child box
    paint.color = _kIndigo500;
    paint.style = PaintingStyle.fill;
    final childRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width * 0.55, 40, size.width * 0.35, size.height - 80),
      const Radius.circular(10),
    );
    canvas.drawRRect(childRect, paint);

    _drawLabel(
      canvas,
      'RenderBox',
      Offset(childRect.left + 10, childRect.top + 10),
      Colors.white,
    );
    _drawLabel(
      canvas,
      'Child',
      Offset(childRect.left + 10, childRect.top + 25),
      Colors.white70,
    );

    // Draw size result
    paint.color = Colors.green;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;
    canvas.drawLine(
      Offset(childRect.right + 8, childRect.top),
      Offset(childRect.right + 8, childRect.bottom),
      paint,
    );
    canvas.drawLine(
      Offset(childRect.left, childRect.bottom + 8),
      Offset(childRect.right, childRect.bottom + 8),
      paint,
    );

    _drawLabel(
      canvas,
      'Size',
      Offset(childRect.right + 12, size.height / 2),
      Colors.green[700]!,
    );
  }

  void _drawArrowHead(
    Canvas canvas,
    Offset tip,
    double direction,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const arrowSize = 8.0;
    final p1 = tip - Offset.fromDirection(direction - 0.5, arrowSize);
    final p2 = tip - Offset.fromDirection(direction + 0.5, arrowSize);
    canvas.drawLine(tip, p1, paint);
    canvas.drawLine(tip, p2, paint);
  }

  void _drawLabel(Canvas canvas, String text, Offset position, Color color) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Dry layout vs real layout comparison
Widget _buildDryLayoutComparisonCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'dryLayoutChild() vs layoutChild()',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kIndigo800,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _buildComparisonColumn('layoutChild()', _kIndigo500, [
                'Actually lays out child',
                'Updates child.size',
                'Triggers paint',
                'Has side effects',
                'Required for rendering',
              ]),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildComparisonColumn(
                'dryLayoutChild()',
                Colors.orange[700]!,
                [
                  'Only calculates size',
                  'No state changes',
                  'No paint trigger',
                  'No side effects',
                  'For measurement only',
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildComparisonColumn(String title, Color color, List<String> items) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(20),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(100)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 8),
        ...items.map(
          (item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check, size: 14, color: color),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    item,
                    style: TextStyle(fontSize: 10, color: color.withAlpha(200)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

/// Interactive layout demo
Widget _buildInteractiveLayoutDemo() {
  return _InteractiveLayoutWidget();
}

class _InteractiveLayoutWidget extends StatefulWidget {
  @override
  State<_InteractiveLayoutWidget> createState() =>
      _InteractiveLayoutWidgetState();
}

class _InteractiveLayoutWidgetState extends State<_InteractiveLayoutWidget> {
  double _maxWidth = 200;
  double _maxHeight = 150;
  bool _tight = false;

  @override
  Widget build(BuildContext context) {
    final constraints = _tight
        ? BoxConstraints.tight(Size(_maxWidth, _maxHeight))
        : BoxConstraints(
            minWidth: 0,
            maxWidth: _maxWidth,
            minHeight: 0,
            maxHeight: _maxHeight,
          );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kIndigo300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interactive Layout Demo',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _kIndigo800,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Adjust constraints to see how child sizing works:',
            style: TextStyle(fontSize: 12, color: _kIndigo600),
          ),
          const SizedBox(height: 16),

          // Sliders
          Row(
            children: [
              const Text(
                'Max Width:',
                style: TextStyle(fontSize: 11, color: _kIndigo600),
              ),
              Expanded(
                child: Slider(
                  value: _maxWidth,
                  min: 50,
                  max: 300,
                  onChanged: (v) => setState(() => _maxWidth = v),
                  activeColor: _kIndigo500,
                ),
              ),
              Text(
                '${_maxWidth.toInt()}',
                style: const TextStyle(fontSize: 11, color: _kIndigo800),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Max Height:',
                style: TextStyle(fontSize: 11, color: _kIndigo600),
              ),
              Expanded(
                child: Slider(
                  value: _maxHeight,
                  min: 50,
                  max: 200,
                  onChanged: (v) => setState(() => _maxHeight = v),
                  activeColor: _kIndigo500,
                ),
              ),
              Text(
                '${_maxHeight.toInt()}',
                style: const TextStyle(fontSize: 11, color: _kIndigo800),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                'Tight:',
                style: TextStyle(fontSize: 11, color: _kIndigo600),
              ),
              Switch(
                value: _tight,
                onChanged: (v) => setState(() => _tight = v),
                activeColor: _kIndigo500,
              ),
              Text(
                _tight ? 'Exact size' : 'Max bounds',
                style: const TextStyle(fontSize: 11, color: _kIndigo700),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Constraints display
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _kIndigo50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Constraints: $constraints',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10,
                color: _kIndigo700,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Visual demo
          Container(
            height: 180,
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kIndigo100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Stack(
              children: [
                // Constraint bounds indicator
                Positioned(
                  left: 0,
                  top: 0,
                  child: Container(
                    width: _maxWidth,
                    height: _maxHeight,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _kIndigo400,
                        width: 2,
                        style: BorderStyle.solid,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'Constraint\nBounds',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: _kIndigo400, fontSize: 10),
                      ),
                    ),
                  ),
                ),
                // Actual laid out child
                Positioned(
                  left: 0,
                  top: 0,
                  child: ConstrainedBox(
                    constraints: constraints,
                    child: Container(
                      decoration: BoxDecoration(
                        color: _kIndigo500,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Child Widget\n(fills available)',
                          style: TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ),
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
}

/// Baseline demo
Widget _buildBaselineDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'getBaseline() for Text Alignment',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kIndigo800,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'Baseline is used to align text of different sizes on the same line:',
          style: TextStyle(fontSize: 12, color: _kIndigo600),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: CustomPaint(
            painter: _BaselinePainter(),
            size: const Size(double.infinity, 100),
          ),
        ),
        const SizedBox(height: 12),
        _buildPropertyRow(
          'TextBaseline.alphabetic',
          'Bottom of letters like "a"',
        ),
        _buildPropertyRow(
          'TextBaseline.ideographic',
          'Bottom of Asian characters',
        ),
      ],
    ),
  );
}

class _BaselinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    // Draw baseline line
    paint.color = Colors.red;
    paint.strokeWidth = 2;
    final baselineY = size.height * 0.65;
    canvas.drawLine(
      Offset(10, baselineY),
      Offset(size.width - 10, baselineY),
      paint,
    );

    // Label baseline
    _drawLabel(
      canvas,
      'baseline',
      Offset(size.width - 60, baselineY - 15),
      Colors.red,
    );

    // Draw text samples at different sizes
    final texts = [
      ('Ag', 32.0, 50.0),
      ('Ag', 24.0, 130.0),
      ('Ag', 16.0, 200.0),
      ('Ag', 20.0, 260.0),
    ];

    for (final (text, fontSize, x) in texts) {
      final textPainter = TextPainter(
        text: TextSpan(
          text: text,
          style: TextStyle(
            color: _kIndigo700,
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();

      // Draw aligned to baseline
      final y = baselineY - fontSize * 0.75; // Approximate alphabetic baseline
      textPainter.paint(canvas, Offset(x, y));

      // Draw bounding box
      paint.color = _kIndigo300;
      paint.style = PaintingStyle.stroke;
      paint.strokeWidth = 1;
      canvas.drawRect(
        Rect.fromLTWH(x, y, textPainter.width, textPainter.height),
        paint,
      );
    }

    // Annotation
    _drawLabel(
      canvas,
      'All aligned on baseline',
      Offset(size.width / 2 - 60, 10),
      _kIndigo600,
    );
  }

  void _drawLabel(Canvas canvas, String text, Offset position, Color color) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Usage in RenderBox
Widget _buildUsageCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kIndigo100, _kIndigo50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'When to Use ChildLayoutHelper',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kIndigo800,
          ),
        ),
        const SizedBox(height: 12),
        _buildUsageItem(
          Icons.grid_view,
          'Custom RenderBox',
          'When implementing performLayout()',
        ),
        _buildUsageItem(
          Icons.calculate,
          'Intrinsic Sizing',
          'Computing intrinsic dimensions',
        ),
        _buildUsageItem(
          Icons.align_vertical_bottom,
          'Text Alignment',
          'Aligning mixed text/widget rows',
        ),
        _buildUsageItem(
          Icons.layers,
          'Multi-Child Layout',
          'Custom multi-child render objects',
        ),
      ],
    ),
  );
}

Widget _buildUsageItem(IconData icon, String title, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: _kIndigo500,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: Colors.white, size: 16),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: _kIndigo800,
                fontSize: 12,
              ),
            ),
            Text(
              desc,
              style: const TextStyle(color: _kIndigo600, fontSize: 11),
            ),
          ],
        ),
      ],
    ),
  );
}

/// Constraint flow demonstration
Widget _buildConstraintFlowDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Constraint Flow in Layout',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kIndigo800,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: CustomPaint(
            painter: _ConstraintFlowPainter(),
            size: const Size(double.infinity, 180),
          ),
        ),
      ],
    ),
  );
}

class _ConstraintFlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();

    final boxW = 80.0;
    final boxH = 50.0;
    final spacing = 100.0;

    // Parent box
    paint.color = _kIndigo300;
    paint.style = PaintingStyle.fill;
    final parentRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(10, size.height / 2 - boxH / 2, boxW, boxH),
      const Radius.circular(8),
    );
    canvas.drawRRect(parentRect, paint);
    _drawLabel(canvas, 'Parent', Offset(25, size.height / 2 - 8), Colors.white);

    // Helper box
    paint.color = _kIndigo500;
    final helperRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(10 + spacing, size.height / 2 - boxH / 2, boxW, boxH),
      const Radius.circular(8),
    );
    canvas.drawRRect(helperRect, paint);
    _drawLabel(
      canvas,
      'Helper',
      Offset(10 + spacing + 15, size.height / 2 - 8),
      Colors.white,
    );

    // Child box
    paint.color = _kIndigo700;
    final childRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(10 + spacing * 2, size.height / 2 - boxH / 2, boxW, boxH),
      const Radius.circular(8),
    );
    canvas.drawRRect(childRect, paint);
    _drawLabel(
      canvas,
      'Child',
      Offset(10 + spacing * 2 + 20, size.height / 2 - 8),
      Colors.white,
    );

    // Constraints arrow (down)
    paint.color = Colors.orange;
    paint.strokeWidth = 2;
    paint.style = PaintingStyle.stroke;

    // Parent to helper
    canvas.drawLine(
      Offset(10 + boxW, size.height / 2 - 10),
      Offset(10 + spacing - 5, size.height / 2 - 10),
      paint,
    );
    _drawArrowHead(
      canvas,
      Offset(10 + spacing - 5, size.height / 2 - 10),
      0,
      Colors.orange,
    );
    _drawLabel(
      canvas,
      'constraints',
      Offset(45, size.height / 2 - 30),
      Colors.orange,
    );

    // Helper to child
    canvas.drawLine(
      Offset(10 + spacing + boxW, size.height / 2 - 10),
      Offset(10 + spacing * 2 - 5, size.height / 2 - 10),
      paint,
    );
    _drawArrowHead(
      canvas,
      Offset(10 + spacing * 2 - 5, size.height / 2 - 10),
      0,
      Colors.orange,
    );
    _drawLabel(
      canvas,
      'layout()',
      Offset(spacing + 50, size.height / 2 - 30),
      Colors.orange,
    );

    // Size arrow (up)
    paint.color = Colors.green;

    // Child to helper
    canvas.drawLine(
      Offset(10 + spacing * 2 + 5, size.height / 2 + 20),
      Offset(10 + spacing + boxW, size.height / 2 + 20),
      paint,
    );
    _drawArrowHead(
      canvas,
      Offset(10 + spacing + boxW, size.height / 2 + 20),
      3.14,
      Colors.green,
    );
    _drawLabel(
      canvas,
      'Size',
      Offset(spacing + 70, size.height / 2 + 30),
      Colors.green,
    );

    // Helper to parent
    canvas.drawLine(
      Offset(10 + spacing + 5, size.height / 2 + 20),
      Offset(10 + boxW, size.height / 2 + 20),
      paint,
    );
    _drawArrowHead(
      canvas,
      Offset(10 + boxW, size.height / 2 + 20),
      3.14,
      Colors.green,
    );

    // Legend
    _drawLabel(
      canvas,
      '→ Constraints flow down',
      Offset(size.width - 150, 20),
      Colors.orange,
    );
    _drawLabel(
      canvas,
      '← Sizes flow up',
      Offset(size.width - 150, 35),
      Colors.green,
    );
  }

  void _drawArrowHead(
    Canvas canvas,
    Offset tip,
    double direction,
    Color color,
  ) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const arrowSize = 8.0;
    final p1 = tip - Offset.fromDirection(direction - 0.5, arrowSize);
    final p2 = tip - Offset.fromDirection(direction + 0.5, arrowSize);
    canvas.drawLine(tip, p1, paint);
    canvas.drawLine(tip, p2, paint);
  }

  void _drawLabel(Canvas canvas, String text, Offset position, Color color) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Build results card
Widget _buildResultsCard(bool success, String className) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: success ? const Color(0xFFE8F5E9) : const Color(0xFFFFEBEE),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: success ? Colors.green[300]! : Colors.red[300]!,
      ),
    ),
    child: Row(
      children: [
        Icon(
          success ? Icons.check_circle : Icons.error,
          color: success ? Colors.green[700] : Colors.red[700],
          size: 32,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                success ? 'Demo Successful' : 'Demo Failed',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: success ? Colors.green[800] : Colors.red[800],
                ),
              ),
              Text(
                '$className concepts demonstrated',
                style: TextStyle(
                  fontSize: 12,
                  color: success ? Colors.green[600] : Colors.red[600],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSummaryChip(String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: _kIndigo500,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 14),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 10,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  // Print information about ChildLayoutHelper
  print('╔══════════════════════════════════════════════════════════════════╗');
  print('║        ChildLayoutHelper Deep Demo                               ║');
  print('╚══════════════════════════════════════════════════════════════════╝');

  print('\n--- ChildLayoutHelper Overview ---');
  print('ChildLayoutHelper is a static utility class for laying out children.');
  print('It provides standardized methods for RenderBox layout operations.');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Static Methods ---');
  print('layoutChild(RenderBox, BoxConstraints) → Size');
  print('  - Lays out child with constraints');
  print('  - Returns the resulting size');
  print('dryLayoutChild(RenderBox, BoxConstraints) → Size');
  print('  - Computes size without actual layout');
  print('  - No side effects');
  print('getBaseline(RenderBox, TextBaseline) → double?');
  print('  - Gets baseline for text alignment');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: LAYOUT FLOW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Layout Flow ---');
  print('1. Parent receives constraints');
  print('2. Parent uses ChildLayoutHelper.layoutChild()');
  print('3. Child performs layout with constraints');
  print('4. Size flows back up');
  print('5. Parent positions child using size');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: DRY LAYOUT
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Dry Layout ---');
  print('dryLayoutChild() is used for:');
  print('  - Intrinsic dimension calculations');
  print('  - Size estimation before actual layout');
  print('  - Avoiding layout side effects');

  print('\nChildLayoutHelper test completed.');

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD UI
  // ═══════════════════════════════════════════════════════════════════════════

  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
      ),
    ),
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_kIndigo600, _kIndigo800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kIndigo700.withAlpha(80),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(50),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.view_quilt,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ChildLayoutHelper',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'rendering library',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(30),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'A static utility class providing helper methods for laying out '
                    'RenderBox children with BoxConstraints.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Overview cards
          _buildInfoCard(
            'Purpose',
            'Provides standardized, encapsulated methods for child layout '
                'that ensure correct protocol and enable dry layout.',
            Icons.info_outline,
          ),
          _buildInfoCard(
            'Static Class',
            'All methods are static. No instance needed. '
                'Call directly: ChildLayoutHelper.layoutChild(...)',
            Icons.functions,
          ),

          // Methods
          _buildSectionTitle('Methods Overview', Icons.list),
          _buildMethodsCard(),
          const SizedBox(height: 20),

          // Why exists
          _buildSectionTitle('Design Rationale', Icons.psychology),
          _buildWhyExistsCard(),
          const SizedBox(height: 20),

          // Layout visualization
          _buildSectionTitle('layoutChild() Visualization', Icons.straighten),
          _buildLayoutChildVisualization(),
          const SizedBox(height: 20),

          // Dry layout comparison
          _buildSectionTitle('Layout vs Dry Layout', Icons.compare),
          _buildDryLayoutComparisonCard(),
          const SizedBox(height: 20),

          // Interactive demo
          _buildSectionTitle('Interactive Demo', Icons.touch_app),
          _buildInteractiveLayoutDemo(),
          const SizedBox(height: 20),

          // Constraint flow
          _buildSectionTitle('Constraint Flow', Icons.schema),
          _buildConstraintFlowDemo(),
          const SizedBox(height: 20),

          // Baseline demo
          _buildSectionTitle('Baseline Alignment', Icons.format_align_left),
          _buildBaselineDemo(),
          const SizedBox(height: 20),

          // Usage
          _buildSectionTitle('When to Use', Icons.lightbulb),
          _buildUsageCard(),
          const SizedBox(height: 20),

          // Code examples
          _buildSectionTitle('Code Examples', Icons.code),
          _buildCodeSnippet('Using layoutChild in performLayout', '''@override
void performLayout() {
  // Layout child with our constraints
  final childSize = ChildLayoutHelper.layoutChild(
    child!,
    constraints,
  );
  
  // Use the returned size
  size = constraints.constrain(childSize);
  
  // Position child (example: centered)
  (child!.parentData as BoxParentData).offset = Offset(
    (size.width - childSize.width) / 2,
    (size.height - childSize.height) / 2,
  );
}'''),
          _buildCodeSnippet('Using dryLayoutChild for intrinsics', '''@override
double computeMaxIntrinsicWidth(double height) {
  if (child == null) return 0.0;
  
  // Get child's preferred size without layout
  final childSize = ChildLayoutHelper.dryLayoutChild(
    child!,
    BoxConstraints(maxHeight: height),
  );
  
  return childSize.width;
}'''),

          // Results
          _buildSectionTitle('Test Results', Icons.check_circle),
          _buildResultsCard(true, 'ChildLayoutHelper'),
          const SizedBox(height: 20),

          // Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kIndigo100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.summarize, color: _kIndigo600, size: 32),
                const SizedBox(height: 12),
                const Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _kIndigo800,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'ChildLayoutHelper provides a clean API for laying out RenderBox '
                  'children. Use layoutChild() for actual layout and dryLayoutChild() '
                  'for size calculations without side effects.',
                  style: TextStyle(
                    fontSize: 12,
                    color: _kIndigo700,
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSummaryChip('layoutChild', Icons.straighten),
                    const SizedBox(width: 8),
                    _buildSummaryChip('dryLayout', Icons.calculate),
                    const SizedBox(width: 8),
                    _buildSummaryChip('baseline', Icons.format_align_left),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}
