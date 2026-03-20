// D4rt test script: Deep demo for ColorFilterLayer from rendering
//
// ColorFilterLayer applies a ColorFilter to all children.
// Part of the low-level layer compositing API.
//
// Key properties:
//   - colorFilter: The ColorFilter to apply
//
// ColorFilter types:
//   - ColorFilter.mode: Blend a color with blend mode
//   - ColorFilter.matrix: Apply 5x4 color transformation matrix
//   - ColorFilter.linearToSrgbGamma: Linear to sRGB gamma
//   - ColorFilter.srgbToLinearGamma: sRGB to linear gamma
//
// Common use cases:
//   - Grayscale effects
//   - Sepia/vintage effects
//   - Color tinting
//   - Color inversion
//   - Accessibility contrast adjustments
//
// This demo visualizes various color filter effects.

import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ═══════════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════════

Widget _buildHeader(String title, String subtitle) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [const Color(0xFFD84315), const Color(0xFFFF7043)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: const Color(0xFFD84315).withAlpha(100),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(Icons.color_lens, size: 48, color: Colors.white),
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
            color: const Color(0xFFFF7043).withAlpha(30),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFFD84315), size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFFD84315),
          ),
        ),
      ],
    ),
  );
}

Widget _buildConceptCard() {
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
            Icon(Icons.filter, color: const Color(0xFFD84315)),
            const SizedBox(width: 8),
            const Text(
              'What is ColorFilterLayer?',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD84315),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: CustomPaint(
            size: const Size(double.infinity, 100),
            painter: _ConceptPainter(),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFFFBE9E7),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Applies a ColorFilter to transform\n'
            'all colors in the child layers',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ),
  );
}

class _ConceptPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Original image representation (colorful squares)
    final colors = [Colors.red, Colors.green, Colors.blue, Colors.yellow];
    final startX = 20.0;

    for (var i = 0; i < 4; i++) {
      final paint = Paint()..color = colors[i];
      canvas.drawRect(Rect.fromLTWH(startX + i * 25, 30, 20, 40), paint);
    }
    _drawLabel(canvas, 'Original', Offset(60, 80));

    // Arrow
    final arrowPaint = Paint()
      ..color = const Color(0xFFD84315)
      ..strokeWidth = 2;
    canvas.drawLine(Offset(130, 50), Offset(170, 50), arrowPaint);
    final arrowPath = Path()
      ..moveTo(165, 45)
      ..lineTo(175, 50)
      ..lineTo(165, 55);
    canvas.drawPath(arrowPath, arrowPaint);

    // Filter label
    final filterRect = RRect.fromRectXY(Rect.fromLTWH(140, 20, 50, 20), 4, 4);
    final filterPaint = Paint()..color = const Color(0xFFFF7043);
    canvas.drawRRect(filterRect, filterPaint);
    _drawLabel(canvas, 'Filter', Offset(152, 23), Colors.white);

    // Filtered result (grayscale)
    final afterX = 190.0;
    final grays = [0.3, 0.59, 0.11, 0.89]; // Approximate luminance
    for (var i = 0; i < 4; i++) {
      final grayValue = (grays[i] * 255).toInt();
      final paint = Paint()
        ..color = Color.fromARGB(255, grayValue, grayValue, grayValue);
      canvas.drawRect(Rect.fromLTWH(afterX + i * 25, 30, 20, 40), paint);
    }
    _drawLabel(canvas, 'Grayscale', Offset(225, 80));
  }

  void _drawLabel(Canvas canvas, String text, Offset pos, [Color? color]) {
    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color ?? const Color(0xFFD84315),
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(pos.dx - tp.width / 2, pos.dy));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildFilterTypesCard() {
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
            Icon(Icons.category, color: const Color(0xFFD84315)),
            const SizedBox(width: 8),
            const Text(
              'ColorFilter Types',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD84315),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildFilterTypeRow(
          'ColorFilter.mode',
          'Blend color with BlendMode',
          'ColorFilter.mode(Colors.red, BlendMode.color)',
        ),
        _buildFilterTypeRow(
          'ColorFilter.matrix',
          '5x4 color transformation',
          'ColorFilter.matrix([...20 values...])',
        ),
        _buildFilterTypeRow(
          'linearToSrgbGamma',
          'Linear to sRGB gamma',
          'ColorFilter.linearToSrgbGamma()',
        ),
        _buildFilterTypeRow(
          'srgbToLinearGamma',
          'sRGB to linear gamma',
          'ColorFilter.srgbToLinearGamma()',
        ),
      ],
    ),
  );
}

