// D4rt deep-demo: TwoDimensionalChildListDelegate — Mosaic Tile Wall.
//
// TwoDimensionalChildListDelegate stores a preloaded `List<List<Widget>>`
// and hands tiles to a TwoDimensionalViewport as-is — no lazy builder, no
// index math at render time, no surprises. That preloaded shape is a
// perfect fit for small, curated 2D content where every cell is known up
// front: mosaic grids, layout boards, palette pickers, crossword-like
// puzzles, product catalogs paginated client-side.
//
// This demo frames the delegate inside a ceramic / terracotta "Mosaic Tile
// Wall" studio. Users swap between four historic patterns (Andalusian,
// Moroccan, Byzantine, Art Deco), compare all four side-by-side, inspect
// a tapped ChildVicinity, and toggle `addRepaintBoundaries` /
// `addAutomaticKeepAlives` to read narrated performance trade-offs.
//
// The viewport scaffolding — `_TwoDListTableView`, `_TwoDListTableViewport`
// and `_TwoDListTableRender` — is a minimal hand-written
// TwoDimensionalScrollView/TwoDimensionalViewport/RenderTwoDimensionalViewport
// triple: fixed-size children, window-computed from scroll offsets. It is
// intentionally authored from scratch (not copy-pasted from the SDK doc)
// so the harness exercises the real element/render pipeline for the
// delegate under test.

import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// ---------------------------------------------------------------------------
// Palette — terracotta, ceramic cream, glaze teal.
// ---------------------------------------------------------------------------

const Color _kTerracotta = Color(0xFFC65D3C);
const Color _kTerracottaDeep = Color(0xFF8E3B22);
const Color _kCeramic = Color(0xFFF7ECD7);
const Color _kCeramicWarm = Color(0xFFE9D8B8);
const Color _kGlazeTeal = Color(0xFF2E7D7D);
const Color _kGlazeTealDeep = Color(0xFF174F4F);
const Color _kInk = Color(0xFF2E241B);
const Color _kInkSoft = Color(0xFF5A4A3B);
const Color _kGold = Color(0xFFBF8A3D);
const Color _kCobalt = Color(0xFF2F4E8C);

// ---------------------------------------------------------------------------
// Entry point — d4rt expects a top-level `build(BuildContext)`.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  debugPrint('TwoDimensionalChildListDelegate deep demo: booting mosaic wall');
  return const _TwoDListMosaicApp();
}

class _TwoDListMosaicApp extends StatelessWidget {
  const _TwoDListMosaicApp();

  @override
  Widget build(BuildContext context) {
    final ThemeData base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: _kCeramic,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _kTerracotta,
        brightness: Brightness.light,
        primary: _kTerracotta,
        secondary: _kGlazeTeal,
        surface: _kCeramicWarm,
      ),
      fontFamily: 'Georgia',
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: _kInk, fontWeight: FontWeight.w700),
        titleMedium: TextStyle(color: _kInk, fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(color: _kInkSoft, height: 1.45),
        labelMedium: TextStyle(color: _kGlazeTealDeep, fontWeight: FontWeight.w600),
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mosaic Tile Wall — TwoDimensionalChildListDelegate',
      theme: base,
      home: const _MosaicHome(),
    );
  }
}

// ---------------------------------------------------------------------------
// Pattern catalog.
// ---------------------------------------------------------------------------

enum _MosaicPattern { andalusian, moroccan, byzantine, artDeco }

class _PatternSpec {
  const _PatternSpec({
    required this.pattern,
    required this.label,
    required this.subtitle,
    required this.era,
    required this.region,
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.synopsis,
  });

  final _MosaicPattern pattern;
  final String label;
  final String subtitle;
  final String era;
  final String region;
  final Color primary;
  final Color secondary;
  final Color accent;
  final String synopsis;
}

const List<_PatternSpec> _kPatternCatalog = <_PatternSpec>[
  _PatternSpec(
    pattern: _MosaicPattern.andalusian,
    label: 'Andalusian',
    subtitle: 'Hexagon flower tessellation',
    era: '14th century',
    region: 'Granada, Al-Andalus',
    primary: _kTerracotta,
    secondary: _kCeramic,
    accent: _kGlazeTeal,
    synopsis: 'Interlocking hexagons with a six-petal rosette centerpiece — '
        'each tile a miniature garden, repeated across the plaster wall.',
  ),
  _PatternSpec(
    pattern: _MosaicPattern.moroccan,
    label: 'Moroccan',
    subtitle: 'Star-and-cross zellij',
    era: '12th century',
    region: 'Fez, Morocco',
    primary: _kGlazeTeal,
    secondary: _kCeramic,
    accent: _kGold,
    synopsis: 'Eight-pointed stars lock into crosses, woven by a strict '
        'ruler-and-compass geometry into infinite zellij lattices.',
  ),
  _PatternSpec(
    pattern: _MosaicPattern.byzantine,
    label: 'Byzantine',
    subtitle: 'Cross-in-square tessera',
    era: '6th century',
    region: 'Constantinople',
    primary: _kCobalt,
    secondary: _kCeramicWarm,
    accent: _kGold,
    synopsis: 'Dense gold-leaf tesserae framing a cobalt cross, echoing the '
        'apses of Hagia Sophia and Ravenna.',
  ),
  _PatternSpec(
    pattern: _MosaicPattern.artDeco,
    label: 'Art Deco',
    subtitle: 'Stepped chevron medallion',
    era: '1920s',
    region: 'Paris & Manhattan',
    primary: _kTerracottaDeep,
    secondary: _kGold,
    accent: _kGlazeTealDeep,
    synopsis: 'Sunburst chevrons stepping out from a lacquered medallion, '
        'machined symmetry for the jazz age.',
  ),
];

_PatternSpec _specFor(_MosaicPattern p) =>
    _kPatternCatalog.firstWhere((s) => s.pattern == p);

// ---------------------------------------------------------------------------
// Mosaic home — stateful coordinator.
// ---------------------------------------------------------------------------

class _MosaicHome extends StatefulWidget {
  const _MosaicHome();

  @override
  State<_MosaicHome> createState() => _MosaicHomeState();
}

