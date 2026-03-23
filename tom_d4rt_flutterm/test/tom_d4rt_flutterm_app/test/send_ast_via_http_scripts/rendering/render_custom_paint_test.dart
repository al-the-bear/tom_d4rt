// ignore_for_file: avoid_print
// Deep demo: RenderCustomPaint via CustomPaint widget
// Tests CustomPaint with multiple CustomPainter implementations,
// foregroundPainter, child combinations, and Canvas drawing APIs.

import 'package:flutter/material.dart';
import 'dart:math';

// Painter that draws basic geometric shapes: lines, circles, rectangles
class GeometricShapesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('[GeometricShapesPainter] paint called, size: $size');

    // Draw border rectangle
    var borderPaint = Paint()
      ..color = Colors.blueGrey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), borderPaint);

    // Draw diagonal lines
    var linePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(0, 0), Offset(size.width, size.height), linePaint);
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), linePaint);
    print('[GeometricShapesPainter] diagonal lines drawn');

    // Draw circles at various positions
    var circlePaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      30.0,
      circlePaint,
    );

    var circleStrokePaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawCircle(
      Offset(size.width / 4, size.height / 4),
      20.0,
      circleStrokePaint,
    );
    canvas.drawCircle(
      Offset(size.width * 3 / 4, size.height / 4),
      20.0,
      circleStrokePaint,
    );
    print('[GeometricShapesPainter] circles drawn');

    // Draw filled rectangles
    var rectPaint = Paint()
      ..color = Colors.orange.withValues(alpha: 0.5)
      ..style = PaintingStyle.fill;
    canvas.drawRect(Rect.fromLTWH(10, 10, 60, 40), rectPaint);
    canvas.drawRect(
      Rect.fromLTWH(size.width - 70, size.height - 50, 60, 40),
      rectPaint,
    );

    // Draw rounded rectangle
    var rrectPaint = Paint()
      ..color = Colors.purple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(size.width / 2 - 40, size.height - 60, 80, 50),
        Radius.circular(10),
      ),
      rrectPaint,
    );
    print('[GeometricShapesPainter] rectangles drawn');
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    print('[GeometricShapesPainter] shouldRepaint called');
    return false;
  }
}

