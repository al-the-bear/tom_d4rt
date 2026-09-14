// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =====================================================================
// CupertinoLinearActivityIndicator — Deep Visual Demo
// =====================================================================
//
// This file is a hand-authored, analyzer-clean visual showcase for the
// Cupertino-style horizontal progress bar widget that ships with the
// Flutter framework as `CupertinoLinearActivityIndicator`.
//
// Constructor signature (from package:flutter/cupertino.dart):
//
//   const CupertinoLinearActivityIndicator({
//     Key? key,
//     required double progress,   // 0.0 .. 1.0
//     double height = 4.5,        // must be > 0
//     Color? color,               // defaults to CupertinoColors.activeBlue
//   })
//
// Notably absent from the public API (compared to its Material cousin
// `LinearProgressIndicator`):
//
//   * No `backgroundColor` parameter.  The track colour is hard-coded
//     internally to `CupertinoColors.systemFill`.  We "fake" a custom
//     background by stacking a coloured `Container` underneath a slim
//     `CupertinoLinearActivityIndicator` whose track is allowed to
//     overlay it.
//
//   * No `radius` / corner-radius parameter.  The widget is itself
//     rendered with a `CustomPainter` that uses a rounded rect path
//     internally; we simulate "custom radius" by wrapping the widget
//     in a `ClipRRect` of the chosen radius.
//
//   * No animation control.  Unlike Material's
//     `LinearProgressIndicator()` (which sweeps when value is null),
//     the Cupertino variant is strictly determinate — `progress` is
//     `required`.  An "indeterminate-style sweep" therefore renders
//     here as a *static still frame* (multiple progress snapshots).
//
// The demo is intentionally rich: eight sections of prose + visuals,
// six-plus gradients, six-plus multi-layer shadows, a CustomPainter
// anatomy diagram, a comparison decision matrix, code snippet cards,
// a Wrap palette, and a scoped `StatefulBuilder` interactive section.
// =====================================================================

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Section: Design tokens
// ---------------------------------------------------------------------
//
// The demo standardises on a small set of named tokens for spacing,
// radii, and shadow stacks so that every section feels visually
// related.  These are top-level `const` values rather than scattered
// magic numbers — the harness can reference them at any layer.
// ---------------------------------------------------------------------

const double _kSectionPad = 20.0;
const double _kCardRadius = 18.0;
const double _kPillRadius = 999.0;
const double _kIndicatorWidth = 320.0;
const double _kHeroIndicatorWidth = 360.0;
const double _kSwatchIndicatorWidth = 140.0;
const double _kGapXs = 4.0;
const double _kGapSm = 8.0;
const double _kGapMd = 12.0;
const double _kGapLg = 20.0;
const double _kGapXl = 28.0;

// Cupertino-flavoured accent palette used by the swatch grid and by
// several section gradients.  These are deliberately chosen to mirror
// iOS / iPadOS system colours so the demo feels native.
const List<Color> _kCupertinoAccents = <Color>[
  CupertinoColors.activeBlue,
  CupertinoColors.systemIndigo,
  CupertinoColors.systemPurple,
  CupertinoColors.systemPink,
  CupertinoColors.systemRed,
  CupertinoColors.systemOrange,
  CupertinoColors.systemYellow,
  CupertinoColors.systemGreen,
  CupertinoColors.systemTeal,
  CupertinoColors.systemCyan,
  CupertinoColors.systemMint,
  CupertinoColors.systemBrown,
];

const List<String> _kCupertinoAccentNames = <String>[
  'activeBlue',
  'systemIndigo',
  'systemPurple',
  'systemPink',
  'systemRed',
  'systemOrange',
  'systemYellow',
  'systemGreen',
  'systemTeal',
  'systemCyan',
  'systemMint',
  'systemBrown',
];

// ---------------------------------------------------------------------
// Section: Shadow factories
// ---------------------------------------------------------------------
//
// Three named multi-layer shadow stacks.  Each one combines an
// "ambient" soft far-spread shadow with a "key" tighter shadow,
// producing a depth cue that survives both light backgrounds and
// the darker hero-card gradients.
// ---------------------------------------------------------------------

List<BoxShadow> _softCardShadow() {
  return <BoxShadow>[
    BoxShadow(
      color: Colors.black.withOpacity(0.06),
      blurRadius: 24.0,
      spreadRadius: 0.0,
      offset: const Offset(0.0, 12.0),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.04),
      blurRadius: 6.0,
      spreadRadius: 0.0,
      offset: const Offset(0.0, 2.0),
    ),
  ];
}

List<BoxShadow> _heroShadow(Color tint) {
  return <BoxShadow>[
    BoxShadow(
      color: tint.withOpacity(0.28),
      blurRadius: 36.0,
      spreadRadius: 2.0,
      offset: const Offset(0.0, 18.0),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.10),
      blurRadius: 12.0,
      spreadRadius: 0.0,
      offset: const Offset(0.0, 4.0),
    ),
    BoxShadow(
      color: Colors.white.withOpacity(0.55),
      blurRadius: 1.0,
      spreadRadius: 0.0,
      offset: const Offset(0.0, -1.0),
    ),
  ];
}

List<BoxShadow> _innerGlow(Color tint) {
  return <BoxShadow>[
    BoxShadow(
      color: tint.withOpacity(0.22),
      blurRadius: 18.0,
      spreadRadius: 0.0,
      offset: const Offset(0.0, 6.0),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.05),
      blurRadius: 2.0,
      spreadRadius: 0.0,
      offset: const Offset(0.0, 1.0),
    ),
  ];
}

// ---------------------------------------------------------------------
// Section: Gradient factories
// ---------------------------------------------------------------------
//
// Each major section gets its own gradient so the page reads as a
// stack of clearly distinct slabs.  All gradients are linear with a
// slight diagonal, keeping the look modern but never overwhelming
// the indicator content sitting on top.
// ---------------------------------------------------------------------

