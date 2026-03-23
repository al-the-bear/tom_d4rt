// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep demo for SceneBuilder from dart:ui
//
// SceneBuilder is the low-level API for constructing compositing scenes
// in Flutter. It creates a tree of layers that are rendered by the engine.
//
// Key operations:
//   - pushOffset(): Position layer
//   - pushOpacity(): Opacity layer
//   - pushClipRect/RRect/Path(): Clipping layers
//   - pushColorFilter(): Color transformation layer
//   - pushImageFilter(): Image effect layer (blur, etc.)
//   - pushBackdropFilter(): Background blur layer
//   - pushTransform(): Matrix transformation layer
//   - pop(): End current layer
//   - build(): Create final Scene
//
// This demo visually demonstrates SceneBuilder concepts and layer stacking.

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
        colors: [const Color(0xFF303F9F), const Color(0xFF5C6BC0)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFF303F9F).withAlpha(100),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.layers, size: 48, color: Colors.white),
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
            color: const Color(0xFF5C6BC0).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF5C6BC0), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF303F9F),
          ),
        ),
      ],
    ),
  );
}

Widget _buildLayerTypesCard(List<Map<String, dynamic>> layerTypes) {
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
            Icon(Icons.category, color: const Color(0xFF5C6BC0)),
            const SizedBox(width: 8),
            const Text(
              'Layer Types',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF303F9F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...layerTypes.map((lt) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: lt['color'] as Color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 110,
                  child: Text(
                    lt['method'] as String,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    lt['desc'] as String,
                    style: TextStyle(fontSize: 10, color: Colors.grey[600]),
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

Widget _buildOffsetLayerDemo() {
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
            Icon(Icons.open_with, color: const Color(0xFF5C6BC0)),
            const SizedBox(width: 8),
            const Text(
              'pushOffset()',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF303F9F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: CustomPaint(
            size: const Size(double.infinity, 100),
            painter: _OffsetDemoPainter(),
          ),
        ),
        const SizedBox(height: 8),
        _buildCodeSnippet('sb.pushOffset(10.0, 20.0);'),
      ],
    ),
  );
}

class _OffsetDemoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Grid
    final gridPaint = Paint()
      ..color = Colors.grey.withAlpha(40)
      ..strokeWidth = 1;
    for (var x = 0.0; x < size.width; x += 20) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (var y = 0.0; y < size.height; y += 20) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Original position (faded)
    final origPaint = Paint()
      ..color = const Color(0xFF5C6BC0).withAlpha(60)
      ..style = PaintingStyle.fill;
    canvas.drawRect(const Rect.fromLTWH(20, 20, 60, 40), origPaint);

    // Offset position
    final offsetPaint = Paint()
      ..color = const Color(0xFF5C6BC0)
      ..style = PaintingStyle.fill;
    canvas.drawRect(const Rect.fromLTWH(50, 50, 60, 40), offsetPaint);

    // Arrow
    final arrowPaint = Paint()
      ..color = const Color(0xFF303F9F)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(const Offset(50, 40), const Offset(70, 55), arrowPaint);

    // Labels
    _drawLabel(canvas, '+30, +30', const Offset(72, 58));
  }

  void _drawLabel(Canvas canvas, String text, Offset pos) {
    final textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: Color(0xFF303F9F),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, pos);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildOpacityLayerDemo() {
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
            Icon(Icons.opacity, color: const Color(0xFF5C6BC0)),
            const SizedBox(width: 8),
            const Text(
              'pushOpacity()',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF303F9F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAlphaBox(255, 'α=255'),
            _buildAlphaBox(191, 'α=191'),
            _buildAlphaBox(128, 'α=128'),
            _buildAlphaBox(64, 'α=64'),
          ],
        ),
        const SizedBox(height: 8),
        _buildCodeSnippet('sb.pushOpacity(128, offset: Offset(5, 5));'),
      ],
    ),
  );
}

