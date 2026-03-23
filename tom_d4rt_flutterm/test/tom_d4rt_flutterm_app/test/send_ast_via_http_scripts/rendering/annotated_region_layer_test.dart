// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for AnnotatedRegionLayer from rendering
//
// AnnotatedRegionLayer<T> attaches metadata to a region of the render tree.
// The system can query these annotations via findAnnotations().
//
// Key properties:
//   - value: The annotation value of type T
//   - size: Size of the annotated region
//   - offset: Offset of the region from parent
//   - opaque: Whether this region fully occludes regions below
//
// Common use cases:
//   - SystemUiOverlayStyle: Status bar colors per region
//   - Custom annotations for hit testing
//   - Accessibility regions
//
// Related widgets:
//   - AnnotatedRegion<T>: Widget wrapper for AnnotatedRegionLayer
//   - Scaffold: Uses AnnotatedRegion for app bars
//
// This demo visualizes how annotated regions work.

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// CUSTOM ANNOTATION CLASS
// ═══════════════════════════════════════════════════════════════════════════════

class RegionInfo {
  final String name;
  final Color color;
  final int priority;

  const RegionInfo(this.name, this.color, this.priority);

  @override
  String toString() => 'RegionInfo($name, priority: $priority)';
}

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [const Color(0xFF8E24AA), const Color(0xFFBA68C8)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF8E24AA).withAlpha(100),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.layers, size: 48, color: Colors.white),
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
            color: const Color(0xFF8E24AA).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF8E24AA), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF8E24AA),
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
            Icon(Icons.layers_outlined, color: const Color(0xFF8E24AA)),
            const SizedBox(width: 8),
            const Text(
              'What is AnnotatedRegionLayer?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8E24AA),
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
            color: const Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Attaches metadata (annotation) to a region\n'
            'of the render tree for later lookup',
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
    // Draw layer stack
    final colors = [
      const Color(0xFF8E24AA),
      const Color(0xFFAB47BC),
      const Color(0xFFCE93D8),
    ];

    for (var i = 0; i < 3; i++) {
      final rect = RRect.fromRectXY(
        Rect.fromLTWH(
          30 + i * 15.0,
          20 + i * 20.0,
          size.width - 120 - i * 30.0,
          50,
        ),
        8,
        8,
      );

      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;
      canvas.drawRRect(rect, paint);

      // Draw annotation marker
      if (i == 1) {
        // Annotation bubble
        final bubbleRect = RRect.fromRectXY(
          Rect.fromLTWH(rect.right + 10, rect.top - 5, 70, 30),
          4,
          4,
        );
        paint.color = const Color(0xFFFF9800);
        canvas.drawRRect(bubbleRect, paint);

        // Arrow
        final arrowPath = Path()
          ..moveTo(rect.right + 10, rect.top + 10)
          ..lineTo(rect.right + 2, rect.top + 10)
          ..lineTo(rect.right + 10, rect.top + 18)
          ..close();
        canvas.drawPath(arrowPath, paint);

        // Label
        final tp = TextPainter(
          text: const TextSpan(
            text: 'T value',
            style: TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
          textDirection: ui.TextDirection.ltr,
        );
        tp.layout();
        tp.paint(canvas, Offset(bubbleRect.left + 12, bubbleRect.top + 7));
      }
    }

    // Labels
    _drawLabel(canvas, 'Parent Layer', Offset(size.width - 82, 24));
    _drawLabel(canvas, 'AnnotatedRegionLayer<T>', Offset(size.width - 145, 44));
    _drawLabel(canvas, 'Child Layer', Offset(size.width - 82, 64));
  }

  void _drawLabel(Canvas canvas, String text, Offset pos) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Color(0xFF8E24AA),
          fontSize: 9,
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

Widget _buildAnnotatedRegionExample() {
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
            Icon(Icons.smartphone, color: const Color(0xFF8E24AA)),
            const SizedBox(width: 8),
            const Text(
              'SystemUiOverlayStyle Example',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8E24AA),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Phone mockup showing different regions
        SizedBox(
          height: 180,
          child: CustomPaint(
            size: const Size(double.infinity, 180),
            painter: _PhoneMockupPainter(),
          ),
        ),
        const SizedBox(height: 12),
        _buildCodeSnippet(
          'AnnotatedRegion<SystemUiOverlayStyle>(\n'
          '  value: SystemUiOverlayStyle(\n'
          '    statusBarColor: Colors.transparent,\n'
          '    statusBarIconBrightness: Brightness.light,\n'
          '  ),\n'
          '  child: AppBar(title: Text("Title")),\n'
          ')',
        ),
      ],
    ),
  );
}

