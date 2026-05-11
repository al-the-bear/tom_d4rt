// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// =====================================================================
// CupertinoSheetRoute<T> — Deep Visual Demo
// =====================================================================
//
// This file is a hand-authored, analyzer-clean visual showcase for
// `CupertinoSheetRoute<T>`, the modal-sheet route class that ships in
// `package:flutter/cupertino.dart`, plus the surrounding API surfaces:
// `showCupertinoSheet<T>`, `CupertinoSheetTransition`, and the
// `PageRoute<T>` / `ModalRoute<T>` superclass machinery the route
// inherits from.
//
// Constructor signature (paraphrased from the Flutter framework):
//
//   class CupertinoSheetRoute<T> extends PageRoute<T> {
//     CupertinoSheetRoute({
//       required WidgetBuilder builder,
//       RouteSettings? settings,
//       bool maintainState = true,
//       bool enableNavigationStack = false,
//     });
//   }
//
//   Future<T?> showCupertinoSheet<T>({
//     required BuildContext context,
//     required WidgetBuilder pageBuilder,
//     bool useNestedNavigation = false,
//   });
//
// The route inherits most of its behaviour from `PageRoute<T>` and
// `ModalRoute<T>`: barrier handling, transition timing, settings,
// pop completion, animation status notifiers.  The Cupertino part is
// the visual transition (`CupertinoSheetTransition`) and the
// swipe-to-dismiss gesture handling.
//
// Because the demo runs inside the D4rt interpreter sandbox, certain
// Flutter idioms are off-limits:
//
//   * No `AnimationController` — there is no `Ticker`/`vsync`.
//   * No `Navigator.push` of a real `CupertinoSheetRoute` — there is
//     no live Navigator to drive the route's primary animation in a
//     static render.
//   * No `setState`, no `StatefulWidget` at the top level — the
//     harness re-renders by re-invoking `build()`, so every "frame"
//     of interest is its own widget instance tiled in a static
//     scrollable column.
//   * No `Timer`, no `Future` — everything is computed eagerly.
//
// The demo focuses on the ROUTE class.  Where the sister file
// `cupertino_sheet_transition_test.dart` zoomed in on the transition
// widget itself, this file pulls the camera out to show:
//
//   1. Hero card with API-surface chips
//   2. Sheet-route anatomy painter (presenting + sheet + dim overlay)
//   3. Bezel reel of `CupertinoSheetTransition` at five t-values,
//      framed as sheet-route presentation snapshots
//   4. ModalRoute → PageRoute → CupertinoSheetRoute hierarchy diagram
//   5. API table card listing constructor params + inherited semantics
//   6. `showCupertinoSheet` code-snippet cards (4 idiomatic usages)
//   7. Sheet vs PageRoute vs CupertinoPageRoute vs ModalPopupRoute
//      comparison table
//   8. Sheet body design guide (safe-area, scrollable content,
//      drag-to-dismiss, top notch / back button)
//   9. State diagram (pushed → presenting → dismissible → popping →
//      disposed) rendered with a CustomPainter
//  10. Pitfalls / sharp-edges callouts (observers, double-pop, leaks,
//      oversized content, swipe-gesture collisions, popUntil traps)
//  11. Footer cheat-sheet
//
// Every numeric and colour token is `const`-promoted where the
// framework permits, with a strict lint policy enforced by the single
// `ignore_for_file` header above.
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
// all reference the same canonical values.  Kept deliberately close
// to the sister-file's tokens so the two demos read as a pair.
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
const double _kReelBezelWidth = 124.0;
const double _kReelBezelHeight = 224.0;

// The route reel uses a coarse 5-step progress — enough to read the
// rise-and-settle story without crowding the row.
const List<double> _kRouteReel = <double>[
  0.0,
  0.25,
  0.5,
  0.75,
  1.0,
];

// iOS sheet design tokens — the values that the framework's
// `CupertinoSheetTransition` implements internally.
const double _kHigSheetTopGap = 12.0;
const double _kHigSheetCornerRadius = 10.0;
const double _kHigStackedScale = 0.92;
const double _kHigStackedTopInset = 10.0;
const double _kHigDimOpacity = 0.28;
const Duration _kDefaultTransition = Duration(milliseconds: 500);

// State-diagram nodes — the lifecycle a CupertinoSheetRoute moves
// through from `install()` through to disposal.
const List<String> _kLifecycleNodes = <String>[
  'pushed',
  'presenting',
  'idle',
  'dismissible',
  'popping',
  'disposed',
];

// Palette: iOS system colours we reuse for swatches and small chips.
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
      Color(0xFF30D158),
      Color(0xFF5E5CE6),
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

LinearGradient _hierarchyGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFE0F2FE),
      Color(0xFFBAE6FD),
      Color(0xFF7DD3FC),
    ],
    stops: <double>[0.0, 0.55, 1.0],
  );
}

LinearGradient _apiTableGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFECFDF5),
      Color(0xFFA7F3D0),
    ],
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

LinearGradient _compareGradient() {
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

LinearGradient _designGuideGradient() {
  return const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: <Color>[
      Color(0xFFFFFBEB),
      Color(0xFFFEF3C7),
      Color(0xFFFDE68A),
    ],
    stops: <double>[0.0, 0.55, 1.0],
  );
}