// Painter that draws a simple bar chart
class BarChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('[BarChartPainter] paint called, size: $size');

    var barValues = [0.7, 0.4, 0.9, 0.5, 0.8, 0.3, 0.6];
    var barColors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.indigo,
    ];

    var barCount = barValues.length;
    var barSpacing = 6.0;
    var totalSpacing = barSpacing * (barCount + 1);
    var barWidth = (size.width - totalSpacing) / barCount;
    var maxBarHeight = size.height - 30.0;

    // Draw background grid lines
    var gridPaint = Paint()
      ..color = Colors.grey.withValues(alpha: 0.3)
      ..strokeWidth = 1.0;
    for (var i = 0; i <= 4; i = i + 1) {
      var y = 10.0 + (maxBarHeight / 4) * i;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    print('[BarChartPainter] grid lines drawn');

    // Draw bars
    for (var i = 0; i < barCount; i = i + 1) {
      var barHeight = maxBarHeight * barValues[i];
      var x = barSpacing + i * (barWidth + barSpacing);
      var y = size.height - 20.0 - barHeight;

      var barPaint = Paint()
        ..color = barColors[i]
        ..style = PaintingStyle.fill;
      canvas.drawRect(Rect.fromLTWH(x, y, barWidth, barHeight), barPaint);

      // Draw bar border
      var borderPaint = Paint()
        ..color = barColors[i].withValues(alpha: 0.8)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      canvas.drawRect(Rect.fromLTWH(x, y, barWidth, barHeight), borderPaint);
    }
    print('[BarChartPainter] bars drawn: $barCount bars');

    // Draw baseline
    var baselinePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0;
    canvas.drawLine(
      Offset(0, size.height - 20.0),
      Offset(size.width, size.height - 20.0),
      baselinePaint,
    );
    print('[BarChartPainter] chart complete');
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// Painter that draws a line graph with points
class LineGraphPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('[LineGraphPainter] paint called, size: $size');

    var dataPoints = [0.2, 0.5, 0.3, 0.8, 0.6, 0.9, 0.4, 0.7, 0.85, 0.55];
    var padding = 20.0;
    var graphWidth = size.width - padding * 2;
    var graphHeight = size.height - padding * 2;

    // Draw axes
    var axisPaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 2.0;
    canvas.drawLine(
      Offset(padding, padding),
      Offset(padding, size.height - padding),
      axisPaint,
    );
    canvas.drawLine(
      Offset(padding, size.height - padding),
      Offset(size.width - padding, size.height - padding),
      axisPaint,
    );
    print('[LineGraphPainter] axes drawn');

    // Draw data line
    var linePaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke;

    var path = Path();
    for (var i = 0; i < dataPoints.length; i = i + 1) {
      var x = padding + (graphWidth / (dataPoints.length - 1)) * i;
      var y = size.height - padding - graphHeight * dataPoints[i];
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    canvas.drawPath(path, linePaint);
    print('[LineGraphPainter] line path drawn');

    // Draw data points
    var pointPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.fill;
    var pointBorderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    for (var i = 0; i < dataPoints.length; i = i + 1) {
      var x = padding + (graphWidth / (dataPoints.length - 1)) * i;
      var y = size.height - padding - graphHeight * dataPoints[i];
      canvas.drawCircle(Offset(x, y), 5.0, pointBorderPaint);
      canvas.drawCircle(Offset(x, y), 3.5, pointPaint);
    }
    print('[LineGraphPainter] data points drawn: ${dataPoints.length}');
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// Painter that draws gradient-like pattern using concentric shapes
class GradientPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('[GradientPatternPainter] paint called, size: $size');

    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var maxRadius = min(size.width, size.height) / 2;

    // Draw concentric circles with varying colors for gradient effect
    var steps = 20;
    for (var i = steps; i > 0; i = i - 1) {
      var ratio = i / steps;
      var radius = maxRadius * ratio;
      var colorValue = (255 * ratio).toInt();
      var paint = Paint()
        ..color = Color.fromARGB(255, colorValue, 50, 255 - colorValue)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(centerX, centerY), radius, paint);
    }
    print('[GradientPatternPainter] concentric gradient circles drawn: $steps');

    // Draw radiating lines from center
    var lineCount = 16;
    var linePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.3)
      ..strokeWidth = 1.0;
    for (var i = 0; i < lineCount; i = i + 1) {
      var angle = (2 * pi / lineCount) * i;
      var endX = centerX + maxRadius * cos(angle);
      var endY = centerY + maxRadius * sin(angle);
      canvas.drawLine(Offset(centerX, centerY), Offset(endX, endY), linePaint);
    }
    print('[GradientPatternPainter] radiating lines drawn: $lineCount');

    // Draw outer ring
    var ringPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawCircle(Offset(centerX, centerY), maxRadius - 2, ringPaint);
    print('[GradientPatternPainter] gradient pattern complete');
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// Foreground painter that draws an overlay grid on top of child
class ForegroundGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print(
      '[ForegroundGridPainter] paint called as foregroundPainter, size: $size',
    );

    var gridPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.25)
      ..strokeWidth = 0.5;

    var gridSpacing = 20.0;

    // Vertical lines
    var x = 0.0;
    while (x <= size.width) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
      x = x + gridSpacing;
    }

    // Horizontal lines
    var y = 0.0;
    while (y <= size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
      y = y + gridSpacing;
    }
    print('[ForegroundGridPainter] grid overlay drawn');

    // Draw corner markers
    var markerPaint = Paint()
      ..color = Colors.yellow
      ..strokeWidth = 2.0;
    var markerSize = 15.0;
    // Top-left
    canvas.drawLine(Offset(0, 0), Offset(markerSize, 0), markerPaint);
    canvas.drawLine(Offset(0, 0), Offset(0, markerSize), markerPaint);
    // Top-right
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width - markerSize, 0),
      markerPaint,
    );
    canvas.drawLine(
      Offset(size.width, 0),
      Offset(size.width, markerSize),
      markerPaint,
    );
    // Bottom-left
    canvas.drawLine(
      Offset(0, size.height),
      Offset(markerSize, size.height),
      markerPaint,
    );
    canvas.drawLine(
      Offset(0, size.height),
      Offset(0, size.height - markerSize),
      markerPaint,
    );
    // Bottom-right
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width - markerSize, size.height),
      markerPaint,
    );
    canvas.drawLine(
      Offset(size.width, size.height),
      Offset(size.width, size.height - markerSize),
      markerPaint,
    );
    print('[ForegroundGridPainter] corner markers drawn');
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// Painter that draws arcs and paths for advanced canvas usage
class ArcAndPathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('[ArcAndPathPainter] paint called, size: $size');

    // Draw arc segments
    var arcPaint = Paint()
      ..color = Colors.deepPurple
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    var arcRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2),
      width: size.width * 0.7,
      height: size.height * 0.7,
    );
    canvas.drawArc(arcRect, 0, pi, false, arcPaint);
    print('[ArcAndPathPainter] top arc drawn');

    var arcPaint2 = Paint()
      ..color = Colors.teal
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;
    canvas.drawArc(arcRect, pi, pi, false, arcPaint2);
    print('[ArcAndPathPainter] bottom arc drawn');

    // Draw a star path
    var starPath = Path();
    var starCenter = Offset(size.width / 2, size.height / 2);
    var outerRadius = min(size.width, size.height) * 0.25;
    var innerRadius = outerRadius * 0.4;
    var points = 5;

    for (var i = 0; i < points * 2; i = i + 1) {
      var radius = (i % 2 == 0) ? outerRadius : innerRadius;
      var angle = (pi / points) * i - pi / 2;
      var px = starCenter.dx + radius * cos(angle);
      var py = starCenter.dy + radius * sin(angle);
      if (i == 0) {
        starPath.moveTo(px, py);
      } else {
        starPath.lineTo(px, py);
      }
    }
    starPath.close();

    var starFill = Paint()
      ..color = Colors.amber.withValues(alpha: 0.6)
      ..style = PaintingStyle.fill;
    canvas.drawPath(starPath, starFill);

    var starStroke = Paint()
      ..color = Colors.amber
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawPath(starPath, starStroke);
    print('[ArcAndPathPainter] star path drawn');

    // Draw bezier curve
    var bezierPath = Path();
    bezierPath.moveTo(10, size.height - 20);
    bezierPath.cubicTo(
      size.width * 0.25,
      10,
      size.width * 0.75,
      size.height - 10,
      size.width - 10,
      20,
    );
    var bezierPaint = Paint()
      ..color = Colors.pink
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawPath(bezierPath, bezierPaint);
    print('[ArcAndPathPainter] bezier curve drawn');
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// Painter that draws a checkerboard pattern
class CheckerboardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    print('[CheckerboardPainter] paint called, size: $size');

    var tileSize = 20.0;
    var cols = (size.width / tileSize).ceil();
    var rows = (size.height / tileSize).ceil();

    var darkPaint = Paint()
      ..color = Colors.grey.shade700
      ..style = PaintingStyle.fill;
    var lightPaint = Paint()
      ..color = Colors.grey.shade300
      ..style = PaintingStyle.fill;

    for (var row = 0; row < rows; row = row + 1) {
      for (var col = 0; col < cols; col = col + 1) {
        var paint = ((row + col) % 2 == 0) ? lightPaint : darkPaint;
        canvas.drawRect(
          Rect.fromLTWH(col * tileSize, row * tileSize, tileSize, tileSize),
          paint,
        );
      }
    }
    print('[CheckerboardPainter] checkerboard drawn: $cols x $rows tiles');
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// Helper: section header with gradient
Widget _buildHeader(String title) {
  print('[_buildHeader] building header: $title');
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.deepPurple.shade700, Colors.indigo.shade400],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// Helper: section title with accent
Widget _buildSectionTitle(String title) {
  print('[_buildSectionTitle] building section: $title');
  return Padding(
    padding: EdgeInsets.only(top: 20, bottom: 8),
    child: Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple.shade100, Colors.indigo.shade50],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.deepPurple.shade200),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.deepPurple.shade800,
        ),
      ),
    ),
  );
}