LinearGradient _heroGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFF0A84FF),
      Color(0xFF5856D6),
      Color(0xFFAF52DE),
    ],
    stops: <double>[0.0, 0.55, 1.0],
  );
}

LinearGradient _surfaceGradient() {
  return const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color(0xFFF6F7FB),
      Color(0xFFE9ECF4),
    ],
  );
}

LinearGradient _anatomyGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFFFF6E5),
      Color(0xFFFFE0B2),
    ],
  );
}

LinearGradient _matrixGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFE0F7FA),
      Color(0xFFB2EBF2),
      Color(0xFF80DEEA),
    ],
    stops: <double>[0.0, 0.6, 1.0],
  );
}

LinearGradient _snippetGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFF1F2937),
      Color(0xFF111827),
    ],
  );
}

LinearGradient _paletteGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFFFFBEB),
      Color(0xFFFFE4E6),
      Color(0xFFFCE7F3),
    ],
    stops: <double>[0.0, 0.55, 1.0],
  );
}

LinearGradient _interactiveGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFECFCCB),
      Color(0xFFD9F99D),
    ],
  );
}

LinearGradient _comparisonGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFF3E8FF),
      Color(0xFFE9D5FF),
      Color(0xFFDDD6FE),
    ],
    stops: <double>[0.0, 0.5, 1.0],
  );
}

LinearGradient _footerGradient() {
  return const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color(0xFF1F2937),
      Color(0xFF0F172A),
    ],
  );
}

// =====================================================================
//                      ENTRY POINT — `build`
// =====================================================================
//
// The Tom D4rt flutter_ast test harness expects a top-level function
// named `build` returning `dynamic`.  It is invoked with a real
// `BuildContext`.  We forbid `main`, `runApp`, `testWidgets`, async
// primitives, and root-level `setState`.  Scoped interactivity uses
// `StatefulBuilder` only.
// =====================================================================

dynamic build(BuildContext context) {
  print('[clai-demo] entering build()');
  print('[clai-demo] Flutter SDK exposes CupertinoLinearActivityIndicator '
      'with parameters: progress (required), height (default 4.5), color.');
  print('[clai-demo] backgroundColor and radius are synthesised via '
      'Container + ClipRRect wrappers.');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'CupertinoLinearActivityIndicator Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF2F4F8),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontSize: 14.0, color: Color(0xFF1F2937)),
      ),
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFF2F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: _kSectionPad,
            vertical: _kSectionPad,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildHeroSection(),
              const SizedBox(height: _kGapXl),
              _buildIntroductionSection(),
              const SizedBox(height: _kGapXl),
              _buildProgressLadderSection(),
              const SizedBox(height: _kGapXl),
              _buildIndeterminateSweepSection(),
              const SizedBox(height: _kGapXl),
              _buildAnatomySection(),
              const SizedBox(height: _kGapXl),
              _buildCustomisationSection(),
              const SizedBox(height: _kGapXl),
              _buildHeightStudySection(),
              const SizedBox(height: _kGapXl),
              _buildRadiusAndBackgroundSection(),
              const SizedBox(height: _kGapXl),
              _buildAccentSwatchSection(),
              const SizedBox(height: _kGapXl),
              _buildComparisonSection(),
              const SizedBox(height: _kGapXl),
              _buildDecisionMatrixSection(),
              const SizedBox(height: _kGapXl),
              _buildCodeSnippetSection(),
              const SizedBox(height: _kGapXl),
              _buildInteractiveProgressSection(),
              const SizedBox(height: _kGapXl),
              _buildEdgeCaseSection(),
              const SizedBox(height: _kGapXl),
              _buildFooterSection(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =====================================================================
// Section 1 — Hero
// =====================================================================
//
// A bold, gradient-filled hero card that sets the tone.  It introduces
// the widget by name, displays a single large indicator at 60% progress
// against a translucent white inner surface, and uses three stacked
// shadows so it feels like it floats above the page.  The hero is the
// visual anchor that every subsequent section refers back to.
// =====================================================================

Widget _buildHeroSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _heroGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius + 6.0),
      boxShadow: _heroShadow(const Color(0xFF5856D6)),
    ),
    padding: const EdgeInsets.all(_kSectionPad + 6.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: _kGapMd,
                vertical: _kGapXs,
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.18),
                borderRadius: BorderRadius.circular(_kPillRadius),
                border: Border.all(
                  color: Colors.white.withOpacity(0.35),
                  width: 1.0,
                ),
              ),
              child: const Text(
                'CUPERTINO • PROGRESS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.0,
                  letterSpacing: 1.4,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            const Icon(
              CupertinoIcons.chart_bar_alt_fill,
              color: Colors.white,
              size: 28.0,
            ),
          ],
        ),
        const SizedBox(height: _kGapLg),
        const Text(
          'CupertinoLinearActivityIndicator',
          style: TextStyle(
            color: Colors.white,
            fontSize: 26.0,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
          ),
        ),
        const SizedBox(height: _kGapSm),
        Text(
          'A linear, iOS-style progress bar with a required progress '
          'value, optional accent colour, and an adjustable height. '
          'Unlike its Material counterpart, this widget does not '
          'animate by itself — it always renders the exact progress '
          'fraction you hand it.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.85),
            fontSize: 14.0,
            height: 1.4,
          ),
        ),
        const SizedBox(height: _kGapXl),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: _kGapLg,
            vertical: _kGapLg,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(_kCardRadius),
            border: Border.all(
              color: Colors.white.withOpacity(0.22),
              width: 1.0,
            ),
            boxShadow: _innerGlow(Colors.white),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'Uploading project archive',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    '60%',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontFeatures: <FontFeature>[
                        FontFeature.tabularFigures(),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: _kGapMd),
              SizedBox(
                width: _kHeroIndicatorWidth,
                child: const CupertinoLinearActivityIndicator(
                  progress: 0.6,
                  height: 6.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: _kGapSm),
              Text(
                '12.4 MB of 20.7 MB transferred',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 2 — Introduction (prose)
// =====================================================================
//
// Plain-language explanation of where the widget fits and how it
// compares against its Material sibling.  No indicators are drawn
// here; the goal is to give the reader enough context that every
// later section makes immediate sense.  Roughly seventy words of
// substantive prose, plus a small "at a glance" bullet list.
// =====================================================================

Widget _buildIntroductionSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _surfaceGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('When to reach for it'),
        const SizedBox(height: _kGapMd),
        const Text(
          'The Cupertino linear activity indicator is the iOS-flavoured '
          'choice whenever you need to show a determinate horizontal '
          'progress bar inside an app that follows Apple Human Interface '
          'Guidelines. It is purely visual: there is no built-in tween, '
          'no sweep, and no spinner mode. Drive it from your own state, '
          'pass a value between zero and one, and let the framework '
          'paint a soft, pill-shaped fill on top of the system fill '
          'track.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapMd),
        _bullet('Determinate only — `progress` is required (0.0 to 1.0).'),
        _bullet('Track colour is the iOS systemFill — not configurable.'),
        _bullet('Corner radius is implicit; use ClipRRect to override.'),
        _bullet('Height defaults to 4.5 logical pixels — assert > 0.'),
        _bullet('Sits naturally inside CupertinoPageScaffold.'),
      ],
    ),
  );
}