class _MosaicHomeState extends State<_MosaicHome> {
  _MosaicPattern _active = _MosaicPattern.andalusian;
  int _rows = 10;
  int _cols = 6;
  bool _addRepaintBoundaries = true;
  bool _addAutomaticKeepAlives = true;
  bool _showCoords = false;
  _TwoDListInspection? _inspected;

  @override
  Widget build(BuildContext context) {
    final _PatternSpec spec = _specFor(_active);
    return Scaffold(
      backgroundColor: _kCeramic,
      appBar: _MosaicAppBar(spec: spec),
      body: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints constraints) {
          final bool wide = constraints.maxWidth >= 1080;
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const _PreambleCard(),
                const SizedBox(height: 18),
                _PatternSwitcher(
                  active: _active,
                  onSelect: (_MosaicPattern p) {
                    setState(() {
                      _active = p;
                      _inspected = null;
                    });
                    debugPrint('Mosaic: pattern -> ${p.name}');
                  },
                ),
                const SizedBox(height: 18),
                if (wide)
                  _WideMainLayout(
                    spec: spec,
                    rows: _rows,
                    cols: _cols,
                    addRepaintBoundaries: _addRepaintBoundaries,
                    addAutomaticKeepAlives: _addAutomaticKeepAlives,
                    showCoords: _showCoords,
                    inspected: _inspected,
                    onInspect: _handleInspect,
                  )
                else
                  _NarrowMainLayout(
                    spec: spec,
                    rows: _rows,
                    cols: _cols,
                    addRepaintBoundaries: _addRepaintBoundaries,
                    addAutomaticKeepAlives: _addAutomaticKeepAlives,
                    showCoords: _showCoords,
                    inspected: _inspected,
                    onInspect: _handleInspect,
                  ),
                const SizedBox(height: 22),
                _DimensionsPanel(
                  rows: _rows,
                  cols: _cols,
                  onRows: (double v) => setState(() => _rows = v.round()),
                  onCols: (double v) => setState(() => _cols = v.round()),
                ),
                const SizedBox(height: 18),
                _FlagsPanel(
                  addRepaintBoundaries: _addRepaintBoundaries,
                  addAutomaticKeepAlives: _addAutomaticKeepAlives,
                  showCoords: _showCoords,
                  onRepaint: (bool v) =>
                      setState(() => _addRepaintBoundaries = v),
                  onKeepAlive: (bool v) =>
                      setState(() => _addAutomaticKeepAlives = v),
                  onShowCoords: (bool v) => setState(() => _showCoords = v),
                ),
                const SizedBox(height: 18),
                const _ComparisonStrip(),
                const SizedBox(height: 18),
                _AnatomyCard(spec: spec),
                const SizedBox(height: 18),
                const _EpilogueCard(),
                const SizedBox(height: 18),
                const _DelegateSnippetCard(),
              ],
            ),
          );
        },
      ),
    );
  }

  void _handleInspect(_TwoDListInspection info) {
    setState(() => _inspected = info);
    debugPrint('Mosaic: inspected ${info.vicinity} (${info.widgetTypeName})');
  }
}

// ---------------------------------------------------------------------------
// Inspection model — plain data passed back from tiles.
// ---------------------------------------------------------------------------

class _TwoDListInspection {
  const _TwoDListInspection({
    required this.vicinity,
    required this.widgetTypeName,
    required this.patternLabel,
    required this.glyph,
  });

  final ChildVicinity vicinity;
  final String widgetTypeName;
  final String patternLabel;
  final String glyph;
}

// ---------------------------------------------------------------------------
// App bar.
// ---------------------------------------------------------------------------

class _MosaicAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _MosaicAppBar({required this.spec});
  final _PatternSpec spec;

  @override
  Size get preferredSize => const Size.fromHeight(84);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 0,
      color: _kCeramicWarm,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 14, 22, 14),
          child: Row(
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: spec.primary,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: _kInk.withValues(alpha: 0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: CustomPaint(
                  painter: _AppBarCrestPainter(spec: spec),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Mosaic Tile Wall',
                      style: TextStyle(
                        color: _kInk,
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.4,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'TwoDimensionalChildListDelegate — ${spec.label}',
                      style: const TextStyle(
                        color: _kInkSoft,
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              _AppBarBadge(label: spec.era, tint: spec.accent),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppBarBadge extends StatelessWidget {
  const _AppBarBadge({required this.label, required this.tint});
  final String label;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.15),
        border: Border.all(color: tint.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: tint,
          fontWeight: FontWeight.w700,
          fontSize: 12,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

class _AppBarCrestPainter extends CustomPainter {
  _AppBarCrestPainter({required this.spec});
  final _PatternSpec spec;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = spec.primary;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
          Offset.zero & size, const Radius.circular(14)),
      bg,
    );
    final Paint petal = Paint()..color = spec.secondary;
    final Offset center = size.center(Offset.zero);
    final double r = size.shortestSide * 0.32;
    for (int i = 0; i < 6; i++) {
      final double a = i * math.pi / 3;
      final Offset p = Offset(
        center.dx + r * math.cos(a),
        center.dy + r * math.sin(a),
      );
      canvas.drawCircle(p, r * 0.55, petal);
    }
    canvas.drawCircle(center, r * 0.4, Paint()..color = spec.accent);
  }

  @override
  bool shouldRepaint(covariant _AppBarCrestPainter old) =>
      old.spec.pattern != spec.pattern;
}

// ---------------------------------------------------------------------------
// Preamble card.
// ---------------------------------------------------------------------------

class _PreambleCard extends StatelessWidget {
  const _PreambleCard();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'List delegate vs. Builder delegate',
      subtitle: 'When to pick the preloaded one',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _BulletLine(
            glyph: '◆',
            text:
                'TwoDimensionalChildListDelegate takes a finished List<List<Widget>>: '
                'you pay the widget construction cost up front, then every tile '
                'is fetched by `children[y][x]` — no callback churn.',
          ),
          _BulletLine(
            glyph: '◆',
            text:
                'TwoDimensionalChildBuilderDelegate takes a callback and maxIndex '
                'counts: ideal for millions of cells, wasteful for a 6x10 '
                'mosaic you already have in memory.',
          ),
          _BulletLine(
            glyph: '◆',
            text:
                'Rule of thumb: if the number of tiles fits comfortably in RAM and '
                'you know them at layout time, reach for the list delegate. '
                'If the grid is unbounded or driven by a stream, reach for the builder.',
          ),
        ],
      ),
    );
  }
}

