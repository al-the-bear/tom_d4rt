// D4rt test script: Comprehensive demo for ClipRSuperellipseLayer from rendering
//
// ClipRSuperellipseLayer clips content to a rounded superellipse shape.
// A superellipse (also called squircle) provides smoother corner curves
// than standard rounded rectangles:
//   - Standard RRect: corners are circular arcs
//   - RSuperellipse: corners follow superellipse formula
//   - iOS-style app icons use superellipse shapes
//
// This demo shows:
//   1. What a superellipse/squircle looks like
//   2. Comparison with standard rounded rectangle
//   3. How ClipRSuperellipseLayer works
//   4. Visual examples of clipped content
//
// ═══════════════════════════════════════════════════════════════════════════
import 'dart:math' as math;

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS
// ═══════════════════════════════════════════════════════════════════════════

const _kPink50 = Color(0xFFFCE4EC);
const _kPink100 = Color(0xFFF8BBD0);
const _kPink200 = Color(0xFFF48FB1);
const _kPink300 = Color(0xFFF06292);
const _kPink400 = Color(0xFFEC407A);
const _kPink500 = Color(0xFFE91E63);
const _kPink600 = Color(0xFFD81B60);
const _kPink700 = Color(0xFFC2185B);
const _kPink800 = Color(0xFFAD1457);
const _kPink900 = Color(0xFF880E4F);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Builds a styled section title
Widget _buildSectionTitle(String title, IconData icon) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        Icon(icon, color: _kPink600, size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: _kPink800,
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
      color: _kPink50,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kPink200),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _kPink100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _kPink600, size: 24),
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
                  color: _kPink800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(fontSize: 12, color: _kPink600),
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
      color: _kPink900,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: _kPink800,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              const Icon(Icons.code, color: _kPink200, size: 16),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kPink200,
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
              color: Color(0xFFFFCCDD),
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Superellipse shape comparison demo
Widget _buildShapeComparisonDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kPink300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Shape Comparison: RRect vs Superellipse',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kPink800,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildShapeCard(
              'Standard RRect',
              _buildRRectShape(),
              'Circular arc corners',
            ),
            _buildShapeCard(
              'Superellipse',
              _buildSuperellipseShape(),
              'Continuous curvature',
            ),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kPink50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Notice how the superellipse has smoother transitions '
            'from straight edges to curved corners.',
            style: TextStyle(fontSize: 11, color: _kPink700),
          ),
        ),
      ],
    ),
  );
}

Widget _buildShapeCard(String title, Widget shape, String desc) {
  return Column(
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: _kPink700,
        ),
      ),
      const SizedBox(height: 8),
      shape,
      const SizedBox(height: 8),
      Text(desc, style: const TextStyle(fontSize: 10, color: _kPink500)),
    ],
  );
}

Widget _buildRRectShape() {
  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      color: _kPink300,
      borderRadius: BorderRadius.circular(25),
    ),
    child: const Center(
      child: Icon(Icons.rounded_corner, color: Colors.white, size: 32),
    ),
  );
}

Widget _buildSuperellipseShape() {
  return CustomPaint(
    painter: _SuperellipsePainter(),
    size: const Size(100, 100),
  );
}

