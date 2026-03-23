// D4rt test script: Deep demo for PictureLayer from rendering
//
// PictureLayer is a compositing layer that displays a Picture object.
// The Picture contains recorded drawing commands from a PictureRecorder.
//
// Key properties:
//   - picture: The Picture containing drawing commands to display
//   - canvasBounds: Optional bounds limiting where the picture can draw
//   - isComplexHint: Hints that the picture is complex (enables raster caching)
//   - willChangeHint: Hints that the picture will change soon (disables caching)
//
// Related classes:
//   - Picture: Immutable collection of recorded drawing commands
//   - PictureRecorder: Records Canvas operations to produce a Picture
//   - Canvas: Drawing surface connected to PictureRecorder
//   - ContainerLayer: Parent class managing child layers
//   - OffsetLayer: Layer with an offset transformation
//
// Use cases:
//   - Custom painting via RenderCustomPaint
//   - Pre-recorded drawing command playback
//   - Performance optimization with raster caching
//   - Layer compositing in custom render objects
//
// This demo visualizes PictureLayer properties, hints, and composition.

import 'dart:ui' as ui;
import 'dart:math' as math;
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Color(0xFF6A1B9A).withAlpha(100),
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
            color: Color(0xFFAB47BC).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Color(0xFF6A1B9A), size: 20),
        ),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF6A1B9A),
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
          width: 130,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFF6A1B9A),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? Color(0xFF8E24AA),
              fontSize: 13,
            ),
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 1: PICTURELAYER OVERVIEW
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildPictureLayerOverviewSection() {
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
        _buildSectionTitle('PictureLayer Overview', Icons.photo_library),
        Text(
          'PictureLayer is a leaf layer in the compositing tree that displays '
          'a Picture object. Pictures contain pre-recorded drawing commands '
          'that can be replayed efficiently by the rendering engine.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Text(
                'PictureLayer Creation Flow',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4A148C),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(
                height: 160,
                child: CustomPaint(
                  size: Size(double.infinity, 160),
                  painter: _PictureLayerFlowPainter(),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, color: Color(0xFF6A1B9A), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Key Characteristics',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6A1B9A),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              _buildInfoRow('Layer Type', 'Leaf layer (no children)'),
              _buildInfoRow('Content', 'Displays a Picture object'),
              _buildInfoRow('Bounds', 'canvasBounds defines draw area'),
              _buildInfoRow('Caching', 'Can be rasterized for performance'),
              _buildInfoRow('Lifecycle', 'Disposes Picture when removed'),
            ],
          ),
        ),
      ],
    ),
  );
}

