// D4rt test script: Deep demo for PictureLayer from rendering
//
// PictureLayer displays a Picture containing recorded drawing commands.
// Part of the low-level layer compositing API in Flutter.
//
// Key properties:
//   - picture: The Picture object containing drawing commands
//   - canvasBounds: The bounds where the picture can draw
//   - isComplexHint: Suggests the picture is complex (for raster caching)
//   - willChangeHint: Suggests the picture will change soon
//
// Related classes:
//   - Picture: Contains recorded drawing operations
//   - PictureRecorder: Records drawing operations to create a Picture
//   - Canvas: Drawing surface connected to PictureRecorder
//   - CustomPaint widget: High-level wrapper using CustomPainter
//
// Use cases:
//   - Custom painting via RenderCustomPaint
//   - Pre-recorded drawing command playback
//   - Performance caching for complex graphics
//   - Low-level compositing control
//
// This demo visualizes the PictureLayer workflow and properties.

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
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF5D4037), Color(0xFF8D6E63)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF5D4037).withAlpha(100),
          blurRadius: 12,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.layers, size: 48, color: Colors.white),
        SizedBox(height: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4),
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
    padding: EdgeInsets.symmetric(vertical: 12),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF8D6E63).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFF5D4037), size: 20),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5D4037),
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoRow(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF5D4037),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? Color(0xFF6D4C41),
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: CUSTOMPAINT AS VISUAL ENTRY POINT
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildCustomPaintSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.brush, color: Color(0xFF5D4037)),
            SizedBox(width: 8),
            Text(
              'CustomPaint Widget Flow',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: CustomPaint(
            size: Size(double.infinity, 140),
            painter: _CustomPaintFlowPainter(),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFEFEBE9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The path from widget to layer:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF5D4037),
                ),
              ),
              SizedBox(height: 8),
              _buildFlowStep('1.', 'CustomPaint creates RenderCustomPaint'),
              _buildFlowStep('2.', 'RenderCustomPaint.paint() creates PictureRecorder'),
              _buildFlowStep('3.', 'Canvas draws via CustomPainter.paint()'),
              _buildFlowStep('4.', 'PictureRecorder.endRecording() produces Picture'),
              _buildFlowStep('5.', 'Picture assigned to PictureLayer.picture'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFlowStep(String number, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          child: Text(
            number,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFF8D6E63),
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Color(0xFF6D4C41)),
          ),
        ),
      ],
    ),
  );
}

class _CustomPaintFlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final boxes = <Map<String, dynamic>>[
      {'label': 'CustomPaint\nWidget', 'color': Color(0xFF8D6E63)},
      {'label': 'Render\nCustomPaint', 'color': Color(0xFF795548)},
      {'label': 'Picture\nRecorder', 'color': Color(0xFF6D4C41)},
      {'label': 'Picture\nLayer', 'color': Color(0xFF5D4037)},
    ];

    final boxWidth = 70.0;
    final boxHeight = 50.0;
    final spacing = (size.width - boxes.length * boxWidth) / (boxes.length + 1);
    final y = (size.height - boxHeight) / 2;

    for (var i = 0; i < boxes.length; i++) {
      final x = spacing + i * (boxWidth + spacing);
      final rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, boxWidth, boxHeight),
        Radius.circular(8),
      );

      final boxPaint = Paint()
        ..color = boxes[i]['color'] as Color
        ..style = PaintingStyle.fill;
      canvas.drawRRect(rect, boxPaint);

      final borderPaint = Paint()
        ..color = Color(0xFF3E2723)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRRect(rect, borderPaint);

      _drawCenteredText(
        canvas,
        boxes[i]['label'] as String,
        Offset(x + boxWidth / 2, y + boxHeight / 2),
        Colors.white,
        10,
      );

      if (i < boxes.length - 1) {
        final arrowStart = Offset(x + boxWidth + 4, y + boxHeight / 2);
        final arrowEnd = Offset(x + boxWidth + spacing - 4, y + boxHeight / 2);
        _drawArrow(canvas, arrowStart, arrowEnd);
      }
    }

    _drawCenteredText(
      canvas,
      'Widget Layer → Render Layer → Compositing Layer',
      Offset(size.width / 2, size.height - 15),
      Color(0xFF6D4C41),
      11,
    );
  }

  void _drawArrow(Canvas canvas, Offset start, Offset end) {
    final paint = Paint()
      ..color = Color(0xFF8D6E63)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(start, end, paint);

    final headPaint = Paint()
      ..color = Color(0xFF8D6E63)
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(end.dx - 6, end.dy - 4)
      ..lineTo(end.dx, end.dy)
      ..lineTo(end.dx - 6, end.dy + 4)
      ..close();
    canvas.drawPath(path, headPaint);
  }

  void _drawCenteredText(
    Canvas canvas,
    String text,
    Offset center,
    Color color,
    double fontSize,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildCustomPaintExampleCard() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Color(0xFF5D4037)),
            SizedBox(width: 8),
            Text(
              'Live CustomPaint Example',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFD7CCC8), width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomPaint(
              size: Size(double.infinity, 100),
              painter: _LiveExamplePainter(),
            ),
          ),
        ),
        SizedBox(height: 8),
        Center(
          child: Text(
            'CustomPainter.paint() draws to Canvas → becomes Picture → PictureLayer',
            style: TextStyle(fontSize: 11, color: Color(0xFF8D6E63)),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

class _LiveExamplePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final random = math.Random(42);

    for (var i = 0; i < 15; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = 10 + random.nextDouble() * 15;
      final hue = random.nextDouble() * 60 + 15;

      final paint = Paint()
        ..color = HSVColor.fromAHSV(1, hue, 0.6, 0.8).toColor().withAlpha(150)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x, y), radius, paint);

      final borderPaint = Paint()
        ..color = Color(0xFF5D4037).withAlpha(100)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;
      canvas.drawCircle(Offset(x, y), radius, borderPaint);
    }

    final linePaint = Paint()
      ..color = Color(0xFF5D4037).withAlpha(80)
      ..strokeWidth = 1;
    for (var i = 0; i < 8; i++) {
      final x1 = random.nextDouble() * size.width;
      final y1 = random.nextDouble() * size.height;
      final x2 = random.nextDouble() * size.width;
      final y2 = random.nextDouble() * size.height;
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: PICTURERECORDER AND CANVAS BASICS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildRecorderSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.fiber_manual_record, color: Colors.red),
            SizedBox(width: 8),
            Text(
              'PictureRecorder Workflow',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: CustomPaint(
            size: Size(double.infinity, 160),
            painter: _RecorderWorkflowPainter(),
          ),
        ),
      ],
    ),
  );
}

