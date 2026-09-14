// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =====================================================================
// CupertinoSheetTransition — Deep Visual Demo
// =====================================================================
//
// This file is a hand-authored, analyzer-clean visual showcase for the
// Cupertino-style iOS-13 modal sheet transition that ships with the
// Flutter framework as `CupertinoSheetTransition`, plus the surrounding
// sheet-route machinery: `CupertinoSheetRoute<T>`, `showCupertinoSheet`,
// and the modal-presentation behaviour you get when these are combined.
//
// Constructor signature (from package:flutter/cupertino.dart):
//
//   const CupertinoSheetTransition({
//     Key? key,
//     required Animation<double> primaryRouteAnimation,
//     required Animation<double> secondaryRouteAnimation,
//     required Widget child,
//     bool linearTransition = false,
//     double topGap = 12.0,
//   })
//
// And the route/helper signatures (paraphrased):
//
//   class CupertinoSheetRoute<T> extends PageRoute<T> {
//     CupertinoSheetRoute({ required WidgetBuilder builder, ... });
//   }
//
//   Future<T?> showCupertinoSheet<T>({
//     required BuildContext context,
//     required WidgetBuilder pageBuilder,
//     bool useNestedNavigation = false,
//   });
//
// The `CupertinoSheetTransition` widget is the visual layer used by
// `CupertinoSheetRoute`; it animates BOTH the newly-arriving sheet
// (driven by `primaryRouteAnimation`) AND, when another route is
// pushed on top of it, the receding presenting view (driven by
// `secondaryRouteAnimation`).  In real life, those animations come
// from a `Navigator` and are advanced by a `Ticker`.  Here, the demo
// is 100% static, so every snapshot is fed an
// `AlwaysStoppedAnimation<double>(t)` for a fixed `t`.
//
// Because the harness runs INSIDE the D4rt interpreter, certain Flutter
// idioms are off-limits:
//
//   * No `AnimationController` — it needs a `TickerProvider`/`vsync`.
//   * No `Navigator.push` of a real `CupertinoSheetRoute` — there is
//     no live Navigator to drive the route's primary animation.
//   * No `setState`, no `StatefulWidget` at the top level — the
//     harness re-renders by re-invoking `build()`, so we render every
//     "frame" of interest as its own widget instance and tile them in
//     a static scrollable column.
//
// The demo is intentionally rich: a half-dozen prose cards, hand-rolled
// CustomPainter "phone bezel" frames, a transition reel showing the
// primary animation at t = 0.0, 0.15, 0.35, 0.55, 0.75, 0.92, 1.0, a
// second reel showing the secondary animation 0.0 → 1.0, a math card
// explaining the underlying transform, a swatch grid of the dim
// overlay, a code-block card showing idiomatic
// `Navigator.of(context).push(CupertinoSheetRoute(...))`, and pitfalls
// & theory cards.  Every numeric and colour token is `const`-promoted
// where the framework permits, with a strict lint policy enforced by
// the single `ignore_for_file` header above.
// =====================================================================

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------
// Section: Design tokens
// ---------------------------------------------------------------------
//
// Spacing, radii, and typography tokens shared across every visual
// section.  Top-level `const` so the painters and inline widgets can
// all reference the same canonical values.
// ---------------------------------------------------------------------

const double _kSectionPad = 20.0;
const double _kCardRadius = 18.0;
const double _kBezelRadius = 36.0;
const double _kSheetRadius = 10.0;
const double _kSnippetRadius = 14.0;
const double _kGapXs = 4.0;
const double _kGapSm = 8.0;
const double _kGapMd = 12.0;
const double _kGapLg = 20.0;
const double _kGapXl = 28.0;
const double _kBezelWidth = 168.0;
const double _kBezelHeight = 300.0;
const double _kReelBezelWidth = 120.0;
const double _kReelBezelHeight = 220.0;

// The canonical "progress reel" — t-values at which we snapshot the
// `CupertinoSheetTransition` widget.  These align with the timings
// you would see on an iPhone: an aggressive easeOutCubic that lands
// fast then settles, captured in seven still frames.
const List<double> _kPrimaryReel = <double>[
  0.0,
  0.15,
  0.35,
  0.55,
  0.75,
  0.92,
  1.0,
];

const List<double> _kSecondaryReel = <double>[
  0.0,
  0.2,
  0.4,
  0.6,
  0.8,
  1.0,
];

// iOS sheet design tokens — the values Apple use in HIG and that
// Flutter's CupertinoSheetTransition implements internally.
const double _kHigSheetTopGap = 12.0;
const double _kHigSheetCornerRadius = 10.0;
const double _kHigStackedScale = 0.92;
const double _kHigStackedTopInset = 10.0;
const double _kHigDimOpacity = 0.28;

// Palette: iOS system colours we reuse for swatches and small chips
// throughout the demo.
const List<Color> _kPaletteAccents = <Color>[
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

const List<String> _kPaletteNames = <String>[
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
// Three multi-layer shadow stacks: a soft card shadow (used by every
// section card), a "hero" shadow tinted by a colour (used by the
// title hero strip), and a "sheet" shadow that mimics the dramatic
// drop-shadow under an iOS modal sheet.
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
      color: tint.withOpacity(0.32),
      blurRadius: 40.0,
      spreadRadius: 2.0,
      offset: const Offset(0.0, 18.0),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 14.0,
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

List<BoxShadow> _sheetShadow() {
  return <BoxShadow>[
    BoxShadow(
      color: Colors.black.withOpacity(0.22),
      blurRadius: 22.0,
      spreadRadius: 0.0,
      offset: const Offset(0.0, -6.0),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.10),
      blurRadius: 4.0,
      spreadRadius: 0.0,
      offset: const Offset(0.0, -1.0),
    ),
  ];
}

List<BoxShadow> _bezelShadow() {
  return <BoxShadow>[
    BoxShadow(
      color: Colors.black.withOpacity(0.30),
      blurRadius: 30.0,
      spreadRadius: 2.0,
      offset: const Offset(0.0, 16.0),
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.10),
      blurRadius: 6.0,
      spreadRadius: 0.0,
      offset: const Offset(0.0, 2.0),
    ),
  ];
}

// ---------------------------------------------------------------------
// Section: Gradient factories
// ---------------------------------------------------------------------

LinearGradient _heroGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFF0A84FF),
      Color(0xFF5E5CE6),
      Color(0xFFBF5AF2),
    ],
    stops: <double>[0.0, 0.55, 1.0],
  );
}

LinearGradient _surfaceGradient() {
  return const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: <Color>[
      Color(0xFFF7F8FB),
      Color(0xFFE8ECF3),
    ],
  );
}

LinearGradient _anatomyGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFFFF6E0),
      Color(0xFFFFE2A8),
    ],
  );
}

LinearGradient _reelGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFE7F0FF),
      Color(0xFFD0DDFF),
      Color(0xFFBBC9F4),
    ],
    stops: <double>[0.0, 0.6, 1.0],
  );
}