class _PictureLayerFlowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var steps = <Map<String, dynamic>>[
      {'label': 'PictureRecorder()', 'color': Color(0xFF7B1FA2)},
      {'label': 'Canvas(recorder)', 'color': Color(0xFF8E24AA)},
      {'label': 'canvas.draw*()', 'color': Color(0xFF9C27B0)},
      {'label': 'endRecording()', 'color': Color(0xFFAB47BC)},
      {'label': 'PictureLayer', 'color': Color(0xFF6A1B9A)},
    ];

    var boxWidth = 68.0;
    var boxHeight = 45.0;
    var spacing = (size.width - steps.length * boxWidth) / (steps.length + 1);
    var y = 40.0;

    for (var i = 0; i < steps.length; i++) {
      var x = spacing + i * (boxWidth + spacing);
      var rect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, boxWidth, boxHeight),
        Radius.circular(8),
      );

      var fillPaint = Paint()
        ..color = steps[i]['color'] as Color
        ..style = PaintingStyle.fill;
      canvas.drawRRect(rect, fillPaint);

      var borderPaint = Paint()
        ..color = Color(0xFF4A148C)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2;
      canvas.drawRRect(rect, borderPaint);

      _drawCenteredText(
        canvas,
        steps[i]['label'] as String,
        Offset(x + boxWidth / 2, y + boxHeight / 2),
        Colors.white,
        9,
      );

      if (i < steps.length - 1) {
        var arrowStart = Offset(x + boxWidth + 4, y + boxHeight / 2);
        var arrowEnd = Offset(x + boxWidth + spacing - 4, y + boxHeight / 2);
        _drawArrowLine(canvas, arrowStart, arrowEnd, Color(0xFF9C27B0));
      }
    }

    _drawCenteredText(
      canvas,
      'Recording → Picture → Layer',
      Offset(size.width / 2, y + boxHeight + 35),
      Color(0xFF6A1B9A),
      12,
    );

    var boxPaint = Paint()
      ..color = Color(0xFFE1BEE7)
      ..style = PaintingStyle.fill;
    var topRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(size.width / 2 - 70, 5, 140, 25),
      Radius.circular(5),
    );
    canvas.drawRRect(topRect, boxPaint);
    _drawCenteredText(
      canvas,
      'Picture Recording Pipeline',
      Offset(size.width / 2, 17),
      Color(0xFF4A148C),
      10,
    );
  }

  void _drawArrowLine(Canvas canvas, Offset start, Offset end, Color color) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(start, end, paint);

    var headPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    var path = Path()
      ..moveTo(end.dx - 5, end.dy - 4)
      ..lineTo(end.dx, end.dy)
      ..lineTo(end.dx - 5, end.dy + 4)
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
    var tp = TextPainter(
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

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 2: PICTURE PROPERTY VISUALIZATION
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
        _buildSectionTitle('Picture Property', Icons.image),
        Text(
          'The picture property holds an immutable Picture object containing '
          'recorded drawing commands. When set, the previous picture is '
          'disposed and the layer is marked for repainting.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          height: 150,
          decoration: BoxDecoration(
            color: Color(0xFFFAFAFA),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Color(0xFFE1BEE7), width: 2),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CustomPaint(
              size: Size(double.infinity, 150),
              painter: _PictureContentVisualizerPainter(),
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.code, color: Color(0xFF6A1B9A), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Picture Object Properties',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6A1B9A),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              _buildInfoRow('Type', 'ui.Picture (dart:ui)'),
              _buildInfoRow('Immutable', 'Cannot be modified after creation'),
              _buildInfoRow('Disposal', 'Must call dispose() when done'),
              _buildInfoRow('Approximation', 'approximateBytesUsed available'),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildPropertyCard('Set Picture', 'Dispose old picture\nMark needs paint', Icons.upload, Color(0xFF7B1FA2))),
            SizedBox(width: 12),
            Expanded(child: _buildPropertyCard('Get Picture', 'Returns current\nPicture reference', Icons.download, Color(0xFF8E24AA))),
          ],
        ),
      ],
    ),
  );
}

