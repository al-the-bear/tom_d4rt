// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// PaintingStyle deep-demo — demonstrates PaintingStyle.fill & PaintingStyle.stroke
// through visual widgets, Paint-object configuration, and decoration patterns.
// Entry point: dynamic build(BuildContext context)
// ---------------------------------------------------------------------------

// -- helper builders --------------------------------------------------------

Widget _sectionCard(String title, String subtitle, List<Widget> children) {
  return Card(
    margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
          const Divider(height: 20),
          ...children,
        ],
      ),
    ),
  );
}

Widget _label(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6, top: 10),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    ),
  );
}

Widget _smallLabel(String text) {
  return Padding(
    padding: const EdgeInsets.only(top: 4),
    child: Text(
      text,
      style: const TextStyle(fontSize: 11, color: Colors.black54),
    ),
  );
}

Widget _colorBox({
  required double width,
  required double height,
  Color? fillColor,
  Color? borderColor,
  double borderWidth = 0,
  BorderRadius? borderRadius,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: fillColor,
      border: borderColor != null
          ? Border.all(color: borderColor, width: borderWidth)
          : null,
      borderRadius: borderRadius,
    ),
  );
}

Widget _circleBox({
  required double size,
  Color? fillColor,
  Color? borderColor,
  double borderWidth = 0,
}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: fillColor,
      shape: BoxShape.circle,
      border: borderColor != null
          ? Border.all(color: borderColor, width: borderWidth)
          : null,
    ),
  );
}

Widget _gradientBox({
  required double width,
  required double height,
  required Gradient gradient,
  Color? borderColor,
  double borderWidth = 0,
  BorderRadius? borderRadius,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      gradient: gradient,
      border: borderColor != null
          ? Border.all(color: borderColor, width: borderWidth)
          : null,
      borderRadius: borderRadius ?? BorderRadius.circular(4),
    ),
  );
}

Widget _paintInfoTile(String label, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 12, color: Colors.black87),
          ),
        ),
      ],
    ),
  );
}