LinearGradient _stateGradient() {
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
// Helpers: math used by the static snapshots.  Mirrors what
// `CupertinoSheetTransition` does internally for the curves we plot
// in the state diagram.
// ---------------------------------------------------------------------

double _easeOutCubic(double t) {
  final double inv = 1.0 - t;
  return 1.0 - inv * inv * inv;
}

double _sheetOffsetFraction(double t) {
  return 1.0 - _easeOutCubic(t);
}

double _dimOpacity(double secondaryT) {
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
  print('[csheet-route-demo] entering build()');
  print('[csheet-route-demo] CupertinoSheetRoute<T> extends PageRoute<T>');
  print('[csheet-route-demo] reel snapshots: ${_kRouteReel.length}');
  print('[csheet-route-demo] lifecycle nodes: ${_kLifecycleNodes.length}');
  print('[csheet-route-demo] default transitionDuration: '
      '${_kDefaultTransition.inMilliseconds}ms');
  print('[csheet-route-demo] math probe: '
      'offsetFraction(0.5)=${_sheetOffsetFraction(0.5).toStringAsFixed(3)} '
      'dimOpacity(0.5)=${_dimOpacity(0.5).toStringAsFixed(3)}');
  print('[csheet-route-demo] palette accents: ${_kPaletteAccents.length}');
  print('[csheet-route-demo] sanity refs: ${_sanityRefs.length}');

  return CupertinoApp(
    debugShowCheckedModeBanner: false,
    title: 'CupertinoSheetRoute — Deep Visual Demo',
    theme: const CupertinoThemeData(
      brightness: Brightness.light,
      primaryColor: CupertinoColors.activeBlue,
    ),
    home: const _SheetRouteShowcase(),
  );
}

// =====================================================================
// Top-level scaffold
// =====================================================================

class _SheetRouteShowcase extends StatelessWidget {
  const _SheetRouteShowcase();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('CupertinoSheetRoute'),
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
              _BezelReelCard(),
              SizedBox(height: _kGapLg),
              _HierarchyDiagramCard(),
              SizedBox(height: _kGapLg),
              _ApiTableCard(),
              SizedBox(height: _kGapLg),
              _ShowSheetSnippetCard(),
              SizedBox(height: _kGapLg),
              _RouteComparisonCard(),
              SizedBox(height: _kGapLg),
              _SheetBodyDesignGuideCard(),
              SizedBox(height: _kGapLg),
              _LifecycleDiagramCard(),
              SizedBox(height: _kGapLg),
              _PitfallsCard(),
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
// Big colourful title strip introducing the route.  Establishes the
// page's visual language: tri-stop iOS gradient, white title, chip
// row naming the API surfaces this file covers.
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
        boxShadow: _heroShadow(const Color(0xFF0A84FF)),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'CupertinoSheetRoute<T>',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.w700,
              color: CupertinoColors.white,
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: _kGapXs),
          Text(
            'The PageRoute subclass behind every iOS modal sheet',
            style: TextStyle(
              fontSize: 16.0,
              color: Color(0xFFE5E7EB),
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: _kGapMd),
          Text(
            'A typed PageRoute that wraps its builder in '
            'CupertinoSheetTransition. Push it through any Navigator '
            'or use the showCupertinoSheet<T> helper to await a '
            'typed return value.  Inherits barrier handling, '
            'transition timing, and pop semantics from ModalRoute<T>.',
            style: TextStyle(
              fontSize: 13.5,
              height: 1.45,
              color: Color(0xFFF1F5F9),
            ),
          ),
          SizedBox(height: _kGapMd),
          _ApiChipRow(),
        ],
      ),
    );
  }
}

class _ApiChipRow extends StatelessWidget {
  const _ApiChipRow();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: _kGapSm,
      runSpacing: _kGapSm,
      children: <Widget>[
        _ApiChip(label: 'CupertinoSheetRoute<T>'),
        _ApiChip(label: 'showCupertinoSheet<T>'),
        _ApiChip(label: 'CupertinoSheetTransition'),
        _ApiChip(label: 'extends PageRoute<T>'),
        _ApiChip(label: 'ModalRoute<T>'),
      ],
    );
  }
}

