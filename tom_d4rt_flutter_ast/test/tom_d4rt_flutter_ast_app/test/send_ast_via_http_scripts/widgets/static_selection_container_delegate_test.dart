// =============================================================================
// Selection Plinth Hall — a deep visual demo for the d4rt AST test harness.
// -----------------------------------------------------------------------------
// SUBJECT: `StaticSelectionContainerDelegate`
//
// `StaticSelectionContainerDelegate` is a concrete subclass of
// `MultiSelectableSelectionContainerDelegate` (see
// `/srv/flutter/flutter/packages/flutter/lib/src/widgets/selectable_region.dart`
// line 2089). It is specialised for containers whose set of `Selectable`
// children is static at build time — i.e. the list of children does NOT
// change after the container is first constructed. Because children never
// arrive or depart, the delegate can keep lightweight internal bookkeeping
// (`_hasReceivedStartEvent`, `_hasReceivedEndEvent`) and avoid the extra
// round-trips the general multi-selectable delegate performs for dynamic
// subtrees.
//
// It IS re-exported through `package:flutter/material.dart` (via
// `widgets.dart` -> `src/widgets/selectable_region.dart`). No pivot to a
// composition fallback is required here; this demo consumes the delegate
// directly through real `SelectionContainer` + `SelectableRegion` widgets.
//
// Key inherited / overridden surface used in this demo:
//   * `value`                         -> SelectionGeometry getter (inherited)
//   * `selectables`                   -> List<Selectable> (inherited)
//   * `didReceiveSelectionEventFor`   -> start/end bookkeeping
//   * `didReceiveSelectionBoundaryEvents` -> boundary (word/line/all) sync
//   * `updateLastSelectionEdgeLocation`   -> last-known global positions
//   * `getSelectionGeometry`          -> merges child geometries (inherited)
//
// -----------------------------------------------------------------------------
// UX THEME — "Selection Plinth Hall"
// -----------------------------------------------------------------------------
//   * marble white  #F3F0E9   — gallery wall / plinth faces.
//   * gold leaf     #C9A34E   — accent sweep, framing, captions.
//   * obsidian      #18181B   — base, deep shadow, text.
//   * slate         #4A5568   — secondary chrome, subtitle ink.
//
// The hall is composed of: a marble-walled hero header with an animated
// gold-leaf sweep, four plinths (poem excerpt, plaque inscription, label,
// museum placard), a selection laboratory panel, an imperative control row,
// a comparison card, an API card, and a pitfall card. Every plinth wraps
// curated static text in a `SelectionContainer` whose delegate is a
// `StaticSelectionContainerDelegate`, and overlays a dashed bounding-box
// frame showing the selection region.
//
// -----------------------------------------------------------------------------
// HARNESS CONTRACT
// -----------------------------------------------------------------------------
//   * `dynamic build(BuildContext context)` is the single entry point.
//   * No `main()` and no `runApp()`.
//   * Imports are `package:flutter/material.dart` + `dart:math` only.
//   * No `// ignore_for_file:` directives, no `analysis_options.yaml` edits.
//   * Colour alpha uses `.withValues(alpha: ...)`; channels use `.r/.g/.b/.a`.
//   * `debugPrint` instead of `print`.
//   * Private classes prefixed with `_Sscd`.
// =============================================================================

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

// -----------------------------------------------------------------------------
// PALETTE CONSTANTS
// -----------------------------------------------------------------------------

const Color _kMarble = Color(0xFFF3F0E9);
const Color _kMarbleDeep = Color(0xFFE4DFD2);
const Color _kMarbleVein = Color(0xFFD8D2C2);
const Color _kGold = Color(0xFFC9A34E);
const Color _kGoldSoft = Color(0xFFE1C988);
const Color _kGoldDeep = Color(0xFF8C6F2E);
const Color _kObsidian = Color(0xFF18181B);
const Color _kObsidianSoft = Color(0xFF2A2A30);
const Color _kSlate = Color(0xFF4A5568);
const Color _kSlateSoft = Color(0xFF6B7380);
const Color _kVelvet = Color(0xFF7A1E1E);
const Color _kVelvetSoft = Color(0xFFA03434);

// -----------------------------------------------------------------------------
// PLINTH CONTENT — four curated excerpts, one per plinth.
// -----------------------------------------------------------------------------

const String _kPlinthOneTitle = 'Plinth I — Poem Excerpt';
const String _kPlinthOneAttribution = 'from "Of the Marble Halls", anon.';
const List<String> _kPlinthOneLines = <String>[
  'In the still hall the marble keeps its thought,',
  'and gold leaf, laid in patient leaves, forgets',
  'nothing of the long hand that carried it.',
  'Stand here: the stone is patient, and will wait.',
];

const String _kPlinthTwoTitle = 'Plinth II — Plaque Inscription';
const String _kPlinthTwoAttribution = 'Dedicatory plaque, east atrium.';
const List<String> _kPlinthTwoLines = <String>[
  'To those who named the quiet things,',
  'and to the hands that shaped the hours,',
  'this room is set aside. Read slowly.',
  'What you read, you may carry out with you.',
];

const String _kPlinthThreeTitle = 'Plinth III — Gallery Label';
const String _kPlinthThreeAttribution = 'Cat. no. 00.147, on loan.';
const List<String> _kPlinthThreeLines = <String>[
  'Artefact: selection cursor, annotated.',
  'Material: geometry, rect, status, handles.',
  'Date: introduced with the SelectableRegion.',
  'Provenance: /src/widgets/selectable_region.dart',
];