// =====================================================================
// Section 3 — Progress ladder
// =====================================================================
//
// A vertical ladder of five static frames at the canonical discrete
// values: 10%, 25%, 50%, 75% and 100%.  Each row pairs a percentage
// label, the indicator, and a short status caption.  The whole ladder
// sits on a soft surface gradient so the indicator strokes have
// enough contrast to read clearly.
// =====================================================================

Widget _buildProgressLadderSection() {
  const List<double> values = <double>[0.1, 0.25, 0.5, 0.75, 1.0];
  const List<String> captions = <String>[
    'Just started',
    'Warming up',
    'Halfway there',
    'Almost done',
    'Complete',
  ];

  return Container(
    decoration: BoxDecoration(
      gradient: _surfaceGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Discrete progress values'),
        const SizedBox(height: _kGapSm),
        const Text(
          'Five common landmarks along the 0..1 range. Each indicator '
          'is rendered exactly once at the indicated fraction — there '
          'is no animation in this section. Use these as visual '
          'reference points when designing your own progress feedback '
          'flow.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        for (int i = 0; i < values.length; i++) ...<Widget>[
          _progressRow(
            value: values[i],
            caption: captions[i],
            color: _kCupertinoAccents[i % _kCupertinoAccents.length],
          ),
          if (i != values.length - 1) const SizedBox(height: _kGapMd),
        ],
      ],
    ),
  );
}

Widget _progressRow({
  required double value,
  required String caption,
  required Color color,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      SizedBox(
        width: 52.0,
        child: Text(
          '${(value * 100).toInt()}%',
          textAlign: TextAlign.right,
          style: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w600,
            fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
          ),
        ),
      ),
      const SizedBox(width: _kGapMd),
      Expanded(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_kPillRadius),
          child: CupertinoLinearActivityIndicator(
            progress: value,
            color: color,
            height: 6.0,
          ),
        ),
      ),
      const SizedBox(width: _kGapMd),
      SizedBox(
        width: 110.0,
        child: Text(
          caption,
          style: const TextStyle(
            fontSize: 12.0,
            color: Color(0xFF4B5563),
          ),
        ),
      ),
    ],
  );
}

// =====================================================================
// Section 4 — Indeterminate "sweep" still frames
// =====================================================================
//
// `CupertinoLinearActivityIndicator` does not animate by itself.  In
// production code, a developer wanting an indeterminate sweep would
// usually fall back to Material's `LinearProgressIndicator()` with no
// value, or drive a custom animation.  Here, since the demo is
// strictly static (no AnimationController allowed), we show what a
// sweep "looks like" by laying down a row of five still frames at
// successive progress values.  This gives a clear cinematic sense of
// motion without ever animating.
// =====================================================================

Widget _buildIndeterminateSweepSection() {
  const List<double> sweepFrames = <double>[0.15, 0.35, 0.55, 0.75, 0.95];

  return Container(
    decoration: BoxDecoration(
      gradient: _surfaceGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Simulated indeterminate sweep'),
        const SizedBox(height: _kGapSm),
        const Text(
          'There is no built-in indeterminate mode. To convey ongoing '
          'work without a known endpoint, developers usually animate '
          'the progress value themselves or fall back to a Material '
          'LinearProgressIndicator with value: null. The five frames '
          'below approximate what a sweep would look like by rendering '
          'one indicator per discrete moment in time.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        for (int i = 0; i < sweepFrames.length; i++) ...<Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                width: 60.0,
                child: Text(
                  'frame ${i + 1}',
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ),
              Expanded(
                child: CupertinoLinearActivityIndicator(
                  progress: sweepFrames[i],
                  color: CupertinoColors.systemIndigo,
                  height: 5.0,
                ),
              ),
            ],
          ),
          if (i != sweepFrames.length - 1)
            const SizedBox(height: _kGapMd),
        ],
      ],
    ),
  );
}

// =====================================================================
// Section 5 — Anatomy diagram
// =====================================================================
//
// A CustomPainter renders an oversized, annotated cross-section of the
// indicator: track, fill, and the implicit corner radii.  Labels with
// callout lines explain each region.  This is the only section that
// uses raw painting; the rest stick to widgets.
// =====================================================================

