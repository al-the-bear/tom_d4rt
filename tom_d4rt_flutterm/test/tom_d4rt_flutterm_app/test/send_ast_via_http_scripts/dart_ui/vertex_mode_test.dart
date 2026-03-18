// D4rt test script: Tests VertexMode enum from dart:ui
// Demonstrates different modes for drawing vertices with Canvas.drawVertices.
// VertexMode controls how vertex positions are interpreted when rendering.
//
// VertexMode enum values:
// - VertexMode.triangles: Every 3 vertices form a triangle
// - VertexMode.triangleStrip: Each vertex forms triangle with previous two
// - VertexMode.triangleFan: All triangles share first vertex
//
// Used with Canvas.drawVertices() for GPU-accelerated mesh rendering.
//
// IMPORTANT: In D4rt, class definitions are not allowed. All logic must be in
// the build function, which returns a Widget.

import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  // Log VertexMode enum information
  print('=== VertexMode Enum Deep Demo ===');
  print('');
  print('VertexMode Enum Overview:');
  print('  Total values: ${VertexMode.values.length}');
  for (final mode in VertexMode.values) {
    print('  ${mode.index}: ${mode.name}');
  }

  print('');
  print('Mode Descriptions:');
  print('  triangles: Groups of 3 vertices form independent triangles');
  print('             Vertices: 0-1-2, 3-4-5, 6-7-8, ...');
  print('  triangleStrip: Each new vertex forms triangle with previous two');
  print('             Triangles: 0-1-2, 1-2-3, 2-3-4, ...');
  print('  triangleFan: All triangles share the first vertex');
  print('             Triangles: 0-1-2, 0-2-3, 0-3-4, ...');

  print('');
  print('Use Cases:');
  print('  triangles: General mesh rendering, custom shapes');
  print('  triangleStrip: Efficient strips, wave effects, ribbons');
  print('  triangleFan: Circular shapes, pie charts, radial effects');

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
            width: 150,
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

  // Build mode card with description
  Widget buildModeCard(
    VertexMode mode,
    String description,
    String pattern,
    List<String> vertices,
    Color color,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 1,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    mode.name.toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    description,
                    style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Triangle Pattern:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                  SizedBox(height: 4),
                  Text(
                    pattern,
                    style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Triangles from 6 vertices:',
              style: TextStyle(fontSize: 12, color: Colors.grey[700]),
            ),
            SizedBox(height: 4),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: vertices
                  .map(
                    (v) => Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: color.withValues(alpha: 0.3)),
                      ),
                      child: Text(
                        v,
                        style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
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
              colors: [Colors.deepPurple, Colors.purple],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.change_history, color: Colors.white, size: 48),
              SizedBox(height: 12),
              Text(
                'VertexMode Enum',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Triangle rendering modes for Canvas.drawVertices',
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
                  '${VertexMode.values.length} vertex modes available',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16),

        // Section 1: Enum Overview
        buildSectionCard(
          title: 'VertexMode Values',
          icon: Icons.list_alt,
          color: Colors.blue,
          children: [
            Text(
              'VertexMode determines how vertex positions are grouped into triangles.',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            ...VertexMode.values.map(
              (mode) => buildInfoRow(
                'VertexMode.${mode.name}',
                'index: ${mode.index}',
                valueColor: Colors.blue,
              ),
            ),
          ],
        ),

        // Section 2: Mode Details
        buildSectionCard(
          title: 'Mode Descriptions',
          icon: Icons.info_outline,
          color: Colors.teal,
          children: [
            buildModeCard(
              VertexMode.triangles,
              'Independent triangles from groups of 3 vertices',
              'vertices[0,1,2] → tri1, vertices[3,4,5] → tri2, ...',
              ['△(0,1,2)', '△(3,4,5)'],
              Colors.orange,
            ),
            buildModeCard(
              VertexMode.triangleStrip,
              'Connected strip where each vertex adds a triangle',
              'vertices[i,i+1,i+2] form triangle, alternating winding',
              ['△(0,1,2)', '△(1,2,3)', '△(2,3,4)', '△(3,4,5)'],
              Colors.green,
            ),
            buildModeCard(
              VertexMode.triangleFan,
              'Fan shape with all triangles sharing vertex 0',
              'All triangles include vertex 0: (0,i,i+1)',
              ['△(0,1,2)', '△(0,2,3)', '△(0,3,4)', '△(0,4,5)'],
              Colors.purple,
            ),
          ],
        ),

        // Section 3: Visual Diagram - Triangles Mode
        buildSectionCard(
          title: 'VertexMode.triangles',
          icon: Icons.category,
          color: Colors.orange,
          children: [
            Text(
              'Every 3 consecutive vertices form a separate triangle:',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Center(
              child: CustomPaint(
                size: Size(300, 180),
                painter: _TrianglesDiagramPainter(),
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vertex count requirement: Multiple of 3',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '6 vertices = 2 triangles, 9 vertices = 3 triangles',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Best for: Non-connected triangles, custom meshes',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Section 4: Visual Diagram - Triangle Strip
        buildSectionCard(
          title: 'VertexMode.triangleStrip',
          icon: Icons.linear_scale,
          color: Colors.green,
          children: [
            Text(
              'Each new vertex creates a triangle with the previous two:',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Center(
              child: CustomPaint(
                size: Size(300, 180),
                painter: _TriangleStripDiagramPainter(),
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Triangle count: n - 2 (where n = vertex count)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '6 vertices = 4 triangles, very efficient!',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Best for: Ribbons, terrain, wave surfaces',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Section 5: Visual Diagram - Triangle Fan
        buildSectionCard(
          title: 'VertexMode.triangleFan',
          icon: Icons.blur_circular,
          color: Colors.purple,
          children: [
            Text(
              'All triangles share the first vertex (center):',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Center(
              child: CustomPaint(
                size: Size(250, 250),
                painter: _TriangleFanDiagramPainter(),
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Triangle count: n - 2 (same as strip)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '6 vertices = 4 triangles forming a fan',
                    style: TextStyle(fontSize: 12),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Best for: Circles, pie charts, radial gradients',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Section 6: Comparison Table
        buildSectionCard(
          title: 'Mode Comparison',
          icon: Icons.compare,
          color: Colors.indigo,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  // Header
                  Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(7),
                        topRight: Radius.circular(7),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Property',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'triangles',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'strip',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'fan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  _buildComparisonRow('Triangles/6 verts', '2', '4', '4'),
                  _buildComparisonRow('Shared vertices', 'No', 'Yes', 'Yes'),
                  _buildComparisonRow('Memory efficient', '✗', '✓', '✓'),
                  _buildComparisonRow(
                    'Shape flexibility',
                    'High',
                    'Linear',
                    'Radial',
                  ),
                ],
              ),
            ),
          ],
        ),

        // Section 7: Real-World Example - Gradient Mesh
        buildSectionCard(
          title: 'Colored Mesh Demo',
          icon: Icons.gradient,
          color: Colors.pink,
          children: [
            Text(
              'VertexMode with per-vertex colors for gradient effects:',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      'triangles',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    CustomPaint(
                      size: Size(100, 100),
                      painter: _ColoredMeshPainter(mode: VertexMode.triangles),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'triangleStrip',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    CustomPaint(
                      size: Size(100, 100),
                      painter: _ColoredMeshPainter(
                        mode: VertexMode.triangleStrip,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'triangleFan',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    CustomPaint(
                      size: Size(100, 100),
                      painter: _ColoredMeshPainter(
                        mode: VertexMode.triangleFan,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),

        // Section 8: Code Example
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
                    '// Create vertices for a triangle strip',
                    style: TextStyle(
                      color: Colors.green.shade400,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'final vertices = ui.Vertices(',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '  VertexMode.triangleStrip,',
                    style: TextStyle(
                      color: Colors.orange.shade300,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '  [',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '    Offset(0, 0),   // vertex 0',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '    Offset(50, 100),// vertex 1',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '    Offset(100, 0), // vertex 2',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '    // more vertices...',
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '  ],',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    '  colors: [Colors.red, Colors.green, ...]',
                    style: TextStyle(
                      color: Colors.blue.shade300,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    ');',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    '// Draw the vertices',
                    style: TextStyle(
                      color: Colors.green.shade400,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'canvas.drawVertices(vertices, BlendMode.srcOver, paint);',
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

        // Section 9: Use Cases
        buildSectionCard(
          title: 'When to Use Each Mode',
          icon: Icons.lightbulb_outline,
          color: Colors.amber.shade800,
          children: [
            _buildUseCaseCard(VertexMode.triangles, 'General mesh rendering', [
              '3D models',
              'Custom shapes',
              'Non-contiguous triangles',
              'Complex geometry',
            ], Colors.orange),
            _buildUseCaseCard(VertexMode.triangleStrip, 'Connected surfaces', [
              'Ribbons/trails',
              'Wave effects',
              'Terrain rendering',
              'Smooth curves',
            ], Colors.green),
            _buildUseCaseCard(VertexMode.triangleFan, 'Radial shapes', [
              'Pie charts',
              'Circular gradients',
              'Cones',
              'Radial effects',
            ], Colors.purple),
          ],
        ),

        // Section 10: Enum Properties
        buildSectionCard(
          title: 'Enum Properties',
          icon: Icons.settings,
          color: Colors.grey.shade700,
          children: [
            buildInfoRow('values.length', '${VertexMode.values.length}'),
            buildInfoRow('values.first', '${VertexMode.values.first}'),
            buildInfoRow('values.last', '${VertexMode.values.last}'),
            Divider(height: 24),
            ...List.generate(
              VertexMode.values.length,
              (i) => buildInfoRow('values[$i]', '${VertexMode.values[i]}'),
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
                'VertexMode Demo Complete',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'All ${VertexMode.values.length} modes demonstrated with visual '
                'diagrams showing how each interprets vertex positions.',
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

// Helper for comparison table rows
Widget _buildComparisonRow(String property, String v1, String v2, String v3) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(property, style: TextStyle(fontSize: 12)),
        ),
        Expanded(
          child: Text(
            v1,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
          ),
        ),
        Expanded(
          child: Text(
            v2,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
          ),
        ),
        Expanded(
          child: Text(
            v3,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11),
          ),
        ),
      ],
    ),
  );
}

// Helper for use case cards
Widget _buildUseCaseCard(
  VertexMode mode,
  String title,
  List<String> uses,
  Color color,
) {
  return Card(
    margin: EdgeInsets.symmetric(vertical: 6),
    color: color.withValues(alpha: 0.05),
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              mode.name,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                Wrap(
                  spacing: 6,
                  children: uses
                      .map(
                        (u) => Chip(
                          label: Text(u, style: TextStyle(fontSize: 10)),
                          padding: EdgeInsets.zero,
                          labelPadding: EdgeInsets.symmetric(horizontal: 6),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

/// Painter for triangles mode diagram
class _TrianglesDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Triangle 1 (vertices 0, 1, 2)
    final t1Color = Colors.orange;
    _drawTriangle(canvas, [
      Offset(20, 150),
      Offset(80, 30),
      Offset(140, 150),
    ], t1Color);
    _drawVertexLabels(
      canvas,
      [Offset(20, 150), Offset(80, 30), Offset(140, 150)],
      ['0', '1', '2'],
    );

    // Triangle 2 (vertices 3, 4, 5)
    final t2Color = Colors.blue;
    _drawTriangle(canvas, [
      Offset(160, 150),
      Offset(220, 30),
      Offset(280, 150),
    ], t2Color);
    _drawVertexLabels(
      canvas,
      [Offset(160, 150), Offset(220, 30), Offset(280, 150)],
      ['3', '4', '5'],
    );
  }

  void _drawTriangle(Canvas canvas, List<Offset> points, Color color) {
    final fillPaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    final strokePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final path = Path()
      ..moveTo(points[0].dx, points[0].dy)
      ..lineTo(points[1].dx, points[1].dy)
      ..lineTo(points[2].dx, points[2].dy)
      ..close();

    canvas.drawPath(path, fillPaint);
    canvas.drawPath(path, strokePaint);
  }

  void _drawVertexLabels(
    Canvas canvas,
    List<Offset> points,
    List<String> labels,
  ) {
    for (var i = 0; i < points.length; i++) {
      // Draw vertex circle
      canvas.drawCircle(points[i], 8, Paint()..color = Colors.white);
      canvas.drawCircle(
        points[i],
        8,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );

      // Draw label
      final tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(points[i].dx - 4, points[i].dy - 5));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Painter for triangle strip diagram
class _TriangleStripDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Define vertices for the strip
    final vertices = [
      Offset(20, 150), // 0
      Offset(60, 30), // 1
      Offset(100, 150), // 2
      Offset(140, 30), // 3
      Offset(180, 150), // 4
      Offset(220, 30), // 5
      Offset(260, 150), // 6
    ];

    final colors = [
      Colors.red.withValues(alpha: 0.3),
      Colors.orange.withValues(alpha: 0.3),
      Colors.yellow.withValues(alpha: 0.3),
      Colors.green.withValues(alpha: 0.3),
      Colors.blue.withValues(alpha: 0.3),
    ];

    // Draw triangles in strip order
    for (var i = 0; i < vertices.length - 2; i++) {
      final fillPaint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.fill;
      final strokePaint = Paint()
        ..color = Colors.grey[700]!
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      final path = Path()
        ..moveTo(vertices[i].dx, vertices[i].dy)
        ..lineTo(vertices[i + 1].dx, vertices[i + 1].dy)
        ..lineTo(vertices[i + 2].dx, vertices[i + 2].dy)
        ..close();

      canvas.drawPath(path, fillPaint);
      canvas.drawPath(path, strokePaint);
    }

    // Draw vertex points and labels
    for (var i = 0; i < vertices.length; i++) {
      canvas.drawCircle(vertices[i], 8, Paint()..color = Colors.white);
      canvas.drawCircle(
        vertices[i],
        8,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );

      final tp = TextPainter(
        text: TextSpan(
          text: '$i',
          style: TextStyle(
            color: Colors.black,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(vertices[i].dx - 4, vertices[i].dy - 5));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Painter for triangle fan diagram
class _TriangleFanDiagramPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 20;

    // Create fan vertices - center + 6 around
    final vertices = <Offset>[center];
    for (var i = 0; i < 6; i++) {
      final angle = (i * 60 - 90) * 3.14159265359 / 180;
      vertices.add(
        Offset(
          center.dx + radius * _cos(angle),
          center.dy + radius * _sin(angle),
        ),
      );
    }

    final colors = [
      Colors.red.withValues(alpha: 0.4),
      Colors.orange.withValues(alpha: 0.4),
      Colors.yellow.withValues(alpha: 0.4),
      Colors.green.withValues(alpha: 0.4),
      Colors.blue.withValues(alpha: 0.4),
      Colors.purple.withValues(alpha: 0.4),
    ];

    // Draw triangles in fan order (all share vertex 0)
    for (var i = 1; i < vertices.length - 1; i++) {
      final fillPaint = Paint()
        ..color = colors[(i - 1) % colors.length]
        ..style = PaintingStyle.fill;
      final strokePaint = Paint()
        ..color = Colors.grey[700]!
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1;

      final path = Path()
        ..moveTo(vertices[0].dx, vertices[0].dy)
        ..lineTo(vertices[i].dx, vertices[i].dy)
        ..lineTo(vertices[i + 1].dx, vertices[i + 1].dy)
        ..close();

      canvas.drawPath(path, fillPaint);
      canvas.drawPath(path, strokePaint);
    }

    // Close the fan
    final lastFill = Paint()
      ..color = colors.last
      ..style = PaintingStyle.fill;
    final lastStroke = Paint()
      ..color = Colors.grey[700]!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    final lastPath = Path()
      ..moveTo(vertices[0].dx, vertices[0].dy)
      ..lineTo(vertices.last.dx, vertices.last.dy)
      ..lineTo(vertices[1].dx, vertices[1].dy)
      ..close();
    canvas.drawPath(lastPath, lastFill);
    canvas.drawPath(lastPath, lastStroke);

    // Draw vertex points and labels
    for (var i = 0; i < vertices.length; i++) {
      final isCenter = i == 0;
      canvas.drawCircle(
        vertices[i],
        isCenter ? 12 : 8,
        Paint()..color = isCenter ? Colors.deepPurple : Colors.white,
      );
      canvas.drawCircle(
        vertices[i],
        isCenter ? 12 : 8,
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );

      final tp = TextPainter(
        text: TextSpan(
          text: '$i',
          style: TextStyle(
            color: isCenter ? Colors.white : Colors.black,
            fontSize: isCenter ? 12 : 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(
          vertices[i].dx - (isCenter ? 5 : 4),
          vertices[i].dy - (isCenter ? 6 : 5),
        ),
      );
    }
  }

  double _cos(double r) => 1 - r * r / 2 + r * r * r * r / 24;
  double _sin(double r) => r - r * r * r / 6 + r * r * r * r * r / 120;

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Painter showing colored mesh with different modes
class _ColoredMeshPainter extends CustomPainter {
  final VertexMode mode;

  _ColoredMeshPainter({required this.mode});

  @override
  void paint(Canvas canvas, Size size) {
    List<Offset> positions;
    List<Color> colors;

    switch (mode) {
      case VertexMode.triangles:
        // 2 independent triangles
        positions = [
          Offset(10, 90), Offset(50, 10), Offset(90, 90), // tri1
          Offset(10, 90), Offset(90, 90), Offset(50, 50), // tri2
        ];
        colors = [
          Colors.red,
          Colors.green,
          Colors.blue,
          Colors.yellow,
          Colors.cyan,
          Colors.pink,
        ];
      case VertexMode.triangleStrip:
        positions = [
          Offset(10, 10),
          Offset(10, 90),
          Offset(50, 10),
          Offset(50, 90),
          Offset(90, 10),
          Offset(90, 90),
        ];
        colors = [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.blue,
          Colors.purple,
        ];
      case VertexMode.triangleFan:
        // Center + surrounding vertices
        positions = [
          Offset(50, 50), // center
          Offset(50, 10), Offset(90, 30), Offset(90, 70),
          Offset(50, 90), Offset(10, 70), Offset(10, 30),
        ];
        colors = [
          Colors.white, // center
          Colors.red, Colors.orange, Colors.yellow,
          Colors.green, Colors.blue, Colors.purple,
        ];
    }

    final vertices = ui.Vertices(mode, positions, colors: colors);

    canvas.drawVertices(vertices, BlendMode.srcOver, Paint());

    // Draw outline
    final outlinePaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), outlinePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