Widget _buildAlphaBox(int alpha, String label) {
  return Column(
    children: [
      Stack(
        children: [
          // Checkerboard background
          Container(
            width: 50,
            height: 35,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
            child: CustomPaint(painter: _CheckerboardPainter()),
          ),
          Container(
            width: 50,
            height: 35,
            decoration: BoxDecoration(
              color: const Color(0xFF5C6BC0).withAlpha(alpha),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 9, fontFamily: 'monospace')),
    ],
  );
}

class _CheckerboardPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const tileSize = 5.0;
    for (var y = 0.0; y < size.height; y += tileSize) {
      for (var x = 0.0; x < size.width; x += tileSize) {
        final isLight = ((x ~/ tileSize) + (y ~/ tileSize)) % 2 == 0;
        final paint = Paint()
          ..color = isLight ? Colors.white : Colors.grey[300]!;
        canvas.drawRect(Rect.fromLTWH(x, y, tileSize, tileSize), paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildClipLayerDemo() {
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
            Icon(Icons.crop, color: const Color(0xFF5C6BC0)),
            const SizedBox(width: 8),
            const Text(
              'Clipping Layers',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF303F9F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildClipExample('ClipRect', Icons.crop_square),
            _buildClipExample('ClipRRect', Icons.rounded_corner),
            _buildClipExample('ClipPath', Icons.hexagon),
          ],
        ),
        const SizedBox(height: 12),
        _buildCodeSnippet(
          'sb.pushClipRect(Rect.fromLTWH(0, 0, 200, 200));\n'
          'sb.pushClipRRect(RRect.fromRectXY(rect, 8, 8));\n'
          'sb.pushClipPath(path);',
        ),
      ],
    ),
  );
}

Widget _buildClipExample(String label, IconData icon) {
  return Column(
    children: [
      Container(
        width: 60,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF5C6BC0).withAlpha(40),
          border: Border.all(color: const Color(0xFF5C6BC0), width: 2),
          borderRadius: label == 'ClipRRect'
              ? BorderRadius.circular(12)
              : label == 'ClipPath'
              ? null
              : BorderRadius.zero,
        ),
        child: Center(child: Icon(icon, color: const Color(0xFF5C6BC0))),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
      ),
    ],
  );
}

Widget _buildFilterLayerDemo() {
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
            Icon(Icons.filter, color: const Color(0xFF5C6BC0)),
            const SizedBox(width: 8),
            const Text(
              'Filter Layers',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF303F9F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildFilterExample(
              'ColorFilter',
              Icons.color_lens,
              const Color(0xFFE53935),
            ),
            _buildFilterExample(
              'ImageFilter',
              Icons.blur_on,
              const Color(0xFF5C6BC0),
            ),
            _buildFilterExample(
              'Backdrop',
              Icons.filter_drama,
              const Color(0xFF7E57C2),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildCodeSnippet(
          'sb.pushColorFilter(ColorFilter.mode(color, blend));\n'
          'sb.pushImageFilter(ImageFilter.blur(sigmaX: 3));\n'
          'sb.pushBackdropFilter(ImageFilter.blur(sigmaX: 5));',
        ),
      ],
    ),
  );
}

Widget _buildFilterExample(String label, IconData icon, Color color) {
  return Column(
    children: [
      Container(
        width: 55,
        height: 45,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withAlpha(150), color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: color.withAlpha(60),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(child: Icon(icon, color: Colors.white, size: 22)),
      ),
      const SizedBox(height: 4),
      Text(
        label,
        style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w500),
      ),
    ],
  );
}

Widget _buildNestedLayersDemo() {
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
            Icon(Icons.account_tree, color: const Color(0xFF5C6BC0)),
            const SizedBox(width: 8),
            const Text(
              'Nested Layers',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF303F9F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        // Visual tree
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFFE8EAF6),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTreeNode('pushOffset(0, 0)', 0, Colors.green),
              _buildTreeNode('pushOpacity(200)', 1, Colors.blue),
              _buildTreeNode('pushClipRect(...)', 2, Colors.orange),
              _buildTreeNode('// render content', 3, Colors.grey),
              _buildTreeNode('pop() // ClipRect', 2, Colors.orange),
              _buildTreeNode('pop() // Opacity', 1, Colors.blue),
              _buildTreeNode('pop() // Offset', 0, Colors.green),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFFFE0B2)),
          ),
          child: Row(
            children: const [
              Icon(Icons.info, size: 16, color: Color(0xFFE65100)),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Each push() must have a matching pop(). Layers are nested like a stack.',
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTreeNode(String text, int indent, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: indent * 16.0, top: 4, bottom: 4),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 10,
            color: color == Colors.grey ? Colors.grey : Colors.black87,
          ),
        ),
      ],
    ),
  );
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

