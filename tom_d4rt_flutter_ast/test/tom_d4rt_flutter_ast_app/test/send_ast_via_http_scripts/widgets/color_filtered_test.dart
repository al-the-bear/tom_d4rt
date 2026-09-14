// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: deep visual demo of ColorFiltered + ColorFilter.
//
// This file illustrates ColorFiltered, a widget that wraps a child subtree and
// composites every painted pixel through a dart:ui ColorFilter. Three filter
// flavors are explored:
//   * ColorFilter.mode(Color, BlendMode) — blend a flat color over content
//   * ColorFilter.matrix(List<double>) — 5x4 channel matrix transform
//   * ColorFilter.linearToSrgbGamma / srgbToLinearGamma — gamma corrections
//
// Constraints: static-only sandbox. No StatefulWidget, no setState, no timers,
// no controllers. Helpers are top-level functions so the d4rt analyzer-free
// interpreter can render them deterministically.

import 'package:flutter/material.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Theme palette (prefix _cf for ColorFiltered).
// ─────────────────────────────────────────────────────────────────────────────

const Color _cfInk = Color(0xFF1A1A2E);
const Color _cfPanel = Color(0xFFF5F3EF);
const Color _cfAccent = Color(0xFFE94560);
const Color _cfMuted = Color(0xFF6B7280);
const Color _cfSurface = Color(0xFFFFFFFF);
const Color _cfHighlight = Color(0xFF0F3460);
const Color _cfSoft = Color(0xFFE6E6F0);
const Color _cfWarn = Color(0xFFF59E0B);
const Color _cfOk = Color(0xFF10B981);
const Color _cfDivider = Color(0xFFE5E7EB);

// Source palette used to make the "before" content recognizable.
const Color _srcRed = Color(0xFFE11D48);
const Color _srcGreen = Color(0xFF22C55E);
const Color _srcBlue = Color(0xFF3B82F6);
const Color _srcYellow = Color(0xFFFACC15);
const Color _srcMagenta = Color(0xFFD946EF);
const Color _srcCyan = Color(0xFF06B6D4);

// ─────────────────────────────────────────────────────────────────────────────
// Entry point.
// ─────────────────────────────────────────────────────────────────────────────

dynamic build(BuildContext context) {
  return MaterialApp(
    title: 'ColorFiltered Demo',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: _cfPanel,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _cfHighlight,
        primary: _cfHighlight,
        secondary: _cfAccent,
      ),
    ),
    home: Scaffold(
      appBar: AppBar(
        backgroundColor: _cfInk,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'ColorFiltered & ColorFilter',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.4),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildIntroCard(),
          const SizedBox(height: 20),
          _buildBlendModesGrid(),
          const SizedBox(height: 20),
          _buildMatrixTransforms(),
          const SizedBox(height: 20),
          _buildGammaCorrection(),
          const SizedBox(height: 20),
          _buildBeforeAfterComparison(),
          const SizedBox(height: 20),
          _buildAnatomyDiagram(),
          const SizedBox(height: 20),
          _buildAdvancedRecipes(),
          const SizedBox(height: 20),
          _buildPerformanceNotes(),
          const SizedBox(height: 20),
          _buildUsageGuide(),
          const SizedBox(height: 24),
          _buildFooter(),
        ],
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Source content used as input to every filter.
// ─────────────────────────────────────────────────────────────────────────────

Widget _sourceContent({double height = 120, double radius = 12}) {
  return Container(
    height: height,
    clipBehavior: Clip.antiAlias,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_srcRed, _srcYellow, _srcGreen, _srcCyan, _srcBlue, _srcMagenta],
        stops: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.10),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Stack(
      fit: StackFit.expand,
      children: [
        // Translucent dots
        Positioned(
          left: 18,
          top: 14,
          child: _dot(28, Colors.white.withOpacity(0.85)),
        ),
        Positioned(
          right: 22,
          top: 26,
          child: _dot(20, Colors.black.withOpacity(0.45)),
        ),
        Positioned(
          left: 50,
          bottom: 18,
          child: _dot(36, Colors.white.withOpacity(0.6)),
        ),
        Positioned(
          right: 52,
          bottom: 24,
          child: _dot(24, Colors.black.withOpacity(0.35)),
        ),
        // Center icon — universal source landmark.
        Center(
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(Icons.wb_sunny_rounded,
                color: _srcYellow, size: 26),
          ),
        ),
      ],
    ),
  );
}

Widget _dot(double size, Color c) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(color: c, shape: BoxShape.circle),
  );
}

