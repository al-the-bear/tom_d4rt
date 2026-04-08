// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ============================================================================
// SLIVER GRID GEOMETRY — Deep Demo
// ============================================================================
//
// SliverGridGeometry is a small, immutable data class in Flutter's rendering
// layer that describes the precise layout metrics for one tile inside a
// sliver grid.  It carries four properties:
//
//   • scrollOffset      – where the tile begins along the scroll axis (px)
//   • crossAxisOffset   – where the tile begins on the cross axis (px)
//   • mainAxisExtent    – the tile's size along the scroll axis (px)
//   • crossAxisExtent   – the tile's size along the cross axis (px)
//
// From these four values two derived helpers are computed:
//
//   • trailingScrollOffset  = scrollOffset + mainAxisExtent
//   • getBoxConstraints()   = tight BoxConstraints(w, h)  (orientation-aware)
//
// SliverGridGeometry objects are produced by SliverGridLayout implementations
// (e.g. SliverGridRegularTileLayout) and consumed by RenderSliverGrid to
// position each child.
//
// This demo builds visual cards and diagrams that make every property
// tangible, then shows how uniform vs. non-uniform geometries differ,
// and closes with realistic grid layouts driven by SliverGridGeometry data.
//
// Color theme : Rust (#BF5722) / Sand (#FFE0B2)
// Helper prefix: _gg
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _ggRust = Color(0xFFBF5722);
const Color _ggSand = Color(0xFFFFE0B2);
const Color _ggDarkRust = Color(0xFF8D3E17);
const Color _ggLightSand = Color(0xFFFFF3E0);
const Color _ggCharcoal = Color(0xFF3E2723);
const Color _ggTeal = Color(0xFF00897B);
const Color _ggSlate = Color(0xFF546E7A);
const Color _ggIndigo = Color(0xFF3949AB);
const Color _ggAmber = Color(0xFFFFA000);
const Color _ggCoral = Color(0xFFEF5350);
const Color _ggForest = Color(0xFF2E7D32);
const Color _ggPlum = Color(0xFF7B1FA2);
const Color _ggSky = Color(0xFF039BE5);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

Widget _ggSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_ggRust, _ggDarkRust],
      ),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        if (subtitle != null)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              subtitle,
              style: const TextStyle(color: Color(0xCCFFFFFF), fontSize: 13),
            ),
          ),
      ],
    ),
  );
}