class _RecorderWorkflowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;

    final recorderRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(centerX - 80, 10, 160, 35),
      Radius.circular(8),
    );
    final recorderPaint = Paint()..color = Color(0xFFEF5350);
    canvas.drawRRect(recorderRect, recorderPaint);
    _drawText(canvas, 'PictureRecorder()', Offset(centerX, 27), Colors.white, 12);

    final recIconPaint = Paint()..color = Colors.white;
    canvas.drawCircle(Offset(centerX - 60, 27), 5, recIconPaint);

    _drawArrowDown(canvas, Offset(centerX, 50), 20);
    _drawText(canvas, 'new', Offset(centerX + 25, 55), Color(0xFF8D6E63), 10);

    final canvasRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(centerX - 80, 75, 160, 35),
      Radius.circular(8),
    );
    final canvasPaint = Paint()..color = Color(0xFF42A5F5);
    canvas.drawRRect(canvasRect, canvasPaint);
    _drawText(canvas, 'Canvas(recorder)', Offset(centerX, 92), Colors.white, 12);

    final brushPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(centerX - 55, 87),
      Offset(centerX - 65, 97),
      brushPaint,
    );

    _drawArrowDown(canvas, Offset(centerX, 115), 20);
    _drawText(canvas, 'draw...', Offset(centerX + 30, 120), Color(0xFF8D6E63), 10);

    final pictureRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(centerX - 80, 140, 160, 35),
      Radius.circular(8),
    );
    final picturePaint = Paint()..color = Color(0xFF66BB6A);
    canvas.drawRRect(pictureRect, picturePaint);
    _drawText(canvas, 'endRecording() → Picture', Offset(centerX, 157), Colors.white, 11);

    final sideCmds = [
      {'x': 30.0, 'y': 45.0, 'cmd': 'drawRect()'},
      {'x': 30.0, 'y': 65.0, 'cmd': 'drawCircle()'},
      {'x': 30.0, 'y': 85.0, 'cmd': 'drawPath()'},
      {'x': 30.0, 'y': 105.0, 'cmd': 'drawLine()'},
    ];

    for (var cmd in sideCmds) {
      final xPos = cmd['x'] as double;
      final yPos = cmd['y'] as double;
      final cmdText = cmd['cmd'] as String;
      _drawText(canvas, cmdText, Offset(xPos, yPos), Color(0xFF795548), 10);

      final linePaint = Paint()
        ..color = Color(0xFFBCAAA4)
        ..strokeWidth = 1
        ..style = PaintingStyle.stroke;
      final dashPath = Path()
        ..moveTo(xPos + 45, yPos)
        ..lineTo(centerX - 85, 92);
      canvas.drawPath(dashPath, linePaint);
    }
  }

  void _drawArrowDown(Canvas canvas, Offset start, double length) {
    final paint = Paint()
      ..color = Color(0xFF8D6E63)
      ..strokeWidth = 2;
    canvas.drawLine(start, Offset(start.dx, start.dy + length), paint);

    final headPaint = Paint()
      ..color = Color(0xFF8D6E63)
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(start.dx - 4, start.dy + length - 5)
      ..lineTo(start.dx, start.dy + length)
      ..lineTo(start.dx + 4, start.dy + length - 5)
      ..close();
    canvas.drawPath(path, headPaint);
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset center,
    Color color,
    double fontSize,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildCanvasOperationsCard() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.palette, color: Color(0xFF5D4037)),
            SizedBox(width: 8),
            Text(
              'Canvas Drawing Operations',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: CustomPaint(
            size: Size(double.infinity, 120),
            painter: _CanvasOperationsPainter(),
          ),
        ),
      ],
    ),
  );
}