const String _kPlinthFourTitle = 'Plinth IV — Museum Placard';
const String _kPlinthFourAttribution = 'Curatorial note, long form.';
const List<String> _kPlinthFourLines = <String>[
  'A static delegate is not a lesser delegate.',
  'It is simply a delegate that has been told,',
  '"the children you were given are all the',
  'children you will ever have." That promise',
  'buys it smaller books and quieter footsteps.',
];

// -----------------------------------------------------------------------------
// LABORATORY CONTENT — one long passage the lab selection container wraps.
// -----------------------------------------------------------------------------

const String _kLabHeadline = 'Selection Laboratory — Observation Bench';
const List<String> _kLabParagraphs = <String>[
  'The laboratory wraps a single SelectionContainer around a static list '
      'of four Text children. Drag across the paragraphs below, then read '
      'the live geometry panel on the right. The delegate in use is a '
      'StaticSelectionContainerDelegate.',
  'Because the child list is fixed at build time, the delegate never has '
      'to run the add/remove reconciliation path that the general case '
      'requires. The selectables list is sorted once and stays sorted.',
  'When you drag an edge outside a paragraph, the delegate clamps the '
      'handle to the last known global position and synthesises the '
      'missing start or end event so every active Selectable sees a well '
      'formed pair.',
  'Copy the selection with the Copy button below, or press Ctrl+C. Both '
      'paths go through the same CopySelectionTextIntent that the '
      'SelectableRegion already installs into the Actions map above it.',
];

// -----------------------------------------------------------------------------
// COMPARISON ROWS — StaticSelectionContainerDelegate vs the base class.
// -----------------------------------------------------------------------------

const List<List<String>> _kComparisonRows = <List<String>>[
  <String>[
    'Child list',
    'Fixed at build time, never mutates.',
    'May grow / shrink / reorder at any frame.',
  ],
  <String>[
    'Event bookkeeping',
    '_hasReceivedStartEvent / _hasReceivedEndEvent sets.',
    'Must reconcile additions/removals each frame.',
  ],
  <String>[
    'Last edge position',
    'Cached globally; synthesised on demand.',
    'Recomputed from children each notify cycle.',
  ],
  <String>[
    'Typical host',
    'Poster, placard, card, list-tile, label.',
    'Scrollable list, lazy grid, dynamic feed.',
  ],
  <String>[
    'Notify cost',
    'Low — no merge/sort per mutation.',
    'Higher — add/remove triggers _flushAdditions.',
  ],
  <String>[
    'Risk if misused',
    'Silently drops updates for late arrivals.',
    'None specific — this IS the general case.',
  ],
];

// -----------------------------------------------------------------------------
// API ROWS — quoted public / inherited surface referenced by this demo.
// -----------------------------------------------------------------------------

const List<List<String>> _kApiRows = <List<String>>[
  <String>[
    'SelectionGeometry get value',
    'Inherited getter. Returns the merged SelectionGeometry for all '
        'Selectables managed by this delegate.',
  ],
  <String>[
    'List<Selectable> selectables',
    'Inherited field. The ordered list of Selectable children. For the '
        'static delegate, this list is populated once and never re-sorted '
        'after the first frame.',
  ],
  <String>[
    'void didReceiveSelectionEventFor({required Selectable selectable, '
        'bool? forEnd})',
    'Registers a Selectable as having seen a start event, an end event, '
        'or (when forEnd is null) both. Internal bookkeeping for the '
        'static case.',
  ],
  <String>[
    'void didReceiveSelectionBoundaryEvents()',
    'Marks every Selectable in the current selection range as having seen '
        'both edges. Called after SelectAll / SelectWord / SelectParagraph.',
  ],
  <String>[
    'void updateLastSelectionEdgeLocation({required Offset '
        'globalSelectionEdgeLocation, required bool forEnd})',
    'Stores the most recent global position of the start or end edge. '
        'Used to synthesise missing events for new or lagging children.',
  ],
  <String>[
    'SelectionGeometry getSelectionGeometry()',
    'Inherited. Computes the merged geometry from all child selectables. '
        'Called by the base class whenever a child notifies.',
  ],
];

// -----------------------------------------------------------------------------
// PITFALL BULLET POINTS.
// -----------------------------------------------------------------------------

const List<String> _kPitfallBullets = <String>[
  'Do NOT use StaticSelectionContainerDelegate if your children list is '
      'dynamic — new children arriving after the first frame will not be '
      'correctly merged into the ongoing selection.',
  'Do NOT use it for scrollable viewports that lazy-build their children '
      '(ListView.builder, SliverList, LazyColumn-style widgets).',
  'Do NOT share a single StaticSelectionContainerDelegate instance across '
      'two SelectionContainers; the delegate holds state and is 1:1 with '
      'its container.',
  'DO remember to call super.dispose() on any wrapper State that owns the '
      'delegate; the delegate is a ChangeNotifier and expects teardown.',
  'DO prefer StaticSelectionContainerDelegate when the content is truly '
      'static — poster rows, placards, captions, help cards, about panels.',
];

// =============================================================================
// ENTRY POINT — d4rt AST harness contract.
// =============================================================================

dynamic build(BuildContext context) {
  debugPrint('[Sscd] Selection Plinth Hall — build() called.');
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'StaticSelectionContainerDelegate — Selection Plinth Hall',
    theme: _sscdBuildTheme(),
    home: const _SscdHallShell(),
  );
}

ThemeData _sscdBuildTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    scaffoldBackgroundColor: _kMarble,
    colorScheme: base.colorScheme.copyWith(
      primary: _kGold,
      secondary: _kVelvet,
      surface: _kMarble,
      onSurface: _kObsidian,
    ),
    textTheme: base.textTheme.apply(
      bodyColor: _kObsidian,
      displayColor: _kObsidian,
      fontFamily: 'Georgia',
    ),
    dividerColor: _kGold.withValues(alpha: 0.35),
  );
}

