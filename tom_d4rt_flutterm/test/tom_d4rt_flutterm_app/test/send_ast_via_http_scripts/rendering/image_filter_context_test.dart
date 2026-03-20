// D4rt test script: Comprehensive demo for ImageFilterContext from rendering
//
// ImageFilter in Flutter's rendering layer operates within a "context" —
// the compositing layer tree that determines how filters clip, transform,
// and blend with surrounding paint operations. This demo explores how
// ImageFilter integrates with the layer-based painting context.
//
// This demo covers:
//   1. How BackdropFilter creates filter layers in the compositing tree
//   2. ClipRect and filter boundary contexts
//   3. Opacity + filter layer interactions
//   4. Nested filter contexts (filter within filter)
//   5. ColorFilter vs ImageFilter contexts
//   6. Shader mask + filter combinations
//
// ═══════════════════════════════════════════════════════════════════════════
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS – Indigo / Yellow theme
// ═══════════════════════════════════════════════════════════════════════════

const _kIndigo50 = Color(0xFFEEF2FF);
const _kIndigo200 = Color(0xFFC7D2FE);
const _kIndigo400 = Color(0xFF818CF8);
const _kIndigo500 = Color(0xFF6366F1);
const _kIndigo600 = Color(0xFF4F46E5);
const _kIndigo800 = Color(0xFF3730A3);

const _kYellow400 = Color(0xFFFACC15);
const _kYellow500 = Color(0xFFEAB308);

const _kSlate50 = Color(0xFFF8FAFC);
const _kSlate600 = Color(0xFF475569);
const _kSlate700 = Color(0xFF334155);
const _kSlate800 = Color(0xFF1E293B);

// ═══════════════════════════════════════════════════════════════════════════
// HELPER WIDGETS
// ═══════════════════════════════════════════════════════════════════════════

/// Section header
Widget _buildSectionHeader(String title, IconData icon) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.only(bottom: 16),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kIndigo800, _kIndigo600],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: _kIndigo800.withAlpha(80),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Builds a colorful background
Widget _buildColorfulBg({double height = 100}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          _kIndigo400,
          Colors.deepPurple,
          Colors.pinkAccent,
          _kYellow400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.circle, size: 30, color: Colors.white.withAlpha(200)),
          Icon(Icons.star, size: 30, color: Colors.yellow.withAlpha(200)),
          Icon(Icons.diamond, size: 30, color: Colors.cyan.withAlpha(200)),
          Icon(Icons.favorite, size: 30, color: Colors.red.withAlpha(200)),
        ],
      ),
    ),
  );
}