Widget _buildPropertyCard(String title, String description, IconData icon, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Column(
      children: [
        Icon(icon, color: color, size: 24),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
            fontSize: 13,
          ),
        ),
        SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(fontSize: 11, color: Color(0xFF546E7A)),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

class _PictureContentVisualizerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var rng = math.Random(123);

    var backgroundPaint = Paint()
      ..color = Color(0xFFFCE4EC)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    for (var i = 0; i < 12; i++) {
      var x = rng.nextDouble() * size.width;
      var y = rng.nextDouble() * size.height;
      var radius = 8 + rng.nextDouble() * 20;
      var hue = 270 + rng.nextDouble() * 60;

      var circlePaint = Paint()
        ..color = HSVColor.fromAHSV(1, hue, 0.5, 0.8).toColor().withAlpha(160)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x, y), radius, circlePaint);
    }

    for (var i = 0; i < 6; i++) {
      var x = rng.nextDouble() * (size.width - 40);
      var y = rng.nextDouble() * (size.height - 30);
      var w = 20 + rng.nextDouble() * 30;
      var h = 15 + rng.nextDouble() * 20;

      var rectPaint = Paint()
        ..color = Color(0xFF9C27B0).withAlpha(100)
        ..style = PaintingStyle.fill;
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(x, y, w, h), Radius.circular(4)),
        rectPaint,
      );
    }

    var linePaint = Paint()
      ..color = Color(0xFF6A1B9A).withAlpha(80)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    for (var i = 0; i < 5; i++) {
      var path = Path()
        ..moveTo(rng.nextDouble() * size.width, rng.nextDouble() * size.height)
        ..quadraticBezierTo(
          rng.nextDouble() * size.width,
          rng.nextDouble() * size.height,
          rng.nextDouble() * size.width,
          rng.nextDouble() * size.height,
        );
      canvas.drawPath(path, linePaint);
    }

    var labelPaint = Paint()
      ..color = Color(0xFF4A148C).withAlpha(200)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width / 2 - 60, size.height - 25, 120, 20),
        Radius.circular(4),
      ),
      labelPaint,
    );
    _drawLabel(canvas, 'Picture Contents', Offset(size.width / 2, size.height - 15), Colors.white);
  }

  void _drawLabel(Canvas canvas, String text, Offset center, Color color) {
    var tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
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
// SECTION 3: ISCOMPLEXHINT VISUALIZATION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildIsComplexHintSection() {
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
        _buildSectionTitle('isComplexHint Property', Icons.construction),
        Text(
          'The isComplexHint property suggests to the compositor that this '
          'picture is computationally expensive to render. When true, the '
          'engine may cache the rasterized result for improved performance.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildHintComparisonCard(
                'isComplexHint: false',
                'Default behavior',
                [
                  'Re-rasterized each frame',
                  'Lower memory usage',
                  'Good for simple graphics',
                  'No caching overhead',
                ],
                Color(0xFF43A047),
                Icons.speed,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildHintComparisonCard(
                'isComplexHint: true',
                'Enable raster caching',
                [
                  'Cached as texture',
                  'Higher memory usage',
                  'Good for complex paths',
                  'Faster subsequent paints',
                ],
                Color(0xFF6A1B9A),
                Icons.memory,
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.tips_and_updates, color: Color(0xFF2E7D32), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'When to Use isComplexHint',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              _buildUsageRow('Complex paths', 'Many bezier curves or intricate shapes', Color(0xFF388E3C)),
              _buildUsageRow('Heavy shadows', 'Multiple shadow layers or blur effects', Color(0xFF388E3C)),
              _buildUsageRow('Gradients', 'Complex gradient fills across large areas', Color(0xFF388E3C)),
              _buildUsageRow('Text rendering', 'Large amounts of styled text', Color(0xFF388E3C)),
            ],
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: CustomPaint(
            size: Size(double.infinity, 120),
            painter: _ComplexHintDiagramPainter(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildHintComparisonCard(String title, String subtitle, List<String> points, Color color, IconData icon) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 10, color: color.withAlpha(180)),
        ),
        SizedBox(height: 8),
        ...points.map((point) => Padding(
          padding: EdgeInsets.only(bottom: 3),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('• ', style: TextStyle(color: color, fontSize: 10)),
              Expanded(
                child: Text(
                  point,
                  style: TextStyle(fontSize: 10, color: Color(0xFF546E7A)),
                ),
              ),
            ],
          ),
        )),
      ],
    ),
  );
}

