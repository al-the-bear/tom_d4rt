// ignore_for_file: avoid_print
// D4rt test script: Deep demo for ClipPathLayer from rendering
//
// ClipPathLayer clips its child layers to an arbitrary Path.
// Part of the low-level layer compositing API.
//
// Key properties:
//   - clipPath: The Path to clip to
//   - clipBehavior: How to apply the clip (antiAlias, hardEdge, none)
//
// Related classes:
//   - ClipRectLayer: Clips to a rectangle
//   - ClipRRectLayer: Clips to a rounded rectangle
//   - ClipPath widget: High-level wrapper
//   - CustomClipper: For dynamic clip paths
//
// Use cases:
//   - Complex shaped masking (stars, hearts, arrows)
//   - Custom button shapes
//   - Image cropping to shapes
//   - Decorative UI elements
//
// This demo visualizes different clip path shapes.

import 'dart:ui' as ui;
import 'dart:math' as math;
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
        colors: [const Color(0xFF00695C), const Color(0xFF26A69A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF00695C).withAlpha(100),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.crop_free, size: 48, color: Colors.white),
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
            color: const Color(0xFF26A69A).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF00695C), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF00695C),
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
            Icon(Icons.content_cut, color: const Color(0xFF00695C)),
            const SizedBox(width: 8),
            const Text(
              'What is ClipPathLayer?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: CustomPaint(
            size: const Size(double.infinity, 100),
            painter: _ConceptPainter(),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Clips child layers to any Path shape,\n'
            'showing only content inside the path',
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
    // Before (full rectangle)
    final beforeRect = Rect.fromLTWH(20, 10, 100, 80);
    final gridPaint = Paint()
      ..color = Colors.blue.withAlpha(50)
      ..style = PaintingStyle.fill;

    // Draw grid pattern (content)
    for (var x = beforeRect.left; x < beforeRect.right; x += 10) {
      for (var y = beforeRect.top; y < beforeRect.bottom; y += 10) {
        final idx = ((x - beforeRect.left) / 10 + (y - beforeRect.top) / 10)
            .toInt();
        gridPaint.color = idx.isEven
            ? Colors.blue.withAlpha(100)
            : Colors.green.withAlpha(100);
        canvas.drawRect(Rect.fromLTWH(x, y, 10, 10), gridPaint);
      }
    }

    // Border
    final borderPaint = Paint()
      ..color = const Color(0xFF00695C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(beforeRect, borderPaint);
    _drawLabel(canvas, 'Original', Offset(45, size.height - 5));

    // Arrow
    final arrowPaint = Paint()
      ..color = const Color(0xFF00695C)
      ..strokeWidth = 2;
    canvas.drawLine(Offset(130, 50), Offset(170, 50), arrowPaint);
    final arrowPath = Path()
      ..moveTo(165, 45)
      ..lineTo(175, 50)
      ..lineTo(165, 55);
    canvas.drawPath(arrowPath, arrowPaint);

    // After (clipped star)
    canvas.save();
    final afterRect = Rect.fromLTWH(180, 10, 100, 80);
    final starPath = _createStarPath(afterRect.center, 35, 15);
    canvas.clipPath(starPath);

    // Content
    for (var x = afterRect.left; x < afterRect.right; x += 10) {
      for (var y = afterRect.top; y < afterRect.bottom; y += 10) {
        final idx = ((x - afterRect.left) / 10 + (y - afterRect.top) / 10)
            .toInt();
        gridPaint.color = idx.isEven
            ? Colors.blue.withAlpha(100)
            : Colors.green.withAlpha(100);
        canvas.drawRect(Rect.fromLTWH(x, y, 10, 10), gridPaint);
      }
    }
    canvas.restore();

    // Star outline
    final starOutline = Paint()
      ..color = const Color(0xFF00695C)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(starPath, starOutline);
    _drawLabel(canvas, 'Clipped', Offset(210, size.height - 5));
  }

  Path _createStarPath(Offset center, double outerRadius, double innerRadius) {
    final path = Path();
    const points = 5;
    const angle = math.pi / points;

    for (var i = 0; i < points * 2; i++) {
      final r = i.isEven ? outerRadius : innerRadius;
      final a = i * angle - math.pi / 2;
      final x = center.dx + r * math.cos(a);
      final y = center.dy + r * math.sin(a);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  void _drawLabel(Canvas canvas, String text, Offset pos) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Color(0xFF00695C),
          fontSize: 10,
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

Widget _buildPathShapesCard() {
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
            Icon(Icons.category, color: const Color(0xFF00695C)),
            const SizedBox(width: 8),
            const Text(
              'Common Path Shapes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: CustomPaint(
            size: const Size(double.infinity, 120),
            painter: _ShapesPainter(),
          ),
        ),
      ],
    ),
  );
}

