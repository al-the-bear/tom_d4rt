// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for AlignmentGeometryTween from rendering
//
// AlignmentGeometryTween animates between AlignmentGeometry values.
// It can tween between Alignment and AlignmentDirectional values.
//
// Key features:
//   - Inherits from Tween<AlignmentGeometry?>
//   - lerp() interpolates between two alignments
//   - Works with both LTR and RTL layouts
//   - Supports mixed Alignment and AlignmentDirectional
//
// AlignmentGeometry is the abstract base class for:
//   - Alignment: Uses x, y coordinates
//   - AlignmentDirectional: Uses start, y coordinates (RTL-aware)
//
// Common alignment values:
//   - Alignment.topLeft, topCenter, topRight
//   - Alignment.centerLeft, center, centerRight
//   - Alignment.bottomLeft, bottomCenter, bottomRight
//   - AlignmentDirectional.topStart, topEnd
//   - AlignmentDirectional.centerStart, centerEnd
//   - AlignmentDirectional.bottomStart, bottomEnd
//
// This demo visually demonstrates alignment tweening.

import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [const Color(0xFF1565C0), const Color(0xFF42A5F5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF1565C0).withAlpha(100),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.animation, size: 48, color: Colors.white),
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
            color: const Color(0xFF42A5F5).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF1565C0), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1565C0),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAlignmentValuesCard() {
  final alignments = <Map<String, dynamic>>[
    {'name': 'topLeft', 'x': -1.0, 'y': -1.0, 'icon': Icons.north_west},
    {'name': 'topCenter', 'x': 0.0, 'y': -1.0, 'icon': Icons.north},
    {'name': 'topRight', 'x': 1.0, 'y': -1.0, 'icon': Icons.north_east},
    {'name': 'centerLeft', 'x': -1.0, 'y': 0.0, 'icon': Icons.west},
    {'name': 'center', 'x': 0.0, 'y': 0.0, 'icon': Icons.center_focus_strong},
    {'name': 'centerRight', 'x': 1.0, 'y': 0.0, 'icon': Icons.east},
    {'name': 'bottomLeft', 'x': -1.0, 'y': 1.0, 'icon': Icons.south_west},
    {'name': 'bottomCenter', 'x': 0.0, 'y': 1.0, 'icon': Icons.south},
    {'name': 'bottomRight', 'x': 1.0, 'y': 1.0, 'icon': Icons.south_east},
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
            Icon(Icons.grid_3x3, color: const Color(0xFF1565C0)),
            const SizedBox(width: 8),
            const Text(
              'Alignment Constants',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // 3x3 grid showing alignments
        SizedBox(
          height: 150,
          child: CustomPaint(
            size: const Size(double.infinity, 150),
            painter: _AlignmentGridPainter(alignments),
          ),
        ),
      ],
    ),
  );
}

class _AlignmentGridPainter extends CustomPainter {
  final List<Map<String, dynamic>> alignments;
  _AlignmentGridPainter(this.alignments);

  @override
  void paint(Canvas canvas, Size size) {
    final cellW = size.width / 3;
    final cellH = size.height / 3;

    // Grid lines
    final gridPaint = Paint()
      ..color = Colors.grey.withAlpha(60)
      ..strokeWidth = 1;

    for (var i = 1; i < 3; i++) {
      canvas.drawLine(
        Offset(i * cellW, 0),
        Offset(i * cellW, size.height),
        gridPaint,
      );
      canvas.drawLine(
        Offset(0, i * cellH),
        Offset(size.width, i * cellH),
        gridPaint,
      );
    }

    // Border
    final borderPaint = Paint()
      ..color = const Color(0xFF1565C0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), borderPaint);