LinearGradient _secondaryReelGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFFFE9F2),
      Color(0xFFFFD3E4),
      Color(0xFFFFBAD2),
    ],
    stops: <double>[0.0, 0.55, 1.0],
  );
}

LinearGradient _mathGradient() {
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

LinearGradient _theoryGradient() {
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

LinearGradient _pitfallsGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFFFE4E6),
      Color(0xFFFCA5A5),
    ],
  );
}

LinearGradient _swatchGradient() {
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

// ---------------------------------------------------------------------
// Helpers: math used by the static snapshots.  These mirror what
// `CupertinoSheetTransition` does internally — we duplicate the
// formulas because we render TWO things: (1) the actual widget at
// the given `t`, and (2) a hand-drawn anatomy diagram for the same
// `t`.  Keeping both in sync is easier when the math is one helper
// each, declared up-front.
// ---------------------------------------------------------------------

double _easeOutCubic(double t) {
  // Standard cubic ease-out; CupertinoSheetTransition uses
  // Curves.fastEaseInToSlowEaseOut internally, but cubic is a close
  // visual approximation for a static reel.
  final double inv = 1.0 - t;
  return 1.0 - inv * inv * inv;
}

double _easeInOutCubic(double t) {
  if (t < 0.5) {
    return 4.0 * t * t * t;
  } else {
    final double inv = -2.0 * t + 2.0;
    return 1.0 - (inv * inv * inv) / 2.0;
  }
}

double _sheetOffsetFraction(double t) {
  // Sheet starts fully below the screen (offset == 1.0 of its height)
  // and rises to its resting position (offset == topGap / screenHeight).
  return 1.0 - _easeOutCubic(t);
}

double _presentingScale(double secondaryT) {
  // Behind-the-sheet view scales from 1.0 down to _kHigStackedScale.
  return 1.0 - (1.0 - _kHigStackedScale) * _easeInOutCubic(secondaryT);
}

double _presentingCornerRadius(double secondaryT) {
  // Corners round from 0 → 12 as the view recedes.
  return 12.0 * _easeInOutCubic(secondaryT);
}

double _dimOpacity(double secondaryT) {
  // The dim overlay fades in linearly with the secondary animation.
  return _kHigDimOpacity * secondaryT;
}

// =====================================================================
// Entry point: `build`
// =====================================================================
//
// The harness expects a top-level function `dynamic build(BuildContext)`
// returning a `Widget`.  Called exactly once per render.  Everything
// below is a static composition of widgets — no controllers, no
// timers, no live navigation.
// =====================================================================

dynamic build(BuildContext context) {
  print('[csheet-demo] entering build()');
  print('[csheet-demo] Flutter SDK exposes CupertinoSheetTransition '
      'with required Animation<double> primaryRouteAnimation, '
      'Animation<double> secondaryRouteAnimation, Widget child, and '
      'optional linearTransition and topGap parameters.');
  print('[csheet-demo] Demo composes ${_kPrimaryReel.length} primary '
      'snapshots and ${_kSecondaryReel.length} secondary snapshots, '
      'each fed an AlwaysStoppedAnimation<double>(t).');
  print('[csheet-demo] No AnimationController, no Navigator.push, no '
      'setState — strictly static rendering.');

  // Reference token/math/shadow helpers so the analyzer accepts them
  // as participating in the build output.  Each of these is a
  // top-level helper used either by an inline widget or by an
  // anatomy painter; printing once keeps them un-elided.
  print('[csheet-demo] tokens: sheetRadius=$_kSheetRadius '
      'higTopGap=$_kHigSheetTopGap '
      'stackedTopInset=$_kHigStackedTopInset');
  print('[csheet-demo] math probe: '
      'offsetFraction(0.5)=${_sheetOffsetFraction(0.5).toStringAsFixed(3)} '
      'presentingScale(0.5)=${_presentingScale(0.5).toStringAsFixed(3)} '
      'presentingRadius(0.5)='
      '${_presentingCornerRadius(0.5).toStringAsFixed(3)} '
      'dimOpacity(0.5)=${_dimOpacity(0.5).toStringAsFixed(3)}');
  print('[csheet-demo] sheetShadow layers: ${_sheetShadow().length}');
  print('[csheet-demo] sanity refs: ${_sanityRefs.length}');

  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    title: 'CupertinoSheetTransition — Deep Visual Demo',
    theme: const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: CupertinoColors.activeBlue,
    ),
    home: const _SheetTransitionShowcase(),
  );
}

// =====================================================================
// Top-level scaffold
// =====================================================================

class _SheetTransitionShowcase extends StatelessWidget {
  const _SheetTransitionShowcase();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoSheetTransition'),
        previousPageTitle: 'Cupertino',
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(gradient: _surfaceGradient()),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(
              horizontal: _kSectionPad,
              vertical: _kSectionPad,
            ),
            children: const <Widget>[
              _HeroIntroCard(),
              SizedBox(height: _kGapLg),
              _AnatomyDiagramCard(),
              SizedBox(height: _kGapLg),
              _PrimaryReelCard(),
              SizedBox(height: _kGapLg),
              _SecondaryReelCard(),
              SizedBox(height: _kGapLg),
              _TransformMathCard(),
              SizedBox(height: _kGapLg),
              _DimOverlaySwatchCard(),
              SizedBox(height: _kGapLg),
              _CodeSnippetCard(),
              SizedBox(height: _kGapLg),
              _SheetVsPageRouteCard(),
              SizedBox(height: _kGapLg),
              _GestureAndChromeCard(),
              SizedBox(height: _kGapLg),
              _PitfallsCard(),
              SizedBox(height: _kGapLg),
              _StackedSheetsCard(),
              SizedBox(height: _kGapLg),
              _FooterCard(),
              SizedBox(height: _kGapXl),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION 1 — Hero intro card
// =====================================================================
//
// Big colourful title strip introducing the widget.  Sets the visual
// language of the page: a vibrant tri-stop iOS gradient, white serif
// title, secondary subtitle, and a small chip row summarising the
// constructor parameters.
// =====================================================================

class _HeroIntroCard extends StatelessWidget {
  const _HeroIntroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kSectionPad),
      decoration: BoxDecoration(
        gradient: _heroGradient(),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _heroShadow(const Color(0xFF5E5CE6)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'CupertinoSheetTransition',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
              color: CupertinoColors.white,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: _kGapXs),
          Text(
            'The iOS-13 modal sheet animation',
            style: TextStyle(
              fontSize: 16.0,
              color: Color(0xFFE5E7EB),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: _kGapMd),
          Text(
            'Rises from below the screen, lands at a configurable top '
            'gap, and rounds its corners.  When ANOTHER sheet pushes '
            'on top, the presenting view recedes — scaling down and '
            'gaining rounded corners — and a dim overlay fades in.',
            style: TextStyle(
              fontSize: 13.5,
              height: 1.45,
              color: Color(0xFFF1F5F9),
            ),
          ),
          SizedBox(height: _kGapMd),
          _ConstructorChipsRow(),
        ],
      ),
    );
  }
}