class _ShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final shapes = <Map<String, dynamic>>[
      {'name': 'Star', 'create': _createStar},
      {'name': 'Heart', 'create': _createHeart},
      {'name': 'Arrow', 'create': _createArrow},
      {'name': 'Hexagon', 'create': _createHexagon},
    ];

    final cellW = size.width / 4;
    final cellH = size.height;

    for (var i = 0; i < shapes.length; i++) {
      final center = Offset(cellW * i + cellW / 2, cellH / 2 - 10);
      final path = (shapes[i]['create'] as Function)(center, 30.0);

      // Fill
      final fillPaint = Paint()
        ..color = const Color(0xFF26A69A).withAlpha(100)
        ..style = PaintingStyle.fill;
      canvas.drawPath(path as Path, fillPaint);

      // Stroke
      final strokePaint = Paint()
        ..color = const Color(0xFF00695C)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawPath(path, strokePaint);

      // Label
      _drawLabel(
        canvas,
        shapes[i]['name'] as String,
        Offset(center.dx, cellH - 15),
      );
    }
  }

  Path _createStar(Offset center, double r) {
    final path = Path();
    const points = 5;
    const angle = math.pi / points;
    final innerR = r * 0.4;

    for (var i = 0; i < points * 2; i++) {
      final radius = i.isEven ? r : innerR;
      final a = i * angle - math.pi / 2;
      final x = center.dx + radius * math.cos(a);
      final y = center.dy + radius * math.sin(a);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  Path _createHeart(Offset center, double r) {
    final path = Path();
    path.moveTo(center.dx, center.dy + r * 0.7);

    // Left curve
    path.cubicTo(
      center.dx - r,
      center.dy,
      center.dx - r,
      center.dy - r * 0.6,
      center.dx,
      center.dy - r * 0.3,
    );

    // Right curve
    path.cubicTo(
      center.dx + r,
      center.dy - r * 0.6,
      center.dx + r,
      center.dy,
      center.dx,
      center.dy + r * 0.7,
    );

    path.close();
    return path;
  }

  Path _createArrow(Offset center, double r) {
    final path = Path();
    // Arrow pointing right
    path.moveTo(center.dx - r, center.dy - r * 0.3);
    path.lineTo(center.dx, center.dy - r * 0.3);
    path.lineTo(center.dx, center.dy - r * 0.6);
    path.lineTo(center.dx + r, center.dy);
    path.lineTo(center.dx, center.dy + r * 0.6);
    path.lineTo(center.dx, center.dy + r * 0.3);
    path.lineTo(center.dx - r, center.dy + r * 0.3);
    path.close();
    return path;
  }

  Path _createHexagon(Offset center, double r) {
    final path = Path();
    for (var i = 0; i < 6; i++) {
      final angle = i * math.pi / 3 - math.pi / 6;
      final x = center.dx + r * math.cos(angle);
      final y = center.dy + r * math.sin(angle);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  void _drawLabel(Canvas canvas, String text, Offset pos) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Color(0xFF00695C),
          fontSize: 10,
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

Widget _buildClipBehaviorCard() {
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
            Icon(Icons.tune, color: const Color(0xFF00695C)),
            const SizedBox(width: 8),
            const Text(
              'Clip Behavior Options',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: CustomPaint(
            size: const Size(double.infinity, 100),
            painter: _ClipBehaviorPainter(),
          ),
        ),
        const SizedBox(height: 12),
        _buildBehaviorRow('Clip.none', 'No clipping (fastest)'),
        _buildBehaviorRow('Clip.hardEdge', 'Sharp edges, no anti-aliasing'),
        _buildBehaviorRow('Clip.antiAlias', 'Smooth edges (default)'),
        _buildBehaviorRow(
          'Clip.antiAliasWithSaveLayer',
          'Best quality, slowest',
        ),
      ],
    ),
  );
}

Widget _buildBehaviorRow(String name, String desc) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Container(
          width: 140,
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFF00695C),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 9,
              color: Colors.white,
              fontFamily: 'monospace',
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

class _ClipBehaviorPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final labels = ['hardEdge', 'antiAlias', 'antiAliasSaveLayer'];
    final cellW = size.width / 3;

    for (var i = 0; i < labels.length; i++) {
      final center = Offset(cellW * i + cellW / 2, 40);

      // Circle with visible edge quality
      final paint = Paint()
        ..color = const Color(0xFF26A69A)
        ..style = PaintingStyle.fill;

      // Simulate different edge qualities
      if (i == 0) {
        // Hard edge - jagged circle
        paint.isAntiAlias = false;
        canvas.drawCircle(center, 25, paint);
      } else if (i == 1) {
        // Anti-alias - smooth
        paint.isAntiAlias = true;
        canvas.drawCircle(center, 25, paint);
      } else {
        // With save layer - gradient example to show blending
        paint.isAntiAlias = true;
        paint.shader = ui.Gradient.radial(center, 25, [
          const Color(0xFF26A69A),
          const Color(0xFF00695C),
        ]);
        canvas.drawCircle(center, 25, paint);
      }

      // Label
      final tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(
            color: Color(0xFF00695C),
            fontSize: 9,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: ui.TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(center.dx - tp.width / 2, 75));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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

Widget _buildLayerCodeCard() {
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
            Icon(Icons.code, color: const Color(0xFF00695C)),
            const SizedBox(width: 8),
            const Text(
              'Creating ClipPathLayer',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildCodeSnippet(
          '// Create the path to clip to\n'
          'final path = Path()\n'
          '  ..moveTo(50, 0)\n'
          '  ..lineTo(100, 50)\n'
          '  ..lineTo(50, 100)\n'
          '  ..lineTo(0, 50)\n'
          '  ..close();\n'
          '\n'
          '// Create the layer\n'
          'final layer = ClipPathLayer(\n'
          '  clipPath: path,\n'
          '  clipBehavior: Clip.antiAlias,\n'
          ');\n'
          '\n'
          '// Add children\n'
          'layer.append(childLayer);',
        ),
      ],
    ),
  );
}