class _PhoneMockupPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final phoneW = 100.0;
    final phoneH = 160.0;
    final phoneX = (size.width - phoneW) / 2;
    final phoneY = (size.height - phoneH) / 2;

    // Phone body
    final phonePaint = Paint()
      ..color = Colors.grey[800]!
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectXY(Rect.fromLTWH(phoneX, phoneY, phoneW, phoneH), 12, 12),
      phonePaint,
    );

    // Screen
    final screenPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(phoneX + 5, phoneY + 15, phoneW - 10, phoneH - 30),
      screenPaint,
    );

    // Status bar region (dark)
    final statusPaint = Paint()
      ..color = const Color(0xFF8E24AA)
      ..style = PaintingStyle.fill;
    canvas.drawRect(
      Rect.fromLTWH(phoneX + 5, phoneY + 15, phoneW - 10, 18),
      statusPaint,
    );
    _drawLabel(
      canvas,
      'Light icons',
      Offset(phoneX + 35, phoneY + 19),
      Colors.white,
    );

    // AppBar region
    statusPaint.color = const Color(0xFFAB47BC);
    canvas.drawRect(
      Rect.fromLTWH(phoneX + 5, phoneY + 33, phoneW - 10, 30),
      statusPaint,
    );
    _drawLabel(
      canvas,
      'AppBar',
      Offset(phoneX + 32, phoneY + 41),
      Colors.white,
    );

    // Content region
    statusPaint.color = const Color(0xFFE1BEE7);
    canvas.drawRect(
      Rect.fromLTWH(phoneX + 5, phoneY + 63, phoneW - 10, 64),
      statusPaint,
    );
    _drawLabel(
      canvas,
      'Content',
      Offset(phoneX + 32, phoneY + 89),
      Colors.black,
    );

    // Labels with arrows
    _drawArrowLabel(
      canvas,
      'Region 1',
      Offset(phoneX - 60, phoneY + 30),
      Offset(phoneX, phoneY + 30),
    );
    _drawArrowLabel(
      canvas,
      'Region 2',
      Offset(phoneX + phoneW + 10, phoneY + 70),
      Offset(phoneX + phoneW, phoneY + 70),
    );
  }

  void _drawLabel(Canvas canvas, String text, Offset pos, Color color) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, pos);
  }

  void _drawArrowLabel(
    Canvas canvas,
    String text,
    Offset labelPos,
    Offset arrowEnd,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Color(0xFF8E24AA),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, labelPos);

    // Arrow line
    final linePaint = Paint()
      ..color = const Color(0xFF8E24AA)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(labelPos.dx + tp.width + 3, labelPos.dy + 5),
      arrowEnd,
      linePaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildLayerPropertiesCard() {
  final props = [
    {'name': 'value', 'type': 'T', 'desc': 'The annotation data'},
    {'name': 'size', 'type': 'Size', 'desc': 'Region dimensions'},
    {'name': 'offset', 'type': 'Offset', 'desc': 'Offset from parent'},
    {'name': 'opaque', 'type': 'bool', 'desc': 'Occludes layers below'},
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
            Icon(Icons.settings, color: const Color(0xFF8E24AA)),
            const SizedBox(width: 8),
            const Text(
              'Layer Properties',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8E24AA),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...props.map(
          (p) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 70,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8E24AA),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    p['name'] as String,
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 50,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E5F5),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    p['type'] as String,
                    style: const TextStyle(
                      fontSize: 9,
                      fontFamily: 'monospace',
                      color: Color(0xFF8E24AA),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    p['desc'] as String,
                    style: TextStyle(fontSize: 11, color: Colors.grey[700]),
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

Widget _buildFindAnnotationsCard() {
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
            Icon(Icons.search, color: const Color(0xFF8E24AA)),
            const SizedBox(width: 8),
            const Text(
              'Finding Annotations',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8E24AA),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: CustomPaint(
            size: const Size(double.infinity, 100),
            painter: _FindAnnotationsPainter(),
          ),
        ),
        const SizedBox(height: 12),
        _buildCodeSnippet(
          '// How the system finds annotations:\n'
          'layer.findAllAnnotations<T>(\n'
          '  result,\n'
          '  localPosition: position,\n'
          ');\n'
          '\n'
          '// Traverses the layer tree looking for\n'
          '// AnnotatedRegionLayer<T> at given position',
        ),
      ],
    ),
  );
}