Widget _chartBar({
  required double widthFraction,
  required double height,
  required Color color,
  required bool isFilled,
  required String label,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 50,
          child: Text(
            label,
            style: const TextStyle(fontSize: 11, color: Colors.black54),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: widthFraction.clamp(0.0, 1.0),
            child: Container(
              height: height,
              decoration: BoxDecoration(
                color: isFilled ? color : null,
                border: Border.all(color: color, width: isFilled ? 0 : 2),
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// -- section builders -------------------------------------------------------

Widget _buildEnumOverview() {
  final Paint fillPaint = Paint()
    ..style = PaintingStyle.fill
    ..color = const Color(0xFF2196F3);

  final Paint strokePaint = Paint()
    ..style = PaintingStyle.stroke
    ..color = const Color(0xFFF44336)
    ..strokeWidth = 3.0;

  print('=== PaintingStyle Enum Overview ===');
  print('PaintingStyle.values: ${PaintingStyle.values}');
  print('PaintingStyle.fill: ${PaintingStyle.fill}');
  print('PaintingStyle.stroke: ${PaintingStyle.stroke}');
  print('PaintingStyle.fill.index: ${PaintingStyle.fill.index}');
  print('PaintingStyle.stroke.index: ${PaintingStyle.stroke.index}');
  print('PaintingStyle.fill.name: ${PaintingStyle.fill.name}');
  print('PaintingStyle.stroke.name: ${PaintingStyle.stroke.name}');
  print('fillPaint.style: ${fillPaint.style}');
  print('strokePaint.style: ${strokePaint.style}');
  print('fillPaint.color: ${fillPaint.color}');
  print('strokePaint.strokeWidth: ${strokePaint.strokeWidth}');

  return _sectionCard(
    'Section 0 — PaintingStyle Enum Overview',
    'Two values: fill (interior) and stroke (outline)',
    <Widget>[
      _paintInfoTile('PaintingStyle.values', PaintingStyle.values.toString()),
      _paintInfoTile('fill.toString()', PaintingStyle.fill.toString()),
      _paintInfoTile('stroke.toString()', PaintingStyle.stroke.toString()),
      _paintInfoTile('fill.index', PaintingStyle.fill.index.toString()),
      _paintInfoTile('stroke.index', PaintingStyle.stroke.index.toString()),
      _paintInfoTile('fill.name', PaintingStyle.fill.name),
      _paintInfoTile('stroke.name', PaintingStyle.stroke.name),
      const Divider(height: 16),
      _label('Paint configured for fill'),
      _paintInfoTile('style', fillPaint.style.toString()),
      _paintInfoTile('color', fillPaint.color.toString()),
      _paintInfoTile('isAntiAlias', fillPaint.isAntiAlias.toString()),
      const SizedBox(height: 8),
      _label('Paint configured for stroke'),
      _paintInfoTile('style', strokePaint.style.toString()),
      _paintInfoTile('color', strokePaint.color.toString()),
      _paintInfoTile('strokeWidth', strokePaint.strokeWidth.toString()),
      _paintInfoTile('strokeCap', strokePaint.strokeCap.toString()),
      _paintInfoTile('strokeJoin', strokePaint.strokeJoin.toString()),
    ],
  );
}

Widget _buildFillVsStrokeComparison() {
  print('=== Section 1: Fill vs Stroke Comparison ===');
  print(
    'Demonstrating same shapes with PaintingStyle.fill vs PaintingStyle.stroke',
  );

  return _sectionCard(
    'Section 1 — Fill vs Stroke Comparison',
    'Same shapes rendered with fill (solid) and stroke (outline)',
    <Widget>[
      _label('Rectangles'),
      Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              _colorBox(width: 80, height: 60, fillColor: Colors.blue),
              _smallLabel('fill'),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: <Widget>[
              _colorBox(
                width: 80,
                height: 60,
                borderColor: Colors.blue,
                borderWidth: 3,
              ),
              _smallLabel('stroke (3px)'),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: <Widget>[
              _colorBox(
                width: 80,
                height: 60,
                fillColor: Colors.blue.withValues(alpha: 0.2),
                borderColor: Colors.blue,
                borderWidth: 3,
              ),
              _smallLabel('fill + stroke'),
            ],
          ),
        ],
      ),
      const SizedBox(height: 16),
      _label('Circles'),
      Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              _circleBox(size: 70, fillColor: Colors.red),
              _smallLabel('fill'),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: <Widget>[
              _circleBox(size: 70, borderColor: Colors.red, borderWidth: 3),
              _smallLabel('stroke (3px)'),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: <Widget>[
              _circleBox(
                size: 70,
                fillColor: Colors.red.withValues(alpha: 0.15),
                borderColor: Colors.red,
                borderWidth: 3,
              ),
              _smallLabel('fill + stroke'),
            ],
          ),
        ],
      ),
      const SizedBox(height: 16),
      _label('Rounded Rectangles'),
      Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              _colorBox(
                width: 80,
                height: 60,
                fillColor: Colors.green,
                borderRadius: BorderRadius.circular(16),
              ),
              _smallLabel('fill'),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: <Widget>[
              _colorBox(
                width: 80,
                height: 60,
                borderColor: Colors.green,
                borderWidth: 3,
                borderRadius: BorderRadius.circular(16),
              ),
              _smallLabel('stroke (3px)'),
            ],
          ),
          const SizedBox(width: 20),
          Column(
            children: <Widget>[
              _colorBox(
                width: 80,
                height: 60,
                fillColor: Colors.green.withValues(alpha: 0.15),
                borderColor: Colors.green,
                borderWidth: 3,
                borderRadius: BorderRadius.circular(16),
              ),
              _smallLabel('fill + stroke'),
            ],
          ),
        ],
      ),
    ],
  );
}

