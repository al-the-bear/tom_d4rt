// D4rt test script: Deep Demo for PointMode from dart:ui
// PointMode defines how a list of points is interpreted when drawn
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== PointMode Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: PointMode Fundamentals
  // ═══════════════════════════════════════════════════════════════════════════

  print('PointMode defines how Canvas.drawPoints interprets point lists');
  print('All values: ${PointMode.values}');
  print('Count: ${PointMode.values.length}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: All Values
  // ═══════════════════════════════════════════════════════════════════════════

  for (final mode in PointMode.values) {
    print('${mode.name}: index=${mode.index}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: Understanding Modes
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Point Modes ---');
  print('points: Draw each point as a dot');
  print('lines: Draw lines between consecutive pairs of points');
  print('polygon: Draw connected line segments through all points');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              _buildHeader(),
              SizedBox(height: 16),

              // Section 1: Overview
              _buildSectionCard(
                'PointMode Overview',
                Icons.scatter_plot,
                Colors.deepOrange,
                [
                  'Used with Canvas.drawPoints() method',
                  'Interprets a list of points in different ways',
                  'Controls whether to draw dots, line pairs, or polygons',
                  'Values: ${PointMode.values.length} drawing modes',
                ],
              ),
              SizedBox(height: 16),

              // Section 2: All Three Modes
              _buildSectionHeader('ALL POINT MODES'),
              _buildAllModesDemo(),
              SizedBox(height: 16),

              // Section 3: Points Mode
              _buildSectionHeader('POINTMODE.POINTS'),
              _buildPointsModeDemo(),
              SizedBox(height: 16),

              // Section 4: Lines Mode
              _buildSectionHeader('POINTMODE.LINES'),
              _buildLinesModeDemo(),
              SizedBox(height: 16),

              // Section 5: Polygon Mode
              _buildSectionHeader('POINTMODE.POLYGON'),
              _buildPolygonModeDemo(),
              SizedBox(height: 16),

              // Section 6: Same Points Comparison
              _buildSectionHeader('SAME POINTS, DIFFERENT MODES'),
              _buildSamePointsComparison(),
              SizedBox(height: 16),

              // Section 7: Stroke Width Effects
              _buildSectionHeader('STROKE WIDTH EFFECTS'),
              _buildStrokeWidthDemo(),
              SizedBox(height: 16),

              // Section 8: Stroke Cap Effects
              _buildSectionHeader('STROKE CAP EFFECTS'),
              _buildStrokeCapDemo(),
              SizedBox(height: 16),

              // Section 9: Practical Examples
              _buildSectionHeader('PRACTICAL USE CASES'),
              _buildPracticalExamples(),
              SizedBox(height: 16),

              // Section 10: Comparison Table
              _buildSectionHeader('MODE COMPARISON'),
              _buildComparisonTable(),
              SizedBox(height: 32),

              // Footer
              _buildFooter(),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget _buildHeader() {
  return Container(
    margin: EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFF5722), Color(0xFFFF8A65)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Color(0xFFFF5722).withValues(alpha: 0.3),
          blurRadius: 8,
          offset: Offset(0, 4),
        ),
      ],
    ),
    padding: EdgeInsets.all(24),
    child: Column(
      children: [
        Icon(Icons.scatter_plot, size: 48, color: Colors.white),
        SizedBox(height: 12),
        Text(
          'PointMode',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Canvas Point Drawing Modes',
          style: TextStyle(
            fontSize: 14,
            color: Colors.white.withValues(alpha: 0.9),
          ),
        ),
        SizedBox(height: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'dart:ui Enum • ${PointMode.values.length} Modes',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSectionHeader(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
        color: Colors.grey[600],
        letterSpacing: 1.2,
      ),
    ),
  );
}

Widget _buildSectionCard(
  String title,
  IconData icon,
  Color color,
  List<String> points,
) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 24),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: points
                .map(
                  (point) => Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 6),
                          width: 6,
                          height: 6,
                          decoration: BoxDecoration(
                            color: color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            point,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAllModesDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(child: _buildModeCard(PointMode.points, Colors.blue)),
            SizedBox(width: 8),
            Expanded(child: _buildModeCard(PointMode.lines, Colors.green)),
            SizedBox(width: 8),
            Expanded(child: _buildModeCard(PointMode.polygon, Colors.orange)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildModeCard(PointMode mode, Color color) {
  return Container(
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            mode.name,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        SizedBox(height: 8),
        SizedBox(
          height: 80,
          child: CustomPaint(
            painter: _PointModePainter(mode, color),
            size: Size.infinite,
          ),
        ),
      ],
    ),
  );
}