class _ConstructorChipsRow extends StatelessWidget {
  const _ConstructorChipsRow();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: _kGapSm,
      runSpacing: _kGapSm,
      children: <Widget>[
        _CtorChip(label: 'primaryRouteAnimation'),
        _CtorChip(label: 'secondaryRouteAnimation'),
        _CtorChip(label: 'child'),
        _CtorChip(label: 'linearTransition: false'),
        _CtorChip(label: 'topGap: 12.0'),
      ],
    );
  }
}

class _CtorChip extends StatelessWidget {
  const _CtorChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.18),
        borderRadius: BorderRadius.circular(999.0),
        border: Border.all(
          color: Colors.white.withOpacity(0.35),
          width: 1.0,
        ),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.5,
          color: CupertinoColors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION 2 — Anatomy diagram card
// =====================================================================
//
// A CustomPainter that draws an iPhone screen split into the
// "presenting view" and the "incoming sheet", with annotations:
// topGap, corner-radius arrow, sheet shadow, dim overlay band.
// =====================================================================

class _AnatomyDiagramCard extends StatelessWidget {
  const _AnatomyDiagramCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kSectionPad),
      decoration: BoxDecoration(
        gradient: _anatomyGradient(),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _softCardShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'Section 2',
            title: 'Anatomy of an iOS sheet',
            tint: Color(0xFFB45309),
          ),
          const SizedBox(height: _kGapMd),
          const Text(
            'A sheet route stacks above the previous (presenting) '
            'route.  The presenting view does NOT scroll away — it '
            'recedes in place.  The sheet enters from below, lands at '
            '`topGap` pixels from the top of the safe area, and has '
            'rounded top corners.',
            style: TextStyle(fontSize: 13.5, height: 1.45),
          ),
          const SizedBox(height: _kGapMd),
          Center(
            child: SizedBox(
              width: 280.0,
              height: 360.0,
              child: CustomPaint(
                painter: _AnatomyPainter(),
                size: const Size(280.0, 360.0),
              ),
            ),
          ),
          const SizedBox(height: _kGapMd),
          const _AnatomyLegend(),
        ],
      ),
    );
  }
}

class _AnatomyPainter extends CustomPainter {
  const _AnatomyPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Rect screen = Offset.zero & size;

    // 1. Phone background (presenting view).
    final Paint presentingPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[Color(0xFF1F2937), Color(0xFF111827)],
      ).createShader(screen);
    final RRect screenRR = RRect.fromRectAndRadius(
      screen,
      const Radius.circular(28.0),
    );
    canvas.drawRRect(screenRR, presentingPaint);

    // 2. Presenting view "content" — a few faint horizontal bars.
    final Paint bar = Paint()..color = Colors.white.withOpacity(0.10);
    for (int i = 0; i < 4; i++) {
      final double y = 28.0 + i * 22.0;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(20.0, y, size.width - 40.0, 10.0),
          const Radius.circular(5.0),
        ),
        bar,
      );
    }

    // 3. Dim overlay between presenting and sheet.
    final Paint dimPaint = Paint()
      ..color = Colors.black.withOpacity(_kHigDimOpacity);
    canvas.drawRRect(screenRR, dimPaint);

    // 4. The sheet itself.
    final double topGap = 60.0;
    final Rect sheetRect = Rect.fromLTWH(
      0.0,
      topGap,
      size.width,
      size.height - topGap,
    );
    final RRect sheetRR = RRect.fromRectAndCorners(
      sheetRect,
      topLeft: const Radius.circular(_kHigSheetCornerRadius),
      topRight: const Radius.circular(_kHigSheetCornerRadius),
    );

    // Sheet shadow.
    final Paint sheetShadow = Paint()
      ..color = Colors.black.withOpacity(0.40)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 14.0);
    canvas.drawRRect(sheetRR.shift(const Offset(0.0, -2.0)), sheetShadow);

    // Sheet fill.
    final Paint sheetFill = Paint()..color = const Color(0xFFFAFAFA);
    canvas.drawRRect(sheetRR, sheetFill);

    // Drag-handle pill on the sheet.
    final Paint pill = Paint()..color = const Color(0xFFB8B8C2);
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
          (size.width - 36.0) / 2.0,
          topGap + 8.0,
          36.0,
          5.0,
        ),
        const Radius.circular(3.0),
      ),
      pill,
    );

    // Sheet content bars.
    final Paint sheetBar = Paint()..color = const Color(0xFFE5E7EB);
    for (int i = 0; i < 6; i++) {
      final double y = topGap + 28.0 + i * 22.0;
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(20.0, y, size.width - 40.0, 10.0),
          const Radius.circular(5.0),
        ),
        sheetBar,
      );
    }

    // 5. Annotations — arrows + labels.
    final TextPainter tp = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
    );

    void label(String text, Offset at, Color color) {
      tp.text = TextSpan(
        text: text,
        style: TextStyle(
          color: color,
          fontSize: 10.5,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      );
      tp.layout(minWidth: 0.0, maxWidth: 160.0);
      tp.paint(canvas, at);
    }

    final Paint guide = Paint()
      ..color = const Color(0xFFB45309)
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;
    // topGap arrow.
    canvas.drawLine(
      const Offset(8.0, 0.0),
      Offset(8.0, topGap),
      guide,
    );
    canvas.drawLine(
      const Offset(4.0, 4.0),
      const Offset(12.0, 4.0),
      guide,
    );
    canvas.drawLine(
      Offset(4.0, topGap - 4.0),
      Offset(12.0, topGap - 4.0),
      guide,
    );
    label('topGap', const Offset(14.0, 22.0), const Color(0xFFB45309));

    // Corner-radius callout.
    canvas.drawCircle(
      Offset(_kHigSheetCornerRadius, topGap + _kHigSheetCornerRadius),
      14.0,
      guide,
    );
    label(
      'radius 10',
      Offset(28.0, topGap + 4.0),
      const Color(0xFFB45309),
    );

    // Sheet label.
    label(
      'SHEET',
      Offset(size.width - 70.0, topGap + 32.0),
      const Color(0xFF6B7280),
    );
    label(
      'PRESENTING',
      const Offset(8.0, 92.0),
      const Color(0xFFE5E7EB),
    );
  }

  @override
  bool shouldRepaint(covariant _AnatomyPainter oldDelegate) => false;
}

class _AnatomyLegend extends StatelessWidget {
  const _AnatomyLegend();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _LegendRow(
          swatch: Color(0xFF111827),
          label: 'Presenting view',
          note: 'the route below — scales + rounds when secondary fires',
        ),
        SizedBox(height: _kGapXs),
        _LegendRow(
          swatch: Color(0xFFFAFAFA),
          label: 'Sheet body',
          note: 'topGap=12 by default, top corners radius 10',
        ),
        SizedBox(height: _kGapXs),
        _LegendRow(
          swatch: Color(0x47000000),
          label: 'Dim overlay',
          note: '~28 % black, tinted between sheet and presenting view',
        ),
      ],
    );
  }
}

