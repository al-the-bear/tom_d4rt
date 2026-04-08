// ignore_for_file: avoid_print
import 'package:flutter/material.dart';

// ============================================================================
// SLIVER GRID LAYOUT — Deep Demo
// ============================================================================
//
// SliverGridLayout is the **abstract interface** that sits between a
// SliverGridDelegate and the RenderSliverGrid render object.  When
// Flutter lays out a grid, the pipeline works like this:
//
//   SliverGridDelegate  ──▶  SliverGridLayout  ──▶  RenderSliverGrid
//        (config)              (positioning)           (painting)
//
// The delegate's getLayout(SliverConstraints) method returns a concrete
// SliverGridLayout.  RenderSliverGrid then calls **two methods** on it:
//
//   1. getGeometryForChildIndex(int index) → SliverGridGeometry
//      Returns the exact position and size of the tile at [index].
//
//   2. computeMaxScrollOffset(int childCount) → double
//      Returns the total scroll extent needed for [childCount] tiles.
//
// Flutter ships two concrete implementations:
//
//   • SliverGridRegularTileLayout  — uniform tiles in a fixed column count
//   • (custom)  — any layout you want, by subclassing SliverGridLayout
//
// This demo illustrates the abstract contract visually, shows how the
// two methods drive grid rendering, contrasts the built-in implementations,
// and builds visual diagrams of index→geometry mapping and the full pipeline.
//
// Color theme : Violet (#5C6BC0)  /  Lavender (#D1C4E9)
// Helper prefix: _gl
// ============================================================================

// ---------------------------------------------------------------------------
// Color palette
// ---------------------------------------------------------------------------
const Color _glViolet = Color(0xFF5C6BC0);
const Color _glLavender = Color(0xFFD1C4E9);
const Color _glDeepViolet = Color(0xFF3949AB);
const Color _glPaleLavender = Color(0xFFEDE7F6);
const Color _glCharcoal = Color(0xFF263238);
const Color _glSlate = Color(0xFF546E7A);
const Color _glTeal = Color(0xFF00897B);
const Color _glAmber = Color(0xFFFFA000);
const Color _glCoral = Color(0xFFEF5350);
const Color _glForest = Color(0xFF2E7D32);
const Color _glSky = Color(0xFF039BE5);
const Color _glPlum = Color(0xFF7B1FA2);
const Color _glRose = Color(0xFFE91E63);
const Color _glIndigo = Color(0xFF283593);
const Color _glOrange = Color(0xFFE65100);

// ---------------------------------------------------------------------------
// Reusable helpers
// ---------------------------------------------------------------------------