Widget _buildStrokeWidthVariations() {
  print('=== Section 2: Stroke Width Variations ===');

  final List<double> widths = <double>[1, 2, 3, 4, 6, 8, 10, 14];
  for (final double w in widths) {
    final Paint p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = w
      ..color = const Color(0xFF9C27B0);
    print('  strokeWidth=$w => paint.strokeWidth=${p.strokeWidth}');
  }

  return _sectionCard(
    'Section 2 — Stroke Width Variations',
    'PaintingStyle.stroke with increasing strokeWidth values',
    <Widget>[
      _label('Rectangle outlines at different stroke widths'),
      ...widths.map((double w) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 80,
                child: Text(
                  '${w.toStringAsFixed(0)}px',
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ),
              _colorBox(
                width: 120,
                height: 40,
                borderColor: Colors.purple,
                borderWidth: w,
                borderRadius: BorderRadius.circular(6),
              ),
            ],
          ),
        );
      }),
      const SizedBox(height: 12),
      _label('Circle outlines at different stroke widths'),
      Wrap(
        spacing: 12,
        runSpacing: 8,
        children: <Widget>[
          ...widths.map((double w) {
            return Column(
              children: <Widget>[
                _circleBox(
                  size: 50,
                  borderColor: Colors.deepOrange,
                  borderWidth: w,
                ),
                _smallLabel('${w.toStringAsFixed(0)}px'),
              ],
            );
          }),
        ],
      ),
    ],
  );
}

Widget _buildCombinedFillStroke() {
  print('=== Section 3: Combined Fill + Stroke ===');
  print('Drawing filled shapes with stroke outlines overlaid');

  final List<Map<String, dynamic>> combos = <Map<String, dynamic>>[
    <String, dynamic>{
      'fill': Colors.lightBlue.shade100,
      'stroke': Colors.blue.shade800,
      'label': 'Light fill + dark stroke',
    },
    <String, dynamic>{
      'fill': Colors.amber.shade100,
      'stroke': Colors.orange.shade800,
      'label': 'Warm fill + outline',
    },
    <String, dynamic>{
      'fill': Colors.pink.shade50,
      'stroke': Colors.pink.shade700,
      'label': 'Subtle fill + bold stroke',
    },
    <String, dynamic>{
      'fill': Colors.teal.shade50,
      'stroke': Colors.teal.shade600,
      'label': 'Teal variation',
    },
  ];

  for (final Map<String, dynamic> c in combos) {
    final Paint fp = Paint()
      ..style = PaintingStyle.fill
      ..color = c['fill'] as Color;
    final Paint sp = Paint()
      ..style = PaintingStyle.stroke
      ..color = c['stroke'] as Color
      ..strokeWidth = 3;
    print(
      '  ${c['label']}: fill=${fp.color}, stroke=${sp.color}, '
      'strokeWidth=${sp.strokeWidth}',
    );
  }

  return _sectionCard(
    'Section 3 — Combined Fill + Stroke Effect',
    'Filled shape with stroke outline drawn on top',
    <Widget>[
      _label('Rectangles with fill + stroke overlay'),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: combos.map((Map<String, dynamic> c) {
          return Column(
            children: <Widget>[
              Container(
                width: 80,
                height: 60,
                decoration: BoxDecoration(
                  color: c['fill'] as Color,
                  border: Border.all(color: c['stroke'] as Color, width: 3),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: 80,
                child: Text(
                  c['label'] as String,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 10),
                ),
              ),
            ],
          );
        }).toList(),
      ),
      const SizedBox(height: 16),
      _label('Circles with fill + stroke overlay'),
      Wrap(
        spacing: 16,
        runSpacing: 12,
        children: combos.map((Map<String, dynamic> c) {
          return Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: c['fill'] as Color,
              shape: BoxShape.circle,
              border: Border.all(color: c['stroke'] as Color, width: 3),
            ),
          );
        }).toList(),
      ),
      const SizedBox(height: 16),
      _label('Varying stroke on same fill'),
      Row(
        children: <double>[1, 2, 4, 6, 8].map((double w) {
          return Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Column(
              children: <Widget>[
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    border: Border.all(color: Colors.indigo, width: w),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                _smallLabel('${w.toStringAsFixed(0)}px'),
              ],
            ),
          );
        }).toList(),
      ),
    ],
  );
}