// =============================================================================
// HALL SHELL — top-level scroll view containing every demo section.
// =============================================================================

class _SscdHallShell extends StatefulWidget {
  const _SscdHallShell();

  @override
  State<_SscdHallShell> createState() => _SscdHallShellState();
}

class _SscdHallShellState extends State<_SscdHallShell>
    with TickerProviderStateMixin {
  late final AnimationController _sweepController;
  late final AnimationController _velvetController;
  final GlobalKey _labRegionKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _sweepController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    _velvetController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 9),
    )..repeat(reverse: true);
    debugPrint('[Sscd] Hall shell initState complete.');
  }

  @override
  void dispose() {
    _sweepController.dispose();
    _velvetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kMarble,
      body: SafeArea(
        child: SelectionArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _SscdHeroHeader(
                  sweep: _sweepController,
                  velvet: _velvetController,
                ),
                const SizedBox(height: 32),
                const _SscdIntroRibbon(),
                const SizedBox(height: 28),
                const _SscdPlinthHall(),
                const SizedBox(height: 28),
                _SscdLaboratoryPanel(regionKey: _labRegionKey),
                const SizedBox(height: 28),
                _SscdImperativeControlRow(regionKey: _labRegionKey),
                const SizedBox(height: 28),
                const _SscdComparisonCard(),
                const SizedBox(height: 28),
                const _SscdApiCard(),
                const SizedBox(height: 28),
                const _SscdPitfallCard(),
                const SizedBox(height: 28),
                const _SscdFootCartouche(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// HERO HEADER — marble gallery wall with animated gold-leaf sweep.
// =============================================================================

class _SscdHeroHeader extends StatelessWidget {
  const _SscdHeroHeader({required this.sweep, required this.velvet});

  final Animation<double> sweep;
  final Animation<double> velvet;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 18 / 7,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            const _SscdMarbleWall(),
            AnimatedBuilder(
              animation: sweep,
              builder: (BuildContext context, Widget? _) {
                return CustomPaint(
                  painter: _SscdGoldSweepPainter(progress: sweep.value),
                );
              },
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 24, 32, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _SscdBreadcrumb(),
                    _SscdHeroTitle(),
                    _SscdHeroFootline(),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: 14,
              child: AnimatedBuilder(
                animation: velvet,
                builder: (BuildContext context, Widget? _) {
                  return CustomPaint(
                    painter: _SscdVelvetRopePainter(phase: velvet.value),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SscdBreadcrumb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        _SscdBreadcrumbChip(label: 'widgets'),
        _SscdBreadcrumbDot(),
        _SscdBreadcrumbChip(label: 'selectable_region'),
        _SscdBreadcrumbDot(),
        _SscdBreadcrumbChip(label: 'delegates'),
        _SscdBreadcrumbDot(),
        _SscdBreadcrumbChip(label: 'static', emphasised: true),
      ],
    );
  }
}

class _SscdBreadcrumbChip extends StatelessWidget {
  const _SscdBreadcrumbChip({required this.label, this.emphasised = false});
  final String label;
  final bool emphasised;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: emphasised
            ? _kGold.withValues(alpha: 0.22)
            : _kObsidian.withValues(alpha: 0.06),
        border: Border.all(
          color: emphasised
              ? _kGold.withValues(alpha: 0.8)
              : _kObsidian.withValues(alpha: 0.18),
        ),
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w600,
          color: emphasised ? _kGoldDeep : _kSlate,
        ),
      ),
    );
  }
}

class _SscdBreadcrumbDot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Icon(Icons.circle, size: 4, color: _kSlate.withValues(alpha: 0.6)),
    );
  }
}

class _SscdHeroTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Text(
          'StaticSelectionContainerDelegate',
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.4,
            color: _kObsidian,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Selection Plinth Hall — a gallery of static selection containers',
          style: TextStyle(
            fontSize: 16,
            fontStyle: FontStyle.italic,
            color: _kSlate,
          ),
        ),
      ],
    );
  }
}

class _SscdHeroFootline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        _SscdHeroStat(label: 'subtype of', value: 'MultiSelectable…Delegate'),
        const SizedBox(width: 18),
        _SscdHeroStat(label: 'assumption', value: 'children are static'),
        const SizedBox(width: 18),
        _SscdHeroStat(label: 'host widget', value: 'SelectionContainer'),
        const SizedBox(width: 18),
        _SscdHeroStat(label: 'harness', value: 'd4rt AST'),
      ],
    );
  }
}

class _SscdHeroStat extends StatelessWidget {
  const _SscdHeroStat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            letterSpacing: 1.5,
            color: _kSlate.withValues(alpha: 0.85),
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            color: _kObsidian,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// MARBLE WALL + GOLD SWEEP + VELVET ROPE PAINTERS
// -----------------------------------------------------------------------------

class _SscdMarbleWall extends StatelessWidget {
  const _SscdMarbleWall();
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _SscdMarblePainter());
  }
}

