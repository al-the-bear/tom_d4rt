// ignore_for_file: avoid_print
// D4rt test script: Deep demo for OpacityEngineLayer from dart:ui
//
// OpacityEngineLayer is the return type from SceneBuilder.pushOpacity().
// It represents a compositing layer with an opacity value applied.
//
// Key characteristics:
//   - Created via SceneBuilder.pushOpacity(alpha, offset)
//   - Alpha range: 0 (fully transparent) to 255 (fully opaque)
//   - Optional offset parameter for layer positioning
//   - Part of the low-level scene compositing API
//   - Used internally by Flutter's rendering pipeline
//
// This demo visually demonstrates opacity concepts and layer compositing.

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
        colors: [const Color(0xFF5E35B1), const Color(0xFF7E57C2)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF5E35B1).withAlpha(100),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.opacity, size: 48, color: Colors.white),
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
            color: const Color(0xFF7E57C2).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF7E57C2), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF5E35B1),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAlphaScaleDemo() {
  final alphaValues = [0, 25, 50, 75, 100, 128, 150, 175, 200, 225, 255];

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
            Icon(Icons.gradient, color: const Color(0xFF7E57C2)),
            const SizedBox(width: 8),
            const Text(
              'Alpha Scale (0-255)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5E35B1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Background checkerboard pattern
        Container(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: const DecorationImage(
              image: AssetImage('assets/checker.png'),
              repeat: ImageRepeat.repeat,
            ),
          ),
          child: CustomPaint(
            size: const Size(double.infinity, 60),
            painter: _CheckerboardPainter(),
            child: Row(
              children: alphaValues.map((alpha) {
                return Expanded(
                  child: Container(
                    height: 60,
                    color: Color.fromARGB(alpha, 103, 58, 183),
                    child: Center(
                      child: Text(
                        '$alpha',
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: alpha > 128 ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '← Transparent',
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
            Text(
              'Opaque →',
              style: TextStyle(fontSize: 11, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    ),
  );
}

class _CheckerboardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const tileSize = 10.0;
    final lightPaint = Paint()..color = const Color(0xFFFFFFFF);
    final darkPaint = Paint()..color = const Color(0xFFCCCCCC);

    for (var y = 0.0; y < size.height; y += tileSize) {
      for (var x = 0.0; x < size.width; x += tileSize) {
        final isLight = ((x ~/ tileSize) + (y ~/ tileSize)) % 2 == 0;
        canvas.drawRect(
          Rect.fromLTWH(x, y, tileSize, tileSize),
          isLight ? lightPaint : darkPaint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildOpacityExamples() {
  final examples = [
    {'alpha': 255, 'label': 'Full', 'desc': '100% visible'},
    {'alpha': 191, 'label': '75%', 'desc': '75% visible'},
    {'alpha': 128, 'label': '50%', 'desc': '50% visible'},
    {'alpha': 64, 'label': '25%', 'desc': '25% visible'},
    {'alpha': 0, 'label': 'None', 'desc': '0% visible'},
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
            Icon(Icons.visibility, color: const Color(0xFF7E57C2)),
            const SizedBox(width: 8),
            const Text(
              'Opacity Visual Examples',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5E35B1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: examples.map((e) {
            final alpha = e['alpha'] as int;
            return Column(
              children: [
                // Checkered background to show transparency
                Container(
                  width: 55,
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Stack(
                      children: [
                        CustomPaint(
                          size: const Size(55, 55),
                          painter: _CheckerboardPainter(),
                        ),
                        Container(color: Color.fromARGB(alpha, 103, 58, 183)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  e['label'] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                Text(
                  'α=$alpha',
                  style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                ),
              ],
            );
          }).toList(),
        ),
      ],
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
            Icon(Icons.code, color: const Color(0xFF7E57C2)),
            const SizedBox(width: 8),
            const Text(
              'SceneBuilder API',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5E35B1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildCodeBlock('''final builder = SceneBuilder();

// Push opacity layer with alpha 128 (50%)
final layer = builder.pushOpacity(128);

// Optional: with offset
final layer2 = builder.pushOpacity(
  200,
  offset: Offset(10, 20),
);

// Add content here...

builder.pop();  // Pop each layer
builder.pop();

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

Widget _buildLayerTypeInfo(List<Map<String, dynamic>> layerInfo) {
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
            Icon(Icons.layers, color: const Color(0xFF7E57C2)),
            const SizedBox(width: 8),
            const Text(
              'Created Layer Types',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5E35B1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...layerInfo.map((info) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFF5E35B1,
                    ).withAlpha((info['alpha'] as int) ~/ 2 + 64),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'α=${info['alpha']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '${info['type']}',
                  style: const TextStyle(fontFamily: 'monospace', fontSize: 11),
                ),
                if (info['offset'] != null) ...[
                  const SizedBox(width: 8),
                  Text(
                    'offset: ${info['offset']}',
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                  ),
                ],
              ],
            ),
          );
        }),
      ],
    ),
  );
}

Widget _buildLayerStackVisualization() {
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
            Icon(Icons.filter_none, color: const Color(0xFF7E57C2)),
            const SizedBox(width: 8),
            const Text(
              'Layer Stack Visualization',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5E35B1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Background checkered
              Positioned.fill(
                child: CustomPaint(painter: _CheckerboardPainter()),
              ),
              // Layer 1 - bottom (alpha 64)
              Positioned(
                bottom: 0,
                left: 20,
                child: _buildStackLayer('Layer 1', 64, const Color(0xFF1565C0)),
              ),
              // Layer 2 - middle (alpha 128)
              Positioned(
                bottom: 40,
                left: 50,
                child: _buildStackLayer(
                  'Layer 2',
                  128,
                  const Color(0xFF4CAF50),
                ),
              ),
              // Layer 3 - top (alpha 192)
              Positioned(
                bottom: 80,
                left: 80,
                child: _buildStackLayer(
                  'Layer 3',
                  192,
                  const Color(0xFFFF9800),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildStackLegend('Layer 1', 64, const Color(0xFF1565C0)),
            _buildStackLegend('Layer 2', 128, const Color(0xFF4CAF50)),
            _buildStackLegend('Layer 3', 192, const Color(0xFFFF9800)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildStackLayer(String label, int alpha, Color baseColor) {
  return Container(
    width: 120,
    height: 80,
    decoration: BoxDecoration(
      color: baseColor.withAlpha(alpha),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: baseColor, width: 2),
    ),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyle(
              color: alpha > 100 ? Colors.white : Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          Text(
            'α=$alpha',
            style: TextStyle(
              color: alpha > 100 ? Colors.white.withAlpha(200) : Colors.black54,
              fontSize: 10,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildStackLegend(String label, int alpha, Color color) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: color.withAlpha(alpha),
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(3),
        ),
      ),
      const SizedBox(width: 4),
      Text('$label (α=$alpha)', style: const TextStyle(fontSize: 10)),
    ],
  );
}

Widget _buildOffsetDemo() {
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
            Icon(Icons.open_with, color: const Color(0xFF7E57C2)),
            const SizedBox(width: 8),
            const Text(
              'Offset Parameter',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5E35B1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 120,
          child: Stack(
            children: [
              // Grid background
              Positioned.fill(child: CustomPaint(painter: _GridPainter())),
              // Original position
              Positioned(
                left: 20,
                top: 20,
                child: Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF5E35B1).withAlpha(100),
                    border: Border.all(
                      color: const Color(0xFF5E35B1),
                      width: 2,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text('Original', style: TextStyle(fontSize: 10)),
                  ),
                ),
              ),
              // Offset position
              Positioned(
                left: 70, // 20 + 50
                top: 50, // 20 + 30
                child: Container(
                  width: 80,
                  height: 60,
                  decoration: BoxDecoration(
                    color: const Color(0xFF7E57C2).withAlpha(180),
                    border: Border.all(
                      color: const Color(0xFF7E57C2),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Text(
                      'Offset(50, 30)',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
              ),
              // Arrow
              Positioned(
                left: 50,
                top: 45,
                child: Icon(
                  Icons.arrow_forward,
                  size: 20,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            'pushOpacity(alpha, offset: Offset(dx, dy))',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: Colors.grey[600],
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

    // Draw grid
    const spacing = 20.0;
    for (var x = 0.0; x <= size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y <= size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildAlphaFormulasCard() {
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
            Icon(Icons.functions, color: const Color(0xFF7E57C2)),
            const SizedBox(width: 8),
            const Text(
              'Alpha Conversion',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5E35B1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildFormulaRow('Percent to Alpha', 'alpha = (percent / 100) × 255'),
        _buildFormulaRow('Alpha to Percent', 'percent = (alpha / 255) × 100'),
        const SizedBox(height: 12),
        const Text(
          'Common Values:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAlphaChip('100%', 255),
            _buildAlphaChip('75%', 191),
            _buildAlphaChip('50%', 128),
            _buildAlphaChip('25%', 64),
            _buildAlphaChip('0%', 0),
          ],
        ),
      ],
    ),
  );
}

Widget _buildFormulaRow(String label, String formula) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: const Color(0xFFEDE7F6),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            formula,
            style: const TextStyle(fontFamily: 'monospace', fontSize: 10),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAlphaChip(String percent, int alpha) {
  return Column(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: const Color(0xFF5E35B1).withAlpha(alpha),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFF5E35B1)),
        ),
        child: Text(
          percent,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: alpha > 128 ? Colors.white : const Color(0xFF5E35B1),
          ),
        ),
      ),
      const SizedBox(height: 2),
      Text('α=$alpha', style: TextStyle(fontSize: 9, color: Colors.grey[600])),
    ],
  );
}

Widget _buildUseCasesCard() {
  final useCases = [
    {
      'icon': Icons.animation,
      'title': 'Fade Animations',
      'desc': 'Animate alpha from 0 to 255 for fade-in effects',
    },
    {
      'icon': Icons.filter_drama,
      'title': 'Overlay Effects',
      'desc': 'Semi-transparent overlays for modals and dialogs',
    },
    {
      'icon': Icons.visibility_off,
      'title': 'Hide Content',
      'desc': 'Alpha 0 to completely hide without removing',
    },
    {
      'icon': Icons.layers,
      'title': 'Compositing',
      'desc': 'Build complex scenes with multiple opacity layers',
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
            Icon(Icons.apps, color: const Color(0xFF7E57C2)),
            const SizedBox(width: 8),
            const Text(
              'Common Use Cases',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5E35B1),
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
                    color: const Color(0xFFEDE7F6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    uc['icon'] as IconData,
                    size: 20,
                    color: const Color(0xFF7E57C2),
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

Widget _buildInteractiveOpacityDemo() {
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
            Icon(Icons.photo, color: const Color(0xFF7E57C2)),
            const SizedBox(width: 8),
            const Text(
              'Opacity Blend Demo',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF5E35B1),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            // Overlapping circles demo
            Expanded(
              child: SizedBox(
                height: 100,
                child: CustomPaint(painter: _OverlappingCirclesPainter()),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Center(
          child: Text(
            'Three circles with α=150 showing blend effects',
            style: TextStyle(fontSize: 11, color: Colors.grey[600]),
          ),
        ),
      ],
    ),
  );
}

class _OverlappingCirclesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    final radius = 35.0;
    const alpha = 150;

    // Red circle (left)
    final redPaint = Paint()
      ..color = Color.fromARGB(alpha, 244, 67, 54)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX - 25, centerY), radius, redPaint);

    // Green circle (right)
    final greenPaint = Paint()
      ..color = Color.fromARGB(alpha, 76, 175, 80)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX + 25, centerY), radius, greenPaint);

    // Blue circle (top)
    final bluePaint = Paint()
      ..color = Color.fromARGB(alpha, 33, 150, 243)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(centerX, centerY - 20), radius, bluePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

dynamic build(BuildContext context) {
  print('=== OpacityEngineLayer Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 0: OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- OpacityEngineLayer Overview ---');
  print('OpacityEngineLayer: Created via SceneBuilder.pushOpacity()');
  print('Represents a compositing layer with opacity applied');
  print('Alpha range: 0 (transparent) to 255 (opaque)');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: SCENE BUILDER USAGE
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- SceneBuilder Usage ---');

  final builder = ui.SceneBuilder();
  final layerInfo = <Map<String, dynamic>>[];

  // Full opacity
  final layer1 = builder.pushOpacity(255);
  print('pushOpacity(255): ${layer1.runtimeType}');
  layerInfo.add({
    'alpha': 255,
    'type': '${layer1.runtimeType}',
    'offset': null,
  });
  builder.pop();

  // Half opacity
  final layer2 = builder.pushOpacity(128);
  print('pushOpacity(128): ${layer2.runtimeType}');
  layerInfo.add({
    'alpha': 128,
    'type': '${layer2.runtimeType}',
    'offset': null,
  });
  builder.pop();

  // Zero opacity (fully transparent)
  final layer3 = builder.pushOpacity(0);
  print('pushOpacity(0): ${layer3.runtimeType}');
  layerInfo.add({'alpha': 0, 'type': '${layer3.runtimeType}', 'offset': null});
  builder.pop();

  // With offset
  final layer4 = builder.pushOpacity(200, offset: const Offset(10.0, 20.0));
  print('pushOpacity(200, offset: (10, 20)): ${layer4.runtimeType}');
  layerInfo.add({
    'alpha': 200,
    'type': '${layer4.runtimeType}',
    'offset': '(10, 20)',
  });
  builder.pop();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: VARIOUS ALPHA VALUES
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Alpha Values Test ---');

  final alphaTests = <int>[25, 50, 75, 100, 150, 175, 200, 225];
  for (final alpha in alphaTests) {
    final l = builder.pushOpacity(alpha);
    print('pushOpacity($alpha): ${l.runtimeType}');
    layerInfo.add({'alpha': alpha, 'type': '${l.runtimeType}', 'offset': null});
    builder.pop();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: BUILD SCENE
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Building Scene ---');
  final scene = builder.build();
  print('Scene built successfully');
  scene.dispose();
  print('Scene disposed');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: ALPHA CALCULATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Alpha Calculations ---');
  print('100% opacity = alpha 255');
  print('75% opacity = alpha ${(0.75 * 255).round()}');
  print('50% opacity = alpha ${(0.50 * 255).round()}');
  print('25% opacity = alpha ${(0.25 * 255).round()}');
  print('0% opacity = alpha 0');

  print('\n=== OpacityEngineLayer Deep Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL UI
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader('OpacityEngineLayer', 'Compositing Layer with Opacity'),
        const SizedBox(height: 20),

        // Alpha scale
        _buildSectionTitle('Alpha Scale', Icons.gradient),
        _buildAlphaScaleDemo(),
        const SizedBox(height: 20),

        // Visual examples
        _buildSectionTitle('Visual Examples', Icons.visibility),
        _buildOpacityExamples(),
        const SizedBox(height: 20),

        // SceneBuilder API
        _buildSectionTitle('SceneBuilder API', Icons.code),
        _buildSceneBuilderApiCard(),
        const SizedBox(height: 20),

        // Created layers
        _buildSectionTitle('Created Layers', Icons.layers),
        _buildLayerTypeInfo(layerInfo),
        const SizedBox(height: 20),

        // Layer stack
        _buildSectionTitle('Layer Stacking', Icons.filter_none),
        _buildLayerStackVisualization(),
        const SizedBox(height: 20),

        // Offset parameter
        _buildSectionTitle('Offset Parameter', Icons.open_with),
        _buildOffsetDemo(),
        const SizedBox(height: 20),

        // Alpha formulas
        _buildSectionTitle('Alpha Conversion', Icons.functions),
        _buildAlphaFormulasCard(),
        const SizedBox(height: 20),

        // Blend demo
        _buildSectionTitle('Blend Effects', Icons.photo),
        _buildInteractiveOpacityDemo(),
        const SizedBox(height: 20),

        // Use cases
        _buildSectionTitle('Use Cases', Icons.apps),
        _buildUseCasesCard(),
        const SizedBox(height: 20),

        // Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFEDE7F6),
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
                  color: Color(0xFF5E35B1),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• OpacityEngineLayer created via SceneBuilder.pushOpacity()\n'
                '• Alpha range: 0 (transparent) to 255 (opaque)\n'
                '• Optional offset parameter for layer positioning\n'
                '• Part of low-level scene compositing API\n'
                '• Used internally by Flutter rendering pipeline\n'
                '• Percent to alpha: (percent/100) × 255',
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