Widget _buildComplexShapes() {
  print('=== Section 4: Complex Shapes (Clipped Paths) ===');
  print('Using ClipPath to create star and diamond shapes');
  print('Simulating fill vs stroke via Container decorations');

  return _sectionCard(
    'Section 4 — Complex Shapes with Fill vs Stroke',
    'Diamond and hexagonal shapes using clip and decoration',
    <Widget>[
      _label('Diamond shapes — fill vs stroke'),
      Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              Transform.rotate(
                angle: 0.785398, // 45 degrees
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 12),
              _smallLabel('fill'),
            ],
          ),
          const SizedBox(width: 30),
          Column(
            children: <Widget>[
              Transform.rotate(
                angle: 0.785398,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.deepPurple, width: 3),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _smallLabel('stroke'),
            ],
          ),
          const SizedBox(width: 30),
          Column(
            children: <Widget>[
              Transform.rotate(
                angle: 0.785398,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: 0.15),
                    border: Border.all(color: Colors.deepPurple, width: 3),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              _smallLabel('fill+stroke'),
            ],
          ),
        ],
      ),
      const SizedBox(height: 20),
      _label('Nested shapes — outer stroke, inner fill'),
      Center(
        child: SizedBox(
          width: 120,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _circleBox(size: 120, borderColor: Colors.red, borderWidth: 3),
              _circleBox(size: 90, fillColor: Colors.red.shade100),
              _circleBox(
                size: 90,
                borderColor: Colors.red.shade400,
                borderWidth: 2,
              ),
              _circleBox(size: 60, fillColor: Colors.red.shade200),
              _circleBox(
                size: 60,
                borderColor: Colors.red.shade600,
                borderWidth: 2,
              ),
              _circleBox(size: 30, fillColor: Colors.red.shade400),
            ],
          ),
        ),
      ),
      const SizedBox(height: 20),
      _label('Rounded-rect nesting — alternating fill/stroke'),
      Center(
        child: SizedBox(
          width: 200,
          height: 120,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              _colorBox(
                width: 200,
                height: 120,
                borderColor: Colors.teal.shade700,
                borderWidth: 3,
                borderRadius: BorderRadius.circular(20),
              ),
              _colorBox(
                width: 170,
                height: 95,
                fillColor: Colors.teal.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              _colorBox(
                width: 140,
                height: 70,
                borderColor: Colors.teal.shade500,
                borderWidth: 2,
                borderRadius: BorderRadius.circular(12),
              ),
              _colorBox(
                width: 110,
                height: 50,
                fillColor: Colors.teal.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              _colorBox(
                width: 80,
                height: 30,
                borderColor: Colors.teal.shade300,
                borderWidth: 2,
                borderRadius: BorderRadius.circular(6),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

Widget _buildGradientStyles() {
  print('=== Section 5: PaintingStyle with Gradients ===');
  print('fill style with gradient fills; stroke borders around gradient boxes');

  final Paint gradFill = Paint()
    ..style = PaintingStyle.fill
    ..shader = const LinearGradient(
      colors: <Color>[Color(0xFF2196F3), Color(0xFF9C27B0)],
    ).createShader(const Rect.fromLTWH(0, 0, 200, 60));
  print('  gradFill.style: ${gradFill.style}');
  print('  gradFill.shader is non-null: ${gradFill.shader != null}');

  return _sectionCard(
    'Section 5 — PaintingStyle with Gradients',
    'Gradient fills (PaintingStyle.fill) + stroke outlines around them',
    <Widget>[
      _label('Linear gradient — fill only'),
      _gradientBox(
        width: 250,
        height: 60,
        gradient: const LinearGradient(
          colors: <Color>[Colors.blue, Colors.purple],
        ),
      ),
      const SizedBox(height: 12),
      _label('Linear gradient — fill + stroke border'),
      _gradientBox(
        width: 250,
        height: 60,
        gradient: const LinearGradient(
          colors: <Color>[Colors.blue, Colors.purple],
        ),
        borderColor: Colors.black87,
        borderWidth: 3,
        borderRadius: BorderRadius.circular(12),
      ),
      const SizedBox(height: 12),
      _label('Radial gradient — fill only (circle)'),
      Container(
        width: 100,
        height: 100,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: <Color>[Colors.yellow, Colors.orange, Colors.red],
          ),
        ),
      ),
      const SizedBox(height: 12),
      _label('Radial gradient — fill + stroke'),
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const RadialGradient(
            colors: <Color>[Colors.yellow, Colors.orange, Colors.red],
          ),
          border: Border.all(color: Colors.red.shade900, width: 4),
        ),
      ),
      const SizedBox(height: 12),
      _label('Sweep gradient — fill + thin stroke'),
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const SweepGradient(
            colors: <Color>[
              Colors.red,
              Colors.orange,
              Colors.yellow,
              Colors.green,
              Colors.blue,
              Colors.purple,
              Colors.red,
            ],
          ),
          border: Border.all(color: Colors.black, width: 2),
        ),
      ),
      const SizedBox(height: 12),
      _label('Multiple gradient boxes — stroke comparison'),
      Row(
        children: <Widget>[
          Column(
            children: <Widget>[
              _gradientBox(
                width: 80,
                height: 50,
                gradient: const LinearGradient(
                  colors: <Color>[Colors.green, Colors.teal],
                ),
              ),
              _smallLabel('fill only'),
            ],
          ),
          const SizedBox(width: 12),
          Column(
            children: <Widget>[
              _gradientBox(
                width: 80,
                height: 50,
                gradient: const LinearGradient(
                  colors: <Color>[Colors.green, Colors.teal],
                ),
                borderColor: Colors.teal.shade900,
                borderWidth: 2,
              ),
              _smallLabel('fill + 2px stroke'),
            ],
          ),
          const SizedBox(width: 12),
          Column(
            children: <Widget>[
              _gradientBox(
                width: 80,
                height: 50,
                gradient: const LinearGradient(
                  colors: <Color>[Colors.green, Colors.teal],
                ),
                borderColor: Colors.teal.shade900,
                borderWidth: 5,
              ),
              _smallLabel('fill + 5px stroke'),
            ],
          ),
        ],
      ),
    ],
  );
}