class _CanvasOperationsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final operations = <Map<String, dynamic>>[
      {
        'name': 'drawRect',
        'draw': (Canvas c, Offset center) {
          final paint = Paint()
            ..color = Color(0xFFEF5350)
            ..style = PaintingStyle.fill;
          c.drawRect(
            Rect.fromCenter(center: center, width: 35, height: 25),
            paint,
          );
        },
      },
      {
        'name': 'drawCircle',
        'draw': (Canvas c, Offset center) {
          final paint = Paint()
            ..color = Color(0xFF42A5F5)
            ..style = PaintingStyle.fill;
          c.drawCircle(center, 18, paint);
        },
      },
      {
        'name': 'drawOval',
        'draw': (Canvas c, Offset center) {
          final paint = Paint()
            ..color = Color(0xFF66BB6A)
            ..style = PaintingStyle.fill;
          c.drawOval(
            Rect.fromCenter(center: center, width: 40, height: 25),
            paint,
          );
        },
      },
      {
        'name': 'drawPath',
        'draw': (Canvas c, Offset center) {
          final paint = Paint()
            ..color = Color(0xFFFF9800)
            ..style = PaintingStyle.fill;
          final path = Path()
            ..moveTo(center.dx, center.dy - 18)
            ..lineTo(center.dx + 18, center.dy + 12)
            ..lineTo(center.dx - 18, center.dy + 12)
            ..close();
          c.drawPath(path, paint);
        },
      },
      {
        'name': 'drawLine',
        'draw': (Canvas c, Offset center) {
          final paint = Paint()
            ..color = Color(0xFF9C27B0)
            ..strokeWidth = 4
            ..strokeCap = StrokeCap.round;
          c.drawLine(
            Offset(center.dx - 18, center.dy - 10),
            Offset(center.dx + 18, center.dy + 10),
            paint,
          );
          c.drawLine(
            Offset(center.dx - 18, center.dy + 10),
            Offset(center.dx + 18, center.dy - 10),
            paint,
          );
        },
      },
    ];

    final cellW = size.width / operations.length;
    final cellH = size.height;

    for (var i = 0; i < operations.length; i++) {
      final center = Offset(cellW * i + cellW / 2, cellH / 2 - 15);
      final op = operations[i];
      (op['draw'] as Function)(canvas, center);

      _drawLabel(canvas, op['name'] as String, Offset(center.dx, cellH - 12));
    }
  }

  void _drawLabel(Canvas canvas, String text, Offset pos) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: Color(0xFF5D4037),
          fontSize: 10,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(pos.dx - tp.width / 2, pos.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 3: PICTURELAYER IN THE LAYER TREE CONCEPT
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildLayerTreeSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.account_tree, color: Color(0xFF5D4037)),
            SizedBox(width: 8),
            Text(
              'Layer Tree Hierarchy',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: CustomPaint(
            size: Size(double.infinity, 200),
            painter: _LayerTreePainter(),
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFEFEBE9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'PictureLayer is a leaf layer - it has no children.\n'
            'It only holds a Picture containing drawing commands.\n'
            'Parent ContainerLayer manages compositing order.',
            style: TextStyle(fontSize: 11, color: Color(0xFF6D4C41)),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

class _LayerTreePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;

    final rootNode = _TreeNode(
      'ContainerLayer\n(root)',
      Offset(centerX, 30),
      Color(0xFF5D4037),
      [],
    );

    final transformNode = _TreeNode(
      'TransformLayer',
      Offset(centerX - 80, 85),
      Color(0xFF795548),
      [],
    );

    final offsetNode = _TreeNode(
      'OffsetLayer',
      Offset(centerX + 80, 85),
      Color(0xFF795548),
      [],
    );

    final pictureNode1 = _TreeNode(
      'PictureLayer',
      Offset(centerX - 120, 145),
      Color(0xFFFF7043),
      [],
    );

    final pictureNode2 = _TreeNode(
      'PictureLayer',
      Offset(centerX - 40, 145),
      Color(0xFFFF7043),
      [],
    );

    final pictureNode3 = _TreeNode(
      'PictureLayer',
      Offset(centerX + 80, 145),
      Color(0xFFFF7043),
      [],
    );

    _drawConnection(canvas, rootNode.position, transformNode.position);
    _drawConnection(canvas, rootNode.position, offsetNode.position);
    _drawConnection(canvas, transformNode.position, pictureNode1.position);
    _drawConnection(canvas, transformNode.position, pictureNode2.position);
    _drawConnection(canvas, offsetNode.position, pictureNode3.position);

    for (var node in [rootNode, transformNode, offsetNode, pictureNode1, pictureNode2, pictureNode3]) {
      _drawNode(canvas, node);
    }

    final labelPaint = Paint()
      ..color = Color(0xFFFFE0B2)
      ..style = PaintingStyle.fill;
    final labelRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width - 90, 10, 80, 60),
      Radius.circular(6),
    );
    canvas.drawRRect(labelRect, labelPaint);

    final borderPaint = Paint()
      ..color = Color(0xFFFF7043)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRRect(labelRect, borderPaint);

    _drawText(canvas, 'Legend:', Offset(size.width - 50, 22), Color(0xFF5D4037), 10);
    
    canvas.drawCircle(Offset(size.width - 78, 40), 4, Paint()..color = Color(0xFFFF7043));
    _drawTextLeft(canvas, 'PictureLayer', Offset(size.width - 70, 40), Color(0xFF5D4037), 9);
    
    canvas.drawCircle(Offset(size.width - 78, 55), 4, Paint()..color = Color(0xFF795548));
    _drawTextLeft(canvas, 'Container', Offset(size.width - 70, 55), Color(0xFF5D4037), 9);
  }

  void _drawNode(Canvas canvas, _TreeNode node) {
    final nodeWidth = 75.0;
    final nodeHeight = 30.0;
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: node.position, width: nodeWidth, height: nodeHeight),
      Radius.circular(6),
    );

    final fillPaint = Paint()..color = node.color;
    canvas.drawRRect(rect, fillPaint);

    final borderPaint = Paint()
      ..color = Color(0xFF3E2723)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRRect(rect, borderPaint);

    _drawText(canvas, node.label, node.position, Colors.white, 9);
  }

  void _drawConnection(Canvas canvas, Offset from, Offset to) {
    final paint = Paint()
      ..color = Color(0xFFBCAAA4)
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(from.dx, from.dy + 15),
      Offset(to.dx, to.dy - 15),
      paint,
    );
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset center,
    Color color,
    double fontSize,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  void _drawTextLeft(
    Canvas canvas,
    String text,
    Offset pos,
    Color color,
    double fontSize,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(pos.dx, pos.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _TreeNode {
  _TreeNode(this.label, this.position, this.color, this.children);
  
  final String label;
  final Offset position;
  final Color color;
  final List<_TreeNode> children;
}

Widget _buildLayerLifecycleCard() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.loop, color: Color(0xFF5D4037)),
            SizedBox(width: 8),
            Text(
              'PictureLayer Lifecycle',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildInfoRow('Creation', 'PictureLayer(canvasBounds)'),
        _buildInfoRow('Assignment', 'layer.picture = recordedPicture'),
        _buildInfoRow('Attachment', 'parentLayer.append(pictureLayer)'),
        _buildInfoRow('Painting', 'Compositor includes in scene'),
        _buildInfoRow('Disposal', 'layer.dispose() releases Picture'),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 4: PICTURE PROPERTY VISUALIZATION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildPicturePropertySection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.image, color: Color(0xFF5D4037)),
            SizedBox(width: 8),
            Text(
              'Picture Property',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 150,
          child: CustomPaint(
            size: Size(double.infinity, 150),
            painter: _PicturePropertyPainter(),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color(0xFFEFEBE9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow('Type', 'ui.Picture?'),
              _buildInfoRow('Purpose', 'Contains recorded drawing commands'),
              _buildInfoRow('Setter', 'Assigns picture and marks layer dirty'),
              _buildInfoRow('Memory', 'Picture is GPU-backed resource'),
            ],
          ),
        ),
      ],
    ),
  );
}