Widget _buildAnatomySection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _anatomyGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Anatomy of the indicator'),
        const SizedBox(height: _kGapSm),
        const Text(
          'The widget paints two rounded rectangles: a full-width '
          '"track" using CupertinoColors.systemFill, and a fill '
          'overlay clamped to progress * width using either '
          'CupertinoColors.activeBlue or the user-supplied colour. '
          'Both share the same vertical extent (`height`) and the '
          'same implicit corner radius, which is half the height — '
          'producing the pill silhouette characteristic of iOS '
          'progress bars.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        SizedBox(
          height: 220.0,
          width: double.infinity,
          child: CustomPaint(
            painter: _IndicatorAnatomyPainter(),
          ),
        ),
        const SizedBox(height: _kGapLg),
        Wrap(
          spacing: _kGapLg,
          runSpacing: _kGapSm,
          children: <Widget>[
            _legendSwatch(
              const Color(0xFFE5E7EB),
              'Track (systemFill)',
            ),
            _legendSwatch(
              CupertinoColors.activeBlue,
              'Fill (progress region)',
            ),
            _legendSwatch(
              const Color(0xFFFF9500),
              'Radius callout (height/2)',
            ),
          ],
        ),
      ],
    ),
  );
}

class _IndicatorAnatomyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double midY = size.height * 0.5;
    final double barHeight = 36.0;
    final double left = 40.0;
    final double right = size.width - 40.0;
    final double width = right - left;
    final double progress = 0.62;

    // Track
    final RRect track = RRect.fromRectAndRadius(
      Rect.fromLTRB(
        left,
        midY - barHeight / 2.0,
        right,
        midY + barHeight / 2.0,
      ),
      Radius.circular(barHeight / 2.0),
    );
    final Paint trackPaint = Paint()..color = const Color(0xFFE5E7EB);
    canvas.drawRRect(track, trackPaint);

    // Fill
    final RRect fill = RRect.fromRectAndRadius(
      Rect.fromLTRB(
        left,
        midY - barHeight / 2.0,
        left + width * progress,
        midY + barHeight / 2.0,
      ),
      Radius.circular(barHeight / 2.0),
    );
    final Paint fillPaint = Paint()..color = CupertinoColors.activeBlue;
    canvas.drawRRect(fill, fillPaint);

    // Stroke outline around the entire track for emphasis
    final Paint outline = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xFF9CA3AF);
    canvas.drawRRect(track, outline);

    // Radius callout: orange arc on left cap, with leader line.
    final Paint callout = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = const Color(0xFFFF9500);
    final Rect capRect = Rect.fromCircle(
      center: Offset(left + barHeight / 2.0, midY),
      radius: barHeight / 2.0 + 2.0,
    );
    canvas.drawArc(capRect, 2.4, 1.4, false, callout);

    // Leader line from the cap to a label point above.
    final Offset capPoint = Offset(left + 4.0, midY - barHeight / 2.0 - 2.0);
    final Offset capLabel = Offset(left + 4.0, midY - barHeight / 2.0 - 36.0);
    canvas.drawLine(capPoint, capLabel, callout);

    // Label text
    _drawText(
      canvas,
      'radius = height / 2',
      Offset(capLabel.dx, capLabel.dy - 14.0),
      const Color(0xFFB45309),
    );

    // Track label
    _drawText(
      canvas,
      'track',
      Offset(left + width / 2.0 - 18.0, midY + barHeight / 2.0 + 12.0),
      const Color(0xFF374151),
    );

    // Fill label with leader line
    final Offset fillPoint = Offset(left + width * progress * 0.5, midY);
    final Offset fillLabel = Offset(fillPoint.dx, midY + barHeight / 2.0 + 36.0);
    canvas.drawLine(
      fillPoint.translate(0, barHeight / 2.0),
      fillLabel,
      Paint()
        ..color = const Color(0xFF1D4ED8)
        ..strokeWidth = 1.0,
    );
    _drawText(
      canvas,
      'fill = progress * width',
      Offset(fillLabel.dx - 50.0, fillLabel.dy + 4.0),
      const Color(0xFF1D4ED8),
    );

    // Width measurement bracket at the bottom
    final double bracketY = midY + barHeight / 2.0 + 68.0;
    final Paint bracket = Paint()
      ..color = const Color(0xFF6B7280)
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(left, bracketY), Offset(right, bracketY), bracket);
    canvas.drawLine(
      Offset(left, bracketY - 6.0),
      Offset(left, bracketY + 6.0),
      bracket,
    );
    canvas.drawLine(
      Offset(right, bracketY - 6.0),
      Offset(right, bracketY + 6.0),
      bracket,
    );
    _drawText(
      canvas,
      'available width',
      Offset(left + width / 2.0 - 40.0, bracketY + 8.0),
      const Color(0xFF374151),
    );
  }

  void _drawText(Canvas canvas, String text, Offset at, Color color) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, at);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// Section 6 — Customisation (color)
// =====================================================================
//
// Walks through `color` customisation against a single fixed height
// and progress, so the reader can isolate the impact of accent
// changes.  Five named Cupertino colours plus the default.  Each row
// shows the indicator on a soft inset card with a thin border.
// =====================================================================