Widget _buildFilterTypeRow(String name, String desc, String code) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: const Color(0xFFD84315),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                desc,
                style: TextStyle(fontSize: 11, color: Colors.grey[700]),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: const Color(0xFFFBE9E7),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 9,
              color: Color(0xFFBF360C),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildBlendModeCard() {
  // Common blend modes for color filters
  final modes = [
    {'mode': BlendMode.color, 'name': 'color', 'desc': 'Colorize'},
    {'mode': BlendMode.saturation, 'name': 'saturation', 'desc': 'Adjust sat'},
    {'mode': BlendMode.hue, 'name': 'hue', 'desc': 'Change hue'},
    {'mode': BlendMode.modulate, 'name': 'modulate', 'desc': 'Multiply'},
    {'mode': BlendMode.overlay, 'name': 'overlay', 'desc': 'Overlay mix'},
    {'mode': BlendMode.srcIn, 'name': 'srcIn', 'desc': 'Tint solid'},
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
            Icon(Icons.gradient, color: const Color(0xFFD84315)),
            const SizedBox(width: 8),
            const Text(
              'Common Blend Modes',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD84315),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: modes.map((m) {
            return Container(
              width: 95,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFBE9E7),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    m['name'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Color(0xFFD84315),
                    ),
                  ),
                  Text(
                    m['desc'] as String,
                    style: TextStyle(fontSize: 8, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    ),
  );
}

Widget _buildMatrixCard() {
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
            Icon(Icons.grid_3x3, color: const Color(0xFFD84315)),
            const SizedBox(width: 8),
            const Text(
              'Color Matrix (5x4)',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD84315),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 100,
          child: CustomPaint(
            size: const Size(double.infinity, 100),
            painter: _MatrixPainter(),
          ),
        ),
        const SizedBox(height: 12),
        _buildCodeSnippet(
          '// Grayscale matrix\n'
          'const grayscale = [\n'
          '  0.2126, 0.7152, 0.0722, 0, 0,  // R\n'
          '  0.2126, 0.7152, 0.0722, 0, 0,  // G\n'
          '  0.2126, 0.7152, 0.0722, 0, 0,  // B\n'
          '  0,      0,      0,      1, 0,  // A\n'
          '];',
        ),
      ],
    ),
  );
}

class _MatrixPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw matrix grid
    final cellW = 35.0;
    final cellH = 20.0;
    final startX = (size.width - cellW * 5) / 2;
    final startY = 10.0;

    final headers = ['R', 'G', 'B', 'A', '+'];
    final rows = ['R\'', 'G\'', 'B\'', 'A\''];

    // Header
    for (var i = 0; i < headers.length; i++) {
      _drawCell(
        canvas,
        Rect.fromLTWH(startX + i * cellW, startY, cellW, cellH),
        headers[i],
        const Color(0xFFD84315),
        Colors.white,
      );
    }

    // Row labels and cells
    for (var r = 0; r < rows.length; r++) {
      // Row label
      final tp = TextPainter(
        text: TextSpan(
          text: rows[r],
          style: const TextStyle(
            color: Color(0xFFD84315),
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: ui.TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(startX - 20, startY + (r + 1) * cellH + 3));

      // Cells (show diagonal as 1, others as 0)
      for (var c = 0; c < 5; c++) {
        final value = (r == c && c < 4) ? '1' : '0';
        _drawCell(
          canvas,
          Rect.fromLTWH(
            startX + c * cellW,
            startY + (r + 1) * cellH,
            cellW,
            cellH,
          ),
          value,
          const Color(0xFFFBE9E7),
          const Color(0xFFBF360C),
        );
      }
    }
  }

  void _drawCell(Canvas canvas, Rect rect, String text, Color bg, Color fg) {
    final paint = Paint()
      ..color = bg
      ..style = PaintingStyle.fill;
    canvas.drawRect(rect, paint);

    final borderPaint = Paint()
      ..color = const Color(0xFFD84315).withAlpha(50)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawRect(rect, borderPaint);

    final tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: fg, fontSize: 10, fontWeight: FontWeight.bold),
      ),
      textDirection: ui.TextDirection.ltr,
    );
    tp.layout();
    tp.paint(
      canvas,
      Offset(
        rect.left + (rect.width - tp.width) / 2,
        rect.top + (rect.height - tp.height) / 2,
      ),
    );
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