class _FindAnnotationsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Target point
    final targetX = size.width * 0.3;
    final targetY = size.height * 0.5;

    // Regions
    final regions = [
      Rect.fromLTWH(10, 10, size.width * 0.5, size.height - 20),
      Rect.fromLTWH(20, 20, size.width * 0.4, size.height - 40),
    ];

    final colors = [
      const Color(0xFFCE93D8).withAlpha(150),
      const Color(0xFFAB47BC).withAlpha(150),
    ];

    for (var i = 0; i < regions.length; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;
      canvas.drawRect(regions[i], paint);

      // Border
      paint
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2
        ..color = const Color(0xFF8E24AA);
      canvas.drawRect(regions[i], paint);
    }

    // Target crosshair
    final crossPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(targetX - 10, targetY),
      Offset(targetX + 10, targetY),
      crossPaint,
    );
    canvas.drawLine(
      Offset(targetX, targetY - 10),
      Offset(targetX, targetY + 10),
      crossPaint,
    );
    canvas.drawCircle(Offset(targetX, targetY), 5, crossPaint);

    // Labels
    _drawLabel(canvas, 'Query point', Offset(targetX + 12, targetY - 5));
    _drawLabel(
      canvas,
      'Region A',
      Offset(regions[0].right - 50, regions[0].top + 5),
    );
    _drawLabel(
      canvas,
      'Region B',
      Offset(regions[1].right - 50, regions[1].top + 5),
    );

    // Result box
    final resultPaint = Paint()
      ..color = const Color(0xFF4CAF50)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectXY(Rect.fromLTWH(size.width - 100, 20, 90, 60), 6, 6),
      resultPaint,
    );

    final tp = TextPainter(
      text: const TextSpan(
        text: 'Results:\nRegion B\nRegion A',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(size.width - 95, 25));
  }

  void _drawLabel(Canvas canvas, String text, Offset pos) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Color(0xFF8E24AA),
          fontSize: 9,
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

Widget _buildOpaqueDemo() {
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
            Icon(Icons.visibility, color: const Color(0xFF8E24AA)),
            const SizedBox(width: 8),
            const Text(
              'Opaque Property',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8E24AA),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildOpaqueColumn('opaque: false', false)),
            const SizedBox(width: 16),
            Expanded(child: _buildOpaqueColumn('opaque: true', true)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildOpaqueColumn(String label, bool opaque) {
  return Column(
    children: [
      Text(
        label,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 11,
          fontFamily: 'monospace',
        ),
      ),
      const SizedBox(height: 8),
      SizedBox(
        height: 80,
        child: CustomPaint(
          size: const Size(double.infinity, 80),
          painter: _OpaqueDemoPainter(opaque),
        ),
      ),
      const SizedBox(height: 4),
      Text(
        opaque ? 'Stops search' : 'Continues search',
        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
      ),
    ],
  );
}

class _OpaqueDemoPainter extends CustomPainter {
  final bool opaque;
  _OpaqueDemoPainter(this.opaque);