Widget _buildPracticalExamples() {
  print('=== Section 6: Practical Examples ===');
  print('Chart bars (filled), wireframes (stroked), buttons, badges');

  final List<Map<String, dynamic>> data = <Map<String, dynamic>>[
    <String, dynamic>{'label': 'Jan', 'value': 0.8},
    <String, dynamic>{'label': 'Feb', 'value': 0.6},
    <String, dynamic>{'label': 'Mar', 'value': 0.95},
    <String, dynamic>{'label': 'Apr', 'value': 0.45},
    <String, dynamic>{'label': 'May', 'value': 0.7},
    <String, dynamic>{'label': 'Jun', 'value': 0.55},
  ];

  for (final Map<String, dynamic> d in data) {
    print('  bar ${d['label']}: value=${d['value']}');
  }

  return _sectionCard(
    'Section 6 — Practical Examples',
    'Real-world patterns using fill and stroke painting styles',
    <Widget>[
      _label('Filled chart bars (PaintingStyle.fill)'),
      ...data.map((Map<String, dynamic> d) {
        return _chartBar(
          widthFraction: d['value'] as double,
          height: 22,
          color: Colors.blue,
          isFilled: true,
          label: d['label'] as String,
        );
      }),
      const SizedBox(height: 16),
      _label('Wireframe chart bars (PaintingStyle.stroke)'),
      ...data.map((Map<String, dynamic> d) {
        return _chartBar(
          widthFraction: d['value'] as double,
          height: 22,
          color: Colors.blue,
          isFilled: false,
          label: d['label'] as String,
        );
      }),
      const SizedBox(height: 20),
      _label('Button styles — filled vs outlined'),
      Row(
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              print('Filled button tapped (PaintingStyle.fill analogy)');
            },
            child: const Text('Filled'),
          ),
          const SizedBox(width: 12),
          OutlinedButton(
            onPressed: () {
              print('Outlined button tapped (PaintingStyle.stroke analogy)');
            },
            child: const Text('Outlined'),
          ),
        ],
      ),
      const SizedBox(height: 16),
      _label('Badge styles — filled vs stroked'),
      Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Fill badge',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Stroke badge',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              border: Border.all(color: Colors.red, width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Both',
              style: TextStyle(color: Colors.red, fontSize: 12),
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      _label('Card elevation effect — layered fill + stroke'),
      Stack(
        children: <Widget>[
          Positioned(
            left: 4,
            top: 4,
            child: _colorBox(
              width: 200,
              height: 80,
              fillColor: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          _colorBox(
            width: 200,
            height: 80,
            fillColor: Colors.white,
            borderColor: Colors.grey.shade400,
            borderWidth: 1,
            borderRadius: BorderRadius.circular(8),
          ),
        ],
      ),
      const SizedBox(height: 16),
      _label('Icon placeholder — fill vs stroke outlines'),
      Row(
        children: <Widget>[
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.star, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.star_border, color: Colors.blue, size: 28),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              border: Border.all(color: Colors.blue, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.star_half, color: Colors.blue, size: 28),
          ),
        ],
      ),
    ],
  );
}