Widget _buildUsageRow(String feature, String description, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.check_circle, size: 14, color: color),
        SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$feature: ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    color: Color(0xFF1B5E20),
                  ),
                ),
                TextSpan(
                  text: description,
                  style: TextStyle(fontSize: 11, color: Color(0xFF546E7A)),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _ComplexHintDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var centerY = size.height / 2;
    var sectionWidth = size.width / 4;

    _drawBox(canvas, Offset(sectionWidth * 0.5, centerY), 'Picture',Color(0xFF7B1FA2), 70);
    _drawArrowH(canvas, sectionWidth * 0.5 + 40, sectionWidth * 1.5 - 40, centerY, Color(0xFF9C27B0));
    _drawBox(canvas, Offset(sectionWidth * 1.5, centerY), 'isComplex?', Color(0xFF8E24AA), 70);

    _drawArrowDiag(canvas, sectionWidth * 1.5 + 35, centerY - 15, sectionWidth * 2.5 - 35, centerY - 30, Color(0xFF43A047));
    _drawBox(canvas, Offset(sectionWidth * 2.5, centerY - 30), 'Rasterize', Color(0xFF43A047), 60);

    _drawArrowDiag(canvas, sectionWidth * 1.5 + 35, centerY + 15, sectionWidth * 2.5 - 35, centerY + 30, Color(0xFFF57C00));
    _drawBox(canvas, Offset(sectionWidth * 2.5, centerY + 30), 'No Cache', Color(0xFFF57C00), 60);

    _drawArrowH(canvas, sectionWidth * 2.5 + 35, sectionWidth * 3.5 - 35, centerY - 30, Color(0xFF43A047));
    _drawBox(canvas, Offset(sectionWidth * 3.5, centerY - 30), 'GPU\nTexture', Color(0xFF2E7D32), 60);

    _drawArrowH(canvas, sectionWidth * 2.5 + 35, sectionWidth * 3.5 - 35, centerY + 30, Color(0xFFF57C00));
    _drawBox(canvas, Offset(sectionWidth * 3.5, centerY + 30), 'Direct\nRender', Color(0xFFE65100), 60);

    _drawLabel(canvas, 'true', Offset(sectionWidth * 2, centerY - 25), Color(0xFF43A047));
    _drawLabel(canvas, 'false', Offset(sectionWidth * 2, centerY + 35), Color(0xFFF57C00));
  }

  void _drawBox(Canvas canvas, Offset center, String text, Color color, double width) {
    var rect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: width, height: 35),
      Radius.circular(6),
    );
    var fillPaint = Paint()..color = color.withAlpha(40)..style = PaintingStyle.fill;
    var borderPaint = Paint()..color = color..strokeWidth = 2..style = PaintingStyle.stroke;
    canvas.drawRRect(rect, fillPaint);
    canvas.drawRRect(rect, borderPaint);

    var tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold),
      ),
      textAlign: TextAlign.center,
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout(maxWidth: width - 8);
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height / 2));
  }

  void _drawArrowH(Canvas canvas, double x1, double x2, double y, Color color) {
    var paint = Paint()..color = color..strokeWidth = 2;
    canvas.drawLine(Offset(x1, y), Offset(x2 - 5, y), paint);
    var headPaint = Paint()..color = color..style = PaintingStyle.fill;
    var path = Path()
      ..moveTo(x2 - 8, y - 4)
      ..lineTo(x2, y)
      ..lineTo(x2 - 8, y + 4)
      ..close();
    canvas.drawPath(path, headPaint);
  }

  void _drawArrowDiag(Canvas canvas, double x1, double y1, double x2, double y2, Color color) {
    var paint = Paint()..color = color..strokeWidth = 2;
    canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
    var angle = math.atan2(y2 - y1, x2 - x1);
    var headPaint = Paint()..color = color..style = PaintingStyle.fill;
    var path = Path()
      ..moveTo(x2, y2)
      ..lineTo(x2 - 8 * math.cos(angle - 0.4), y2 - 8 * math.sin(angle - 0.4))
      ..lineTo(x2 - 8 * math.cos(angle + 0.4), y2 - 8 * math.sin(angle + 0.4))
      ..close();
    canvas.drawPath(path, headPaint);
  }

  void _drawLabel(Canvas canvas, String text, Offset pos, Color color) {
    var tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: 9, fontWeight: FontWeight.bold),
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
// SECTION 4: WILLCHANGEHINT VISUALIZATION
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildWillChangeHintSection() {
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
        _buildSectionTitle('willChangeHint Property', Icons.update),
        Text(
          'The willChangeHint property indicates that the picture contents '
          'are expected to change frequently. When true, the engine avoids '
          'caching the rasterized result since it would be invalidated soon.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.autorenew, color: Color(0xFFE65100), size: 24),
                  SizedBox(width: 8),
                  Text(
                    'Caching Behavior Matrix',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFE65100),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _buildCachingMatrix(),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildWillChangeScenarioCard(
                'willChangeHint: false',
                'Static or rarely changing',
                Icons.lock,
                Color(0xFF1976D2),
                ['Logo displays', 'Static backgrounds', 'Cached UI elements'],
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: _buildWillChangeScenarioCard(
                'willChangeHint: true',
                'Frequently updating',
                Icons.sync,
                Color(0xFFE65100),
                ['Animations', 'Live charts', 'Video frames'],
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: Color(0xFF1565C0), size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Tip: Use willChangeHint = true for animated content to prevent wasteful cache creation and invalidation cycles.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF1565C0)),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildCachingMatrix() {
  return Table(
    border: TableBorder.all(color: Color(0xFFFFCC80), width: 1),
    children: [
      TableRow(
        decoration: BoxDecoration(color: Color(0xFFFFE0B2)),
        children: [
          _buildTableCell('', isHeader: true),
          _buildTableCell('willChange: false', isHeader: true),
          _buildTableCell('willChange: true', isHeader: true),
        ],
      ),
      TableRow(
        children: [
          _buildTableCell('isComplex: false', isHeader: true),
          _buildTableCell('No caching', icon: Icons.close, iconColor: Color(0xFF757575)),
          _buildTableCell('No caching', icon: Icons.close, iconColor: Color(0xFF757575)),
        ],
      ),
      TableRow(
        children: [
          _buildTableCell('isComplex: true', isHeader: true),
          _buildTableCell('Cache enabled', icon: Icons.check, iconColor: Color(0xFF43A047)),
          _buildTableCell('Cache skipped', icon: Icons.remove, iconColor: Color(0xFFF57C00)),
        ],
      ),
    ],
  );
}

Widget _buildTableCell(String text, {bool isHeader = false, IconData? icon, Color? iconColor}) {
  return Padding(
    padding: EdgeInsets.all(8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 14, color: iconColor),
          SizedBox(width: 4),
        ],
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 10,
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              color: isHeader ? Color(0xFFE65100) : Color(0xFF546E7A),
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget _buildWillChangeScenarioCard(String title, String subtitle, IconData icon, Color color, List<String> examples) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withAlpha(15),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: color,
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 4),
        Text(
          subtitle,
          style: TextStyle(fontSize: 10, color: color.withAlpha(180)),
        ),
        SizedBox(height: 8),
        Text(
          'Examples:',
          style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Color(0xFF546E7A)),
        ),
        SizedBox(height: 4),
        ...examples.map((ex) => Padding(
          padding: EdgeInsets.only(bottom: 2),
          child: Row(
            children: [
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(width: 6),
              Text(ex, style: TextStyle(fontSize: 10, color: Color(0xFF546E7A))),
            ],
          ),
        )),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════════
// SECTION 5: LAYER TREE DIAGRAM
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildLayerTreeDiagramSection() {
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
        _buildSectionTitle('Layer Tree Structure', Icons.account_tree),
        Text(
          'PictureLayer exists as a leaf node in the compositing layer tree. '
          'It is typically a child of ContainerLayer subtypes like OffsetLayer '
          'or ClipRectLayer.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: SizedBox(
            height: 200,
            child: CustomPaint(
              size: Size(double.infinity, 200),
              painter: _LayerTreePainter(),
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Layer Tree Properties',
                style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF6A1B9A)),
              ),
              SizedBox(height: 8),
              _buildTreePropertyRow('parent', 'Reference to parent ContainerLayer'),
              _buildTreePropertyRow('nextSibling', 'Next layer in sibling chain'),
              _buildTreePropertyRow('previousSibling', 'Previous layer in sibling chain'),
              _buildTreePropertyRow('owner', 'PipelineOwner managing this layer'),
            ],
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            _buildLayerTypeChip('ContainerLayer', Color(0xFF1976D2)),
            SizedBox(width: 8),
            _buildLayerTypeChip('OffsetLayer', Color(0xFF388E3C)),
            SizedBox(width: 8),
            _buildLayerTypeChip('PictureLayer', Color(0xFF6A1B9A)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildTreePropertyRow(String name, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 11,
              color: Color(0xFF7B1FA2),
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 11, color: Color(0xFF546E7A)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLayerTypeChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: color.withAlpha(30),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withAlpha(80)),
    ),
    child: Text(
      label,
      style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.bold),
    ),
  );
}

