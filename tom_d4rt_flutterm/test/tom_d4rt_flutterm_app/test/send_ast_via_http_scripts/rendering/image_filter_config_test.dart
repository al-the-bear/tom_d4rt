// ignore_for_file: avoid_print
// D4rt test script: Comprehensive demo for ImageFilterConfig from rendering
//
// ImageFilter in Flutter provides GPU-accelerated visual effects including
// blur, matrix transforms, dilation, erosion, and compositing. While
// ImageFilterConfig is an internal configuration class, ImageFilter itself
// is the primary public API for applying filters to render objects.
//
// This demo covers:
//   1. ImageFilter.blur – Gaussian blur with different sigma values
//   2. ImageFilter.matrix – Transform-based image filters
//   3. ImageFilter.dilate and .erode – Morphological operations
//   4. ImageFilter.compose – Chaining multiple filters
//   5. BackdropFilter usage with ImageFilter
//   6. Practical blur and glass-morphism effects
//
// ═══════════════════════════════════════════════════════════════════════════
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

// ═══════════════════════════════════════════════════════════════════════════
// CONSTANTS – Orange / Slate theme
// ═══════════════════════════════════════════════════════════════════════════

const _kOrange50 = Color(0xFFFFF7ED);
const _kOrange200 = Color(0xFFFED7AA);
const _kOrange400 = Color(0xFFFB923C);
const _kOrange500 = Color(0xFFF97316);
const _kOrange600 = Color(0xFFEA580C);
const _kOrange700 = Color(0xFFC2410C);
const _kOrange800 = Color(0xFF9A3412);

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
        colors: [_kOrange800, _kOrange600],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: _kOrange800.withAlpha(80),
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

/// Builds a colorful sample widget to apply filters on
Widget _buildSampleContent() {
  return Container(
    width: double.infinity,
    height: 80,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [_kOrange400, _kOrange600, Colors.deepPurple],
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: Colors.white, size: 28),
          const Text(
            'Sample Content',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ],
      ),
    ),
  );
}