class _SuperellipsePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = _kPink500
      ..style = PaintingStyle.fill;

    // Draw superellipse approximation
    final path = _createSuperellipsePath(
      Rect.fromLTWH(0, 0, size.width, size.height),
      25,
    );
    canvas.drawPath(path, paint);

    // Draw icon
    final iconPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Simple curve icon
    final iconPath = Path()
      ..moveTo(size.width / 2 - 15, size.height / 2 - 10)
      ..quadraticBezierTo(
        size.width / 2,
        size.height / 2 - 20,
        size.width / 2 + 15,
        size.height / 2 - 10,
      );
    canvas.drawPath(iconPath, iconPaint);
  }

  Path _createSuperellipsePath(Rect rect, double cornerRadius) {
    // Superellipse n=4 approximation using cubic bezier
    final path = Path();

    final w = rect.width;
    final h = rect.height;
    final r = cornerRadius;
    final x = rect.left;
    final y = rect.top;

    // More curved superellipse factor
    final sf = 0.65; // Superellipse smoothness factor

    path.moveTo(x + r, y);
    // Top edge
    path.lineTo(x + w - r, y);
    // Top-right corner (superellipse)
    path.cubicTo(
      x + w - r * (1 - sf),
      y,
      x + w,
      y + r * (1 - sf),
      x + w,
      y + r,
    );
    // Right edge
    path.lineTo(x + w, y + h - r);
    // Bottom-right corner
    path.cubicTo(
      x + w,
      y + h - r * (1 - sf),
      x + w - r * (1 - sf),
      y + h,
      x + w - r,
      y + h,
    );
    // Bottom edge
    path.lineTo(x + r, y + h);
    // Bottom-left corner
    path.cubicTo(
      x + r * (1 - sf),
      y + h,
      x,
      y + h - r * (1 - sf),
      x,
      y + h - r,
    );
    // Left edge
    path.lineTo(x, y + r);
    // Top-left corner
    path.cubicTo(x, y + r * (1 - sf), x + r * (1 - sf), y, x + r, y);

    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Interactive corner comparison
Widget _buildCornerComparisonDemo() {
  return _CornerComparisonWidget();
}

class _CornerComparisonWidget extends StatefulWidget {
  @override
  State<_CornerComparisonWidget> createState() =>
      _CornerComparisonWidgetState();
}

class _CornerComparisonWidgetState extends State<_CornerComparisonWidget> {
  double _cornerRadius = 30;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kPink300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Interactive Corner Comparison',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _kPink800,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'Corner Radius:',
                style: TextStyle(fontSize: 11, color: _kPink600),
              ),
              Expanded(
                child: Slider(
                  value: _cornerRadius,
                  min: 0,
                  max: 50,
                  onChanged: (v) => setState(() => _cornerRadius = v),
                  activeColor: _kPink500,
                ),
              ),
              Text(
                '${_cornerRadius.toInt()}',
                style: const TextStyle(fontSize: 11, color: _kPink800),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: CustomPaint(
              painter: _CornerComparisonPainter(_cornerRadius),
              size: const Size(double.infinity, 180),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(_kPink300, 'RRect (circular)'),
              const SizedBox(width: 16),
              _buildLegendItem(_kPink700, 'Superellipse'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 10, color: _kPink700)),
      ],
    );
  }
}

class _CornerComparisonPainter extends CustomPainter {
  final double cornerRadius;

  _CornerComparisonPainter(this.cornerRadius);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final centerX = size.width / 2;
    final rect = Rect.fromLTWH(centerX - 60, 20, 120, 120);

    // Draw RRect
    paint.color = _kPink300;
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.circular(cornerRadius)),
      paint,
    );

    // Draw superellipse
    paint.color = _kPink700;
    final path = _createSuperellipsePath(rect, cornerRadius);
    canvas.drawPath(path, paint);

    // Draw corner detail box
    final detailRect = Rect.fromLTWH(rect.right + 20, rect.top, 80, 80);
    paint.color = _kPink200;
    paint.style = PaintingStyle.fill;
    canvas.drawRect(detailRect, paint);

    // Draw zoomed corner
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 2;

    // RRect corner
    paint.color = _kPink300;
    final rrectCorner = Path()
      ..moveTo(detailRect.left + 5, detailRect.center.dy)
      ..arcToPoint(
        Offset(detailRect.center.dx, detailRect.top + 5),
        radius: Radius.circular(cornerRadius),
      );
    canvas.drawPath(rrectCorner, paint);

    // Superellipse corner
    paint.color = _kPink700;
    final sf = 0.65;
    final r = cornerRadius;
    final superCorner = Path()
      ..moveTo(detailRect.left + 5, detailRect.center.dy)
      ..cubicTo(
        detailRect.left + 5,
        detailRect.center.dy - r * sf,
        detailRect.center.dx - r * sf,
        detailRect.top + 5,
        detailRect.center.dx,
        detailRect.top + 5,
      );
    canvas.drawPath(superCorner, paint);

    // Label
    _drawLabel(
      canvas,
      'Corner Detail',
      Offset(detailRect.left, detailRect.bottom + 10),
      _kPink600,
    );
  }

  Path _createSuperellipsePath(Rect rect, double cornerRadius) {
    final path = Path();
    final sf = 0.65;
    final w = rect.width;
    final h = rect.height;
    final r = cornerRadius.clamp(0.0, math.min(w, h) / 2);
    final x = rect.left;
    final y = rect.top;

    path.moveTo(x + r, y);
    path.lineTo(x + w - r, y);
    path.cubicTo(
      x + w - r * (1 - sf),
      y,
      x + w,
      y + r * (1 - sf),
      x + w,
      y + r,
    );
    path.lineTo(x + w, y + h - r);
    path.cubicTo(
      x + w,
      y + h - r * (1 - sf),
      x + w - r * (1 - sf),
      y + h,
      x + w - r,
      y + h,
    );
    path.lineTo(x + r, y + h);
    path.cubicTo(
      x + r * (1 - sf),
      y + h,
      x,
      y + h - r * (1 - sf),
      x,
      y + h - r,
    );
    path.lineTo(x, y + r);
    path.cubicTo(x, y + r * (1 - sf), x + r * (1 - sf), y, x + r, y);
    path.close();
    return path;
  }

  void _drawLabel(Canvas canvas, String text, Offset position, Color color) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  @override
  bool shouldRepaint(covariant _CornerComparisonPainter oldDelegate) {
    return oldDelegate.cornerRadius != cornerRadius;
  }
}