/// Section header with gradient background.
Widget _glSectionHeader(String title, {String? subtitle}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    decoration: const BoxDecoration(
      gradient: LinearGradient(
        colors: [_glViolet, _glDeepViolet],
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
Widget _glParagraph(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    child: Text(
      text,
      style: const TextStyle(color: _glCharcoal, fontSize: 14, height: 1.5),
    ),
  );
}

/// Italic caption.
Widget _glCaption(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
    child: Text(
      text,
      style: const TextStyle(
        color: _glSlate,
        fontSize: 13,
        fontStyle: FontStyle.italic,
      ),
    ),
  );
}

/// Label–value row.
Widget _glLabelValue(String label, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 3),
    child: Row(
      children: [
        SizedBox(
          width: 180,
          child: Text(
            label,
            style: const TextStyle(
              color: _glSlate,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              color: valueColor ?? _glViolet,
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
Widget _glInfoCard(String title, String body, IconData icon, Color accent) {
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
                  color: _glCharcoal,
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
Widget _glDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    height: 1,
    color: _glLavender,
  );
}

/// Code-style monospace text block.
Widget _glCodeBlock(String code) {
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

/// Colored chip/badge.
Widget _glBadge(String label, Color bg, Color fg) {
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

/// A small visual grid cell used to build diagrams.
Widget _glDiagramCell(
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
      color: color ?? _glViolet,
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
  print('--- SliverGridLayout Deep Demo ---');
  print('Demonstrating the abstract grid layout interface.');

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
              colors: [_glDeepViolet, _glViolet, Color(0xFF7986CB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'SliverGridLayout',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'The abstract positioning interface for sliver grids',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.85),
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _glBadge('ABSTRACT', _glCoral, Colors.white),
                  const SizedBox(width: 8),
                  _glBadge('rendering.dart', Colors.white24, Colors.white),
                  const SizedBox(width: 8),
                  _glBadge('GRID CORE', _glTeal, Colors.white),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 12),

        // ================================================================
        // SECTION 2 — What is SliverGridLayout?
        // ================================================================
        _glSectionHeader(
          '1 · What Is SliverGridLayout?',
          subtitle: 'The bridge between configuration and rendering',
        ),
        const SizedBox(height: 8),
        _glParagraph(
          'SliverGridLayout is an abstract class in Flutter\'s rendering layer. '
          'It acts as the positioning engine that a SliverGridDelegate produces '
          'and a RenderSliverGrid consumes. Every time Flutter lays out a grid, '
          'the SliverGridDelegate creates a SliverGridLayout, and the render '
          'object asks it "where does tile N go?" and "how much scroll space '
          'is needed?".',
        ),
        _glParagraph(
          'It defines exactly two abstract methods — nothing more, nothing less. '
          'This minimal surface area keeps the contract crystal-clear: any '
          'custom grid layout (staggered, masonry, radial...) can be expressed '
          'by implementing these two methods.',
        ),
        _glInfoCard(
          'Key insight',
          'SliverGridLayout is a strategy object. The delegate is the factory, '
          'the layout is the strategy, and the render object is the consumer. '
          'Swapping delegates swaps layouts at zero cost.',
          Icons.lightbulb_outline,
          _glAmber,
        ),

        _glDivider(),

        // ================================================================
        // SECTION 3 — The Two Abstract Methods
        // ================================================================
        _glSectionHeader(
          '2 · The Two Abstract Methods',
          subtitle: 'getGeometryForChildIndex & computeMaxScrollOffset',
        ),
        const SizedBox(height: 8),
        _glParagraph(
          'The entire SliverGridLayout contract consists of two methods. '
          'Together they are sufficient for RenderSliverGrid to position '
          'every tile and know the total scrollable extent.',
        ),

        // Method 1 card
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _glViolet.withValues(alpha: 0.08),
                _glLavender.withValues(alpha: 0.3),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _glViolet.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.grid_on, color: _glViolet, size: 22),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'getGeometryForChildIndex(int index)',
                      style: TextStyle(
                        color: _glDeepViolet,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Returns a SliverGridGeometry describing the exact position '
                'and size of the tile at the given index. The geometry '
                'specifies scrollOffset, crossAxisOffset, mainAxisExtent, '
                'and crossAxisExtent.',
                style: TextStyle(
                  color: _glCharcoal,
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _glBadge('INPUT', _glViolet, Colors.white),
                  const SizedBox(width: 6),
                  const Text(
                    'int index  (0-based child position)',
                    style: TextStyle(color: _glSlate, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  _glBadge('OUTPUT', _glTeal, Colors.white),
                  const SizedBox(width: 6),
                  const Text(
                    'SliverGridGeometry  (position + size)',
                    style: TextStyle(color: _glSlate, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),

        // Method 2 card
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _glTeal.withValues(alpha: 0.08),
                _glLavender.withValues(alpha: 0.3),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _glTeal.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.straighten, color: _glTeal, size: 22),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text(
                      'computeMaxScrollOffset(int childCount)',
                      style: TextStyle(
                        color: _glTeal,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Returns the maximum scroll offset needed to display all '
                'childCount tiles. The render object uses this to set the '
                'scroll extent of its SliverGeometry, which defines how far '
                'the user can scroll.',
                style: TextStyle(
                  color: _glCharcoal,
                  fontSize: 13,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _glBadge('INPUT', _glTeal, Colors.white),
                  const SizedBox(width: 6),
                  const Text(
                    'int childCount  (total tiles in grid)',
                    style: TextStyle(color: _glSlate, fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  _glBadge('OUTPUT', _glAmber, Colors.white),
                  const SizedBox(width: 6),
                  const Text(
                    'double  (total scrollable pixels)',
                    style: TextStyle(color: _glSlate, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),

        _glCodeBlock(
          'abstract class SliverGridLayout {\n'
          '  const SliverGridLayout();\n'
          '\n'
          '  SliverGridGeometry\n'
          '      getGeometryForChildIndex(int index);\n'
          '\n'
          '  double computeMaxScrollOffset(\n'
          '      int childCount);\n'
          '}',
        ),

        _glCaption(
          'The full class — just a constructor and two abstract methods.',
        ),

        _glDivider(),

        // ================================================================
        // SECTION 4 — Visual: getGeometryForChildIndex Mapping
        // ================================================================
        _glSectionHeader(
          '3 · getGeometryForChildIndex in Action',
          subtitle: 'Mapping child indices to grid positions',
        ),
        const SizedBox(height: 8),
        _glParagraph(
          'When RenderSliverGrid asks for the geometry of child 0, 1, 2, … '
          'the layout returns where each tile lives. For a 3-column grid with '
          '100×100 tiles, the mapping looks like this:',
        ),

        // Visual 3×3 grid mapping
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _glPaleLavender,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _glViolet.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '3-column grid — index → position',
                style: TextStyle(
                  color: _glDeepViolet,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              // Row 0
              Row(
                children: [
                  _glDiagramCell('idx 0\n(0, 0)',
                      color: _glViolet, width: 90, height: 60),
                  const SizedBox(width: 6),
                  _glDiagramCell('idx 1\n(100, 0)',
                      color: _glTeal, width: 90, height: 60),
                  const SizedBox(width: 6),
                  _glDiagramCell('idx 2\n(200, 0)',
                      color: _glAmber,
                      width: 90,
                      height: 60,
                      textColor: _glCharcoal),
                ],
              ),
              const SizedBox(height: 6),
              // Row 1
              Row(
                children: [
                  _glDiagramCell('idx 3\n(0, 100)',
                      color: _glCoral, width: 90, height: 60),
                  const SizedBox(width: 6),
                  _glDiagramCell('idx 4\n(100, 100)',
                      color: _glForest, width: 90, height: 60),
                  const SizedBox(width: 6),
                  _glDiagramCell('idx 5\n(200, 100)',
                      color: _glSky, width: 90, height: 60),
                ],
              ),
              const SizedBox(height: 6),
              // Row 2
              Row(
                children: [
                  _glDiagramCell('idx 6\n(0, 200)',
                      color: _glPlum, width: 90, height: 60),
                  const SizedBox(width: 6),
                  _glDiagramCell('idx 7\n(100, 200)',
                      color: _glRose, width: 90, height: 60),
                  const SizedBox(width: 6),
                  _glDiagramCell('idx 8\n(200, 200)',
                      color: _glIndigo, width: 90, height: 60),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Each cell shows (crossAxisOffset, scrollOffset). '
                'The layout computes these from the index alone.',
                style: TextStyle(color: _glSlate, fontSize: 12),
              ),
            ],
          ),
        ),

        _glCaption(
          'For 3 columns: row = index ~/ 3, col = index % 3. '
          'scrollOffset = row × tileHeight, crossAxisOffset = col × tileWidth.',
        ),

        // Index → geometry table
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _glLavender),
          ),
          child: Column(
            children: [
              // Header row
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                decoration: BoxDecoration(
                  color: _glViolet.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Row(
                  children: [
                    SizedBox(
                      width: 50,
                      child: Text('Index',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: _glDeepViolet)),
                    ),
                    SizedBox(
                      width: 70,
                      child: Text('scroll',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: _glDeepViolet)),
                    ),
                    SizedBox(
                      width: 70,
                      child: Text('cross',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: _glDeepViolet)),
                    ),
                    SizedBox(
                      width: 70,
                      child: Text('main',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: _glDeepViolet)),
                    ),
                    Expanded(
                      child: Text('crossExt',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: _glDeepViolet)),
                    ),
                  ],
                ),
              ),
              // Data rows
              ..._glIndexGeometryRows(),
            ],
          ),
        ),

        _glDivider(),

        // ================================================================
        // SECTION 5 — computeMaxScrollOffset Explained
        // ================================================================
        _glSectionHeader(
          '4 · computeMaxScrollOffset Visualized',
          subtitle: 'Calculating total scrollable extent',
        ),
        const SizedBox(height: 8),
        _glParagraph(
          'The second method tells the render object how many pixels of scroll '
          'space are required. For a regular grid this is simply: '
          'ceil(childCount / crossAxisCount) × (mainAxisExtent + mainAxisSpacing). '
          'For irregular grids it can be more complex.',
        ),

        // Scroll extent diagram
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _glPaleLavender,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _glTeal.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Scroll extent for 10 tiles, 3 columns, 100px tiles + 10px spacing',
                style: TextStyle(
                  color: _glTeal,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              // Visual stacked rows
              _glScrollExtentRow('Row 0', 'tiles 0–2', _glViolet, 100),
              const SizedBox(height: 2),
              Container(
                  height: 10,
                  width: 280,
                  color: _glLavender.withValues(alpha: 0.5)),
              const SizedBox(height: 2),
              _glScrollExtentRow('Row 1', 'tiles 3–5', _glTeal, 100),
              const SizedBox(height: 2),
              Container(
                  height: 10,
                  width: 280,
                  color: _glLavender.withValues(alpha: 0.5)),
              const SizedBox(height: 2),
              _glScrollExtentRow('Row 2', 'tiles 6–8', _glAmber, 100),
              const SizedBox(height: 2),
              Container(
                  height: 10,
                  width: 280,
                  color: _glLavender.withValues(alpha: 0.5)),
              const SizedBox(height: 2),
              _glScrollExtentRow('Row 3', 'tile 9', _glCoral, 100),
              const SizedBox(height: 12),
              _glLabelValue('Rows', 'ceil(10 / 3) = 4'),
              _glLabelValue('Tile height', '100 px'),
              _glLabelValue('Spacing', '10 px'),
              _glLabelValue(
                'Max scroll offset',
                '4 × 100 + 3 × 10 = 430 px',
                valueColor: _glCoral,
              ),
            ],
          ),
        ),

        _glCaption(
          'The max scroll offset ensures the ScrollView knows exactly how '
          'far the user can scroll, even for tiles that are off-screen.',
        ),

        _glDivider(),

        // ================================================================
        // SECTION 6 — Concrete implementation: FixedCrossAxisCount
        // ================================================================
        _glSectionHeader(
          '5 · Fixed Cross-Axis Count Grid',
          subtitle: 'SliverGridDelegateWithFixedCrossAxisCount → SliverGridLayout',
        ),
        const SizedBox(height: 8),
        _glParagraph(
          'The most common delegate is SliverGridDelegateWithFixedCrossAxisCount. '
          'It creates a SliverGridRegularTileLayout where all tiles have '
          'identical dimensions. The crossAxisCount determines how many '
          'columns (or rows in horizontal scroll) the grid has.',
        ),

        // Live grid: 2 columns
        _glCaption('2-column grid — childAspectRatio: 1.5'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          height: 240,
          decoration: BoxDecoration(
            border: Border.all(color: _glViolet.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            padding: const EdgeInsets.all(8),
            itemCount: 6,
            itemBuilder: (context, index) {
              final colors = [
                _glViolet,
                _glTeal,
                _glAmber,
                _glCoral,
                _glForest,
                _glSky,
              ];
              return Container(
                decoration: BoxDecoration(
                  color: colors[index],
                  borderRadius: BorderRadius.circular(8),
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
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'col ${index % 2}, row ${index ~/ 2}',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 12),

        // Live grid: 4 columns square
        _glCaption('4-column grid — childAspectRatio: 1.0 (square tiles)'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: _glTeal.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 1.0,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
            ),
            padding: const EdgeInsets.all(6),
            itemCount: 12,
            itemBuilder: (context, index) {
              final hue = (index * 30.0) % 360;
              return Container(
                decoration: BoxDecoration(
                  color: HSVColor.fromAHSV(1, hue, 0.6, 0.85).toColor(),
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              );
            },
          ),
        ),

        _glInfoCard(
          'Index → position formula',
          'For crossAxisCount = N:\n'
          '  row = index ~/ N\n'
          '  col = index % N\n'
          '  scrollOffset = row × (tileMainAxisExtent + mainAxisSpacing)\n'
          '  crossAxisOffset = col × (tileCrossAxisExtent + crossAxisSpacing)',
          Icons.functions,
          _glViolet,
        ),

        _glDivider(),

        // ================================================================
        // SECTION 7 — Concrete implementation: MaxCrossAxisExtent
        // ================================================================
        _glSectionHeader(
          '6 · Max Cross-Axis Extent Grid',
          subtitle: 'SliverGridDelegateWithMaxCrossAxisExtent → SliverGridLayout',
        ),
        const SizedBox(height: 8),
        _glParagraph(
          'The second built-in delegate, SliverGridDelegateWithMaxCrossAxisExtent, '
          'specifies the maximum width of each tile. Flutter calculates the '
          'actual column count from the available cross-axis space. This makes '
          'grids responsive — narrower viewports get fewer columns automatically.',
        ),

        // Live grid: maxCrossAxisExtent 120
        _glCaption('maxCrossAxisExtent: 120 — tiles adapt to available width'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          height: 250,
          decoration: BoxDecoration(
            border: Border.all(color: _glPlum.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(10),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 120,
              childAspectRatio: 0.85,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            padding: const EdgeInsets.all(8),
            itemCount: 9,
            itemBuilder: (context, index) {
              final icons = [
                Icons.star,
                Icons.favorite,
                Icons.bolt,
                Icons.eco,
                Icons.palette,
                Icons.music_note,
                Icons.camera_alt,
                Icons.pets,
                Icons.local_fire_department,
              ];
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      _glViolet.withValues(alpha: 0.7 + index * 0.03),
                      _glDeepViolet,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icons[index], color: Colors.white, size: 28),
                    const SizedBox(height: 6),
                    Text(
                      'Item $index',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        _glParagraph(
          'The delegate computes crossAxisCount as: '
          '(crossAxisExtent / (maxCrossAxisExtent + crossAxisSpacing)).ceil(). '
          'It then produces a SliverGridRegularTileLayout just like the '
          'fixed-count delegate.',
        ),

        _glInfoCard(
          'Responsive vs. fixed',
          'Use FixedCrossAxisCount when you want an exact number of columns '
          'regardless of screen size. Use MaxCrossAxisExtent when tiles should '
          'maintain a size range and the column count should adapt.',
          Icons.devices,
          _glSky,
        ),

        _glDivider(),

        // ================================================================
        // SECTION 8 — The rendering pipeline diagram
        // ================================================================
        _glSectionHeader(
          '7 · Delegate → Layout → Geometry → Render Pipeline',
          subtitle: 'How SliverGridLayout fits in the big picture',
        ),
        const SizedBox(height: 8),
        _glParagraph(
          'The complete grid rendering pipeline flows through four stages. '
          'SliverGridLayout is the second stage — it translates the delegate\'s '
          'configuration into per-tile positioning data.',
        ),

        // Pipeline diagram
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _glPaleLavender,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: _glViolet.withValues(alpha: 0.3)),
          ),
          child: Column(
            children: [
              // Stage 1
              _glPipelineStage(
                '1. SliverGridDelegate',
                'Configuration (crossAxisCount, spacing, ratio)',
                Icons.settings,
                _glSlate,
              ),
              _glPipelineArrowDown(),
              const Text(
                'getLayout(constraints)',
                style: TextStyle(
                  color: _glSlate,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
              _glPipelineArrowDown(),
              // Stage 2
              _glPipelineStage(
                '2. SliverGridLayout',
                'Positioning engine (index → geometry)',
                Icons.grid_view,
                _glViolet,
              ),
              _glPipelineArrowDown(),
              const Text(
                'getGeometryForChildIndex(i)',
                style: TextStyle(
                  color: _glSlate,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
              _glPipelineArrowDown(),
              // Stage 3
              _glPipelineStage(
                '3. SliverGridGeometry',
                'Per-tile data (offset, extent, constraints)',
                Icons.crop_square,
                _glTeal,
              ),
              _glPipelineArrowDown(),
              const Text(
                'getBoxConstraints()',
                style: TextStyle(
                  color: _glSlate,
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
              _glPipelineArrowDown(),
              // Stage 4
              _glPipelineStage(
                '4. RenderSliverGrid',
                'Paints each child at its computed position',
                Icons.brush,
                _glCoral,
              ),
            ],
          ),
        ),

        _glCaption(
          'SliverGridLayout is the keystone: it holds the mapping logic.',
        ),

        _glDivider(),

        // ================================================================
        // SECTION 9 — Custom Layout Concept
        // ================================================================
        _glSectionHeader(
          '8 · Custom SliverGridLayout Concept',
          subtitle: 'Extending the abstract class for non-uniform grids',
        ),
        const SizedBox(height: 8),
        _glParagraph(
          'While Flutter provides SliverGridRegularTileLayout for uniform grids, '
          'you can create custom layouts by subclassing SliverGridLayout. '
          'A staggered grid, for example, would give different mainAxisExtents '
          'to tiles based on their index.',
        ),

        _glCodeBlock(
          'class StaggeredGridLayout extends SliverGridLayout {\n'
          '  final int crossAxisCount;\n'
          '  final double tileWidth;\n'
          '  final double spacing;\n'
          '\n'
          '  @override\n'
          '  SliverGridGeometry\n'
          '      getGeometryForChildIndex(int index) {\n'
          '    final col = index % crossAxisCount;\n'
          '    final row = index ~/ crossAxisCount;\n'
          '    final height = (index.isEven) ? 120.0 : 80.0;\n'
          '    return SliverGridGeometry(\n'
          '      scrollOffset: row * (120 + spacing),\n'
          '      crossAxisOffset: col * (tileWidth + spacing),\n'
          '      mainAxisExtent: height,\n'
          '      crossAxisExtent: tileWidth,\n'
          '    );\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  double computeMaxScrollOffset(int childCount) {\n'
          '    final rows = (childCount / crossAxisCount).ceil();\n'
          '    return rows * (120 + spacing) - spacing;\n'
          '  }\n'
          '}',
        ),

        _glCaption(
          'A custom layout gives even-indexed tiles more height. '
          'The concept extends naturally to masonry, radial, or angled grids.',
        ),

        // Visual: staggered-like tiles demonstration
        _glParagraph(
          'Below is a visual approximation of what a staggered grid looks like: '
          'tiles of varying heights arranged in columns.',
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _glPaleLavender,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _glViolet.withValues(alpha: 0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Column 0
              Expanded(
                child: Column(
                  children: [
                    _glStaggeredTile('A0', 100, _glViolet),
                    const SizedBox(height: 6),
                    _glStaggeredTile('A1', 65, _glTeal),
                    const SizedBox(height: 6),
                    _glStaggeredTile('A2', 85, _glAmber),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              // Column 1
              Expanded(
                child: Column(
                  children: [
                    _glStaggeredTile('B0', 70, _glCoral),
                    const SizedBox(height: 6),
                    _glStaggeredTile('B1', 95, _glForest),
                    const SizedBox(height: 6),
                    _glStaggeredTile('B2', 75, _glSky),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              // Column 2
              Expanded(
                child: Column(
                  children: [
                    _glStaggeredTile('C0', 85, _glPlum),
                    const SizedBox(height: 6),
                    _glStaggeredTile('C1', 60, _glRose),
                    const SizedBox(height: 6),
                    _glStaggeredTile('C2', 110, _glIndigo),
                  ],
                ),
              ),
            ],
          ),
        ),

        _glInfoCard(
          'Extensibility',
          'The abstract nature of SliverGridLayout means any arrangement is '
          'possible — spiral grids, diagonal flows, variable-density layouts. '
          'The only contract is index→geometry and childCount→maxScroll.',
          Icons.extension,
          _glForest,
        ),

        _glDivider(),

        // ================================================================
        // SECTION 10 — Spacing & Aspect Ratio Effects
        // ================================================================
        _glSectionHeader(
          '9 · Spacing & Aspect Ratio Effects',
          subtitle: 'How delegate parameters change the layout output',
        ),
        const SizedBox(height: 8),
        _glParagraph(
          'The SliverGridLayout produced by a delegate is sensitive to spacing '
          'and aspect ratio parameters. Below we see how changing these '
          'parameters affects the visual output — even though all use the '
          'same abstract interface underneath.',
        ),

        // No spacing grid
        _glCaption('Zero spacing — tiles pack tightly'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          height: 140,
          decoration: BoxDecoration(
            border: Border.all(color: _glCharcoal.withValues(alpha: 0.2)),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              childAspectRatio: 1.0,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
            ),
            padding: EdgeInsets.zero,
            itemCount: 10,
            itemBuilder: (context, index) {
              final hue = (index * 36.0) % 360;
              return Container(
                color: HSVColor.fromAHSV(1, hue, 0.5, 0.9).toColor(),
                alignment: Alignment.center,
                child: Text(
                  '$index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        // Large spacing grid
        _glCaption('Generous spacing — 16px between tiles'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          height: 160,
          decoration: BoxDecoration(
            color: _glPaleLavender,
            border: Border.all(color: _glViolet.withValues(alpha: 0.2)),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1.2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            padding: const EdgeInsets.all(16),
            itemCount: 6,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: _glViolet,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: _glViolet.withValues(alpha: 0.3),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: Text(
                  'S$index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        // Wide aspect ratio grid
        _glCaption('Aspect ratio 3.0 — wide landscape tiles'),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
          height: 120,
          decoration: BoxDecoration(
            border: Border.all(color: _glAmber.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3.0,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            padding: const EdgeInsets.all(8),
            itemCount: 4,
            itemBuilder: (context, index) {
              final colors = [_glAmber, _glCoral, _glForest, _glSky];
              return Container(
                decoration: BoxDecoration(
                  color: colors[index],
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: Text(
                  'Wide tile $index',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),

        _glParagraph(
          'Each of these variations uses the same SliverGridLayout interface. '
          'The delegate controls the configuration; the layout translates it '
          'into per-tile geometry; the render object paints the result.',
        ),

        _glDivider(),

        // ================================================================
        // SECTION 11 — Grid in CustomScrollView
        // ================================================================
        _glSectionHeader(
          '10 · SliverGrid in CustomScrollView',
          subtitle: 'Where SliverGridLayout actually lives at runtime',
        ),
        const SizedBox(height: 8),
        _glParagraph(
          'In practice, SliverGridLayout is used inside a CustomScrollView\'s '
          'SliverGrid widget. The SliverGrid\'s delegate produces the layout '
          'during each layout pass. Here is a SliverGrid alongside a '
          'SliverAppBar and SliverList to show the composability.',
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          height: 350,
          decoration: BoxDecoration(
            border: Border.all(color: _glViolet.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: CustomScrollView(
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              // Pinned header
              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  color: _glDeepViolet,
                  child: const Text(
                    'CustomScrollView with SliverGrid',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // List header
              SliverToBoxAdapter(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  color: _glLavender.withValues(alpha: 0.5),
                  child: const Text(
                    'Header section (SliverToBoxAdapter)',
                    style: TextStyle(color: _glSlate, fontSize: 12),
                  ),
                ),
              ),
              // Grid section
              SliverGrid(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  childAspectRatio: 1.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final gridColors = [
                      _glViolet,
                      _glTeal,
                      _glAmber,
                      _glCoral,
                      _glForest,
                      _glSky,
                      _glPlum,
                      _glRose,
                      _glIndigo,
                    ];
                    return Container(
                      margin: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: gridColors[index % gridColors.length],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'G$index',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    );
                  },
                  childCount: 9,
                ),
              ),
              // Footer
              SliverToBoxAdapter(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  color: _glPaleLavender,
                  child: const Text(
                    'Footer section — the SliverGrid above used '
                    'SliverGridLayout internally to position 9 tiles.',
                    style: TextStyle(color: _glSlate, fontSize: 12),
                  ),
                ),
              ),
            ],
          ),
        ),

        _glCaption(
          'SliverGrid delegates to SliverGridLayout on every layout pass. '
          'The layout object is re-created when constraints change.',
        ),

        _glDivider(),

        // ================================================================
        // SECTION 12 — Comparing Layout Strategies Side by Side
        // ================================================================
        _glSectionHeader(
          '11 · Comparing Layout Strategies Side by Side',
          subtitle: 'Same data, different SliverGridLayout outputs',
        ),
        const SizedBox(height: 8),
        _glParagraph(
          'The same 8 items rendered with different delegate configurations '
          'produce different SliverGridLayout objects, which position tiles '
          'differently. This demonstrates that the layout is a pure function '
          'of the delegate configuration.',
        ),

        // Comparison container
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _glLavender),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Strategy A
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _glViolet.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'A: 2 columns, ratio 1.0',
                  style: TextStyle(
                    color: _glViolet,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 140,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  padding: const EdgeInsets.all(4),
                  itemCount: 8,
                  itemBuilder: (context, i) => Container(
                    decoration: BoxDecoration(
                      color: _glViolet.withValues(alpha: 0.6 + i * 0.05),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$i',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Strategy B
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _glTeal.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'B: 4 columns, ratio 1.0',
                  style: TextStyle(
                    color: _glTeal,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 80,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  padding: const EdgeInsets.all(4),
                  itemCount: 8,
                  itemBuilder: (context, i) => Container(
                    decoration: BoxDecoration(
                      color: _glTeal.withValues(alpha: 0.6 + i * 0.05),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$i',
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Strategy C
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _glAmber.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Text(
                  'C: maxCrossAxisExtent 80, ratio 0.75',
                  style: TextStyle(
                    color: _glOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              SizedBox(
                height: 120,
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate:
                      const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 80,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  padding: const EdgeInsets.all(4),
                  itemCount: 8,
                  itemBuilder: (context, i) => Container(
                    decoration: BoxDecoration(
                      color: _glAmber.withValues(alpha: 0.6 + i * 0.05),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$i',
                      style: const TextStyle(
                          color: _glCharcoal,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        _glCaption(
          'Same 8 items, three different SliverGridLayout outputs. '
          'The layout is a strategy — swap the delegate, swap the strategy.',
        ),

        _glDivider(),

        // ================================================================
        // SECTION 13 — Constraints Flow
        // ================================================================
        _glSectionHeader(
          '12 · How Constraints Flow Through the Layout',
          subtitle: 'SliverConstraints → SliverGridLayout → BoxConstraints',
        ),
        const SizedBox(height: 8),
        _glParagraph(
          'The journey of constraints through a sliver grid involves three '
          'different constraint types. Understanding this flow is key to '
          'understanding why SliverGridLayout exists.',
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _glViolet.withValues(alpha: 0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Step 1
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: _glSlate,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '1',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SliverConstraints arrive',
                          style: TextStyle(
                            color: _glCharcoal,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'crossAxisExtent, scrollOffset, remainingPaintExtent…',
                          style: TextStyle(color: _glSlate, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Step 2
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: _glViolet,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '2',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Delegate creates SliverGridLayout',
                          style: TextStyle(
                            color: _glCharcoal,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'Uses crossAxisExtent to compute tile sizes and column count',
                          style: TextStyle(color: _glSlate, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Step 3
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: _glTeal,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '3',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Layout returns SliverGridGeometry per tile',
                          style: TextStyle(
                            color: _glCharcoal,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'Contains scrollOffset, crossAxisOffset, mainAxisExtent, crossAxisExtent',
                          style: TextStyle(color: _glSlate, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Step 4
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: _glCoral,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '4',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Geometry produces BoxConstraints',
                          style: TextStyle(
                            color: _glCharcoal,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'getBoxConstraints(constraints) → tight width/height for the child',
                          style: TextStyle(color: _glSlate, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Step 5
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: _glForest,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    alignment: Alignment.center,
                    child: const Text(
                      '5',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Child laid out with BoxConstraints',
                          style: TextStyle(
                            color: _glCharcoal,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          'RenderSliverGrid places child at (crossAxisOffset, scrollOffset)',
                          style: TextStyle(color: _glSlate, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        _glInfoCard(
          'Constraint transformation',
          'SliverConstraints → (delegate) → SliverGridLayout → '
          '(per-tile) → SliverGridGeometry → (per-tile) → BoxConstraints. '
          'Three constraint types, one clean pipeline.',
          Icons.transform,
          _glPlum,
        ),

        _glDivider(),

        // ================================================================
        // SECTION 14 — Grid Showcase with Themed Content
        // ================================================================
        _glSectionHeader(
          '13 · Grid Showcase — Themed Content',
          subtitle: 'A real-world scenario driven by SliverGridLayout',
        ),
        const SizedBox(height: 8),
        _glParagraph(
          'A grid of category cards — something you\'d see in any app. '
          'Each card occupies a position calculated by SliverGridLayout. '
          'The gridDelegate → layout → geometry pipeline works invisibly.',
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          height: 320,
          decoration: BoxDecoration(
            border: Border.all(color: _glViolet.withValues(alpha: 0.2)),
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            padding: const EdgeInsets.all(10),
            childAspectRatio: 0.75,
            children: [
              _glCategoryCard('Music', Icons.music_note, _glViolet),
              _glCategoryCard('Photos', Icons.camera_alt, _glTeal),
              _glCategoryCard('Weather', Icons.wb_sunny, _glAmber),
              _glCategoryCard('Health', Icons.favorite, _glCoral),
              _glCategoryCard('Nature', Icons.eco, _glForest),
              _glCategoryCard('Travel', Icons.flight, _glSky),
              _glCategoryCard('Art', Icons.palette, _glPlum),
              _glCategoryCard('Food', Icons.restaurant, _glRose),
              _glCategoryCard('Code', Icons.code, _glIndigo),
            ],
          ),
        ),

        _glCaption(
          'Nine category cards positioned by a 3-column SliverGridLayout. '
          'Each card\'s position is computed from its index.',
        ),

        _glDivider(),

        // ================================================================
        // SECTION 15 — Summary
        // ================================================================
        _glSectionHeader(
          '14 · Summary',
          subtitle: 'Key takeaways about SliverGridLayout',
        ),
        const SizedBox(height: 8),

        _glInfoCard(
          'Abstract contract',
          'SliverGridLayout defines exactly two methods: '
          'getGeometryForChildIndex(index) and computeMaxScrollOffset(childCount). '
          'This minimal interface is sufficient for any grid arrangement.',
          Icons.architecture,
          _glViolet,
        ),
        _glInfoCard(
          'Strategy pattern',
          'The delegate is the factory, the layout is the strategy, and '
          'RenderSliverGrid is the consumer. Swapping delegates swaps '
          'entire grid layouts transparently.',
          Icons.swap_horiz,
          _glTeal,
        ),
        _glInfoCard(
          'Built-in implementation',
          'SliverGridRegularTileLayout handles uniform grids. '
          'Both FixedCrossAxisCount and MaxCrossAxisExtent delegates '
          'produce this same layout type with different parameters.',
          Icons.grid_view,
          _glAmber,
        ),
        _glInfoCard(
          'Extensibility',
          'Custom SliverGridLayout subclasses enable staggered, masonry, '
          'radial, or any non-uniform grid arrangement.',
          Icons.extension,
          _glForest,
        ),
        _glInfoCard(
          'Constraint pipeline',
          'SliverConstraints → SliverGridLayout → SliverGridGeometry → '
          'BoxConstraints. The layout sits at the heart of this transformation.',
          Icons.linear_scale,
          _glCoral,
        ),

        const SizedBox(height: 16),

        // Footer badge
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [_glDeepViolet, _glViolet],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'SliverGridLayout — The Grid Positioning Engine',
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

/// Generates index-to-geometry table data rows for a 3-column, 100×100 grid.
List<Widget> _glIndexGeometryRows() {
  final data = <Map<String, String>>[];
  for (int i = 0; i < 9; i++) {
    final row = i ~/ 3;
    final col = i % 3;
    data.add({
      'index': '$i',
      'scroll': '${row * 100}.0',
      'cross': '${col * 100}.0',
      'main': '100.0',
      'crossExt': '100.0',
    });
  }

  final colors = [
    _glViolet,
    _glTeal,
    _glAmber,
    _glCoral,
    _glForest,
    _glSky,
    _glPlum,
    _glRose,
    _glIndigo,
  ];

  return data.asMap().entries.map((entry) {
    final idx = entry.key;
    final d = entry.value;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      decoration: BoxDecoration(
        color: idx.isEven
            ? _glPaleLavender.withValues(alpha: 0.5)
            : Colors.white,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Row(
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: colors[idx],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 6),
                Text(d['index']!,
                    style: const TextStyle(fontSize: 12, color: _glCharcoal)),
              ],
            ),
          ),
          SizedBox(
            width: 70,
            child: Text(d['scroll']!,
                style: const TextStyle(
                    fontSize: 12,
                    color: _glViolet,
                    fontFamily: 'monospace')),
          ),
          SizedBox(
            width: 70,
            child: Text(d['cross']!,
                style: const TextStyle(
                    fontSize: 12,
                    color: _glTeal,
                    fontFamily: 'monospace')),
          ),
          SizedBox(
            width: 70,
            child: Text(d['main']!,
                style: const TextStyle(
                    fontSize: 12,
                    color: _glAmber,
                    fontFamily: 'monospace')),
          ),
          Expanded(
            child: Text(d['crossExt']!,
                style: const TextStyle(
                    fontSize: 12,
                    color: _glCoral,
                    fontFamily: 'monospace')),
          ),
        ],
      ),
    );
  }).toList();
}

/// Scroll extent row for the diagram.
Widget _glScrollExtentRow(
    String label, String sublabel, Color color, double height) {
  return Row(
    children: [
      SizedBox(
        width: 60,
        child: Text(
          label,
          style: const TextStyle(
            color: _glCharcoal,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 30,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Text(
            sublabel,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      const SizedBox(width: 8),
      Text(
        '${height.toInt()}px',
        style: const TextStyle(
          color: _glSlate,
          fontSize: 11,
          fontFamily: 'monospace',
        ),
      ),
    ],
  );
}

/// Pipeline stage box.
Widget _glPipelineStage(
    String title, String subtitle, IconData icon, Color color) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.12),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: color.withValues(alpha: 0.4)),
    ),
    child: Row(
      children: [
        Icon(icon, color: color, size: 22),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(color: _glSlate, fontSize: 11),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

/// Downward arrow for pipeline.
Widget _glPipelineArrowDown() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 3),
    child: Icon(Icons.arrow_downward, color: _glSlate, size: 18),
  );
}

/// Staggered tile for the custom layout concept section.
Widget _glStaggeredTile(String label, double height, Color color) {
  return Container(
    height: height,
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    alignment: Alignment.center,
    child: Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
    ),
  );
}

/// Category card for the themed content showcase.
Widget _glCategoryCard(String title, IconData icon, Color color) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [color, color.withValues(alpha: 0.7)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.3),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Colors.white, size: 32),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
      ],
    ),
  );
}