class _SscdMarblePainter extends CustomPainter {
  _SscdMarblePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Rect rect = Offset.zero & size;
    final Paint base = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          _kMarble,
          _kMarbleDeep.withValues(alpha: 0.95),
          _kMarble,
        ],
        stops: const <double>[0.0, 0.55, 1.0],
      ).createShader(rect);
    canvas.drawRect(rect, base);

    final math.Random rng = math.Random(20260424);
    final Paint vein = Paint()
      ..color = _kMarbleVein.withValues(alpha: 0.55)
      ..strokeWidth = 0.9
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < 28; i++) {
      final Path p = Path();
      final double y0 = rng.nextDouble() * size.height;
      p.moveTo(-10, y0);
      double x = -10;
      double y = y0;
      while (x < size.width + 10) {
        x += 24 + rng.nextDouble() * 18;
        y += (rng.nextDouble() - 0.5) * 28;
        p.lineTo(x, y);
      }
      canvas.drawPath(p, vein);
    }

    final Paint flecks = Paint()..color = _kGold.withValues(alpha: 0.09);
    for (int i = 0; i < 60; i++) {
      final Offset c = Offset(
        rng.nextDouble() * size.width,
        rng.nextDouble() * size.height,
      );
      canvas.drawCircle(c, 0.6 + rng.nextDouble() * 1.2, flecks);
    }
  }

  @override
  bool shouldRepaint(covariant _SscdMarblePainter oldDelegate) => false;
}

class _SscdGoldSweepPainter extends CustomPainter {
  _SscdGoldSweepPainter({required this.progress});
  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width * (-0.4 + 1.6 * progress);
    final double w = size.width * 0.35;
    final Rect band = Rect.fromLTWH(cx - w / 2, 0, w, size.height);
    final Paint p = Paint()
      ..shader = LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: <Color>[
          _kGold.withValues(alpha: 0.0),
          _kGoldSoft.withValues(alpha: 0.22),
          _kGold.withValues(alpha: 0.34),
          _kGoldSoft.withValues(alpha: 0.22),
          _kGold.withValues(alpha: 0.0),
        ],
        stops: const <double>[0.0, 0.3, 0.5, 0.7, 1.0],
      ).createShader(band);
    canvas.drawRect(band, p);

    final Paint edge = Paint()
      ..color = _kGoldDeep.withValues(alpha: 0.18)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(cx, 0), Offset(cx, size.height), edge);
  }

  @override
  bool shouldRepaint(covariant _SscdGoldSweepPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class _SscdVelvetRopePainter extends CustomPainter {
  _SscdVelvetRopePainter({required this.phase});
  final double phase;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint rope = Paint()
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round
      ..color = _kVelvet;
    final Paint highlight = Paint()
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..color = _kVelvetSoft.withValues(alpha: 0.55);

    final Path p = Path();
    final Path h = Path();
    const double baseY = 8;
    p.moveTo(0, baseY);
    h.moveTo(0, baseY - 2);
    final int segments = 80;
    for (int i = 0; i <= segments; i++) {
      final double t = i / segments;
      final double x = t * size.width;
      final double y = baseY +
          math.sin(t * math.pi * 6 + phase * math.pi * 2) * 2.6;
      p.lineTo(x, y);
      h.lineTo(x, y - 2);
    }
    canvas.drawPath(p, rope);
    canvas.drawPath(h, highlight);

    // Brass posts at both ends.
    final Paint post = Paint()..color = _kGoldDeep;
    final Paint postGlow = Paint()..color = _kGoldSoft;
    for (final double x in <double>[6, size.width - 6]) {
      canvas.drawCircle(Offset(x, baseY), 4, post);
      canvas.drawCircle(Offset(x, baseY), 2, postGlow);
    }
  }

  @override
  bool shouldRepaint(covariant _SscdVelvetRopePainter oldDelegate) =>
      oldDelegate.phase != phase;
}

// =============================================================================
// INTRO RIBBON — short explanatory paragraph, in gold on marble.
// =============================================================================

