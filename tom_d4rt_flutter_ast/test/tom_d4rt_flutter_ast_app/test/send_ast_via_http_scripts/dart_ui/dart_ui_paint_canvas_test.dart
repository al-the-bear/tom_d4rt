// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for Paint & Canvas interaction from dart:ui
// Covers: Paint configuration with Canvas drawing operations
// Shows how Paint properties affect visual output on Canvas
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Paint & Canvas Interaction Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: PAINT DEFAULTS
  // ═══════════════════════════════════════════════════════════════════════════

  final paint = ui.Paint();
  print('Default Paint:');
  print('  color: ${paint.color}');
  print('  style: ${paint.style}');
  print('  strokeWidth: ${paint.strokeWidth}');
  print('  strokeCap: ${paint.strokeCap}');
  print('  strokeJoin: ${paint.strokeJoin}');
  print('  isAntiAlias: ${paint.isAntiAlias}');
  print('  blendMode: ${paint.blendMode}');
  print('  filterQuality: ${paint.filterQuality}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: PAINT CONFIGURATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  final fillPaint = ui.Paint()
    ..color = Color(0xFF2196F3)
    ..style = ui.PaintingStyle.fill;

  final strokePaint = ui.Paint()
    ..color = Color(0xFFF44336)
    ..style = ui.PaintingStyle.stroke
    ..strokeWidth = 3.0
    ..strokeCap = ui.StrokeCap.round
    ..strokeJoin = ui.StrokeJoin.round;

  final gradientPaint = ui.Paint()
    ..shader = ui.Gradient.linear(Offset(0, 0), Offset(200, 0), [
      Color(0xFF4CAF50),
      Color(0xFF2196F3),
    ]);

  final blurPaint = ui.Paint()
    ..color = Color(0xFF6A1B9A)
    ..maskFilter = ui.MaskFilter.blur(ui.BlurStyle.normal, 5.0);

  print('fillPaint: $fillPaint');
  print('strokePaint: $strokePaint');
  print('gradientPaint: $gradientPaint');
  print('blurPaint: $blurPaint');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: CANVAS OPERATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  print('Canvas drawing operations:');
  print('  drawRect, drawRRect, drawCircle, drawOval');
  print('  drawLine, drawPoints, drawPath');
  print('  drawImage, drawImageRect, drawImageNine');
  print('  drawParagraph, drawVertices, drawAtlas');
  print('  save, restore, translate, rotate, scale, skew');
  print('  clipRect, clipRRect, clipPath');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: PATH OPERATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  final path = ui.Path();
  path.moveTo(0, 0);
  path.lineTo(100, 0);
  path.lineTo(100, 100);
  path.close();
  print('Path created: triangle (3 points)');
  print('  Path.contains(50, 50): ${path.contains(Offset(50, 50))}');
  print('  Path.getBounds(): ${path.getBounds()}');

  print('Paint & Canvas demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF0F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.brush, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'Paint & Canvas',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Drawing operations with Paint configuration',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 1: Paint Styles ──
              _sectionTitle('1. PAINTING STYLE COMPARISON'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _paintStyleBox(
                        'Fill',
                        ui.PaintingStyle.fill,
                        Color(0xFF2196F3),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _paintStyleBox(
                        'Stroke',
                        ui.PaintingStyle.stroke,
                        Color(0xFFF44336),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _paintStyleBox('Both', null, Color(0xFF4CAF50)),
                    ),
                  ],
                ),
              ),

              // ── Section 2: Stroke Width ──
              _sectionTitle('2. STROKE WIDTH'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _strokeWidthRow(1.0, Color(0xFF1565C0)),
                    _strokeWidthRow(3.0, Color(0xFF2E7D32)),
                    _strokeWidthRow(5.0, Color(0xFFE65100)),
                    _strokeWidthRow(8.0, Color(0xFF6A1B9A)),
                    _strokeWidthRow(12.0, Color(0xFFC62828)),
                  ],
                ),
              ),

              // ── Section 3: Stroke Caps ──
              _sectionTitle('3. STROKE CAPS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _capRow(
                      'butt',
                      'Flat end at line endpoint',
                      Color(0xFF1565C0),
                    ),
                    _capRow(
                      'round',
                      'Semicircle at line endpoint',
                      Color(0xFF2E7D32),
                    ),
                    _capRow(
                      'square',
                      'Square extends past endpoint',
                      Color(0xFFE65100),
                    ),
                  ],
                ),
              ),

              // ── Section 4: Stroke Joins ──
              _sectionTitle('4. STROKE JOINS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _joinRow('miter', 'Sharp corner point', Color(0xFF1565C0)),
                    _joinRow('round', 'Rounded corner', Color(0xFF2E7D32)),
                    _joinRow('bevel', 'Flat-cut corner', Color(0xFFE65100)),
                  ],
                ),
              ),

              // ── Section 5: Canvas Operations ──
              _sectionTitle('5. CANVAS DRAWING OPERATIONS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _canvasOpGroup('Shape Drawing', [
                      _canvasOp('drawRect', 'Rectangle from Rect'),
                      _canvasOp('drawRRect', 'Rounded rectangle'),
                      _canvasOp('drawCircle', 'Circle from center+radius'),
                      _canvasOp('drawOval', 'Oval bounded by Rect'),
                      _canvasOp('drawArc', 'Arc segment'),
                    ], Color(0xFF1565C0)),
                    SizedBox(height: 12),
                    _canvasOpGroup('Line & Path', [
                      _canvasOp('drawLine', 'Line between two points'),
                      _canvasOp('drawPoints', 'Multiple points/lines'),
                      _canvasOp('drawPath', 'Complex vector path'),
                    ], Color(0xFF2E7D32)),
                    SizedBox(height: 12),
                    _canvasOpGroup('Image & Text', [
                      _canvasOp('drawImage', 'Image at offset'),
                      _canvasOp('drawImageRect', 'Image src→dst rect'),
                      _canvasOp('drawParagraph', 'Laid-out text'),
                    ], Color(0xFF6A1B9A)),
                    SizedBox(height: 12),
                    _canvasOpGroup('Transform', [
                      _canvasOp('save/restore', 'Save/restore state stack'),
                      _canvasOp('translate', 'Move origin'),
                      _canvasOp('rotate/scale', 'Rotate or scale'),
                      _canvasOp('clipRect/Path', 'Clip to region'),
                    ], Color(0xFFE65100)),
                  ],
                ),
              ),

              // ── Section 6: Blend Modes ──
              _sectionTitle('6. BLEND MODE GALLERY'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: BlendMode.values.take(18).map((mode) {
                    return _blendChip(mode.name);
                  }).toList(),
                ),
              ),

              // ── Section 7: Shader Types ──
              _sectionTitle('7. SHADER TYPES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _shaderRow(
                      'Gradient.linear',
                      LinearGradient(
                        colors: [Color(0xFF2196F3), Color(0xFFF44336)],
                      ),
                    ),
                    SizedBox(height: 10),
                    _shaderRow(
                      'Gradient.radial',
                      RadialGradient(
                        colors: [Color(0xFF4CAF50), Color(0xFF1565C0)],
                      ),
                    ),
                    SizedBox(height: 10),
                    _shaderRow(
                      'Gradient.sweep',
                      SweepGradient(
                        colors: [
                          Color(0xFFF44336),
                          Color(0xFF2196F3),
                          Color(0xFF4CAF50),
                          Color(0xFFF44336),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // ── Section 8: Filter Effects ──
              _sectionTitle('8. FILTER EFFECTS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _filterRow(
                      'MaskFilter.blur(normal, 2)',
                      2.0,
                      Color(0xFF6A1B9A),
                    ),
                    _filterRow(
                      'MaskFilter.blur(normal, 5)',
                      5.0,
                      Color(0xFF2E7D32),
                    ),
                    _filterRow(
                      'MaskFilter.blur(normal, 10)',
                      10.0,
                      Color(0xFF1565C0),
                    ),
                    SizedBox(height: 16),
                    _filterRow('No filter', 0.0, Color(0xFFBF360C)),
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// ─── HELPERS ────────────────────────────────────────────────────────────────

Widget _sectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF455A64),
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _paintStyleBox(String label, ui.PaintingStyle? style, Color color) {
  return Column(
    children: [
      Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: style == ui.PaintingStyle.fill || style == null
              ? color.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: style == ui.PaintingStyle.stroke || style == null
                ? color
                : Colors.transparent,
            width: 3,
          ),
        ),
      ),
      SizedBox(height: 6),
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
      Text(
        style?.name ?? 'fill+stroke',
        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
      ),
    ],
  );
}