class _PicturePropertyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final leftX = size.width * 0.25;
    final rightX = size.width * 0.75;
    final midY = size.height / 2;

    final layerRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(leftX, midY), width: 100, height: 70),
      Radius.circular(12),
    );
    final layerPaint = Paint()..color = Color(0xFF5D4037);
    canvas.drawRRect(layerRect, layerPaint);
    _drawText(canvas, 'PictureLayer', Offset(leftX, midY - 15), Colors.white, 11);
    _drawText(canvas, '.picture', Offset(leftX, midY + 5), Colors.white.withAlpha(200), 10);

    final arrowPaint = Paint()
      ..color = Color(0xFF8D6E63)
      ..strokeWidth = 3;
    canvas.drawLine(Offset(leftX + 55, midY), Offset(rightX - 55, midY), arrowPaint);

    final headPaint = Paint()
      ..color = Color(0xFF8D6E63)
      ..style = PaintingStyle.fill;
    final arrowPath = Path()
      ..moveTo(rightX - 60, midY - 6)
      ..lineTo(rightX - 50, midY)
      ..lineTo(rightX - 60, midY + 6)
      ..close();
    canvas.drawPath(arrowPath, headPaint);

    _drawText(canvas, 'getter/setter', Offset((leftX + rightX) / 2, midY - 15), Color(0xFF8D6E63), 10);

    final pictureRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(rightX, midY), width: 100, height: 70),
      Radius.circular(12),
    );
    final picturePaint = Paint()..color = Color(0xFF66BB6A);
    canvas.drawRRect(pictureRect, picturePaint);
    _drawText(canvas, 'ui.Picture', Offset(rightX, midY - 10), Colors.white, 11);

    final random = math.Random(123);
    for (var i = 0; i < 5; i++) {
      final x = rightX - 30 + random.nextDouble() * 60;
      final y = midY + 5 + random.nextDouble() * 20;
      final r = 3 + random.nextDouble() * 4;
      final dotPaint = Paint()..color = Colors.white.withAlpha(150);
      canvas.drawCircle(Offset(x, y), r, dotPaint);
    }

    _drawText(canvas, '(drawing commands)', Offset(rightX, size.height - 15), Color(0xFF6D4C41), 10);
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset center,
    Color color,
    double fontSize,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildCanvasBoundsCard() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.crop, color: Color(0xFF5D4037)),
            SizedBox(width: 8),
            Text(
              'canvasBounds Property',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: CustomPaint(
            size: Size(double.infinity, 120),
            painter: _CanvasBoundsPainter(),
          ),
        ),
        SizedBox(height: 8),
        Center(
          child: Text(
            'canvasBounds defines the area where Picture can draw',
            style: TextStyle(fontSize: 11, color: Color(0xFF8D6E63)),
          ),
        ),
      ],
    ),
  );
}