class _BulletLine extends StatelessWidget {
  const _BulletLine({required this.glyph, required this.text});
  final String glyph;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(glyph,
              style: const TextStyle(color: _kTerracotta, fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: _kInkSoft, height: 1.45),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Pattern switcher (filter chips).
// ---------------------------------------------------------------------------

class _PatternSwitcher extends StatelessWidget {
  const _PatternSwitcher({required this.active, required this.onSelect});
  final _MosaicPattern active;
  final ValueChanged<_MosaicPattern> onSelect;

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Pattern switcher',
      subtitle: 'Each chip rebuilds the delegate with a different 2D list',
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: <Widget>[
          for (final _PatternSpec spec in _kPatternCatalog)
            _PatternChip(
              spec: spec,
              selected: spec.pattern == active,
              onTap: () => onSelect(spec.pattern),
            ),
        ],
      ),
    );
  }
}

class _PatternChip extends StatelessWidget {
  const _PatternChip({
    required this.spec,
    required this.selected,
    required this.onTap,
  });

  final _PatternSpec spec;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? spec.primary : _kCeramicWarm,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: selected
              ? spec.primary
              : _kInkSoft.withValues(alpha: 0.25),
          width: 1.2,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: spec.secondary,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: CustomPaint(
                  painter: _ChipGlyphPainter(spec: spec),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    spec.label,
                    style: TextStyle(
                      color: selected ? _kCeramic : _kInk,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    spec.subtitle,
                    style: TextStyle(
                      color: selected
                          ? _kCeramic.withValues(alpha: 0.85)
                          : _kInkSoft,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChipGlyphPainter extends CustomPainter {
  _ChipGlyphPainter({required this.spec});
  final _PatternSpec spec;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = spec.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final Offset c = size.center(Offset.zero);
    switch (spec.pattern) {
      case _MosaicPattern.andalusian:
        canvas.drawCircle(c, size.shortestSide * 0.25, p);
        canvas.drawCircle(c, size.shortestSide * 0.42, p);
        break;
      case _MosaicPattern.moroccan:
        final Path star = Path();
        for (int i = 0; i < 8; i++) {
          final double a = i * math.pi / 4;
          final double r =
              (i.isEven ? size.shortestSide * 0.42 : size.shortestSide * 0.2);
          final Offset pt = Offset(c.dx + r * math.cos(a), c.dy + r * math.sin(a));
          if (i == 0) {
            star.moveTo(pt.dx, pt.dy);
          } else {
            star.lineTo(pt.dx, pt.dy);
          }
        }
        star.close();
        canvas.drawPath(star, p);
        break;
      case _MosaicPattern.byzantine:
        canvas.drawLine(Offset(c.dx, size.height * 0.15),
            Offset(c.dx, size.height * 0.85), p);
        canvas.drawLine(Offset(size.width * 0.15, c.dy),
            Offset(size.width * 0.85, c.dy), p);
        break;
      case _MosaicPattern.artDeco:
        for (int i = 0; i < 3; i++) {
          final double t = (i + 1) / 4;
          final Path chevron = Path()
            ..moveTo(size.width * 0.15, size.height * (1 - t))
            ..lineTo(c.dx, size.height * (1 - t) - size.height * 0.1)
            ..lineTo(size.width * 0.85, size.height * (1 - t));
          canvas.drawPath(chevron, p);
        }
        break;
    }
  }

  @override
  bool shouldRepaint(covariant _ChipGlyphPainter old) =>
      old.spec.pattern != spec.pattern;
}

// ---------------------------------------------------------------------------
// Main layout — wide vs narrow.
// ---------------------------------------------------------------------------

class _WideMainLayout extends StatelessWidget {
  const _WideMainLayout({
    required this.spec,
    required this.rows,
    required this.cols,
    required this.addRepaintBoundaries,
    required this.addAutomaticKeepAlives,
    required this.showCoords,
    required this.inspected,
    required this.onInspect,
  });

  final _PatternSpec spec;
  final int rows;
  final int cols;
  final bool addRepaintBoundaries;
  final bool addAutomaticKeepAlives;
  final bool showCoords;
  final _TwoDListInspection? inspected;
  final ValueChanged<_TwoDListInspection> onInspect;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: _MosaicWallPanel(
              spec: spec,
              rows: rows,
              cols: cols,
              addRepaintBoundaries: addRepaintBoundaries,
              addAutomaticKeepAlives: addAutomaticKeepAlives,
              showCoords: showCoords,
              onInspect: onInspect,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            flex: 2,
            child: _InspectorPanel(
              spec: spec,
              rows: rows,
              cols: cols,
              inspection: inspected,
            ),
          ),
        ],
      ),
    );
  }
}

class _NarrowMainLayout extends StatelessWidget {
  const _NarrowMainLayout({
    required this.spec,
    required this.rows,
    required this.cols,
    required this.addRepaintBoundaries,
    required this.addAutomaticKeepAlives,
    required this.showCoords,
    required this.inspected,
    required this.onInspect,
  });