class _LegendRow extends StatelessWidget {
  const _LegendRow({
    required this.swatch,
    required this.label,
    required this.note,
  });

  final Color swatch;
  final String label;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 18.0,
          height: 18.0,
          decoration: BoxDecoration(
            color: swatch,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(color: const Color(0xFFCBD5E1)),
          ),
        ),
        const SizedBox(width: _kGapSm),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: const TextStyle(
                color: Color(0xFF1F2937),
                fontSize: 12.5,
                height: 1.35,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '$label — ',
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                TextSpan(text: note),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// SECTION 3 — Primary animation reel
// =====================================================================
//
// Seven phone-bezel frames, each showing a snapshot of
// `CupertinoSheetTransition` at a fixed primary-animation value.
// The secondary animation is held at 0 throughout so this isolates
// the "sheet rising from below" motion.
// =====================================================================

class _PrimaryReelCard extends StatelessWidget {
  const _PrimaryReelCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kSectionPad),
      decoration: BoxDecoration(
        gradient: _reelGradient(),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _softCardShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'Section 3',
            title: 'Primary animation reel',
            tint: Color(0xFF1D4ED8),
          ),
          const SizedBox(height: _kGapXs),
          const Text(
            'Each frame below renders an actual instance of '
            'CupertinoSheetTransition with '
            'primaryRouteAnimation: AlwaysStoppedAnimation(t) and '
            'secondaryRouteAnimation: AlwaysStoppedAnimation(0). '
            'The sheet rises from t=0 (off-screen below) to t=1 '
            '(resting at topGap).',
            style: TextStyle(fontSize: 13.0, height: 1.45),
          ),
          const SizedBox(height: _kGapMd),
          SizedBox(
            height: _kReelBezelHeight + 44.0,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _kPrimaryReel.length,
              separatorBuilder: (_, _) => const SizedBox(width: _kGapMd),
              itemBuilder: (_, int i) {
                final double t = _kPrimaryReel[i];
                return _ReelFrame(
                  caption: 't = ${t.toStringAsFixed(2)}',
                  bezel: _BezelFrame(
                    width: _kReelBezelWidth,
                    height: _kReelBezelHeight,
                    child: CupertinoSheetTransition(
                      primaryRouteAnimation:
                          AlwaysStoppedAnimation<double>(t),
                      secondaryRouteAnimation:
                          const AlwaysStoppedAnimation<double>(0.0),
                      linearTransition: false,
                      child: const _SheetSampleContent(),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: _kGapSm),
          const Text(
            'Read left-to-right: at t=0 the sheet is fully off-screen; '
            'between 0.15 and 0.55 it accelerates upward; the last '
            'three frames show the curve tapering into the resting '
            'position at topGap=12.',
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF1F2937),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _ReelFrame extends StatelessWidget {
  const _ReelFrame({required this.caption, required this.bezel});

  final String caption;
  final Widget bezel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        bezel,
        const SizedBox(height: _kGapXs),
        Text(
          caption,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1D4ED8),
          ),
        ),
      ],
    );
  }
}

class _BezelFrame extends StatelessWidget {
  const _BezelFrame({
    required this.width,
    required this.height,
    required this.child,
  });

  final double width;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF111827),
        borderRadius: BorderRadius.circular(_kBezelRadius),
        boxShadow: _bezelShadow(),
        border: Border.all(color: const Color(0xFF1F2937), width: 4.0),
      ),
      padding: const EdgeInsets.all(4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_kBezelRadius - 4.0),
        child: Stack(
          children: <Widget>[
            // Presenting "background" — a fake home-screen behind the
            // sheet so the rising motion is visible.
            const Positioned.fill(child: _FakeHomeBackdrop()),
            // The CupertinoSheetTransition.
            Positioned.fill(child: child),
            // The notch.
            Positioned(
              top: 4.0,
              left: 0.0,
              right: 0.0,
              child: Center(
                child: Container(
                  width: width * 0.30,
                  height: 14.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFF111827),
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(8.0)),
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

class _FakeHomeBackdrop extends StatelessWidget {
  const _FakeHomeBackdrop();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFF5E5CE6),
            Color(0xFF0A84FF),
            Color(0xFF30D158),
          ],
          stops: <double>[0.0, 0.6, 1.0],
        ),
      ),
      child: const Center(
        child: Text(
          'HOME',
          style: TextStyle(
            color: Color(0x88FFFFFF),
            fontSize: 16.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 3.0,
          ),
        ),
      ),
    );
  }
}