class _CanvasBoundsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    
    final screenRect = Rect.fromCenter(
      center: Offset(centerX, centerY),
      width: size.width - 40,
      height: size.height - 20,
    );
    final screenPaint = Paint()
      ..color = Color(0xFFEEEEEE)
      ..style = PaintingStyle.fill;
    canvas.drawRect(screenRect, screenPaint);

    final boundsRect = Rect.fromCenter(
      center: Offset(centerX, centerY),
      width: 150,
      height: 80,
    );

    final boundsPaint = Paint()
      ..color = Color(0xFF5D4037).withAlpha(30)
      ..style = PaintingStyle.fill;
    canvas.drawRect(boundsRect, boundsPaint);

    final boundsStroke = Paint()
      ..color = Color(0xFF5D4037)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(boundsRect, boundsStroke);

    final random = math.Random(555);
    for (var i = 0; i < 8; i++) {
      final x = boundsRect.left + 10 + random.nextDouble() * (boundsRect.width - 20);
      final y = boundsRect.top + 10 + random.nextDouble() * (boundsRect.height - 20);
      final r = 5 + random.nextDouble() * 10;
      final shapePaint = Paint()
        ..color = Color(0xFFFF7043).withAlpha(180)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x, y), r, shapePaint);
    }

    _drawDimLine(canvas, boundsRect.topLeft, boundsRect.topRight, '200px');
    _drawDimLine(canvas, boundsRect.topRight, boundsRect.bottomRight, '100px', vertical: true);

    _drawText(canvas, 'canvasBounds', Offset(centerX, boundsRect.bottom + 15), Color(0xFF5D4037), 10);
  }

  void _drawDimLine(Canvas canvas, Offset start, Offset end, String label, {bool vertical = false}) {
    final paint = Paint()
      ..color = Color(0xFF8D6E63)
      ..strokeWidth = 1;

    if (vertical) {
      final x = start.dx + 10;
      canvas.drawLine(Offset(x, start.dy), Offset(x, end.dy), paint);
      canvas.drawLine(Offset(x - 3, start.dy), Offset(x + 3, start.dy), paint);
      canvas.drawLine(Offset(x - 3, end.dy), Offset(x + 3, end.dy), paint);
      _drawText(canvas, label, Offset(x + 15, (start.dy + end.dy) / 2), Color(0xFF8D6E63), 9);
    } else {
      final y = start.dy - 10;
      canvas.drawLine(Offset(start.dx, y), Offset(end.dx, y), paint);
      canvas.drawLine(Offset(start.dx, y - 3), Offset(start.dx, y + 3), paint);
      canvas.drawLine(Offset(end.dx, y - 3), Offset(end.dx, y + 3), paint);
      _drawText(canvas, label, Offset((start.dx + end.dx) / 2, y - 8), Color(0xFF8D6E63), 9);
    }
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset center,
    Color color,
    double fontSize,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: ISCOMPLEXHINT AND WILLCHANGEHINT FLAGS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHintsSection() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb_outline, color: Color(0xFF5D4037)),
            SizedBox(width: 8),
            Text(
              'Performance Hint Flags',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: CustomPaint(
            size: Size(double.infinity, 180),
            painter: _HintFlagsPainter(),
          ),
        ),
      ],
    ),
  );
}