Widget _buildComparisonCard() {
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
            Icon(Icons.compare, color: const Color(0xFF00695C)),
            const SizedBox(width: 8),
            const Text(
              'Clip Layer Comparison',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildComparisonRow('ClipRectLayer', 'Rectangle', Icons.crop_square),
        _buildComparisonRow(
          'ClipRRectLayer',
          'Rounded rect',
          Icons.rounded_corner,
        ),
        _buildComparisonRow('ClipPathLayer', 'Any path', Icons.star),
      ],
    ),
  );
}

Widget _buildComparisonRow(String name, String desc, IconData icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2F1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 18, color: const Color(0xFF00695C)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 10, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildLiveDemo() {
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
            Icon(Icons.preview, color: const Color(0xFF00695C)),
            const SizedBox(width: 8),
            const Text(
              'Live ClipPath Demo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildClipDemo('Star', _StarClipper()),
            _buildClipDemo('Heart', _HeartClipper()),
            _buildClipDemo('Diamond', _DiamondClipper()),
          ],
        ),
      ],
    ),
  );
}

Widget _buildClipDemo(String label, CustomClipper<Path> clipper) {
  return Column(
    children: [
      ClipPath(
        clipper: clipper,
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF00695C), const Color(0xFF26A69A)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Icon(
              Icons.image,
              color: Colors.white.withAlpha(150),
              size: 24,
            ),
          ),
        ),
      ),
      const SizedBox(height: 6),
      Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Color(0xFF00695C),
        ),
      ),
    ],
  );
}

class _StarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final center = Offset(size.width / 2, size.height / 2);
    const points = 5;
    const angle = math.pi / points;
    final outerR = size.width / 2;
    final innerR = size.width / 5;

    for (var i = 0; i < points * 2; i++) {
      final r = i.isEven ? outerR : innerR;
      final a = i * angle - math.pi / 2;
      final x = center.dx + r * math.cos(a);
      final y = center.dy + r * math.sin(a);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _HeartClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w / 2, h * 0.9);
    path.cubicTo(0, h * 0.5, 0, 0, w / 2, h * 0.25);
    path.cubicTo(w, 0, w, h * 0.5, w / 2, h * 0.9);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _DiamondClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final w = size.width;
    final h = size.height;

    path.moveTo(w / 2, 0);
    path.lineTo(w, h / 2);
    path.lineTo(w / 2, h);
    path.lineTo(0, h / 2);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