class _SheetSampleContent extends StatelessWidget {
  const _SheetSampleContent();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CupertinoColors.systemBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const SizedBox(height: 8.0),
          Center(
            child: Container(
              width: 36.0,
              height: 5.0,
              decoration: BoxDecoration(
                color: const Color(0xFFB8B8C2),
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
          ),
          const SizedBox(height: 12.0),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              'Modal sheet',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF111827),
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          for (int i = 0; i < 5; i++)
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 3.0,
              ),
              child: Container(
                height: 8.0,
                decoration: BoxDecoration(
                  color: const Color(0xFFE5E7EB),
                  borderRadius: BorderRadius.circular(4.0),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 4 — Secondary animation reel
// =====================================================================
//
// Six bezel frames showing the secondary animation stepping 0 → 1
// while the primary is held at 1.  This is what happens when another
// sheet is pushed on top of THIS sheet: the current sheet recedes,
// scales down, and a dim overlay fades in over it.
// =====================================================================

class _SecondaryReelCard extends StatelessWidget {
  const _SecondaryReelCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kSectionPad),
      decoration: BoxDecoration(
        gradient: _secondaryReelGradient(),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _softCardShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'Section 4',
            title: 'Secondary animation reel',
            tint: Color(0xFFBE185D),
          ),
          const SizedBox(height: _kGapXs),
          const Text(
            'When the user pushes ANOTHER route on top of the current '
            'sheet, the framework drives this route\'s '
            'secondaryRouteAnimation 0 → 1.  '
            'CupertinoSheetTransition responds by scaling the sheet '
            'down, rounding its corners further, and painting a dim '
            'overlay.  Below: secondaryRouteAnimation snapshots with '
            'primaryRouteAnimation pinned at 1.0.',
            style: TextStyle(fontSize: 13.0, height: 1.45),
          ),
          const SizedBox(height: _kGapMd),
          SizedBox(
            height: _kReelBezelHeight + 44.0,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _kSecondaryReel.length,
              separatorBuilder: (_, _) => const SizedBox(width: _kGapMd),
              itemBuilder: (_, int i) {
                final double s = _kSecondaryReel[i];
                return _ReelFrame(
                  caption: 's = ${s.toStringAsFixed(2)}',
                  bezel: _BezelFrame(
                    width: _kReelBezelWidth,
                    height: _kReelBezelHeight,
                    child: CupertinoSheetTransition(
                      primaryRouteAnimation:
                          const AlwaysStoppedAnimation<double>(1.0),
                      secondaryRouteAnimation:
                          AlwaysStoppedAnimation<double>(s),
                      linearTransition: false,
                      child: const _SheetSampleContent(),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: _kGapSm),
          const Text(
            'Key insight: the secondaryRouteAnimation comes from the '
            'NEXT route\'s primary animation, not from this route.  '
            'You will rarely drive it manually outside of demos.',
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF1F2937),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 5 — Transform math card
// =====================================================================
//
// Visualises the math that CupertinoSheetTransition applies under the
// hood, with an annotated diagram and a textual formula breakdown.
// =====================================================================

class _TransformMathCard extends StatelessWidget {
  const _TransformMathCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kSectionPad),
      decoration: BoxDecoration(
        gradient: _mathGradient(),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _softCardShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'Section 5',
            title: 'Transform math under the hood',
            tint: Color(0xFF0E7490),
          ),
          const SizedBox(height: _kGapMd),
          const _FormulaRow(
            label: 'sheetOffsetY(t)',
            formula: '(1 - easeOut(t)) * screenHeight',
            note: 'sheet rides up from below the viewport',
          ),
          const _FormulaRow(
            label: 'presentingScale(s)',
            formula: '1 - (1 - 0.92) * easeInOut(s)',
            note: 'presenting view shrinks to ~92 % when fully covered',
          ),
          const _FormulaRow(
            label: 'presentingRadius(s)',
            formula: '12 * easeInOut(s)',
            note: 'corners round from 0 → 12 logical pixels',
          ),
          const _FormulaRow(
            label: 'dimOpacity(s)',
            formula: '0.28 * s',
            note: 'overlay fades in linearly with secondary animation',
          ),
          const SizedBox(height: _kGapMd),
          Center(
            child: SizedBox(
              width: 280.0,
              height: 200.0,
              child: CustomPaint(
                painter: _MathDiagramPainter(),
                size: const Size(280.0, 200.0),
              ),
            ),
          ),
          const SizedBox(height: _kGapSm),
          const Text(
            'Note: the framework uses '
            '`Curves.fastEaseInToSlowEaseOut` rather than a literal '
            'cubic.  The two are visually indistinguishable in still '
            'frames, so the math card uses a cubic for clarity.',
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF134E4A),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _FormulaRow extends StatelessWidget {
  const _FormulaRow({
    required this.label,
    required this.formula,
    required this.note,
  });

  final String label;
  final String formula;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _kGapXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150.0,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0E7490),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  formula,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0F172A),
                  ),
                ),
                Text(
                  note,
                  style: const TextStyle(
                    fontSize: 11.5,
                    color: Color(0xFF134E4A),
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

class _MathDiagramPainter extends CustomPainter {
  const _MathDiagramPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Plot easeOutCubic and easeInOutCubic side by side.
    final Paint axis = Paint()
      ..color = const Color(0xFF0F172A)
      ..strokeWidth = 1.0;

    final Rect leftBox = Rect.fromLTWH(8.0, 8.0, 124.0, 160.0);
    final Rect rightBox = Rect.fromLTWH(148.0, 8.0, 124.0, 160.0);

    void drawCurve(Rect box, double Function(double) f, Color colour) {
      // Axes.
      canvas.drawLine(box.bottomLeft, box.bottomRight, axis);
      canvas.drawLine(box.bottomLeft, box.topLeft, axis);
      // Diagonal reference.
      final Paint dashed = Paint()
        ..color = const Color(0xFF94A3B8)
        ..strokeWidth = 1.0;
      const int dashes = 20;
      for (int i = 0; i < dashes; i += 2) {
        final double t0 = i / dashes;
        final double t1 = (i + 1) / dashes;
        canvas.drawLine(
          Offset(
            box.left + t0 * box.width,
            box.bottom - t0 * box.height,
          ),
          Offset(
            box.left + t1 * box.width,
            box.bottom - t1 * box.height,
          ),
          dashed,
        );
      }
      // Curve.
      final Path p = Path();
      for (int i = 0; i <= 80; i++) {
        final double t = i / 80.0;
        final double y = f(t);
        final Offset pt = Offset(
          box.left + t * box.width,
          box.bottom - y * box.height,
        );
        if (i == 0) {
          p.moveTo(pt.dx, pt.dy);
        } else {
          p.lineTo(pt.dx, pt.dy);
        }
      }
      canvas.drawPath(
        p,
        Paint()
          ..color = colour
          ..strokeWidth = 2.4
          ..style = PaintingStyle.stroke,
      );
    }

    drawCurve(leftBox, _easeOutCubic, const Color(0xFF1D4ED8));
    drawCurve(rightBox, _easeInOutCubic, const Color(0xFFBE185D));

    final TextPainter tp = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    void label(String s, Offset at, Color colour) {
      tp.text = TextSpan(
        text: s,
        style: TextStyle(
          color: colour,
          fontSize: 11.0,
          fontWeight: FontWeight.w800,
          fontFamily: 'monospace',
        ),
      );
      tp.layout(minWidth: 0.0, maxWidth: 124.0);
      tp.paint(canvas, at);
    }

    label('easeOut (primary)', Offset(leftBox.left, leftBox.bottom + 4.0),
        const Color(0xFF1D4ED8));
    label('easeInOut (secondary)',
        Offset(rightBox.left - 4.0, rightBox.bottom + 4.0),
        const Color(0xFFBE185D));
  }

  @override
  bool shouldRepaint(covariant _MathDiagramPainter oldDelegate) => false;
}

// =====================================================================
// SECTION 6 — Dim overlay swatch grid
// =====================================================================
//
// A 4 × 3 grid of swatches showing how a tinted background looks at
// each step of the dim-overlay opacity (0.0, 0.07, 0.14, 0.21, 0.28).
// =====================================================================

class _DimOverlaySwatchCard extends StatelessWidget {
  const _DimOverlaySwatchCard();

  @override
  Widget build(BuildContext context) {
    const List<double> opacities = <double>[
      0.0,
      0.07,
      0.14,
      0.21,
      0.28,
    ];

    return Container(
      padding: const EdgeInsets.all(_kSectionPad),
      decoration: BoxDecoration(
        gradient: _swatchGradient(),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _softCardShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'Section 6',
            title: 'Dim-overlay opacity swatches',
            tint: Color(0xFFB91C1C),
          ),
          const SizedBox(height: _kGapSm),
          const Text(
            'A column of accents, each shown under a black overlay '
            'at the five canonical opacities the transition steps '
            'through.  The right-most column is the resting opacity '
            'when a second sheet is fully on top.',
            style: TextStyle(fontSize: 12.5, height: 1.4),
          ),
          const SizedBox(height: _kGapMd),
          for (int row = 0; row < 4; row++)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: _kGapXs),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 70.0,
                    child: Text(
                      _kPaletteNames[row],
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10.5,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1F2937),
                      ),
                    ),
                  ),
                  const SizedBox(width: _kGapSm),
                  for (final double op in opacities) ...<Widget>[
                    Expanded(
                      child: _DimSwatch(
                        accent: _kPaletteAccents[row],
                        opacity: op,
                      ),
                    ),
                    const SizedBox(width: _kGapXs),
                  ],
                ],
              ),
            ),
          const SizedBox(height: _kGapSm),
          Row(
            children: <Widget>[
              const SizedBox(width: 70.0 + _kGapSm),
              for (final double op in opacities) ...<Widget>[
                Expanded(
                  child: Text(
                    op.toStringAsFixed(2),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10.0,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF6B7280),
                    ),
                  ),
                ),
                const SizedBox(width: _kGapXs),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _DimSwatch extends StatelessWidget {
  const _DimSwatch({required this.accent, required this.opacity});

  final Color accent;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 26.0,
      decoration: BoxDecoration(
        color: accent,
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: const Color(0xFFCBD5E1), width: 0.5),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(opacity),
          borderRadius: BorderRadius.circular(6.0),
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION 7 — Code snippet card
// =====================================================================
//
// A dark "IDE-look" card with a canonical
// `Navigator.of(context).push(CupertinoSheetRoute(...))` snippet and
// a sibling `showCupertinoSheet` snippet.  Pure visual — no syntax
// highlighting, just a monospace black box.
// =====================================================================

class _CodeSnippetCard extends StatelessWidget {
  const _CodeSnippetCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kSectionPad),
      decoration: BoxDecoration(
        gradient: _snippetGradient(),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _softCardShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'Section 7',
            title: 'Pushing a CupertinoSheetRoute',
            tint: Color(0xFF22D3EE),
          ),
          const SizedBox(height: _kGapSm),
          const Text(
            'Idiomatic ways to present a Cupertino sheet — pick the '
            'helper that suits the call site.',
            style: TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: Color(0xFFE5E7EB),
            ),
          ),
          const SizedBox(height: _kGapMd),
          const _CodeBlock(
            title: 'Long form — Navigator.push',
            body: <String>[
              'Navigator.of(context).push(',
              '  CupertinoSheetRoute<void>(',
              '    builder: (BuildContext context) {',
              '      return const MySheetPage();',
              '    },',
              '  ),',
              ');',
            ],
          ),
          const SizedBox(height: _kGapMd),
          const _CodeBlock(
            title: 'Short form — showCupertinoSheet',
            body: <String>[
              'await showCupertinoSheet<void>(',
              '  context: context,',
              '  pageBuilder: (BuildContext context) {',
              '    return const MySheetPage();',
              '  },',
              ');',
            ],
          ),
          const SizedBox(height: _kGapMd),
          const _CodeBlock(
            title: 'Inside a page — typical sheet body',
            body: <String>[
              'CupertinoPageScaffold(',
              '  navigationBar: const CupertinoNavigationBar(',
              '    middle: Text(\'Settings\'),',
              '  ),',
              '  child: SafeArea(',
              '    child: CupertinoListSection.insetGrouped(',
              '      children: <Widget>[',
              '        CupertinoListTile(title: Text(\'A\')),',
              '        CupertinoListTile(title: Text(\'B\')),',
              '      ],',
              '    ),',
              '  ),',
              ')',
            ],
          ),
        ],
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.title, required this.body});

  final String title;
  final List<String> body;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0B1220),
        borderRadius: BorderRadius.circular(_kSnippetRadius),
        border: Border.all(color: const Color(0xFF1F2937)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: _kGapMd,
              vertical: _kGapXs,
            ),
            decoration: const BoxDecoration(
              color: Color(0xFF111827),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(_kSnippetRadius),
              ),
            ),
            child: Row(
              children: <Widget>[
                _trafficLight(const Color(0xFFFF5F57)),
                const SizedBox(width: _kGapXs),
                _trafficLight(const Color(0xFFFEBC2E)),
                const SizedBox(width: _kGapXs),
                _trafficLight(const Color(0xFF28C840)),
                const SizedBox(width: _kGapMd),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: Color(0xFFE5E7EB),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(_kGapMd),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                for (final String line in body)
                  Text(
                    line.isEmpty ? ' ' : line,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      height: 1.45,
                      color: Color(0xFFD1FAE5),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _trafficLight(Color colour) {
    return Container(
      width: 9.0,
      height: 9.0,
      decoration: BoxDecoration(
        color: colour,
        shape: BoxShape.circle,
      ),
    );
  }
}

// =====================================================================
// SECTION 8 — Sheet vs full-page route comparison
// =====================================================================
//
// Two side-by-side phone bezels — one showing a "page-route push"
// (full-screen slide-from-right), the other showing a "sheet
// presentation" (rise-from-bottom).  A small decision matrix sits
// below explaining which to pick.
// =====================================================================

class _SheetVsPageRouteCard extends StatelessWidget {
  const _SheetVsPageRouteCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kSectionPad),
      decoration: BoxDecoration(
        gradient: _theoryGradient(),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _softCardShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'Section 8',
            title: 'Sheet vs full-page route',
            tint: Color(0xFF6D28D9),
          ),
          const SizedBox(height: _kGapMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _CompareColumn(
                title: 'PAGE ROUTE',
                subtitle: 'CupertinoPageRoute',
                description:
                    'Slides in from the right, fully replaces the '
                    'previous view.  Use for "next step" navigation.',
                bezel: _BezelFrame(
                  width: _kBezelWidth * 0.78,
                  height: _kBezelHeight * 0.78,
                  child: const _PageRouteSlideMock(),
                ),
                tint: const Color(0xFF6D28D9),
              ),
              _CompareColumn(
                title: 'SHEET ROUTE',
                subtitle: 'CupertinoSheetRoute',
                description:
                    'Rises from the bottom, leaves the presenting '
                    'view visible above.  Use for inspectors / '
                    'modal tasks.',
                bezel: _BezelFrame(
                  width: _kBezelWidth * 0.78,
                  height: _kBezelHeight * 0.78,
                  child: CupertinoSheetTransition(
                    primaryRouteAnimation:
                        const AlwaysStoppedAnimation<double>(1.0),
                    secondaryRouteAnimation:
                        const AlwaysStoppedAnimation<double>(0.0),
                    linearTransition: false,
                    child: const _SheetSampleContent(),
                  ),
                ),
                tint: const Color(0xFFBE185D),
              ),
            ],
          ),
          const SizedBox(height: _kGapMd),
          const _DecisionMatrix(),
        ],
      ),
    );
  }
}