  final _PatternSpec spec;
  final int rows;
  final int cols;
  final bool addRepaintBoundaries;
  final bool addAutomaticKeepAlives;
  final bool showCoords;
  final _TwoDListInspection? inspected;
  final ValueChanged<_TwoDListInspection> onInspect;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _MosaicWallPanel(
          spec: spec,
          rows: rows,
          cols: cols,
          addRepaintBoundaries: addRepaintBoundaries,
          addAutomaticKeepAlives: addAutomaticKeepAlives,
          showCoords: showCoords,
          onInspect: onInspect,
        ),
        const SizedBox(height: 18),
        _InspectorPanel(
          spec: spec,
          rows: rows,
          cols: cols,
          inspection: inspected,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Mosaic wall panel — the primary deep-demo surface.
// ---------------------------------------------------------------------------

class _MosaicWallPanel extends StatelessWidget {
  const _MosaicWallPanel({
    required this.spec,
    required this.rows,
    required this.cols,
    required this.addRepaintBoundaries,
    required this.addAutomaticKeepAlives,
    required this.showCoords,
    required this.onInspect,
  });

  final _PatternSpec spec;
  final int rows;
  final int cols;
  final bool addRepaintBoundaries;
  final bool addAutomaticKeepAlives;
  final bool showCoords;
  final ValueChanged<_TwoDListInspection> onInspect;

  @override
  Widget build(BuildContext context) {
    final List<List<Widget>> matrix = _buildMatrix(
      spec: spec,
      rows: rows,
      cols: cols,
      showCoords: showCoords,
      tileSize: _TwoDListTableRender.kTileSize,
      onInspect: onInspect,
    );
    final TwoDimensionalChildListDelegate delegate =
        TwoDimensionalChildListDelegate(
      addRepaintBoundaries: addRepaintBoundaries,
      addAutomaticKeepAlives: addAutomaticKeepAlives,
      children: matrix,
    );
    return _SectionShell(
      title: 'Primary mosaic wall',
      subtitle:
          '$cols × $rows tiles · pattern ${spec.label} · ${matrix.length * (matrix.isEmpty ? 0 : matrix.first.length)} cells preloaded',
      trailing: _LivePatternPill(spec: spec),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: _kCeramicWarm,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: spec.primary.withValues(alpha: 0.4),
                width: 1.5,
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _kInk.withValues(alpha: 0.08),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.all(12),
            child: SizedBox(
              height: 420,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: _TwoDListTableView(
                  delegate: delegate,
                  background: spec.secondary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            spec.synopsis,
            style: const TextStyle(
              color: _kInkSoft,
              fontStyle: FontStyle.italic,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _LivePatternPill extends StatelessWidget {
  const _LivePatternPill({required this.spec});
  final _PatternSpec spec;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: spec.primary.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: spec.primary.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: spec.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '${spec.region} · ${spec.era}',
            style: TextStyle(
              color: spec.primary,
              fontWeight: FontWeight.w700,
              fontSize: 11,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Inspector panel — reveals the tapped ChildVicinity.
// ---------------------------------------------------------------------------

class _InspectorPanel extends StatelessWidget {
  const _InspectorPanel({
    required this.spec,
    required this.rows,
    required this.cols,
    required this.inspection,
  });

  final _PatternSpec spec;
  final int rows;
  final int cols;
  final _TwoDListInspection? inspection;

  @override
  Widget build(BuildContext context) {
    final _TwoDListInspection? info = inspection;
    return _SectionShell(
      title: 'Tile inspector',
      subtitle: 'Tap a tile to read its ChildVicinity metadata',
      trailing: Icon(Icons.search, color: spec.accent, size: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _kCeramic,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: spec.accent.withValues(alpha: 0.35)),
            ),
            child: info == null
                ? const _InspectorEmpty()
                : _InspectorFilled(info: info, spec: spec),
          ),
          const SizedBox(height: 14),
          _InspectorStat(label: 'Rows in children[]', value: '$rows'),
          _InspectorStat(label: 'Cols in children[y][]', value: '$cols'),
          _InspectorStat(
            label: 'Total cells',
            value: '${rows * cols}',
          ),
          _InspectorStat(
            label: 'Delegate contract',
            value: 'children[yIndex][xIndex]',
          ),
          const SizedBox(height: 12),
          const _InspectorNarrative(),
        ],
      ),
    );
  }
}

class _InspectorEmpty extends StatelessWidget {
  const _InspectorEmpty();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const <Widget>[
        Icon(Icons.touch_app, color: _kGlazeTeal),
        SizedBox(width: 10),
        Expanded(
          child: Text(
            'Tap any tile in the mosaic wall. The inspector will report '
            'its ChildVicinity (xIndex, yIndex) and the widget type the '
            'delegate handed back from children[y][x].',
            style: TextStyle(color: _kInkSoft, height: 1.45),
          ),
        ),
      ],
    );
  }
}

class _InspectorFilled extends StatelessWidget {
  const _InspectorFilled({required this.info, required this.spec});
  final _TwoDListInspection info;
  final _PatternSpec spec;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: spec.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Text(
                info.glyph,
                style: TextStyle(
                  color: spec.primary,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'ChildVicinity(x: ${info.vicinity.xIndex}, y: ${info.vicinity.yIndex})',
                    style: const TextStyle(
                      color: _kInk,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    '${info.patternLabel} · ${info.widgetTypeName}',
                    style: const TextStyle(
                      color: _kInkSoft,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          'Accessed as children[${info.vicinity.yIndex}][${info.vicinity.xIndex}] '
          'by the delegate at build time.',
          style: const TextStyle(color: _kInkSoft, height: 1.35),
        ),
      ],
    );
  }
}

class _InspectorStat extends StatelessWidget {
  const _InspectorStat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: _kInkSoft, fontSize: 12),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: _kInk,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _InspectorNarrative extends StatelessWidget {
  const _InspectorNarrative();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kGlazeTeal.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kGlazeTeal.withValues(alpha: 0.2)),
      ),
      child: const Text(
        'Because the delegate stores the finished widget list, lookup is O(1). '
        'There is no build callback, no cache miss, no async backing store — '
        'the cell is whichever Widget the author stuffed into children[y][x].',
        style: TextStyle(color: _kInkSoft, height: 1.4, fontSize: 12.5),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Dimensions panel — sliders for rows and cols.
// ---------------------------------------------------------------------------

class _DimensionsPanel extends StatelessWidget {
  const _DimensionsPanel({
    required this.rows,
    required this.cols,
    required this.onRows,
    required this.onCols,
  });

  final int rows;
  final int cols;
  final ValueChanged<double> onRows;
  final ValueChanged<double> onCols;

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Grid dimensions',
      subtitle: 'Each change rebuilds children[][] — delegate shouldRebuild: true',
      child: Column(
        children: <Widget>[
          _DimensionSlider(
            label: 'Rows (yIndex range)',
            value: rows.toDouble(),
            min: 4,
            max: 16,
            divisions: 12,
            onChanged: onRows,
          ),
          const SizedBox(height: 6),
          _DimensionSlider(
            label: 'Columns (xIndex range)',
            value: cols.toDouble(),
            min: 3,
            max: 10,
            divisions: 7,
            onChanged: onCols,
          ),
        ],
      ),
    );
  }
}

class _DimensionSlider extends StatelessWidget {
  const _DimensionSlider({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.divisions,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double min;
  final double max;
  final int divisions;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 180,
          child: Text(
            label,
            style: const TextStyle(color: _kInk, fontWeight: FontWeight.w600),
          ),
        ),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: _kTerracotta,
              thumbColor: _kTerracottaDeep,
              overlayColor: _kTerracotta.withValues(alpha: 0.2),
              inactiveTrackColor: _kCeramicWarm,
              valueIndicatorColor: _kTerracottaDeep,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              divisions: divisions,
              label: value.round().toString(),
              onChanged: onChanged,
            ),
          ),
        ),
        SizedBox(
          width: 36,
          child: Text(
            value.round().toString(),
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: _kInk,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Flags panel — repaintBoundaries / keepAlives / coord overlay.
// ---------------------------------------------------------------------------

class _FlagsPanel extends StatelessWidget {
  const _FlagsPanel({
    required this.addRepaintBoundaries,
    required this.addAutomaticKeepAlives,
    required this.showCoords,
    required this.onRepaint,
    required this.onKeepAlive,
    required this.onShowCoords,
  });

  final bool addRepaintBoundaries;
  final bool addAutomaticKeepAlives;
  final bool showCoords;
  final ValueChanged<bool> onRepaint;
  final ValueChanged<bool> onKeepAlive;
  final ValueChanged<bool> onShowCoords;

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Delegate flags & overlays',
      subtitle: 'Read the effect narration beside each switch',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _FlagRow(
            label: 'addRepaintBoundaries',
            value: addRepaintBoundaries,
            onChanged: onRepaint,
            narration: addRepaintBoundaries
                ? 'ON — each tile is wrapped in a RepaintBoundary. Scroll '
                    'repaints stay local; heavy tile painters do not invalidate '
                    'neighbours.'
                : 'OFF — no RepaintBoundary per tile. Animations in one tile '
                    'can force repainting of the whole visible window.',
            activeColor: _kGlazeTeal,
          ),
          _FlagRow(
            label: 'addAutomaticKeepAlives',
            value: addAutomaticKeepAlives,
            onChanged: onKeepAlive,
            narration: addAutomaticKeepAlives
                ? 'ON — scrolled-off tiles with keep-alive clients (e.g. '
                    'Checkboxes, text fields) retain state across rebuilds.'
                : 'OFF — children are disposed the moment they exit the '
                    'visible area. Local state in a scrolled-off tile is gone.',
            activeColor: _kTerracotta,
          ),
          _FlagRow(
            label: 'Show tile coordinates',
            value: showCoords,
            onChanged: onShowCoords,
            narration: showCoords
                ? 'ON — each tile prints its (x, y) vicinity. Handy for '
                    'debugging how the delegate maps children[y][x].'
                : 'OFF — the wall shows only the decorative motif.',
            activeColor: _kCobalt,
          ),
        ],
      ),
    );
  }
}