Widget _miniSource({double height = 68}) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_srcRed, _srcYellow, _srcGreen, _srcBlue, _srcMagenta],
      ),
    ),
    child: Center(
      child: Container(
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.star_rounded,
            color: _srcRed, size: 18),
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable section shell — header + paragraph + body.
// ─────────────────────────────────────────────────────────────────────────────

Widget _section({
  required IconData icon,
  required String title,
  required String subtitle,
  required String paragraph,
  required Color tint,
  required Widget body,
}) {
  return Container(
    decoration: BoxDecoration(
      color: _cfSurface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _cfDivider, width: 1),
      boxShadow: [
        BoxShadow(
          color: tint.withOpacity(0.08),
          blurRadius: 18,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    padding: const EdgeInsets.all(18),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: tint.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: tint, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: _cfInk,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: _cfMuted,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _cfSoft,
            borderRadius: BorderRadius.circular(10),
            border: Border(
              left: BorderSide(color: tint, width: 3),
            ),
          ),
          child: Text(
            paragraph,
            style: const TextStyle(
              fontSize: 13.5,
              height: 1.5,
              color: Color(0xFF374151),
            ),
          ),
        ),
        const SizedBox(height: 16),
        body,
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// 1. Intro card.
// ─────────────────────────────────────────────────────────────────────────────

Widget _buildIntroCard() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [_cfInk, _cfHighlight, Color(0xFF533483)],
        stops: [0.0, 0.55, 1.0],
      ),
      boxShadow: [
        BoxShadow(
          color: _cfInk.withOpacity(0.35),
          blurRadius: 22,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    padding: const EdgeInsets.all(22),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.palette_rounded,
                  color: Colors.white, size: 28),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'ColorFiltered',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: _cfAccent,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: _cfAccent.withOpacity(0.5),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Text(
                'dart:ui',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'A widget that composites every pixel painted by its child through '
          'a dart:ui ColorFilter. Combine flat-color blends, channel matrices '
          'and gamma corrections to recolor any subtree without rasterizing.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _introChip('ColorFilter.mode'),
            _introChip('ColorFilter.matrix'),
            _introChip('linearToSrgbGamma'),
            _introChip('srgbToLinearGamma'),
            _introChip('BlendMode.srcIn'),
            _introChip('BlendMode.modulate'),
          ],
        ),
        const SizedBox(height: 18),
        // Side-by-side preview: source vs greyscale.
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  _sourceContent(height: 92, radius: 12),
                  const SizedBox(height: 6),
                  const Text(
                    'source',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  ColorFiltered(
                    colorFilter: const ColorFilter.matrix(_kGrayscaleMatrix),
                    child: _sourceContent(height: 92, radius: 12),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'grayscale matrix',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                        Color(0xFF1F2937), BlendMode.saturation),
                    child: _sourceContent(height: 92, radius: 12),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'mode (saturation)',
                    style: TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _introChip(String label) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(0.12),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.white.withOpacity(0.25)),
    ),
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11.5,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.2,
      ),
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// 2. Blend modes grid (≥18 modes).
// ─────────────────────────────────────────────────────────────────────────────

class _BlendEntry {
  final String name;
  final BlendMode mode;
  final Color tint;
  final String hint;
  const _BlendEntry(this.name, this.mode, this.tint, this.hint);
}

