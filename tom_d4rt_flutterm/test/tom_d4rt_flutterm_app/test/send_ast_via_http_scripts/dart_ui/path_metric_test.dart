// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for PathMetric from dart:ui
//
// PathMetric provides metrics about a single contour of a Path.
// Access via path.computeMetrics() which returns an Iterable<PathMetric>.
//
// Key features:
//   - length: Total length of the contour
//   - isClosed: Whether the contour forms a closed shape
//   - contourIndex: Index of this contour in the path
//   - getTangentForOffset(distance): Get position and direction at distance
//   - extractPath(start, end): Extract a sub-path for a distance range
//
// This demo visually demonstrates PathMetric usage for animation and effects.

import 'dart:math' as math;
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [const Color(0xFFE65100), const Color(0xFFFF9800)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFE65100).withAlpha(100),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.timeline, size: 48, color: Colors.white),
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
            color: const Color(0xFFFF9800).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFFFF9800), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFE65100),
          ),
        ),
      ],
    ),
  );
}

Widget _buildRectPathDemo(double rectLength, bool rectClosed, int rectIndex) {
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
            Icon(Icons.crop_square, color: const Color(0xFFFF9800)),
            const SizedBox(width: 8),
            const Text(
              'Rectangle Path Metrics',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            // Visual rectangle
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 100,
                child: CustomPaint(painter: _RectPathPainter()),
              ),
            ),
            const SizedBox(width: 16),
            // Metrics info
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMetricRow('Path', 'Rect(0, 0, 100, 50)'),
                  _buildMetricRow('Length', '${rectLength.toStringAsFixed(1)}'),
                  _buildMetricRow('Formula', '2×(100+50) = 300'),
                  _buildMetricRow('isClosed', '$rectClosed'),
                  _buildMetricRow('contourIndex', '$rectIndex'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _RectPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFF9800)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(10, 10, 80, 40);
    canvas.drawRect(rect, paint);

    // Draw direction arrows
    _drawArrow(canvas, const Offset(50, 10), 0); // top
    _drawArrow(canvas, const Offset(90, 30), math.pi / 2); // right
    _drawArrow(canvas, const Offset(50, 50), math.pi); // bottom
    _drawArrow(canvas, const Offset(10, 30), -math.pi / 2); // left

    // Start point
    final startPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(10, 10), 5, startPaint);

    // Length labels
    _drawLabel(canvas, '100', const Offset(50, 5), const Color(0xFFE65100));
    _drawLabel(canvas, '50', const Offset(95, 30), const Color(0xFFE65100));
  }

  void _drawArrow(Canvas canvas, Offset position, double angle) {
    final paint = Paint()
      ..color = const Color(0xFFE65100)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.save();
    canvas.translate(position.dx, position.dy);
    canvas.rotate(angle);
    final path = Path()
      ..moveTo(-5, -3)
      ..lineTo(0, 0)
      ..lineTo(-5, 3);
    canvas.drawPath(path, paint);
    canvas.restore();
  }

  void _drawLabel(Canvas canvas, String text, Offset position, Color color) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(position.dx - textPainter.width / 2, position.dy),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildMetricRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCirclePathDemo(double circleLen, bool circleClosed) {
  final expectedCircle = 2 * math.pi * 25; // 2πr where r=25

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
            Icon(Icons.circle, color: const Color(0xFFFF9800)),
            const SizedBox(width: 8),
            const Text(
              'Circle Path Metrics',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            // Visual circle
            Expanded(
              flex: 2,
              child: SizedBox(
                height: 100,
                child: CustomPaint(painter: _CirclePathPainter()),
              ),
            ),
            const SizedBox(width: 16),
            // Metrics info
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMetricRow('Path', 'Circle radius=25'),
                  _buildMetricRow('Length', '${circleLen.toStringAsFixed(1)}'),
                  _buildMetricRow(
                    'Formula',
                    '2πr = ${expectedCircle.toStringAsFixed(1)}',
                  ),
                  _buildMetricRow('isClosed', '$circleClosed'),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _CirclePathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    const radius = 35.0;

    // Circle path
    final paint = Paint()
      ..color = const Color(0xFFFF9800)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius, paint);

    // Radius line
    final radiusPaint = Paint()
      ..color = const Color(0xFFE65100)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    canvas.drawLine(center, Offset(center.dx + radius, center.dy), radiusPaint);

    // Center dot
    final centerPaint = Paint()
      ..color = const Color(0xFFE65100)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 3, centerPaint);

    // Radius label
    _drawLabel(canvas, 'r=25', Offset(center.dx + 10, center.dy + 5));
  }

  void _drawLabel(Canvas canvas, String text, Offset position) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Color(0xFFE65100),
          fontSize: 10,
          fontWeight: FontWeight.bold,
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