class _FlagRow extends StatelessWidget {
  const _FlagRow({
    required this.label,
    required this.value,
    required this.onChanged,
    required this.narration,
    required this.activeColor,
  });

  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  final String narration;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCeramic,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: activeColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Switch(
            value: value,
            activeThumbColor: activeColor,
            activeTrackColor: activeColor.withValues(alpha: 0.4),
            onChanged: onChanged,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: TextStyle(
                    color: activeColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  narration,
                  style: const TextStyle(
                    color: _kInkSoft,
                    height: 1.4,
                    fontSize: 12.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Comparison strip — four delegates side-by-side in mini viewports.
// ---------------------------------------------------------------------------

class _ComparisonStrip extends StatelessWidget {
  const _ComparisonStrip();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Pattern comparison strip',
      subtitle: 'Four independent TwoDimensionalChildListDelegate instances, '
          'one mini viewport each — purely for eyeballing the motifs',
      child: SizedBox(
        height: 220,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: _kPatternCatalog.length,
          separatorBuilder: (BuildContext _, int _) =>
              const SizedBox(width: 14),
          itemBuilder: (BuildContext ctx, int i) {
            final _PatternSpec spec = _kPatternCatalog[i];
            return _MiniViewportCard(spec: spec);
          },
        ),
      ),
    );
  }
}

class _MiniViewportCard extends StatelessWidget {
  const _MiniViewportCard({required this.spec});
  final _PatternSpec spec;

  @override
  Widget build(BuildContext context) {
    final List<List<Widget>> matrix = _buildMiniMatrix(spec);
    final TwoDimensionalChildListDelegate delegate =
        TwoDimensionalChildListDelegate(
      addRepaintBoundaries: true,
      addAutomaticKeepAlives: false,
      children: matrix,
    );
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: _kCeramicWarm,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: spec.primary.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: spec.primary.withValues(alpha: 0.15),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    spec.label,
                    style: TextStyle(
                      color: spec.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Text(
                  '${matrix.length} × ${matrix.isEmpty ? 0 : matrix.first.length}',
                  style: const TextStyle(color: _kInkSoft, fontSize: 11),
                ),
              ],
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(14)),
              child: _TwoDListTableView(
                delegate: delegate,
                background: spec.secondary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Anatomy card — shows the delegate constructor contract.
// ---------------------------------------------------------------------------

class _AnatomyCard extends StatelessWidget {
  const _AnatomyCard({required this.spec});
  final _PatternSpec spec;

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Delegate anatomy',
      subtitle: 'What the constructor takes, what the viewport asks for',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _AnatomyField(
            name: 'children',
            type: 'List<List<Widget>>',
            role:
                'Preloaded 2D list of widgets. Indexed as children[yIndex][xIndex].',
            accent: spec.primary,
          ),
          _AnatomyField(
            name: 'addRepaintBoundaries',
            type: 'bool = true',
            role: 'Wraps each tile with RepaintBoundary during build.',
            accent: spec.accent,
          ),
          _AnatomyField(
            name: 'addAutomaticKeepAlives',
            type: 'bool = true',
            role:
                'Wraps each tile with AutomaticKeepAlive; stateful tiles can opt in.',
            accent: _kCobalt,
          ),
          _AnatomyField(
            name: 'build(context, vicinity)',
            type: 'Widget?',
            role:
                'Returns null outside bounds; otherwise children[y][x] with optional boundary/keep-alive wrappers.',
            accent: _kGlazeTeal,
          ),
          _AnatomyField(
            name: 'shouldRebuild(old)',
            type: 'bool',
            role:
                'True iff children reference changed — hand the delegate a NEW list to trigger rebuild.',
            accent: _kTerracottaDeep,
          ),
        ],
      ),
    );
  }
}