Widget _ggCaption(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
    child: Text(
      text,
      style: const TextStyle(
        color: _ggCharcoal,
        fontSize: 13,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

Widget _ggParagraph(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: Text(
      text,
      style: const TextStyle(color: _ggCharcoal, fontSize: 14, height: 1.5),
    ),
  );
}

Widget _ggLabelValue(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 180,
          child: Text(
            label,
            style: const TextStyle(
              color: _ggSlate,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? _ggRust,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _ggInfoCard(String title, String body, IconData icon, Color accent) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withValues(alpha: 0.4)),
      boxShadow: [
        BoxShadow(
          color: accent.withValues(alpha: 0.10),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: accent, size: 28),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: accent,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                body,
                style: const TextStyle(
                  color: _ggCharcoal,
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _ggDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    height: 1,
    color: _ggSand,
  );
}

/// Simulates a positioned tile with labeled geometry data.
Widget _ggTileBox({
  required double width,
  required double height,
  required String label,
  Color? color,
  Color? textColor,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: color ?? _ggRust.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color ?? _ggRust, width: 1.5),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor ?? _ggDarkRust,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

/// A small arrow/dimension annotation.
Widget _ggDimensionLabel(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: _ggAmber.withValues(alpha: 0.25),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      text,
      style: const TextStyle(
        color: _ggCharcoal,
        fontSize: 10,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// ============================================================================
// ENTRY POINT
// ============================================================================

dynamic build(BuildContext context) {
  // Print geometry data to console for script verification.
  const geo = SliverGridGeometry(
    scrollOffset: 0.0,
    crossAxisOffset: 0.0,
    mainAxisExtent: 120.0,
    crossAxisExtent: 180.0,
  );
  print('=== SliverGridGeometry Deep Demo ===');
  print('scrollOffset     : ${geo.scrollOffset}');
  print('crossAxisOffset  : ${geo.crossAxisOffset}');
  print('mainAxisExtent   : ${geo.mainAxisExtent}');
  print('crossAxisExtent  : ${geo.crossAxisExtent}');
  print('trailingScroll   : ${geo.trailingScrollOffset}');

  const geo2 = SliverGridGeometry(
    scrollOffset: 120.0,
    crossAxisOffset: 180.0,
    mainAxisExtent: 80.0,
    crossAxisExtent: 140.0,
  );
  print('--- second geometry ---');
  print('scrollOffset     : ${geo2.scrollOffset}');
  print('crossAxisOffset  : ${geo2.crossAxisOffset}');
  print('mainAxisExtent   : ${geo2.mainAxisExtent}');
  print('crossAxisExtent  : ${geo2.crossAxisExtent}');
  print('trailingScroll   : ${geo2.trailingScrollOffset}');

  return SingleChildScrollView(
    child: Container(
      color: _ggLightSand,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ================================================================
          // SECTION 1 — Introduction
          // ================================================================
          _ggSectionHeader(
            'SliverGridGeometry',
            subtitle: 'Immutable data class describing one grid-tile\'s layout',
          ),
          const SizedBox(height: 10),
          _ggParagraph(
            'SliverGridGeometry is a lightweight, immutable value object that '
            'encapsulates exactly four numbers describing how a single tile '
            'should be positioned and sized inside a sliver grid.  It is the '
            'primary communication mechanism between SliverGridLayout (the '
            'layout strategy) and RenderSliverGrid (the render object that '
            'paints children).',
          ),
          _ggParagraph(
            'Every time a SliverGrid needs to lay out its children, it asks '
            'its SliverGridLayout for a SliverGridGeometry per child index.  '
            'The geometry tells the renderer exactly where and how large each '
            'tile should be.',
          ),
          _ggInfoCard(
            'Data class — not a widget',
            'SliverGridGeometry has no build method and is never placed in a '
            'widget tree.  It is purely a data carrier.  This demo uses '
            'visual cards to show what the four properties mean.',
            Icons.data_object,
            _ggRust,
          ),
          _ggDivider(),

          // ================================================================
          // SECTION 2 — The four properties at a glance
          // ================================================================
          _ggSectionHeader(
            '1 · The Four Properties',
            subtitle: 'scrollOffset, crossAxisOffset, mainAxisExtent, crossAxisExtent',
          ),
          const SizedBox(height: 8),
          _ggParagraph(
            'A SliverGridGeometry stores four doubles.  Together they form a '
            'rectangle in the sliver coordinate system:',
          ),
          _ggLabelValue('scrollOffset', '${geo.scrollOffset} px',
              valueColor: _ggTeal),
          _ggLabelValue('crossAxisOffset', '${geo.crossAxisOffset} px',
              valueColor: _ggIndigo),
          _ggLabelValue('mainAxisExtent', '${geo.mainAxisExtent} px',
              valueColor: _ggCoral),
          _ggLabelValue('crossAxisExtent', '${geo.crossAxisExtent} px',
              valueColor: _ggForest),
          const SizedBox(height: 10),
          // Visual: a grid area with the tile rectangle highlighted
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 220,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: _ggSlate.withValues(alpha: 0.3)),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Stack(
              children: [
                // Axis labels
                const Positioned(
                  left: 8,
                  top: 8,
                  child: Text('Origin (0,0)',
                      style: TextStyle(fontSize: 10, color: _ggSlate)),
                ),
                const Positioned(
                  right: 8,
                  top: 8,
                  child: Text('→ cross axis',
                      style: TextStyle(fontSize: 10, color: _ggIndigo)),
                ),
                const Positioned(
                  left: 8,
                  bottom: 8,
                  child: Text('↓ scroll axis',
                      style: TextStyle(fontSize: 10, color: _ggTeal)),
                ),
                // The tile rectangle
                Positioned(
                  left: 30,
                  top: 40,
                  child: Container(
                    width: 140,
                    height: 90,
                    decoration: BoxDecoration(
                      color: _ggRust.withValues(alpha: 0.18),
                      border: Border.all(color: _ggRust, width: 2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Tile',
                            style: TextStyle(
                                color: _ggDarkRust,
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                        Text('crossAxisExtent × mainAxisExtent',
                            style: TextStyle(color: _ggCharcoal, fontSize: 9)),
                      ],
                    ),
                  ),
                ),
                // Dimension annotations
                Positioned(
                  left: 70,
                  top: 135,
                  child: _ggDimensionLabel('mainAxisExtent: 120px'),
                ),
                Positioned(
                  left: 175,
                  top: 70,
                  child: _ggDimensionLabel('crossAxisExtent: 180px'),
                ),
              ],
            ),
          ),
          _ggCaption(
            'The tile rectangle is placed at (scrollOffset, crossAxisOffset) '
            'and sized mainAxisExtent × crossAxisExtent.',
          ),
          _ggDivider(),

          // ================================================================
          // SECTION 3 — scrollOffset explained
          // ================================================================
          _ggSectionHeader(
            '2 · scrollOffset — Position Along Scroll Axis',
            subtitle: 'Where the tile starts in the scrollable direction',
          ),
          const SizedBox(height: 8),
          _ggParagraph(
            'scrollOffset is typically the pixel distance from the top of '
            'the sliver scroll extent to the leading edge of this tile.  '
            'In a vertical grid, row 0 has scrollOffset ≈ 0, row 1 has '
            'scrollOffset ≈ tileHeight + spacing, and so on.',
          ),
          // Visual: three rows of tiles with different scrollOffsets
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _ggTeal.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Vertical scroll — three rows',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _ggTeal)),
                const SizedBox(height: 10),
                // Row 0: scrollOffset = 0
                Row(
                  children: [
                    Container(
                      width: 80,
                      padding: const EdgeInsets.only(right: 8),
                      child: const Text('scroll: 0',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _ggTeal)),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _ggTileBox(width: 80, height: 44, label: 'A0'),
                          const SizedBox(width: 6),
                          _ggTileBox(width: 80, height: 44, label: 'A1'),
                          const SizedBox(width: 6),
                          _ggTileBox(width: 80, height: 44, label: 'A2'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Row 1: scrollOffset = 50
                Row(
                  children: [
                    Container(
                      width: 80,
                      padding: const EdgeInsets.only(right: 8),
                      child: const Text('scroll: 50',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _ggTeal)),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _ggTileBox(width: 80, height: 44, label: 'B0'),
                          const SizedBox(width: 6),
                          _ggTileBox(width: 80, height: 44, label: 'B1'),
                          const SizedBox(width: 6),
                          _ggTileBox(width: 80, height: 44, label: 'B2'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Row 2: scrollOffset = 100
                Row(
                  children: [
                    Container(
                      width: 80,
                      padding: const EdgeInsets.only(right: 8),
                      child: const Text('scroll: 100',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _ggTeal)),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          _ggTileBox(width: 80, height: 44, label: 'C0'),
                          const SizedBox(width: 6),
                          _ggTileBox(width: 80, height: 44, label: 'C1'),
                          const SizedBox(width: 6),
                          _ggTileBox(width: 80, height: 44, label: 'C2'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _ggCaption(
            'Each row scrollOffset increases by mainAxisExtent + spacing.  '
            'Row 0 starts at 0, Row 1 at 50, Row 2 at 100.',
          ),
          _ggDivider(),

          // ================================================================
          // SECTION 4 — crossAxisOffset explained
          // ================================================================
          _ggSectionHeader(
            '3 · crossAxisOffset — Position Across the Grid',
            subtitle: 'Horizontal position (in vertical scrolling)',
          ),
          const SizedBox(height: 8),
          _ggParagraph(
            'crossAxisOffset determines where a tile starts on the axis '
            'perpendicular to scrolling.  In a 3-column vertical grid, '
            'column 0 has crossAxisOffset ≈ 0, column 1 ≈ tileWidth + '
            'spacing, column 2 ≈ 2 × (tileWidth + spacing).',
          ),
          // Visual: a single row with cross-axis offsets labeled
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _ggIndigo.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Cross-axis offsets in a 3-column grid',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _ggIndigo)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          _ggTileBox(
                            width: 76,
                            height: 50,
                            label: 'cross: 0',
                            color: _ggIndigo.withValues(alpha: 0.2),
                            textColor: _ggIndigo,
                          ),
                          const SizedBox(height: 4),
                          const Text('Col 0',
                              style: TextStyle(
                                  fontSize: 10, color: _ggIndigo)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        children: [
                          _ggTileBox(
                            width: 76,
                            height: 50,
                            label: 'cross: 82',
                            color: _ggIndigo.withValues(alpha: 0.35),
                            textColor: _ggIndigo,
                          ),
                          const SizedBox(height: 4),
                          const Text('Col 1',
                              style: TextStyle(
                                  fontSize: 10, color: _ggIndigo)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        children: [
                          _ggTileBox(
                            width: 76,
                            height: 50,
                            label: 'cross: 164',
                            color: _ggIndigo.withValues(alpha: 0.5),
                            textColor: Colors.white,
                          ),
                          const SizedBox(height: 4),
                          const Text('Col 2',
                              style: TextStyle(
                                  fontSize: 10, color: _ggIndigo)),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  '→ cross axis direction',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: _ggSlate),
                ),
              ],
            ),
          ),
          _ggCaption(
            'crossAxisOffset = column × (crossAxisExtent + crossAxisSpacing).',
          ),
          _ggDivider(),

          // ================================================================
          // SECTION 5 — mainAxisExtent vs crossAxisExtent
          // ================================================================
          _ggSectionHeader(
            '4 · Extents — Tile Dimensions',
            subtitle: 'mainAxisExtent and crossAxisExtent define the tile size',
          ),
          const SizedBox(height: 8),
          _ggParagraph(
            'mainAxisExtent is the tile height (in vertical scrolling) or '
            'width (in horizontal scrolling).  crossAxisExtent is the '
            'complementary dimension.  In a regular grid every tile has '
            'identical extents; in a staggered grid they may vary.',
          ),
          // Visual: side-by-side comparison of tall vs wide tiles
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _ggCoral.withValues(alpha: 0.3)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tall tile
                Expanded(
                  child: Column(
                    children: [
                      const Text('Tall tile',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _ggCoral)),
                      const SizedBox(height: 6),
                      _ggTileBox(
                        width: 60,
                        height: 110,
                        label: '60 × 110\nmain=110\ncross=60',
                        color: _ggCoral.withValues(alpha: 0.15),
                        textColor: _ggCoral,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Wide tile
                Expanded(
                  child: Column(
                    children: [
                      const Text('Wide tile',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _ggForest)),
                      const SizedBox(height: 6),
                      _ggTileBox(
                        width: 120,
                        height: 55,
                        label: '120 × 55\nmain=55\ncross=120',
                        color: _ggForest.withValues(alpha: 0.15),
                        textColor: _ggForest,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Square tile
                Expanded(
                  child: Column(
                    children: [
                      const Text('Square tile',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _ggPlum)),
                      const SizedBox(height: 6),
                      _ggTileBox(
                        width: 80,
                        height: 80,
                        label: '80 × 80\nmain=80\ncross=80',
                        color: _ggPlum.withValues(alpha: 0.15),
                        textColor: _ggPlum,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          _ggCaption(
            'The same SliverGridGeometry structure describes tall, wide, '
            'or square tiles — only the extent values differ.',
          ),
          _ggDivider(),

          // ================================================================
          // SECTION 6 — trailingScrollOffset
          // ================================================================
          _ggSectionHeader(
            '5 · trailingScrollOffset',
            subtitle: 'Computed: scrollOffset + mainAxisExtent',
          ),
          const SizedBox(height: 8),
          _ggParagraph(
            'trailingScrollOffset is a convenience getter that returns the '
            'scroll position of the far edge of the tile.  It is used by '
            'RenderSliverGrid to know how far scroll space a row of tiles '
            'consumes and to decide when tiles scroll out of view.',
          ),
          _ggLabelValue(
            'geo1.trailingScrollOffset',
            '${geo.scrollOffset} + ${geo.mainAxisExtent} = ${geo.trailingScrollOffset}',
            valueColor: _ggTeal,
          ),
          _ggLabelValue(
            'geo2.trailingScrollOffset',
            '${geo2.scrollOffset} + ${geo2.mainAxisExtent} = ${geo2.trailingScrollOffset}',
            valueColor: _ggIndigo,
          ),
          const SizedBox(height: 8),
          // Visual: two tiles stacked showing trailing edge
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 180,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _ggSlate.withValues(alpha: 0.3)),
            ),
            child: Stack(
              children: [
                // Scroll axis ruler
                Positioned(
                  left: 10,
                  top: 10,
                  bottom: 10,
                  child: Container(
                    width: 2,
                    color: _ggSlate.withValues(alpha: 0.3),
                  ),
                ),
                // Tile A: scrollOffset=0, mainAxisExtent=60
                Positioned(
                  left: 30,
                  top: 10,
                  child: Container(
                    width: 120,
                    height: 55,
                    decoration: BoxDecoration(
                      color: _ggTeal.withValues(alpha: 0.15),
                      border: Border.all(color: _ggTeal, width: 1.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Tile A\nscroll: 0→60',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _ggTeal)),
                  ),
                ),
                // Trailing edge marker A
                Positioned(
                  left: 155,
                  top: 32,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: _ggTeal.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Text('trailing: 60',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: _ggTeal)),
                  ),
                ),
                // Tile B: scrollOffset=65, mainAxisExtent=80
                Positioned(
                  left: 30,
                  top: 75,
                  child: Container(
                    width: 120,
                    height: 70,
                    decoration: BoxDecoration(
                      color: _ggIndigo.withValues(alpha: 0.15),
                      border: Border.all(color: _ggIndigo, width: 1.5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: const Text('Tile B\nscroll: 65→145',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: _ggIndigo)),
                  ),
                ),
                // Trailing edge marker B
                Positioned(
                  left: 155,
                  top: 98,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                    decoration: BoxDecoration(
                      color: _ggIndigo.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const Text('trailing: 145',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: _ggIndigo)),
                  ),
                ),
                // Spacing annotation
                Positioned(
                  left: 260,
                  top: 55,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: _ggAmber.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text('5px spacing',
                        style: TextStyle(
                            fontSize: 9,
                            color: _ggCharcoal,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ],
            ),
          ),
          _ggCaption(
            'trailingScrollOffset marks the far edge.  The next row starts '
            'at trailing + spacing.',
          ),
          _ggDivider(),

          // ================================================================
          // SECTION 7 — getBoxConstraints()
          // ================================================================
          _ggSectionHeader(
            '6 · getBoxConstraints()',
            subtitle: 'Converts geometry to tight BoxConstraints',
          ),
          const SizedBox(height: 8),
          _ggParagraph(
            'getBoxConstraints(SliverConstraints) converts the geometry into '
            'tight BoxConstraints.  For a vertical grid, width = crossAxisExtent '
            'and height = mainAxisExtent.  For a horizontal grid, the mapping '
            'is swapped.  The child is then laid out with these constraints.',
          ),
          // Show the mapping visually
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _ggSky.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Text('Axis-dependent mapping',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: _ggSky)),
                const SizedBox(height: 12),
                // Vertical grid row
                Row(
                  children: [
                    Container(
                      width: 110,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _ggSky.withValues(alpha: 0.12),
                        border: Border.all(color: _ggSky),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Vertical grid',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: _ggSky)),
                          Text('width = cross\nheight = main',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 9, color: _ggSlate)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward, size: 16, color: _ggSlate),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: _ggForest.withValues(alpha: 0.10),
                          border: Border.all(color: _ggForest),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'BoxConstraints.tightFor(\n'
                          '  width: 180, height: 120)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10, color: _ggForest),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Horizontal grid row
                Row(
                  children: [
                    Container(
                      width: 110,
                      height: 60,
                      decoration: BoxDecoration(
                        color: _ggPlum.withValues(alpha: 0.12),
                        border: Border.all(color: _ggPlum),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Horizontal grid',
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: _ggPlum)),
                          Text('width = main\nheight = cross',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 9, color: _ggSlate)),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.arrow_forward, size: 16, color: _ggSlate),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: _ggAmber.withValues(alpha: 0.10),
                          border: Border.all(color: _ggAmber),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'BoxConstraints.tightFor(\n'
                          '  width: 120, height: 180)',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10, color: _ggAmber),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _ggCaption(
            'The swap ensures that "main" always maps to the scroll direction '
            'regardless of axis orientation.',
          ),
          _ggDivider(),

          // ================================================================
          // SECTION 8 — Uniform grid tiles
          // ================================================================
          _ggSectionHeader(
            '7 · Uniform Grid — All Tiles Identical',
            subtitle: 'Same extents, regular spacing',
          ),
          const SizedBox(height: 8),
          _ggParagraph(
            'SliverGridRegularTileLayout produces SliverGridGeometry objects '
            'where every tile has the same mainAxisExtent and crossAxisExtent.  '
            'Only scrollOffset and crossAxisOffset change per tile.  This is '
            'the most common layout in apps — a photo grid, an icon picker, '
            'product cards, and so on.',
          ),
          // Visual: 3×3 uniform grid
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _ggRust.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Text('3 × 3 uniform grid',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _ggRust)),
                const SizedBox(height: 8),
                for (int row = 0; row < 3; row++) ...[
                  if (row > 0) const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int col = 0; col < 3; col++) ...[
                        if (col > 0) const SizedBox(width: 6),
                        _ggTileBox(
                          width: 80,
                          height: 60,
                          label:
                              's:${row * 66}\nc:${col * 86}\n80×60',
                          color: _ggRust
                              .withValues(alpha: 0.1 + (row * 3 + col) * 0.05),
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
          _ggCaption(
            'Every tile: mainAxisExtent=60, crossAxisExtent=80.  '
            'scrollOffset and crossAxisOffset vary by row/column.',
          ),

          // Second uniform grid variant — 4 columns
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _ggForest.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                const Text('4-column compact grid',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _ggForest)),
                const SizedBox(height: 8),
                for (int row = 0; row < 2; row++) ...[
                  if (row > 0) const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (int col = 0; col < 4; col++) ...[
                        if (col > 0) const SizedBox(width: 4),
                        _ggTileBox(
                          width: 62,
                          height: 46,
                          label: '($row,$col)',
                          color:
                              _ggForest.withValues(alpha: 0.1 + col * 0.08),
                          textColor: _ggForest,
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
          _ggCaption('4-column variant — narrower crossAxisExtent.'),
          _ggDivider(),

          // ================================================================
          // SECTION 9 — Non-uniform / staggered tiles
          // ================================================================
          _ggSectionHeader(
            '8 · Non-Uniform Geometry — Staggered Layouts',
            subtitle: 'Different mainAxisExtent per tile',
          ),
          const SizedBox(height: 8),
          _ggParagraph(
            'While SliverGridRegularTileLayout always produces identical '
            'geometries, a custom SliverGridLayout implementation can return '
            'different mainAxisExtent values per tile index, creating a '
            'staggered mosaic.  Each SliverGridGeometry is still the same '
            'data class — only the numbers differ.',
          ),
          // Visual: staggered layout with varying heights
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _ggPlum.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Staggered 2-column layout',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _ggPlum)),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left column — varying heights
                    Expanded(
                      child: Column(
                        children: [
                          _ggTileBox(
                            width: double.infinity,
                            height: 80,
                            label: 'main: 80\ncross: full',
                            color: _ggPlum.withValues(alpha: 0.12),
                            textColor: _ggPlum,
                          ),
                          const SizedBox(height: 6),
                          _ggTileBox(
                            width: double.infinity,
                            height: 50,
                            label: 'main: 50',
                            color: _ggPlum.withValues(alpha: 0.22),
                            textColor: _ggPlum,
                          ),
                          const SizedBox(height: 6),
                          _ggTileBox(
                            width: double.infinity,
                            height: 70,
                            label: 'main: 70',
                            color: _ggPlum.withValues(alpha: 0.32),
                            textColor: _ggPlum,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6),
                    // Right column — different varying heights
                    Expanded(
                      child: Column(
                        children: [
                          _ggTileBox(
                            width: double.infinity,
                            height: 55,
                            label: 'main: 55',
                            color: _ggSky.withValues(alpha: 0.15),
                            textColor: _ggSky,
                          ),
                          const SizedBox(height: 6),
                          _ggTileBox(
                            width: double.infinity,
                            height: 90,
                            label: 'main: 90',
                            color: _ggSky.withValues(alpha: 0.25),
                            textColor: _ggSky,
                          ),
                          const SizedBox(height: 6),
                          _ggTileBox(
                            width: double.infinity,
                            height: 60,
                            label: 'main: 60',
                            color: _ggSky.withValues(alpha: 0.35),
                            textColor: _ggSky,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _ggCaption(
            'Each tile has its own SliverGridGeometry.  The staggered look '
            'comes from different mainAxisExtent values per column.',
          ),
          _ggDivider(),

          // ================================================================
          // SECTION 10 — Constructing SliverGridGeometry objects
          // ================================================================
          _ggSectionHeader(
            '9 · Constructing SliverGridGeometry',
            subtitle: 'Creating geometry objects with different configurations',
          ),
          const SizedBox(height: 8),
          _ggParagraph(
            'The constructor takes four named, required doubles.  There are '
            'no optional parameters and no factory constructors.  The class '
            'is intentionally minimal — it carries data, nothing more.',
          ),
          // Visual: constructor card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _ggCharcoal,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'const SliverGridGeometry(\n'
                  '  scrollOffset: 0.0,\n'
                  '  crossAxisOffset: 0.0,\n'
                  '  mainAxisExtent: 120.0,\n'
                  '  crossAxisExtent: 180.0,\n'
                  ')',
                  style: TextStyle(
                    color: Color(0xFF81C784),
                    fontSize: 13,
                    fontFamily: 'monospace',
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Different configurations
          _ggInfoCard(
            'Square tile at origin',
            'SliverGridGeometry(scrollOffset: 0, crossAxisOffset: 0, '
            'mainAxisExtent: 100, crossAxisExtent: 100)\n'
            '→ trailingScrollOffset = 100',
            Icons.crop_square,
            _ggTeal,
          ),
          _ggInfoCard(
            'Wide banner in second row',
            'SliverGridGeometry(scrollOffset: 110, crossAxisOffset: 0, '
            'mainAxisExtent: 60, crossAxisExtent: 360)\n'
            '→ trailingScrollOffset = 170',
            Icons.panorama_wide_angle,
            _ggIndigo,
          ),
          _ggInfoCard(
            'Small thumbnail, third column',
            'SliverGridGeometry(scrollOffset: 0, crossAxisOffset: 240, '
            'mainAxisExtent: 48, crossAxisExtent: 48)\n'
            '→ trailingScrollOffset = 48',
            Icons.photo_size_select_small,
            _ggCoral,
          ),
          _ggDivider(),

          // ================================================================
          // SECTION 11 — How RenderSliverGrid uses geometry
          // ================================================================
          _ggSectionHeader(
            '10 · Inside RenderSliverGrid',
            subtitle: 'How the renderer consumes SliverGridGeometry',
          ),
          const SizedBox(height: 8),
          _ggParagraph(
            'When RenderSliverGrid performs layout it iterates child indices '
            'and for each one asks the SliverGridLayout for a geometry.  The '
            'renderer then:\n'
            '  1. Calls getBoxConstraints() to get tight constraints.\n'
            '  2. Lays out the child with those constraints.\n'
            '  3. Paints the child at the offset derived from scrollOffset '
            'and crossAxisOffset.\n'
            '  4. Uses trailingScrollOffset to decide if more children '
            'need to be materialised.',
          ),
          // Flow diagram
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _ggAmber.withValues(alpha: 0.4)),
            ),
            child: Column(
              children: [
                const Text('Layout flow',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: _ggAmber)),
                const SizedBox(height: 10),
                _ggFlowStep('SliverGridLayout.getGeometryForChildIndex(i)',
                    _ggTeal),
                const Icon(Icons.arrow_downward,
                    size: 16, color: _ggSlate),
                _ggFlowStep('SliverGridGeometry returned', _ggRust),
                const Icon(Icons.arrow_downward,
                    size: 16, color: _ggSlate),
                _ggFlowStep('getBoxConstraints(sliverConstraints)', _ggIndigo),
                const Icon(Icons.arrow_downward,
                    size: 16, color: _ggSlate),
                _ggFlowStep('child.layout(constraints)', _ggForest),
                const Icon(Icons.arrow_downward,
                    size: 16, color: _ggSlate),
                _ggFlowStep(
                    'paint at (crossAxisOffset, scrollOffset)', _ggPlum),
              ],
            ),
          ),
          _ggCaption(
            'SliverGridGeometry is the bridge between the abstract layout '
            'strategy and the concrete render object.',
          ),
          _ggDivider(),

          // ================================================================
          // SECTION 12 — Property comparison table
          // ================================================================
          _ggSectionHeader(
            '11 · Property Comparison Table',
            subtitle: 'All four properties side-by-side for multiple tiles',
          ),
          const SizedBox(height: 8),
          _ggParagraph(
            'Below is a visual table showing how the four geometry properties '
            'vary across different tiles in a 3-column, 2-row uniform grid '
            'with 80×60 tiles and 6px spacing.',
          ),
          // Table header
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: _ggDarkRust,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: const Row(
              children: [
                SizedBox(
                    width: 40,
                    child: Text('Tile',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('scroll',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('cross',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('mainExt',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('crossExt',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold))),
                Expanded(
                    child: Text('trailing',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold))),
              ],
            ),
          ),
          // Table rows
          for (int row = 0; row < 2; row++)
            for (int col = 0; col < 3; col++)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: (row * 3 + col).isEven
                      ? _ggSand.withValues(alpha: 0.4)
                      : Colors.white,
                  border: Border(
                    bottom: BorderSide(
                        color: _ggSlate.withValues(alpha: 0.15)),
                  ),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 40,
                      child: Text('($row,$col)',
                          style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: _ggRust)),
                    ),
                    Expanded(
                      child: Text('${row * 66}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 10, color: _ggTeal)),
                    ),
                    Expanded(
                      child: Text('${col * 86}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 10, color: _ggIndigo)),
                    ),
                    const Expanded(
                      child: Text('60',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: _ggCoral)),
                    ),
                    const Expanded(
                      child: Text('80',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 10, color: _ggForest)),
                    ),
                    Expanded(
                      child: Text('${row * 66 + 60}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 10, color: _ggPlum)),
                    ),
                  ],
                ),
              ),
          // Table bottom border
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 3,
            decoration: BoxDecoration(
              color: _ggDarkRust,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(8)),
            ),
          ),
          _ggCaption(
            'In a uniform grid, mainAxisExtent and crossAxisExtent stay '
            'constant; only offsets change.',
          ),
          _ggDivider(),

          // ================================================================
          // SECTION 13 — Practical: real GridView with annotated tiles
          // ================================================================
          _ggSectionHeader(
            '12 · Practical GridView Showcase',
            subtitle: 'Real grid widgets backed by SliverGridGeometry',
          ),
          const SizedBox(height: 8),
          _ggParagraph(
            'Below are actual GridView widgets.  Under the hood every tile\'s '
            'position is determined by a SliverGridGeometry.  The demo '
            'overlays the geometry data so you can see the values in action.',
          ),
          // GridView 1: photo-gallery style
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _ggRust.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Photo gallery — 3 columns, aspect ratio 1.0',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _ggRust)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 200,
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      6,
                      (i) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _ggRust.withValues(alpha: 0.2 + i * 0.1),
                              _ggSand,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              [
                                Icons.landscape,
                                Icons.pets,
                                Icons.local_florist,
                                Icons.wb_sunny,
                                Icons.water_drop,
                                Icons.filter_vintage,
                              ][i],
                              color: _ggDarkRust,
                              size: 24,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tile $i',
                              style: const TextStyle(
                                  fontSize: 10, color: _ggDarkRust),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // GridView 2: wide aspect ratio (landscape cards)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _ggTeal.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Landscape cards — 2 columns, ratio 2.0',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _ggTeal)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 140,
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 2.0,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      4,
                      (i) => Container(
                        decoration: BoxDecoration(
                          color: _ggTeal.withValues(alpha: 0.12 + i * 0.08),
                          borderRadius: BorderRadius.circular(6),
                          border:
                              Border.all(color: _ggTeal.withValues(alpha: 0.4)),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Row(
                          children: [
                            Icon(
                              [
                                Icons.movie,
                                Icons.music_note,
                                Icons.book,
                                Icons.sports_basketball,
                              ][i],
                              color: _ggTeal,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Card $i — wide ratio',
                                style: const TextStyle(
                                    fontSize: 11, color: _ggCharcoal),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // GridView 3: tall portrait cards
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _ggPlum.withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Portrait cards — 4 columns, ratio 0.65',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: _ggPlum)),
                const SizedBox(height: 8),
                SizedBox(
                  height: 190,
                  child: GridView.count(
                    crossAxisCount: 4,
                    childAspectRatio: 0.65,
                    mainAxisSpacing: 6,
                    crossAxisSpacing: 6,
                    physics: const NeverScrollableScrollPhysics(),
                    children: List.generate(
                      4,
                      (i) => Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _ggPlum.withValues(alpha: 0.1 + i * 0.12),
                              _ggSand.withValues(alpha: 0.6),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: _ggPlum.withValues(alpha: 0.3)),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              [
                                Icons.person,
                                Icons.person_outline,
                                Icons.face,
                                Icons.tag_faces,
                              ][i],
                              color: _ggPlum,
                              size: 28,
                            ),
                            const SizedBox(height: 6),
                            Text('P$i',
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: _ggPlum)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          _ggCaption(
            'Three different aspect ratios → three different sets of '
            'SliverGridGeometry values under the hood.',
          ),
          _ggDivider(),

          // ================================================================
          // SECTION 14 — Relationship to other classes
          // ================================================================
          _ggSectionHeader(
            '13 · Class Relationships',
            subtitle: 'Where SliverGridGeometry fits in the grid pipeline',
          ),
          const SizedBox(height: 8),
          _ggParagraph(
            'SliverGridGeometry is part of a small family of classes '
            'that cooperate to lay out grids:',
          ),
          _ggInfoCard(
            'SliverGridDelegate',
            'Top-level strategy. Receives SliverConstraints and produces '
            'a SliverGridLayout. Examples: '
            'SliverGridDelegateWithFixedCrossAxisCount, '
            'SliverGridDelegateWithMaxCrossAxisExtent.',
            Icons.account_tree,
            _ggSky,
          ),
          _ggInfoCard(
            'SliverGridLayout',
            'Abstract interface returned by the delegate. Provides '
            'getGeometryForChildIndex(i) → SliverGridGeometry and '
            'computeMaxScrollOffset(childCount).',
            Icons.grid_on,
            _ggForest,
          ),
          _ggInfoCard(
            'SliverGridRegularTileLayout',
            'Concrete SliverGridLayout for uniform grids. Computes geometry '
            'from crossAxisCount, mainAxisStride, crossAxisStride, etc.',
            Icons.apps,
            _ggPlum,
          ),
          _ggInfoCard(
            'SliverGridGeometry',
            'The data object you\'re looking at now — carries four doubles '
            'and two derived getters.  Created by SliverGridLayout, consumed '
            'by RenderSliverGrid.',
            Icons.data_object,
            _ggRust,
          ),
          _ggInfoCard(
            'RenderSliverGrid',
            'Render object that iterates children, asks the layout for '
            'geometry, and positions each child accordingly.',
            Icons.view_module,
            _ggAmber,
          ),
          _ggDivider(),

          // ================================================================
          // SECTION 15 — Edge cases and special values
          // ================================================================
          _ggSectionHeader(
            '14 · Edge Cases & Special Values',
            subtitle: 'Zero extents, large offsets, single-tile grids',
          ),
          const SizedBox(height: 8),
          _ggParagraph(
            'SliverGridGeometry accepts any non-negative double.  Some '
            'interesting edge cases:',
          ),
          // Edge case visuals
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _ggCoral.withValues(alpha: 0.3)),
            ),
            child: Column(
              children: [
                // Zero mainAxisExtent
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 2,
                      color: _ggCoral,
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'mainAxisExtent = 0 → zero-height tile, '
                        'trailingScrollOffset = scrollOffset',
                        style: TextStyle(fontSize: 11, color: _ggCharcoal),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Single tile filling entire width
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        color: _ggForest.withValues(alpha: 0.15),
                        border: Border.all(color: _ggForest),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: const Text('full width',
                          style: TextStyle(fontSize: 9, color: _ggForest)),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'crossAxisExtent = viewport width, '
                        'crossAxisOffset = 0 → banner tile',
                        style: TextStyle(fontSize: 11, color: _ggCharcoal),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Large scrollOffset
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 30,
                      decoration: BoxDecoration(
                        color: _ggSky.withValues(alpha: 0.15),
                        border: Border.all(color: _ggSky),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: const Text('far down',
                          style: TextStyle(fontSize: 9, color: _ggSky)),
                    ),
                    const SizedBox(width: 10),
                    const Expanded(
                      child: Text(
                        'scrollOffset = 50000 → tile is far down the list; '
                        'renderer skips painting until user scrolls there',
                        style: TextStyle(fontSize: 11, color: _ggCharcoal),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          _ggCaption('The data class imposes no constraints — the layout '
              'strategy is responsible for sensible values.'),
          _ggDivider(),

          // ================================================================
          // SECTION 16 — Summary
          // ================================================================
          _ggSectionHeader(
            '15 · Summary',
            subtitle: 'Key take-aways',
          ),
          const SizedBox(height: 8),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  _ggRust.withValues(alpha: 0.08),
                  _ggSand.withValues(alpha: 0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _ggRust.withValues(alpha: 0.3)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• SliverGridGeometry is an immutable data class.',
                    style: TextStyle(fontSize: 13, color: _ggCharcoal,
                        height: 1.6)),
                Text('• Four properties: scrollOffset, crossAxisOffset, '
                    'mainAxisExtent, crossAxisExtent.',
                    style: TextStyle(fontSize: 13, color: _ggCharcoal,
                        height: 1.6)),
                Text('• Two derived getters: trailingScrollOffset, '
                    'getBoxConstraints().',
                    style: TextStyle(fontSize: 13, color: _ggCharcoal,
                        height: 1.6)),
                Text('• Produced by SliverGridLayout, consumed by '
                    'RenderSliverGrid.',
                    style: TextStyle(fontSize: 13, color: _ggCharcoal,
                        height: 1.6)),
                Text('• Same structure, different values → uniform or '
                    'staggered grids.',
                    style: TextStyle(fontSize: 13, color: _ggCharcoal,
                        height: 1.6)),
                Text('• Works identically for vertical and horizontal '
                    'scroll directions.',
                    style: TextStyle(fontSize: 13, color: _ggCharcoal,
                        height: 1.6)),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Additional helpers
// ---------------------------------------------------------------------------

Widget _ggFlowStep(String text, Color color) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(vertical: 3),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: 11,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}