Widget _buildUseCasesCard() {
  final cases = [
    {
      'icon': Icons.person,
      'title': 'Avatar Shapes',
      'desc': 'Circular, hexagonal, custom avatars',
    },
    {
      'icon': Icons.smart_button,
      'title': 'Custom Buttons',
      'desc': 'Arrow, star, badge shapes',
    },
    {
      'icon': Icons.photo_size_select_large,
      'title': 'Image Cropping',
      'desc': 'Crop images to shapes',
    },
    {
      'icon': Icons.animation,
      'title': 'Transitions',
      'desc': 'Reveal animations with paths',
    },
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
            Icon(Icons.lightbulb, color: const Color(0xFF00695C)),
            const SizedBox(width: 8),
            const Text(
              'Use Cases',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...cases.map(
          (c) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2F1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    c['icon'] as IconData,
                    size: 16,
                    color: const Color(0xFF00695C),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        c['desc'] as String,
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      ),
                    ],
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

Widget _buildResultsCard(bool layerCreated, String pathType, String behavior) {
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
                color: Color(0xFF00695C),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildResultRow(
          'Layer created',
          layerCreated ? 'Yes' : 'No',
          layerCreated,
        ),
        _buildResultRow('Path type', pathType, true),
        _buildResultRow('Clip behavior', behavior, true),
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
          success ? Icons.check_circle : Icons.cancel,
          size: 14,
          color: success ? const Color(0xFF4CAF50) : Colors.red,
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 100,
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
  print('=== ClipPathLayer Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- ClipPathLayer Overview ---');
  print('Clips child layers to an arbitrary Path shape');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: CREATE PATH
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Creating Clip Paths ---');

  // Diamond path
  final diamondPath = Path()
    ..moveTo(50, 0)
    ..lineTo(100, 50)
    ..lineTo(50, 100)
    ..lineTo(0, 50)
    ..close();
  print('Diamond path created');
  print('Path bounds: ${diamondPath.getBounds()}');

  // Star path
  final starPath = Path();
  const points = 5;
  const outerR = 50.0;
  const innerR = 20.0;
  final center = const Offset(50, 50);

  for (var i = 0; i < points * 2; i++) {
    final r = i.isEven ? outerR : innerR;
    final angle = i * math.pi / points - math.pi / 2;
    final x = center.dx + r * math.cos(angle);
    final y = center.dy + r * math.sin(angle);
    if (i == 0) {
      starPath.moveTo(x, y);
    } else {
      starPath.lineTo(x, y);
    }
  }
  starPath.close();
  print('Star path created');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: CREATE LAYER
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Creating ClipPathLayer ---');

  final layer = ClipPathLayer(
    clipPath: diamondPath,
    clipBehavior: Clip.antiAlias,
  );

  print('Layer type: ${layer.runtimeType}');
  print('Clip path bounds: ${layer.clipPath?.getBounds()}');
  print('Clip behavior: ${layer.clipBehavior}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: CLIP BEHAVIORS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Clip Behaviors ---');
  print('Clip.none: No clipping applied');
  print('Clip.hardEdge: No anti-aliasing');
  print('Clip.antiAlias: Smooth edges');
  print('Clip.antiAliasWithSaveLayer: Best quality');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Layer Comparison ---');
  print('ClipRectLayer: Rectangle clips');
  print('ClipRRectLayer: Rounded rectangle clips');
  print('ClipPathLayer: Arbitrary path clips');

  print('\n=== ClipPathLayer Deep Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL UI
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader('ClipPathLayer', 'Clip to Any Path Shape'),
        const SizedBox(height: 20),

        // Concept
        _buildSectionTitle('Concept', Icons.content_cut),
        _buildConceptCard(),
        const SizedBox(height: 20),

        // Path shapes
        _buildSectionTitle('Path Shapes', Icons.category),
        _buildPathShapesCard(),
        const SizedBox(height: 20),

        // Live demo
        _buildSectionTitle('Live Demo', Icons.preview),
        _buildLiveDemo(),
        const SizedBox(height: 20),

        // Clip behavior
        _buildSectionTitle('Clip Behavior', Icons.tune),
        _buildClipBehaviorCard(),
        const SizedBox(height: 20),

        // Code
        _buildSectionTitle('Creating Layer', Icons.code),
        _buildLayerCodeCard(),
        const SizedBox(height: 20),

        // Comparison
        _buildSectionTitle('Layer Types', Icons.compare),
        _buildComparisonCard(),
        const SizedBox(height: 20),

        // Use cases
        _buildSectionTitle('Use Cases', Icons.lightbulb),
        _buildUseCasesCard(),
        const SizedBox(height: 20),

        // Results
        _buildSectionTitle('Test Results', Icons.check_circle),
        _buildResultsCard(true, 'Diamond (Path)', 'Clip.antiAlias'),
        const SizedBox(height: 20),

        // Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE0F2F1),
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
                  color: Color(0xFF00695C),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• ClipPathLayer clips to arbitrary Path shapes\n'
                '• Use Path API to create stars, hearts, polygons\n'
                '• Clip.antiAlias provides smooth edges\n'
                '• Part of the layer compositing system\n'
                '• Use ClipPath widget for declarative clipping\n'
                '• CustomClipper for dynamic clip paths',
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