class _LayerTreePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var centerX = size.width / 2;

    _drawLayerNode(canvas, Offset(centerX, 20), 'TransformLayer', Color(0xFF1976D2), Icons.transform);

    _drawConnector(canvas, centerX, 40, centerX - 80, 70, Color(0xFF90CAF9));
    _drawConnector(canvas, centerX, 40, centerX + 80, 70, Color(0xFF90CAF9));

    _drawLayerNode(canvas, Offset(centerX - 80, 85), 'OffsetLayer', Color(0xFF388E3C), Icons.open_with);
    _drawLayerNode(canvas, Offset(centerX + 80, 85), 'ClipRectLayer', Color(0xFFF57C00), Icons.crop);

    _drawConnector(canvas, centerX - 80, 105, centerX - 120, 140, Color(0xFFA5D6A7));
    _drawConnector(canvas, centerX - 80, 105, centerX - 40, 140, Color(0xFFA5D6A7));

    _drawLayerNode(canvas, Offset(centerX - 120, 155), 'PictureLayer', Color(0xFF6A1B9A), Icons.image);
    _drawLayerNode(canvas, Offset(centerX - 40, 155), 'PictureLayer', Color(0xFF6A1B9A), Icons.image);

    _drawConnector(canvas, centerX + 80, 105, centerX + 80, 140, Color(0xFFFFCC80));
    _drawLayerNode(canvas, Offset(centerX + 80, 155), 'PictureLayer', Color(0xFF6A1B9A), Icons.image);

    var labelPaint = Paint()..color = Color(0xFFE0E0E0)..style = PaintingStyle.fill;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Rect.fromLTWH(10, size.height - 25, 90, 18), Radius.circular(4)),
      labelPaint,
    );
    _drawText(canvas, 'Leaf Layers', Offset(55, size.height - 16), Color(0xFF6A1B9A), 10);
  }

  void _drawLayerNode(Canvas canvas, Offset center, String label, Color color, IconData icon) {
    var rect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: center, width: 85, height: 32),
      Radius.circular(6),
    );
    var fillPaint = Paint()..color = color.withAlpha(40)..style = PaintingStyle.fill;
    var borderPaint = Paint()..color = color..strokeWidth = 2..style = PaintingStyle.stroke;
    canvas.drawRRect(rect, fillPaint);
    canvas.drawRRect(rect, borderPaint);
    _drawText(canvas, label, center, color, 9);
  }

  void _drawConnector(Canvas canvas, double x1, double y1, double x2, double y2, Color color) {
    var paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    var path = Path()
      ..moveTo(x1, y1)
      ..lineTo(x1, (y1 + y2) / 2)
      ..lineTo(x2, (y1 + y2) / 2)
      ..lineTo(x2, y2);
    canvas.drawPath(path, paint);
  }

  void _drawText(Canvas canvas, String text, Offset center, Color color, double fontSize) {
    var tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.bold),
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
// SECTION 6: COMPOSITION WITH OTHER LAYERS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildCompositionSection() {
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
        _buildSectionTitle('Composition with Other Layers', Icons.layers),
        Text(
          'PictureLayer works alongside other layer types to build complex '
          'composited scenes. Each layer type adds specific visual effects '
          'or transformations to the final rendered output.',
          style: TextStyle(color: Color(0xFF546E7A), fontSize: 13),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Common Layer Combinations',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              SizedBox(height: 12),
              _buildLayerCombinationRow('OffsetLayer', 'Position Pictures with dx/dy offset', Icons.open_with, Color(0xFF388E3C)),
              _buildLayerCombinationRow('ClipRectLayer', 'Rectangular clipping of Pictures', Icons.crop, Color(0xFFF57C00)),
              _buildLayerCombinationRow('ClipPathLayer', 'Arbitrary path clipping', Icons.content_cut, Color(0xFFE91E63)),
              _buildLayerCombinationRow('OpacityLayer', 'Alpha blending for Pictures', Icons.opacity, Color(0xFF1976D2)),
              _buildLayerCombinationRow('ColorFilterLayer', 'Color transformations', Icons.filter, Color(0xFF00897B)),
              _buildLayerCombinationRow('BackdropFilterLayer', 'Backdrop blur effects', Icons.blur_on, Color(0xFF5D4037)),
            ],
          ),
        ),
        SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: CustomPaint(
            size: Size(double.infinity, 180),
            painter: _CompositionDiagramPainter(),
          ),
        ),
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.info_outline, color: Color(0xFF2E7D32), size: 18),
                  SizedBox(width: 8),
                  Text(
                    'Composition Order',
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2E7D32)),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Layers are composited from leaves to root. PictureLayer provides '
                'the base content, while parent layers apply transformations, '
                'clips, and effects in order up the tree.',
                style: TextStyle(fontSize: 12, color: Color(0xFF546E7A)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildLayerCombinationRow(String layer, String description, IconData icon, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Icon(icon, size: 16, color: color),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 100,
          child: Text(
            layer,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: color,
            ),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 11, color: Color(0xFF546E7A)),
          ),
        ),
      ],
    ),
  );
}

