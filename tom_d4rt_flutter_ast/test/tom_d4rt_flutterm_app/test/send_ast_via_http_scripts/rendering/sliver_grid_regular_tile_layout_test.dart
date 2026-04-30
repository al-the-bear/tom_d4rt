// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// SLIVER GRID REGULAR TILE LAYOUT — Deep Demo
// ============================================================================
//
// SliverGridRegularTileLayout is the **concrete implementation** of
// SliverGridLayout that Flutter uses for grids where every tile is the
// same size.  Both built-in delegates — FixedCrossAxisCount and
// MaxCrossAxisExtent — produce an instance of this class.
//
// It stores six values that fully describe a uniform grid:
//
//   • crossAxisCount        – number of tiles per row (or column)
//   • mainAxisStride        – distance between tile starts along scroll axis
//   • crossAxisStride       – distance between tile starts on cross axis
//   • childMainAxisExtent   – the tile's size along the scroll axis
//   • childCrossAxisExtent  – the tile's size along the cross axis
//   • reverseCrossAxis      – whether to flip cross-axis ordering (RTL)
//
// From these, the two abstract methods are implemented:
//
//   getGeometryForChildIndex(index):
//     row   = index  ~/ crossAxisCount
//     col   = index  %  crossAxisCount
//     scrollOffset    = row × mainAxisStride
//     crossAxisOffset = col × crossAxisStride  (flipped if reverseCrossAxis)
//
//   computeMaxScrollOffset(childCount):
//     rows = (childCount / crossAxisCount).ceil()
//     maxScroll = mainAxisStride × rows - (mainAxisStride - childMainAxisExtent)
//
// This demo makes every property tangible through visual diagrams, shows
// how stride vs. extent creates spacing, demonstrates RTL behaviour,
// and builds real grids that exercise the layout.
//
// Color theme : Bronze (#795548) / Cream (#EFEBE9)
// Helper prefix: _rt
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _rtBronze = Color(0xFF795548);
const Color _rtCream = Color(0xFFEFEBE9);
const Color _rtDarkBronze = Color(0xFF4E342E);
const Color _rtLightCream = Color(0xFFFAF7F5);
const Color _rtCharcoal = Color(0xFF263238);
const Color _rtSlate = Color(0xFF546E7A);
const Color _rtTeal = Color(0xFF00897B);
const Color _rtAmber = Color(0xFFFFA000);
const Color _rtCoral = Color(0xFFEF5350);
const Color _rtForest = Color(0xFF2E7D32);
const Color _rtSky = Color(0xFF039BE5);
const Color _rtPlum = Color(0xFF7B1FA2);
const Color _rtRose = Color(0xFFE91E63);
const Color _rtOrange = Color(0xFFE65100);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

/// Section header with gradient background.
Widget _rtSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_rtBronze, _rtDarkBronze],
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

/// Explanatory paragraph.
Widget _rtParagraph(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: Text(
      text,
      style: const TextStyle(color: _rtCharcoal, fontSize: 14, height: 1.5),
    ),
  );
}