class _SscdIntroRibbon extends StatelessWidget {
  const _SscdIntroRibbon();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 16, 22, 16),
      decoration: BoxDecoration(
        color: _kMarbleDeep.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kGold.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: _kGold.withValues(alpha: 0.15),
              shape: BoxShape.circle,
              border: Border.all(color: _kGold.withValues(alpha: 0.7)),
            ),
            child: const Icon(Icons.auto_stories, color: _kGoldDeep, size: 18),
          ),
          const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Four plinths, each hosting a StaticSelectionContainerDelegate. '
              'A laboratory panel for live geometry readout. Imperative '
              'controls for select-all / clear / copy. A comparison card, an '
              'API card, and a pitfall card. Drag across any selectable '
              'surface to observe the delegate at work.',
              style: TextStyle(
                fontSize: 14,
                color: _kObsidian,
                height: 1.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// PLINTH HALL — four plinths arranged in a 2x2 responsive grid.
// =============================================================================

class _SscdPlinthHall extends StatelessWidget {
  const _SscdPlinthHall();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const _SscdSectionHeader(
          caption: 'Hall of Plinths',
          subtitle:
              'Each plinth wraps curated static text in its own SelectionContainer.',
        ),
        const SizedBox(height: 14),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final bool wide = constraints.maxWidth > 860;
            if (wide) {
              return Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Expanded(
                        child: _SscdPlinth(
                          index: 1,
                          title: _kPlinthOneTitle,
                          attribution: _kPlinthOneAttribution,
                          lines: _kPlinthOneLines,
                          accent: _kGold,
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        child: _SscdPlinth(
                          index: 2,
                          title: _kPlinthTwoTitle,
                          attribution: _kPlinthTwoAttribution,
                          lines: _kPlinthTwoLines,
                          accent: _kVelvet,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Expanded(
                        child: _SscdPlinth(
                          index: 3,
                          title: _kPlinthThreeTitle,
                          attribution: _kPlinthThreeAttribution,
                          lines: _kPlinthThreeLines,
                          accent: _kSlate,
                        ),
                      ),
                      SizedBox(width: 18),
                      Expanded(
                        child: _SscdPlinth(
                          index: 4,
                          title: _kPlinthFourTitle,
                          attribution: _kPlinthFourAttribution,
                          lines: _kPlinthFourLines,
                          accent: _kObsidian,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            return Column(
              children: const <Widget>[
                _SscdPlinth(
                  index: 1,
                  title: _kPlinthOneTitle,
                  attribution: _kPlinthOneAttribution,
                  lines: _kPlinthOneLines,
                  accent: _kGold,
                ),
                SizedBox(height: 18),
                _SscdPlinth(
                  index: 2,
                  title: _kPlinthTwoTitle,
                  attribution: _kPlinthTwoAttribution,
                  lines: _kPlinthTwoLines,
                  accent: _kVelvet,
                ),
                SizedBox(height: 18),
                _SscdPlinth(
                  index: 3,
                  title: _kPlinthThreeTitle,
                  attribution: _kPlinthThreeAttribution,
                  lines: _kPlinthThreeLines,
                  accent: _kSlate,
                ),
                SizedBox(height: 18),
                _SscdPlinth(
                  index: 4,
                  title: _kPlinthFourTitle,
                  attribution: _kPlinthFourAttribution,
                  lines: _kPlinthFourLines,
                  accent: _kObsidian,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// INDIVIDUAL PLINTH
// -----------------------------------------------------------------------------

class _SscdPlinth extends StatefulWidget {
  const _SscdPlinth({
    required this.index,
    required this.title,
    required this.attribution,
    required this.lines,
    required this.accent,
  });

  final int index;
  final String title;
  final String attribution;
  final List<String> lines;
  final Color accent;

  @override
  State<_SscdPlinth> createState() => _SscdPlinthState();
}

class _SscdPlinthState extends State<_SscdPlinth> {
  late final StaticSelectionContainerDelegate _delegate;

  @override
  void initState() {
    super.initState();
    _delegate = StaticSelectionContainerDelegate();
    debugPrint('[Sscd] Plinth ${widget.index} delegate constructed.');
  }

  @override
  void dispose() {
    _delegate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
      decoration: BoxDecoration(
        color: _kMarble,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kGold.withValues(alpha: 0.35), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kObsidian.withValues(alpha: 0.07),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _SscdPlinthCaption(
            index: widget.index,
            title: widget.title,
            accent: widget.accent,
          ),
          const SizedBox(height: 14),
          CustomPaint(
            painter: _SscdPlinthBodyPainter(accent: widget.accent),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 18, 14, 18),
              child: _SscdDashedFrame(
                color: widget.accent.withValues(alpha: 0.55),
                child: SelectionContainer(
                  delegate: _delegate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      for (int i = 0; i < widget.lines.length; i++)
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: i == widget.lines.length - 1 ? 0 : 4,
                          ),
                          child: Text(
                            widget.lines[i],
                            style: const TextStyle(
                              fontSize: 14,
                              color: _kObsidian,
                              height: 1.45,
                              fontFamily: 'Georgia',
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _SscdPlinthBase(accent: widget.accent),
          const SizedBox(height: 8),
          _SscdPlinthAttribution(text: widget.attribution),
        ],
      ),
    );
  }
}

class _SscdPlinthCaption extends StatelessWidget {
  const _SscdPlinthCaption({
    required this.index,
    required this.title,
    required this.accent,
  });
  final int index;
  final String title;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 30,
          height: 30,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.15),
            shape: BoxShape.circle,
            border: Border.all(color: accent.withValues(alpha: 0.8)),
          ),
          child: Text(
            _romanNumeral(index),
            style: TextStyle(
              fontSize: 12,
              color: accent,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _kObsidian,
              letterSpacing: 0.2,
            ),
          ),
        ),
      ],
    );
  }

  String _romanNumeral(int n) {
    switch (n) {
      case 1:
        return 'I';
      case 2:
        return 'II';
      case 3:
        return 'III';
      case 4:
        return 'IV';
      default:
        return '$n';
    }
  }
}

class _SscdPlinthBodyPainter extends CustomPainter {
  _SscdPlinthBodyPainter({required this.accent});
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect r = Offset.zero & size;
    final Paint fill = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          _kMarble,
          _kMarbleDeep.withValues(alpha: 0.7),
        ],
      ).createShader(r);
    canvas.drawRRect(
      RRect.fromRectAndRadius(r.deflate(1), const Radius.circular(6)),
      fill,
    );
    final Paint edge = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = accent.withValues(alpha: 0.18);
    canvas.drawRRect(
      RRect.fromRectAndRadius(r.deflate(1), const Radius.circular(6)),
      edge,
    );
  }

  @override
  bool shouldRepaint(covariant _SscdPlinthBodyPainter oldDelegate) =>
      oldDelegate.accent != accent;
}

class _SscdPlinthBase extends StatelessWidget {
  const _SscdPlinthBase({required this.accent});
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: CustomPaint(
        painter: _SscdPlinthBasePainter(accent: accent),
      ),
    );
  }
}

class _SscdPlinthBasePainter extends CustomPainter {
  _SscdPlinthBasePainter({required this.accent});
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;
    // Three-tier base.
    final Paint tier = Paint()..color = _kMarbleDeep;
    canvas.drawRect(Rect.fromLTWH(w * 0.05, 0, w * 0.9, h * 0.35), tier);
    final Paint tier2 = Paint()..color = _kMarbleVein;
    canvas.drawRect(
      Rect.fromLTWH(w * 0.02, h * 0.35, w * 0.96, h * 0.35),
      tier2,
    );
    final Paint tier3 = Paint()..color = _kObsidianSoft;
    canvas.drawRect(
      Rect.fromLTWH(0, h * 0.7, w, h * 0.3),
      tier3,
    );
    // Gold inlay stripe.
    final Paint inlay = Paint()..color = accent.withValues(alpha: 0.55);
    canvas.drawRect(
      Rect.fromLTWH(w * 0.05, h * 0.33, w * 0.9, 1.2),
      inlay,
    );
  }

  @override
  bool shouldRepaint(covariant _SscdPlinthBasePainter oldDelegate) =>
      oldDelegate.accent != accent;
}