const List<_BlendEntry> _kBlendEntries = [
  _BlendEntry(
      'srcIn', BlendMode.srcIn, Color(0xFF0F3460), 'silhouette in tint color'),
  _BlendEntry('srcOver', BlendMode.srcOver, Color(0xCC1F2937),
      'overlay tint on top'),
  _BlendEntry('srcATop', BlendMode.srcATop, Color(0xCCE94560),
      'tint where child is opaque'),
  _BlendEntry(
      'dstIn', BlendMode.dstIn, Color(0xFF111827), 'keep child where tint is'),
  _BlendEntry('dstOver', BlendMode.dstOver, Color(0xFFF59E0B),
      'tint behind child'),
  _BlendEntry('modulate', BlendMode.modulate, Color(0xFFE94560),
      'channel-wise multiply'),
  _BlendEntry(
      'multiply', BlendMode.multiply, Color(0xFF7C3AED), 'darkening blend'),
  _BlendEntry('plus', BlendMode.plus, Color(0xFF0F766E), 'add channels'),
  _BlendEntry('screen', BlendMode.screen, Color(0xFFEF4444), 'inverse multiply'),
  _BlendEntry('overlay', BlendMode.overlay, Color(0xFF14B8A6),
      'screen + multiply mix'),
  _BlendEntry(
      'darken', BlendMode.darken, Color(0xFF7E22CE), 'min(src, dst)'),
  _BlendEntry(
      'lighten', BlendMode.lighten, Color(0xFFFACC15), 'max(src, dst)'),
  _BlendEntry('colorDodge', BlendMode.colorDodge, Color(0xFFEAB308),
      'brighten by tint'),
  _BlendEntry('colorBurn', BlendMode.colorBurn, Color(0xFF1F2937),
      'darken by tint'),
  _BlendEntry('hardLight', BlendMode.hardLight, Color(0xFF0EA5E9),
      'overlay with src/dst swap'),
  _BlendEntry('softLight', BlendMode.softLight, Color(0xFFF97316),
      'gentle dodge or burn'),
  _BlendEntry('difference', BlendMode.difference, Color(0xFF22C55E),
      '|src − dst|'),
  _BlendEntry('exclusion', BlendMode.exclusion, Color(0xFF06B6D4),
      'softer difference'),
  _BlendEntry(
      'hue', BlendMode.hue, Color(0xFFEC4899), 'src hue, dst sat/lum'),
  _BlendEntry('saturation', BlendMode.saturation, Color(0xFFEF4444),
      'src sat, dst hue/lum'),
  _BlendEntry('color', BlendMode.color, Color(0xFF8B5CF6),
      'src hue/sat, dst lum'),
  _BlendEntry('luminosity', BlendMode.luminosity, Color(0xFF1F2937),
      'src lum, dst hue/sat'),
  _BlendEntry('clear', BlendMode.clear, Color(0xFF000000), 'fully transparent'),
  _BlendEntry('src', BlendMode.src, Color(0xFFE94560), 'replace with src'),
  _BlendEntry('dst', BlendMode.dst, Color(0xFF000000), 'keep dst as-is'),
  _BlendEntry(
      'xor', BlendMode.xor, Color(0xFF0F3460), 'non-overlap regions'),
];

Widget _buildBlendModesGrid() {
  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < _kBlendEntries.length; i++) {
    tiles.add(_blendTile(_kBlendEntries[i]));
  }
  return _section(
    icon: Icons.gradient_rounded,
    title: 'Blend Modes Grid',
    subtitle: '${_kBlendEntries.length} modes · same source content',
    paragraph:
        'ColorFilter.mode(color, blendMode) composites a flat tint over each '
        'painted pixel. The tint becomes the "src" and the child the "dst" of '
        'a Porter-Duff blend. The tile below shows the same gradient + dots + '
        'sun icon under every mode — letting you compare destructive modes '
        '(srcIn, dstIn) against tonal modes (modulate, screen) and HSL modes '
        '(hue, saturation, color, luminosity).',
    tint: _cfHighlight,
    body: GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      childAspectRatio: 0.78,
      children: tiles,
    ),
  );
}