class _HintFlagsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final leftX = size.width * 0.25;
    final rightX = size.width * 0.75;
    final topY = 50.0;
    final bottomY = 130.0;

    _drawHintBox(
      canvas,
      Offset(leftX, topY),
      'isComplexHint',
      'true',
      Color(0xFF66BB6A),
      'Cache: Complex to re-draw',
    );

    _drawHintBox(
      canvas,
      Offset(rightX, topY),
      'isComplexHint',
      'false',
      Color(0xFFEF5350),
      'Skip cache: Simple to draw',
    );

    _drawHintBox(
      canvas,
      Offset(leftX, bottomY),
      'willChangeHint',
      'true',
      Color(0xFFEF5350),
      'Avoid cache: Will change soon',
    );

    _drawHintBox(
      canvas,
      Offset(rightX, bottomY),
      'willChangeHint',
      'false',
      Color(0xFF66BB6A),
      'Cache OK: Stable content',
    );

    _drawText(canvas, 'Raster Cache Optimization', Offset(size.width / 2, 15), Color(0xFF5D4037), 12);
  }

  void _drawHintBox(
    Canvas canvas,
    Offset center,
    String property,
    String value,
    Color valueColor,
    String description,
  ) {
    final boxWidth = 130.0;
    final boxHeight = 55.0;
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: boxWidth, height: boxHeight),
      Radius.circular(8),
    );

    final bgPaint = Paint()..color = Color(0xFFFAFAFA);
    canvas.drawRRect(rect, bgPaint);

    final borderPaint = Paint()
      ..color = valueColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(rect, borderPaint);

    _drawText(canvas, property, Offset(center.dx, center.dy - 15), Color(0xFF5D4037), 10);

    final valueBgRect = Rect.fromCenter(
      center: Offset(center.dx, center.dy + 2),
      width: 40,
      height: 16,
    );
    final valueBgPaint = Paint()..color = valueColor;
    canvas.drawRRect(
      RRect.fromRectAndRadius(valueBgRect, Radius.circular(4)),
      valueBgPaint,
    );
    _drawText(canvas, value, Offset(center.dx, center.dy + 2), Colors.white, 9);

    _drawText(canvas, description, Offset(center.dx, center.dy + 22), Color(0xFF8D6E63), 8);
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset center,
    Color color,
    double fontSize,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildHintComparisonCard() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare_arrows, color: Color(0xFF5D4037)),
            SizedBox(width: 8),
            Text(
              'Hint Flag Combinations',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 140,
          child: CustomPaint(
            size: Size(double.infinity, 140),
            painter: _HintCombinationsPainter(),
          ),
        ),
      ],
    ),
  );
}