Widget _strokeWidthRow(double width, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            '${width}px',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Container(
            height: width,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(width / 2),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _capRow(String name, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          width: 60,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            borderRadius: name == 'round'
                ? BorderRadius.circular(12)
                : name == 'square'
                ? BorderRadius.circular(0)
                : BorderRadius.circular(0),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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

Widget _joinRow(String name, String desc, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            border: Border.all(color: color, width: 3),
            borderRadius: name == 'round'
                ? BorderRadius.circular(8)
                : name == 'bevel'
                ? BorderRadius.circular(4)
                : BorderRadius.circular(0),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
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

Widget _canvasOpGroup(String title, List<Widget> ops, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: color,
          ),
        ),
        SizedBox(height: 6),
        ...ops,
      ],
    ),
  );
}

Widget _canvasOp(String name, String desc) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: [
        Text(
          '  • $name',
          style: TextStyle(
            fontSize: 11,
            fontFamily: 'monospace',
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 6),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 10, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}

Widget _blendChip(String name) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.grey[300]!),
    ),
    child: Text(name, style: TextStyle(fontSize: 9, fontFamily: 'monospace')),
  );
}

Widget _shaderRow(String name, Gradient gradient) {
  return Row(
    children: [
      SizedBox(
        width: 110,
        child: Text(
          name,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
        ),
      ),
      Expanded(
        child: Container(
          height: 28,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(6),
          ),
        ),
      ),
    ],
  );
}

Widget _filterRow(String name, double sigma, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            boxShadow: sigma > 0
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.5),
                      blurRadius: sigma * 2,
                    ),
                  ]
                : null,
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: Text(
            name,
            style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
        ),
      ],
    ),
  );
}