class _ApiChip extends StatelessWidget {
  const _ApiChip({required this.label});

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
// CustomPainter rendering of an iPhone screen split into the
// "presenting view" (recessed behind) and the "incoming sheet" (rising
// from the bottom), with annotations for: topGap, corner radius,
// sheet drop-shadow, dim overlay region.
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
            title: 'Sheet-route anatomy',
            tint: Color(0xFFB45309),
          ),
          const SizedBox(height: _kGapMd),
          const Text(
            'A CupertinoSheetRoute stacks above the previous route.  '
            'The presenting view does NOT scroll away — it recedes in '
            'place (scaled 0.92x with rounded corners).  The sheet '
            'enters from below the screen, lands at `topGap` pixels '
            'from the top of the safe area, and has rounded top '
            'corners.  A dim overlay sits between the two layers.',
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

    // 3. Recessed-presenting rectangle outline — what the presenting
    // view scales down to once the sheet is fully on top.
    final Paint recessed = Paint()
      ..color = const Color(0xFF60A5FA).withOpacity(0.6)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    final double inset = size.width * (1.0 - _kHigStackedScale) / 2.0;
    final Rect recessedRect = Rect.fromLTWH(
      inset,
      _kHigStackedTopInset,
      size.width - inset * 2.0,
      (size.height - _kHigStackedTopInset) * _kHigStackedScale,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(recessedRect, const Radius.circular(12.0)),
      recessed,
    );

    // 4. Dim overlay between presenting and sheet.
    final Paint dimPaint = Paint()
      ..color = Colors.black.withOpacity(_kHigDimOpacity);
    canvas.drawRRect(screenRR, dimPaint);

    // 5. The sheet itself.
    const double topGap = 60.0;
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

    // Sheet drop-shadow above the sheet's top edge.
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

    // 6. Annotations — arrows + labels.
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
    canvas.drawLine(const Offset(8.0, 0.0), const Offset(8.0, topGap), guide);
    canvas.drawLine(
      const Offset(4.0, 4.0),
      const Offset(12.0, 4.0),
      guide,
    );
    canvas.drawLine(
      const Offset(4.0, topGap - 4.0),
      const Offset(12.0, topGap - 4.0),
      guide,
    );
    label('topGap', const Offset(14.0, 22.0), const Color(0xFFB45309));

    // Corner-radius callout.
    canvas.drawCircle(
      const Offset(_kHigSheetCornerRadius, topGap + _kHigSheetCornerRadius),
      14.0,
      guide,
    );
    label(
      'radius 10',
      const Offset(28.0, topGap + 4.0),
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
    label(
      'recessed 0.92x',
      Offset(inset + 4.0, _kHigStackedTopInset + 4.0),
      const Color(0xFF60A5FA),
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
          note: 'the route below — recedes when secondary fires',
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
          note: '~28 % black, painted between sheet and presenting view',
        ),
        SizedBox(height: _kGapXs),
        _LegendRow(
          swatch: Color(0xFF60A5FA),
          label: 'Recessed bounds',
          note: 'where the presenting view ends up at secondary=1',
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
// SECTION 3 — Bezel reel of sheet-route presentations
// =====================================================================
//
// Five iPhone-bezel snapshots at t = 0.0, 0.25, 0.5, 0.75, 1.0.  Each
// frame renders an actual `CupertinoSheetTransition` driven by an
// `AlwaysStoppedAnimation<double>(t)` — this is the route's primary
// animation captured at five points along the easeOut curve.
// =====================================================================

class _BezelReelCard extends StatelessWidget {
  const _BezelReelCard();

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
            title: 'Route presentation reel',
            tint: Color(0xFF1D4ED8),
          ),
          const SizedBox(height: _kGapXs),
          const Text(
            'Five static snapshots of CupertinoSheetTransition fed an '
            'AlwaysStoppedAnimation<double>(t).  In production, t is '
            'driven by the Navigator from 0 to 1 over the route\'s '
            'transitionDuration (500ms by default).  Each snapshot '
            'below is wrapped in a phone-bezel frame.',
            style: TextStyle(fontSize: 13.0, height: 1.45),
          ),
          const SizedBox(height: _kGapMd),
          SizedBox(
            height: _kReelBezelHeight + 44.0,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _kRouteReel.length,
              separatorBuilder: (_, _) => const SizedBox(width: _kGapMd),
              itemBuilder: (_, int i) {
                final double t = _kRouteReel[i];
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
            'At t=0 the sheet is fully off-screen below the viewport; '
            'at t=1 it rests at topGap=12 from the top of the safe '
            'area.  Between those, the eased-cubic curve produces an '
            'aggressive rise that settles softly into place.',
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
            const Positioned.fill(child: _FakeHomeBackdrop()),
            Positioned.fill(child: child),
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
// SECTION 4 — Hierarchy diagram card
// =====================================================================
//
// A CustomPainter rendering of the class hierarchy:
//   Object → Route<T> → OverlayRoute<T> → TransitionRoute<T>
//          → ModalRoute<T> → PageRoute<T> → CupertinoSheetRoute<T>
//
// Each box lists which behaviours that class contributes.  The
// painter draws boxes with connector lines and labels.
// =====================================================================

class _HierarchyDiagramCard extends StatelessWidget {
  const _HierarchyDiagramCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kSectionPad),
      decoration: BoxDecoration(
        gradient: _hierarchyGradient(),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _softCardShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'Section 4',
            title: 'ModalRoute → PageRoute → CupertinoSheetRoute',
            tint: Color(0xFF0369A1),
          ),
          const SizedBox(height: _kGapMd),
          const Text(
            'CupertinoSheetRoute inherits the bulk of its behaviour. '
            'The list below names every superclass and the slice of '
            'behaviour it contributes.  When you push a sheet, you are '
            'getting all of these features composed.',
            style: TextStyle(fontSize: 13.0, height: 1.45),
          ),
          const SizedBox(height: _kGapMd),
          const _HierarchyNode(
            label: 'Route<T>',
            note: 'install / dispose lifecycle, popped Future',
            tint: Color(0xFF075985),
            indent: 0,
          ),
          _HierarchyArrow(),
          const _HierarchyNode(
            label: 'OverlayRoute<T>',
            note: 'overlayEntries — how the route paints itself',
            tint: Color(0xFF0369A1),
            indent: 1,
          ),
          _HierarchyArrow(),
          const _HierarchyNode(
            label: 'TransitionRoute<T>',
            note: 'animation / secondaryAnimation, transitionDuration',
            tint: Color(0xFF0284C7),
            indent: 2,
          ),
          _HierarchyArrow(),
          const _HierarchyNode(
            label: 'ModalRoute<T>',
            note: 'barrier, dismissible, focus, scoped gestures',
            tint: Color(0xFF0EA5E9),
            indent: 3,
          ),
          _HierarchyArrow(),
          const _HierarchyNode(
            label: 'PageRoute<T>',
            note: 'fullscreenDialog flag, opaque, isCurrent helpers',
            tint: Color(0xFF38BDF8),
            indent: 4,
          ),
          _HierarchyArrow(),
          const _HierarchyNode(
            label: 'CupertinoSheetRoute<T>',
            note: 'sheet transition + swipe-down dismiss gesture',
            tint: Color(0xFF1D4ED8),
            indent: 5,
            leaf: true,
          ),
          const SizedBox(height: _kGapMd),
          const Text(
            'Inherited members you may want to override or read:',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF0F172A),
            ),
          ),
          const SizedBox(height: _kGapXs),
          const _InheritedList(),
        ],
      ),
    );
  }
}

class _HierarchyNode extends StatelessWidget {
  const _HierarchyNode({
    required this.label,
    required this.note,
    required this.tint,
    required this.indent,
    this.leaf = false,
  });