class _HintCombinationsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final combinations = <Map<String, dynamic>>[
      {
        'complex': true,
        'willChange': false,
        'result': 'CACHE',
        'color': Color(0xFF66BB6A),
        'desc': 'Best for\nstatic art',
      },
      {
        'complex': true,
        'willChange': true,
        'result': 'SKIP',
        'color': Color(0xFFFF9800),
        'desc': 'Complex but\nanimating',
      },
      {
        'complex': false,
        'willChange': false,
        'result': 'SKIP',
        'color': Color(0xFF42A5F5),
        'desc': 'Simple\nshapes',
      },
      {
        'complex': false,
        'willChange': true,
        'result': 'SKIP',
        'color': Color(0xFFEF5350),
        'desc': 'Simple &\nchanging',
      },
    ];

    final cellW = size.width / 4;
    final cellH = size.height;

    for (var i = 0; i < combinations.length; i++) {
      final combo = combinations[i];
      final centerX = cellW * i + cellW / 2;

      final boxRect = RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset(centerX, cellH / 2), width: 70, height: 100),
        Radius.circular(10),
      );
      final bgPaint = Paint()..color = (combo['color'] as Color).withAlpha(30);
      canvas.drawRRect(boxRect, bgPaint);

      final borderPaint = Paint()
        ..color = combo['color'] as Color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRRect(boxRect, borderPaint);

      final complexTxt = (combo['complex'] as bool) ? 'C: ✓' : 'C: ✗';
      final willTxt = (combo['willChange'] as bool) ? 'W: ✓' : 'W: ✗';
      _drawText(canvas, complexTxt, Offset(centerX, cellH / 2 - 30), Color(0xFF5D4037), 10);
      _drawText(canvas, willTxt, Offset(centerX, cellH / 2 - 15), Color(0xFF5D4037), 10);

      final resultBgRect = Rect.fromCenter(
        center: Offset(centerX, cellH / 2 + 5),
        width: 50,
        height: 18,
      );
      final resultBg = Paint()..color = combo['color'] as Color;
      canvas.drawRRect(
        RRect.fromRectAndRadius(resultBgRect, Radius.circular(4)),
        resultBg,
      );
      _drawText(canvas, combo['result'] as String, Offset(centerX, cellH / 2 + 5), Colors.white, 10);

      _drawText(canvas, combo['desc'] as String, Offset(centerX, cellH / 2 + 32), Color(0xFF8D6E63), 8);
    }
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset center,
    Color color,
    double fontSize,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildRasterCacheExplanationCard() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.memory, color: Color(0xFF5D4037)),
            SizedBox(width: 8),
            Text(
              'Raster Cache Mechanism',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFEFEBE9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRasterStep('1', 'Engine checks isComplexHint'),
              _buildRasterStep('2', 'If complex & !willChange → cache candidate'),
              _buildRasterStep('3', 'Picture rasterized to GPU texture'),
              _buildRasterStep('4', 'Future frames blit cached texture'),
              _buildRasterStep('5', 'Cache invalidated when picture changes'),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildRasterStep(String step, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: Color(0xFF5D4037),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              step,
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 12, color: Color(0xFF6D4C41)),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// ADDITIONAL DEMO CARDS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildPictureLayerApiCard() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.api, color: Color(0xFF5D4037)),
            SizedBox(width: 8),
            Text(
              'PictureLayer API Reference',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildApiEntry('Constructor', 'PictureLayer(Rect canvasBounds)'),
        Divider(color: Color(0xFFD7CCC8)),
        _buildApiEntry('picture', 'ui.Picture? - Drawing commands'),
        _buildApiEntry('canvasBounds', 'Rect - Area for drawing'),
        _buildApiEntry('isComplexHint', 'bool - Complexity hint'),
        _buildApiEntry('willChangeHint', 'bool - Change hint'),
        Divider(color: Color(0xFFD7CCC8)),
        _buildApiEntry('findAnnotations', 'Find annotations at offset'),
        _buildApiEntry('dispose', 'Release resources'),
      ],
    ),
  );
}

Widget _buildApiEntry(String name, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Color(0xFFEFEBE9),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            name,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Color(0xFF5D4037),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 11, color: Color(0xFF6D4C41)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildUseCasesCard() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.apps, color: Color(0xFF5D4037)),
            SizedBox(width: 8),
            Text(
              'Common Use Cases',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 100,
          child: CustomPaint(
            size: Size(double.infinity, 100),
            painter: _UseCasesPainter(),
          ),
        ),
      ],
    ),
  );
}