Widget _blendTile(_BlendEntry entry) {
  return Container(
    decoration: BoxDecoration(
      color: _cfSoft,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _cfDivider),
    ),
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(entry.tint, entry.mode),
              child: _miniSource(height: double.infinity),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          entry.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: _cfInk,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          entry.hint,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 9.5,
            color: _cfMuted,
            height: 1.15,
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// 3. Matrix transforms (≥5 matrices).
// ─────────────────────────────────────────────────────────────────────────────

// 5x4 color matrices: 20 doubles arranged row-major as RGBA channel mixers
// followed by an additive offset column.

const List<double> _kIdentityMatrix = <double>[
  1, 0, 0, 0, 0,
  0, 1, 0, 0, 0,
  0, 0, 1, 0, 0,
  0, 0, 0, 1, 0,
];

const List<double> _kGrayscaleMatrix = <double>[
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0.2126, 0.7152, 0.0722, 0, 0,
  0, 0, 0, 1, 0,
];

const List<double> _kSepiaMatrix = <double>[
  0.393, 0.769, 0.189, 0, 0,
  0.349, 0.686, 0.168, 0, 0,
  0.272, 0.534, 0.131, 0, 0,
  0, 0, 0, 1, 0,
];

const List<double> _kInvertMatrix = <double>[
  -1, 0, 0, 0, 255,
  0, -1, 0, 0, 255,
  0, 0, -1, 0, 255,
  0, 0, 0, 1, 0,
];

const List<double> _kHighSaturationMatrix = <double>[
  1.6, -0.3, -0.3, 0, 0,
  -0.3, 1.6, -0.3, 0, 0,
  -0.3, -0.3, 1.6, 0, 0,
  0, 0, 0, 1, 0,
];

const List<double> _kBrightnessMatrix = <double>[
  1, 0, 0, 0, 40,
  0, 1, 0, 0, 40,
  0, 0, 1, 0, 40,
  0, 0, 0, 1, 0,
];

const List<double> _kContrastMatrix = <double>[
  1.5, 0, 0, 0, -64,
  0, 1.5, 0, 0, -64,
  0, 0, 1.5, 0, -64,
  0, 0, 0, 1, 0,
];

const List<double> _kChannelSwapMatrix = <double>[
  // R = old B, G = old R, B = old G
  0, 0, 1, 0, 0,
  1, 0, 0, 0, 0,
  0, 1, 0, 0, 0,
  0, 0, 0, 1, 0,
];

const List<double> _kCoolToneMatrix = <double>[
  0.9, 0, 0, 0, -10,
  0, 1.0, 0, 0, 0,
  0, 0, 1.2, 0, 20,
  0, 0, 0, 1, 0,
];

const List<double> _kWarmToneMatrix = <double>[
  1.2, 0, 0, 0, 20,
  0, 1.0, 0, 0, 5,
  0, 0, 0.8, 0, -10,
  0, 0, 0, 1, 0,
];

class _MatrixEntry {
  final String name;
  final List<double> matrix;
  final String description;
  const _MatrixEntry(this.name, this.matrix, this.description);
}

const List<_MatrixEntry> _kMatrixEntries = <_MatrixEntry>[
  _MatrixEntry('Identity', _kIdentityMatrix,
      'Diagonal 1s — no change. Useful as a baseline.'),
  _MatrixEntry('Grayscale', _kGrayscaleMatrix,
      'Luminance weights 0.2126/0.7152/0.0722 produce perceptual gray.'),
  _MatrixEntry('Sepia', _kSepiaMatrix,
      'Classic warm-brown photographic tint, used in vintage looks.'),
  _MatrixEntry('Invert', _kInvertMatrix,
      'Negate channels and add 255 — produces a photographic negative.'),
  _MatrixEntry('High Saturation', _kHighSaturationMatrix,
      'Pull each channel away from the mean of the others to boost colors.'),
  _MatrixEntry('Brightness', _kBrightnessMatrix,
      'Add a constant offset per channel — every pixel becomes lighter.'),
  _MatrixEntry('Contrast', _kContrastMatrix,
      'Multiply by 1.5 then subtract 64 to push values away from mid-gray.'),
  _MatrixEntry('Channel Swap', _kChannelSwapMatrix,
      'Cycle R→G→B→R so reds become greens, greens become blues.'),
  _MatrixEntry('Cool Tone', _kCoolToneMatrix,
      'Reduce red, boost blue — produces a chilled cinematic look.'),
  _MatrixEntry('Warm Tone', _kWarmToneMatrix,
      'Boost red and slightly drop blue — sunset / golden-hour feel.'),
];

Widget _buildMatrixTransforms() {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < _kMatrixEntries.length; i++) {
    rows.add(_matrixRow(_kMatrixEntries[i]));
    if (i < _kMatrixEntries.length - 1) {
      rows.add(const Divider(height: 18, color: _cfDivider));
    }
  }
  return _section(
    icon: Icons.grid_4x4_rounded,
    title: 'Matrix Transforms',
    subtitle: '${_kMatrixEntries.length} channel-mixing matrices',
    paragraph:
        'ColorFilter.matrix accepts a 5×4 (20-value) matrix laid out row-major. '
        'Each row produces one output channel: out = Mr·R + Mg·G + Mb·B + Ma·A '
        '+ offset. With the offset column you can shift channels (brightness), '
        'with negative diagonals you can invert, and by mixing rows you can '
        'desaturate (grayscale) or recolor (sepia, channel swap).',
    tint: _cfAccent,
    body: Column(children: rows),
  );
}

Widget _matrixRow(_MatrixEntry entry) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 96,
        height: 96,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.10),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: ColorFiltered(
          colorFilter: ColorFilter.matrix(entry.matrix),
          child: _miniSource(height: double.infinity),
        ),
      ),
      const SizedBox(width: 14),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  entry.name,
                  style: const TextStyle(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: _cfInk,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: _cfHighlight.withOpacity(0.10),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    '5×4',
                    style: TextStyle(
                      fontSize: 10,
                      color: _cfHighlight,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              entry.description,
              style: const TextStyle(
                fontSize: 12.5,
                color: _cfMuted,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 8),
            _matrixGlyph(entry.matrix),
          ],
        ),
      ),
    ],
  );
}

Widget _matrixGlyph(List<double> matrix) {
  // Show the matrix as a small 4×5 grid of value pills.
  final List<Widget> rows = <Widget>[];
  for (int r = 0; r < 4; r++) {
    final List<Widget> cells = <Widget>[];
    for (int c = 0; c < 5; c++) {
      final double v = matrix[r * 5 + c];
      cells.add(_matrixCell(v));
      if (c < 4) cells.add(const SizedBox(width: 4));
    }
    rows.add(Row(children: cells));
    if (r < 3) rows.add(const SizedBox(height: 3));
  }
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: _cfSoft,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: _cfDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: rows,
    ),
  );
}