Widget _buildTangentDemo(Map<String, dynamic> tangentData) {
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
            Icon(Icons.trending_flat, color: const Color(0xFFFF9800)),
            const SizedBox(width: 8),
            const Text(
              'getTangentForOffset()',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Visual
        SizedBox(
          height: 120,
          child: CustomPaint(
            size: const Size(double.infinity, 120),
            painter: _TangentDemoPainter(),
          ),
        ),
        const SizedBox(height: 16),
        // Tangent info cards
        Row(
          children: [
            Expanded(
              child: _buildTangentInfoCard(
                'Start (0)',
                tangentData['start'] as Map<String, dynamic>,
                Colors.green,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildTangentInfoCard(
                'Mid (len/2)',
                tangentData['mid'] as Map<String, dynamic>,
                Colors.blue,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: _buildTangentInfoCard(
                'End (len)',
                tangentData['end'] as Map<String, dynamic>,
                Colors.red,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

class _TangentDemoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(20, 60)
      ..quadraticBezierTo(size.width / 2, 10, size.width - 20, 100);

    // Draw path
    final pathPaint = Paint()
      ..color = const Color(0xFFFF9800)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, pathPaint);

    // Tangent at start
    _drawTangentPoint(canvas, const Offset(20, 60), 0.7, Colors.green);

    // Tangent at mid (approximate)
    _drawTangentPoint(canvas, Offset(size.width / 2, 35), 0.3, Colors.blue);

    // Tangent at end
    _drawTangentPoint(canvas, Offset(size.width - 20, 100), 0.4, Colors.red);
  }

  void _drawTangentPoint(Canvas canvas, Offset pos, double angle, Color color) {
    // Point
    final pointPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawCircle(pos, 6, pointPaint);

    // Arrow
    canvas.save();
    canvas.translate(pos.dx, pos.dy);
    canvas.rotate(angle);
    final arrowPaint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(const Offset(0, 0), const Offset(25, 0), arrowPaint);
    final arrowHead = Path()
      ..moveTo(20, -5)
      ..lineTo(25, 0)
      ..lineTo(20, 5);
    canvas.drawPath(arrowHead, arrowPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildTangentInfoCard(
  String title,
  Map<String, dynamic> data,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withAlpha(50)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
            const SizedBox(width: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'pos: ${data['pos']}',
          style: const TextStyle(fontSize: 9, fontFamily: 'monospace'),
        ),
        Text(
          'vec: ${data['vec']}',
          style: const TextStyle(fontSize: 9, fontFamily: 'monospace'),
        ),
      ],
    ),
  );
}

Widget _buildExtractPathDemo() {
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
            Icon(Icons.content_cut, color: const Color(0xFFFF9800)),
            const SizedBox(width: 8),
            const Text(
              'extractPath(start, end)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Visual
        SizedBox(
          height: 100,
          child: CustomPaint(
            size: const Size(double.infinity, 100),
            painter: _ExtractPathPainter(),
          ),
        ),
        const SizedBox(height: 12),
        // Explanation
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Extract portions of a path by distance:',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                '• extractPath(0, len/4) → First quarter\n'
                '• extractPath(len/4, len/2) → Second quarter\n'
                '• Useful for animation progress effects',
                style: TextStyle(fontSize: 10, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class _ExtractPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2;

    // Full path (light)
    final fullPaint = Paint()
      ..color = const Color(0xFFFF9800).withAlpha(80)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(20, centerY),
      Offset(size.width - 20, centerY),
      fullPaint,
    );

    // Extracted segment (0 to len/4)
    final seg1Paint = Paint()
      ..color = const Color(0xFF4CAF50)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final segWidth = (size.width - 40) / 4;
    canvas.drawLine(
      Offset(20, centerY),
      Offset(20 + segWidth, centerY),
      seg1Paint,
    );

    // Extracted segment (len/4 to len/2)
    final seg2Paint = Paint()
      ..color = const Color(0xFF2196F3)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(
      Offset(20 + segWidth, centerY),
      Offset(20 + segWidth * 2, centerY),
      seg2Paint,
    );

    // Labels
    _drawLabel(canvas, '0', Offset(20, centerY + 20));
    _drawLabel(canvas, 'len/4', Offset(20 + segWidth, centerY + 20));
    _drawLabel(canvas, 'len/2', Offset(20 + segWidth * 2, centerY + 20));
    _drawLabel(canvas, 'len', Offset(size.width - 20, centerY + 20));
  }

  void _drawLabel(Canvas canvas, String text, Offset position) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: Colors.grey[600], fontSize: 10),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(position.dx - textPainter.width / 2, position.dy),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildAnimationUseCase() {
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
            Icon(Icons.animation, color: const Color(0xFFFF9800)),
            const SizedBox(width: 8),
            const Text(
              'Animation Use Case',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Visual showing animated dot on path
        SizedBox(
          height: 100,
          child: CustomPaint(
            size: const Size(double.infinity, 100),
            painter: _AnimationUseCasePainter(),
          ),
        ),
        const SizedBox(height: 12),
        _buildCodeBlock('''// Animate object along path
final metric = path.computeMetrics().first;
final distance = animation.value * metric.length;
final tangent = metric.getTangentForOffset(distance);
if (tangent != null) {
  // Position at tangent.position
  // Direction from tangent.vector
}'''),
      ],
    ),
  );
}

class _AnimationUseCasePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Curved path
    final path = Path()
      ..moveTo(20, 70)
      ..cubicTo(
        size.width * 0.3,
        10,
        size.width * 0.7,
        90,
        size.width - 20,
        30,
      );

    // Draw path
    final pathPaint = Paint()
      ..color = const Color(0xFFFF9800).withAlpha(150)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, pathPaint);

    // Draw multiple positions along path
    final positions = [0.0, 0.25, 0.5, 0.75, 1.0];
    final colors = [
      Colors.green.withAlpha(150),
      Colors.green.withAlpha(200),
      Colors.blue,
      Colors.purple.withAlpha(200),
      Colors.red.withAlpha(150),
    ];

    for (var i = 0; i < positions.length; i++) {
      final progress = positions[i];
      // Approximate positions for demo
      final x = 20 + progress * (size.width - 40);
      final y =
          70 -
          math.sin(progress * math.pi) * 40 +
          progress * 20 * math.sin(progress * 3);
      final pos = Offset(x, y.clamp(10.0, 90.0));

      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;
      canvas.drawCircle(pos, i == 2 ? 8 : 6, paint);

      if (i == 2) {
        // Draw direction arrow for mid position
        _drawArrow(canvas, pos, 0.3);
      }
    }
  }

  void _drawArrow(Canvas canvas, Offset pos, double angle) {
    canvas.save();
    canvas.translate(pos.dx, pos.dy);
    canvas.rotate(angle);
    final arrowPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(const Offset(8, 0), const Offset(20, 0), arrowPaint);
    final arrowHead = Path()
      ..moveTo(16, -4)
      ..lineTo(20, 0)
      ..lineTo(16, 4);
    canvas.drawPath(arrowHead, arrowPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8),
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

Widget _buildMultiContourDemo() {
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
            Icon(Icons.view_stream, color: const Color(0xFFFF9800)),
            const SizedBox(width: 8),
            const Text(
              'Multiple Contours',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Visual
        SizedBox(
          height: 80,
          child: CustomPaint(
            size: const Size(double.infinity, 80),
            painter: _MultiContourPainter(),
          ),
        ),
        const SizedBox(height: 12),
        // Info
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'A path can have multiple contours. Each moveTo() starts a new contour. '
            'Use computeMetrics() to iterate over all contours, each with its own '
            'contourIndex, length, and isClosed property.',
            style: TextStyle(fontSize: 11, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

class _MultiContourPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    // Contour 0 - rectangle
    paint.color = const Color(0xFF4CAF50);
    canvas.drawRect(const Rect.fromLTWH(20, 10, 60, 30), paint);

    // Contour 1 - circle
    paint.color = const Color(0xFF2196F3);
    canvas.drawCircle(Offset(size.width / 2, 25), 20, paint);

    // Contour 2 - triangle
    paint.color = const Color(0xFFFF9800);
    final triangle = Path()
      ..moveTo(size.width - 60, 45)
      ..lineTo(size.width - 20, 45)
      ..lineTo(size.width - 40, 10)
      ..close();
    canvas.drawPath(triangle, paint);

    // Labels
    _drawLabel(canvas, 'idx=0', const Offset(50, 52), const Color(0xFF4CAF50));
    _drawLabel(
      canvas,
      'idx=1',
      Offset(size.width / 2, 52),
      const Color(0xFF2196F3),
    );
    _drawLabel(
      canvas,
      'idx=2',
      Offset(size.width - 40, 52),
      const Color(0xFFFF9800),
    );
  }

  void _drawLabel(Canvas canvas, String text, Offset pos, Color color) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(pos.dx - textPainter.width / 2, pos.dy));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildApiSummaryCard() {
  final methods = [
    {'name': 'length', 'desc': 'Total path length in pixels'},
    {'name': 'isClosed', 'desc': 'True if path forms closed shape'},
    {'name': 'contourIndex', 'desc': 'Index of this contour (0-based)'},
    {'name': 'getTangentForOffset(d)', 'desc': 'Get Tangent at distance d'},
    {'name': 'extractPath(s, e)', 'desc': 'Extract sub-path from s to e'},
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
            Icon(Icons.code, color: const Color(0xFFFF9800)),
            const SizedBox(width: 8),
            const Text(
              'API Summary',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...methods.map((m) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    m['name'] as String,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    m['desc'] as String,
                    style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== PathMetric Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: RECTANGLE PATH METRIC
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Rectangle Path Metric ---');

  final path = Path()..addRect(const Rect.fromLTWH(0, 0, 100, 50));

  var rectLength = 0.0;
  var rectClosed = false;
  var rectIndex = 0;
  Map<String, dynamic> tangentData = {
    'start': {'pos': 'N/A', 'vec': 'N/A'},
    'mid': {'pos': 'N/A', 'vec': 'N/A'},
    'end': {'pos': 'N/A', 'vec': 'N/A'},
  };

  for (final metric in path.computeMetrics()) {
    rectLength = metric.length;
    rectClosed = metric.isClosed;
    rectIndex = metric.contourIndex;

    print('PathMetric type: ${metric.runtimeType}');
    print('length: ${metric.length}');
    print('isClosed: ${metric.isClosed}');
    print('contourIndex: ${metric.contourIndex}');

    // getTangentForOffset
    final tangent0 = metric.getTangentForOffset(0.0);
    if (tangent0 != null) {
      print('Tangent at 0: pos=${tangent0.position}, vec=${tangent0.vector}');
      tangentData['start'] = {
        'pos':
            '(${tangent0.position.dx.toInt()}, ${tangent0.position.dy.toInt()})',
        'vec':
            '(${tangent0.vector.dx.toStringAsFixed(1)}, ${tangent0.vector.dy.toStringAsFixed(1)})',
      };
    }

    final tangentMid = metric.getTangentForOffset(metric.length / 2.0);
    if (tangentMid != null) {
      print('Tangent at mid: pos=${tangentMid.position}');
      tangentData['mid'] = {
        'pos':
            '(${tangentMid.position.dx.toInt()}, ${tangentMid.position.dy.toInt()})',
        'vec':
            '(${tangentMid.vector.dx.toStringAsFixed(1)}, ${tangentMid.vector.dy.toStringAsFixed(1)})',
      };
    }

    final tangentEnd = metric.getTangentForOffset(metric.length);
    if (tangentEnd != null) {
      print('Tangent at end: pos=${tangentEnd.position}');
      tangentData['end'] = {
        'pos':
            '(${tangentEnd.position.dx.toInt()}, ${tangentEnd.position.dy.toInt()})',
        'vec':
            '(${tangentEnd.vector.dx.toStringAsFixed(1)}, ${tangentEnd.vector.dy.toStringAsFixed(1)})',
      };
    }

    // extractPath
    final subPath = metric.extractPath(0.0, metric.length / 4.0);
    print('extractPath(0, len/4): ${subPath.runtimeType}');
    final subBounds = subPath.getBounds();
    print('subPath bounds: $subBounds');

    final subPath2 = metric.extractPath(
      metric.length / 4.0,
      metric.length / 2.0,
    );
    print('extractPath(len/4, len/2) bounds: ${subPath2.getBounds()}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: CIRCLE PATH METRIC
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Circle Path Metric ---');

  final circlePath = Path()
    ..addOval(Rect.fromCircle(center: const Offset(50, 50), radius: 25));

  var circleLen = 0.0;
  var circleClosed = false;
  for (final circleMetric in circlePath.computeMetrics()) {
    circleLen = circleMetric.length;
    circleClosed = circleMetric.isClosed;
    print('Circle length: ${circleMetric.length.toStringAsFixed(1)}');
    print('Circle isClosed: ${circleMetric.isClosed}');
    print('Expected: 2πr = ${(2 * math.pi * 25).toStringAsFixed(1)}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: MULTIPLE CONTOURS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Multiple Contours ---');

  final multiPath = Path()
    ..addRect(const Rect.fromLTWH(0, 0, 40, 20)) // contour 0
    ..addOval(const Rect.fromLTWH(50, 0, 30, 30)); // contour 1

  var contourCount = 0;
  for (final m in multiPath.computeMetrics()) {
    print(
      'Contour ${m.contourIndex}: length=${m.length.toStringAsFixed(1)}, closed=${m.isClosed}',
    );
    contourCount++;
  }
  print('Total contours: $contourCount');

  print('\n=== PathMetric Deep Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL UI
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader('PathMetric', 'Measure & Navigate Paths'),
        const SizedBox(height: 20),

        // Rectangle path
        _buildSectionTitle('Rectangle Path', Icons.crop_square),
        _buildRectPathDemo(rectLength, rectClosed, rectIndex),
        const SizedBox(height: 20),

        // Circle path
        _buildSectionTitle('Circle Path', Icons.circle),
        _buildCirclePathDemo(circleLen, circleClosed),
        const SizedBox(height: 20),

        // Tangent
        _buildSectionTitle('Tangent Data', Icons.trending_flat),
        _buildTangentDemo(tangentData),
        const SizedBox(height: 20),

        // Extract path
        _buildSectionTitle('Extract Sub-Path', Icons.content_cut),
        _buildExtractPathDemo(),
        const SizedBox(height: 20),

        // Multiple contours
        _buildSectionTitle('Multiple Contours', Icons.view_stream),
        _buildMultiContourDemo(),
        const SizedBox(height: 20),

        // Animation use case
        _buildSectionTitle('Animation Use Case', Icons.animation),
        _buildAnimationUseCase(),
        const SizedBox(height: 20),

        // API summary
        _buildSectionTitle('API Reference', Icons.code),
        _buildApiSummaryCard(),
        const SizedBox(height: 20),

        // Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
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
                  color: Color(0xFFE65100),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• PathMetric measures individual path contours\n'
                '• Access via path.computeMetrics() iterable\n'
                '• length: total distance around contour\n'
                '• getTangentForOffset(): position + direction at distance\n'
                '• extractPath(): create sub-path for distance range\n'
                '• Essential for path animations and effects',
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