// Helper: description text
Widget _buildDescription(String text) {
  return Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Text(
      text,
      style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
    ),
  );
}

dynamic build(BuildContext context) {
  print('[build] RenderCustomPaint deep demo starting');

  // Section 1: Basic geometric shapes painter
  print('[build] creating geometric shapes CustomPaint');
  var geometricShapesPaint = CustomPaint(
    painter: GeometricShapesPainter(),
    size: Size(double.infinity, 200),
  );

  // Section 2: Bar chart painter
  print('[build] creating bar chart CustomPaint');
  var barChartPaint = CustomPaint(
    painter: BarChartPainter(),
    size: Size(double.infinity, 180),
  );

  // Section 3: Line graph painter
  print('[build] creating line graph CustomPaint');
  var lineGraphPaint = CustomPaint(
    painter: LineGraphPainter(),
    size: Size(double.infinity, 180),
  );

  // Section 4: Gradient pattern painter
  print('[build] creating gradient pattern CustomPaint');
  var gradientPatternPaint = SizedBox(
    width: 250,
    height: 250,
    child: CustomPaint(painter: GradientPatternPainter()),
  );

  // Section 5: ForegroundPainter with child widget
  print('[build] creating foregroundPainter CustomPaint with child');
  var foregroundPainterWithChild = CustomPaint(
    foregroundPainter: ForegroundGridPainter(),
    child: Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade800, Colors.purple.shade800],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          'Child beneath foregroundPainter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );

  // Section 6: Painter + child combination
  print('[build] creating painter + child combo CustomPaint');
  var painterWithChild = CustomPaint(
    painter: CheckerboardPainter(),
    child: Container(
      width: double.infinity,
      height: 160,
      alignment: Alignment.center,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.85),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
        ),
        child: Text(
          'Child on top of checkerboard painter',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade900,
          ),
        ),
      ),
    ),
  );

  // Section 7: isComplex and willChange hints
  print('[build] creating CustomPaint with isComplex and willChange');
  var complexPaint = CustomPaint(
    painter: ArcAndPathPainter(),
    size: Size(double.infinity, 200),
    isComplex: true,
    willChange: false,
  );
  print('[build] isComplex=true, willChange=false set');

  // Section 8: Different sizes via SizedBox
  print('[build] creating sized CustomPaint variants');
  var smallPaint = SizedBox(
    width: 100,
    height: 100,
    child: CustomPaint(painter: GeometricShapesPainter()),
  );
  var mediumPaint = SizedBox(
    width: 180,
    height: 180,
    child: CustomPaint(painter: GradientPatternPainter()),
  );
  var largePaint = SizedBox(
    width: 280,
    height: 160,
    child: CustomPaint(painter: BarChartPainter()),
  );

  // Section 9: Combined painter and foregroundPainter
  print('[build] creating combined painter + foregroundPainter');
  var combinedPainters = CustomPaint(
    painter: CheckerboardPainter(),
    foregroundPainter: ForegroundGridPainter(),
    child: Container(
      width: double.infinity,
      height: 200,
      alignment: Alignment.center,
      child: Text(
        'Both painter and foregroundPainter active',
        style: TextStyle(
          color: Colors.yellow,
          fontSize: 15,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(color: Colors.black, blurRadius: 4, offset: Offset(1, 1)),
          ],
        ),
      ),
    ),
  );

  // Assemble all sections
  print('[build] assembling all sections in SingleChildScrollView');
  var content = SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader('RenderCustomPaint Deep Demo'),
        SizedBox(height: 8),
        _buildDescription(
          'Demonstrates CustomPaint with various CustomPainter implementations, '
          'foregroundPainter, child combination, sizing, and canvas drawing APIs.',
        ),

        // 1. Geometric shapes
        _buildSectionTitle('1. Geometric Shapes Painter'),
        _buildDescription(
          'CustomPainter drawing lines, circles, rectangles, and rounded rects using Canvas API.',
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: geometricShapesPaint,
        ),

        // 2. Bar chart
        _buildSectionTitle('2. Bar Chart Painter'),
        _buildDescription(
          'Custom bar chart with grid lines, colored bars, and a baseline axis.',
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(color: Colors.white, child: barChartPaint),
        ),

        // 3. Line graph
        _buildSectionTitle('3. Line Graph Painter'),
        _buildDescription(
          'Line graph with axes, data path, and highlighted data points.',
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(color: Colors.grey.shade50, child: lineGraphPaint),
        ),

        // 4. Gradient pattern
        _buildSectionTitle('4. Gradient Pattern Painter'),
        _buildDescription(
          'Concentric circles creating a gradient effect with radiating lines.',
        ),
        Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(color: Colors.black, child: gradientPatternPaint),
          ),
        ),

        // 5. ForegroundPainter with child
        _buildSectionTitle('5. ForegroundPainter Over Child'),
        _buildDescription(
          'foregroundPainter draws grid overlay on top of a gradient child container.',
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: foregroundPainterWithChild,
        ),

        // 6. Painter + child combination
        _buildSectionTitle('6. Painter + Child Combination'),
        _buildDescription(
          'Checkerboard painter behind a floating label child widget.',
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: painterWithChild,
        ),

        // 7. isComplex and willChange
        _buildSectionTitle('7. Arc & Path Painter (isComplex, willChange)'),
        _buildDescription(
          'Arcs, star path, and bezier curve with isComplex=true, willChange=false hints.',
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(color: Colors.grey.shade100, child: complexPaint),
        ),

        // 8. Different sizes
        _buildSectionTitle('8. Different Sizes via SizedBox'),
        _buildDescription(
          'Same painters rendered at small (100x100), medium (180x180), and large (280x160) sizes.',
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Column(
              children: [
                Text(
                  'Small',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: smallPaint,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  'Medium',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: mediumPaint,
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 12),
        Center(
          child: Column(
            children: [
              Text(
                'Large',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 4),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: largePaint,
                ),
              ),
            ],
          ),
        ),

        // 9. Combined painter and foregroundPainter
        _buildSectionTitle('9. Combined Painter + ForegroundPainter'),
        _buildDescription(
          'Checkerboard as painter, grid overlay as foregroundPainter, with centered text child.',
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: combinedPainters,
        ),

        SizedBox(height: 24),
        Center(
          child: Text(
            'End of RenderCustomPaint Deep Demo',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade500,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        SizedBox(height: 16),
      ],
    ),
  );

  print('[build] RenderCustomPaint deep demo build complete');
  return content;
}