  final String label;
  final String note;
  final Color tint;
  final int indent;
  final bool leaf;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: indent * 14.0, top: 2.0, bottom: 2.0),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: _kGapMd,
          vertical: _kGapSm,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(leaf ? 0.95 : 0.80),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(
            color: tint,
            width: leaf ? 2.0 : 1.0,
          ),
        ),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 6.0,
                vertical: 2.0,
              ),
              decoration: BoxDecoration(
                color: tint,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                label,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  fontWeight: FontWeight.w900,
                  color: CupertinoColors.white,
                ),
              ),
            ),
            const SizedBox(width: _kGapSm),
            Expanded(
              child: Text(
                note,
                style: const TextStyle(
                  fontSize: 11.5,
                  height: 1.3,
                  color: Color(0xFF1F2937),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HierarchyArrow extends StatelessWidget {
  const _HierarchyArrow();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 24.0),
      child: Text(
        '↓',
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 14.0,
          fontWeight: FontWeight.w900,
          color: Color(0xFF0369A1),
        ),
      ),
    );
  }
}

class _InheritedList extends StatelessWidget {
  const _InheritedList();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _InheritedRow(
          name: 'barrierColor',
          note: 'null for sheet — sheet handles its own dim overlay',
        ),
        _InheritedRow(
          name: 'barrierDismissible',
          note: 'true — tapping outside the sheet pops it',
        ),
        _InheritedRow(
          name: 'barrierLabel',
          note: 'a11y label announced when the barrier is focused',
        ),
        _InheritedRow(
          name: 'settings (RouteSettings)',
          note: 'name + arguments, used by RouteObserver',
        ),
        _InheritedRow(
          name: 'transitionDuration',
          note: '500ms by default; framework-tuned to feel iOS-native',
        ),
        _InheritedRow(
          name: 'reverseTransitionDuration',
          note: 'matches transitionDuration; pop animates the same',
        ),
        _InheritedRow(
          name: 'opaque',
          note: 'false — the presenting view is still painted below',
        ),
        _InheritedRow(
          name: 'maintainState',
          note: 'true — the route below stays mounted while sheet is up',
        ),
        _InheritedRow(
          name: 'animation / secondaryAnimation',
          note: 'driven by the Navigator; exposed as ProxyAnimation',
        ),
        _InheritedRow(
          name: 'isFirst / isActive / isCurrent',
          note: 'navigator-state introspection, read inside didPopNext etc.',
        ),
      ],
    );
  }
}

class _InheritedRow extends StatelessWidget {
  const _InheritedRow({required this.name, required this.note});

  final String name;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 170.0,
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0369A1),
              ),
            ),
          ),
          Expanded(
            child: Text(
              note,
              style: const TextStyle(
                fontSize: 11.5,
                height: 1.35,
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
// SECTION 5 — API table card
// =====================================================================
//
// A formal table of CupertinoSheetRoute<T>'s constructor parameters
// and key properties.  Three columns: name, type, semantics.
// =====================================================================

class _ApiTableCard extends StatelessWidget {
  const _ApiTableCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kSectionPad),
      decoration: BoxDecoration(
        gradient: _apiTableGradient(),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _softCardShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'Section 5',
            title: 'API surface — parameters & properties',
            tint: Color(0xFF047857),
          ),
          const SizedBox(height: _kGapMd),
          const Text(
            'CupertinoSheetRoute<T> is a typed PageRoute<T> — the type '
            'parameter `T` is the return type of the sheet when it is '
            'popped.  The constructor takes a `builder` plus a handful '
            'of inherited optional configuration values.',
            style: TextStyle(fontSize: 13.0, height: 1.45),
          ),
          const SizedBox(height: _kGapMd),
          const _ApiTableHeader(),
          const _ApiTableRow(
            name: 'builder',
            type: 'WidgetBuilder',
            note:
                'required; called once when the route installs; the '
                'returned widget is wrapped in CupertinoSheetTransition',
            req: true,
          ),
          const _ApiTableRow(
            name: 'settings',
            type: 'RouteSettings?',
            note:
                'optional name + arguments used by RouteObserver and '
                'restoration; defaults to an empty RouteSettings',
            req: false,
          ),
          const _ApiTableRow(
            name: 'maintainState',
            type: 'bool',
            note:
                'whether the previous route stays mounted while the '
                'sheet is presented; defaults to true',
            req: false,
          ),
          const _ApiTableRow(
            name: 'enableNavigationStack',
            type: 'bool',
            note:
                'when true, the sheet hosts its own Navigator so you '
                'can push child pages inside the sheet (false by default)',
            req: false,
          ),
          const _ApiTableRow(
            name: 'fullscreenDialog',
            type: 'bool (inherited)',
            note:
                'left at false; sheets are not full-screen dialogs in '
                'the iOS sense — that is what CupertinoPageRoute exposes',
            req: false,
          ),
          const _ApiTableRow(
            name: 'T (type parameter)',
            type: 'Type',
            note:
                'the return type from Navigator.pop(context, T) — '
                'await\'d by the caller of showCupertinoSheet<T>',
            req: false,
          ),
          const SizedBox(height: _kGapMd),
          const Text(
            'Read-only properties at the route level:',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF064E3B),
            ),
          ),
          const SizedBox(height: _kGapXs),
          const _ApiTableRow(
            name: 'transitionDuration',
            type: 'Duration',
            note: '500ms — tuned to feel iOS-native; const-overrideable',
            req: false,
          ),
          const _ApiTableRow(
            name: 'reverseTransitionDuration',
            type: 'Duration',
            note: 'matches transitionDuration — symmetric show/dismiss',
            req: false,
          ),
          const _ApiTableRow(
            name: 'barrierDismissible',
            type: 'bool',
            note: 'true — tap outside the sheet pops it',
            req: false,
          ),
          const _ApiTableRow(
            name: 'opaque',
            type: 'bool',
            note: 'false — the route below stays visually present',
            req: false,
          ),
        ],
      ),
    );
  }
}