Widget _buildBuildSceneCard() {
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
            Icon(Icons.build, color: const Color(0xFF5C6BC0)),
            const SizedBox(width: 8),
            const Text(
              'Building the Scene',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF303F9F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildCodeSnippet(
          '// After configuring all layers:\n'
          'final scene = sb.build();\n'
          '\n'
          '// Use the scene for rendering...\n'
          '\n'
          '// When done:\n'
          'scene.dispose();',
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildStep('1', 'Create layers', Icons.layers)),
            const SizedBox(width: 8),
            Expanded(child: _buildStep('2', 'Build scene', Icons.build_circle)),
            const SizedBox(width: 8),
            Expanded(child: _buildStep('3', 'Render', Icons.visibility)),
            const SizedBox(width: 8),
            Expanded(child: _buildStep('4', 'Dispose', Icons.delete)),
          ],
        ),
      ],
    ),
  );
}

Widget _buildStep(String num, String label, IconData icon) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: const Color(0xFFE8EAF6),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                color: Color(0xFF5C6BC0),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  num,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Icon(icon, size: 16, color: const Color(0xFF5C6BC0)),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 9),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

Widget _buildLayerResultsCard(List<Map<String, dynamic>> results) {
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
              'Layer Results',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF303F9F),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...results.map((r) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                const Icon(Icons.check, size: 14, color: Color(0xFF4CAF50)),
                const SizedBox(width: 8),
                SizedBox(
                  width: 100,
                  child: Text(
                    r['method'] as String,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                    ),
                  ),
                ),
                Text(
                  '→ ${r['type']}',
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

Widget _buildUseCasesCard() {
  final useCases = [
    {
      'icon': Icons.animation,
      'title': 'Custom Animations',
      'desc': 'Fine-grained control over compositing',
    },
    {
      'icon': Icons.filter_vintage,
      'title': 'Visual Effects',
      'desc': 'Blur, opacity, color transforms',
    },
    {
      'icon': Icons.speed,
      'title': 'Performance',
      'desc': 'Efficient layer caching and reuse',
    },
    {
      'icon': Icons.dashboard_customize,
      'title': 'Custom Widgets',
      'desc': 'Low-level render object implementation',
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
            Icon(Icons.apps, color: const Color(0xFF5C6BC0)),
            const SizedBox(width: 8),
            const Text(
              'Use Cases',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF303F9F),
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
                    color: const Color(0xFFE8EAF6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    uc['icon'] as IconData,
                    size: 18,
                    color: const Color(0xFF5C6BC0),
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

dynamic build(BuildContext context) {
  print('=== SceneBuilder Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 0: OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- SceneBuilder Overview ---');
  print('SceneBuilder: Low-level compositing API');
  print('Creates a tree of layers for rendering');

  final sb = ui.SceneBuilder();
  print('SceneBuilder type: ${sb.runtimeType}');

  final results = <Map<String, dynamic>>[];

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: OFFSET LAYER
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- pushOffset ---');
  final offset = sb.pushOffset(10.0, 20.0);
  print('pushOffset(10, 20): ${offset.runtimeType}');
  results.add({'method': 'pushOffset', 'type': '${offset.runtimeType}'});
  sb.pop();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: CLIP LAYERS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Clip Layers ---');

  final clip = sb.pushClipRect(const Rect.fromLTWH(0, 0, 200, 200));
  print('pushClipRect: ${clip.runtimeType}');
  results.add({'method': 'pushClipRect', 'type': '${clip.runtimeType}'});
  sb.pop();

  final clipRR = sb.pushClipRRect(
    RRect.fromRectXY(const Rect.fromLTWH(0, 0, 100, 100), 8, 8),
  );
  print('pushClipRRect: ${clipRR.runtimeType}');
  results.add({'method': 'pushClipRRect', 'type': '${clipRR.runtimeType}'});
  sb.pop();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: OPACITY LAYER
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- pushOpacity ---');
  final opacity = sb.pushOpacity(128, offset: const Offset(5, 5));
  print('pushOpacity(128): ${opacity.runtimeType}');
  results.add({'method': 'pushOpacity', 'type': '${opacity.runtimeType}'});
  sb.pop();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: FILTER LAYERS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Filter Layers ---');

  final cf = sb.pushColorFilter(
    const ColorFilter.mode(Colors.red, BlendMode.srcIn),
  );
  print('pushColorFilter: ${cf.runtimeType}');
  results.add({'method': 'pushColorFilter', 'type': '${cf.runtimeType}'});
  sb.pop();

  final imgf = sb.pushImageFilter(ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3));
  print('pushImageFilter: ${imgf.runtimeType}');
  results.add({'method': 'pushImageFilter', 'type': '${imgf.runtimeType}'});
  sb.pop();

  final bd = sb.pushBackdropFilter(ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5));
  print('pushBackdropFilter: ${bd.runtimeType}');
  results.add({'method': 'pushBackdropFilter', 'type': '${bd.runtimeType}'});
  sb.pop();

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: NESTED LAYERS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Nested Layers ---');
  sb.pushOffset(0, 0);
  sb.pushOpacity(200);
  sb.pushClipRect(const Rect.fromLTWH(0, 0, 100, 100));
  sb.pop();
  sb.pop();
  sb.pop();
  print('Nested push/pop: OK');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: BUILD SCENE
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Build Scene ---');
  final scene = sb.build();
  print('Scene type: ${scene.runtimeType}');
  scene.dispose();
  print('Scene disposed');

  print('\n=== SceneBuilder Deep Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL UI
  // ═══════════════════════════════════════════════════════════════════════════

  final layerTypes = <Map<String, dynamic>>[
    {
      'method': 'pushOffset',
      'desc': 'Position translation',
      'color': Colors.green,
    },
    {
      'method': 'pushOpacity',
      'desc': 'Alpha transparency',
      'color': Colors.blue,
    },
    {
      'method': 'pushClipRect',
      'desc': 'Rectangular clip',
      'color': Colors.orange,
    },
    {
      'method': 'pushClipRRect',
      'desc': 'Rounded rect clip',
      'color': Colors.orange,
    },
    {
      'method': 'pushClipPath',
      'desc': 'Arbitrary path clip',
      'color': Colors.orange,
    },
    {
      'method': 'pushColorFilter',
      'desc': 'Color transformation',
      'color': Colors.red,
    },
    {
      'method': 'pushImageFilter',
      'desc': 'Image effects (blur)',
      'color': Colors.purple,
    },
    {
      'method': 'pushBackdropFilter',
      'desc': 'Background blur',
      'color': Colors.purple,
    },
    {
      'method': 'pushTransform',
      'desc': 'Matrix transform',
      'color': Colors.teal,
    },
  ];

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader('SceneBuilder', 'Low-Level Compositing API'),
        const SizedBox(height: 20),

        // Layer types
        _buildSectionTitle('Layer Types', Icons.category),
        _buildLayerTypesCard(layerTypes),
        const SizedBox(height: 20),

        // Offset demo
        _buildSectionTitle('Offset Layer', Icons.open_with),
        _buildOffsetLayerDemo(),
        const SizedBox(height: 20),

        // Opacity demo
        _buildSectionTitle('Opacity Layer', Icons.opacity),
        _buildOpacityLayerDemo(),
        const SizedBox(height: 20),

        // Clip demo
        _buildSectionTitle('Clipping Layers', Icons.crop),
        _buildClipLayerDemo(),
        const SizedBox(height: 20),

        // Filter demo
        _buildSectionTitle('Filter Layers', Icons.filter),
        _buildFilterLayerDemo(),
        const SizedBox(height: 20),

        // Nested layers
        _buildSectionTitle('Layer Nesting', Icons.account_tree),
        _buildNestedLayersDemo(),
        const SizedBox(height: 20),

        // Build scene
        _buildSectionTitle('Building Scene', Icons.build),
        _buildBuildSceneCard(),
        const SizedBox(height: 20),

        // Results
        _buildSectionTitle('Test Results', Icons.check_circle),
        _buildLayerResultsCard(results),
        const SizedBox(height: 20),

        // Use cases
        _buildSectionTitle('Use Cases', Icons.apps),
        _buildUseCasesCard(),
        const SizedBox(height: 20),

        // Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFE8EAF6),
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
                  color: Color(0xFF303F9F),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• SceneBuilder is the low-level compositing API\n'
                '• Creates a tree of layers: offset, opacity, clip, filter\n'
                '• Each push() must have a matching pop()\n'
                '• Layers can be nested for complex effects\n'
                '• build() creates the final Scene object\n'
                '• Dispose the scene when done to free resources',
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
