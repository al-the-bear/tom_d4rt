// ignore_for_file: avoid_print
// D4rt test script: Deep demo for OffsetEngineLayer from dart:ui
//
// OffsetEngineLayer is the return type from SceneBuilder.pushOffset().
// It represents a compositing layer that applies a positional offset
// to all its child content.
//
// Key characteristics:
//   - Created via SceneBuilder.pushOffset(dx, dy)
//   - Applies translation to all children in the layer
//   - Can be nested for cumulative offsets
//   - Part of the low-level scene compositing API
//   - Used internally by Flutter's rendering pipeline
//
// This demo visually demonstrates offset layer behavior and nesting.

import 'dart:ui' as ui;
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
        colors: [const Color(0xFF0277BD), const Color(0xFF039BE5)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF0277BD).withAlpha(100),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.transform, size: 48, color: Colors.white),
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
            color: const Color(0xFF039BE5).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF039BE5), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0277BD),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBasicOffsetDemo() {
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
            Icon(Icons.open_with, color: const Color(0xFF039BE5)),
            const SizedBox(width: 8),
            const Text(
              'Basic Offset',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0277BD),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 150,
          child: Stack(
            children: [
              // Grid background
              Positioned.fill(child: CustomPaint(painter: _GridPainter())),
              // Origin marker
              Positioned(
                left: 10,
                top: 10,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
              // Original position (faded)
              Positioned(
                left: 20,
                top: 20,
                child: Container(
                  width: 60,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF0277BD).withAlpha(50),
                    border: Border.all(
                      color: const Color(0xFF0277BD).withAlpha(100),
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text(
                      'Original',
                      style: TextStyle(fontSize: 9, color: Colors.black54),
                    ),
                  ),
                ),
              ),
              // Offset position
              Positioned(
                left: 70, // 20 + 50 (dx)
                top: 50, // 20 + 30 (dy)
                child: Container(
                  width: 60,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF039BE5),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(30),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      '+50, +30',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // Arrow
              Positioned(
                left: 45,
                top: 38,
                child: Transform.rotate(
                  angle: 0.5,
                  child: Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'pushOffset(50.0, 30.0)',
              style: TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ),
      ],
    ),
  );
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withAlpha(60)
      ..strokeWidth = 1;

    const spacing = 20.0;
    for (var x = 0.0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    // Origin axes
    paint.color = Colors.red.withAlpha(100);
    paint.strokeWidth = 2;
    canvas.drawLine(const Offset(0, 10), const Offset(100, 10), paint);
    canvas.drawLine(const Offset(10, 0), const Offset(10, 80), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildNegativeOffsetDemo() {
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
            Icon(Icons.undo, color: const Color(0xFF039BE5)),
            const SizedBox(width: 8),
            const Text(
              'Negative Offset',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0277BD),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: Stack(
            children: [
              Positioned.fill(child: CustomPaint(painter: _GridPainter())),
              // Offset position (moves up-left)
              Positioned(
                left: 40,
                top: 60,
                child: Container(
                  width: 60,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF7043),
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withAlpha(30),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Text(
                      '-30, -20',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              // Original position (faded)
              Positioned(
                left: 70, // 40 + 30
                top: 80, // 60 + 20
                child: Container(
                  width: 60,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF7043).withAlpha(50),
                    border: Border.all(
                      color: const Color(0xFFFF7043).withAlpha(100),
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text(
                      'Original',
                      style: TextStyle(fontSize: 9, color: Colors.black54),
                    ),
                  ),
                ),
              ),
              // Arrow
              Positioned(
                left: 85,
                top: 75,
                child: Transform.rotate(
                  angle: -2.3,
                  child: Icon(
                    Icons.arrow_forward,
                    size: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFFBE9E7),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'pushOffset(-30.0, -20.0)',
              style: TextStyle(fontFamily: 'monospace', fontSize: 12),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildNestedOffsetsDemo() {
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
            Icon(Icons.layers, color: const Color(0xFF039BE5)),
            const SizedBox(width: 8),
            const Text(
              'Nested Offsets (Cumulative)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0277BD),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 150,
          child: Stack(
            children: [
              Positioned.fill(child: CustomPaint(painter: _GridPainter())),
              // Origin
              Positioned(
                left: 20,
                top: 20,
                child: _buildLayerBox('Origin', Colors.grey[400]!, 0),
              ),
              // Layer 1 offset
              Positioned(
                left: 50, // +30
                top: 40, // +20
                child: _buildLayerBox('Layer 1', const Color(0xFF66BB6A), 1),
              ),
              // Layer 2 offset (cumulative)
              Positioned(
                left: 95, // 50 + 45
                top: 65, // 40 + 25
                child: _buildLayerBox('Layer 2', const Color(0xFF039BE5), 2),
              ),
              // Layer 3 offset (cumulative)
              Positioned(
                left: 130, // 95 + 35
                top: 85, // 65 + 20
                child: _buildLayerBox('Layer 3', const Color(0xFF7E57C2), 3),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Nested pushOffset() calls accumulate:',
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                '• Layer 1: (30, 20) → total: (30, 20)\n'
                '• Layer 2: (45, 25) → total: (75, 45)\n'
                '• Layer 3: (35, 20) → total: (110, 65)',
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildLayerBox(String label, Color color, int level) {
  return Container(
    width: 50,
    height: 35,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(20 + level * 10),
          blurRadius: 2 + level.toDouble(),
          offset: Offset(level.toDouble(), level.toDouble()),
        ),
      ],
    ),
    child: Center(
      child: Text(
        label,
        style: TextStyle(
          color: level == 0 ? Colors.black54 : Colors.white,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

Widget _buildSceneBuilderApiCard() {
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
            Icon(Icons.code, color: const Color(0xFF039BE5)),
            const SizedBox(width: 8),
            const Text(
              'SceneBuilder API',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0277BD),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildCodeBlock('''final builder = SceneBuilder();

// Push offset layer
final layer1 = builder.pushOffset(10.0, 20.0);
print(layer1.runtimeType); // OffsetEngineLayer

// Can nest multiple offsets
final layer2 = builder.pushOffset(30.0, 40.0);
// Total offset now: (40, 60)

// Add rendered content here...

builder.pop(); // Pop layer2
builder.pop(); // Pop layer1

final scene = builder.build();'''),
      ],
    ),
  );
}

Widget _buildCodeBlock(String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E1E),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 11,
        color: Color(0xFFD4D4D4),
        height: 1.4,
      ),
    ),
  );
}

Widget _buildLayerInfoCard(List<Map<String, dynamic>> layers) {
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
            Icon(Icons.list, color: const Color(0xFF039BE5)),
            const SizedBox(width: 8),
            const Text(
              'Created Layers',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0277BD),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...layers.asMap().entries.map((entry) {
          final i = entry.key;
          final layer = entry.value;
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: const Color(0xFF039BE5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '(${layer['dx']}, ${layer['dy']})',
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${layer['type']}',
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );
}

Widget _buildDirectionIndicators() {
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
            Icon(Icons.explore, color: const Color(0xFF039BE5)),
            const SizedBox(width: 8),
            const Text(
              'Offset Directions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0277BD),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildDirectionCard('+dx', 'Right', Icons.arrow_forward),
            _buildDirectionCard('-dx', 'Left', Icons.arrow_back),
            _buildDirectionCard('+dy', 'Down', Icons.arrow_downward),
            _buildDirectionCard('-dy', 'Up', Icons.arrow_upward),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                children: const [
                  Icon(Icons.info, size: 16, color: Color(0xFF039BE5)),
                  SizedBox(width: 8),
                  Text(
                    'Coordinate System',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              const Text(
                'Origin (0,0) is at top-left corner.\n'
                'X increases to the right, Y increases downward.',
                style: TextStyle(fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDirectionCard(String value, String label, IconData icon) {
  return Column(
    children: [
      Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: const Color(0xFF039BE5).withAlpha(30),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: const Color(0xFF039BE5), size: 24),
      ),
      const SizedBox(height: 4),
      Text(
        value,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
      Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
    ],
  );
}

Widget _buildUseCasesCard() {
  final useCases = [
    {
      'icon': Icons.animation,
      'title': 'Slide Animations',
      'desc': 'Animate content sliding in/out of view',
    },
    {
      'icon': Icons.grid_view,
      'title': 'Grid Layout',
      'desc': 'Position items in a grid pattern',
    },
    {
      'icon': Icons.layers,
      'title': 'Layer Positioning',
      'desc': 'Stack and position composite layers',
    },
    {
      'icon': Icons.visibility,
      'title': 'Viewport Scrolling',
      'desc': 'Scroll large content within viewport',
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
            Icon(Icons.apps, color: const Color(0xFF039BE5)),
            const SizedBox(width: 8),
            const Text(
              'Common Use Cases',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0277BD),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...useCases.map((uc) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE3F2FD),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    uc['icon'] as IconData,
                    size: 20,
                    color: const Color(0xFF039BE5),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        uc['title'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        uc['desc'] as String,
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
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

Widget _buildOffsetComparisonDemo() {
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
            Icon(Icons.compare, color: const Color(0xFF039BE5)),
            const SizedBox(width: 8),
            const Text(
              'Offset Values Comparison',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0277BD),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 180,
          child: CustomPaint(
            size: const Size(double.infinity, 180),
            painter: _OffsetComparisonPainter(),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildOffsetLegend('Zero', const Color(0xFF4CAF50), '(0, 0)'),
            _buildOffsetLegend('Small', const Color(0xFF2196F3), '(20, 15)'),
            _buildOffsetLegend('Large', const Color(0xFFFF9800), '(80, 60)'),
            _buildOffsetLegend(
              'Negative',
              const Color(0xFFF44336),
              '(-30, -20)',
            ),
          ],
        ),
      ],
    ),
  );
}

class _OffsetComparisonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Grid
    final gridPaint = Paint()
      ..color = Colors.grey.withAlpha(40)
      ..strokeWidth = 1;

    const spacing = 20.0;
    for (var x = 0.0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (var y = 0.0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Reference point
    const refX = 100.0;
    const refY = 100.0;

    // Draw reference point
    final refPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(const Offset(refX, refY), 4, refPaint);

    // Zero offset (stays at reference)
    _drawOffsetBox(canvas, refX, refY, const Color(0xFF4CAF50), '0,0');

    // Small positive offset
    _drawOffsetBox(
      canvas,
      refX + 20,
      refY + 15,
      const Color(0xFF2196F3),
      '+20,+15',
    );

    // Large positive offset
    _drawOffsetBox(
      canvas,
      refX + 80,
      refY + 60,
      const Color(0xFFFF9800),
      '+80,+60',
    );

    // Negative offset
    _drawOffsetBox(
      canvas,
      refX - 70,
      refY - 50,
      const Color(0xFFF44336),
      '-30,-20',
    );
  }

  void _drawOffsetBox(
    Canvas canvas,
    double x,
    double y,
    Color color,
    String label,
  ) {
    final rect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(x, y), width: 50, height: 30),
      const Radius.circular(4),
    );

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawRRect(rect, paint);

    final borderPaint = Paint()
      ..color = color.withAlpha(200)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawRRect(rect, borderPaint);

    // Label
    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(x - textPainter.width / 2, y - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildOffsetLegend(String label, Color color, String value) {
  return Column(
    children: [
      Container(
        width: 20,
        height: 12,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      const SizedBox(height: 2),
      Text(
        label,
        style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
      ),
      Text(value, style: TextStyle(fontSize: 8, color: Colors.grey[600])),
    ],
  );
}

dynamic build(BuildContext context) {
  print('=== OffsetEngineLayer Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 0: OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- OffsetEngineLayer Overview ---');
  print('OffsetEngineLayer: Created via SceneBuilder.pushOffset()');
  print('Applies positional translation to all children');
  print('Nested offsets are cumulative');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: BASIC USAGE
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Basic Offset Usage ---');

  final builder = ui.SceneBuilder();
  final layerInfo = <Map<String, dynamic>>[];

  // Positive offset
  final layer1 = builder.pushOffset(10.0, 20.0);
  print('pushOffset(10, 20): ${layer1.runtimeType}');
  layerInfo.add({'dx': 10.0, 'dy': 20.0, 'type': '${layer1.runtimeType}'});
  builder.pop();

  // Zero offset
  final layer2 = builder.pushOffset(0.0, 0.0);
  print('pushOffset(0, 0): ${layer2.runtimeType}');
  layerInfo.add({'dx': 0.0, 'dy': 0.0, 'type': '${layer2.runtimeType}'});
  builder.pop();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: NEGATIVE OFFSETS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Negative Offsets ---');

  final layer3 = builder.pushOffset(-50.0, -30.0);
  print('pushOffset(-50, -30): ${layer3.runtimeType}');
  layerInfo.add({'dx': -50.0, 'dy': -30.0, 'type': '${layer3.runtimeType}'});
  builder.pop();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: LARGE OFFSETS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Large Offsets ---');

  final layer4 = builder.pushOffset(1000.0, 2000.0);
  print('pushOffset(1000, 2000): ${layer4.runtimeType}');
  layerInfo.add({'dx': 1000.0, 'dy': 2000.0, 'type': '${layer4.runtimeType}'});
  builder.pop();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: NESTED OFFSETS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Nested Offsets (Cumulative) ---');

  final l5 = builder.pushOffset(10.0, 10.0);
  print('Outer pushOffset(10, 10): ${l5.runtimeType}');
  layerInfo.add({'dx': 10.0, 'dy': 10.0, 'type': '${l5.runtimeType} (outer)'});

  final l6 = builder.pushOffset(20.0, 20.0);
  print('Inner pushOffset(20, 20): ${l6.runtimeType}');
  print('Total cumulative offset: (30, 30)');
  layerInfo.add({'dx': 20.0, 'dy': 20.0, 'type': '${l6.runtimeType} (inner)'});

  builder.pop();
  builder.pop();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: FRACTIONAL OFFSETS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Fractional Offsets ---');

  final l7 = builder.pushOffset(5.5, 7.25);
  print('pushOffset(5.5, 7.25): ${l7.runtimeType}');
  layerInfo.add({'dx': 5.5, 'dy': 7.25, 'type': '${l7.runtimeType}'});
  builder.pop();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: BUILD SCENE
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Building Scene ---');
  final scene = builder.build();
  print('Scene built successfully');
  scene.dispose();
  print('Scene disposed');

  print('\n=== OffsetEngineLayer Deep Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL UI
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader('OffsetEngineLayer', 'Positional Translation Layer'),
        const SizedBox(height: 20),

        // Basic offset
        _buildSectionTitle('Basic Offset', Icons.open_with),
        _buildBasicOffsetDemo(),
        const SizedBox(height: 20),

        // Negative offset
        _buildSectionTitle('Negative Offset', Icons.undo),
        _buildNegativeOffsetDemo(),
        const SizedBox(height: 20),

        // Direction indicators
        _buildSectionTitle('Direction Reference', Icons.explore),
        _buildDirectionIndicators(),
        const SizedBox(height: 20),

        // Nested offsets
        _buildSectionTitle('Nested Offsets', Icons.layers),
        _buildNestedOffsetsDemo(),
        const SizedBox(height: 20),

        // SceneBuilder API
        _buildSectionTitle('SceneBuilder API', Icons.code),
        _buildSceneBuilderApiCard(),
        const SizedBox(height: 20),

        // Created layers
        _buildSectionTitle('Created Layers', Icons.list),
        _buildLayerInfoCard(layerInfo),
        const SizedBox(height: 20),

        // Comparison
        _buildSectionTitle('Offset Comparison', Icons.compare),
        _buildOffsetComparisonDemo(),
        const SizedBox(height: 20),

        // Use cases
        _buildSectionTitle('Use Cases', Icons.apps),
        _buildUseCasesCard(),
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
                  color: Color(0xFF0277BD),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• OffsetEngineLayer created via SceneBuilder.pushOffset()\n'
                '• Applies (dx, dy) translation to all children\n'
                '• Positive X moves right, positive Y moves down\n'
                '• Negative values move in opposite directions\n'
                '• Nested pushOffset() calls accumulate offsets\n'
                '• Part of low-level scene compositing API',
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