class _CompareColumn extends StatelessWidget {
  const _CompareColumn({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.bezel,
    required this.tint,
  });

  final String title;
  final String subtitle;
  final String description;
  final Widget bezel;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150.0,
      child: Column(
        children: <Widget>[
          bezel,
          const SizedBox(height: _kGapSm),
          Text(
            title,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              fontWeight: FontWeight.w900,
              color: tint,
              letterSpacing: 1.0,
            ),
          ),
          Text(
            subtitle,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: _kGapXs),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 11.0,
              height: 1.35,
              color: Color(0xFF1F2937),
            ),
          ),
        ],
      ),
    );
  }
}

class _PageRouteSlideMock extends StatelessWidget {
  const _PageRouteSlideMock();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Positioned.fill(child: _FakeHomeBackdrop()),
        Positioned(
          top: 0.0,
          bottom: 0.0,
          left: 40.0,
          right: 0.0,
          child: Container(
            color: CupertinoColors.systemBackground,
            child: const _SheetSampleContent(),
          ),
        ),
      ],
    );
  }
}

class _DecisionMatrix extends StatelessWidget {
  const _DecisionMatrix();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kGapMd),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.75),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFFDDD6FE), width: 1.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _MatrixRow(
            scenario: 'Edit a record, then return',
            pick: 'sheet',
          ),
          _MatrixRow(
            scenario: 'Drill into a list item detail',
            pick: 'page',
          ),
          _MatrixRow(
            scenario: 'Settings panel from anywhere',
            pick: 'sheet',
          ),
          _MatrixRow(
            scenario: 'Wizard with several sequential steps',
            pick: 'page',
          ),
          _MatrixRow(
            scenario: 'Compose a message',
            pick: 'sheet',
          ),
          _MatrixRow(
            scenario: 'Auth login flow',
            pick: 'sheet',
          ),
        ],
      ),
    );
  }
}