class _ApiTableHeader extends StatelessWidget {
  const _ApiTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: _kGapSm,
        vertical: 6.0,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF047857),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: const Row(
        children: <Widget>[
          SizedBox(
            width: 140.0,
            child: Text(
              'name',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                fontWeight: FontWeight.w900,
                color: CupertinoColors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
          SizedBox(
            width: 110.0,
            child: Text(
              'type',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                fontWeight: FontWeight.w900,
                color: CupertinoColors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'semantics',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                fontWeight: FontWeight.w900,
                color: CupertinoColors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ApiTableRow extends StatelessWidget {
  const _ApiTableRow({
    required this.name,
    required this.type,
    required this.note,
    required this.req,
  });

  final String name;
  final String type;
  final String note;
  final bool req;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      padding: const EdgeInsets.all(_kGapSm),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.78),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: req
              ? const Color(0xFF047857)
              : const Color(0xFFBBF7D0),
          width: req ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 140.0,
            child: Row(
              children: <Widget>[
                if (req)
                  Container(
                    width: 6.0,
                    height: 6.0,
                    margin: const EdgeInsets.only(right: 4.0, top: 4.0),
                    decoration: const BoxDecoration(
                      color: Color(0xFF047857),
                      shape: BoxShape.circle,
                    ),
                  ),
                Expanded(
                  child: Text(
                    name,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.5,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF064E3B),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 110.0,
            child: Text(
              type,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF047857),
              ),
            ),
          ),
          Expanded(
            child: Text(
              note,
              style: const TextStyle(
                fontSize: 11.5,
                height: 1.35,
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
// SECTION 6 — showCupertinoSheet code-snippet cards
// =====================================================================
//
// Four idiomatic call patterns rendered as IDE-styled dark cards.
// =====================================================================

class _ShowSheetSnippetCard extends StatelessWidget {
  const _ShowSheetSnippetCard();

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
            kicker: 'Section 6',
            title: 'showCupertinoSheet — idiomatic usages',
            tint: Color(0xFF22D3EE),
          ),
          const SizedBox(height: _kGapSm),
          const Text(
            'Four call-site patterns covering the typical lifecycles: '
            'fire-and-forget, dismissible, awaiting a return value, '
            'and using the builder context to pop.',
            style: TextStyle(
              fontSize: 12.5,
              height: 1.4,
              color: Color(0xFFE5E7EB),
            ),
          ),
          const SizedBox(height: _kGapMd),
          const _CodeBlock(
            title: 'Pattern 1 — fire-and-forget, full sheet',
            body: <String>[
              'showCupertinoSheet<void>(',
              '  context: context,',
              '  pageBuilder: (BuildContext context) {',
              '    return const SettingsSheet();',
              '  },',
              ');',
            ],
          ),
          SizedBox(height: _kGapMd),
          const _CodeBlock(
            title: 'Pattern 2 — dismissible / typed return',
            body: <String>[
              'final String? choice = await showCupertinoSheet<String>(',
              '  context: context,',
              '  pageBuilder: (BuildContext context) {',
              '    return const PickerSheet();',
              '  },',
              ');',
              'if (choice != null) {',
              '  applyChoice(choice);',
              '}',
            ],
          ),
          SizedBox(height: _kGapMd),
          const _CodeBlock(
            title: 'Pattern 3 — push via Navigator with settings',
            body: <String>[
              'Navigator.of(context).push(',
              '  CupertinoSheetRoute<Result>(',
              '    settings: const RouteSettings(name: \'/edit\'),',
              '    builder: (BuildContext context) {',
              '      return const EditorSheet();',
              '    },',
              '  ),',
              ');',
            ],
          ),
          SizedBox(height: _kGapMd),
          const _CodeBlock(
            title: 'Pattern 4 — pop with the builder context',
            body: <String>[
              'showCupertinoSheet<void>(',
              '  context: context,',
              '  pageBuilder: (BuildContext sheetContext) {',
              '    return CupertinoPageScaffold(',
              '      navigationBar: CupertinoNavigationBar(',
              '        middle: const Text(\'Compose\'),',
              '        trailing: CupertinoButton(',
              '          padding: EdgeInsets.zero,',
              '          onPressed: () =>',
              '              Navigator.of(sheetContext).pop(),',
              '          child: const Text(\'Done\'),',
              '        ),',
              '      ),',
              '      child: const ComposeBody(),',
              '    );',
              '  },',
              ');',
            ],
          ),
          SizedBox(height: _kGapMd),
          const _CodeBlock(
            title: 'Pattern 5 — nested navigation inside the sheet',
            body: <String>[
              'Navigator.of(context).push(',
              '  CupertinoSheetRoute<void>(',
              '    enableNavigationStack: true,',
              '    builder: (BuildContext context) {',
              '      return const WizardRootPage();',
              '    },',
              '  ),',
              ');',
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
// SECTION 7 — Route comparison table
// =====================================================================
//
// Four-row table comparing CupertinoSheetRoute against the three other
// modal-ish routes you commonly reach for in Cupertino apps.
// =====================================================================

class _RouteComparisonCard extends StatelessWidget {
  const _RouteComparisonCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kSectionPad),
      decoration: BoxDecoration(
        gradient: _compareGradient(),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _softCardShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'Section 7',
            title: 'Route comparison — what to pick when',
            tint: Color(0xFF6D28D9),
          ),
          const SizedBox(height: _kGapMd),
          const _CompareTableHeader(),
          const _CompareTableRow(
            route: 'CupertinoSheetRoute',
            extends_: 'PageRoute',
            transition: 'rise from bottom + recess presenting',
            useCase: 'modal task — inspector, picker, settings',
            tint: Color(0xFF1D4ED8),
          ),
          const _CompareTableRow(
            route: 'PageRoute<T>',
            extends_: 'ModalRoute',
            transition: 'platform-specific default',
            useCase: 'abstract base — rarely instantiated directly',
            tint: Color(0xFF6D28D9),
          ),
          const _CompareTableRow(
            route: 'CupertinoPageRoute',
            extends_: 'PageRoute',
            transition: 'slide-from-right + parallax',
            useCase: 'drill-in navigation — next step in a flow',
            tint: Color(0xFF15803D),
          ),
          const _CompareTableRow(
            route: 'CupertinoModalPopupRoute',
            extends_: 'PopupRoute',
            transition: 'fade + slide-from-bottom (action sheet)',
            useCase: 'action sheets and short-lived popovers',
            tint: Color(0xFFB45309),
          ),
          const SizedBox(height: _kGapMd),
          const Text(
            'Notes: PopupRoute is itself a ModalRoute subclass; the '
            'Cupertino popup route is used by showCupertinoModalPopup '
            'and is distinct from showCupertinoSheet.  Pick a sheet '
            'route when the user might spend more than a few seconds '
            'in the modal — pick a popup for ephemeral decisions.',
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF3B0764),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

class _CompareTableHeader extends StatelessWidget {
  const _CompareTableHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: _kGapSm,
        vertical: 6.0,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF6D28D9),
        borderRadius: BorderRadius.circular(6.0),
      ),
      child: const Row(
        children: <Widget>[
          SizedBox(
            width: 130.0,
            child: Text(
              'route',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                fontWeight: FontWeight.w900,
                color: CupertinoColors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
          SizedBox(
            width: 90.0,
            child: Text(
              'extends',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                fontWeight: FontWeight.w900,
                color: CupertinoColors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'transition / use',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                fontWeight: FontWeight.w900,
                color: CupertinoColors.white,
                letterSpacing: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CompareTableRow extends StatelessWidget {
  const _CompareTableRow({
    required this.route,
    required this.extends_,
    required this.transition,
    required this.useCase,
    required this.tint,
  });

  final String route;
  final String extends_;
  final String transition;
  final String useCase;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0),
      padding: const EdgeInsets.all(_kGapSm),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.78),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: tint.withOpacity(0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 130.0,
            child: Text(
              route,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
                color: tint,
              ),
            ),
          ),
          SizedBox(
            width: 90.0,
            child: Text(
              extends_,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.5,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3B0764),
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  transition,
                  style: const TextStyle(
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF1F2937),
                  ),
                ),
                Text(
                  useCase,
                  style: const TextStyle(
                    fontSize: 11.0,
                    height: 1.3,
                    color: Color(0xFF374151),
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

// =====================================================================
// SECTION 8 — Sheet body design guide
// =====================================================================
//
// Cards covering the four critical design considerations for the body
// of a sheet: safe-area handling, scrollable content, drag-to-dismiss
// interaction, and the navigation chrome at the top.
// =====================================================================

class _SheetBodyDesignGuideCard extends StatelessWidget {
  const _SheetBodyDesignGuideCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kSectionPad),
      decoration: BoxDecoration(
        gradient: _designGuideGradient(),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _softCardShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'Section 8',
            title: 'Designing the sheet body',
            tint: Color(0xFF92400E),
          ),
          const SizedBox(height: _kGapMd),
          const _GuideCard(
            tag: 'safe-area',
            title: 'Wrap the body in SafeArea',
            body:
                'The topGap (12 px) is a visual margin, not a safe-area '
                'inset.  On a device with a notch, the status bar still '
                'sits above the sheet; wrap your body in SafeArea so '
                'content does not collide with system chrome.',
          ),
          _GuideCard(
            tag: 'scrollable',
            title: 'Make content scrollable',
            body:
                'A sheet has finite vertical space.  Wrap long content '
                'in ListView, CustomScrollView, or '
                'SingleChildScrollView.  Drag-to-dismiss still works '
                'because the framework checks for scroll-position == 0 '
                'before reversing the route animation.',
          ),
          _GuideCard(
            tag: 'drag-dismiss',
            title: 'Drag-to-dismiss is automatic',
            body:
                'The user can pull the sheet down to dismiss it.  '
                'CupertinoSheetRoute hooks the gesture and reverses '
                'primaryRouteAnimation as the sheet is dragged.  If '
                'the user releases past a threshold, the route pops; '
                'otherwise the sheet snaps back to topGap.',
          ),
          _GuideCard(
            tag: 'top-chrome',
            title: 'Top notch + cancel button, no back button',
            body:
                'By convention, sheets do NOT show a back button — '
                'they are modal.  Render a small drag-handle pill at '
                'the top of the body and place a trailing Done/Cancel '
                'CupertinoButton inside a CupertinoNavigationBar.',
          ),
          _GuideCard(
            tag: 'theming',
            title: 'Theme inheritance',
            body:
                'The sheet inherits the ambient CupertinoTheme and '
                'Material Theme.  Material widgets (TextField, etc.) '
                'still look themselves up by ancestor and find the '
                'app-level Theme; you do not need a nested provider.',
          ),
          _GuideCard(
            tag: 'gestures',
            title: 'Avoid horizontal-swipe collisions',
            body:
                'CupertinoSheetRoute only owns the vertical drag '
                'gesture; you can still use PageView or horizontal '
                'sliders inside.  But if you nest another sheet route '
                'inside, both will compete for the swipe.  Disable the '
                'inner via enableDrag: false where appropriate.',
          ),
        ],
      ),
    );
  }
}

class _GuideCard extends StatelessWidget {
  const _GuideCard({
    required this.tag,
    required this.title,
    required this.body,
  });

  final String tag;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _kGapXs),
      child: Container(
        padding: const EdgeInsets.all(_kGapMd),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.85),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: const Color(0xFFFDE68A), width: 1.0),
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
                    color: const Color(0xFF92400E),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    tag,
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
                      fontSize: 13.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF78350F),
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
                color: Color(0xFF1F2937),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION 9 — Lifecycle / state diagram
// =====================================================================
//
// CustomPainter rendering of the route state machine:
//   pushed → presenting → idle → dismissible → popping → disposed
//
// Each node is drawn as a pill, connected by arrows.  Beneath, a list
// of which Navigator/Route methods fire at each transition.
// =====================================================================

class _LifecycleDiagramCard extends StatelessWidget {
  const _LifecycleDiagramCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_kSectionPad),
      decoration: BoxDecoration(
        gradient: _stateGradient(),
        borderRadius: BorderRadius.circular(_kCardRadius),
        boxShadow: _softCardShadow(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const _SectionHeader(
            kicker: 'Section 9',
            title: 'Route lifecycle state diagram',
            tint: Color(0xFF0E7490),
          ),
          const SizedBox(height: _kGapMd),
          const Text(
            'Every CupertinoSheetRoute moves through six states from '
            'creation to disposal.  Hooks fire on each transition — '
            'override didPush, didPopNext, didChangeNext, dispose etc. '
            'in a subclass if you need to react.',
            style: TextStyle(fontSize: 13.0, height: 1.45),
          ),
          const SizedBox(height: _kGapMd),
          Center(
            child: SizedBox(
              width: 300.0,
              height: 200.0,
              child: CustomPaint(
                painter: _LifecyclePainter(),
                size: const Size(300.0, 200.0),
              ),
            ),
          ),
          const SizedBox(height: _kGapMd),
          const Text(
            'Hooks called at each transition:',
            style: TextStyle(
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
              color: Color(0xFF134E4A),
            ),
          ),
          const SizedBox(height: _kGapXs),
          const _LifecycleHook(
            from: 'pushed',
            to: 'presenting',
            hook: 'install() then didPush()',
          ),
          const _LifecycleHook(
            from: 'presenting',
            to: 'idle',
            hook: 'animation.status -> AnimationStatus.completed',
          ),
          const _LifecycleHook(
            from: 'idle',
            to: 'dismissible',
            hook: 'user begins vertical drag',
          ),
          const _LifecycleHook(
            from: 'dismissible',
            to: 'popping',
            hook: 'release past threshold -> Navigator.pop()',
          ),
          const _LifecycleHook(
            from: 'popping',
            to: 'disposed',
            hook: 'didPop -> dispose() -> popped Future completes',
          ),
        ],
      ),
    );
  }
}

class _LifecyclePainter extends CustomPainter {
  const _LifecyclePainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Layout: nodes in a zig-zag — 3 across the top row, 3 across the
    // bottom row, with arrows linking them.
    const int topRow = 3;
    final double colWidth = size.width / topRow;
    const double pillHeight = 32.0;
    const double topY = 16.0;
    final double bottomY = size.height - pillHeight - 16.0;

    final List<Offset> positions = <Offset>[
      Offset(colWidth * 0.5, topY),
      Offset(colWidth * 1.5, topY),
      Offset(colWidth * 2.5, topY),
      Offset(colWidth * 2.5, bottomY),
      Offset(colWidth * 1.5, bottomY),
      Offset(colWidth * 0.5, bottomY),
    ];

    const List<Color> tints = <Color>[
      Color(0xFF0E7490),
      Color(0xFF0891B2),
      Color(0xFF06B6D4),
      Color(0xFF22D3EE),
      Color(0xFFB45309),
      Color(0xFF991B1B),
    ];

    final TextPainter tp = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    void drawPill(int i) {
      final Offset center = positions[i];
      final Color tint = tints[i];
      final Rect r = Rect.fromCenter(
        center: Offset(center.dx, center.dy + pillHeight / 2.0),
        width: colWidth - 14.0,
        height: pillHeight,
      );
      final RRect rr =
          RRect.fromRectAndRadius(r, const Radius.circular(16.0));
      canvas.drawRRect(rr, Paint()..color = tint);
      tp.text = TextSpan(
        text: _kLifecycleNodes[i],
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.0,
          fontWeight: FontWeight.w800,
          color: CupertinoColors.white,
        ),
      );
      tp.layout(minWidth: 0.0, maxWidth: r.width);
      tp.paint(
        canvas,
        Offset(r.center.dx - tp.width / 2.0, r.center.dy - tp.height / 2.0),
      );
    }

    // Arrows between consecutive nodes.
    final Paint arrowPaint = Paint()
      ..color = const Color(0xFF134E4A)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;

    void drawArrow(Offset from, Offset to) {
      canvas.drawLine(from, to, arrowPaint);
      // Simple arrowhead — a small triangle at `to`.
      final double dx = to.dx - from.dx;
      final double dy = to.dy - from.dy;
      final double len = math.sqrt(dx * dx + dy * dy);
      if (len == 0.0) {
        return;
      }
      final double ux = dx / len;
      final double uy = dy / len;
      final Offset back = Offset(to.dx - ux * 6.0, to.dy - uy * 6.0);
      final Offset left = Offset(back.dx - uy * 3.0, back.dy + ux * 3.0);
      final Offset right = Offset(back.dx + uy * 3.0, back.dy - ux * 3.0);
      final Path p = Path()
        ..moveTo(to.dx, to.dy)
        ..lineTo(left.dx, left.dy)
        ..lineTo(right.dx, right.dy)
        ..close();
      canvas.drawPath(p, Paint()..color = const Color(0xFF134E4A));
    }

    for (int i = 0; i < positions.length; i++) {
      drawPill(i);
    }

    // Top row: left → right.
    for (int i = 0; i < 2; i++) {
      drawArrow(
        Offset(positions[i].dx + colWidth * 0.4, positions[i].dy + 16.0),
        Offset(positions[i + 1].dx - colWidth * 0.4, positions[i + 1].dy + 16.0),
      );
    }
    // Top-right → bottom-right (wrap).
    drawArrow(
      Offset(positions[2].dx, positions[2].dy + pillHeight + 2.0),
      Offset(positions[3].dx, positions[3].dy - 2.0),
    );
    // Bottom row: right → left.
    for (int i = 3; i < 5; i++) {
      drawArrow(
        Offset(positions[i].dx - colWidth * 0.4, positions[i].dy + 16.0),
        Offset(positions[i + 1].dx + colWidth * 0.4, positions[i + 1].dy + 16.0),
      );
    }
  }

  @override
  bool shouldRepaint(covariant _LifecyclePainter oldDelegate) => false;
}

class _LifecycleHook extends StatelessWidget {
  const _LifecycleHook({
    required this.from,
    required this.to,
    required this.hook,
  });

  final String from;
  final String to;
  final String hook;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150.0,
            child: Text(
              '$from → $to',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFF0E7490),
              ),
            ),
          ),
          Expanded(
            child: Text(
              hook,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                height: 1.35,
                color: Color(0xFF134E4A),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION 10 — Pitfalls & sharp-edges
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
            title: 'Forgetting to register a NavigatorObserver',
            body:
                'If your app uses analytics or restoration that relies on '
                'didPush / didPop hooks, you must register a '
                'NavigatorObserver with the Navigator that owns the sheet '
                'route — observers do not bubble through nested Navigators.',
          ),
          _PitfallRow(
            kind: 'WRONG',
            title: 'Double-pop on a single tap',
            body:
                'Calling Navigator.of(context).pop() twice in a row from '
                'inside a sheet pops the SHEET and then the route below it. '
                'Wrap the action in a guard or use the sheet\'s own '
                'BuildContext (the one supplied to pageBuilder).',
          ),
          _PitfallRow(
            kind: 'WRONG',
            title: 'Leaking controllers held by sheet body',
            body:
                'A TextEditingController, ScrollController, or Stream '
                'subscription created inside the sheet body must be '
                'disposed when the sheet pops.  Use a StatefulWidget with '
                'a dispose() override — relying on the route\'s dispose '
                'is not enough for child-owned resources.',
          ),
          _PitfallRow(
            kind: 'WRONG',
            title: 'Oversized non-scrollable content',
            body:
                'A sheet body taller than the available space overflows '
                'silently or clips at the bottom edge.  Always wrap the '
                'body in a scrollable container (CustomScrollView, '
                'ListView, SingleChildScrollView).',
          ),
          _PitfallRow(
            kind: 'WRONG',
            title: 'Horizontal-swipe gesture collisions',
            body:
                'A PageView or horizontally-scrollable widget inside a '
                'sheet competes with the vertical drag-to-dismiss only at '
                'the top edge — but if the inner widget uses arbitrary '
                'pan gestures, the route\'s dismiss may be swallowed.  '
                'Test thoroughly with the gesture in question.',
          ),
          _PitfallRow(
            kind: 'WRONG',
            title: 'popUntil traps in nested navigation',
            body:
                'With enableNavigationStack: true, the sheet hosts its '
                'own Navigator.  Calling Navigator.popUntil from inside '
                'pops within the inner Navigator first — to dismiss the '
                'entire sheet, use rootNavigator: true or call the inner '
                'Navigator until isFirst, then pop the outer.',
          ),
          _PitfallRow(
            kind: 'OK',
            title: 'Reusing one page for both push styles',
            body:
                'A single CupertinoPageScaffold-based page works as the '
                'builder of both a CupertinoPageRoute (drill-in) and a '
                'CupertinoSheetRoute (modal).  Pick the route at the call '
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
// SECTION 11 — Footer cheat-sheet
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
            'Cheat sheet',
            style: TextStyle(
              fontSize: 12.0,
              color: Color(0xFF9CA3AF),
              letterSpacing: 1.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: _kGapXs),
          Text(
            'CupertinoSheetRoute<T> — at a glance',
            style: TextStyle(
              fontSize: 22.0,
              color: CupertinoColors.white,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.4,
            ),
          ),
          SizedBox(height: _kGapMd),
          _CheatRow(
            label: 'Push',
            value: 'Navigator.of(context).push(CupertinoSheetRoute<T>(...))',
          ),
          _CheatRow(
            label: 'Helper',
            value: 'await showCupertinoSheet<T>(context: ..., pageBuilder: ...)',
          ),
          _CheatRow(
            label: 'Pop with value',
            value: 'Navigator.of(sheetContext).pop(result)',
          ),
          _CheatRow(
            label: 'Transition',
            value: 'CupertinoSheetTransition — rise-from-bottom + recess',
          ),
          _CheatRow(
            label: 'Duration',
            value: '500ms primary; reverseTransitionDuration matches',
          ),
          _CheatRow(
            label: 'Dismiss',
            value: 'drag-down past threshold, or tap outside the sheet',
          ),
          _CheatRow(
            label: 'Body design',
            value: 'wrap in SafeArea, make content scrollable, no back button',
          ),
          SizedBox(height: _kGapMd),
          Text(
            'Static AlwaysStoppedAnimation snapshots only; no '
            'AnimationController, no live route push, no setState. '
            'See package:flutter/cupertino.dart for the live widget.',
            style: TextStyle(
              fontSize: 11.5,
              color: Color(0xFFE5E7EB),
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

class _CheatRow extends StatelessWidget {
  const _CheatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 100.0,
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                fontWeight: FontWeight.w800,
                color: Color(0xFF9CA3AF),
                letterSpacing: 1.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Color(0xFFE5E7EB),
                height: 1.4,
              ),
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
// Self-test sanity references — keep imports unused-free.
// =====================================================================

final double _piRef = math.pi;
final double? _lerpRef = ui.lerpDouble(0.0, 1.0, 0.5);
final bool _debugRef = kDebugMode;
final IconData _iconRef = CupertinoIcons.square_stack_3d_up_fill;
final TextDirection _directionRef = TextDirection.ltr;
final EdgeInsets _edgeRef = const EdgeInsets.all(0.0);
final Brightness _brightnessRef = Brightness.light;
final Curve _curveRef = Curves.fastEaseInToSlowEaseOut;
final Color _paintingRef = const Color(0xFF000000);

final List<Object> _sanityRefs = <Object>[
  _piRef,
  _lerpRef ?? 0.0,
  _debugRef,
  _iconRef,
  _directionRef,
  _edgeRef,
  _brightnessRef,
  _curveRef,
  _paintingRef,
  _kSheetRadius,
  _kBezelWidth,
  _kBezelHeight,
  _kHigSheetTopGap,
];