class _PointModePainter extends CustomPainter {
  final PointMode mode;
  final Color color;

  _PointModePainter(this.mode, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final points = <Offset>[
      Offset(size.width * 0.2, size.height * 0.3),
      Offset(size.width * 0.5, size.height * 0.1),
      Offset(size.width * 0.8, size.height * 0.4),
      Offset(size.width * 0.6, size.height * 0.8),
      Offset(size.width * 0.3, size.height * 0.6),
      Offset(size.width * 0.1, size.height * 0.9),
    ];

    canvas.drawPoints(mode, points, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildPointsModeDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.radio_button_checked, color: Colors.blue, size: 20),
            SizedBox(width: 8),
            Text(
              'PointMode.points',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Each point is drawn as a dot. The size of the dot is determined by strokeWidth.',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: CustomPaint(
            painter: _PointsOnlyPainter(),
            size: Size.infinite,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Points: [p1, p2, p3, p4, p5] → 5 dots',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

class _PointsOnlyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    final points = <Offset>[
      Offset(size.width * 0.1, size.height * 0.5),
      Offset(size.width * 0.3, size.height * 0.3),
      Offset(size.width * 0.5, size.height * 0.7),
      Offset(size.width * 0.7, size.height * 0.2),
      Offset(size.width * 0.9, size.height * 0.5),
    ];

    canvas.drawPoints(PointMode.points, points, paint);

    // Draw labels
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    for (int i = 0; i < points.length; i++) {
      textPainter.text = TextSpan(
        text: 'p${i + 1}',
        style: TextStyle(fontSize: 10, color: Colors.blue[800]),
      );
      textPainter.layout();
      textPainter.paint(canvas, points[i] + Offset(-8, 12));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildLinesModeDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.show_chart, color: Colors.green, size: 20),
            SizedBox(width: 8),
            Text(
              'PointMode.lines',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Points are paired. Each pair forms a separate line segment. Requires even number of points.',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: CustomPaint(painter: _LinesPainter(), size: Size.infinite),
        ),
        SizedBox(height: 8),
        Text(
          'Points: [p1, p2, p3, p4, p5, p6] → 3 lines (p1-p2, p3-p4, p5-p6)',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

class _LinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final points = <Offset>[
      Offset(size.width * 0.1, size.height * 0.4),
      Offset(size.width * 0.25, size.height * 0.7),
      Offset(size.width * 0.4, size.height * 0.2),
      Offset(size.width * 0.55, size.height * 0.6),
      Offset(size.width * 0.7, size.height * 0.3),
      Offset(size.width * 0.9, size.height * 0.8),
    ];

    canvas.drawPoints(PointMode.lines, points, paint);

    // Draw point markers
    final dotPaint = Paint()..color = Colors.green[800]!;
    for (final p in points) {
      canvas.drawCircle(p, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildPolygonModeDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: Colors.orange, size: 20),
            SizedBox(width: 8),
            Text(
              'PointMode.polygon',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'All points are connected in sequence. Each point connects to the next, forming a polyline.',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: CustomPaint(painter: _PolygonPainter(), size: Size.infinite),
        ),
        SizedBox(height: 8),
        Text(
          'Points: [p1, p2, p3, p4, p5] → 4 lines (p1-p2-p3-p4-p5)',
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey[600],
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );
}

class _PolygonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final points = <Offset>[
      Offset(size.width * 0.1, size.height * 0.5),
      Offset(size.width * 0.3, size.height * 0.2),
      Offset(size.width * 0.5, size.height * 0.7),
      Offset(size.width * 0.7, size.height * 0.3),
      Offset(size.width * 0.9, size.height * 0.6),
    ];

    canvas.drawPoints(PointMode.polygon, points, paint);

    // Draw point markers
    final dotPaint = Paint()..color = Colors.orange[800]!;
    for (final p in points) {
      canvas.drawCircle(p, 4, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildSamePointsComparison() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '6 points rendered with each mode:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 150,
          child: CustomPaint(
            painter: _ComparisonPainter(),
            size: Size.infinite,
          ),
        ),
      ],
    ),
  );
}

class _ComparisonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rowHeight = size.height / 3;