class _CompositionDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var layerStack = <Map<String, dynamic>>[
      {'label': 'TransformLayer', 'color': Color(0xFF1976D2), 'desc': 'Scale & Rotate'},
      {'label': 'ClipRectLayer', 'color': Color(0xFFF57C00), 'desc': 'Clip to bounds'},
      {'label': 'OpacityLayer', 'color': Color(0xFF8E24AA), 'desc': 'Alpha: 0.8'},
      {'label': 'OffsetLayer', 'color': Color(0xFF388E3C), 'desc': 'Offset(20, 30)'},
      {'label': 'PictureLayer', 'color': Color(0xFF6A1B9A), 'desc': 'Drawing content'},
    ];

    var layerHeight = 28.0;
    var layerWidth = 140.0;
    var startX = size.width / 2 - layerWidth / 2;
    var startY = 10.0;
    var offsetStep = 15.0;

    for (var i = 0; i < layerStack.length; i++) {
      var x = startX + i * offsetStep;
      var y = startY + i * (layerHeight + 5);
      var layerData = layerStack[i];
      var color = layerData['color'] as Color;

      var shadowPaint = Paint()
        ..color = color.withAlpha(40)
        ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);
      canvas.drawRRect(
        RRect.fromRectAndRadius(Rect.fromLTWH(x + 2, y + 2, layerWidth, layerHeight), Radius.circular(6)),
        shadowPaint,
      );

      var fillPaint = Paint()..color = color.withAlpha(60)..style = PaintingStyle.fill;
      var borderPaint = Paint()..color = color..strokeWidth = 2..style = PaintingStyle.stroke;
      var rect = RRect.fromRectAndRadius(Rect.fromLTWH(x, y, layerWidth, layerHeight), Radius.circular(6));
      canvas.drawRRect(rect, fillPaint);
      canvas.drawRRect(rect, borderPaint);

      _drawText(canvas, layerData['label'] as String, Offset(x + layerWidth / 2, y + layerHeight / 2 - 4), color, 10);
      _drawText(canvas, layerData['desc'] as String, Offset(x + layerWidth / 2, y + layerHeight / 2 + 7), color.withAlpha(180), 8);
    }

    var bracketX = startX + layerStack.length * offsetStep + layerWidth + 10;
    var bracketPaint = Paint()
      ..color = Color(0xFF6A1B9A)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    var bracketPath = Path()
      ..moveTo(bracketX, startY)
      ..lineTo(bracketX + 10, startY)
      ..lineTo(bracketX + 10, startY + (layerStack.length - 1) * (layerHeight + 5) + layerHeight)
      ..lineTo(bracketX, startY + (layerStack.length - 1) * (layerHeight + 5) + layerHeight);
    canvas.drawPath(bracketPath, bracketPaint);

    _drawText(
      canvas,
      'Composited\nScene',
      Offset(bracketX + 40, startY + ((layerStack.length - 1) * (layerHeight + 5) + layerHeight) / 2),
      Color(0xFF6A1B9A),
      10,
    );
  }

  void _drawText(Canvas canvas, String text, Offset center, Color color, double fontSize) {
    var tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: fontSize, fontWeight: FontWeight.w600),
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

// ═══════════════════════════════════════════════════════════════════════════════
// MAIN BUILD FUNCTION
// ═══════════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader(
          'PictureLayer',
          'A compositing layer that displays a Picture',
        ),
        SizedBox(height: 20),
        _buildPictureLayerOverviewSection(),
        SizedBox(height: 16),
        _buildPicturePropertySection(),
        SizedBox(height: 16),
        _buildIsComplexHintSection(),
        SizedBox(height: 16),
        _buildWillChangeHintSection(),
        SizedBox(height: 16),
        _buildLayerTreeDiagramSection(),
        SizedBox(height: 16),
        _buildCompositionSection(),
        SizedBox(height: 24),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.check_circle, color: Color(0xFF6A1B9A), size: 32),
              SizedBox(height: 8),
              Text(
                'PictureLayer Deep Demo Complete',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Picture-based layer compositing visualized',
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF8E24AA),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