Widget _buildLiveEffectsCard() {
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
            Icon(Icons.preview, color: const Color(0xFFD84315)),
            const SizedBox(width: 8),
            const Text(
              'Live Effect Demos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD84315),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildEffectDemo('Original', null),
            const SizedBox(width: 8),
            _buildEffectDemo('Grayscale', _grayscaleFilter()),
            const SizedBox(width: 8),
            _buildEffectDemo('Sepia', _sepiaFilter()),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildEffectDemo(
              'Red Tint',
              ColorFilter.mode(Colors.red.withAlpha(100), BlendMode.srcATop),
            ),
            const SizedBox(width: 8),
            _buildEffectDemo('Invert', _invertFilter()),
            const SizedBox(width: 8),
            _buildEffectDemo('High Sat', _highSaturationFilter()),
          ],
        ),
      ],
    ),
  );
}

ColorFilter _grayscaleFilter() {
  return const ColorFilter.matrix(<double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
}

ColorFilter _sepiaFilter() {
  return const ColorFilter.matrix(<double>[
    0.393,
    0.769,
    0.189,
    0,
    0,
    0.349,
    0.686,
    0.168,
    0,
    0,
    0.272,
    0.534,
    0.131,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
}

ColorFilter _invertFilter() {
  return const ColorFilter.matrix(<double>[
    -1,
    0,
    0,
    0,
    255,
    0,
    -1,
    0,
    0,
    255,
    0,
    0,
    -1,
    0,
    255,
    0,
    0,
    0,
    1,
    0,
  ]);
}

ColorFilter _highSaturationFilter() {
  const s = 2.0; // Saturation multiplier
  const lumR = 0.3086;
  const lumG = 0.6094;
  const lumB = 0.0820;
  return ColorFilter.matrix(<double>[
    lumR * (1 - s) + s,
    lumG * (1 - s),
    lumB * (1 - s),
    0,
    0,
    lumR * (1 - s),
    lumG * (1 - s) + s,
    lumB * (1 - s),
    0,
    0,
    lumR * (1 - s),
    lumG * (1 - s),
    lumB * (1 - s) + s,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
}

Widget _buildEffectDemo(String label, ColorFilter? filter) {
  final child = Container(
    width: 60,
    height: 60,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.red,
          Colors.orange,
          Colors.yellow,
          Colors.green,
          Colors.blue,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Icon(Icons.image, color: Colors.white.withAlpha(150), size: 24),
    ),
  );

  return Expanded(
    child: Column(
      children: [
        filter != null
            ? ColorFiltered(colorFilter: filter, child: child)
            : child,
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: Color(0xFFD84315),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPresetsCard() {
  final presets = [
    {'name': 'Grayscale', 'desc': 'Remove color saturation'},
    {'name': 'Sepia', 'desc': 'Warm, vintage look'},
    {'name': 'Invert', 'desc': 'Negative colors effect'},
    {'name': 'High Contrast', 'desc': 'Accessibility enhancement'},
    {'name': 'Protanopia', 'desc': 'Red-blind simulation'},
    {'name': 'Night Mode', 'desc': 'Reduce blue light'},
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
            Icon(Icons.palette, color: const Color(0xFFD84315)),
            const SizedBox(width: 8),
            const Text(
              'Common Presets',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD84315),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...presets.map(
          (p) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBE9E7),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Icon(
                    Icons.filter_vintage,
                    size: 14,
                    color: const Color(0xFFD84315),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        p['name'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                      Text(
                        p['desc'] as String,
                        style: TextStyle(fontSize: 9, color: Colors.grey[600]),
                      ),
                    ],
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

Widget _buildUseCasesCard() {
  final cases = [
    {
      'icon': Icons.photo_filter,
      'title': 'Photo Editing',
      'desc': 'Apply filter effects to images',
    },
    {
      'icon': Icons.accessibility,
      'title': 'Accessibility',
      'desc': 'Color blindness, contrast',
    },
    {
      'icon': Icons.nightlight,
      'title': 'Dark Mode',
      'desc': 'Adjust colors for dark theme',
    },
    {
      'icon': Icons.mood,
      'title': 'Mood Effects',
      'desc': 'Create atmosphere with tints',
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
            Icon(Icons.lightbulb, color: const Color(0xFFD84315)),
            const SizedBox(width: 8),
            const Text(
              'Use Cases',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFD84315),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...cases.map(
          (c) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBE9E7),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    c['icon'] as IconData,
                    size: 16,
                    color: const Color(0xFFD84315),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c['title'] as String,
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
          ),
        ),
      ],
    ),
  );
}

Widget _buildResultsCard(
  bool layerCreated,
  String filterType,
  String blendMode,
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
                color: Color(0xFFD84315),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _buildResultRow(
          'Layer created',
          layerCreated ? 'Yes' : 'No',
          layerCreated,
        ),
        _buildResultRow('Filter type', filterType, true),
        _buildResultRow('Blend mode', blendMode, true),
      ],
    ),
  );
}

Widget _buildResultRow(String label, String value, bool success) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        Icon(
          success ? Icons.check_circle : Icons.cancel,
          size: 14,
          color: success ? const Color(0xFF4CAF50) : Colors.red,
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 100,
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

dynamic build(BuildContext context) {
  print('=== ColorFilterLayer Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: OVERVIEW
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- ColorFilterLayer Overview ---');
  print('Applies a ColorFilter to all child layers');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: CREATE FILTERS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Creating Color Filters ---');

  // Mode filter
  final modeFilter = ColorFilter.mode(
    Colors.red.withAlpha(100),
    BlendMode.srcATop,
  );
  print('Mode filter: $modeFilter');

  // Matrix filter (grayscale)
  final grayscaleMatrix = <double>[
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0.2126,
    0.7152,
    0.0722,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ];
  final matrixFilter = ColorFilter.matrix(grayscaleMatrix);
  print('Matrix filter (grayscale): $matrixFilter');

  // Gamma filters
  final linearToSrgb = ColorFilter.linearToSrgbGamma();
  final srgbToLinear = ColorFilter.srgbToLinearGamma();
  print('Gamma filters: $linearToSrgb, $srgbToLinear');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: CREATE LAYER
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Creating ColorFilterLayer ---');

  final layer = ColorFilterLayer(colorFilter: modeFilter);

  print('Layer type: ${layer.runtimeType}');
  print('Color filter: ${layer.colorFilter}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: BLEND MODES
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Common Blend Modes ---');
  print('BlendMode.color: Apply hue and saturation');
  print('BlendMode.saturation: Adjust saturation');
  print('BlendMode.hue: Change hue only');
  print('BlendMode.modulate: Multiply colors');
  print('BlendMode.overlay: Mix colors');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: PRESETS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Common Presets ---');
  print('Grayscale: Remove color saturation');
  print('Sepia: Warm, vintage tone');
  print('Invert: Negative colors');
  print('High saturation: Boost colors');

  print('\n=== ColorFilterLayer Deep Demo Complete ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL UI
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _buildHeader('ColorFilterLayer', 'Apply Color Effects to Layers'),
        const SizedBox(height: 20),

        // Concept
        _buildSectionTitle('Concept', Icons.filter),
        _buildConceptCard(),
        const SizedBox(height: 20),

        // Filter types
        _buildSectionTitle('Filter Types', Icons.category),
        _buildFilterTypesCard(),
        const SizedBox(height: 20),

        // Live effects
        _buildSectionTitle('Live Effects', Icons.preview),
        _buildLiveEffectsCard(),
        const SizedBox(height: 20),

        // Blend modes
        _buildSectionTitle('Blend Modes', Icons.gradient),
        _buildBlendModeCard(),
        const SizedBox(height: 20),

        // Matrix
        _buildSectionTitle('Color Matrix', Icons.grid_3x3),
        _buildMatrixCard(),
        const SizedBox(height: 20),

        // Presets
        _buildSectionTitle('Presets', Icons.palette),
        _buildPresetsCard(),
        const SizedBox(height: 20),

        // Use cases
        _buildSectionTitle('Use Cases', Icons.lightbulb),
        _buildUseCasesCard(),
        const SizedBox(height: 20),

        // Results
        _buildSectionTitle('Test Results', Icons.check_circle),
        _buildResultsCard(true, 'ColorFilter.mode', 'BlendMode.srcATop'),
        const SizedBox(height: 20),

        // Summary
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFBE9E7),
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
                  color: Color(0xFFD84315),
                ),
              ),
              SizedBox(height: 8),
              Text(
                '• ColorFilterLayer applies color effects\n'
                '• Use ColorFilter.mode for blend effects\n'
                '• Use ColorFilter.matrix for full control\n'
                '• Common: grayscale, sepia, invert\n'
                '• Useful for photo filters, accessibility\n'
                '• Use ColorFiltered widget for convenience',
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