Widget _buildPaintObjectDetails() {
  print('=== Section 7: Paint Object Configuration Details ===');

  final Paint p1 = Paint()
    ..style = PaintingStyle.fill
    ..color = const Color(0xFFFF5722)
    ..isAntiAlias = true;

  final Paint p2 = Paint()
    ..style = PaintingStyle.stroke
    ..color = const Color(0xFF4CAF50)
    ..strokeWidth = 5.0
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..isAntiAlias = true;

  final Paint p3 = Paint()
    ..style = PaintingStyle.stroke
    ..color = const Color(0xFF2196F3)
    ..strokeWidth = 3.0
    ..strokeCap = StrokeCap.square
    ..strokeJoin = StrokeJoin.bevel;

  final Paint p4 = Paint()
    ..style = PaintingStyle.stroke
    ..color = const Color(0xFF9C27B0)
    ..strokeWidth = 2.0
    ..strokeCap = StrokeCap.butt
    ..strokeJoin = StrokeJoin.miter
    ..strokeMiterLimit = 10.0;

  print('p1 (fill): style=${p1.style}, color=${p1.color}');
  print(
    'p2 (stroke round): style=${p2.style}, strokeWidth=${p2.strokeWidth}, '
    'cap=${p2.strokeCap}, join=${p2.strokeJoin}',
  );
  print(
    'p3 (stroke square): style=${p3.style}, strokeWidth=${p3.strokeWidth}, '
    'cap=${p3.strokeCap}, join=${p3.strokeJoin}',
  );
  print(
    'p4 (stroke miter): style=${p4.style}, strokeWidth=${p4.strokeWidth}, '
    'cap=${p4.strokeCap}, join=${p4.strokeJoin}, '
    'miterLimit=${p4.strokeMiterLimit}',
  );

  return _sectionCard(
    'Section 7 — Paint Object Configuration',
    'Detailed Paint properties for fill and stroke styles',
    <Widget>[
      _label('Paint #1 — Fill style'),
      _paintInfoTile('style', p1.style.toString()),
      _paintInfoTile('color', p1.color.toString()),
      _paintInfoTile('isAntiAlias', p1.isAntiAlias.toString()),
      _paintInfoTile('blendMode', p1.blendMode.toString()),
      _paintInfoTile('filterQuality', p1.filterQuality.toString()),
      const Divider(height: 16),
      _label('Paint #2 — Stroke round caps/joins'),
      _paintInfoTile('style', p2.style.toString()),
      _paintInfoTile('strokeWidth', p2.strokeWidth.toString()),
      _paintInfoTile('strokeCap', p2.strokeCap.toString()),
      _paintInfoTile('strokeJoin', p2.strokeJoin.toString()),
      _paintInfoTile('isAntiAlias', p2.isAntiAlias.toString()),
      const Divider(height: 16),
      _label('Paint #3 — Stroke square caps / bevel joins'),
      _paintInfoTile('style', p3.style.toString()),
      _paintInfoTile('strokeWidth', p3.strokeWidth.toString()),
      _paintInfoTile('strokeCap', p3.strokeCap.toString()),
      _paintInfoTile('strokeJoin', p3.strokeJoin.toString()),
      const Divider(height: 16),
      _label('Paint #4 — Stroke butt caps / miter joins'),
      _paintInfoTile('style', p4.style.toString()),
      _paintInfoTile('strokeWidth', p4.strokeWidth.toString()),
      _paintInfoTile('strokeCap', p4.strokeCap.toString()),
      _paintInfoTile('strokeJoin', p4.strokeJoin.toString()),
      _paintInfoTile('strokeMiterLimit', p4.strokeMiterLimit.toString()),
    ],
  );
}