/// Builds a filter demo card
Widget _buildFilterDemo(String title, String subtitle, Widget child) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        child,
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          color: _kSlate50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kSlate800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12, color: _kSlate600, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a layer concept card
Widget _buildLayerCard(String name, String desc, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withAlpha(60)),
    ),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color.withAlpha(20),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: _kSlate800,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: TextStyle(fontSize: 12, color: _kSlate600, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a code example card
Widget _buildCodeCard(String title, String code, String explanation) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kIndigo200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kIndigo50,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _kIndigo800,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: _kSlate800,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  code,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontFamily: 'monospace',
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                explanation,
                style: TextStyle(fontSize: 12, color: _kSlate600, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ═══════════════════════════════════════════════════════════════════════════
// MAIN BUILD
// ═══════════════════════════════════════════════════════════════════════════

dynamic build(BuildContext context) {
  print('ImageFilterContext deep demo executing');

  // === Data exploration ===
  print('BackdropFilter creates a BackdropFilterLayer in the compositing tree');
  print(
    'The filter context determines clip bounds and transform for the filter',
  );
  print('Nested filters create multiple BackdropFilterLayers');

  print('ImageFilterContext deep demo completed');

  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── Title ───────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_kIndigo800, _kIndigo500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _kIndigo800.withAlpha(60),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              const Icon(Icons.layers, color: Colors.white, size: 48),
              const SizedBox(height: 12),
              const Text(
                'ImageFilter Context',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'How image filters integrate with the compositing '
                'layer tree and rendering context',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withAlpha(200),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // ─── Section 1: Compositing Layer Tree ──────────────────────
        _buildSectionHeader('Compositing Layers', Icons.account_tree),

        Text(
          'When BackdropFilter is used, Flutter creates a compositing '
          'layer tree. Each BackdropFilter adds a BackdropFilterLayer '
          'that applies the ImageFilter to the layers below it:',
          style: TextStyle(fontSize: 14, color: _kSlate700, height: 1.5),
        ),
        const SizedBox(height: 12),

        _buildLayerCard(
          'TransformLayer',
          'Root layer with device transform',
          Icons.transform,
          _kIndigo500,
        ),
        _buildLayerCard(
          'ClipRectLayer',
          'Clips filter to visible bounds',
          Icons.crop,
          Colors.deepPurple,
        ),
        _buildLayerCard(
          'BackdropFilterLayer',
          'Applies ImageFilter to content below',
          Icons.blur_on,
          _kYellow500,
        ),
        _buildLayerCard(
          'PictureLayer',
          'Rasterized widget content',
          Icons.image,
          Colors.teal,
        ),
        _buildLayerCard(
          'OpacityLayer',
          'Modifies alpha of filtered result',
          Icons.opacity,
          Colors.pink,
        ),

        const SizedBox(height: 24),

        // ─── Section 2: Filter Boundaries ───────────────────────────
        _buildSectionHeader('Filter Boundaries', Icons.crop_square),

        Text(
          'The filter context determines the clip bounds. A BackdropFilter '
          'only affects the area defined by its ancestor clip:',
          style: TextStyle(fontSize: 14, color: _kSlate700, height: 1.5),
        ),
        const SizedBox(height: 12),

        // Full width filter
        _buildFilterDemo(
          'Full Width Filter',
          'No clip — filter affects entire width',
          Stack(
            children: [
              _buildColorfulBg(),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(color: Colors.white.withAlpha(20)),
                ),
              ),
            ],
          ),
        ),

        // Clipped filter
        _buildFilterDemo(
          'Clipped Filter Context',
          'ClipRRect limits the filter to a rounded rectangle area',
          Stack(
            children: [
              _buildColorfulBg(),
              Positioned(
                left: 40,
                top: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      width: 160,
                      height: 80,
                      color: Colors.white.withAlpha(40),
                      child: const Center(
                        child: Text(
                          'Clipped Blur',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // ─── Section 3: Opacity + Filter ────────────────────────────
        _buildSectionHeader('Opacity + Filter Interaction', Icons.opacity),

        _buildFilterDemo(
          'Full Opacity',
          'Filter at 100% — standard backdrop blur',
          Stack(
            children: [
              _buildColorfulBg(height: 80),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    color: Colors.white.withAlpha(40),
                    child: const Center(
                      child: Text(
                        'Opacity 1.0',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildFilterDemo(
          'Reduced Opacity',
          'Opacity(0.5) wrapping BackdropFilter — blends filtered and unfiltered',
          Stack(
            children: [
              _buildColorfulBg(height: 80),
              Positioned.fill(
                child: Opacity(
                  opacity: 0.5,
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                    child: Container(
                      color: Colors.white.withAlpha(40),
                      child: const Center(
                        child: Text(
                          'Opacity 0.5',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 24),

        // ─── Section 4: Nested Filters ──────────────────────────────
        _buildSectionHeader('Nested Filter Contexts', Icons.filter_none),

        Text(
          'Multiple BackdropFilters can nest, each creating its own '
          'filter layer in the compositing tree:',
          style: TextStyle(fontSize: 14, color: _kSlate700, height: 1.5),
        ),
        const SizedBox(height: 12),

        _buildFilterDemo(
          'Nested Blur Filters',
          'Outer blur σ=3 + Inner blur σ=8 — effects compound',
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
            child: Stack(
              children: [
                _buildColorfulBg(height: 120),
                // Outer filter
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(
                      color: Colors.transparent,
                      child: Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                            child: Container(
                              width: 180,
                              height: 60,
                              color: Colors.white.withAlpha(50),
                              child: const Center(
                                child: Text(
                                  'Extra Blurred Center',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // ─── Section 5: ColorFilter vs ImageFilter ──────────────────
        _buildSectionHeader('ColorFilter vs ImageFilter', Icons.color_lens),

        ...[
          (
            'ColorFilter',
            'Operates on individual pixel colors '
                '(grayscale, sepia, color matrix).',
            Icons.palette,
            _kIndigo600,
          ),
          (
            'ImageFilter',
            'Operates on the image as a whole '
                '(blur, transform, morphology).',
            Icons.blur_on,
            _kYellow500,
          ),
          (
            'Key difference',
            'ColorFilter changes what colors pixels are; '
                'ImageFilter changes where pixels are.',
            Icons.compare,
            Colors.deepPurple,
          ),
        ].map((item) => _buildLayerCard(item.$1, item.$2, item.$3, item.$4)),

        const SizedBox(height: 24),

        // ─── Section 6: Code Examples ───────────────────────────────
        _buildSectionHeader('Code Examples', Icons.code),

        _buildCodeCard(
          'Filter in Painting Context',
          'class MyPainter extends CustomPainter {\n'
              '  void paint(Canvas canvas, Size size) {\n'
              '    final paint = Paint()\n'
              '      ..imageFilter =\n'
              '        ImageFilter.blur(\n'
              '          sigmaX: 4, sigmaY: 4);\n'
              '    canvas.saveLayer(bounds, paint);\n'
              '    // Draw content...\n'
              '    canvas.restore();\n'
              '  }\n'
              '}',
          'canvas.saveLayer creates a filter context — the paint\'s '
              'imageFilter applies to everything drawn within the layer.',
        ),
        _buildCodeCard(
          'RenderObject pushLayer',
          'void paint(PaintingContext ctx,\n'
              '    Offset offset) {\n'
              '  ctx.pushLayer(\n'
              '    BackdropFilterLayer(\n'
              '      filter: _filter),\n'
              '    super.paint,\n'
              '    offset,\n'
              '  );\n'
              '}',
          'RenderObjects use PaintingContext.pushLayer to add filter '
              'layers to the compositing tree during painting.',
        ),

        const SizedBox(height: 24),

        // ─── Section 7: Relationships ───────────────────────────────
        _buildSectionHeader('Related Classes', Icons.hub),

        ...[
          (
            'BackdropFilter',
            'Widget that applies filter to background',
            Icons.blur_on,
            _kIndigo500,
          ),
          (
            'ImageFilter',
            'The filter descriptor (blur/matrix/morph)',
            Icons.filter,
            _kYellow500,
          ),
          (
            'PaintingContext',
            'Provides layer push methods',
            Icons.brush,
            Colors.teal,
          ),
          (
            'BackdropFilterLayer',
            'Compositing layer for the filter',
            Icons.layers,
            Colors.deepPurple,
          ),
          (
            'Canvas.saveLayer',
            'Creates paint-level filter context',
            Icons.save,
            Colors.pink,
          ),
        ].map((item) => _buildLayerCard(item.$1, item.$2, item.$3, item.$4)),

        const SizedBox(height: 32),
      ],
    ),
  );
}