/// Layer hierarchy visualization
Widget _buildLayerHierarchyCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kPink200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Clip Layer Hierarchy',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kPink800,
          ),
        ),
        const SizedBox(height: 16),
        _buildHierarchyNode('ContainerLayer', 'Base container', 0, false),
        _buildHierarchyNode('├── ClipRectLayer', 'Rectangle clip', 1, false),
        _buildHierarchyNode(
          '├── ClipRRectLayer',
          'Rounded rect clip',
          1,
          false,
        ),
        _buildHierarchyNode(
          '├── ClipRSuperellipseLayer',
          'Superellipse clip',
          1,
          true,
        ),
        _buildHierarchyNode(
          '└── ClipPathLayer',
          'Arbitrary path clip',
          1,
          false,
        ),
      ],
    ),
  );
}

Widget _buildHierarchyNode(
  String text,
  String desc,
  int indent,
  bool highlight,
) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 20.0, top: 4, bottom: 4),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: highlight ? _kPink500 : _kPink100,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: highlight ? Colors.white : _kPink700,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            desc,
            style: const TextStyle(fontSize: 10, color: _kPink500),
          ),
        ),
      ],
    ),
  );
}

/// iOS app icon style demo
Widget _buildAppIconStyleDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kPink300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'iOS-Style App Icons',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kPink800,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'iOS app icons use superellipse (squircle) shape for that distinctive look:',
          style: TextStyle(fontSize: 12, color: _kPink600),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAppIcon(_kPink400, Icons.photo),
            _buildAppIcon(_kPink500, Icons.music_note),
            _buildAppIcon(_kPink600, Icons.settings),
            _buildAppIcon(_kPink700, Icons.message),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kPink50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(Icons.apple, color: _kPink600, size: 24),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Apple uses superellipse with specific corner radius ratio for all app icons.',
                  style: TextStyle(fontSize: 11, color: _kPink700),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildAppIcon(Color color, IconData icon) {
  return CustomPaint(
    painter: _AppIconPainter(color),
    child: Container(
      width: 60,
      height: 60,
      alignment: Alignment.center,
      child: Icon(icon, color: Colors.white, size: 28),
    ),
  );
}

class _AppIconPainter extends CustomPainter {
  final Color color;

  _AppIconPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    // iOS icon has ~22.37% corner radius
    final cornerRatio = 0.2237;
    final cornerRadius = size.width * cornerRatio;

    final path = _createSuperellipsePath(
      Rect.fromLTWH(0, 0, size.width, size.height),
      cornerRadius,
    );
    canvas.drawPath(path, paint);
  }

  Path _createSuperellipsePath(Rect rect, double r) {
    final path = Path();
    final sf = 0.65;
    final w = rect.width;
    final h = rect.height;
    final x = rect.left;
    final y = rect.top;

    path.moveTo(x + r, y);
    path.lineTo(x + w - r, y);
    path.cubicTo(
      x + w - r * (1 - sf),
      y,
      x + w,
      y + r * (1 - sf),
      x + w,
      y + r,
    );
    path.lineTo(x + w, y + h - r);
    path.cubicTo(
      x + w,
      y + h - r * (1 - sf),
      x + w - r * (1 - sf),
      y + h,
      x + w - r,
      y + h,
    );
    path.lineTo(x + r, y + h);
    path.cubicTo(
      x + r * (1 - sf),
      y + h,
      x,
      y + h - r * (1 - sf),
      x,
      y + h - r,
    );
    path.lineTo(x, y + r);
    path.cubicTo(x, y + r * (1 - sf), x + r * (1 - sf), y, x + r, y);
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant _AppIconPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

/// Live clipping demo with image
Widget _buildLiveClippingDemo() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kPink300),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Live Clipping Demonstration',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kPink800,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildClippedContent('RRect Clip', _buildRRectClipped()),
            _buildClippedContent('Superellipse', _buildSuperellipseClipped()),
          ],
        ),
      ],
    ),
  );
}