Widget _matrixCell(double v) {
  // Simple absolute-value to color heat scale; no math.* import needed.
  double mag = v < 0 ? -v : v;
  if (mag > 255) mag = 255;
  final double t = mag > 2 ? 1.0 : (mag / 2.0);
  final Color bg = v == 0
      ? _cfSurface
      : (v < 0
          ? Color.lerp(_cfSurface, _cfAccent, t.clamp(0.0, 1.0)) ?? _cfSurface
          : Color.lerp(_cfSurface, _cfHighlight, t.clamp(0.0, 1.0)) ??
              _cfSurface);
  final Color fg = v == 0 ? _cfMuted : Colors.white;
  return Container(
    width: 36,
    height: 18,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: _cfDivider, width: 0.5),
    ),
    child: Text(
      _formatMatrixValue(v),
      style: TextStyle(
        fontSize: 9,
        fontWeight: FontWeight.w600,
        color: fg,
      ),
    ),
  );
}

String _formatMatrixValue(double v) {
  if (v == 0) return '0';
  if (v == v.roundToDouble()) return v.toStringAsFixed(0);
  return v.toStringAsFixed(2);
}

// ─────────────────────────────────────────────────────────────────────────────
// 4. Gamma corrections.
// ─────────────────────────────────────────────────────────────────────────────