    // Dots and labels
    for (var a in alignments) {
      final x = ((a['x'] as double) + 1) / 2 * size.width;
      final y = ((a['y'] as double) + 1) / 2 * size.height;

      final dotPaint = Paint()
        ..color = const Color(0xFF1565C0)
        ..style = PaintingStyle.fill;
      canvas.drawCircle(Offset(x, y), 6, dotPaint);

      // Label
      final tp = TextPainter(
        text: TextSpan(
          text: a['name'] as String,
          style: const TextStyle(
            color: Color(0xFF1565C0),
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      tp.layout();

      var labelX = x - tp.width / 2;
      var labelY = y + 8;
      if (y < 20) labelY = y + 10;
      if (y > size.height - 20) labelY = y - tp.height - 8;
      if (x < 40) labelX = x + 10;
      if (x > size.width - 40) labelX = x - tp.width - 10;

      tp.paint(canvas, Offset(labelX, labelY));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildDirectionalCard() {
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
            Icon(Icons.swap_horiz, color: const Color(0xFF1565C0)),
            const SizedBox(width: 8),
            const Text(
              'AlignmentDirectional',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildDirectionalDemo('LTR', TextDirection.ltr)),
            const SizedBox(width: 12),
            Expanded(child: _buildDirectionalDemo('RTL', TextDirection.rtl)),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'start/end adapt to text direction',
            style: TextStyle(fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

Widget _buildDirectionalDemo(String label, TextDirection dir) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      border: Border.all(color: const Color(0xFF1565C0)),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 50,
          child: Directionality(
            textDirection: dir,
            child: Stack(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'S',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text(
                        'E',
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
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

Widget _buildTweenConceptCard() {
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
            Icon(Icons.trending_flat, color: const Color(0xFF1565C0)),
            const SizedBox(width: 8),
            const Text(
              'Tween Concept',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 80,
          child: CustomPaint(
            size: const Size(double.infinity, 80),
            painter: _TweenConceptPainter(),
          ),
        ),
        const SizedBox(height: 8),
        _buildCodeSnippet(
          'final tween = AlignmentGeometryTween(\n'
          '  begin: Alignment.topLeft,\n'
          '  end: Alignment.bottomRight,\n'
          ');\n'
          '\n'
          '// At t=0.5, returns Alignment.center\n'
          'final mid = tween.lerp(0.5);',
        ),
      ],
    ),
  );
}

class _TweenConceptPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final startX = 30.0;
    final endX = size.width - 30;
    final y = size.height / 2;

    // Arrow line
    final linePaint = Paint()
      ..color = const Color(0xFF1565C0)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(Offset(startX, y), Offset(endX, y), linePaint);

    // Arrowhead
    final path = Path()
      ..moveTo(endX - 10, y - 6)
      ..lineTo(endX, y)
      ..lineTo(endX - 10, y + 6);
    canvas.drawPath(path, linePaint);

    // Start point
    final dotPaint = Paint()
      ..color = const Color(0xFF4CAF50)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(startX, y), 10, dotPaint);
    _drawLabel(canvas, 't=0', Offset(startX - 8, y + 15));
    _drawLabel(canvas, 'begin', Offset(startX - 12, y - 25));

    // Mid point
    final midX = (startX + endX) / 2;
    dotPaint.color = Colors.orange;
    canvas.drawCircle(Offset(midX, y), 8, dotPaint);
    _drawLabel(canvas, 't=0.5', Offset(midX - 12, y + 15));

    // End point
    dotPaint.color = const Color(0xFFE53935);
    canvas.drawCircle(Offset(endX, y), 10, dotPaint);
    _drawLabel(canvas, 't=1', Offset(endX - 8, y + 15));
    _drawLabel(canvas, 'end', Offset(endX - 8, y - 25));
  }

  void _drawLabel(Canvas canvas, String text, Offset pos) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Color(0xFF1565C0),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, pos);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildLerpVisualization(AlignmentGeometryTween tween) {
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
            Icon(Icons.moving, color: const Color(0xFF1565C0)),
            const SizedBox(width: 8),
            const Text(
              'Lerp Visualization',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: CustomPaint(
            size: const Size(double.infinity, 120),
            painter: _LerpVisualizationPainter(tween),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLerpChip('t=0.0', const Color(0xFF4CAF50)),
            _buildLerpChip('t=0.25', const Color(0xFF8BC34A)),
            _buildLerpChip('t=0.5', Colors.orange),
            _buildLerpChip('t=0.75', const Color(0xFFFF7043)),
            _buildLerpChip('t=1.0', const Color(0xFFE53935)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildLerpChip(String label, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      label,
      style: const TextStyle(
        fontSize: 9,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

class _LerpVisualizationPainter extends CustomPainter {
  final AlignmentGeometryTween tween;
  _LerpVisualizationPainter(this.tween);

  @override
  void paint(Canvas canvas, Size size) {
    // Box
    final boxRect = Rect.fromLTWH(20, 10, size.width - 40, size.height - 20);
    final boxPaint = Paint()
      ..color = const Color(0xFFE3F2FD)
      ..style = PaintingStyle.fill;
    canvas.drawRRect(RRect.fromRectXY(boxRect, 8, 8), boxPaint);

    final borderPaint = Paint()
      ..color = const Color(0xFF1565C0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(RRect.fromRectXY(boxRect, 8, 8), borderPaint);

    // Draw interpolated positions
    final colors = [
      const Color(0xFF4CAF50),
      const Color(0xFF8BC34A),
      Colors.orange,
      const Color(0xFFFF7043),
      const Color(0xFFE53935),
    ];

    // Draw path line
    final pathPaint = Paint()
      ..color = Colors.grey.withAlpha(100)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final pathPoints = <Offset>[];
    for (var t = 0.0; t <= 1.0; t += 0.1) {
      final alignment = tween.lerp(t) as Alignment;
      final x = boxRect.left + (alignment.x + 1) / 2 * boxRect.width;
      final y = boxRect.top + (alignment.y + 1) / 2 * boxRect.height;
      pathPoints.add(Offset(x, y));
    }

    for (var i = 0; i < pathPoints.length - 1; i++) {
      canvas.drawLine(pathPoints[i], pathPoints[i + 1], pathPaint);
    }

    // Draw main points
    for (var i = 0; i < 5; i++) {
      final t = i / 4;
      final alignment = tween.lerp(t) as Alignment;
      final x = boxRect.left + (alignment.x + 1) / 2 * boxRect.width;
      final y = boxRect.top + (alignment.y + 1) / 2 * boxRect.height;

      final dotPaint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;

      final radius = i == 0 || i == 4 ? 10.0 : 7.0;
      canvas.drawCircle(Offset(x, y), radius, dotPaint);
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

Widget _buildAnimationUsage() {
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
            Icon(Icons.play_circle, color: const Color(0xFF1565C0)),
            const SizedBox(width: 8),
            const Text(
              'Animation Usage',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildCodeSnippet(
          'class _MyWidgetState extends State<MyWidget>\n'
          '    with SingleTickerProviderStateMixin {\n'
          '  late AnimationController _controller;\n'
          '  late Animation<AlignmentGeometry?> _animation;\n'
          '\n'
          '  @override\n'
          '  void initState() {\n'
          '    super.initState();\n'
          '    _controller = AnimationController(\n'
          '      duration: const Duration(seconds: 2),\n'
          '      vsync: this,\n'
          '    );\n'
          '    _animation = AlignmentGeometryTween(\n'
          '      begin: Alignment.topLeft,\n'
          '      end: Alignment.bottomRight,\n'
          '    ).animate(_controller);\n'
          '  }\n'
          '}',
        ),
      ],
    ),
  );
}

Widget _buildResultsCard(
  String tweenType,
  AlignmentGeometry? lerped0,
  AlignmentGeometry? lerped05,
  AlignmentGeometry? lerped1,
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
                color: Color(0xFF1565C0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildResultRow('Tween type', tweenType, true),
        _buildResultRow('lerp(0.0)', '${lerped0}', true),
        _buildResultRow('lerp(0.5)', '${lerped05}', true),
        _buildResultRow('lerp(1.0)', '${lerped1}', true),
      ],
    ),
  );
}

Widget _buildResultRow(String label, String value, bool success) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          success ? Icons.check_circle : Icons.cancel,
          size: 14,
          color: success ? const Color(0xFF4CAF50) : Colors.red,
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 80,
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

Widget _buildUseCasesCard() {
  final cases = [
    {
      'icon': Icons.slideshow,
      'label': 'Slide-in animations',
      'desc': 'Move elements across screen',
    },
    {
      'icon': Icons.expand,
      'label': 'Expand/collapse',
      'desc': 'Center to corner transitions',
    },
    {
      'icon': Icons.touch_app,
      'label': 'Drag feedback',
      'desc': 'Return-to-position effects',
    },
    {
      'icon': Icons.language,
      'label': 'RTL support',
      'desc': 'Direction-aware transitions',
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
            Icon(Icons.lightbulb, color: const Color(0xFF1565C0)),
            const SizedBox(width: 8),
            const Text(
              'Use Cases',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1565C0),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...cases.map((c) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    c['icon'] as IconData,
                    size: 16,
                    color: const Color(0xFF1565C0),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c['label'] as String,
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
          );
        }),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('=== AlignmentGeometryTween Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 0: OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- AlignmentGeometryTween Overview ---');
  print('Animates between AlignmentGeometry values');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CREATE TWEEN
  // ═══════════════════════════════════════════════════════════════════════════

  final tween = AlignmentGeometryTween(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  print('Created tween: ${tween.runtimeType}');
  print('begin: ${tween.begin}');
  print('end: ${tween.end}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: LERP VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Lerp Values ---');
  final lerped0 = tween.lerp(0.0);
  final lerped025 = tween.lerp(0.25);
  final lerped05 = tween.lerp(0.5);
  final lerped075 = tween.lerp(0.75);
  final lerped1 = tween.lerp(1.0);

  print('lerp(0.0): $lerped0');
  print('lerp(0.25): $lerped025');
  print('lerp(0.5): $lerped05');
  print('lerp(0.75): $lerped075');
  print('lerp(1.0): $lerped1');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: DIRECTIONAL TWEEN
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- AlignmentDirectional Tween ---');
  final dirTween = AlignmentGeometryTween(
    begin: AlignmentDirectional.topStart,
    end: AlignmentDirectional.bottomEnd,
  );
  print('Directional begin: ${dirTween.begin}');
  print('Directional end: ${dirTween.end}');
  print('Directional lerp(0.5): ${dirTween.lerp(0.5)}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: MIXED TWEEN
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Mixed Alignment Types ---');
  final mixedTween = AlignmentGeometryTween(
    begin: Alignment.center,
    end: AlignmentDirectional.topEnd,
  );
  print('Mixed begin: ${mixedTween.begin}');
  print('Mixed end: ${mixedTween.end}');

  // Resolving direction
  final resolved = mixedTween.lerp(1.0)?.resolve(TextDirection.ltr);
  print('Mixed lerp(1.0) resolved LTR: $resolved');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: ALIGNMENT CONSTANTS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Alignment Constants ---');
  print('topLeft: ${Alignment.topLeft}');
  print('topCenter: ${Alignment.topCenter}');
  print('center: ${Alignment.center}');
  print('bottomRight: ${Alignment.bottomRight}');

  print('\n=== AlignmentGeometryTween Deep Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL UI
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader('AlignmentGeometryTween', 'Animate Between Alignments'),
        const SizedBox(height: 20),

        // Alignment values
        _buildSectionTitle('Alignment Constants', Icons.grid_3x3),
        _buildAlignmentValuesCard(),
        const SizedBox(height: 20),

        // Directional
        _buildSectionTitle('Directional', Icons.swap_horiz),
        _buildDirectionalCard(),
        const SizedBox(height: 20),

        // Tween concept
        _buildSectionTitle('Tween Concept', Icons.trending_flat),
        _buildTweenConceptCard(),
        const SizedBox(height: 20),

        // Lerp visualization
        _buildSectionTitle('Interpolation', Icons.moving),
        _buildLerpVisualization(tween),
        const SizedBox(height: 20),

        // Animation usage
        _buildSectionTitle('Animation Usage', Icons.play_circle),
        _buildAnimationUsage(),
        const SizedBox(height: 20),

        // Use cases
        _buildSectionTitle('Use Cases', Icons.lightbulb),
        _buildUseCasesCard(),
        const SizedBox(height: 20),

        // Results
        _buildSectionTitle('Test Results', Icons.check_circle),
        _buildResultsCard('${tween.runtimeType}', lerped0, lerped05, lerped1),
        const SizedBox(height: 20),

        // Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
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
                  color: Color(0xFF1565C0),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• AlignmentGeometryTween animates alignments\n'
                '• Works with Alignment and AlignmentDirectional\n'
                '• lerp(t) interpolates between begin and end\n'
                '• Supports mixed alignment types\n'
                '• Use with AnimationController for animations\n'
                '• Essential for slide and position animations',
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