  @override
  void paint(Canvas canvas, Size size) {
    // Bottom layer
    final bottomPaint = Paint()
      ..color = opaque ? Colors.grey.withAlpha(100) : const Color(0xFFCE93D8)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(10, 40, size.width - 20, 30), bottomPaint);

    // Border
    bottomPaint
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = opaque ? Colors.grey : const Color(0xFF8E24AA);
    canvas.drawRect(Rect.fromLTWH(10, 40, size.width - 20, 30), bottomPaint);

    // Top layer (opaque region)
    final topPaint = Paint()
      ..color = const Color(0xFF8E24AA)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(20, 10, size.width - 40, 35), topPaint);

    // X mark if opaque blocks
    if (opaque) {
      final xPaint = Paint()
        ..color = Colors.red
        ..strokeWidth = 2;
      canvas.drawLine(
        Offset(size.width / 2 - 10, 45),
        Offset(size.width / 2 + 10, 65),
        xPaint,
      );
      canvas.drawLine(
        Offset(size.width / 2 + 10, 45),
        Offset(size.width / 2 - 10, 65),
        xPaint,
      );
    } else {
      // Arrow showing traversal continues
      final arrowPaint = Paint()
        ..color = const Color(0xFF4CAF50)
        ..strokeWidth = 2;
      canvas.drawLine(
        Offset(size.width / 2, 45),
        Offset(size.width / 2, 65),
        arrowPaint,
      );
      // Arrowhead
      final path = Path()
        ..moveTo(size.width / 2 - 5, 60)
        ..lineTo(size.width / 2, 68)
        ..lineTo(size.width / 2 + 5, 60);
      canvas.drawPath(path, arrowPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildUseCasesCard() {
  final cases = [
    {
      'icon': Icons.brightness_6,
      'title': 'Status Bar Styling',
      'desc': 'Light/dark icons per screen region',
    },
    {
      'icon': Icons.touch_app,
      'title': 'Hit Testing',
      'desc': 'Custom hit test data per region',
    },
    {
      'icon': Icons.accessibility,
      'title': 'Accessibility',
      'desc': 'Annotate semantic regions',
    },
    {
      'icon': Icons.navigation,
      'title': 'Navigation',
      'desc': 'Track which route is visible',
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
            Icon(Icons.lightbulb, color: const Color(0xFF8E24AA)),
            const SizedBox(width: 8),
            const Text(
              'Use Cases',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8E24AA),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...cases.map(
          (c) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E5F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    c['icon'] as IconData,
                    size: 18,
                    color: const Color(0xFF8E24AA),
                  ),
                ),
                const SizedBox(width: 12),
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

Widget _buildResultsCard(
  bool layerCreated,
  String annotationType,
  String layerType,
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
            Icon(Icons.check_circle, color: const Color(0xFF4CAF50)),
            const SizedBox(width: 8),
            const Text(
              'Test Results',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8E24AA),
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
        _buildResultRow('Annotation type', annotationType, true),
        _buildResultRow('Layer type', layerType, true),
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

Widget _buildLiveDemo(RegionInfo regionA, RegionInfo regionB) {
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
            Icon(Icons.preview, color: const Color(0xFF8E24AA)),
            const SizedBox(width: 8),
            const Text(
              'Live Demo with Custom Annotations',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF8E24AA),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: Row(
            children: [
              Expanded(
                child: AnnotatedRegion<RegionInfo>(
                  value: regionA,
                  child: Container(
                    decoration: BoxDecoration(
                      color: regionA.color.withAlpha(100),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: regionA.color, width: 2),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            regionA.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: regionA.color,
                            ),
                          ),
                          Text(
                            'Priority: ${regionA.priority}',
                            style: TextStyle(
                              fontSize: 10,
                              color: regionA.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: AnnotatedRegion<RegionInfo>(
                  value: regionB,
                  child: Container(
                    decoration: BoxDecoration(
                      color: regionB.color.withAlpha(100),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: regionB.color, width: 2),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            regionB.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: regionB.color,
                            ),
                          ),
                          Text(
                            'Priority: ${regionB.priority}',
                            style: TextStyle(
                              fontSize: 10,
                              color: regionB.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            'Each region is wrapped with AnnotatedRegion<RegionInfo>',
            style: TextStyle(fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== AnnotatedRegionLayer Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- AnnotatedRegionLayer Overview ---');
  print('Attaches metadata to render tree regions');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: CREATE LAYER
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Creating AnnotatedRegionLayer ---');

  final annotationValue = RegionInfo('TestRegion', Colors.purple, 1);
  final layer = AnnotatedRegionLayer<RegionInfo>(
    annotationValue,
    size: const Size(100, 50),
    offset: const Offset(10, 10),
    opaque: false,
  );

  print('Layer type: ${layer.runtimeType}');
  print('Annotation: ${layer.value}');
  print('Size: ${layer.size}');
  print('Offset: ${layer.offset}');
  print('Opaque: ${layer.opaque}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: SYSTEM UI OVERLAY STYLE EXAMPLE
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- SystemUiOverlayStyle Example ---');
  final lightStyle = SystemUiOverlayStyle.light;
  final darkStyle = SystemUiOverlayStyle.dark;
  print('Light style: $lightStyle');
  print('Dark style: $darkStyle');

  // Create layer with system UI style
  final uiLayer = AnnotatedRegionLayer<SystemUiOverlayStyle>(
    lightStyle,
    size: const Size(360, 24),
  );
  print('UI Layer created: ${uiLayer.runtimeType}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: CUSTOM ANNOTATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Custom Annotations ---');
  final regionA = RegionInfo('Content', const Color(0xFF8E24AA), 1);
  final regionB = RegionInfo('Sidebar', const Color(0xFF4CAF50), 2);
  print('Region A: $regionA');
  print('Region B: $regionB');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: LAYER PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Layer Properties ---');
  print('Value: The annotation of type T');
  print('Size: Dimensions of the annotated region');
  print('Offset: Position relative to parent');
  print('Opaque: Whether to stop annotation search');

  print('\n=== AnnotatedRegionLayer Deep Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL UI
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(
          'AnnotatedRegionLayer',
          'Attach Metadata to Render Regions',
        ),
        const SizedBox(height: 20),

        // Concept
        _buildSectionTitle('Concept', Icons.layers_outlined),
        _buildConceptCard(),
        const SizedBox(height: 20),

        // Properties
        _buildSectionTitle('Properties', Icons.settings),
        _buildLayerPropertiesCard(),
        const SizedBox(height: 20),

        // SystemUiOverlayStyle
        _buildSectionTitle('Common Usage', Icons.smartphone),
        _buildAnnotatedRegionExample(),
        const SizedBox(height: 20),

        // Finding annotations
        _buildSectionTitle('Finding Annotations', Icons.search),
        _buildFindAnnotationsCard(),
        const SizedBox(height: 20),

        // Opaque property
        _buildSectionTitle('Opaque Behavior', Icons.visibility),
        _buildOpaqueDemo(),
        const SizedBox(height: 20),

        // Live demo
        _buildSectionTitle('Live Demo', Icons.preview),
        _buildLiveDemo(regionA, regionB),
        const SizedBox(height: 20),

        // Use cases
        _buildSectionTitle('Use Cases', Icons.lightbulb),
        _buildUseCasesCard(),
        const SizedBox(height: 20),

        // Results
        _buildSectionTitle('Test Results', Icons.check_circle),
        _buildResultsCard(
          true,
          '${annotationValue.runtimeType}',
          '${layer.runtimeType}',
        ),
        const SizedBox(height: 20),

        // Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF3E5F5),
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
                  color: Color(0xFF8E24AA),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• AnnotatedRegionLayer attaches metadata to regions\n'
                '• Generic type T defines the annotation type\n'
                '• findAllAnnotations() queries the layer tree\n'
                '• opaque=true stops downward traversal\n'
                '• Use AnnotatedRegion widget for convenience\n'
                '• Common for SystemUiOverlayStyle theming',
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