class _UseCasesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final useCases = <Map<String, dynamic>>[
      {'icon': Icons.brush, 'label': 'Custom\nPainting'},
      {'icon': Icons.show_chart, 'label': 'Charts &\nGraphs'},
      {'icon': Icons.map, 'label': 'Map\nRendering'},
      {'icon': Icons.gamepad, 'label': 'Game\nGraphics'},
      {'icon': Icons.draw, 'label': 'Drawing\nApps'},
    ];

    final cellW = size.width / useCases.length;
    final cellH = size.height;

    for (var i = 0; i < useCases.length; i++) {
      final centerX = cellW * i + cellW / 2;
      final useCase = useCases[i];

      final circlePaint = Paint()
        ..color = Color(0xFF8D6E63).withAlpha(40)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(centerX, cellH / 2 - 15), 25, circlePaint);

      final iconPainter = TextPainter(
        text: TextSpan(
          text: String.fromCharCode((useCase['icon'] as IconData).codePoint),
          style: TextStyle(
            fontSize: 24,
            fontFamily: 'MaterialIcons',
            color: Color(0xFF5D4037),
          ),
        ),
        textDirection: ui.TextDirection.ltr,
      );
      iconPainter.layout();
      iconPainter.paint(
        canvas,
        Offset(centerX - iconPainter.width / 2, cellH / 2 - 15 - iconPainter.height / 2),
      );

      _drawText(canvas, useCase['label'] as String, Offset(centerX, cellH - 15), Color(0xFF6D4C41), 10);
    }
  }

  void _drawText(
    Canvas canvas,
    String text,
    Offset center,
    Color color,
    double fontSize,
  ) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildPerformanceTipsCard() {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(15),
          blurRadius: 12,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.speed, color: Color(0xFF5D4037)),
            SizedBox(width: 8),
            Text(
              'Performance Tips',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5D4037),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        _buildTipItem(Icons.check_circle, 'Set isComplexHint=true for intricate drawings'),
        _buildTipItem(Icons.check_circle, 'Set willChangeHint=false for static content'),
        _buildTipItem(Icons.check_circle, 'Minimize canvasBounds to actual content area'),
        _buildTipItem(Icons.check_circle, 'Dispose layers when no longer visible'),
        _buildTipItem(Icons.warning, 'Avoid large pictures that exceed GPU texture limits'),
        _buildTipItem(Icons.warning, 'Dont cache rapidly animating content'),
      ],
    ),
  );
}

Widget _buildTipItem(IconData icon, String text) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 16,
          color: icon == Icons.check_circle ? Color(0xFF66BB6A) : Color(0xFFFF9800),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Color(0xFF6D4C41)),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('PictureLayer deep demo executing');

  final pictureLayer = PictureLayer(Rect.fromLTWH(0, 0, 200, 150));
  print('Created PictureLayer with canvasBounds: 200x150');

  pictureLayer.isComplexHint = true;
  pictureLayer.willChangeHint = false;
  print('Set isComplexHint=true, willChangeHint=false');

  print('PictureLayer properties:');
  print('  - canvasBounds: The area for drawing');
  print('  - picture: Holds ui.Picture with draw commands');
  print('  - isComplexHint: ${pictureLayer.isComplexHint}');
  print('  - willChangeHint: ${pictureLayer.willChangeHint}');

  print('\nPictureRecorder workflow:');
  print('  1. Create PictureRecorder');
  print('  2. Create Canvas(recorder)');
  print('  3. Draw to canvas');
  print('  4. Call endRecording() to get Picture');

  print('\nPictureLayer deep demo completed');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(
          'PictureLayer',
          'Layer that displays recorded drawing commands',
        ),
        SizedBox(height: 20),

        _buildSectionTitle('CustomPaint Entry Point', Icons.brush),
        _buildCustomPaintSection(),
        SizedBox(height: 12),
        _buildCustomPaintExampleCard(),
        SizedBox(height: 20),

        _buildSectionTitle('PictureRecorder & Canvas', Icons.fiber_manual_record),
        _buildRecorderSection(),
        SizedBox(height: 12),
        _buildCanvasOperationsCard(),
        SizedBox(height: 20),

        _buildSectionTitle('Layer Tree Structure', Icons.account_tree),
        _buildLayerTreeSection(),
        SizedBox(height: 12),
        _buildLayerLifecycleCard(),
        SizedBox(height: 20),

        _buildSectionTitle('Picture Property', Icons.image),
        _buildPicturePropertySection(),
        SizedBox(height: 12),
        _buildCanvasBoundsCard(),
        SizedBox(height: 20),

        _buildSectionTitle('Performance Hints', Icons.lightbulb_outline),
        _buildHintsSection(),
        SizedBox(height: 12),
        _buildHintComparisonCard(),
        SizedBox(height: 12),
        _buildRasterCacheExplanationCard(),
        SizedBox(height: 20),

        _buildSectionTitle('API & Usage', Icons.api),
        _buildPictureLayerApiCard(),
        SizedBox(height: 12),
        _buildUseCasesCard(),
        SizedBox(height: 12),
        _buildPerformanceTipsCard(),
        SizedBox(height: 20),

        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFEFEBE9),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF66BB6A), size: 32),
              SizedBox(height: 8),
              Text(
                'PictureLayer Deep Demo Complete',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5D4037),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Explored CustomPaint flow, PictureRecorder, layer tree,\n'
                'picture property, and performance hint flags.',
                style: TextStyle(fontSize: 11, color: Color(0xFF8D6E63)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );
}