Widget _buildClippedContent(String label, Widget content) {
  return Column(
    children: [
      content,
      const SizedBox(height: 8),
      Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: _kPink700,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}

Widget _buildRRectClipped() {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: _buildGradientContent(),
  );
}

Widget _buildSuperellipseClipped() {
  return ClipPath(
    clipper: _SuperellipseClipper(20),
    child: _buildGradientContent(),
  );
}

Widget _buildGradientContent() {
  return Container(
    width: 100,
    height: 100,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_kPink300, _kPink600],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Stack(
      children: [
        Positioned(
          top: 10,
          left: 10,
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(150),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 10,
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(100),
              shape: BoxShape.circle,
            ),
          ),
        ),
        const Center(child: Icon(Icons.image, color: Colors.white, size: 32)),
      ],
    ),
  );
}

class _SuperellipseClipper extends CustomClipper<Path> {
  final double cornerRadius;

  _SuperellipseClipper(this.cornerRadius);

  @override
  Path getClip(Size size) {
    return _createSuperellipsePath(
      Rect.fromLTWH(0, 0, size.width, size.height),
      cornerRadius,
    );
  }

  Path _createSuperellipsePath(Rect rect, double r) {
    final path = Path();
    final sf = 0.65;
    final w = rect.width;
    final h = rect.height;
    final x = rect.left;
    final y = rect.top;

    path.moveTo(x + r, y);
    path.lineTo(x + w - r, y);
    path.cubicTo(
      x + w - r * (1 - sf),
      y,
      x + w,
      y + r * (1 - sf),
      x + w,
      y + r,
    );
    path.lineTo(x + w, y + h - r);
    path.cubicTo(
      x + w,
      y + h - r * (1 - sf),
      x + w - r * (1 - sf),
      y + h,
      x + w - r,
      y + h,
    );
    path.lineTo(x + r, y + h);
    path.cubicTo(
      x + r * (1 - sf),
      y + h,
      x,
      y + h - r * (1 - sf),
      x,
      y + h - r,
    );
    path.lineTo(x, y + r);
    path.cubicTo(x, y + r * (1 - sf), x + r * (1 - sf), y, x + r, y);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant _SuperellipseClipper oldClipper) {
    return oldClipper.cornerRadius != cornerRadius;
  }
}