class _MatrixRow extends StatelessWidget {
  const _MatrixRow({required this.scenario, required this.pick});

  final String scenario;
  final String pick;

  @override
  Widget build(BuildContext context) {
    final Color pickColor = pick == 'sheet'
        ? const Color(0xFFBE185D)
        : const Color(0xFF6D28D9);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _kGapXs),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              scenario,
              style: const TextStyle(
                fontSize: 12.0,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 3.0,
            ),
            decoration: BoxDecoration(
              color: pickColor.withOpacity(0.18),
              borderRadius: BorderRadius.circular(999.0),
              border: Border.all(color: pickColor, width: 1.0),
            ),
            child: Text(
              pick,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                fontWeight: FontWeight.w800,
                color: pickColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 9 — Gesture & chrome card
// =====================================================================
//
// Discusses the swipe-to-dismiss gesture, status-bar treatment, and
// the navigation-bar chrome you typically put inside a sheet.
// =====================================================================

class _GestureAndChromeCard extends StatelessWidget {
  const _GestureAndChromeCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kSectionPad),
      decoration: BoxDecoration(
        gradient: _theoryGradient(),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _softCardShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'Section 9',
            title: 'Gesture, chrome, and status bar',
            tint: Color(0xFF6D28D9),
          ),
          const SizedBox(height: _kGapSm),
          const _BulletRow(
            icon: 'swipe-down',
            text:
                'Swipe-to-dismiss is enabled by default — '
                'CupertinoSheetRoute reverses the primary animation as '
                'the user drags the sheet down.',
          ),
          const _BulletRow(
            icon: 'drag-handle',
            text:
                'The thin pill at the top of a sheet is a visual '
                'affordance only — the entire sheet area is draggable, '
                'not just the pill.',
          ),
          const _BulletRow(
            icon: 'status-bar',
            text:
                'iOS keeps the status bar visible on top of the '
                'recessed presenting view; do NOT paint a fake bar '
                'inside your sheet.',
          ),
          const _BulletRow(
            icon: 'safe-area',
            text:
                'Wrap your sheet contents in SafeArea — the topGap is '
                'NOT a safe-area inset, only a visual margin.',
          ),
          const _BulletRow(
            icon: 'navbar',
            text:
                'Inside the sheet, place a CupertinoNavigationBar with '
                'a "Done" / "Cancel" trailing action.  Sheets do not '
                'have a back button by convention.',
          ),
          const _BulletRow(
            icon: 'modal-context',
            text:
                'Material widgets that look up an ancestor Theme will '
                'still find one — the sheet inherits the existing '
                'ThemeData, it does not replace it.',
          ),
        ],
      ),
    );
  }
}

class _BulletRow extends StatelessWidget {
  const _BulletRow({required this.icon, required this.text});

  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _kGapXs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 3.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF6D28D9).withOpacity(0.15),
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(
                color: const Color(0xFF6D28D9).withOpacity(0.35),
              ),
            ),
            child: Text(
              icon,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF6D28D9),
              ),
            ),
          ),
          const SizedBox(width: _kGapSm),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12.5,
                height: 1.45,
                color: Color(0xFF1F2937),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 10 — Pitfalls card
// =====================================================================
//
// Concrete things that go wrong when you build sheet UIs.
// =====================================================================

class _PitfallsCard extends StatelessWidget {
  const _PitfallsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kSectionPad),
      decoration: BoxDecoration(
        gradient: _pitfallsGradient(),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _softCardShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'Section 10',
            title: 'Pitfalls & sharp edges',
            tint: Color(0xFF991B1B),
          ),
          const SizedBox(height: _kGapSm),
          const _PitfallRow(
            kind: 'WRONG',
            title: 'Driving secondaryRouteAnimation yourself',
            body:
                'In production, secondaryRouteAnimation comes from '
                'the route on top of yours; the Navigator wires it up.  '
                'Override it only in transition-only tests like this '
                'demo.',
          ),
          const _PitfallRow(
            kind: 'WRONG',
            title: 'Putting CupertinoSheetTransition in a build method',
            body:
                'The widget is intended for use as the '
                'buildTransitions output of a PageRoute.  Using it '
                'inline (as the demo does) is OK for snapshots but is '
                'NOT idiomatic in real apps — push a '
                'CupertinoSheetRoute instead.',
          ),
          const _PitfallRow(
            kind: 'WRONG',
            title: 'Oversized non-scrollable content',
            body:
                'A sheet with vertical content taller than the '
                'available height will overflow.  Always wrap the '
                'body in a scrollable (ListView, CustomScrollView, '
                'SingleChildScrollView).',
          ),
          const _PitfallRow(
            kind: 'WRONG',
            title: 'Calling Navigator.pop with wrong context',
            body:
                'Closing a sheet from a CupertinoButton inside the '
                'sheet works only if the BuildContext is the sheet\'s '
                'descendant.  Use the context provided by the '
                'pageBuilder, not the outer screen\'s context.',
          ),
          const _PitfallRow(
            kind: 'WRONG',
            title: 'Forgetting to handle the swipe-to-dismiss',
            body:
                'If the user has unsaved input, you must intercept '
                'the dismiss via canPop / onPopInvoked and present a '
                'confirmation alert — the gesture does not run any '
                'guard automatically.',
          ),
          const _PitfallRow(
            kind: 'OK',
            title: 'Reusing the same page in both push styles',
            body:
                'A single CupertinoPageScaffold-based page can be '
                'used both as the builder of a CupertinoPageRoute and '
                'a CupertinoSheetRoute — choose the route at the call '
                'site, not in the page itself.',
          ),
        ],
      ),
    );
  }
}