Widget _buildCustomisationSection() {
  final List<({String name, Color? color})> samples = <({String name, Color? color})>[
    (name: 'default (activeBlue)', color: null),
    (name: 'systemIndigo', color: CupertinoColors.systemIndigo),
    (name: 'systemGreen', color: CupertinoColors.systemGreen),
    (name: 'systemOrange', color: CupertinoColors.systemOrange),
    (name: 'systemRed', color: CupertinoColors.systemRed),
    (name: 'systemPurple', color: CupertinoColors.systemPurple),
  ];

  return Container(
    decoration: BoxDecoration(
      gradient: _surfaceGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Customising the accent colour'),
        const SizedBox(height: _kGapSm),
        const Text(
          'The `color` parameter only affects the fill — the track '
          'stays as Cupertino systemFill regardless. This keeps every '
          'indicator visually consistent with the iOS system look '
          'while still letting the brand colour through. When `color` '
          'is omitted the framework falls back to '
          'CupertinoColors.activeBlue.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        for (final ({String name, Color? color}) s in samples)
          Padding(
            padding: const EdgeInsets.only(bottom: _kGapMd),
            child: _customisationRow(name: s.name, color: s.color),
          ),
      ],
    ),
  );
}

Widget _customisationRow({required String name, Color? color}) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: _kGapMd,
      vertical: _kGapMd,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 160.0,
          child: Text(
            name,
            style: const TextStyle(
              fontSize: 13.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: CupertinoLinearActivityIndicator(
            progress: 0.55,
            color: color,
            height: 5.0,
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 7 — Height study
// =====================================================================
//
// Demonstrates the effect of the `height` parameter.  Five rows from
// 2.0 (very thin, almost a hairline) through 14.0 (chunky, "tappable
// looking" bar).  Each row shares the same progress and colour so the
// only visual variable is height.
// =====================================================================

Widget _buildHeightStudySection() {
  const List<double> heights = <double>[2.0, 4.5, 6.0, 10.0, 14.0];

  return Container(
    decoration: BoxDecoration(
      gradient: _surfaceGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Height parameter at a glance'),
        const SizedBox(height: _kGapSm),
        const Text(
          'The default of 4.5 logical pixels matches the iOS-native '
          'progress bar. Thinner heights work well for unobtrusive '
          'inline feedback (under list rows, beneath nav bars); '
          'thicker heights are friendlier for media playhead progress '
          'or download cards where the bar carries more visual weight. '
          'Always keep `height` strictly positive — the assertion in '
          'the constructor enforces this at debug time.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        for (final double h in heights) ...<Widget>[
          _heightRow(h),
          if (h != heights.last) const SizedBox(height: _kGapMd),
        ],
      ],
    ),
  );
}

Widget _heightRow(double height) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      SizedBox(
        width: 70.0,
        child: Text(
          'h = $height',
          style: const TextStyle(
            fontSize: 12.0,
            color: Color(0xFF4B5563),
            fontFeatures: <FontFeature>[FontFeature.tabularFigures()],
          ),
        ),
      ),
      Expanded(
        child: CupertinoLinearActivityIndicator(
          progress: 0.7,
          height: height,
          color: CupertinoColors.systemTeal,
        ),
      ),
    ],
  );
}

// =====================================================================
// Section 8 — Synthesised "backgroundColor" and "radius"
// =====================================================================
//
// `CupertinoLinearActivityIndicator` does not expose a backgroundColor
// or radius parameter.  This section explains the workaround pattern:
// wrap the indicator in a coloured `Container` for backgroundColor
// effects, and in a `ClipRRect` to alter the corner geometry.
// =====================================================================

Widget _buildRadiusAndBackgroundSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _surfaceGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Synthesising backgroundColor + radius'),
        const SizedBox(height: _kGapSm),
        const Text(
          'Cupertino exposes a deliberately minimal API: just '
          'progress, height, and color. To recreate Material-style '
          'customisation you stack the indicator with helpers. A '
          'coloured Container underneath supplies a backgroundColor; '
          'a ClipRRect around it overrides the implicit pill radius. '
          'Below, four variants show the technique: tinted, '
          'square-cornered, fully pill, and shadowed.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        _bgRow(
          label: 'Mint-tinted background',
          background: const Color(0xFFD1FAE5),
          radius: _kPillRadius,
          color: CupertinoColors.systemGreen,
        ),
        const SizedBox(height: _kGapMd),
        _bgRow(
          label: 'Square corners (radius 0)',
          background: const Color(0xFFFEE2E2),
          radius: 0.0,
          color: CupertinoColors.systemRed,
        ),
        const SizedBox(height: _kGapMd),
        _bgRow(
          label: 'Soft 6px radius',
          background: const Color(0xFFE0E7FF),
          radius: 6.0,
          color: CupertinoColors.systemIndigo,
        ),
        const SizedBox(height: _kGapMd),
        _bgRow(
          label: 'Shadowed wrapper',
          background: const Color(0xFFFEF3C7),
          radius: _kPillRadius,
          color: CupertinoColors.systemOrange,
          shadow: true,
        ),
      ],
    ),
  );
}

Widget _bgRow({
  required String label,
  required Color background,
  required double radius,
  required Color color,
  bool shadow = false,
}) {
  return Row(
    children: <Widget>[
      SizedBox(
        width: 180.0,
        child: Text(
          label,
          style: const TextStyle(fontSize: 12.0),
        ),
      ),
      Expanded(
        child: Container(
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(radius),
            boxShadow: shadow
                ? <BoxShadow>[
                    BoxShadow(
                      color: color.withOpacity(0.30),
                      blurRadius: 10.0,
                      offset: const Offset(0.0, 4.0),
                    ),
                  ]
                : null,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 4.0,
            vertical: 4.0,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: CupertinoLinearActivityIndicator(
              progress: 0.65,
              color: color,
              height: 6.0,
            ),
          ),
        ),
      ),
    ],
  );
}

// =====================================================================
// Section 9 — Accent swatch grid
// =====================================================================
//
// A `Wrap` palette showing the same indicator at the same progress
// against twelve different Cupertino system accents.  Each swatch
// labels its accent name underneath so the reader can map names to
// hues quickly.  The grid scales to multiple lines depending on the
// available width.
// =====================================================================