    // Shared points
    List<Offset> getPoints(double yOffset) {
      return [
        Offset(size.width * 0.1, yOffset + rowHeight * 0.5),
        Offset(size.width * 0.25, yOffset + rowHeight * 0.2),
        Offset(size.width * 0.4, yOffset + rowHeight * 0.7),
        Offset(size.width * 0.55, yOffset + rowHeight * 0.3),
        Offset(size.width * 0.7, yOffset + rowHeight * 0.6),
        Offset(size.width * 0.85, yOffset + rowHeight * 0.4),
      ];
    }

    // Points mode
    var paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.points, getPoints(0), paint);

    // Lines mode
    paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.lines, getPoints(rowHeight), paint);

    // Polygon mode
    paint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawPoints(PointMode.polygon, getPoints(rowHeight * 2), paint);

    // Labels
    final textPainter = TextPainter(textDirection: TextDirection.ltr);
    for (final (i, label) in ['points', 'lines', 'polygon'].indexed) {
      textPainter.text = TextSpan(
        text: label,
        style: TextStyle(fontSize: 10, color: Colors.grey[700]),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(size.width * 0.92, rowHeight * i + rowHeight * 0.4),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildStrokeWidthDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Stroke width affects point and line size:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 120,
          child: CustomPaint(
            painter: _StrokeWidthPainter(),
            size: Size.infinite,
          ),
        ),
      ],
    ),
  );
}

class _StrokeWidthPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final widths = [2.0, 6.0, 12.0, 20.0];
    final colors = [Colors.blue, Colors.green, Colors.orange, Colors.red];

    for (int i = 0; i < widths.length; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..strokeWidth = widths[i]
        ..strokeCap = StrokeCap.round;

      final y = size.height * (i + 0.5) / widths.length;
      final points = [
        Offset(size.width * 0.3, y),
        Offset(size.width * 0.5, y),
        Offset(size.width * 0.7, y),
      ];

      canvas.drawPoints(PointMode.points, points, paint);

      // Label
      final textPainter = TextPainter(
        text: TextSpan(
          text: '${widths[i].toInt()}px',
          style: TextStyle(fontSize: 10, color: Colors.grey[700]),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(size.width * 0.1, y - 6));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildStrokeCapDemo() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'StrokeCap affects point shape:',
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
        SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: CustomPaint(painter: _StrokeCapPainter(), size: Size.infinite),
        ),
      ],
    ),
  );
}

class _StrokeCapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final caps = [StrokeCap.round, StrokeCap.square, StrokeCap.butt];
    final labels = ['round', 'square', 'butt'];
    final colors = [Colors.purple, Colors.teal, Colors.pink];

    for (int i = 0; i < caps.length; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..strokeWidth = 16
        ..strokeCap = caps[i];

      final y = size.height * (i + 0.5) / caps.length;
      final points = [Offset(size.width * 0.5, y)];

      canvas.drawPoints(PointMode.points, points, paint);

      // Label
      final textPainter = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(fontSize: 11, color: Colors.grey[700]),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(size.width * 0.2, y - 6));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildPracticalExamples() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    child: Column(
      children: [
        _buildPracticalCard(
          'Scatter Plot',
          'points mode',
          Icons.bubble_chart,
          Colors.blue,
        ),
        SizedBox(height: 8),
        _buildPracticalCard(
          'Dashed Lines',
          'lines mode',
          Icons.more_horiz,
          Colors.green,
        ),
        SizedBox(height: 8),
        _buildPracticalCard(
          'Path Drawing',
          'polygon mode',
          Icons.gesture,
          Colors.orange,
        ),
      ],
    ),
  );
}

Widget _buildPracticalCard(
  String title,
  String mode,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
              Text(
                'Use $mode',
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildComparisonTable() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
          ),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Mode',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  'Behavior',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  'n points →',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
                ),
              ),
            ],
          ),
        ),
        _buildTableRow('points', 'Individual dots', 'n dots'),
        _buildTableRow('lines', 'Paired segments', 'n/2 lines'),
        _buildTableRow('polygon', 'Connected path', 'n-1 lines'),
      ],
    ),
  );
}

Widget _buildTableRow(String mode, String behavior, String result) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            mode,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(behavior, style: TextStyle(fontSize: 11)),
        ),
        Expanded(
          flex: 2,
          child: Text(
            result,
            style: TextStyle(
              fontSize: 11,
              fontFamily: 'monospace',
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFooter() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      children: [
        Text(
          'PointMode Summary',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        SizedBox(height: 8),
        Text(
          '${PointMode.values.length} modes for Canvas.drawPoints(). '
          'Use points for scatter plots, lines for paired segments, '
          'and polygon for connected paths.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12, color: Colors.grey[700]),
        ),
      ],
    ),
  );
}
