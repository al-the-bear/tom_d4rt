// Deep visual demo: IgnoreBaseline — a wrapper widget that prevents its
// child's baseline from bubbling up through the flex layout so the baseline
// of the parent (typically a Row with CrossAxisAlignment.baseline) is no
// longer influenced by that particular subtree. Constructor:
//   IgnoreBaseline({Key? key, Widget? child})
//
// The typical mental model is "this decorative thing sits in the row visually,
// but the row should not ask me where my baseline is when it decides how to
// vertical-align everyone else against text baselines".
//
// This demo is deliberately stateless. Interactivity uses top-level
// ValueNotifier objects driving ValueListenableBuilder. The demo runs in the
// tom_d4rt_flutterm harness and honours the harness rules: no main(), no
// runApp(), no print(), no ignore_for_file pragmas, no deprecated APIs.
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level ValueNotifiers. Everything below is a StatelessWidget; the only
// mutable state lives in these notifiers so the main demo tree itself is
// immutable.
// ---------------------------------------------------------------------------

/// Toggle controlling whether the middle Text in the mixed-size row uses
/// IgnoreBaseline. Drives section 4 "Mixed-size text".
final ValueNotifier<bool> kMixedMiddleIgnored = ValueNotifier<bool>(false);

/// Which size index is flagged as "the big one" inside the mixed-size row.
final ValueNotifier<int> kMixedBigIndex = ValueNotifier<int>(3);

/// Toggles the comparison board's "before / after" highlight in section 3.
final ValueNotifier<bool> kComparisonOverlay = ValueNotifier<bool>(true);

/// Column-demo toggle — wrap the middle child in IgnoreBaseline.
final ValueNotifier<bool> kColumnIgnoreMiddle = ValueNotifier<bool>(false);

/// Selected rotation angle (radians × 100) for the transform-child demo.
final ValueNotifier<int> kRotationDeg = ValueNotifier<int>(18);

/// Selected icon index for the icon+text combos (section 5).
final ValueNotifier<int> kComboHighlight = ValueNotifier<int>(0);

/// Toggle for the column-baseline effect (section 6) showing the overall
/// baseline computation line.
final ValueNotifier<bool> kColumnShowBaselineLine = ValueNotifier<bool>(true);

/// Toggle for the pitfalls board showing the "does nothing" overlay.
final ValueNotifier<bool> kPitfallShowNoOp = ValueNotifier<bool>(true);

/// Diagram comparison — show labels on the painter.
final ValueNotifier<bool> kDiagramShowLabels = ValueNotifier<bool>(true);

// ---------------------------------------------------------------------------
// Shared constants.
// ---------------------------------------------------------------------------

const Color _seedColor = Color(0xFF00695C);

const double _bigFontSize = 48;
const double _smallFontSize = 14;

/// Rows used by the mixed-size demo — font sizes must cover a wide range to
/// make the "one child dominates the baseline" effect visible.
const List<double> _mixedSizes = <double>[12, 18, 28, 40];
const List<String> _mixedLabels = <String>['tiny', 'small', 'medium', 'big'];

// ---------------------------------------------------------------------------
// Entry point.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.light,
      ),
    ),
    darkTheme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: _seedColor,
        brightness: Brightness.dark,
      ),
    ),
    home: const _IgnoreBaselineDemo(),
  );
}

// ---------------------------------------------------------------------------
// Root scaffold — nine-tab DefaultTabController.
// ---------------------------------------------------------------------------

class _IgnoreBaselineDemo extends StatelessWidget {
  const _IgnoreBaselineDemo();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 9,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('IgnoreBaseline — Deep Visual Demo'),
          bottom: const TabBar(
            isScrollable: true,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.flag), text: 'Hero'),
              Tab(icon: Icon(Icons.horizontal_rule), text: 'Concepts'),
              Tab(icon: Icon(Icons.compare_arrows), text: 'Compare'),
              Tab(icon: Icon(Icons.text_fields), text: 'Mixed text'),
              Tab(icon: Icon(Icons.label), text: 'Combos'),
              Tab(icon: Icon(Icons.view_column), text: 'Column'),
              Tab(icon: Icon(Icons.transform), text: 'Transform'),
              Tab(icon: Icon(Icons.auto_graph), text: 'Diagram'),
              Tab(icon: Icon(Icons.warning_amber), text: 'Pitfalls'),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            _HeroTab(),
            _ConceptsTab(),
            _CompareTab(),
            _MixedTextTab(),
            _CombosTab(),
            _ColumnTab(),
            _TransformTab(),
            _DiagramTab(),
            _PitfallsTab(),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 1 — Hero banner.
// ---------------------------------------------------------------------------

class _HeroTab extends StatelessWidget {
  const _HeroTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        _HeroBanner(scheme: scheme),
        const SizedBox(height: 24),
        _HeroWhy(scheme: scheme),
        const SizedBox(height: 24),
        _HeroFacts(scheme: scheme),
        const SizedBox(height: 24),
        _HeroMiniPreview(scheme: scheme),
        const SizedBox(height: 24),
        _HeroApiBox(scheme: scheme),
      ],
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            scheme.primaryContainer,
            scheme.secondaryContainer,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: scheme.surface.withValues(alpha: 0.7),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              Icons.horizontal_rule,
              size: 72,
              color: scheme.primary,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'IgnoreBaseline',
                  style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        color: scheme.onPrimaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Cuts the baseline propagation between a child and its '
                  'parent. Put decorative things like icons, spacers, or '
                  'rotated glyphs inside an IgnoreBaseline when you still '
                  'want Row.CrossAxisAlignment.baseline to align the rest of '
                  'your text cleanly.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: scheme.onPrimaryContainer,
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