Widget _buildAccentSwatchSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _paletteGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Cupertino accent swatch palette'),
        const SizedBox(height: _kGapSm),
        const Text(
          'Twelve indicators at identical 65% progress, drawn against '
          'the system accent palette. Use the Wrap below as a visual '
          'lookup table when picking a `color` value: the named '
          'CupertinoColors constants line up directly with the swatch '
          'labels. The default activeBlue is the leftmost entry so '
          'comparisons against "no color set" stay easy.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        Wrap(
          spacing: _kGapLg,
          runSpacing: _kGapLg,
          children: <Widget>[
            for (int i = 0; i < _kCupertinoAccents.length; i++)
              _swatchTile(
                _kCupertinoAccents[i],
                _kCupertinoAccentNames[i],
              ),
          ],
        ),
      ],
    ),
  );
}

Widget _swatchTile(Color color, String name) {
  return Container(
    width: _kSwatchIndicatorWidth,
    padding: const EdgeInsets.symmetric(
      horizontal: _kGapMd,
      vertical: _kGapMd,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: color.withOpacity(0.18),
          blurRadius: 14.0,
          offset: const Offset(0.0, 6.0),
        ),
        BoxShadow(
          color: Colors.black.withOpacity(0.03),
          blurRadius: 2.0,
          offset: const Offset(0.0, 1.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          name,
          style: const TextStyle(
            fontSize: 11.0,
            color: Color(0xFF374151),
            fontWeight: FontWeight.w600,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: _kGapSm),
        CupertinoLinearActivityIndicator(
          progress: 0.65,
          color: color,
          height: 5.5,
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 10 — Side-by-side with Material counterparts
// =====================================================================
//
// Three indicators stacked: the Cupertino linear one, Material's
// `LinearProgressIndicator`, and the round `CupertinoActivityIndicator`.
// Labels and short captions explain the differences in feel and use.
// =====================================================================

Widget _buildComparisonSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _comparisonGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Side by side: Cupertino vs Material'),
        const SizedBox(height: _kGapSm),
        const Text(
          'The Material LinearProgressIndicator supports both '
          'determinate and indeterminate modes out of the box, has a '
          'configurable backgroundColor and minHeight, and animates '
          'its own sweep when value is null. The Cupertino linear '
          'indicator is determinate-only and intentionally minimal. '
          'The circular CupertinoActivityIndicator covers the '
          '"spinner" use case in iOS apps and lives on a different '
          'visual axis.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        _comparisonRow(
          label: 'CupertinoLinearActivityIndicator',
          caption: 'iOS linear, determinate-only, pill shape.',
          child: const CupertinoLinearActivityIndicator(
            progress: 0.6,
            height: 6.0,
            color: CupertinoColors.activeBlue,
          ),
        ),
        const SizedBox(height: _kGapMd),
        _comparisonRow(
          label: 'LinearProgressIndicator (Material)',
          caption: 'Material linear, animated when value is null.',
          child: const LinearProgressIndicator(
            value: 0.6,
            minHeight: 6.0,
            backgroundColor: Color(0xFFE5E7EB),
            color: Color(0xFF6366F1),
          ),
        ),
        const SizedBox(height: _kGapMd),
        _comparisonRow(
          label: 'CupertinoActivityIndicator (circular)',
          caption: 'iOS spinner — covers the indeterminate case.',
          child: const Center(
            child: CupertinoActivityIndicator(
              radius: 14.0,
              color: CupertinoColors.activeBlue,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _comparisonRow({
  required String label,
  required String caption,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(_kGapMd),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: _kGapXs),
        Text(
          caption,
          style: const TextStyle(
            fontSize: 11.0,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: _kGapSm),
        SizedBox(
          width: _kIndicatorWidth,
          child: child,
        ),
      ],
    ),
  );
}

// =====================================================================
// Section 11 — Decision matrix
// =====================================================================
//
// A simple table comparing the three indicator widgets across five
// axes: animation support, customisation surface, default look-and-
// feel, recommended platform, and parameter footprint.  Implemented
// with `Table` for clean column alignment.
// =====================================================================

Widget _buildDecisionMatrixSection() {
  const TextStyle headerStyle = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w700,
    color: Color(0xFF1F2937),
  );
  const TextStyle cellStyle = TextStyle(
    fontSize: 12.0,
    color: Color(0xFF374151),
  );

  return Container(
    decoration: BoxDecoration(
      gradient: _matrixGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Decision matrix'),
        const SizedBox(height: _kGapSm),
        const Text(
          'Choosing between the linear indicators in Flutter mostly '
          'comes down to platform fit and whether you need a built-in '
          'indeterminate mode. The table summarises the trade-offs '
          'across the three commonly-considered options.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6.0,
                offset: const Offset(0.0, 2.0),
              ),
            ],
          ),
          padding: const EdgeInsets.all(_kGapMd),
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(2.2),
              1: FlexColumnWidth(2.0),
              2: FlexColumnWidth(2.0),
              3: FlexColumnWidth(2.0),
            },
            border: TableBorder(
              horizontalInside: BorderSide(
                color: const Color(0xFFE5E7EB),
                width: 1.0,
              ),
            ),
            children: <TableRow>[
              const TableRow(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(_kGapSm),
                    child: Text('Aspect', style: headerStyle),
                  ),
                  Padding(
                    padding: EdgeInsets.all(_kGapSm),
                    child: Text('Cupertino Linear', style: headerStyle),
                  ),
                  Padding(
                    padding: EdgeInsets.all(_kGapSm),
                    child: Text('Material Linear', style: headerStyle),
                  ),
                  Padding(
                    padding: EdgeInsets.all(_kGapSm),
                    child: Text('Cupertino Circular', style: headerStyle),
                  ),
                ],
              ),
              _matrixRow(
                'Animation',
                'Manual',
                'Built-in sweep',
                'Built-in spin',
                cellStyle,
              ),
              _matrixRow(
                'Indeterminate',
                'Not supported',
                'value: null',
                'Default mode',
                cellStyle,
              ),
              _matrixRow(
                'Track colour',
                'Fixed systemFill',
                'backgroundColor',
                'n/a (transparent)',
                cellStyle,
              ),
              _matrixRow(
                'Custom radius',
                'Via ClipRRect',
                'borderRadius',
                'Implicit circle',
                cellStyle,
              ),
              _matrixRow(
                'Best fit',
                'iOS-styled apps',
                'Material apps',
                'iOS spinners',
                cellStyle,
              ),
              _matrixRow(
                'Param count',
                '3',
                '7+',
                '4',
                cellStyle,
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

TableRow _matrixRow(
  String a,
  String b,
  String c,
  String d,
  TextStyle style,
) {
  return TableRow(
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(_kGapSm),
        child: Text(
          a,
          style: style.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(_kGapSm),
        child: Text(b, style: style),
      ),
      Padding(
        padding: const EdgeInsets.all(_kGapSm),
        child: Text(c, style: style),
      ),
      Padding(
        padding: const EdgeInsets.all(_kGapSm),
        child: Text(d, style: style),
      ),
    ],
  );
}

// =====================================================================
// Section 12 — Code snippet card
// =====================================================================
//
// A dark "IDE-style" card showing two reference snippets: a minimal
// usage and a fully-customised one.  Implemented purely as styled
// `Text` widgets with monospace font and selectable lines.
// =====================================================================

Widget _buildCodeSnippetSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _snippetGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _dot(const Color(0xFFFF5F56)),
            const SizedBox(width: _kGapXs),
            _dot(const Color(0xFFFFBD2E)),
            const SizedBox(width: _kGapXs),
            _dot(const Color(0xFF27C93F)),
            const SizedBox(width: _kGapMd),
            const Text(
              'cupertino_linear_activity_indicator.dart',
              style: TextStyle(
                color: Color(0xFFCBD5E1),
                fontSize: 12.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: _kGapLg),
        const Text(
          '// 1. Minimal usage — track + 30% fill, default colour.',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Color(0xFF6EE7B7),
            fontSize: 12.0,
          ),
        ),
        const SizedBox(height: _kGapXs),
        const Text(
          'CupertinoLinearActivityIndicator(\n'
          '  progress: 0.3,\n'
          ')',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Color(0xFFE2E8F0),
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        const SizedBox(height: _kGapLg),
        const Text(
          '// 2. Fully customised: explicit height + accent.',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Color(0xFF6EE7B7),
            fontSize: 12.0,
          ),
        ),
        const SizedBox(height: _kGapXs),
        const Text(
          'CupertinoLinearActivityIndicator(\n'
          '  progress: 0.72,\n'
          '  height: 8.0,\n'
          '  color: CupertinoColors.systemPurple,\n'
          ')',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Color(0xFFE2E8F0),
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
        const SizedBox(height: _kGapLg),
        const Text(
          '// 3. Synthesised backgroundColor + radius via wrappers.',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Color(0xFF6EE7B7),
            fontSize: 12.0,
          ),
        ),
        const SizedBox(height: _kGapXs),
        const Text(
          'Container(\n'
          '  decoration: BoxDecoration(\n'
          '    color: const Color(0xFFFEE2E2),\n'
          '    borderRadius: BorderRadius.circular(0),\n'
          '  ),\n'
          '  child: ClipRRect(\n'
          '    borderRadius: BorderRadius.circular(0),\n'
          '    child: const CupertinoLinearActivityIndicator(\n'
          '      progress: 0.5,\n'
          '      color: CupertinoColors.systemRed,\n'
          '    ),\n'
          '  ),\n'
          ')',
          style: TextStyle(
            fontFamily: 'monospace',
            color: Color(0xFFE2E8F0),
            fontSize: 12.5,
            height: 1.4,
          ),
        ),
      ],
    ),
  );
}