class _SscdPlinthAttribution extends StatelessWidget {
  const _SscdPlinthAttribution({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.right,
      style: TextStyle(
        fontSize: 11,
        fontStyle: FontStyle.italic,
        color: _kSlate.withValues(alpha: 0.85),
        letterSpacing: 0.3,
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// DASHED FRAME — overlay showing the selection container's bounding box.
// -----------------------------------------------------------------------------

class _SscdDashedFrame extends StatelessWidget {
  const _SscdDashedFrame({required this.color, required this.child});
  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _SscdDashedFramePainter(color: color),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: child,
      ),
    );
  }
}

class _SscdDashedFramePainter extends CustomPainter {
  _SscdDashedFramePainter({required this.color});
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = color;
    _drawDashedLine(canvas, const Offset(0, 0), Offset(size.width, 0), p);
    _drawDashedLine(canvas, Offset(size.width, 0),
        Offset(size.width, size.height), p);
    _drawDashedLine(canvas, Offset(size.width, size.height),
        Offset(0, size.height), p);
    _drawDashedLine(canvas, Offset(0, size.height), const Offset(0, 0), p);

    // Corner ticks.
    final Paint tick = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = color.withValues(alpha: 0.9);
    const double tl = 6;
    canvas.drawLine(const Offset(0, 0), const Offset(tl, 0), tick);
    canvas.drawLine(const Offset(0, 0), const Offset(0, tl), tick);
    canvas.drawLine(
        Offset(size.width, 0), Offset(size.width - tl, 0), tick);
    canvas.drawLine(Offset(size.width, 0), Offset(size.width, tl), tick);
    canvas.drawLine(Offset(0, size.height), Offset(tl, size.height), tick);
    canvas.drawLine(
        Offset(0, size.height), Offset(0, size.height - tl), tick);
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width - tl, size.height), tick);
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width, size.height - tl), tick);
  }

  void _drawDashedLine(Canvas canvas, Offset a, Offset b, Paint p) {
    const double dash = 5;
    const double gap = 4;
    final double dx = b.dx - a.dx;
    final double dy = b.dy - a.dy;
    final double len = math.sqrt(dx * dx + dy * dy);
    if (len == 0) return;
    final double ux = dx / len;
    final double uy = dy / len;
    double travelled = 0;
    while (travelled < len) {
      final double segEnd = math.min(travelled + dash, len);
      canvas.drawLine(
        Offset(a.dx + ux * travelled, a.dy + uy * travelled),
        Offset(a.dx + ux * segEnd, a.dy + uy * segEnd),
        p,
      );
      travelled = segEnd + gap;
    }
  }

  @override
  bool shouldRepaint(covariant _SscdDashedFramePainter oldDelegate) =>
      oldDelegate.color != color;
}

// =============================================================================
// LABORATORY PANEL — single SelectionContainer + live status readout.
// =============================================================================

class _SscdLaboratoryPanel extends StatefulWidget {
  const _SscdLaboratoryPanel({required this.regionKey});
  final GlobalKey regionKey;

  @override
  State<_SscdLaboratoryPanel> createState() => _SscdLaboratoryPanelState();
}

class _SscdLaboratoryPanelState extends State<_SscdLaboratoryPanel> {
  late final StaticSelectionContainerDelegate _delegate;
  SelectionGeometry _geometry = const SelectionGeometry(
    hasContent: false,
    status: SelectionStatus.none,
  );

  @override
  void initState() {
    super.initState();
    _delegate = StaticSelectionContainerDelegate();
    _delegate.addListener(_onGeometryChanged);
    debugPrint('[Sscd] Laboratory delegate wired.');
  }

  void _onGeometryChanged() {
    if (!mounted) return;
    setState(() {
      _geometry = _delegate.value;
    });
  }