class _AnatomyField extends StatelessWidget {
  const _AnatomyField({
    required this.name,
    required this.type,
    required this.role,
    required this.accent,
  });

  final String name;
  final String type;
  final String role;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kCeramic,
        borderRadius: BorderRadius.circular(10),
        border: Border(left: BorderSide(color: accent, width: 3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                name,
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  type,
                  style: const TextStyle(
                    color: _kInkSoft,
                    fontFamily: 'monospace',
                    fontSize: 12,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            role,
            style: const TextStyle(color: _kInk, height: 1.35, fontSize: 12.5),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Epilogue card.
// ---------------------------------------------------------------------------

class _EpilogueCard extends StatelessWidget {
  const _EpilogueCard();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: 'Production tips',
      subtitle: 'Switching, sizing, and staying out of your own way',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const <Widget>[
          _BulletLine(
            glyph: '✦',
            text:
                'If your grid grows unbounded, switch to TwoDimensionalChildBuilderDelegate '
                'before the preloaded list eats memory.',
          ),
          _BulletLine(
            glyph: '✦',
            text:
                'Hand a BRAND NEW outer list when tiles change. Mutating the '
                'existing List<List<Widget>> will not trigger shouldRebuild.',
          ),
          _BulletLine(
            glyph: '✦',
            text:
                'Fixed-size children make the viewport render object trivial. '
                'If tiles must self-size, do the measurement yourself and '
                'emit tiles of known size — dynamic size needs a custom viewport.',
          ),
          _BulletLine(
            glyph: '✦',
            text:
                'Disable repaint boundaries only on lightweight tiles; '
                'disable keep-alives only when cells hold no local state.',
          ),
          _BulletLine(
            glyph: '✦',
            text:
                'For accessibility, keep semantic widgets (Text, IconButton) '
                'inside each tile. The delegate is transparent to the '
                'semantics tree.',
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Delegate snippet card — literal Dart the delegate is constructed with.
// ---------------------------------------------------------------------------

class _DelegateSnippetCard extends StatelessWidget {
  const _DelegateSnippetCard();

  @override
  Widget build(BuildContext context) {
    const String snippet = '''
final delegate = TwoDimensionalChildListDelegate(
  addRepaintBoundaries: true,
  addAutomaticKeepAlives: true,
  children: <List<Widget>>[
    for (int y = 0; y < rows; y++)
      <Widget>[
        for (int x = 0; x < cols; x++)
          MosaicTile(pattern: spec, x: x, y: y),
      ],
  ],
);

// Consumed by a TwoDimensionalScrollView subclass:
return SimpleListTableView(delegate: delegate, mainAxis: Axis.vertical);''';
    return _SectionShell(
      title: 'Literal construction',
      subtitle: 'The exact shape the delegate wants from you',
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kInk,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          snippet,
          style: TextStyle(
            color: _kCeramic,
            fontFamily: 'monospace',
            fontSize: 12.5,
            height: 1.45,
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section shell — shared chrome for every card in the page.
// ---------------------------------------------------------------------------

class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.title,
    required this.subtitle,
    required this.child,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kCeramicWarm,
        borderRadius: BorderRadius.circular(18),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kInk.withValues(alpha: 0.06),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: _kInk,
                        fontWeight: FontWeight.w800,
                        fontSize: 17,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        color: _kInkSoft,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              ?trailing,
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Matrix factory — builds the List<List<Widget>> the delegate consumes.
// ---------------------------------------------------------------------------

List<List<Widget>> _buildMatrix({
  required _PatternSpec spec,
  required int rows,
  required int cols,
  required bool showCoords,
  required double tileSize,
  required ValueChanged<_TwoDListInspection> onInspect,
}) {
  final List<List<Widget>> out = <List<Widget>>[];
  for (int y = 0; y < rows; y++) {
    final List<Widget> row = <Widget>[];
    for (int x = 0; x < cols; x++) {
      row.add(
        _MosaicTile(
          spec: spec,
          xIndex: x,
          yIndex: y,
          rows: rows,
          cols: cols,
          showCoords: showCoords,
          size: tileSize,
          onInspect: onInspect,
        ),
      );
    }
    out.add(row);
  }
  return out;
}

List<List<Widget>> _buildMiniMatrix(_PatternSpec spec) {
  const int rows = 5;
  const int cols = 4;
  final List<List<Widget>> out = <List<Widget>>[];
  for (int y = 0; y < rows; y++) {
    final List<Widget> row = <Widget>[];
    for (int x = 0; x < cols; x++) {
      row.add(_MiniTile(spec: spec, xIndex: x, yIndex: y));
    }
    out.add(row);
  }
  return out;
}

// ---------------------------------------------------------------------------
// Mosaic tile — the actual painted Widget inside children[y][x].
// ---------------------------------------------------------------------------

class _MosaicTile extends StatelessWidget {
  const _MosaicTile({
    required this.spec,
    required this.xIndex,
    required this.yIndex,
    required this.rows,
    required this.cols,
    required this.showCoords,
    required this.size,
    required this.onInspect,
  });

  final _PatternSpec spec;
  final int xIndex;
  final int yIndex;
  final int rows;
  final int cols;
  final bool showCoords;
  final double size;
  final ValueChanged<_TwoDListInspection> onInspect;

  String get _glyph {
    switch (spec.pattern) {
      case _MosaicPattern.andalusian:
        return '✿';
      case _MosaicPattern.moroccan:
        return '✦';
      case _MosaicPattern.byzantine:
        return '✚';
      case _MosaicPattern.artDeco:
        return '◢';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onInspect(
        _TwoDListInspection(
          vicinity: ChildVicinity(xIndex: xIndex, yIndex: yIndex),
          widgetTypeName: '_MosaicTile',
          patternLabel: spec.label,
          glyph: _glyph,
        ),
      ),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: spec.secondary,
          border: Border.all(
            color: spec.primary.withValues(alpha: 0.25),
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            CustomPaint(
              painter: _MotifPainter(
                spec: spec,
                xIndex: xIndex,
                yIndex: yIndex,
                rows: rows,
                cols: cols,
              ),
            ),
            if (showCoords)
              Positioned(
                left: 4,
                top: 4,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: _kInk.withValues(alpha: 0.55),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    '$xIndex,$yIndex',
                    style: const TextStyle(
                      color: _kCeramic,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MiniTile extends StatelessWidget {
  const _MiniTile({
    required this.spec,
    required this.xIndex,
    required this.yIndex,
  });
  final _PatternSpec spec;
  final int xIndex;
  final int yIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _TwoDListTableRender.kTileSize,
      height: _TwoDListTableRender.kTileSize,
      decoration: BoxDecoration(
        color: spec.secondary,
        border: Border.all(color: spec.primary.withValues(alpha: 0.2)),
      ),
      child: CustomPaint(
        painter: _MotifPainter(
          spec: spec,
          xIndex: xIndex,
          yIndex: yIndex,
          rows: 5,
          cols: 4,
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Motif painters — one per pattern, branched inside a single CustomPainter.
// ---------------------------------------------------------------------------

class _MotifPainter extends CustomPainter {
  _MotifPainter({
    required this.spec,
    required this.xIndex,
    required this.yIndex,
    required this.rows,
    required this.cols,
  });

  final _PatternSpec spec;
  final int xIndex;
  final int yIndex;
  final int rows;
  final int cols;

  @override
  void paint(Canvas canvas, Size size) {
    switch (spec.pattern) {
      case _MosaicPattern.andalusian:
        _paintAndalusian(canvas, size);
        break;
      case _MosaicPattern.moroccan:
        _paintMoroccan(canvas, size);
        break;
      case _MosaicPattern.byzantine:
        _paintByzantine(canvas, size);
        break;
      case _MosaicPattern.artDeco:
        _paintArtDeco(canvas, size);
        break;
    }
  }

  void _paintAndalusian(Canvas canvas, Size size) {
    final Offset c = size.center(Offset.zero);
    final double r = size.shortestSide * 0.38;
    final Paint petal = Paint()
      ..color = spec.primary.withValues(alpha: 0.75)
      ..style = PaintingStyle.fill;
    final Paint ring = Paint()
      ..color = spec.accent.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;
    for (int i = 0; i < 6; i++) {
      final double a = i * math.pi / 3;
      canvas.drawCircle(
        Offset(c.dx + r * math.cos(a), c.dy + r * math.sin(a)),
        r * 0.42,
        petal,
      );
    }
    canvas.drawCircle(c, r * 0.45, ring);
    canvas.drawCircle(
      c,
      r * 0.25,
      Paint()..color = spec.accent.withValues(alpha: 0.9),
    );
  }

  void _paintMoroccan(Canvas canvas, Size size) {
    final Offset c = size.center(Offset.zero);
    final double r = size.shortestSide * 0.44;
    final Paint fill = Paint()
      ..color = spec.primary.withValues(alpha: 0.85);
    final Paint outline = Paint()
      ..color = spec.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;
    final Path star = Path();
    for (int i = 0; i < 16; i++) {
      final double angle = i * math.pi / 8;
      final double radius =
          (i.isEven ? r : r * 0.45);
      final Offset p = Offset(
        c.dx + radius * math.cos(angle),
        c.dy + radius * math.sin(angle),
      );
      if (i == 0) {
        star.moveTo(p.dx, p.dy);
      } else {
        star.lineTo(p.dx, p.dy);
      }
    }
    star.close();
    canvas.drawPath(star, fill);
    canvas.drawPath(star, outline);
    canvas.drawCircle(c, r * 0.2, Paint()..color = spec.accent);
  }

  void _paintByzantine(Canvas canvas, Size size) {
    final Offset c = size.center(Offset.zero);
    final double w = size.width;
    final double h = size.height;
    final Paint tessera = Paint()
      ..color = spec.accent.withValues(alpha: 0.9)
      ..style = PaintingStyle.fill;
    const int grid = 5;
    for (int yy = 0; yy < grid; yy++) {
      for (int xx = 0; xx < grid; xx++) {
        final double px = w * (xx + 0.5) / grid;
        final double py = h * (yy + 0.5) / grid;
        final double dx = px - c.dx;
        final double dy = py - c.dy;
        final double dist = math.sqrt(dx * dx + dy * dy);
        final bool onCross = xx == grid ~/ 2 || yy == grid ~/ 2;
        final Paint p = Paint()
          ..color = onCross
              ? spec.primary
              : (dist < w * 0.25
                  ? spec.accent.withValues(alpha: 0.85)
                  : spec.secondary.withValues(alpha: 0.9))
          ..style = PaintingStyle.fill;
        canvas.drawRect(
          Rect.fromCenter(center: Offset(px, py), width: w / grid * 0.78, height: h / grid * 0.78),
          p,
        );
      }
    }
    canvas.drawRect(
      Rect.fromCenter(center: c, width: w * 0.12, height: h * 0.12),
      tessera,
    );
  }

  void _paintArtDeco(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    final Paint bg = Paint()..color = spec.primary.withValues(alpha: 0.85);
    canvas.drawRect(Offset.zero & size, bg);
    final Paint chevron = Paint()
      ..color = spec.secondary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.1
      ..strokeJoin = StrokeJoin.bevel;
    for (int i = 0; i < 5; i++) {
      final double t = (i + 1) / 6;
      final Path path = Path()
        ..moveTo(0, h * (1 - t))
        ..lineTo(w / 2, h * (1 - t) - h * 0.14)
        ..lineTo(w, h * (1 - t));
      canvas.drawPath(path, chevron);
    }
    canvas.drawCircle(
      size.center(Offset.zero),
      size.shortestSide * 0.14,
      Paint()..color = spec.accent,
    );
  }

  @override
  bool shouldRepaint(covariant _MotifPainter old) {
    return old.spec.pattern != spec.pattern ||
        old.xIndex != xIndex ||
        old.yIndex != yIndex ||
        old.rows != rows ||
        old.cols != cols;
  }
}

// ===========================================================================
// Viewport scaffolding: minimal TwoDimensionalScrollView / Viewport / Render
// ===========================================================================
//
// The SDK ships TwoDimensionalChildListDelegate but does NOT ship a concrete
// TwoDimensionalScrollView consumer of it — subclassing is the expected
// integration point. We re-author a lean triple here: fixed tile size,
// window-computed layout, vertical mainAxis. This is intentionally NOT a
// copy of the SDK docs example; it is tailored to the mosaic wall.

class _TwoDListTableView extends TwoDimensionalScrollView {
  const _TwoDListTableView({
    required TwoDimensionalChildListDelegate super.delegate,
    required this.background,
  }) : super(
          diagonalDragBehavior: DiagonalDragBehavior.weightedEvent,
          dragStartBehavior: DragStartBehavior.start,
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.manual,
          verticalDetails: const ScrollableDetails.vertical(),
          horizontalDetails: const ScrollableDetails.horizontal(),
          mainAxis: Axis.vertical,
          clipBehavior: Clip.hardEdge,
        );

  final Color background;

  @override
  Widget buildViewport(
    BuildContext context,
    ViewportOffset verticalOffset,
    ViewportOffset horizontalOffset,
  ) {
    return _TwoDListTableViewport(
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalDetails.direction,
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalDetails.direction,
      mainAxis: mainAxis,
      delegate: delegate as TwoDimensionalChildListDelegate,
      background: background,
      cacheExtent: cacheExtent,
      cacheExtentStyle: cacheExtentStyle,
      clipBehavior: clipBehavior,
    );
  }
}

class _TwoDListTableViewport extends TwoDimensionalViewport {
  const _TwoDListTableViewport({
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required TwoDimensionalChildListDelegate delegate,
    required super.mainAxis,
    required this.background,
    super.cacheExtent,
    super.cacheExtentStyle,
    super.clipBehavior,
  }) : super(delegate: delegate);

  final Color background;

  @override
  RenderTwoDimensionalViewport createRenderObject(BuildContext context) {
    return _TwoDListTableRender(
      horizontalOffset: horizontalOffset,
      horizontalAxisDirection: horizontalAxisDirection,
      verticalOffset: verticalOffset,
      verticalAxisDirection: verticalAxisDirection,
      mainAxis: mainAxis,
      delegate: delegate as TwoDimensionalChildListDelegate,
      childManager: context as TwoDimensionalChildManager,
      background: background,
      cacheExtent: cacheExtent,
      cacheExtentStyle: cacheExtentStyle,
      clipBehavior: clipBehavior,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    covariant _TwoDListTableRender renderObject,
  ) {
    renderObject
      ..horizontalOffset = horizontalOffset
      ..horizontalAxisDirection = horizontalAxisDirection
      ..verticalOffset = verticalOffset
      ..verticalAxisDirection = verticalAxisDirection
      ..mainAxis = mainAxis
      ..delegate = delegate
      ..background = background
      ..cacheExtent = cacheExtent
      ..cacheExtentStyle = cacheExtentStyle
      ..clipBehavior = clipBehavior;
  }
}

class _TwoDListTableRender extends RenderTwoDimensionalViewport {
  _TwoDListTableRender({
    required super.horizontalOffset,
    required super.horizontalAxisDirection,
    required super.verticalOffset,
    required super.verticalAxisDirection,
    required TwoDimensionalChildListDelegate delegate,
    required super.mainAxis,
    required super.childManager,
    required Color background,
    super.cacheExtent,
    super.cacheExtentStyle,
    super.clipBehavior,
  })  : _background = background,
        super(delegate: delegate);

  static const double kTileSize = 52.0;

  Color _background;
  Color get background => _background;
  set background(Color value) {
    if (_background == value) return;
    _background = value;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.canvas.drawRect(
      offset & size,
      Paint()..color = _background,
    );
    super.paint(context, offset);
  }

  @override
  void layoutChildSequence() {
    final double horizontalPixels = horizontalOffset.pixels;
    final double verticalPixels = verticalOffset.pixels;
    final TwoDimensionalChildListDelegate listDelegate =
        delegate as TwoDimensionalChildListDelegate;

    final int rowCount = listDelegate.children.length;
    if (rowCount == 0) {
      verticalOffset.applyContentDimensions(0.0, 0.0);
      horizontalOffset.applyContentDimensions(0.0, 0.0);
      return;
    }
    final int columnCount = listDelegate.children.first.length;

    final int leadingColumn =
        math.max((horizontalPixels / kTileSize).floor(), 0);
    final int leadingRow =
        math.max((verticalPixels / kTileSize).floor(), 0);
    final int trailingColumn = math.min(
      ((horizontalPixels + viewportDimension.width) / kTileSize).ceil(),
      columnCount - 1,
    );
    final int trailingRow = math.min(
      ((verticalPixels + viewportDimension.height) / kTileSize).ceil(),
      rowCount - 1,
    );

    double xLayoutOffset =
        (leadingColumn * kTileSize) - horizontalOffset.pixels;
    for (int column = leadingColumn; column <= trailingColumn; column++) {
      double yLayoutOffset =
          (leadingRow * kTileSize) - verticalOffset.pixels;
      for (int row = leadingRow; row <= trailingRow; row++) {
        final ChildVicinity vicinity =
            ChildVicinity(xIndex: column, yIndex: row);
        final RenderBox? child = buildOrObtainChildFor(vicinity);
        if (child == null) {
          yLayoutOffset += kTileSize;
          continue;
        }
        child.layout(constraints.tighten(width: kTileSize, height: kTileSize));
        parentDataOf(child).layoutOffset = Offset(xLayoutOffset, yLayoutOffset);
        yLayoutOffset += kTileSize;
      }
      xLayoutOffset += kTileSize;
    }

    verticalOffset.applyContentDimensions(
      0.0,
      math.max(kTileSize * rowCount - viewportDimension.height, 0.0),
    );
    horizontalOffset.applyContentDimensions(
      0.0,
      math.max(kTileSize * columnCount - viewportDimension.width, 0.0),
    );
  }
}