Widget _dot(Color color) {
  return Container(
    width: 10.0,
    height: 10.0,
    decoration: BoxDecoration(color: color, shape: BoxShape.circle),
  );
}

// =====================================================================
// Section 13 — Interactive progress (StatefulBuilder)
// =====================================================================
//
// Local-state-only interactivity.  A `StatefulBuilder` hosts a single
// `double` for the current progress value.  Two CupertinoButton-style
// controls (decrement / increment) and a row of preset chips let the
// reader change the value in scoped state.  No root `setState`, no
// AnimationController, no timers — just scoped widget state.
// =====================================================================

Widget _buildInteractiveProgressSection() {
  double currentProgress = 0.4;

  return Container(
    decoration: BoxDecoration(
      gradient: _interactiveGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Scoped interactive playground'),
        const SizedBox(height: _kGapSm),
        const Text(
          'A StatefulBuilder hosts the local progress value below — '
          'there is no AnimationController and no root setState. Use '
          'the minus and plus buttons to step the value by 0.1, or '
          'tap a preset chip to jump to a canonical landmark. The '
          'indicator below updates in place, demonstrating that the '
          'widget itself is purely declarative.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        StatefulBuilder(
          builder: (BuildContext context, StateSetter setLocal) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    _stepButton(
                      icon: CupertinoIcons.minus,
                      onTap: () {
                        setLocal(() {
                          currentProgress =
                              (currentProgress - 0.1).clamp(0.0, 1.0);
                        });
                      },
                    ),
                    const SizedBox(width: _kGapMd),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(_kPillRadius),
                        child: CupertinoLinearActivityIndicator(
                          progress: currentProgress,
                          color: CupertinoColors.systemGreen,
                          height: 8.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: _kGapMd),
                    _stepButton(
                      icon: CupertinoIcons.plus,
                      onTap: () {
                        setLocal(() {
                          currentProgress =
                              (currentProgress + 0.1).clamp(0.0, 1.0);
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: _kGapMd),
                Text(
                  'progress = ${currentProgress.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    fontFeatures: <FontFeature>[
                      FontFeature.tabularFigures(),
                    ],
                  ),
                ),
                const SizedBox(height: _kGapMd),
                Wrap(
                  spacing: _kGapSm,
                  runSpacing: _kGapSm,
                  children: <Widget>[
                    for (final double preset
                        in <double>[0.0, 0.25, 0.5, 0.75, 1.0])
                      _presetChip(
                        label: '${(preset * 100).toInt()}%',
                        selected: (currentProgress - preset).abs() < 0.001,
                        onTap: () {
                          setLocal(() {
                            currentProgress = preset;
                          });
                        },
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

Widget _stepButton({required IconData icon, required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6.0,
            offset: const Offset(0.0, 2.0),
          ),
        ],
      ),
      child: Icon(
        icon,
        size: 18.0,
        color: const Color(0xFF1F2937),
      ),
    ),
  );
}

Widget _presetChip({
  required String label,
  required bool selected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    behavior: HitTestBehavior.opaque,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      padding: const EdgeInsets.symmetric(
        horizontal: _kGapMd,
        vertical: _kGapXs + 2.0,
      ),
      decoration: BoxDecoration(
        color: selected ? CupertinoColors.systemGreen : Colors.white,
        borderRadius: BorderRadius.circular(_kPillRadius),
        border: Border.all(
          color: selected
              ? CupertinoColors.systemGreen
              : const Color(0xFFD1D5DB),
          width: 1.0,
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4.0,
            offset: const Offset(0.0, 1.0),
          ),
        ],
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w600,
          color: selected ? Colors.white : const Color(0xFF374151),
          fontFeatures: const <FontFeature>[FontFeature.tabularFigures()],
        ),
      ),
    ),
  );
}

// =====================================================================
// Section 14 — Edge cases
// =====================================================================
//
// Documents the two boundary values (0.0 and 1.0) and their visual
// consequences.  Also discusses what happens if you accidentally try
// to pass a value outside [0, 1] — the constructor's assertion fires
// in debug mode.  No invalid values are actually constructed here.
// =====================================================================

Widget _buildEdgeCaseSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _surfaceGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _sectionTitle('Edge cases and assertions'),
        const SizedBox(height: _kGapSm),
        const Text(
          'Two boundary values matter: 0.0 paints an empty track only, '
          'and 1.0 fills the bar completely. Values outside [0, 1] are '
          'rejected by the constructor at debug time via an assert; '
          'in release builds the underlying CustomPainter would clamp '
          'the rect. The two demos below show the empty and full '
          'states with explicit captions.',
          style: TextStyle(fontSize: 14.0, height: 1.5),
        ),
        const SizedBox(height: _kGapLg),
        Row(
          children: <Widget>[
            Expanded(
              child: _edgeCard(
                label: 'progress: 0.0',
                description: 'Nothing painted yet.',
                child: const CupertinoLinearActivityIndicator(
                  progress: 0.0,
                  color: CupertinoColors.systemRed,
                  height: 6.0,
                ),
              ),
            ),
            const SizedBox(width: _kGapMd),
            Expanded(
              child: _edgeCard(
                label: 'progress: 1.0',
                description: 'Track fully filled.',
                child: const CupertinoLinearActivityIndicator(
                  progress: 1.0,
                  color: CupertinoColors.systemGreen,
                  height: 6.0,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _edgeCard({
  required String label,
  required String description,
  required Widget child,
}) {
  return Container(
    padding: const EdgeInsets.all(_kGapMd),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFFE5E7EB), width: 1.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.04),
          blurRadius: 6.0,
          offset: const Offset(0.0, 2.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            fontFamily: 'monospace',
          ),
        ),
        const SizedBox(height: _kGapXs),
        Text(
          description,
          style: const TextStyle(
            fontSize: 11.0,
            color: Color(0xFF6B7280),
          ),
        ),
        const SizedBox(height: _kGapMd),
        child,
      ],
    ),
  );
}

// =====================================================================
// Section 15 — Footer
// =====================================================================
//
// Closing dark-card summary with a credit line and a final tiny
// indicator at 100% to bookend the page visually.  Wraps the overall
// scroll content so the reader knows the demo is complete.
// =====================================================================

Widget _buildFooterSection() {
  return Container(
    decoration: BoxDecoration(
      gradient: _footerGradient(),
      borderRadius: BorderRadius.circular(_kCardRadius),
      boxShadow: _softCardShadow(),
    ),
    padding: const EdgeInsets.all(_kSectionPad),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'End of demo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: _kGapXs),
        Text(
          'CupertinoLinearActivityIndicator — hand-authored visual '
          'showcase for the Tom D4rt flutter_ast test corpus.',
          style: TextStyle(
            color: Colors.white.withOpacity(0.75),
            fontSize: 12.0,
            height: 1.4,
          ),
        ),
        const SizedBox(height: _kGapLg),
        const CupertinoLinearActivityIndicator(
          progress: 1.0,
          color: Colors.white,
          height: 3.0,
        ),
      ],
    ),
  );
}

// =====================================================================
// Shared building blocks
// =====================================================================

Widget _sectionTitle(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
      color: Color(0xFF111827),
      letterSpacing: -0.2,
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          '•  ',
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF6B7280),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13.0, height: 1.4),
          ),
        ),
      ],
    ),
  );
}

Widget _legendSwatch(Color color, String label) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Container(
        width: 14.0,
        height: 14.0,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: Colors.black.withOpacity(0.08),
            width: 1.0,
          ),
        ),
      ),
      const SizedBox(width: _kGapXs + 2.0),
      Text(
        label,
        style: const TextStyle(
          fontSize: 12.0,
          color: Color(0xFF374151),
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