/// Builds a blur comparison card
Widget _buildBlurCard(String label, double sigmaX, double sigmaY) {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kOrange200),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          // Blurred content
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
            child: Stack(
              children: [
                _buildSampleContent(),
                Positioned.fill(
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
                    child: Container(color: Colors.transparent),
                  ),
                ),
              ],
            ),
          ),
          // Label
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(8),
            color: _kSlate50,
            child: Column(
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _kSlate800,
                  ),
                ),
                Text(
                  'σX=$sigmaX σY=$sigmaY',
                  style: TextStyle(
                    fontSize: 10,
                    color: _kOrange600,
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

/// Builds a filter info card
Widget _buildFilterInfoCard(
  String name,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
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
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: _kSlate800,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(height: 2),
              Text(
                description,
                style: TextStyle(fontSize: 12, color: _kSlate600, height: 1.3),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Builds a code example
Widget _buildCodeCard(String title, String code, String explanation) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kOrange200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kOrange50,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(11)),
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: _kOrange800,
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

/// Builds a glass effect card
Widget _buildGlassCard(String title, double sigma, Color tint) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _kOrange200),
    ),
    clipBehavior: Clip.antiAlias,
    child: Stack(
      children: [
        // Background with colorful content
        Container(
          height: 120,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [_kOrange400, Colors.deepPurple, Colors.teal],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.circle,
                  color: Colors.white.withAlpha(180),
                  size: 40,
                ),
                Icon(
                  Icons.square,
                  color: Colors.yellow.withAlpha(180),
                  size: 40,
                ),
                Icon(
                  Icons.hexagon,
                  color: Colors.cyan.withAlpha(180),
                  size: 40,
                ),
              ],
            ),
          ),
        ),
        // Glass overlay
        Positioned.fill(
          child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
            child: Container(
              color: tint.withAlpha(40),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'sigma: $sigma',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withAlpha(200),
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
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
  print('ImageFilterConfig deep demo executing');

  // === Data exploration ===
  final blurFilter = ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5);
  print('ImageFilter.blur: $blurFilter');
  print('ImageFilter types: blur, matrix, dilate, erode, compose');

  print('ImageFilterConfig deep demo completed');

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
              colors: [_kOrange800, _kOrange500],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _kOrange800.withAlpha(60),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            children: [
              const Icon(Icons.blur_on, color: Colors.white, size: 48),
              const SizedBox(height: 12),
              const Text(
                'ImageFilter Config',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'GPU-accelerated blur, transform, and morphological '
                'filters for visual effects',
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

        // ─── Section 1: Filter Types ────────────────────────────────
        _buildSectionHeader('ImageFilter Types', Icons.filter),

        _buildFilterInfoCard(
          'ImageFilter.blur()',
          'Gaussian blur with independent sigmaX and sigmaY '
              'for horizontal and vertical blur amounts.',
          Icons.blur_on,
          _kOrange500,
        ),
        _buildFilterInfoCard(
          'ImageFilter.matrix()',
          '4×4 matrix transform applied as a filter, allowing '
              'rotation, scaling, and perspective transforms.',
          Icons.transform,
          Colors.deepPurple,
        ),
        _buildFilterInfoCard(
          'ImageFilter.dilate()',
          'Morphological dilation — expands bright areas of the image. '
              'Makes light features larger.',
          Icons.open_in_full,
          Colors.teal,
        ),
        _buildFilterInfoCard(
          'ImageFilter.erode()',
          'Morphological erosion — shrinks bright areas of the image. '
              'Makes dark features larger.',
          Icons.close_fullscreen,
          Colors.indigo,
        ),
        _buildFilterInfoCard(
          'ImageFilter.compose()',
          'Chains two ImageFilters: applies outer filter to the '
              'result of inner filter. Enables complex multi-step effects.',
          Icons.auto_awesome,
          _kOrange700,
        ),

        const SizedBox(height: 24),

        // ─── Section 2: Blur Comparison ─────────────────────────────
        _buildSectionHeader('Blur Strength Comparison', Icons.blur_linear),

        Row(
          children: [
            _buildBlurCard('None', 0, 0),
            const SizedBox(width: 8),
            _buildBlurCard('Light', 2, 2),
            const SizedBox(width: 8),
            _buildBlurCard('Medium', 5, 5),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildBlurCard('Heavy', 10, 10),
            const SizedBox(width: 8),
            _buildBlurCard('X-only', 8, 0),
            const SizedBox(width: 8),
            _buildBlurCard('Y-only', 0, 8),
          ],
        ),

        const SizedBox(height: 24),

        // ─── Section 3: Glass Effects ───────────────────────────────
        _buildSectionHeader('Glass Morphism Effects', Icons.auto_awesome),

        _buildGlassCard('Light Frost', 3, Colors.white),
        _buildGlassCard('Medium Glass', 8, Colors.white),
        _buildGlassCard('Heavy Blur', 15, Colors.white),
        _buildGlassCard('Tinted Glass', 10, _kOrange400),

        const SizedBox(height: 24),

        // ─── Section 4: TileMode ────────────────────────────────────
        _buildSectionHeader('Blur TileMode', Icons.grid_view),

        Text(
          'ImageFilter.blur accepts a tileMode parameter that controls '
          'how blur samples beyond the edge of the image:',
          style: TextStyle(fontSize: 14, color: _kSlate700, height: 1.5),
        ),
        const SizedBox(height: 12),

        ...[
          (
            'TileMode.clamp',
            'Extends edge pixels (default)',
            Icons.border_outer,
            _kOrange500,
          ),
          (
            'TileMode.repeated',
            'Tiles the image',
            Icons.grid_on,
            Colors.deepPurple,
          ),
          ('TileMode.mirror', 'Mirrors at edges', Icons.flip, Colors.teal),
          (
            'TileMode.decal',
            'Transparent beyond edges',
            Icons.crop_free,
            Colors.indigo,
          ),
        ].map(
          (item) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: item.$4.withAlpha(10),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: item.$4.withAlpha(50)),
            ),
            child: Row(
              children: [
                Icon(item.$3, color: item.$4, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.$1,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: _kSlate800,
                          fontFamily: 'monospace',
                        ),
                      ),
                      Text(
                        item.$2,
                        style: TextStyle(fontSize: 12, color: _kSlate600),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 24),

        // ─── Section 5: Code Examples ───────────────────────────────
        _buildSectionHeader('Code Examples', Icons.code),

        _buildCodeCard(
          'BackdropFilter with Blur',
          'BackdropFilter(\n'
              '  filter: ImageFilter.blur(\n'
              '    sigmaX: 10,\n'
              '    sigmaY: 10,\n'
              '  ),\n'
              '  child: Container(\n'
              '    color: Colors.white24,\n'
              '    child: Text("Frosted"),\n'
              '  ),\n'
              ')',
          'BackdropFilter applies ImageFilter to everything behind it, '
              'creating frosted glass effects.',
        ),
        _buildCodeCard(
          'Composed Filters',
          'final composed = ImageFilter.compose(\n'
              '  outer: ImageFilter.blur(\n'
              '    sigmaX: 5, sigmaY: 5),\n'
              '  inner: ImageFilter.dilate(\n'
              '    radiusX: 1, radiusY: 1),\n'
              ');\n'
              'BackdropFilter(filter: composed, ...)',
          'compose() chains filters: inner runs first producing an '
              'intermediate result, then outer processes that result.',
        ),
        _buildCodeCard(
          'Paint with ImageFilter',
          'final paint = Paint()\n'
              '  ..imageFilter = ImageFilter.blur(\n'
              '    sigmaX: 3, sigmaY: 3);\n'
              '// Use in CustomPainter\n'
              'canvas.drawImage(img, Offset.zero,\n'
              '  paint);',
          'ImageFilter can also be set on a Paint object for use '
              'in CustomPainter for per-draw-call filtering.',
        ),

        const SizedBox(height: 24),

        // ─── Section 6: Practical Uses ──────────────────────────────
        _buildSectionHeader('Practical Uses', Icons.work),

        ...[
          (
            'Modal Backgrounds',
            'Blur the background when showing a '
                'dialog or bottom sheet for visual depth.',
            Icons.window,
            _kOrange600,
          ),
          (
            'Status Bar Blur',
            'Apply subtle blur behind the status bar '
                'area for iOS-style translucency.',
            Icons.smartphone,
            Colors.deepPurple,
          ),
          (
            'Image Placeholders',
            'Show a heavily blurred thumbnail '
                'while the full image loads.',
            Icons.image,
            Colors.teal,
          ),
          (
            'Search Overlays',
            'Blur the page content when search '
                'overlay is active to focus attention.',
            Icons.search,
            Colors.indigo,
          ),
          (
            'Depth of Field',
            'Blur background layers to simulate '
                'camera depth-of-field in parallax UIs.',
            Icons.camera,
            _kOrange700,
          ),
        ].map(
          (item) => Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: item.$4.withAlpha(10),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: item.$4.withAlpha(50)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: item.$4.withAlpha(25),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(item.$3, color: item.$4, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.$1,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: _kSlate800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.$2,
                        style: TextStyle(
                          fontSize: 12,
                          color: _kSlate600,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 32),
      ],
    ),
  );
}