  @override
  void dispose() {
    _delegate.removeListener(_onGeometryChanged);
    _delegate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
      decoration: BoxDecoration(
        color: _kMarble,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kObsidian.withValues(alpha: 0.12)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _kObsidian.withValues(alpha: 0.06),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SscdSectionHeader(
            caption: 'Selection Laboratory',
            subtitle:
                'A single SelectionContainer, a static child list, and a live geometry readout.',
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              final bool wide = constraints.maxWidth > 780;
              final Widget body = _SscdLabBody(
                regionKey: widget.regionKey,
                delegate: _delegate,
              );
              final Widget readout = _SscdLabReadout(geometry: _geometry);
              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(flex: 3, child: body),
                    const SizedBox(width: 20),
                    Expanded(flex: 2, child: readout),
                  ],
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  body,
                  const SizedBox(height: 16),
                  readout,
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _SscdLabBody extends StatelessWidget {
  const _SscdLabBody({required this.regionKey, required this.delegate});
  final GlobalKey regionKey;
  final StaticSelectionContainerDelegate delegate;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kMarbleDeep.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kGold.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            _kLabHeadline,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: _kObsidian,
            ),
          ),
          const SizedBox(height: 12),
          _SscdDashedFrame(
            color: _kGold.withValues(alpha: 0.7),
            child: SelectableRegion(
              key: regionKey,
              selectionControls: materialTextSelectionControls,
              child: SelectionContainer(
                delegate: delegate,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    for (int i = 0; i < _kLabParagraphs.length; i++)
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: i == _kLabParagraphs.length - 1 ? 0 : 10,
                        ),
                        child: Text(
                          _kLabParagraphs[i],
                          style: const TextStyle(
                            fontSize: 13.5,
                            color: _kObsidian,
                            height: 1.5,
                          ),
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
}

class _SscdLabReadout extends StatelessWidget {
  const _SscdLabReadout({required this.geometry});
  final SelectionGeometry geometry;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _kObsidian,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kGold.withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: _kGold,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              const Text(
                'LIVE GEOMETRY',
                style: TextStyle(
                  fontSize: 11,
                  color: _kGoldSoft,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _SscdReadoutRow(label: 'status', value: _statusLabel(geometry.status)),
          _SscdReadoutRow(
            label: 'hasContent',
            value: geometry.hasContent ? 'true' : 'false',
          ),
          _SscdReadoutRow(
            label: 'hasSelection',
            value: geometry.hasSelection ? 'true' : 'false',
          ),
          _SscdReadoutRow(
            label: 'startPoint',
            value: _formatPoint(geometry.startSelectionPoint),
          ),
          _SscdReadoutRow(
            label: 'endPoint',
            value: _formatPoint(geometry.endSelectionPoint),
          ),
          _SscdReadoutRow(
            label: 'startLineH',
            value: _formatLineHeight(geometry.startSelectionPoint),
          ),
          _SscdReadoutRow(
            label: 'endLineH',
            value: _formatLineHeight(geometry.endSelectionPoint),
          ),
          const SizedBox(height: 12),
          Text(
            _narration(geometry),
            style: TextStyle(
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
              color: _kMarble.withValues(alpha: 0.75),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  String _statusLabel(SelectionStatus status) {
    switch (status) {
      case SelectionStatus.none:
        return 'none';
      case SelectionStatus.uncollapsed:
        return 'uncollapsed';
      case SelectionStatus.collapsed:
        return 'collapsed';
    }
  }

  String _formatPoint(SelectionPoint? p) {
    if (p == null) return '—';
    final Offset o = p.localPosition;
    return '(${o.dx.toStringAsFixed(1)}, ${o.dy.toStringAsFixed(1)})';
  }

  String _formatLineHeight(SelectionPoint? p) {
    if (p == null) return '—';
    return p.lineHeight.toStringAsFixed(1);
  }

  String _narration(SelectionGeometry g) {
    if (!g.hasSelection) {
      return 'No selection. Drag across a paragraph to begin.';
    }
    if (g.status == SelectionStatus.collapsed) {
      return 'Selection collapsed — start and end coincide.';
    }
    return 'Selection active. The delegate merged per-child geometries '
        'into this single SelectionGeometry.';
  }
}

class _SscdReadoutRow extends StatelessWidget {
  const _SscdReadoutRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 86,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: _kGoldSoft.withValues(alpha: 0.9),
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 12,
                color: _kMarble,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// IMPERATIVE CONTROL ROW — select all, clear, copy.
// =============================================================================

class _SscdImperativeControlRow extends StatelessWidget {
  const _SscdImperativeControlRow({required this.regionKey});
  final GlobalKey regionKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 14),
      decoration: BoxDecoration(
        color: _kObsidianSoft,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _kGold.withValues(alpha: 0.55)),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.settings_ethernet, color: _kGoldSoft, size: 18),
          const SizedBox(width: 10),
          const Text(
            'IMPERATIVE CONTROLS',
            style: TextStyle(
              fontSize: 11,
              color: _kGoldSoft,
              letterSpacing: 2,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Spacer(),
          _SscdControlButton(
            icon: Icons.select_all,
            label: 'Select all',
            onTap: () => _selectAll(context),
          ),
          const SizedBox(width: 10),
          _SscdControlButton(
            icon: Icons.clear_all,
            label: 'Clear',
            onTap: () => _clear(context),
          ),
          const SizedBox(width: 10),
          _SscdControlButton(
            icon: Icons.copy_all,
            label: 'Copy',
            onTap: () => _copy(context),
          ),
        ],
      ),
    );
  }

  void _selectAll(BuildContext context) {
    final BuildContext? c = regionKey.currentContext;
    if (c == null) {
      debugPrint('[Sscd] Select all — region context missing.');
      return;
    }
    final Object? invoked =
        Actions.maybeInvoke<SelectAllTextIntent>(
      c,
      const SelectAllTextIntent(SelectionChangedCause.keyboard),
    );
    debugPrint('[Sscd] Select all invoked=$invoked.');
  }

  void _clear(BuildContext context) {
    final BuildContext? c = regionKey.currentContext;
    if (c == null) {
      debugPrint('[Sscd] Clear — region context missing.');
      return;
    }
    final SelectableRegionState? state =
        c.findAncestorStateOfType<SelectableRegionState>();
    state?.clearSelection();
    debugPrint('[Sscd] Clear invoked; state=$state.');
  }

  void _copy(BuildContext context) {
    final BuildContext? c = regionKey.currentContext;
    if (c == null) {
      debugPrint('[Sscd] Copy — region context missing.');
      return;
    }
    final Object? invoked =
        Actions.maybeInvoke<CopySelectionTextIntent>(
      c,
      CopySelectionTextIntent.copy,
    );
    debugPrint('[Sscd] Copy invoked=$invoked.');
  }
}

class _SscdControlButton extends StatefulWidget {
  const _SscdControlButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  State<_SscdControlButton> createState() => _SscdControlButtonState();
}

class _SscdControlButtonState extends State<_SscdControlButton> {
  bool _hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hover = true),
      onExit: (_) => setState(() => _hover = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: _hover
                ? _kGold.withValues(alpha: 0.25)
                : _kGold.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: _hover ? _kGold : _kGold.withValues(alpha: 0.55),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(widget.icon, size: 15, color: _kGoldSoft),
              const SizedBox(width: 7),
              Text(
                widget.label,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kMarble,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// COMPARISON CARD — StaticSelectionContainerDelegate vs parent delegate.
// =============================================================================

class _SscdComparisonCard extends StatelessWidget {
  const _SscdComparisonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 20),
      decoration: BoxDecoration(
        color: _kMarble,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kGold.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SscdSectionHeader(
            caption: 'Comparison — Static vs MultiSelectable (base)',
            subtitle:
                'When to reach for the static delegate, and when to stay with the base.',
          ),
          const SizedBox(height: 12),
          _SscdComparisonHeaderRow(),
          const SizedBox(height: 4),
          for (final List<String> row in _kComparisonRows)
            _SscdComparisonRow(
              label: row[0],
              staticValue: row[1],
              baseValue: row[2],
            ),
        ],
      ),
    );
  }
}

class _SscdComparisonHeaderRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: _kObsidian,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        children: const <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              'aspect',
              style: TextStyle(
                fontSize: 11,
                color: _kGoldSoft,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'StaticSelectionContainerDelegate',
              style: TextStyle(
                fontSize: 11,
                color: _kGoldSoft,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'MultiSelectable… (base)',
              style: TextStyle(
                fontSize: 11,
                color: _kGoldSoft,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SscdComparisonRow extends StatelessWidget {
  const _SscdComparisonRow({
    required this.label,
    required this.staticValue,
    required this.baseValue,
  });
  final String label;
  final String staticValue;
  final String baseValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12.5,
                color: _kSlate,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 10),
              child: _SscdComparisonCell(
                text: staticValue,
                accent: _kGold,
              ),
            ),
          ),
          Expanded(
            child: _SscdComparisonCell(
              text: baseValue,
              accent: _kSlate,
            ),
          ),
        ],
      ),
    );
  }
}