Widget _buildEqualityAndIdentity() {
  print('=== Section 8: Equality and Identity ===');

  final bool fillEqualsFill = PaintingStyle.fill == PaintingStyle.fill;
  final bool fillEqualsStroke = PaintingStyle.fill == PaintingStyle.stroke;
  final bool strokeEqualsStroke = PaintingStyle.stroke == PaintingStyle.stroke;
  final bool indexComparison =
      PaintingStyle.fill.index < PaintingStyle.stroke.index;

  print('fill == fill: $fillEqualsFill');
  print('fill == stroke: $fillEqualsStroke');
  print('stroke == stroke: $strokeEqualsStroke');
  print('fill.index < stroke.index: $indexComparison');
  print('fill.hashCode: ${PaintingStyle.fill.hashCode}');
  print('stroke.hashCode: ${PaintingStyle.stroke.hashCode}');

  return _sectionCard(
    'Section 8 — Equality, Identity & Iteration',
    'Enum comparison, identity, and iteration over values',
    <Widget>[
      _label('Equality checks'),
      _paintInfoTile('fill == fill', fillEqualsFill.toString()),
      _paintInfoTile('fill == stroke', fillEqualsStroke.toString()),
      _paintInfoTile('stroke == stroke', strokeEqualsStroke.toString()),
      _paintInfoTile('fill.index < stroke.index', indexComparison.toString()),
      const Divider(height: 16),
      _label('Hash codes'),
      _paintInfoTile('fill.hashCode', PaintingStyle.fill.hashCode.toString()),
      _paintInfoTile(
        'stroke.hashCode',
        PaintingStyle.stroke.hashCode.toString(),
      ),
      const Divider(height: 16),
      _label('Iterating PaintingStyle.values'),
      ...PaintingStyle.values.map((PaintingStyle style) {
        return _paintInfoTile(
          'values[${style.index}]',
          '${style.name} — ${style.toString()}',
        );
      }),
      const Divider(height: 16),
      _label('Visual summary per value'),
      ...PaintingStyle.values.map((PaintingStyle style) {
        final bool isFill = style == PaintingStyle.fill;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isFill ? Colors.indigo : null,
                  border: isFill
                      ? null
                      : Border.all(color: Colors.indigo, width: 3),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${style.name}: ${isFill ? "fills interior" : "draws outline"}',
                style: const TextStyle(fontSize: 13),
              ),
            ],
          ),
        );
      }),
    ],
  );
}

// -- main entry point -------------------------------------------------------

dynamic build(BuildContext context) {
  print('========================================');
  print('PaintingStyle Deep Demo');
  print('========================================');
  print('PaintingStyle is a dart:ui enum with two values:');
  print('  - PaintingStyle.fill   (index ${PaintingStyle.fill.index})');
  print('  - PaintingStyle.stroke (index ${PaintingStyle.stroke.index})');
  print('It controls whether Paint fills or strokes shapes.');
  print('========================================');

  return SingleChildScrollView(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'PaintingStyle Deep Demo',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Text(
            'Demonstrates PaintingStyle.fill and PaintingStyle.stroke '
            'through visual widgets, Paint configuration, and decoration patterns.',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
        const SizedBox(height: 8),
        _buildEnumOverview(),
        _buildFillVsStrokeComparison(),
        _buildStrokeWidthVariations(),
        _buildCombinedFillStroke(),
        _buildComplexShapes(),
        _buildGradientStyles(),
        _buildPracticalExamples(),
        _buildPaintObjectDetails(),
        _buildEqualityAndIdentity(),
        const SizedBox(height: 32),
      ],
    ),
  );
}