/// Mathematical background
Widget _buildMathCard() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kPink100, _kPink50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Mathematical Background',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: _kPink800,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Superellipse equation:',
                style: TextStyle(
                  fontSize: 11,
                  color: _kPink700,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '|x/a|ⁿ + |y/b|ⁿ = 1',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 16,
                  color: _kPink800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'where n > 2 creates the squircle shape.',
                style: TextStyle(fontSize: 11, color: _kPink600),
              ),
              const Divider(height: 16),
              _buildParamRow('n = 2', 'Circle/Ellipse'),
              _buildParamRow('n = 4', 'Classic squircle'),
              _buildParamRow('n → ∞', 'Rectangle'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildParamRow(String param, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: _kPink200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            param,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: _kPink800,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(desc, style: const TextStyle(fontSize: 11, color: _kPink600)),
      ],
    ),
  );
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
      color: _kPink500,
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
  // Print information about ClipRSuperellipseLayer
  print('╔══════════════════════════════════════════════════════════════════╗');
  print('║        ClipRSuperellipseLayer Deep Demo                          ║');
  print('╚══════════════════════════════════════════════════════════════════╝');

  print('\n--- ClipRSuperellipseLayer Overview ---');
  print('Clips content to a rounded superellipse (squircle) shape.');
  print('Provides smoother corners than standard RRect clipping.');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: SUPERELLIPSE CONCEPT
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Superellipse Concept ---');
  print('A superellipse uses the equation |x/a|ⁿ + |y/b|ⁿ = 1');
  print('When n > 2, corners become smoother than circular arcs.');
  print('n = 4 is the classic "squircle" shape.');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: VS ROUNDED RECTANGLE
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- RRect vs Superellipse ---');
  print('RRect: Corners are circular arcs');
  print('  - Abrupt transition from straight to curved');
  print('Superellipse: Continuous curvature');
  print('  - Smooth transition from straight to curved');
  print('  - Used by iOS for app icons');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: USE CASES
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Use Cases ---');
  print('- iOS-style app icons');
  print('- Premium UI elements');
  print('- Design systems using squircle');
  print('- Smooth corner aesthetics');

  print('\nClipRSuperellipseLayer test completed.');

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD UI
  // ═══════════════════════════════════════════════════════════════════════════

  return Container(
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFFFF0F5), Color(0xFFFFE4EC)],
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
                colors: [_kPink600, _kPink800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: _kPink700.withAlpha(80),
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
                        Icons.rounded_corner,
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
                            'ClipRSuperellipseLayer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
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
                    'Clips content to a rounded superellipse (squircle) shape, '
                    'providing smoother corners than standard rounded rectangles.',
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
            'What is a Superellipse?',
            'A superellipse (squircle) is a shape with rounded corners that '
                'follow a smooth mathematical curve rather than circular arcs.',
            Icons.help_outline,
          ),
          _buildInfoCard(
            'iOS Design',
            'Apple uses superellipse shapes for all app icons, giving them '
                'that distinctive smooth-cornered appearance.',
            Icons.apple,
          ),

          // Shape comparison
          _buildSectionTitle('Shape Comparison', Icons.compare),
          _buildShapeComparisonDemo(),
          const SizedBox(height: 20),

          // Interactive corner comparison
          _buildSectionTitle('Interactive Comparison', Icons.touch_app),
          _buildCornerComparisonDemo(),
          const SizedBox(height: 20),

          // Layer hierarchy
          _buildSectionTitle('Clip Layer Hierarchy', Icons.account_tree),
          _buildLayerHierarchyCard(),
          const SizedBox(height: 20),

          // App icons
          _buildSectionTitle('iOS-Style Icons', Icons.apps),
          _buildAppIconStyleDemo(),
          const SizedBox(height: 20),

          // Live clipping
          _buildSectionTitle('Live Clipping Demo', Icons.crop),
          _buildLiveClippingDemo(),
          const SizedBox(height: 20),

          // Math background
          _buildSectionTitle('Mathematical Background', Icons.functions),
          _buildMathCard(),
          const SizedBox(height: 20),

          // Code examples
          _buildSectionTitle('Code Examples', Icons.code),
          _buildCodeSnippet(
            'ClipRSuperellipseLayer Usage',
            '''// In a RenderObject:
final clipLayer = ClipRSuperellipseLayer(
  clipRSuperellipse: RSuperellipse.fromRectAndRadius(
    Offset.zero & size,
    const Radius.circular(20),
  ),
);

// Add children to the layer
context.pushLayer(
  clipLayer,
  super.paint,
  offset,
);''',
          ),
          _buildCodeSnippet(
            'RSuperellipse Properties',
            '''final shape = RSuperellipse.fromRectAndRadius(
  const Rect.fromLTWH(0, 0, 100, 100),
  const Radius.circular(25),
);

// Access properties
shape.outerRect;  // Bounding rectangle
shape.tlRadius;   // Top-left radius
shape.trRadius;   // Top-right radius
shape.blRadius;   // Bottom-left radius  
shape.brRadius;   // Bottom-right radius''',
          ),

          // Results
          _buildSectionTitle('Test Results', Icons.check_circle),
          _buildResultsCard(true, 'ClipRSuperellipseLayer'),
          const SizedBox(height: 20),

          // Summary
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kPink100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                const Icon(Icons.summarize, color: _kPink600, size: 32),
                const SizedBox(height: 12),
                const Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _kPink800,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'ClipRSuperellipseLayer provides superellipse clipping for that '
                  'smooth iOS-style corner aesthetic. The mathematical curve creates '
                  'continuous curvature for more visually appealing shapes.',
                  style: TextStyle(fontSize: 12, color: _kPink700, height: 1.4),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSummaryChip('squircle', Icons.rounded_corner),
                    const SizedBox(width: 8),
                    _buildSummaryChip('iOS style', Icons.apple),
                    const SizedBox(width: 8),
                    _buildSummaryChip('smooth', Icons.auto_awesome),
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