/// Italic caption.
Widget _rtCaption(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
    child: Text(
      text,
      style: const TextStyle(
        color: _rtSlate,
        fontSize: 13,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

/// Label–value row.
Widget _rtLabelValue(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 200,
          child: Text(
            label,
            style: const TextStyle(
              color: _rtSlate,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? _rtBronze,
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

/// Icon + text info card.
Widget _rtInfoCard(String title, String body, IconData icon, Color accent) {
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
                  color: _rtCharcoal,
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

/// Horizontal divider.
Widget _rtDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    height: 1,
    color: _rtCream,
  );
}

/// Code-style monospace text block.
Widget _rtCodeBlock(String code) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: const Color(0xFF1E1E2E),
      borderRadius: BorderRadius.circular(8),
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: Color(0xFFCDD6F4),
        fontSize: 12,
        fontFamily: 'monospace',
        height: 1.5,
      ),
    ),
  );
}

/// Colored badge/chip.
Widget _rtBadge(String label, Color bg, Color fg) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(
      color: bg,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: fg,
        fontSize: 11,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

/// A small visual tile for diagrams.
Widget _rtDiagramTile(
  String label, {
  Color? color,
  double width = 70,
  double height = 50,
  Color textColor = Colors.white,
  double fontSize = 11,
}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: color ?? _rtBronze,
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor,
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

// ============================================================================
// Main build
// ============================================================================

dynamic build(BuildContext context) {
  print('--- SliverGridRegularTileLayout Deep Demo ---');
  print('Demonstrating the concrete uniform-tile grid layout.');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ================================================================
        // SECTION 1 — Title banner
        // ================================================================
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [_rtDarkBronze, _rtBronze, Color(0xFF8D6E63)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SliverGridRegularTileLayout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Concrete layout for uniform-sized grid tiles',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _rtBadge('CONCRETE', _rtForest, Colors.white),
                  const SizedBox(width: 8),
                  _rtBadge('rendering.dart', Colors.white24, Colors.white),
                  const SizedBox(width: 8),
                  _rtBadge('UNIFORM TILES', _rtAmber, _rtCharcoal),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // ================================================================
        // SECTION 2 — What is SliverGridRegularTileLayout?
        // ================================================================
        _rtSectionHeader(
          '1 · What Is SliverGridRegularTileLayout?',
          subtitle:
              'The implementation behind every standard Flutter grid',
        ),
        const SizedBox(height: 8),
        _rtParagraph(
          'SliverGridRegularTileLayout is the sole concrete implementation of '
          'SliverGridLayout shipped with Flutter. It handles grids where every '
          'tile has exactly the same dimensions — which covers the vast '
          'majority of real-world grid use cases.',
        ),
        _rtParagraph(
          'Both SliverGridDelegateWithFixedCrossAxisCount and '
          'SliverGridDelegateWithMaxCrossAxisExtent produce instances of this '
          'class. The "Regular" in the name means "uniform" — all tiles are '
          'regular rectangles of the same size.',
        ),
        _rtInfoCard(
          'One class, every grid',
          'Whether you use GridView.count, GridView.extent, GridView.builder '
          'with a FixedCrossAxisCount delegate, or a MaxCrossAxisExtent '
          'delegate, the underlying layout is always a '
          'SliverGridRegularTileLayout. The only difference is how the '
          'six parameters are computed.',
          Icons.apps,
          _rtBronze,
        ),

        _rtDivider(),

        // ================================================================
        // SECTION 3 — The Six Stored Properties
        // ================================================================
        _rtSectionHeader(
          '2 · The Six Stored Properties',
          subtitle: 'Everything the layout needs to position tiles',
        ),
        const SizedBox(height: 8),
        _rtParagraph(
          'SliverGridRegularTileLayout stores exactly six values. From these '
          'alone it can compute the position of any tile by index and the '
          'total scroll extent for any child count.',
        ),

        // Property cards
        _rtPropertyCard(
          'crossAxisCount',
          'int',
          'Number of tiles per row (vertical scroll) or per column '
          '(horizontal scroll). Determines how indices map to rows and columns.',
          Icons.view_column,
          _rtBronze,
        ),
        _rtPropertyCard(
          'mainAxisStride',
          'double',
          'Distance between the leading edges of consecutive rows (along '
          'the scroll axis). Equals childMainAxisExtent + mainAxisSpacing.',
          Icons.straighten,
          _rtTeal,
        ),
        _rtPropertyCard(
          'crossAxisStride',
          'double',
          'Distance between the leading edges of consecutive columns (on the '
          'cross axis). Equals childCrossAxisExtent + crossAxisSpacing.',
          Icons.swap_horiz,
          _rtAmber,
        ),
        _rtPropertyCard(
          'childMainAxisExtent',
          'double',
          'The tile\'s actual size along the scroll axis. The difference '
          'between mainAxisStride and childMainAxisExtent is the spacing.',
          Icons.height,
          _rtCoral,
        ),
        _rtPropertyCard(
          'childCrossAxisExtent',
          'double',
          'The tile\'s actual size along the cross axis. The difference '
          'between crossAxisStride and childCrossAxisExtent is the spacing.',
          Icons.width_normal,
          _rtForest,
        ),
        _rtPropertyCard(
          'reverseCrossAxis',
          'bool',
          'If true, cross-axis ordering is flipped (right-to-left in a '
          'vertical grid). Used for RTL text direction support.',
          Icons.flip,
          _rtPlum,
        ),

        _rtDivider(),

        // ================================================================
        // SECTION 4 — Stride vs. Extent Visualized
        // ================================================================
        _rtSectionHeader(
          '3 · Stride vs. Extent — The Spacing Secret',
          subtitle: 'How spacing emerges from two separate measurements',
        ),
        const SizedBox(height: 8),
        _rtParagraph(
          'A common source of confusion: "extent" is the tile\'s actual size, '
          'and "stride" is the distance from one tile\'s start to the next '
          'tile\'s start. The difference is the spacing between tiles.',
        ),

        // Visual stride vs extent diagram
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _rtLightCream,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _rtBronze.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Main axis (vertical scroll direction)',
                style: TextStyle(
                  color: _rtDarkBronze,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              // Tile A with extent marker
              Row(
                children: [
                  Container(
                    width: 180,
                    height: 60,
                    decoration: BoxDecoration(
                      color: _rtBronze,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Tile (row 0)',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(width: 40, height: 3, color: _rtCoral),
                          const SizedBox(width: 4),
                          const Text(
                            'childMainAxisExtent = 60px',
                            style: TextStyle(
                              color: _rtCoral,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // Spacing gap
              Container(
                width: 180,
                height: 16,
                decoration: BoxDecoration(
                  color: _rtAmber.withValues(alpha: 0.3),
                  border: Border(
                    left: BorderSide(color: _rtAmber.withValues(alpha: 0.6)),
                    right: BorderSide(color: _rtAmber.withValues(alpha: 0.6)),
                  ),
                ),
                alignment: Alignment.center,
                child: const Text(
                  'spacing = 16px',
                  style: TextStyle(
                    color: _rtOrange,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // Tile B
              Row(
                children: [
                  Container(
                    width: 180,
                    height: 60,
                    decoration: BoxDecoration(
                      color: _rtTeal,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'Tile (row 1)',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(width: 40, height: 3, color: _rtTeal),
                          const SizedBox(width: 4),
                          const Text(
                            'mainAxisStride = 76px',
                            style: TextStyle(
                              color: _rtTeal,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        '(= 60 + 16)',
                        style: TextStyle(color: _rtSlate, fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              // Same for cross axis
              const Text(
                'Cross axis (horizontal)',
                style: TextStyle(
                  color: _rtDarkBronze,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _rtBronze,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'col 0',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                  Container(
                    width: 12,
                    height: 50,
                    color: _rtAmber.withValues(alpha: 0.3),
                  ),
                  Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _rtTeal,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'col 1',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                  Container(
                    width: 12,
                    height: 50,
                    color: _rtAmber.withValues(alpha: 0.3),
                  ),
                  Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      color: _rtCoral,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      'col 2',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text(
                'crossAxisStride = 92px  (80 extent + 12 spacing)',
                style: TextStyle(
                  color: _rtSlate,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        _rtInfoCard(
          'Formula',
          'mainAxisStride = childMainAxisExtent + mainAxisSpacing\n'
          'crossAxisStride = childCrossAxisExtent + crossAxisSpacing\n\n'
          'The layout stores strides and extents separately so it can '
          'compute both tile sizes and positions in O(1) per tile.',
          Icons.functions,
          _rtBronze,
        ),

        _rtDivider(),

        // ================================================================
        // SECTION 5 — getGeometryForChildIndex Implementation
        // ================================================================
        _rtSectionHeader(
          '4 · getGeometryForChildIndex — Index to Position',
          subtitle: 'The core algorithm for tile placement',
        ),
        const SizedBox(height: 8),
        _rtParagraph(
          'Given a tile index, the layout computes its position with simple '
          'integer division and modulo arithmetic. This is what makes uniform '
          'grids so fast — no accumulation, no iteration, just O(1) math.',
        ),

        _rtCodeBlock(
          'SliverGridGeometry getGeometryForChildIndex(int index) {\n'
          '  final int row = index ~/ crossAxisCount;\n'
          '  final int col = index  % crossAxisCount;\n'
          '  final double crossAxisOffset =\n'
          '      col * crossAxisStride;  // flipped if reverseCrossAxis\n'
          '  return SliverGridGeometry(\n'
          '    scrollOffset: row * mainAxisStride,\n'
          '    crossAxisOffset: crossAxisOffset,\n'
          '    mainAxisExtent: childMainAxisExtent,\n'
          '    crossAxisExtent: childCrossAxisExtent,\n'
          '  );\n'
          '}',
        ),

        // Visual: show the computation for index 7 in a 3-column grid
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _rtLightCream,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _rtBronze.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Example: index = 7, crossAxisCount = 3',
                style: TextStyle(
                  color: _rtDarkBronze,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _rtLabelValue('row = 7 ~/ 3', '2'),
              _rtLabelValue('col = 7 % 3', '1'),
              _rtLabelValue(
                  'scrollOffset', '2 × 110 = 220.0', valueColor: _rtTeal),
              _rtLabelValue(
                  'crossAxisOffset', '1 × 92 = 92.0', valueColor: _rtAmber),
              _rtLabelValue(
                  'mainAxisExtent', '100.0', valueColor: _rtCoral),
              _rtLabelValue(
                  'crossAxisExtent', '80.0', valueColor: _rtForest),
              const SizedBox(height: 10),
              // Grid with index 7 highlighted
              _rtCaption('Grid showing tile 7 at row 2, col 1:'),
              const SizedBox(height: 6),
              // Row 0
              Row(
                children: [
                  _rtDiagramTile('0', width: 70, height: 42,
                      color: _rtBronze.withValues(alpha: 0.5)),
                  const SizedBox(width: 4),
                  _rtDiagramTile('1', width: 70, height: 42,
                      color: _rtBronze.withValues(alpha: 0.5)),
                  const SizedBox(width: 4),
                  _rtDiagramTile('2', width: 70, height: 42,
                      color: _rtBronze.withValues(alpha: 0.5)),
                ],
              ),
              const SizedBox(height: 4),
              // Row 1
              Row(
                children: [
                  _rtDiagramTile('3', width: 70, height: 42,
                      color: _rtBronze.withValues(alpha: 0.5)),
                  const SizedBox(width: 4),
                  _rtDiagramTile('4', width: 70, height: 42,
                      color: _rtBronze.withValues(alpha: 0.5)),
                  const SizedBox(width: 4),
                  _rtDiagramTile('5', width: 70, height: 42,
                      color: _rtBronze.withValues(alpha: 0.5)),
                ],
              ),
              const SizedBox(height: 4),
              // Row 2 (tile 7 highlighted)
              Row(
                children: [
                  _rtDiagramTile('6', width: 70, height: 42,
                      color: _rtBronze.withValues(alpha: 0.5)),
                  const SizedBox(width: 4),
                  _rtDiagramTile('7 ★', width: 70, height: 42,
                      color: _rtCoral),
                  const SizedBox(width: 4),
                  _rtDiagramTile('8', width: 70, height: 42,
                      color: _rtBronze.withValues(alpha: 0.5)),
                ],
              ),
            ],
          ),
        ),

        _rtCaption('Tile 7 lands at row 2, col 1 — computed in O(1).'),

        _rtDivider(),

        // ================================================================
        // SECTION 6 — computeMaxScrollOffset
        // ================================================================
        _rtSectionHeader(
          '5 · computeMaxScrollOffset — Total Scroll Extent',
          subtitle: 'How many pixels of scroll space a grid needs',
        ),
        const SizedBox(height: 8),
        _rtParagraph(
          'The formula accounts for the fact that the last row does not need '
          'trailing spacing. The result is the position of the trailing edge '
          'of the last row\'s tiles.',
        ),

        _rtCodeBlock(
          'double computeMaxScrollOffset(int childCount) {\n'
          '  if (childCount == 0) return 0.0;\n'
          '  final int rows = (childCount / crossAxisCount).ceil();\n'
          '  return mainAxisStride * rows\n'
          '       - (mainAxisStride - childMainAxisExtent);\n'
          '  // Equivalently: mainAxisStride * (rows - 1)\n'
          '  //              + childMainAxisExtent\n'
          '}',
        ),

        // Numeric examples
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _rtCream),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Numeric examples (crossAxisCount=3, mainAxisStride=110, '
                'childMainAxisExtent=100)',
                style: TextStyle(
                  color: _rtDarkBronze,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _rtExampleRow('1 child', 1, 3, 110, 100),
              _rtExampleRow('3 children', 3, 3, 110, 100),
              _rtExampleRow('4 children', 4, 3, 110, 100),
              _rtExampleRow('9 children', 9, 3, 110, 100),
              _rtExampleRow('10 children', 10, 3, 110, 100),
            ],
          ),
        ),

        _rtInfoCard(
          'No trailing spacing',
          'Notice that the formula subtracts the spacing after the last row. '
          '10 tiles in 3 columns → 4 rows → 110×4 - 10 = 430px, not 440px. '
          'The grid stops exactly at the bottom of the last tile.',
          Icons.space_bar,
          _rtTeal,
        ),

        _rtDivider(),

        // ================================================================
        // SECTION 7 — reverseCrossAxis (RTL)
        // ================================================================
        _rtSectionHeader(
          '6 · reverseCrossAxis — Right-to-Left Support',
          subtitle: 'Flipping tile order for RTL languages',
        ),
        const SizedBox(height: 8),
        _rtParagraph(
          'When reverseCrossAxis is true, the cross-axis offset is computed '
          'from the opposite edge. In a vertical grid this means tiles fill '
          'from right to left instead of left to right. This is essential '
          'for RTL locales like Arabic and Hebrew.',
        ),

        // Side-by-side LTR vs RTL
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _rtLightCream,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _rtPlum.withValues(alpha: 0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LTR
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                        color: _rtBronze.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'LTR (reverse: false)',
                        style: TextStyle(
                          color: _rtBronze,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _rtDiagramTile('0', width: 38, height: 32,
                            color: _rtBronze),
                        const SizedBox(width: 3),
                        _rtDiagramTile('1', width: 38, height: 32,
                            color: _rtTeal),
                        const SizedBox(width: 3),
                        _rtDiagramTile('2', width: 38, height: 32,
                            color: _rtAmber,
                            textColor: _rtCharcoal),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        _rtDiagramTile('3', width: 38, height: 32,
                            color: _rtCoral),
                        const SizedBox(width: 3),
                        _rtDiagramTile('4', width: 38, height: 32,
                            color: _rtForest),
                        const SizedBox(width: 3),
                        _rtDiagramTile('5', width: 38, height: 32,
                            color: _rtSky),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '0 → 1 → 2',
                      style: TextStyle(color: _rtSlate, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Container(
                width: 1,
                height: 110,
                color: _rtCream,
                margin: const EdgeInsets.symmetric(horizontal: 8),
              ),
              // RTL
              Expanded(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 10),
                      decoration: BoxDecoration(
                        color: _rtPlum.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'RTL (reverse: true)',
                        style: TextStyle(
                          color: _rtPlum,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _rtDiagramTile('2', width: 38, height: 32,
                            color: _rtAmber,
                            textColor: _rtCharcoal),
                        const SizedBox(width: 3),
                        _rtDiagramTile('1', width: 38, height: 32,
                            color: _rtTeal),
                        const SizedBox(width: 3),
                        _rtDiagramTile('0', width: 38, height: 32,
                            color: _rtBronze),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        _rtDiagramTile('5', width: 38, height: 32,
                            color: _rtSky),
                        const SizedBox(width: 3),
                        _rtDiagramTile('4', width: 38, height: 32,
                            color: _rtForest),
                        const SizedBox(width: 3),
                        _rtDiagramTile('3', width: 38, height: 32,
                            color: _rtCoral),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      '2 ← 1 ← 0',
                      style: TextStyle(color: _rtSlate, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        _rtParagraph(
          'The crossAxisOffset for a reversed layout is: '
          '(crossAxisCount - 1 - col) × crossAxisStride. '
          'The scroll axis remains unchanged — only the cross axis flips.',
        ),

        // Live RTL grid using Directionality
        _rtCaption('Live RTL grid using Directionality.rtl:'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(color: _rtPlum.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.2,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),
              padding: const EdgeInsets.all(6),
              itemCount: 8,
              itemBuilder: (context, index) {
                final colors = [
                  _rtBronze, _rtTeal, _rtAmber, _rtCoral,
                  _rtForest, _rtSky, _rtPlum, _rtRose,
                ];
                return Container(
                  decoration: BoxDecoration(
                    color: colors[index],
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '$index',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        _rtCaption(
          'Tile 0 appears at the right edge, tile 3 at the left. '
          'Row order (scroll axis) stays top-to-bottom.',
        ),

        _rtDivider(),

        // ================================================================
        // SECTION 8 — FixedCrossAxisCount → RegularTileLayout
        // ================================================================
        _rtSectionHeader(
          '7 · From FixedCrossAxisCount to RegularTileLayout',
          subtitle: 'How the delegate computes the six properties',
        ),
        const SizedBox(height: 8),
        _rtParagraph(
          'SliverGridDelegateWithFixedCrossAxisCount receives the available '
          'cross-axis extent from SliverConstraints and computes tile sizes:',
        ),

        _rtCodeBlock(
          'final usableCrossAxisExtent =\n'
          '    constraints.crossAxisExtent\n'
          '    - crossAxisSpacing * (crossAxisCount - 1);\n'
          '\n'
          'final childCrossAxisExtent =\n'
          '    usableCrossAxisExtent / crossAxisCount;\n'
          '\n'
          'final childMainAxisExtent =\n'
          '    childCrossAxisExtent / childAspectRatio;\n'
          '\n'
          '// Then creates:\n'
          'SliverGridRegularTileLayout(\n'
          '  crossAxisCount: crossAxisCount,\n'
          '  mainAxisStride: childMainAxisExtent + mainAxisSpacing,\n'
          '  crossAxisStride: childCrossAxisExtent + crossAxisSpacing,\n'
          '  childMainAxisExtent: childMainAxisExtent,\n'
          '  childCrossAxisExtent: childCrossAxisExtent,\n'
          '  reverseCrossAxis: /* based on textDirection */,\n'
          ')',
        ),

        // Live grid: 3 columns, aspect ratio 1.0
        _rtCaption('Result: 3 columns, ratio 1.0, 8px spacing, square tiles'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: _rtBronze.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            padding: const EdgeInsets.all(8),
            itemCount: 9,
            itemBuilder: (context, index) {
              final hue = (index * 40.0) % 360;
              return Container(
                decoration: BoxDecoration(
                  color: HSVColor.fromAHSV(1, hue, 0.55, 0.8).toColor(),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: HSVColor.fromAHSV(0.3, hue, 0.6, 0.6).toColor(),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Tile $index',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'r${index ~/ 3} c${index % 3}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        _rtDivider(),

        // ================================================================
        // SECTION 9 — MaxCrossAxisExtent → RegularTileLayout
        // ================================================================
        _rtSectionHeader(
          '8 · From MaxCrossAxisExtent to RegularTileLayout',
          subtitle: 'Responsive column count from tile size preference',
        ),
        const SizedBox(height: 8),
        _rtParagraph(
          'SliverGridDelegateWithMaxCrossAxisExtent computes the column count '
          'dynamically: crossAxisCount = (crossAxisExtent / '
          '(maxCrossAxisExtent + crossAxisSpacing)).ceil(). Then it '
          'creates the same SliverGridRegularTileLayout class.',
        ),

        _rtCodeBlock(
          'final crossAxisCount = (\n'
          '  constraints.crossAxisExtent /\n'
          '  (maxCrossAxisExtent + crossAxisSpacing)\n'
          ').ceil();\n'
          '\n'
          '// Then computes tile sizes and creates\n'
          '// SliverGridRegularTileLayout with that count.',
        ),

        // Live grid: maxCrossAxisExtent = 100
        _rtCaption(
            'maxCrossAxisExtent: 100, ratio 0.8 — taller than wide'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          height: 260,
          decoration: BoxDecoration(
            border: Border.all(color: _rtTeal.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 100,
              childAspectRatio: 0.8,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            padding: const EdgeInsets.all(10),
            itemCount: 8,
            itemBuilder: (context, index) {
              final icons = [
                Icons.wb_sunny,
                Icons.cloud,
                Icons.bolt,
                Icons.water_drop,
                Icons.air,
                Icons.thermostat,
                Icons.visibility,
                Icons.waves,
              ];
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _rtBronze.withValues(alpha: 0.8),
                      _rtDarkBronze,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icons[index], color: _rtCream, size: 26),
                    const SizedBox(height: 4),
                    Text(
                      'W$index',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        _rtInfoCard(
          'Same class, different factory',
          'Both delegates create a SliverGridRegularTileLayout. '
          'The difference is only in HOW they compute the six properties. '
          'FixedCrossAxisCount uses a given column count; '
          'MaxCrossAxisExtent derives it from available space.',
          Icons.compare_arrows,
          _rtAmber,
        ),

        _rtDivider(),

        // ================================================================
        // SECTION 10 — Aspect Ratio Gallery
        // ================================================================
        _rtSectionHeader(
          '9 · Aspect Ratio Gallery',
          subtitle: 'How childAspectRatio shapes tile proportions',
        ),
        const SizedBox(height: 8),
        _rtParagraph(
          'The childAspectRatio parameter controls the ratio of '
          'childCrossAxisExtent to childMainAxisExtent. A ratio of 1.0 '
          'makes square tiles; >1 makes them wider than tall; <1 makes '
          'them taller than wide.',
        ),

        // Ratio 2.0 — very wide
        _rtCaption('Aspect ratio 2.0 — wide landscape tiles'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: _rtBronze.withValues(alpha: 0.2)),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.0,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
            ),
            padding: const EdgeInsets.all(6),
            itemCount: 6,
            itemBuilder: (context, i) => Container(
              decoration: BoxDecoration(
                color: _rtAmber.withValues(alpha: 0.7 + i * 0.05),
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: Text('2.0',
                  style: TextStyle(
                      color: _rtCharcoal.withValues(alpha: 0.8),
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Ratio 1.0 — square
        _rtCaption('Aspect ratio 1.0 — perfect squares'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          height: 140,
          decoration: BoxDecoration(
            border: Border.all(color: _rtBronze.withValues(alpha: 0.2)),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.0,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
            ),
            padding: const EdgeInsets.all(6),
            itemCount: 6,
            itemBuilder: (context, i) => Container(
              decoration: BoxDecoration(
                color: _rtTeal.withValues(alpha: 0.7 + i * 0.05),
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: const Text('1.0',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            ),
          ),
        ),

        const SizedBox(height: 8),

        // Ratio 0.6 — tall portrait
        _rtCaption('Aspect ratio 0.6 — tall portrait tiles'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: _rtBronze.withValues(alpha: 0.2)),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 0.6,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
            ),
            padding: const EdgeInsets.all(6),
            itemCount: 3,
            itemBuilder: (context, i) => Container(
              decoration: BoxDecoration(
                color: _rtCoral.withValues(alpha: 0.7 + i * 0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: const Text('0.6',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12)),
            ),
          ),
        ),

        _rtParagraph(
          'In all three cases the underlying SliverGridRegularTileLayout has '
          'different childMainAxisExtent values but the same crossAxisCount '
          'and childCrossAxisExtent. The ratio only affects the main axis.',
        ),

        _rtDivider(),

        // ================================================================
        // SECTION 11 — Horizontal Scroll Grid
        // ================================================================
        _rtSectionHeader(
          '10 · Horizontal Scrolling Grid',
          subtitle: 'Main axis becomes horizontal, cross axis becomes vertical',
        ),
        const SizedBox(height: 8),
        _rtParagraph(
          'When a GridView scrolls horizontally, the axes swap. MainAxisStride '
          'controls horizontal distance between columns, and crossAxisCount '
          'determines how many rows there are. The SliverGridRegularTileLayout '
          'works identically — only the axis interpretation changes.',
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          height: 180,
          decoration: BoxDecoration(
            border: Border.all(color: _rtForest.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            padding: const EdgeInsets.all(8),
            itemCount: 10,
            itemBuilder: (context, index) {
              final hue = (index * 36.0) % 360;
              return Container(
                decoration: BoxDecoration(
                  color: HSVColor.fromAHSV(1, hue, 0.5, 0.85).toColor(),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'H$index',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'r${index % 2} c${index ~/ 2}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.7),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        _rtCaption(
          '2 rows, horizontal scroll. crossAxisCount=2 means 2 rows. '
          'MainAxisStride controls column spacing.',
        ),

        _rtInfoCard(
          'Axis interpretation',
          'In a horizontal grid: mainAxis = horizontal (scroll direction), '
          'crossAxis = vertical. The SliverGridRegularTileLayout does not '
          'know or care which axis is which — it just computes offsets.',
          Icons.rotate_90_degrees_cw,
          _rtSky,
        ),

        _rtDivider(),

        // ================================================================
        // SECTION 12 — Real-World Photo Gallery
        // ================================================================
        _rtSectionHeader(
          '11 · Real-World: Photo Gallery Grid',
          subtitle: 'Practical application of uniform tile layout',
        ),
        const SizedBox(height: 8),
        _rtParagraph(
          'A photo gallery is the quintessential use of '
          'SliverGridRegularTileLayout. All thumbnails are the same size, '
          'making the layout fast and predictable. Below is a gallery with '
          'color-coded "photos".',
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: _rtCharcoal,
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              // Gallery header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                color: _rtDarkBronze,
                child: const Row(
                  children: [
                    Icon(Icons.photo_library, color: Colors.white, size: 20),
                    SizedBox(width: 8),
                    Text(
                      'Gallery',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '12 photos',
                      style: TextStyle(color: Color(0x99FFFFFF), fontSize: 12),
                    ),
                  ],
                ),
              ),
              // Photo grid
              SizedBox(
                height: 280,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                  ),
                  padding: const EdgeInsets.all(2),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    final gradients = [
                      [const Color(0xFFE53935), const Color(0xFFFF7043)],
                      [const Color(0xFF1E88E5), const Color(0xFF42A5F5)],
                      [const Color(0xFF43A047), const Color(0xFF66BB6A)],
                      [const Color(0xFFFDD835), const Color(0xFFFFEE58)],
                      [const Color(0xFF8E24AA), const Color(0xFFAB47BC)],
                      [const Color(0xFF00ACC1), const Color(0xFF26C6DA)],
                      [const Color(0xFFFF7043), const Color(0xFFFF8A65)],
                      [const Color(0xFF5C6BC0), const Color(0xFF7986CB)],
                      [const Color(0xFF26A69A), const Color(0xFF4DB6AC)],
                      [const Color(0xFFEC407A), const Color(0xFFF06292)],
                      [const Color(0xFF795548), const Color(0xFF8D6E63)],
                      [const Color(0xFF78909C), const Color(0xFF90A4AE)],
                    ];
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: gradients[index],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 4,
                            right: 4,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black45,
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text(
                                'IMG_${1000 + index}',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),

        _rtCaption(
          'All 12 "photos" have identical dimensions computed by '
          'SliverGridRegularTileLayout. The 2px spacing creates '
          'the classic gallery grid look.',
        ),

        _rtDivider(),

        // ================================================================
        // SECTION 13 — Performance Characteristics
        // ================================================================
        _rtSectionHeader(
          '12 · Performance Characteristics',
          subtitle: 'Why uniform grids are O(1) per tile',
        ),
        const SizedBox(height: 8),
        _rtParagraph(
          'Because all tiles are identical, SliverGridRegularTileLayout avoids '
          'any measurement accumulation. Every call to getGeometryForChildIndex '
          'is a constant-time operation — just division and multiplication. '
          'This is why standard grids are so fast even with thousands of items.',
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _rtCream),
          ),
          child: Column(
            children: [
              _rtPerformanceRow(
                'getGeometryForChildIndex',
                'O(1)',
                'Integer divide + multiply',
                _rtForest,
              ),
              const SizedBox(height: 8),
              _rtPerformanceRow(
                'computeMaxScrollOffset',
                'O(1)',
                'One division + multiply',
                _rtForest,
              ),
              const SizedBox(height: 8),
              _rtPerformanceRow(
                'Layout N visible children',
                'O(N)',
                'N × O(1) geometry lookups',
                _rtTeal,
              ),
              const SizedBox(height: 8),
              _rtPerformanceRow(
                'Scroll to any offset',
                'O(1)',
                'Direct index calculation',
                _rtForest,
              ),
            ],
          ),
        ),

        _rtInfoCard(
          'Uniform = predictable',
          'A non-uniform grid (staggered/masonry) might need O(N) to compute '
          'positions because each tile\'s height can differ. '
          'SliverGridRegularTileLayout avoids this entirely because all '
          'tiles share the same geometry template.',
          Icons.speed,
          _rtCoral,
        ),

        _rtDivider(),

        // ================================================================
        // SECTION 14 — Summary
        // ================================================================
        _rtSectionHeader(
          '13 · Summary',
          subtitle: 'Key takeaways about SliverGridRegularTileLayout',
        ),
        const SizedBox(height: 8),

        _rtInfoCard(
          'Sole built-in implementation',
          'SliverGridRegularTileLayout is the only concrete SliverGridLayout '
          'in Flutter. Both FixedCrossAxisCount and MaxCrossAxisExtent '
          'delegates produce it.',
          Icons.apps,
          _rtBronze,
        ),
        _rtInfoCard(
          'Six properties',
          'crossAxisCount, mainAxisStride, crossAxisStride, '
          'childMainAxisExtent, childCrossAxisExtent, reverseCrossAxis. '
          'These six values fully determine the grid.',
          Icons.format_list_numbered,
          _rtTeal,
        ),
        _rtInfoCard(
          'Stride vs. extent',
          'Stride = extent + spacing. The layout stores both so it can '
          'compute positions (stride) and sizes (extent) without recalculation.',
          Icons.straighten,
          _rtAmber,
        ),
        _rtInfoCard(
          'O(1) performance',
          'Index-to-position uses integer division and modulo. '
          'No accumulation, no iteration, no measurement cache needed.',
          Icons.speed,
          _rtForest,
        ),
        _rtInfoCard(
          'RTL support',
          'reverseCrossAxis flips the cross-axis ordering. The scroll axis '
          'direction is unaffected. Driven by TextDirection in the delegate.',
          Icons.flip,
          _rtPlum,
        ),

        const SizedBox(height: 16),

        // Footer badge
        Center(
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_rtDarkBronze, _rtBronze],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'SliverGridRegularTileLayout — Uniform Grid Positioning',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
        ),

        const SizedBox(height: 24),
      ],
    ),
  );
}

// ============================================================================
// Additional helper widgets
// ============================================================================

/// Property info card for section 3.
Widget _rtPropertyCard(
    String name, String type, String description, IconData icon, Color accent) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: accent.withValues(alpha: 0.3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: accent, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      color: accent,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(width: 8),
                  _rtBadge(type, accent.withValues(alpha: 0.15), accent),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  color: _rtCharcoal,
                  fontSize: 12,
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

/// Computation example row for computeMaxScrollOffset.
Widget _rtExampleRow(String label, int childCount, int crossAxisCount,
    double mainAxisStride, double childMainAxisExtent) {
  final rows = (childCount / crossAxisCount).ceil();
  final maxScroll =
      mainAxisStride * rows - (mainAxisStride - childMainAxisExtent);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(
              color: _rtSlate,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          width: 70,
          child: Text(
            '$rows rows',
            style: const TextStyle(color: _rtBronze, fontSize: 12),
          ),
        ),
        const SizedBox(width: 8),
        const Icon(Icons.arrow_forward, size: 12, color: _rtSlate),
        const SizedBox(width: 8),
        Text(
          '${maxScroll.toStringAsFixed(0)} px',
          style: const TextStyle(
            color: _rtCoral,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

/// Performance characteristic row.
Widget _rtPerformanceRow(
    String operation, String complexity, String note, Color color) {
  return Row(
    children: [
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          complexity,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
          ),
        ),
      ),
      const SizedBox(width: 10),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              operation,
              style: const TextStyle(
                color: _rtCharcoal,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              note,
              style: const TextStyle(color: _rtSlate, fontSize: 11),
            ),
          ],
        ),
      ),
    ],
  );
}