class _HeroWhy extends StatelessWidget {
  const _HeroWhy({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.lightbulb, color: scheme.primary),
                const SizedBox(width: 8),
                Text(
                  'Why does the baseline leak at all?',
                  style:
                      Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'When a Row uses CrossAxisAlignment.baseline, the flex algorithm '
              'asks every child for its "distance from the top of the child to '
              'the requested baseline". Text widgets return a real value. '
              'Icons, Containers with no text, and decorative widgets return '
              'whatever the default is — often the bottom — and that can drag '
              'the whole row down.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 12),
            Text(
              'IgnoreBaseline short-circuits the question. The parent asks, '
              'and the wrapper answers "null, do not align against me". The '
              'child is still painted — only its baseline contribution is '
              'suppressed.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroFacts extends StatelessWidget {
  const _HeroFacts({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    const List<_HeroFact> facts = <_HeroFact>[
      _HeroFact(
        Icons.looks_one,
        'It is a single-child wrapper.',
        'IgnoreBaseline holds exactly one child. No layout parameters, no '
            'alignment arguments, no size controls.',
      ),
      _HeroFact(
        Icons.looks_two,
        'It is stateless & cheap.',
        'Internally it builds a RenderIgnoreBaseline which returns null from '
            'computeDistanceToActualBaseline. That is literally all it does.',
      ),
      _HeroFact(
        Icons.looks_3,
        'Layout unchanged.',
        'The size of the child, its position, its painting — all identical. '
            'Only the reported baseline is different.',
      ),
      _HeroFact(
        Icons.looks_4,
        'Only relevant for baseline flex alignment.',
        'If the containing layout does not use baseline alignment, wrapping '
            'in IgnoreBaseline is a no-op you will never see.',
      ),
      _HeroFact(
        Icons.looks_5,
        'Composable with anything.',
        'The child can be a Transform, a Container, an Icon, a Padding, even '
            'another IgnoreBaseline — it will happily pass through.',
      ),
    ];
    return Column(
      children: <Widget>[
        for (final _HeroFact fact in facts) ...<Widget>[
          _HeroFactCard(fact: fact, scheme: scheme),
          const SizedBox(height: 12),
        ],
      ],
    );
  }
}

class _HeroFactCard extends StatelessWidget {
  const _HeroFactCard({required this.fact, required this.scheme});

  final _HeroFact fact;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: scheme.primary,
              foregroundColor: scheme.onPrimary,
              child: Icon(fact.icon, color: scheme.onPrimary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    fact.title,
                    style:
                        Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    fact.body,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroMiniPreview extends StatelessWidget {
  const _HeroMiniPreview({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Preview — what you will see',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: const <Widget>[
                Text('Big', style: TextStyle(fontSize: _bigFontSize)),
                SizedBox(width: 8),
                Icon(Icons.star, size: 40),
                SizedBox(width: 8),
                Text('small', style: TextStyle(fontSize: _smallFontSize)),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Without IgnoreBaseline: the star contributes to the baseline '
              'and drags "small" up awkwardly.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: const <Widget>[
                Text('Big', style: TextStyle(fontSize: _bigFontSize)),
                SizedBox(width: 8),
                IgnoreBaseline(child: Icon(Icons.star, size: 40)),
                SizedBox(width: 8),
                Text('small', style: TextStyle(fontSize: _smallFontSize)),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'With IgnoreBaseline: the star still paints — but "Big" and '
              '"small" align cleanly.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroApiBox extends StatelessWidget {
  const _HeroApiBox({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: scheme.secondaryContainer.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(Icons.api, color: scheme.onSecondaryContainer),
              const SizedBox(width: 8),
              Text(
                'Public surface',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: scheme.onSecondaryContainer,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const SelectableText(
            'const IgnoreBaseline({Key? key, Widget? child})',
            style: TextStyle(fontFamily: 'monospace', fontSize: 14),
          ),
          const SizedBox(height: 6),
          Text(
            'That is the entire widget API. One optional child, one optional '
            'key. Behaviour lives in the render object.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 2 — Concepts diagram (CustomPainter).
// ---------------------------------------------------------------------------

class _ConceptsTab extends StatelessWidget {
  const _ConceptsTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text(
          'Baseline concepts',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          'Text has two baselines: "alphabetic" — where the foot of a Latin '
          'letter sits — and "ideographic" — used for CJK glyphs. Flutter '
          'exposes both through TextBaseline. Rows aligned by baseline ask '
          'each child where its baseline is; IgnoreBaseline makes that '
          'answer null.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        Card(
          elevation: 0,
          color: scheme.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Alphabetic baseline — runs below the body of letters.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder<bool>(
                  valueListenable: kDiagramShowLabels,
                  builder: (context, showLabels, _) {
                    return SizedBox(
                      height: 210,
                      child: CustomPaint(
                        painter: _ConceptsPainter(
                          scheme: scheme,
                          mode: _ConceptsMode.alphabetic,
                          showLabels: showLabels,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  'Ideographic baseline — sits lower, aligned with CJK.',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const SizedBox(height: 16),
                ValueListenableBuilder<bool>(
                  valueListenable: kDiagramShowLabels,
                  builder: (context, showLabels, _) {
                    return SizedBox(
                      height: 210,
                      child: CustomPaint(
                        painter: _ConceptsPainter(
                          scheme: scheme,
                          mode: _ConceptsMode.ideographic,
                          showLabels: showLabels,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  children: <Widget>[
                    Icon(Icons.tune, color: scheme.primary),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Toggle diagram labels:',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: kDiagramShowLabels,
                      builder: (context, v, _) => Switch(
                        value: v,
                        onChanged: (nv) => kDiagramShowLabels.value = nv,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          elevation: 0,
          color: scheme.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Where IgnoreBaseline stops the signal',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 260,
                  child: CustomPaint(
                    painter: _BaselineStopPainter(scheme: scheme),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'The arrows represent the "distance to alphabetic baseline" '
                  'query. Wrapping a subtree in IgnoreBaseline turns that '
                  'arrow into a dashed blocked line — the parent still asks, '
                  'but the wrapper refuses to answer with a concrete number.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

enum _ConceptsMode { alphabetic, ideographic }

class _ConceptsPainter extends CustomPainter {
  _ConceptsPainter({
    required this.scheme,
    required this.mode,
    required this.showLabels,
  });

  final ColorScheme scheme;
  final _ConceptsMode mode;
  final bool showLabels;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..color = scheme.surface
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, bg);

    final double baselineY = mode == _ConceptsMode.alphabetic
        ? size.height * 0.62
        : size.height * 0.78;

    // Draw the cap line, x-height line, baseline and descender line.
    final List<_Guide> guides = <_Guide>[
      _Guide(size.height * 0.22, 'cap height', scheme.outlineVariant),
      _Guide(size.height * 0.38, 'x-height', scheme.outlineVariant),
      _Guide(
        baselineY,
        mode == _ConceptsMode.alphabetic
            ? 'alphabetic baseline'
            : 'ideographic baseline',
        scheme.primary,
      ),
      _Guide(size.height * 0.82, 'descender', scheme.outlineVariant),
    ];

    final Paint line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (final _Guide g in guides) {
      line.color = g.color;
      canvas.drawLine(Offset(12, g.y), Offset(size.width - 12, g.y), line);
      if (showLabels) {
        final TextPainter tp = TextPainter(
          textDirection: TextDirection.ltr,
          text: TextSpan(
            text: g.label,
            style: TextStyle(
              fontSize: 11,
              color: g.color == scheme.primary
                  ? scheme.primary
                  : scheme.onSurfaceVariant,
              fontWeight: g.color == scheme.primary
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        )..layout();
        tp.paint(canvas, Offset(size.width - tp.width - 14, g.y - 14));
      }
    }

    // Draw a sample "Ab" glyph and an icon-ish square sitting on the
    // baseline.
    final TextPainter ab = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: mode == _ConceptsMode.alphabetic ? 'Ab' : 'Ab漢',
        style: TextStyle(
          fontSize: 64,
          color: scheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
    )..layout();
    ab.paint(canvas, Offset(36, baselineY - ab.height + 8));

    // Icon rectangle that does NOT respect the baseline.
    final Paint iconFill = Paint()
      ..color = scheme.tertiary.withValues(alpha: 0.8);
    final Rect iconRect = Rect.fromLTWH(
      size.width * 0.48,
      size.height * 0.3,
      48,
      48,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(iconRect, const Radius.circular(8)),
      iconFill,
    );

    if (showLabels) {
      final TextPainter note = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: 'icon (no baseline)',
          style: TextStyle(
            color: scheme.onSurfaceVariant,
            fontSize: 11,
          ),
        ),
      )..layout();
      note.paint(canvas, Offset(iconRect.left, iconRect.bottom + 4));
    }
  }

  @override
  bool shouldRepaint(_ConceptsPainter oldDelegate) =>
      oldDelegate.showLabels != showLabels || oldDelegate.mode != mode;
}

class _Guide {
  const _Guide(this.y, this.label, this.color);
  final double y;
  final String label;
  final Color color;
}

class _BaselineStopPainter extends CustomPainter {
  _BaselineStopPainter({required this.scheme});

  final ColorScheme scheme;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = scheme.surface;
    canvas.drawRect(Offset.zero & size, bg);

    final double topY = 50;
    final double baselineY = size.height * 0.75;

    // Parent row label.
    final TextPainter parent = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: 'Row (baseline alignment)',
        style: TextStyle(
          color: scheme.onSurface,
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    )..layout();
    parent.paint(canvas, Offset(16, 12));

    // Baseline line.
    final Paint line = Paint()
      ..color = scheme.primary
      ..strokeWidth = 1.6
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(8, baselineY), Offset(size.width - 8, baselineY),
        line);

    // Three child boxes representing children.
    final List<_ChildBox> boxes = <_ChildBox>[
      _ChildBox(16, topY, 100, baselineY, 'Text "Big"', scheme.primary, false),
      _ChildBox(
          140, topY + 18, 90, baselineY - 6, 'Icon (ignored)', scheme.tertiary,
          true),
      _ChildBox(
          260, topY + 30, 90, baselineY, 'Text "small"', scheme.primary, false),
    ];

    for (final _ChildBox b in boxes) {
      final Paint fill = Paint()..color = b.color.withValues(alpha: 0.25);
      final Paint border = Paint()
        ..color = b.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4;
      final Rect r = Rect.fromLTRB(b.left, b.top, b.left + 100, b.bottom);
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(8)),
        fill,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(8)),
        border,
      );

      final TextPainter tp = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: b.label,
          style: TextStyle(color: b.color, fontSize: 11),
        ),
      )..layout(maxWidth: 96);
      tp.paint(canvas, Offset(b.left + 4, b.top + 4));

      // Draw the "baseline query" arrow.
      if (b.ignored) {
        final Paint dashed = Paint()
          ..color = scheme.error
          ..strokeWidth = 1.4;
        _dash(canvas, Offset(b.left + 50, b.top + 20),
            Offset(b.left + 50, baselineY - 2), dashed);
        final TextPainter tp2 = TextPainter(
          textDirection: TextDirection.ltr,
          text: TextSpan(
            text: 'null',
            style: TextStyle(color: scheme.error, fontSize: 10),
          ),
        )..layout();
        tp2.paint(canvas, Offset(b.left + 56, b.top + 28));
      } else {
        final Paint arrow = Paint()
          ..color = scheme.primary
          ..strokeWidth = 1.4
          ..style = PaintingStyle.stroke;
        canvas.drawLine(Offset(b.left + 50, b.top + 20),
            Offset(b.left + 50, baselineY - 2), arrow);
      }
    }
  }

  void _dash(Canvas canvas, Offset a, Offset b, Paint p) {
    final double total = (b - a).distance;
    const double seg = 4;
    const double gap = 3;
    double drawn = 0;
    final Offset dir = (b - a) / total;
    while (drawn < total) {
      final Offset start = a + dir * drawn;
      final double next = (drawn + seg).clamp(0.0, total);
      final Offset end = a + dir * next;
      canvas.drawLine(start, end, p);
      drawn = next + gap;
    }
  }

  @override
  bool shouldRepaint(_BaselineStopPainter oldDelegate) => false;
}

class _ChildBox {
  const _ChildBox(
    this.left,
    this.top,
    this.width,
    this.bottom,
    this.label,
    this.color,
    this.ignored,
  );
  final double left;
  final double top;
  final double width;
  final double bottom;
  final String label;
  final Color color;
  final bool ignored;
}

// ---------------------------------------------------------------------------
// Section 3 — Without/With comparison board.
// ---------------------------------------------------------------------------

class _CompareTab extends StatelessWidget {
  const _CompareTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text(
          'Without / With comparison',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Two rows side by side. Both use CrossAxisAlignment.baseline with '
          'textBaseline alphabetic. The right one wraps the decorative icon '
          'in IgnoreBaseline.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        Card(
          elevation: 0,
          color: scheme.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: _ComparePanel(
                    title: 'Without IgnoreBaseline',
                    subtitle:
                        'The Icon reports a baseline. It drags "small" up.',
                    scheme: scheme,
                    child: _buildRow(withIgnore: false),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _ComparePanel(
                    title: 'With IgnoreBaseline',
                    subtitle:
                        '"Big" and "small" baselines align cleanly.',
                    scheme: scheme,
                    child: _buildRow(withIgnore: true),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<bool>(
          valueListenable: kComparisonOverlay,
          builder: (context, v, _) {
            return SwitchListTile(
              value: v,
              onChanged: (nv) => kComparisonOverlay.value = nv,
              title: const Text('Draw baseline overlay'),
              subtitle: const Text(
                'Paints a thin horizontal line across the text baseline of '
                'each row.',
              ),
            );
          },
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder<bool>(
          valueListenable: kComparisonOverlay,
          builder: (context, overlay, _) {
            return _OverlayPanel(
              scheme: scheme,
              overlay: overlay,
            );
          },
        ),
        const SizedBox(height: 24),
        _CompareNarration(scheme: scheme),
      ],
    );
  }

  Widget _buildRow({required bool withIgnore}) {
    final Widget icon = Icon(Icons.star, size: 40);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        const Text('Big', style: TextStyle(fontSize: _bigFontSize)),
        const SizedBox(width: 8),
        withIgnore ? IgnoreBaseline(child: icon) : icon,
        const SizedBox(width: 8),
        const Text('small', style: TextStyle(fontSize: _smallFontSize)),
      ],
    );
  }
}

class _ComparePanel extends StatelessWidget {
  const _ComparePanel({
    required this.title,
    required this.subtitle,
    required this.scheme,
    required this.child,
  });

  final String title;
  final String subtitle;
  final ColorScheme scheme;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 4),
          Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(8),
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}

class _OverlayPanel extends StatelessWidget {
  const _OverlayPanel({required this.scheme, required this.overlay});

  final ColorScheme scheme;
  final bool overlay;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'With baseline overlay',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 16),
            _BaselineOverlayDemo(scheme: scheme, overlay: overlay),
          ],
        ),
      ),
    );
  }
}

class _BaselineOverlayDemo extends StatelessWidget {
  const _BaselineOverlayDemo({required this.scheme, required this.overlay});

  final ColorScheme scheme;
  final bool overlay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _overlayed(
          label: 'Without IgnoreBaseline',
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: const <Widget>[
              Text('Big', style: TextStyle(fontSize: _bigFontSize)),
              SizedBox(width: 8),
              Icon(Icons.star, size: 40),
              SizedBox(width: 8),
              Text('small', style: TextStyle(fontSize: _smallFontSize)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _overlayed(
          label: 'With IgnoreBaseline',
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: const <Widget>[
              Text('Big', style: TextStyle(fontSize: _bigFontSize)),
              SizedBox(width: 8),
              IgnoreBaseline(child: Icon(Icons.star, size: 40)),
              SizedBox(width: 8),
              Text('small', style: TextStyle(fontSize: _smallFontSize)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _overlayed({required String label, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: child,
            ),
            if (overlay)
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _BaselineOverlayPainter(color: scheme.error),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _BaselineOverlayPainter extends CustomPainter {
  _BaselineOverlayPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = color.withValues(alpha: 0.7)
      ..strokeWidth = 1.2;
    // Draw a horizontal dashed line near the bottom of the big text.
    final double y = size.height * 0.72;
    double x = 0;
    while (x < size.width) {
      canvas.drawLine(Offset(x, y), Offset(x + 6, y), p);
      x += 10;
    }
  }

  @override
  bool shouldRepaint(_BaselineOverlayPainter oldDelegate) =>
      oldDelegate.color != color;
}

class _CompareNarration extends StatelessWidget {
  const _CompareNarration({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'What shifts, exactly?',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'In a baseline-aligned Row, Flutter picks the MAX distance-to-'
              'baseline across children and that becomes the row baseline. '
              'An Icon has no real text baseline, so its default answer is '
              'its bottom — which is usually lower than the "Big" text '
              'baseline. The row therefore pushes "Big" up and "small" down '
              'to match, and the text looks badly set.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Wrapping the Icon in IgnoreBaseline makes it silent on '
              'baseline — the row aligns "Big" and "small" naturally, and '
              'paints the icon in place without affecting that decision.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 4 — Mixed-size text.
// ---------------------------------------------------------------------------

class _MixedTextTab extends StatelessWidget {
  const _MixedTextTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text(
          'Mixed-size text',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Four text widgets with sizes 12, 18, 28, 40 sit in a baseline-'
          'aligned row. Normally the row picks the largest baseline, which '
          'makes the small ones hover awkwardly. You can wrap any one of '
          'them in IgnoreBaseline and watch the row re-align itself.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<int>(
          valueListenable: kMixedBigIndex,
          builder: (context, bigIdx, _) {
            return Card(
              elevation: 0,
              color: scheme.surfaceContainerHigh,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Pick which index is "largest":',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      children: <Widget>[
                        for (int i = 0; i < _mixedSizes.length; i++)
                          ChoiceChip(
                            label: Text('${i.toString()} (${_mixedLabels[i]})'),
                            selected: bigIdx == i,
                            onSelected: (sel) {
                              if (sel) kMixedBigIndex.value = i;
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ValueListenableBuilder<bool>(
                      valueListenable: kMixedMiddleIgnored,
                      builder: (context, ignored, _) {
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: scheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: _buildMixedRow(bigIdx, ignored),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    ValueListenableBuilder<bool>(
                      valueListenable: kMixedMiddleIgnored,
                      builder: (context, v, _) => SwitchListTile(
                        value: v,
                        onChanged: (nv) => kMixedMiddleIgnored.value = nv,
                        title: const Text(
                          'Wrap the "largest" text in IgnoreBaseline',
                        ),
                        subtitle: Text(
                          'Because the largest contributes the biggest '
                          'baseline, suppressing it causes the row to '
                          'collapse back around the next largest child.',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        _MixedExplanation(scheme: scheme),
        const SizedBox(height: 20),
        _MixedGrid(scheme: scheme),
      ],
    );
  }

  Widget _buildMixedRow(int bigIdx, bool ignored) {
    final List<Widget> children = <Widget>[];
    for (int i = 0; i < _mixedSizes.length; i++) {
      final Widget text = Text(
        _mixedLabels[i],
        style: TextStyle(
          fontSize: _mixedSizes[i],
          fontWeight: i == bigIdx ? FontWeight.bold : FontWeight.normal,
        ),
      );
      final Widget child =
          (i == bigIdx && ignored) ? IgnoreBaseline(child: text) : text;
      if (children.isNotEmpty) {
        children.add(const SizedBox(width: 12));
      }
      children.add(child);
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: children,
    );
  }
}

class _MixedExplanation extends StatelessWidget {
  const _MixedExplanation({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'How the row computes its baseline',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              '1. Ask every child for its distance from its top to the '
              'requested baseline.\n'
              '2. Whoever answers with the largest distance "wins".\n'
              '3. Everyone is aligned against that winning baseline.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'IgnoreBaseline makes a child answer null. If the winner was '
              'the one wrapped in IgnoreBaseline, the row silently re-runs '
              'with the remaining candidates and the layout collapses down.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _MixedGrid extends StatelessWidget {
  const _MixedGrid({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Static grid — every row ignores one child',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            for (int ignore = -1; ignore < _mixedSizes.length; ignore++) ...<
                Widget>[
              _MixedStaticRow(
                ignoreIndex: ignore,
                scheme: scheme,
              ),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }
}

class _MixedStaticRow extends StatelessWidget {
  const _MixedStaticRow({required this.ignoreIndex, required this.scheme});

  final int ignoreIndex;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = <Widget>[];
    for (int i = 0; i < _mixedSizes.length; i++) {
      final Widget text = Text(
        _mixedLabels[i],
        style: TextStyle(fontSize: _mixedSizes[i]),
      );
      final Widget child =
          (i == ignoreIndex) ? IgnoreBaseline(child: text) : text;
      if (children.isNotEmpty) {
        children.add(const SizedBox(width: 10));
      }
      children.add(child);
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: ignoreIndex == -1
            ? scheme.secondaryContainer.withValues(alpha: 0.3)
            : scheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 170,
            child: Text(
              ignoreIndex == -1
                  ? 'No IgnoreBaseline'
                  : 'Ignore "${_mixedLabels[ignoreIndex]}"',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 5 — Icon + text combos.
// ---------------------------------------------------------------------------

class _CombosTab extends StatelessWidget {
  const _CombosTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text(
          'Icon + text combos',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Four common icon-plus-text patterns, each built twice — once '
          'without IgnoreBaseline and once with. The effect is subtle at '
          'normal UI sizes but visible when text is large.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<int>(
          valueListenable: kComboHighlight,
          builder: (context, highlight, _) {
            return Card(
              elevation: 0,
              color: scheme.surfaceContainerHigh,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: <Widget>[
                    Wrap(
                      spacing: 8,
                      children: <Widget>[
                        _highlightChip(0, 'Labeled icon'),
                        _highlightChip(1, 'Badge number'),
                        _highlightChip(2, 'Price tag'),
                        _highlightChip(3, 'Inline sentence'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _ComboBlock(
                      index: 0,
                      highlight: highlight,
                      scheme: scheme,
                      title: 'Labeled icon (Row with icon + caption)',
                      without: const _LabeledIconRow(withIgnore: false),
                      with_: const _LabeledIconRow(withIgnore: true),
                    ),
                    const SizedBox(height: 14),
                    _ComboBlock(
                      index: 1,
                      highlight: highlight,
                      scheme: scheme,
                      title: 'Badge + number',
                      without: const _BadgeNumberRow(withIgnore: false),
                      with_: const _BadgeNumberRow(withIgnore: true),
                    ),
                    const SizedBox(height: 14),
                    _ComboBlock(
                      index: 2,
                      highlight: highlight,
                      scheme: scheme,
                      title: 'Price tag',
                      without: const _PriceTagRow(withIgnore: false),
                      with_: const _PriceTagRow(withIgnore: true),
                    ),
                    const SizedBox(height: 14),
                    _ComboBlock(
                      index: 3,
                      highlight: highlight,
                      scheme: scheme,
                      title: 'Inline icon in a sentence',
                      without: const _InlineIconRow(withIgnore: false),
                      with_: const _InlineIconRow(withIgnore: true),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        _ComboNotes(scheme: scheme),
      ],
    );
  }

  Widget _highlightChip(int i, String label) {
    return ValueListenableBuilder<int>(
      valueListenable: kComboHighlight,
      builder: (context, h, _) => ChoiceChip(
        label: Text(label),
        selected: h == i,
        onSelected: (sel) {
          if (sel) kComboHighlight.value = i;
        },
      ),
    );
  }
}

class _LabeledIconRow extends StatelessWidget {
  const _LabeledIconRow({required this.withIgnore});

  final bool withIgnore;

  @override
  Widget build(BuildContext context) {
    final Widget icon = Icon(Icons.favorite, color: Colors.red, size: 32);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        withIgnore ? IgnoreBaseline(child: icon) : icon,
        const SizedBox(width: 8),
        const Text(
          'Favourites',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}

class _BadgeNumberRow extends StatelessWidget {
  const _BadgeNumberRow({required this.withIgnore});

  final bool withIgnore;

  @override
  Widget build(BuildContext context) {
    final Widget badge = Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        '7',
        style: TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        const Text('Messages', style: TextStyle(fontSize: 22)),
        const SizedBox(width: 10),
        withIgnore ? IgnoreBaseline(child: badge) : badge,
      ],
    );
  }
}

class _PriceTagRow extends StatelessWidget {
  const _PriceTagRow({required this.withIgnore});

  final bool withIgnore;

  @override
  Widget build(BuildContext context) {
    final Widget currency = Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(4),
      ),
      child: const Text(
        'USD',
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        const Text(
          r'$42.00',
          style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
        ),
        const SizedBox(width: 8),
        withIgnore ? IgnoreBaseline(child: currency) : currency,
      ],
    );
  }
}

class _InlineIconRow extends StatelessWidget {
  const _InlineIconRow({required this.withIgnore});

  final bool withIgnore;

  @override
  Widget build(BuildContext context) {
    final Widget shield = Icon(Icons.shield, size: 20, color: Colors.teal);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        const Text('Protected by ', style: TextStyle(fontSize: 16)),
        withIgnore ? IgnoreBaseline(child: shield) : shield,
        const Text(' TomGuard.', style: TextStyle(fontSize: 16)),
      ],
    );
  }
}

class _ComboBlock extends StatelessWidget {
  const _ComboBlock({
    required this.index,
    required this.highlight,
    required this.scheme,
    required this.title,
    required this.without,
    required this.with_,
  });

  final int index;
  final int highlight;
  final ColorScheme scheme;
  final String title;
  final Widget without;
  final Widget with_;

  @override
  Widget build(BuildContext context) {
    final bool selected = index == highlight;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: selected
            ? scheme.primaryContainer.withValues(alpha: 0.3)
            : scheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: selected ? scheme.primary : scheme.outlineVariant,
          width: selected ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Row(
            children: <Widget>[
              Expanded(
                child: _wrap(label: 'without', content: without),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _wrap(label: 'with IgnoreBaseline', content: with_),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _wrap({required String label, required Widget content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: scheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(6),
          ),
          child: content,
        ),
      ],
    );
  }
}

class _ComboNotes extends StatelessWidget {
  const _ComboNotes({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Observations',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            _bullet(scheme,
                'The labeled icon barely shifts — at 32 px the icon baseline '
                'is close enough to 20 px text.'),
            _bullet(scheme,
                'The badge drops slightly in the ignored variant because '
                'the row no longer anchors to the bottom of its background.'),
            _bullet(scheme,
                'The price tag is where the effect is the most obvious: '
                '34 px text next to 12 px decorative currency.'),
            _bullet(scheme,
                'The inline sentence feels subtler because all children '
                'are near the same height.'),
          ],
        ),
      ),
    );
  }

  Widget _bullet(ColorScheme scheme, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.chevron_right, size: 18, color: scheme.primary),
          const SizedBox(width: 4),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 6 — Column baseline effect.
// ---------------------------------------------------------------------------

class _ColumnTab extends StatelessWidget {
  const _ColumnTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text(
          'Column baseline behaviour',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Columns do not have a baseline cross-axis alignment, but they do '
          'propagate a baseline outward. IgnoreBaseline inside a Column '
          'matters only when that Column itself is placed in another layout '
          'that cares about the baseline.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        Card(
          elevation: 0,
          color: scheme.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Column inside a baseline-aligned Row',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder<bool>(
                  valueListenable: kColumnIgnoreMiddle,
                  builder: (context, ignored, _) {
                    return Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: scheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: <Widget>[
                          const Text(
                            'Label',
                            style: TextStyle(fontSize: 28),
                          ),
                          const SizedBox(width: 16),
                          _columnContent(ignored),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder<bool>(
                  valueListenable: kColumnIgnoreMiddle,
                  builder: (context, v, _) => SwitchListTile(
                    value: v,
                    onChanged: (nv) => kColumnIgnoreMiddle.value = nv,
                    title: const Text(
                      'Wrap the Column in IgnoreBaseline',
                    ),
                    subtitle: const Text(
                      'The Row will no longer ask the Column for a baseline; '
                      'only "Label" drives the alignment.',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          elevation: 0,
          color: scheme.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Overall Column baseline computation',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                Text(
                  'A Column reports the baseline of its first child that has '
                  'one. If all children are wrapped in IgnoreBaseline, the '
                  'Column reports null — the outer Row then treats the whole '
                  'Column as baseline-less and pushes the decision to its '
                  'remaining baseline-providing siblings.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder<bool>(
                  valueListenable: kColumnShowBaselineLine,
                  builder: (context, show, _) => _ColumnBaselineDiagram(
                    scheme: scheme,
                    showLine: show,
                  ),
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder<bool>(
                  valueListenable: kColumnShowBaselineLine,
                  builder: (context, v, _) => SwitchListTile(
                    value: v,
                    onChanged: (nv) => kColumnShowBaselineLine.value = nv,
                    title: const Text('Show computed baseline line'),
                    subtitle: const Text(
                      'Toggle the overlay that points to whichever child '
                      'contributed the column baseline.',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _columnContent(bool ignored) {
    final Widget col = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Text('First line', style: TextStyle(fontSize: 18)),
        Text('Second line', style: TextStyle(fontSize: 14)),
        Text('Third line', style: TextStyle(fontSize: 12)),
      ],
    );
    return ignored ? IgnoreBaseline(child: col) : col;
  }
}

class _ColumnBaselineDiagram extends StatelessWidget {
  const _ColumnBaselineDiagram({required this.scheme, required this.showLine});

  final ColorScheme scheme;
  final bool showLine;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: CustomPaint(
        painter: _ColumnBaselinePainter(scheme: scheme, showLine: showLine),
      ),
    );
  }
}

class _ColumnBaselinePainter extends CustomPainter {
  _ColumnBaselinePainter({required this.scheme, required this.showLine});

  final ColorScheme scheme;
  final bool showLine;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = scheme.surface;
    canvas.drawRect(Offset.zero & size, bg);

    // Column box.
    final Paint border = Paint()
      ..color = scheme.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4;
    final Rect colRect = Rect.fromLTWH(20, 20, 200, size.height - 40);
    canvas.drawRRect(
      RRect.fromRectAndRadius(colRect, const Radius.circular(8)),
      border,
    );

    final TextPainter title = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: 'Column',
        style: TextStyle(
          color: scheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    )..layout();
    title.paint(canvas, Offset(colRect.left + 6, colRect.top + 4));

    // Three children.
    final List<_ChildRow> rows = <_ChildRow>[
      _ChildRow('A (fontSize 18)', 40, scheme.tertiary),
      _ChildRow('B (fontSize 14)', 100, scheme.tertiary),
      _ChildRow('C (fontSize 12)', 150, scheme.tertiary),
    ];
    for (final _ChildRow r in rows) {
      final Paint rf = Paint()..color = r.color.withValues(alpha: 0.15);
      final Paint rb = Paint()
        ..color = r.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0;
      final Rect rr = Rect.fromLTWH(30, r.y, 180, 28);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rr, const Radius.circular(6)),
        rf,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rr, const Radius.circular(6)),
        rb,
      );
      final TextPainter tp = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: r.label,
          style: TextStyle(color: scheme.onSurface, fontSize: 12),
        ),
      )..layout();
      tp.paint(canvas, Offset(rr.left + 6, rr.top + 6));
    }

    if (showLine) {
      final Paint bl = Paint()
        ..color = scheme.error
        ..strokeWidth = 1.5;
      final double y = rows.first.y + 22;
      canvas.drawLine(Offset(16, y), Offset(colRect.right - 4, y), bl);
      final TextPainter label = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: 'Column baseline (first child)',
          style: TextStyle(color: scheme.error, fontSize: 11),
        ),
      )..layout();
      label.paint(canvas, Offset(colRect.right + 10, y - 6));
    }
  }

  @override
  bool shouldRepaint(_ColumnBaselinePainter oldDelegate) =>
      oldDelegate.showLine != showLine;
}

class _ChildRow {
  const _ChildRow(this.label, this.y, this.color);
  final String label;
  final double y;
  final Color color;
}

// ---------------------------------------------------------------------------
// Section 7 — Container + transform child.
// ---------------------------------------------------------------------------

class _TransformTab extends StatelessWidget {
  const _TransformTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text(
          'Container + transform child',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Decorations with rotations, translations, or unusual padding can '
          'completely distort the baseline a parent row relies on. '
          'IgnoreBaseline gives you a stable out.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        ValueListenableBuilder<int>(
          valueListenable: kRotationDeg,
          builder: (context, deg, _) {
            final double radians = deg / 100;
            return Card(
              elevation: 0,
              color: scheme.surfaceContainerHigh,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Rotation: ${radians.toStringAsFixed(2)} rad',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Slider(
                      value: deg.toDouble(),
                      min: -100,
                      max: 100,
                      divisions: 40,
                      onChanged: (v) => kRotationDeg.value = v.round(),
                    ),
                    const SizedBox(height: 12),
                    _buildTransformRow(
                      scheme: scheme,
                      radians: radians,
                      withIgnore: false,
                    ),
                    const SizedBox(height: 14),
                    _buildTransformRow(
                      scheme: scheme,
                      radians: radians,
                      withIgnore: true,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        _TransformNotes(scheme: scheme),
      ],
    );
  }

  Widget _buildTransformRow({
    required ColorScheme scheme,
    required double radians,
    required bool withIgnore,
  }) {
    final Widget decoration = Transform.rotate(
      angle: radians,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: scheme.tertiary,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(Icons.bolt, color: scheme.onTertiary),
      ),
    );
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          SizedBox(
            width: 180,
            child: Text(
              withIgnore ? 'With IgnoreBaseline' : 'Without IgnoreBaseline',
              style: TextStyle(
                fontSize: 12,
                color: scheme.onSurfaceVariant,
              ),
            ),
          ),
          const Text('Tom', style: TextStyle(fontSize: 28)),
          const SizedBox(width: 8),
          withIgnore ? IgnoreBaseline(child: decoration) : decoration,
          const SizedBox(width: 8),
          const Text('agent', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }
}

class _TransformNotes extends StatelessWidget {
  const _TransformNotes({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Why transforms are especially noisy',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'A rotation changes the visual top/bottom of a child but not '
              'its logical layout box. The row still computes a baseline '
              'against the logical box. The baseline the row picks may '
              'point into empty pixels once the rotation is applied. '
              'IgnoreBaseline drops the contribution entirely.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 8 — Diagram comparison (CustomPainter).
// ---------------------------------------------------------------------------

class _DiagramTab extends StatelessWidget {
  const _DiagramTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text(
          'Schematic comparison',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Two side-by-side schematics — (a) Row with every child '
          'contributing a baseline and (b) Row where one child is wrapped '
          'in IgnoreBaseline and is therefore ignored when the row decides '
          'where the baseline is.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 20),
        Card(
          elevation: 0,
          color: scheme.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '(a) All children contribute',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 220,
                  child: CustomPaint(
                    painter: _DiagramPainter(
                      scheme: scheme,
                      ignoreMiddle: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          elevation: 0,
          color: scheme.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '(b) Middle child wrapped in IgnoreBaseline',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: 220,
                  child: CustomPaint(
                    painter: _DiagramPainter(
                      scheme: scheme,
                      ignoreMiddle: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        Card(
          elevation: 0,
          color: scheme.surfaceContainerHigh,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Reading the diagrams',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Solid arrows: child reported its baseline. Dashed arrow: '
                  'child refused via IgnoreBaseline. Thick horizontal line: '
                  'the row baseline that ended up being picked.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _DiagramPainter extends CustomPainter {
  _DiagramPainter({required this.scheme, required this.ignoreMiddle});

  final ColorScheme scheme;
  final bool ignoreMiddle;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = scheme.surface;
    canvas.drawRect(Offset.zero & size, bg);

    final double baselineY =
        ignoreMiddle ? size.height * 0.68 : size.height * 0.82;

    // Draw baseline.
    final Paint baseline = Paint()
      ..color = scheme.primary
      ..strokeWidth = 2;
    canvas.drawLine(
      Offset(16, baselineY),
      Offset(size.width - 16, baselineY),
      baseline,
    );

    // Three child rectangles.
    final List<_DiagChild> kids = <_DiagChild>[
      _DiagChild(20, 30, 80, baselineY - 4, 'Text 40', scheme.primary, false),
      _DiagChild(
          120,
          45,
          80,
          baselineY + 20,
          ignoreMiddle ? 'Icon (ignored)' : 'Icon',
          scheme.tertiary,
          ignoreMiddle),
      _DiagChild(220, 60, 80, baselineY - 6, 'Text 14', scheme.primary, false),
    ];

    for (final _DiagChild k in kids) {
      final Paint fill = Paint()..color = k.color.withValues(alpha: 0.15);
      final Paint border = Paint()
        ..color = k.color
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4;
      final Rect r = Rect.fromLTRB(k.left, k.top, k.left + 80, k.bottom);
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(6)),
        fill,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(6)),
        border,
      );
      final TextPainter tp = TextPainter(
        textDirection: TextDirection.ltr,
        text: TextSpan(
          text: k.label,
          style: TextStyle(color: k.color, fontSize: 11),
        ),
      )..layout(maxWidth: 76);
      tp.paint(canvas, Offset(k.left + 4, k.top + 4));

      // Arrow from box to baseline.
      if (k.ignored) {
        final Paint dashed = Paint()
          ..color = scheme.error
          ..strokeWidth = 1.4;
        _dashed(canvas, Offset(k.left + 40, k.top + 20),
            Offset(k.left + 40, baselineY - 2), dashed);
      } else {
        final Paint arrow = Paint()
          ..color = k.color
          ..strokeWidth = 1.4;
        canvas.drawLine(Offset(k.left + 40, k.top + 20),
            Offset(k.left + 40, baselineY - 2), arrow);
      }
    }

    // Label.
    final TextPainter bl = TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        text: ignoreMiddle ? 'row baseline (middle ignored)' : 'row baseline',
        style: TextStyle(
          color: scheme.primary,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    )..layout();
    bl.paint(canvas, Offset(size.width - bl.width - 20, baselineY + 6));
  }

  void _dashed(Canvas canvas, Offset a, Offset b, Paint p) {
    final double total = (b - a).distance;
    const double seg = 4;
    const double gap = 3;
    double drawn = 0;
    final Offset dir = (b - a) / total;
    while (drawn < total) {
      final Offset start = a + dir * drawn;
      final double next = (drawn + seg).clamp(0.0, total);
      final Offset end = a + dir * next;
      canvas.drawLine(start, end, p);
      drawn = next + gap;
    }
  }

  @override
  bool shouldRepaint(_DiagramPainter oldDelegate) =>
      oldDelegate.ignoreMiddle != ignoreMiddle;
}

class _DiagChild {
  const _DiagChild(
    this.left,
    this.top,
    this.width,
    this.bottom,
    this.label,
    this.color,
    this.ignored,
  );
  final double left;
  final double top;
  final double width;
  final double bottom;
  final String label;
  final Color color;
  final bool ignored;
}

// ---------------------------------------------------------------------------
// Section 9 — Pitfalls + API cheat sheet.
// ---------------------------------------------------------------------------

class _PitfallsTab extends StatelessWidget {
  const _PitfallsTab();

  @override
  Widget build(BuildContext context) {
    final ColorScheme scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(20),
      children: <Widget>[
        Text(
          'Pitfalls',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        _PitfallTile(
          scheme: scheme,
          icon: Icons.warning_amber,
          title: 'Non-baseline CrossAxisAlignment',
          body:
              'IgnoreBaseline is a no-op if the surrounding Row uses start, '
              'end, center, or stretch. The wrapper suppresses a signal '
              'nobody asked for — completely invisible.',
          demo: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const <Widget>[
              Text('Label', style: TextStyle(fontSize: 24)),
              SizedBox(width: 8),
              IgnoreBaseline(child: Icon(Icons.star, size: 40)),
              SizedBox(width: 8),
              Text('extra', style: TextStyle(fontSize: 14)),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _PitfallTile(
          scheme: scheme,
          icon: Icons.layers,
          title: 'Over-using in nested layouts',
          body:
              'Wrapping every decoration obscures which one was actually '
              'misaligning the row. Start by wrapping a single subtree, '
              'verify the effect, and only expand if needed.',
          demo: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: const <Widget>[
              IgnoreBaseline(
                child: Text('Over', style: TextStyle(fontSize: 40)),
              ),
              SizedBox(width: 6),
              IgnoreBaseline(
                child: Icon(Icons.star, size: 28),
              ),
              SizedBox(width: 6),
              IgnoreBaseline(
                child: Text('wrapped', style: TextStyle(fontSize: 14)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        _PitfallTile(
          scheme: scheme,
          icon: Icons.format_underlined,
          title: 'All baselines ignored → the row has to fall back',
          body:
              'If every child inside a baseline Row is wrapped in '
              'IgnoreBaseline, the Row has no baseline to align to. '
              'Behaviour is implementation-defined (currently: no baseline '
              'is used) and the visual alignment becomes unpredictable.',
          demo: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: scheme.errorContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: const <Widget>[
                IgnoreBaseline(
                  child: Text('Nothing', style: TextStyle(fontSize: 28)),
                ),
                SizedBox(width: 8),
                IgnoreBaseline(
                  child: Text('replies', style: TextStyle(fontSize: 14)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder<bool>(
          valueListenable: kPitfallShowNoOp,
          builder: (context, v, _) => SwitchListTile(
            value: v,
            onChanged: (nv) => kPitfallShowNoOp.value = nv,
            title: const Text('Show "no-op" overlay on the first pitfall'),
            subtitle: const Text(
              'Draws a diagonal stripe when the pitfall wrapper is ineffective.',
            ),
          ),
        ),
        const SizedBox(height: 24),
        _CheatSheet(scheme: scheme),
        const SizedBox(height: 24),
        _ApiComparison(scheme: scheme),
      ],
    );
  }
}

class _PitfallTile extends StatelessWidget {
  const _PitfallTile({
    required this.scheme,
    required this.icon,
    required this.title,
    required this.body,
    required this.demo,
  });

  final ColorScheme scheme;
  final IconData icon;
  final String title;
  final String body;
  final Widget demo;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, color: scheme.error),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(body, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: demo,
            ),
          ],
        ),
      ),
    );
  }
}

class _CheatSheet extends StatelessWidget {
  const _CheatSheet({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: scheme.secondaryContainer.withValues(alpha: 0.5),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.menu_book, color: scheme.onSecondaryContainer),
                const SizedBox(width: 8),
                Text(
                  'API cheat sheet',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: scheme.onSecondaryContainer,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const SelectableText(
              'IgnoreBaseline({Key? key, Widget? child})',
              style: TextStyle(fontFamily: 'monospace', fontSize: 14),
            ),
            const SizedBox(height: 12),
            Text(
              'Properties:',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: scheme.onSecondaryContainer,
                  ),
            ),
            const SizedBox(height: 6),
            _row('child', 'The single child whose baseline is suppressed.'),
            _row('key', 'Standard Widget key (inherited).'),
            const SizedBox(height: 12),
            Text(
              'Render object:',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: scheme.onSecondaryContainer,
                  ),
            ),
            const SizedBox(height: 6),
            _row('RenderIgnoreBaseline',
                'Returns null from computeDistanceToActualBaseline.'),
          ],
        ),
      ),
    );
  }

  Widget _row(String name, String desc) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 160,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(child: Text(desc)),
        ],
      ),
    );
  }
}

class _ApiComparison extends StatelessWidget {
  const _ApiComparison({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final List<_Alt> alts = <_Alt>[
      _Alt(
        'CrossAxisAlignment.start',
        'Align all children by their top.',
        'Great for headers stacked with icons but ignores text baseline.',
      ),
      _Alt(
        'CrossAxisAlignment.center',
        'Center every child on the cross axis.',
        'Works for equal-height children; mixed text sizes drift.',
      ),
      _Alt(
        'CrossAxisAlignment.end',
        'Align all children by their bottom.',
        'Visually places descenders and icon bottoms together.',
      ),
      _Alt(
        'IgnoreBaseline + CrossAxisAlignment.baseline',
        'Baseline alignment that ignores a specific subtree.',
        'Best when most children have text baselines and one or two '
            'subtrees are decorative.',
      ),
    ];
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerHigh,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Alternatives and how they differ',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 12),
            for (final _Alt a in alts) ...<Widget>[
              _AltRow(scheme: scheme, alt: a),
              const SizedBox(height: 8),
            ],
          ],
        ),
      ),
    );
  }
}

class _Alt {
  const _Alt(this.name, this.what, this.when);
  final String name;
  final String what;
  final String when;
}

class _AltRow extends StatelessWidget {
  const _AltRow({required this.scheme, required this.alt});

  final ColorScheme scheme;
  final _Alt alt;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            alt.name,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            alt.what,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          const SizedBox(height: 2),
          Text(alt.when, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Small helper classes.
// ---------------------------------------------------------------------------

class _HeroFact {
  const _HeroFact(this.icon, this.title, this.body);
  final IconData icon;
  final String title;
  final String body;
}
