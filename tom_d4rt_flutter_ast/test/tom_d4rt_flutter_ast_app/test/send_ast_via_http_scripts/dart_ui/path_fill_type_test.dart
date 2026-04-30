// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PathFillType enum from dart:ui
// Demonstrates path fill rules for determining inside/outside of complex paths.
// PathFillType is critical for rendering self-intersecting or nested paths.
//
// PathFillType enum values:
// - PathFillType.nonZero: Non-zero winding rule (considers direction)
// - PathFillType.evenOdd: Even-odd rule (counts crossings)
//
// The fill type determines which pixels are considered "inside" a path
// when the path has overlapping or nested regions.
//
// IMPORTANT: In D4rt, class definitions are not allowed. All logic must be in
// the build function, which returns a Widget.

import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // Log PathFillType enum information
  print('=== PathFillType Enum Deep Demo ===');
  print('');
  print('PathFillType Enum Overview:');
  print('  Total values: ${PathFillType.values.length}');
  for (final fillType in PathFillType.values) {
    print('  ${fillType.index}: ${fillType.name}');
  }

  print('');
  print('Fill Rule Explanation:');
  print('  nonZero: Counts winding direction of path segments');
  print('           If total winding != 0, point is inside');
  print('  evenOdd: Counts number of path edge crossings');
  print('           If crossings is odd, point is inside');

  print('');
  print('Common Use Cases:');
  print('  nonZero: Default rule, simpler nested shapes');
  print('  evenOdd: Complex shapes, donut holes, nested rings');

  // Build section card helper
  Widget buildSectionCard({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 28),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  // Build info row
  Widget buildInfoRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: valueColor ?? Colors.black87,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build concentric circles demo
  Widget buildConcentricCirclesDemo(PathFillType fillType, Color color) {
    return Column(
      children: [
        Text(fillType.name, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        CustomPaint(
          size: Size(120, 120),
          painter: _ConcentricCirclesPainter(fillType: fillType, color: color),
        ),
      ],
    );
  }

  // Build star with inner pentagon demo
  Widget buildStarDemo(PathFillType fillType, Color color) {
    return Column(
      children: [
        Text(fillType.name, style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        CustomPaint(
          size: Size(120, 120),
          painter: _StarPainter(fillType: fillType, color: color),
        ),
      ],
    );
  }

  // Build overlapping squares demo
  Widget buildOverlappingSquaresDemo(PathFillType fillType, Color color) {
    return Column(
      children: [
        CustomPaint(
          size: Size(100, 100),
          painter: _OverlappingSquaresPainter(fillType: fillType, color: color),
        ),
        SizedBox(height: 4),
        Text(
          fillType.name,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
        ),
      ],
    );
  }

  // Build figure-8 path demo
  Widget buildFigure8Demo(PathFillType fillType, Color color) {
    return Column(
      children: [
        CustomPaint(
          size: Size(100, 100),
          painter: _Figure8Painter(fillType: fillType, color: color),
        ),
        SizedBox(height: 4),
        Text(
          fillType.name,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
        ),
      ],
    );
  }

  print('');
  print('Building visual demo sections...');

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Header
        Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.format_shapes, color: Colors.white, size: 48),
              SizedBox(height: 12),
              Text(
                'PathFillType Enum',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Path fill rules for complex shapes',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              SizedBox(height: 16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${PathFillType.values.length} fill types available',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16),

        // Section 1: Enum Overview
        buildSectionCard(
          title: 'PathFillType Values',
          icon: Icons.list_alt,
          color: Colors.blue,
          children: [
            Text(
              'PathFillType determines how to compute the inside of a path for filling.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            ...PathFillType.values.map(
              (ft) => buildInfoRow(
                'PathFillType.${ft.name}',
                'index: ${ft.index}',
                valueColor: Colors.blue,
              ),
            ),
          ],
        ),

        // Section 2: Fill Rule Explanation
        buildSectionCard(
          title: 'Fill Rule Algorithms',
          icon: Icons.info_outline,
          color: Colors.teal,
          children: [
            // NonZero explanation
            Card(
              color: Colors.orange.shade50,
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'NON-ZERO',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Winding Rule',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade800,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Draws a ray from the point to infinity and counts path crossings:',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('• +1 for each clockwise crossing'),
                          Text('• -1 for each counter-clockwise crossing'),
                          Text('• Point is INSIDE if total ≠ 0'),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Result: Nested shapes in same direction are filled together',
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 12),
            // EvenOdd explanation
            Card(
              color: Colors.purple.shade50,
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.purple,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'EVEN-ODD',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Alternating Rule',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple.shade800,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Draws a ray from the point and counts total path crossings:',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    SizedBox(height: 8),
                    Padding(
                      padding: EdgeInsets.only(left: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('• Count all crossings (ignore direction)'),
                          Text('• Point is INSIDE if count is odd'),
                          Text('• Point is OUTSIDE if count is even'),
                        ],
                      ),
                    ),
                    SizedBox(height: 8),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.purple.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Result: Nested shapes alternate filled/unfilled (donut effect)',
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // Section 3: Concentric Circles Comparison
        buildSectionCard(
          title: 'Concentric Circles Demo',
          icon: Icons.radio_button_unchecked,
          color: Colors.deepPurple,
          children: [
            Text(
              'Same path with two concentric circles, different fill types:',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildConcentricCirclesDemo(PathFillType.nonZero, Colors.orange),
                buildConcentricCirclesDemo(PathFillType.evenOdd, Colors.purple),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.deepPurple.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notice the difference:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('• nonZero: Inner circle is filled (winding ≠ 0)'),
                  Text('• evenOdd: Inner circle is empty (creates hole)'),
                ],
              ),
            ),
          ],
        ),

        // Section 4: Star Shape Comparison
        buildSectionCard(
          title: 'Self-Intersecting Star',
          icon: Icons.star,
          color: Colors.amber.shade800,
          children: [
            Text(
              'A five-pointed star drawn with a single path intersects itself:',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildStarDemo(PathFillType.nonZero, Colors.orange),
                buildStarDemo(PathFillType.evenOdd, Colors.purple),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Star center comparison:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text('• nonZero: Pentagon center is filled'),
                  Text('• evenOdd: Pentagon center is empty (hole)'),
                ],
              ),
            ),
          ],
        ),

        // Section 5: Overlapping Shapes
        buildSectionCard(
          title: 'Overlapping Squares',
          icon: Icons.filter_none,
          color: Colors.green,
          children: [
            Text(
              'Two overlapping rectangles in a single path:',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildOverlappingSquaresDemo(PathFillType.nonZero, Colors.green),
                buildOverlappingSquaresDemo(
                  PathFillType.evenOdd,
                  Colors.purple,
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'The overlapping region has 2 crossings - odd (inside) for evenOdd, '
              'filled for nonZero since winding ≠ 0.',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ],
        ),

        // Section 6: Figure-8 Path
        buildSectionCard(
          title: 'Figure-8 Path',
          icon: Icons.all_inclusive,
          color: Colors.cyan,
          children: [
            Text(
              'A figure-8 (infinity symbol) shape where direction matters:',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildFigure8Demo(PathFillType.nonZero, Colors.cyan),
                buildFigure8Demo(PathFillType.evenOdd, Colors.pink),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'With evenOdd, both loops are filled identically. '
              'With nonZero, result depends on loop winding directions.',
              style: TextStyle(color: Colors.grey[600], fontSize: 13),
            ),
          ],
        ),

        // Section 7: Practical Usage
        buildSectionCard(
          title: 'Code Example',
          icon: Icons.code,
          color: Colors.blueGrey,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '// Creating a path with fill type',
                    style: TextStyle(
                      color: Colors.green.shade400,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'final path = Path()',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '  ..fillType = PathFillType.evenOdd',
                    style: TextStyle(
                      color: Colors.orange.shade300,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '  ..addOval(outerRect)',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '  ..addOval(innerRect);',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '// Draw filled path',
                    style: TextStyle(
                      color: Colors.green.shade400,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'canvas.drawPath(path, fillPaint);',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Section 8: When to Use Each
        buildSectionCard(
          title: 'Recommendations',
          icon: Icons.lightbulb_outline,
          color: Colors.blue,
          children: [
            _buildRecommendationRow(
              'Simple shapes',
              'nonZero',
              'Default, works for most cases',
              Colors.orange,
            ),
            _buildRecommendationRow(
              'Donut/ring shapes',
              'evenOdd',
              'Creates hole in center automatically',
              Colors.purple,
            ),
            _buildRecommendationRow(
              'Text outlines',
              'evenOdd',
              'Letters like O, A need holes',
              Colors.purple,
            ),
            _buildRecommendationRow(
              'Complex nested shapes',
              'evenOdd',
              'Predictable alternating fill',
              Colors.purple,
            ),
            _buildRecommendationRow(
              'Icon paths',
              'nonZero',
              'Most icon fonts use this',
              Colors.orange,
            ),
          ],
        ),

        // Section 9: Visual Comparison Summary
        buildSectionCard(
          title: 'Visual Comparison',
          icon: Icons.compare,
          color: Colors.indigo,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        width: double.infinity,
                        child: Text(
                          'PathFillType.nonZero',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.orange.shade50,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          border: Border.all(color: Colors.orange.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('✓ Fills based on winding'),
                            Text('✓ Direction matters'),
                            Text('✓ Solid nested shapes'),
                            Text('✓ Default for most uses'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                        ),
                        width: double.infinity,
                        child: Text(
                          'PathFillType.evenOdd',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.purple.shade50,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          border: Border.all(color: Colors.purple.shade200),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('✓ Counts crossings'),
                            Text('✓ Direction ignored'),
                            Text('✓ Creates holes'),
                            Text('✓ Alternating fill'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),

        // Section 10: Enum Operations
        buildSectionCard(
          title: 'Enum Properties',
          icon: Icons.settings,
          color: Colors.brown,
          children: [
            buildInfoRow('values.length', '${PathFillType.values.length}'),
            buildInfoRow('values.first', '${PathFillType.values.first}'),
            buildInfoRow('values.last', '${PathFillType.values.last}'),
            Divider(height: 24),
            Text(
              'Accessing by index:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8),
            ...List.generate(
              PathFillType.values.length,
              (i) => buildInfoRow('values[$i]', '${PathFillType.values[i]}'),
            ),
          ],
        ),

        // Footer
        SizedBox(height: 16),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Text(
                'PathFillType Demo Complete',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Both fill types demonstrated with visual examples showing '
                'how they handle self-intersecting and nested paths.',
                style: TextStyle(color: Colors.grey.shade600),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),

        SizedBox(height: 32),
      ],
    ),
  );
}

// Helper widget for recommendation rows
Widget _buildRecommendationRow(
  String useCase,
  String fillType,
  String reason,
  Color color,
) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 4),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(useCase, style: TextStyle(fontWeight: FontWeight.w500)),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            fillType,
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          flex: 3,
          child: Text(
            reason,
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}

// Custom painters for path fill demonstrations

/// Painter that draws concentric circles to demonstrate fill types
class _ConcentricCirclesPainter extends CustomPainter {
  final PathFillType fillType;
  final Color color;

  _ConcentricCirclesPainter({required this.fillType, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()..fillType = fillType;

    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2 - 10;
    final innerRadius = outerRadius * 0.5;

    // Add outer circle (clockwise)
    path.addOval(Rect.fromCircle(center: center, radius: outerRadius));
    // Add inner circle (also clockwise for same winding)
    path.addOval(Rect.fromCircle(center: center, radius: innerRadius));

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    // Draw outline
    final outlinePaint = Paint()
      ..color = color.withValues(alpha: 0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, outerRadius, outlinePaint);
    canvas.drawCircle(center, innerRadius, outlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Painter that draws a five-pointed star
class _StarPainter extends CustomPainter {
  final PathFillType fillType;
  final Color color;

  _StarPainter({required this.fillType, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()..fillType = fillType;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    // Create 5-pointed star by connecting every other point
    final points = <Offset>[];
    for (var i = 0; i < 5; i++) {
      final angle = (i * 144 - 90) * 3.14159265359 / 180;
      points.add(
        Offset(
          center.dx + radius * cos(angle),
          center.dy + radius * sin(angle),
        ),
      );
    }

    path.moveTo(points[0].dx, points[0].dy);
    for (var i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    path.close();

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    // Draw outline
    final outlinePaint = Paint()
      ..color = Colors.black45
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawPath(path, outlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Painter that draws overlapping squares
class _OverlappingSquaresPainter extends CustomPainter {
  final PathFillType fillType;
  final Color color;

  _OverlappingSquaresPainter({required this.fillType, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()..fillType = fillType;

    final squareSize = size.width * 0.6;

    // First square (top-left)
    path.addRect(Rect.fromLTWH(10, 10, squareSize, squareSize));

    // Second square (bottom-right, overlapping)
    path.addRect(
      Rect.fromLTWH(
        size.width - squareSize - 10,
        size.height - squareSize - 10,
        squareSize,
        squareSize,
      ),
    );

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    // Draw outlines
    final outlinePaint = Paint()
      ..color = Colors.black45
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawPath(path, outlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Painter that draws a figure-8 shape
class _Figure8Painter extends CustomPainter {
  final PathFillType fillType;
  final Color color;

  _Figure8Painter({required this.fillType, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()..fillType = fillType;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 4 - 5;

    // Left circle
    path.addOval(
      Rect.fromCircle(
        center: Offset(center.dx - radius, center.dy),
        radius: radius,
      ),
    );

    // Right circle (overlapping at center)
    path.addOval(
      Rect.fromCircle(
        center: Offset(center.dx + radius, center.dy),
        radius: radius,
      ),
    );

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawPath(path, paint);

    // Draw outlines
    final outlinePaint = Paint()
      ..color = Colors.black45
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawPath(path, outlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Math helper (dart:math not available in this context, inline simple functions)
double cos(double radians) {
  // Taylor series approximation for cos
  var result = 1.0;
  var term = 1.0;
  var sign = -1.0;
  for (var i = 2; i <= 10; i += 2) {
    term *= radians * radians / (i * (i - 1));
    result += sign * term;
    sign *= -1;
  }
  return result;
}

double sin(double radians) {
  // Taylor series approximation for sin
  var result = radians;
  var term = radians;
  var sign = -1.0;
  for (var i = 3; i <= 11; i += 2) {
    term *= radians * radians / (i * (i - 1));
    result += sign * term;
    sign *= -1;
  }
  return result;
}