class _SscdComparisonCell extends StatelessWidget {
  const _SscdComparisonCell({required this.text, required this.accent});
  final String text;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        border: Border(left: BorderSide(color: accent, width: 2.5)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12.5,
          color: _kObsidian,
          height: 1.4,
        ),
      ),
    );
  }
}

// =============================================================================
// API CARD — quoted methods and fields referenced by this demo.
// =============================================================================

class _SscdApiCard extends StatelessWidget {
  const _SscdApiCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 20),
      decoration: BoxDecoration(
        color: _kObsidian,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 6,
                height: 22,
                color: _kGold,
              ),
              const SizedBox(width: 10),
              const Text(
                'API Surface',
                style: TextStyle(
                  fontSize: 18,
                  color: _kMarble,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Methods and fields referenced by this demo — all inherited from '
            'MultiSelectableSelectionContainerDelegate or overridden on the '
            'static subclass.',
            style: TextStyle(
              fontSize: 12.5,
              color: _kMarble.withValues(alpha: 0.72),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 14),
          for (final List<String> row in _kApiRows)
            _SscdApiRow(signature: row[0], description: row[1]),
        ],
      ),
    );
  }
}

class _SscdApiRow extends StatelessWidget {
  const _SscdApiRow({required this.signature, required this.description});
  final String signature;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: BoxDecoration(
        color: _kObsidianSoft,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: _kGold.withValues(alpha: 0.8), width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            signature,
            style: const TextStyle(
              fontSize: 12.5,
              color: _kGoldSoft,
              fontFamily: 'monospace',
              fontWeight: FontWeight.w700,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: TextStyle(
              fontSize: 12.5,
              color: _kMarble.withValues(alpha: 0.85),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// PITFALL CARD — warnings about misuse.
// =============================================================================

class _SscdPitfallCard extends StatelessWidget {
  const _SscdPitfallCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(22, 18, 22, 20),
      decoration: BoxDecoration(
        color: _kVelvet.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _kVelvet.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: _kVelvet,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Icon(
                  Icons.priority_high,
                  size: 18,
                  color: _kMarble,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  'Pitfall — don\'t use this delegate for dynamic children',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: _kObsidian,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (final String bullet in _kPitfallBullets)
            _SscdPitfallBullet(text: bullet),
        ],
      ),
    );
  }
}

class _SscdPitfallBullet extends StatelessWidget {
  const _SscdPitfallBullet({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6, right: 10),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: _kVelvet,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 13,
                color: _kObsidian,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// FOOT CARTOUCHE — closing credit bar.
// =============================================================================

class _SscdFootCartouche extends StatelessWidget {
  const _SscdFootCartouche();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: _kObsidian,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          const Icon(Icons.account_balance, color: _kGold, size: 18),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Selection Plinth Hall — exhibit on '
              'StaticSelectionContainerDelegate. Hand-authored for the d4rt '
              'AST test harness.',
              style: TextStyle(
                fontSize: 12,
                color: _kMarble,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _kGold.withValues(alpha: 0.2),
              border: Border.all(color: _kGold.withValues(alpha: 0.7)),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Text(
              'widgets / selection',
              style: TextStyle(
                fontSize: 10,
                color: _kGoldSoft,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SHARED — section header widget.
// =============================================================================

class _SscdSectionHeader extends StatelessWidget {
  const _SscdSectionHeader({
    required this.caption,
    required this.subtitle,
  });

  final String caption;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 4,
              height: 20,
              color: _kGold,
            ),
            const SizedBox(width: 10),
            Text(
              caption,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: _kObsidian,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 14),
          child: Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: _kSlateSoft.withValues(alpha: 0.95),
            ),
          ),
        ),
      ],
    );
  }
}