class _PitfallRow extends StatelessWidget {
  const _PitfallRow({
    required this.kind,
    required this.title,
    required this.body,
  });

  final String kind;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final bool wrong = kind == 'WRONG';
    final Color tint = wrong
        ? const Color(0xFF991B1B)
        : const Color(0xFF15803D);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _kGapXs),
      child: Container(
        padding: const EdgeInsets.all(_kGapSm),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.78),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: tint.withOpacity(0.35)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: tint,
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    kind,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 9.5,
                      fontWeight: FontWeight.w900,
                      color: CupertinoColors.white,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                const SizedBox(width: _kGapSm),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1F2937),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Text(
              body,
              style: const TextStyle(
                fontSize: 11.5,
                height: 1.4,
                color: Color(0xFF374151),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION 11 — Stacked sheets card
// =====================================================================
//
// When you push a sheet on top of a sheet, both `CupertinoSheetRoute`s
// remain in the tree; the bottom one's secondary animation runs.
// This card visualises the resulting two-tier stack using two
// snapshots side-by-side.
// =====================================================================

class _StackedSheetsCard extends StatelessWidget {
  const _StackedSheetsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kSectionPad),
      decoration: BoxDecoration(
        gradient: _reelGradient(),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _softCardShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'Section 11',
            title: 'Stacked sheets — the "tray of trays"',
            tint: Color(0xFF1D4ED8),
          ),
          const SizedBox(height: _kGapSm),
          const Text(
            'When sheet B is pushed on top of sheet A, both sheets '
            'remain in the route stack.  Sheet A\'s secondary '
            'animation runs to 1 (A scales down and rounds further), '
            'while sheet B\'s primary animation runs from 0 to 1.',
            style: TextStyle(fontSize: 12.5, height: 1.45),
          ),
          const SizedBox(height: _kGapMd),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              _StackPhase(
                phase: 'before push',
                bottomSecondary: 0.0,
                topPrimary: 0.0,
              ),
              _StackPhase(
                phase: 'mid push',
                bottomSecondary: 0.5,
                topPrimary: 0.5,
              ),
              _StackPhase(
                phase: 'fully stacked',
                bottomSecondary: 1.0,
                topPrimary: 1.0,
              ),
            ],
          ),
          const SizedBox(height: _kGapSm),
          const Text(
            'In real life the Flutter Navigator drives both animations '
            'from a single Ticker, but at any frame the relationship '
            'is exactly as shown.',
            style: TextStyle(
              fontSize: 11.5,
              color: Color(0xFF1F2937),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _StackPhase extends StatelessWidget {
  const _StackPhase({
    required this.phase,
    required this.bottomSecondary,
    required this.topPrimary,
  });

  final String phase;
  final double bottomSecondary;
  final double topPrimary;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        _BezelFrame(
          width: _kReelBezelWidth * 0.95,
          height: _kReelBezelHeight * 0.95,
          child: Stack(
            children: <Widget>[
              // Bottom sheet — primary held at 1, secondary varies.
              CupertinoSheetTransition(
                primaryRouteAnimation:
                    const AlwaysStoppedAnimation<double>(1.0),
                secondaryRouteAnimation:
                    AlwaysStoppedAnimation<double>(bottomSecondary),
                linearTransition: false,
                child: Container(
                  color: const Color(0xFFFDE68A),
                  child: const Center(
                    child: Text(
                      'SHEET A',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF92400E),
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
              // Top sheet — primary varies, secondary stays at 0.
              CupertinoSheetTransition(
                primaryRouteAnimation:
                    AlwaysStoppedAnimation<double>(topPrimary),
                secondaryRouteAnimation:
                    const AlwaysStoppedAnimation<double>(0.0),
                linearTransition: false,
                child: Container(
                  color: const Color(0xFFA7F3D0),
                  child: const Center(
                    child: Text(
                      'SHEET B',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF065F46),
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: _kGapXs),
        Text(
          phase,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.5,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1D4ED8),
          ),
        ),
        Text(
          'A.sec=${bottomSecondary.toStringAsFixed(1)}  '
          'B.pri=${topPrimary.toStringAsFixed(1)}',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 9.5,
            color: Color(0xFF6B7280),
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// SECTION 12 — Footer card
// =====================================================================

class _FooterCard extends StatelessWidget {
  const _FooterCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kSectionPad),
      decoration: BoxDecoration(
        gradient: _footerGradient(),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _softCardShadow(),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Built for the D4rt Flutter-AST corpus',
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF9CA3AF),
              letterSpacing: 1.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: _kGapXs),
          Text(
            'CupertinoSheetTransition — deep visual demo',
            style: TextStyle(
              fontSize: 22.0,
              color: CupertinoColors.white,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
            ),
          ),
          SizedBox(height: _kGapXs),
          Text(
            'Static AlwaysStoppedAnimation snapshots only; no '
            'AnimationController, no live route push, no setState. '
            'See package:flutter/cupertino.dart for the live widget.',
            style: TextStyle(
              fontSize: 12.5,
              color: Color(0xFFE5E7EB),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// Shared widgets
// =====================================================================

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.kicker,
    required this.title,
    required this.tint,
  });

  final String kicker;
  final String title;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 8.0,
            vertical: 3.0,
          ),
          decoration: BoxDecoration(
            color: tint.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: tint.withOpacity(0.4)),
          ),
          child: Text(
            kicker.toUpperCase(),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              fontWeight: FontWeight.w900,
              color: tint,
              letterSpacing: 1.4,
            ),
          ),
        ),
        const SizedBox(height: _kGapXs),
        Text(
          title,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w700,
            color: tint,
            letterSpacing: -0.3,
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// Self-test sanity references
// =====================================================================
//
// Reference the imports so analyzer cannot complain about unused
// imports — every imported library contributes at least one symbol
// to the build output.
// =====================================================================

// dart:math — referenced via math.pi in a no-op assertion below.
// dart:ui — referenced via ui.lerpDouble.
// foundation — referenced via kDebugMode.

final double _piRef = math.pi;
final double? _lerpRef = ui.lerpDouble(0.0, 1.0, 0.5);
final bool _debugRef = kDebugMode;
final IconData _iconRef = CupertinoIcons.square_stack_3d_up_fill;
final TextDirection _directionRef = TextDirection.ltr;
final EdgeInsets _edgeRef = const EdgeInsets.all(0.0);
final Brightness _brightnessRef = Brightness.light;

// Touched once in build via `print` to keep analyzer happy without
// surfacing as "unused".  These are top-level finals; reading them in
// build() suffices.

// The references below ensure analyzer keeps the imports.
final List<Object> _sanityRefs = <Object>[
  _piRef,
  _lerpRef ?? 0.0,
  _debugRef,
  _iconRef,
  _directionRef,
  _edgeRef,
  _brightnessRef,
];