Widget _buildGammaCorrection() {
  return _section(
    icon: Icons.lightbulb_outline_rounded,
    title: 'Gamma Correction',
    subtitle: 'linearToSrgbGamma · srgbToLinearGamma',
    paragraph:
        'Two specialized ColorFilter constructors encode and decode the sRGB '
        'gamma curve. linearToSrgbGamma assumes the child paints in linear '
        'light and converts to display-space sRGB; srgbToLinearGamma does the '
        'inverse. Compositing in linear space gives physically accurate '
        'blending — particularly visible in soft mid-tones and translucent '
        'overlays.',
    tint: _cfWarn,
    body: Column(
      children: [
        Row(
          children: [
            Expanded(child: _gammaTile('source (sRGB)', _sourceContent(height: 110))),
            const SizedBox(width: 10),
            Expanded(
              child: _gammaTile(
                'linearToSrgbGamma',
                ColorFiltered(
                  colorFilter: const ColorFilter.linearToSrgbGamma(),
                  child: _sourceContent(height: 110),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _gammaTile(
                'srgbToLinearGamma',
                ColorFiltered(
                  colorFilter: const ColorFilter.srgbToLinearGamma(),
                  child: _sourceContent(height: 110),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _cfWarn.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _cfWarn.withOpacity(0.4)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.info_outline_rounded,
                  color: _cfWarn, size: 18),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Use srgbToLinearGamma → composite → linearToSrgbGamma when '
                  'physically-accurate blending is required (e.g. lens flares, '
                  'translucent shaders). The two filters are inverses; chaining '
                  'them yields the original input.',
                  style: TextStyle(
                    fontSize: 12.5,
                    height: 1.45,
                    color: _cfInk,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _gammaTile(String label, Widget child) {
  return Container(
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: _cfSoft,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _cfDivider),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: child,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
            color: _cfInk,
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// 5. Before/after comparison (≥5 pairs).
// ─────────────────────────────────────────────────────────────────────────────

class _PairEntry {
  final String label;
  final ColorFilter filter;
  final String tagline;
  const _PairEntry(this.label, this.filter, this.tagline);
}

const List<_PairEntry> _kPairs = <_PairEntry>[
  _PairEntry('srcIn tint', ColorFilter.mode(_cfHighlight, BlendMode.srcIn),
      'Replace child colors with a flat brand tint while preserving the alpha shape.'),
  _PairEntry('modulate red', ColorFilter.mode(_srcRed, BlendMode.modulate),
      'Per-channel multiplication darkens and tints toward red.'),
  _PairEntry('grayscale', ColorFilter.matrix(_kGrayscaleMatrix),
      'Drop saturation entirely — useful for "disabled" or "draft" states.'),
  _PairEntry('sepia', ColorFilter.matrix(_kSepiaMatrix),
      'Aged photograph effect — warm browns dominate the tone curve.'),
  _PairEntry('invert', ColorFilter.matrix(_kInvertMatrix),
      'Photographic negative — full channel flip with a +255 offset.'),
  _PairEntry('warm tone', ColorFilter.matrix(_kWarmToneMatrix),
      'Boost reds, drop blues — golden hour feel.'),
];

Widget _buildBeforeAfterComparison() {
  final List<Widget> rows = <Widget>[];
  for (int i = 0; i < _kPairs.length; i++) {
    rows.add(_pairRow(_kPairs[i]));
    if (i < _kPairs.length - 1) {
      rows.add(const SizedBox(height: 14));
    }
  }
  return _section(
    icon: Icons.compare_rounded,
    title: 'Before / After Comparison',
    subtitle: '${_kPairs.length} side-by-side pairs',
    paragraph:
        'A single source rendered raw on the left and through ColorFiltered on '
        'the right. The tagline beneath each pair explains the design intent, '
        'making it easy to map a visual style ("disabled badge", "draft thumb", '
        '"golden hero") to the matching ColorFilter recipe.',
    tint: _cfOk,
    body: Column(children: rows),
  );
}

Widget _pairRow(_PairEntry pair) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _cfSoft,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _cfDivider),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _miniSource(height: 76),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'before',
                    style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: _cfMuted,
                        letterSpacing: 0.5),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: _cfAccent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: _cfAccent.withOpacity(0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.arrow_forward_rounded,
                  color: Colors.white, size: 16),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: ColorFiltered(
                      colorFilter: pair.filter,
                      child: _miniSource(height: 76),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pair.label,
                    style: const TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: _cfHighlight,
                        letterSpacing: 0.5),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          pair.tagline,
          style: const TextStyle(
            fontSize: 12.5,
            color: _cfInk,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// 6. Anatomy diagram.
// ─────────────────────────────────────────────────────────────────────────────

Widget _buildAnatomyDiagram() {
  return _section(
    icon: Icons.account_tree_rounded,
    title: 'Anatomy of ColorFiltered',
    subtitle: 'how the widget composes its child',
    paragraph:
        'ColorFiltered is a SingleChildRenderObjectWidget. It allocates a '
        'RenderObject that pushes a ColorFilterLayer onto the engine layer '
        'tree, then defers child painting underneath. The layer is reused '
        'between frames — the filter object itself is opaque to the engine '
        'and its parameters are baked at construction time.',
    tint: _cfHighlight,
    body: Column(
      children: [
        _anatomyRow(Icons.widgets_outlined, 'ColorFiltered',
            'Public widget. Holds colorFilter + child fields.'),
        _anatomyArrow(),
        _anatomyRow(Icons.layers_outlined, 'RenderColorFilter',
            'RenderProxyBox subclass. Implements paint() by pushing a layer.'),
        _anatomyArrow(),
        _anatomyRow(Icons.filter_b_and_w_rounded, 'ColorFilterLayer',
            'Engine layer carrying the filter. Survives across frames.'),
        _anatomyArrow(),
        _anatomyRow(Icons.brush_outlined, 'dart:ui ColorFilter',
            'Native Skia object. Kind: mode, matrix, linearToSrgb, srgbToLinear.'),
        const SizedBox(height: 12),
        _anatomyLegend(),
      ],
    ),
  );
}

Widget _anatomyRow(IconData icon, String name, String desc) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _cfSoft,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _cfDivider),
      boxShadow: [
        BoxShadow(
          color: _cfHighlight.withOpacity(0.05),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: _cfHighlight.withOpacity(0.15),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: _cfHighlight, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _cfInk,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                desc,
                style: const TextStyle(
                  fontSize: 12,
                  color: _cfMuted,
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

Widget _anatomyArrow() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Center(
      child: Icon(Icons.south_rounded, color: _cfMuted, size: 18),
    ),
  );
}

Widget _anatomyLegend() {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: _cfHighlight.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: _cfHighlight.withOpacity(0.3)),
    ),
    child: const Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.tips_and_updates_outlined,
            color: _cfHighlight, size: 18),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            'The ColorFilter object is const-friendly. Constructing it inside '
            'build() is cheap, but extracting it to a top-level const lets '
            'Flutter treat it as a single shared instance and skip rebuilds.',
            style: TextStyle(
                fontSize: 12, color: _cfHighlight, height: 1.45),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// 7. Advanced recipes.
// ─────────────────────────────────────────────────────────────────────────────

class _RecipeEntry {
  final String name;
  final String purpose;
  final ColorFilter filter;
  final Color accent;
  const _RecipeEntry(this.name, this.purpose, this.filter, this.accent);
}

const List<_RecipeEntry> _kRecipes = <_RecipeEntry>[
  _RecipeEntry(
    'Disabled state',
    'Desaturate any subtree to communicate "not interactable".',
    ColorFilter.matrix(_kGrayscaleMatrix),
    _cfMuted,
  ),
  _RecipeEntry(
    'Brand tint',
    'Lock product imagery into a flat brand color (silhouette style).',
    ColorFilter.mode(_cfHighlight, BlendMode.srcIn),
    _cfHighlight,
  ),
  _RecipeEntry(
    'Vintage poster',
    'Apply a sepia matrix for a warm, archival aesthetic.',
    ColorFilter.matrix(_kSepiaMatrix),
    Color(0xFF8B5A2B),
  ),
  _RecipeEntry(
    'Dark-mode invert',
    'Flip a light-mode asset into dark mode without re-exporting.',
    ColorFilter.matrix(_kInvertMatrix),
    _cfInk,
  ),
  _RecipeEntry(
    'Color pop',
    'Boost saturation to make heroes leap off the page.',
    ColorFilter.matrix(_kHighSaturationMatrix),
    _srcMagenta,
  ),
  _RecipeEntry(
    'Cool cinematic',
    'Cool-tone matrix evokes night, technology, calm.',
    ColorFilter.matrix(_kCoolToneMatrix),
    _srcBlue,
  ),
  _RecipeEntry(
    'Warm cinematic',
    'Warm-tone matrix for sunset, romance, food photography.',
    ColorFilter.matrix(_kWarmToneMatrix),
    _cfWarn,
  ),
  _RecipeEntry(
    'High contrast',
    'Push values away from mid-gray for accessibility or stylization.',
    ColorFilter.matrix(_kContrastMatrix),
    _cfAccent,
  ),
];

Widget _buildAdvancedRecipes() {
  final List<Widget> tiles = <Widget>[];
  for (int i = 0; i < _kRecipes.length; i++) {
    tiles.add(_recipeCard(_kRecipes[i]));
  }
  return _section(
    icon: Icons.auto_awesome_outlined,
    title: 'Advanced Recipes',
    subtitle: '${_kRecipes.length} ready-to-paste filter presets',
    paragraph:
        'Common UX problems mapped to specific ColorFilter constructions. '
        'Each recipe wraps the same source content; the badge color encodes '
        'the recipe family (mode-based vs matrix-based) so the eye can sort '
        'them at a glance.',
    tint: _srcMagenta,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: tiles,
    ),
  );
}

Widget _recipeCard(_RecipeEntry recipe) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _cfSurface,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: _cfDivider),
      boxShadow: [
        BoxShadow(
          color: recipe.accent.withOpacity(0.12),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: ColorFiltered(
            colorFilter: recipe.filter,
            child: _miniSource(height: 72),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: recipe.accent,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    recipe.name,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _cfInk,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                recipe.purpose,
                style: const TextStyle(
                  fontSize: 12.5,
                  color: _cfMuted,
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

// ─────────────────────────────────────────────────────────────────────────────
// 8. Performance notes.
// ─────────────────────────────────────────────────────────────────────────────

Widget _buildPerformanceNotes() {
  return _section(
    icon: Icons.speed_rounded,
    title: 'Performance Notes',
    subtitle: 'when to reach for ColorFiltered (and when not to)',
    paragraph:
        'ColorFiltered runs on the GPU through Skia. Mode filters are nearly '
        'free (one shader uniform). Matrix filters cost slightly more (a '
        '4×5 multiply per pixel). Gamma filters require a lookup-table pass. '
        'The expensive part is layer creation — every ColorFiltered allocates '
        'a layer per frame. Wrap large subtrees once, not many small leaves.',
    tint: _cfWarn,
    body: Column(
      children: [
        _perfRow(
          Icons.check_circle_outline_rounded,
          _cfOk,
          'Cheap',
          'ColorFilter.mode with srcIn / srcOver / modulate. Single uniform.',
        ),
        const SizedBox(height: 8),
        _perfRow(
          Icons.bolt_rounded,
          _cfHighlight,
          'Moderate',
          'ColorFilter.matrix — a 5×4 multiply per pixel inside the fragment shader.',
        ),
        const SizedBox(height: 8),
        _perfRow(
          Icons.warning_amber_rounded,
          _cfWarn,
          'Heavier',
          'Gamma filters use a lookup-table pass; safe for hero images, costly per leaf.',
        ),
        const SizedBox(height: 8),
        _perfRow(
          Icons.close_rounded,
          _cfAccent,
          'Avoid',
          'Wrapping every list cell in its own ColorFiltered. Wrap the list once.',
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _cfHighlight.withOpacity(0.08),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _cfHighlight.withOpacity(0.3)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.psychology_outlined,
                  color: _cfHighlight, size: 20),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Layer reuse is automatic only when the ColorFilter object is '
                  'identical between frames. Const-construct your filters at '
                  'top level so Flutter can intern them — otherwise the layer '
                  'is rebuilt on every rebuild of the surrounding widget.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: _cfHighlight,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _perfRow(IconData icon, Color tint, String tag, String text) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: tint.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tint.withOpacity(0.35)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: tint, size: 20),
        const SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            tag,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 12.5,
              color: _cfInk,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// 9. Usage guide.
// ─────────────────────────────────────────────────────────────────────────────

Widget _buildUsageGuide() {
  return _section(
    icon: Icons.menu_book_rounded,
    title: 'Usage Guide',
    subtitle: 'API reference at a glance',
    paragraph:
        'A short cookbook: how to construct each ColorFilter, where to place '
        'the ColorFiltered widget in the tree, and how to combine it with '
        'siblings (Opacity, ShaderMask, BackdropFilter) to produce richer '
        'effects without re-rasterizing the source.',
    tint: _cfHighlight,
    body: Column(
      children: [
        _codeBlock(
          'Mode filter',
          "ColorFiltered(\n"
          "  colorFilter: const ColorFilter.mode(\n"
          "    Color(0xFF0F3460),\n"
          "    BlendMode.srcIn,\n"
          "  ),\n"
          "  child: Image.network(url),\n"
          ");",
        ),
        const SizedBox(height: 10),
        _codeBlock(
          'Matrix filter',
          "const grayscale = <double>[\n"
          "  0.2126, 0.7152, 0.0722, 0, 0,\n"
          "  0.2126, 0.7152, 0.0722, 0, 0,\n"
          "  0.2126, 0.7152, 0.0722, 0, 0,\n"
          "  0,      0,      0,      1, 0,\n"
          "];\n"
          "ColorFiltered(\n"
          "  colorFilter: const ColorFilter.matrix(grayscale),\n"
          "  child: child,\n"
          ");",
        ),
        const SizedBox(height: 10),
        _codeBlock(
          'Gamma filters',
          "ColorFiltered(\n"
          "  colorFilter: const ColorFilter.srgbToLinearGamma(),\n"
          "  child: ColorFiltered(\n"
          "    colorFilter: const ColorFilter.linearToSrgbGamma(),\n"
          "    child: child,\n"
          "  ),\n"
          ");",
        ),
        const SizedBox(height: 14),
        _doDontList(),
      ],
    ),
  );
}

Widget _codeBlock(String label, String code) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _cfInk,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: _cfInk.withOpacity(0.30),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: _cfAccent,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: _cfWarn,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: _cfOk,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          code,
          style: const TextStyle(
            color: Color(0xFFE6E6F0),
            fontFamily: 'monospace',
            fontSize: 11.5,
            height: 1.5,
          ),
        ),
      ],
    ),
  );
}

Widget _doDontList() {
  return Row(
    children: [
      Expanded(
        child: _doDontColumn(
          true,
          'Do',
          <String>[
            'Const-construct ColorFilter at top level.',
            'Wrap the largest possible subtree with one filter.',
            'Use srcIn for tinting opaque silhouettes.',
            'Pair gamma filters when blending in linear light.',
          ],
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: _doDontColumn(
          false,
          "Don't",
          <String>[
            'Allocate ColorFilter inside per-frame builders.',
            'Apply ColorFiltered to every list cell.',
            'Combine BlendMode.clear except inside SaveLayer().',
            'Expect matrix arithmetic to clamp before writeback.',
          ],
        ),
      ),
    ],
  );
}

Widget _doDontColumn(bool positive, String title, List<String> entries) {
  final Color tint = positive ? _cfOk : _cfAccent;
  final IconData icon =
      positive ? Icons.check_circle_outline_rounded : Icons.cancel_outlined;
  final List<Widget> items = <Widget>[];
  for (int i = 0; i < entries.length; i++) {
    items.add(Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 5),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: tint,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              entries[i],
              style: const TextStyle(
                fontSize: 12.5,
                color: _cfInk,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ));
  }
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: tint.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: tint.withOpacity(0.4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: tint, size: 18),
            const SizedBox(width: 6),
            Text(
              title,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w800,
                color: tint,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items,
        ),
      ],
    ),
  );
}

// ─────────────────────────────────────────────────────────────────────────────
// Footer.
// ─────────────────────────────────────────────────────────────────────────────

Widget _buildFooter() {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(14),
      gradient: const LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [_cfInk, _cfHighlight],
      ),
      boxShadow: [
        BoxShadow(
          color: _cfInk.withOpacity(0.30),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        const Icon(Icons.color_lens_outlined,
            color: Colors.white, size: 22),
        const SizedBox(width: 10),
        const Expanded(
          child: Text(
            'ColorFiltered • dart:ui ColorFilter • mode · matrix · gamma',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: _cfAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Text(
            'd4rt deep demo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.4,
            ),
          ),
        ),
      ],
    ),
  );
}
