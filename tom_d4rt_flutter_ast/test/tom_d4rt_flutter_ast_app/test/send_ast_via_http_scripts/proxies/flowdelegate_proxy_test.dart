// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo gallery - Flutter `FlowDelegate` and `Flow`.
//
// This file is a hand-authored, harness-safe demonstration of the rendering
// `FlowDelegate` API together with the `Flow` widget that drives it.
//
//   - Abstract base class .................. `FlowDelegate`
//   - Driver widget ........................ `Flow`
//   - Painting context ..................... `FlowPaintingContext`
//   - Six concrete delegate subclasses authored at file scope
//
// The filename hints at the d4rt proxy of FlowDelegate, but the SUBJECT here
// is the underlying Flutter rendering API. The proxy layer is a pass-through
// of these same overrides.
//
// HARNESS CONTRACT
// -----------------
// The script exposes a single top-level `dynamic build(BuildContext context)`
// returning a `MaterialApp`. There is no `main()` and no `runApp()` and no
// `testWidgets()` invocation. The harness mounts the returned widget tree
// into its own host scaffold; this file simply describes the UI.
//
// ANIMATION STRATEGY
// ------------------
// The animated delegates take a `Listenable` in their constructor and forward
// it to `super(repaint: listenable)`. Whenever that listenable notifies, the
// `Flow` widget calls `paintChildren` again on its delegate. Concretely:
//
//   - A long-lived `ValueNotifier<double>` advances each frame via
//     `WidgetsBinding.instance.addPostFrameCallback`. It is wrapped as the
//     `repaint` source of the orbit, explode and animated-fan delegates, so
//     they animate continuously without needing a `TickerProvider`.
//   - The radial menu and fan menu use a separate `ValueNotifier<double>`
//     that the user toggles via a button: 0.0 means closed, 1.0 means open.
//
// PAINTING-TIME TRANSFORMATION MODEL
// ----------------------------------
// `FlowDelegate.paintChildren(FlowPaintingContext context)` does not lay out
// children. Layout already happened. What it does is, for each child index,
// call `context.paintChild(i, transform: m)` where `m` is a `Matrix4` applied
// at painting time. The same child can be painted many times at many
// transforms, very cheaply, because there is no widget rebuild and no
// re-layout. That is why `Flow` exists separately from `Stack`+`Positioned`:
// when only the visual position of children changes, `Flow` lets you skip
// layout entirely and just emit a fresh transform per child per frame.
//
// `shouldRepaint` is the cache key for that painting decision. If the
// delegate has any animated state that is not already covered by the
// `Listenable` passed to `super(repaint:)`, `shouldRepaint` is what tells
// the framework "yes, repaint anyway".
//
// `shouldRelayout` only matters when the delegate's `getSize` or
// `getConstraintsForChild` would produce different values for a new
// instance of the same delegate type. Most of the demos here keep layout
// constant and return `false`.
import 'package:flutter/material.dart';

// =============================================================================
// MODULE-LEVEL ANIMATION DRIVERS
// -----------------------------------------------------------------------------
// These notifiers are created exactly once at module load. They drive the
// continuously animated delegates (orbit, explode, animated fan). The
// `_kicked` flag ensures the recursive frame loop is started exactly once
// even if `build` is invoked more than once for the same page.
// =============================================================================
final ValueNotifier<double> _orbitPhase = ValueNotifier<double>(0.0);
final ValueNotifier<double> _explodePhase = ValueNotifier<double>(0.0);
final ValueNotifier<double> _driftPhase = ValueNotifier<double>(0.0);

// Toggleable progress notifiers (driven by user buttons).
final ValueNotifier<double> _fanOpen = ValueNotifier<double>(0.0);
final ValueNotifier<double> _radialOpen = ValueNotifier<double>(0.0);
final ValueNotifier<double> _galleryOpen = ValueNotifier<double>(0.0);
final ValueNotifier<double> _ringOpen = ValueNotifier<double>(0.0);

// Slider-driven values for the orbit showcase.
final ValueNotifier<double> _manualOrbitAngle = ValueNotifier<double>(0.0);

bool _kicked = false;

void _kickAnimationLoop() {
  if (_kicked) {
    return;
  }
  _kicked = true;

  void tick(Duration _) {
    final double orbitNext = (_orbitPhase.value + 0.012) % 1.0001;
    final double explodeNext = (_explodePhase.value + 0.009) % 1.0001;
    final double driftNext = (_driftPhase.value + 0.006) % 1.0001;

    _orbitPhase.value = orbitNext > 1.0 ? 0.0 : orbitNext;
    _explodePhase.value = explodeNext > 1.0 ? 0.0 : explodeNext;
    _driftPhase.value = driftNext > 1.0 ? 0.0 : driftNext;

    // Smoothly approach the target open progress for the toggleable menus.
    _fanOpen.value = _approach(_fanOpen.value, _fanOpenTarget, 0.08);
    _radialOpen.value = _approach(_radialOpen.value, _radialOpenTarget, 0.08);
    _galleryOpen.value =
        _approach(_galleryOpen.value, _galleryOpenTarget, 0.08);
    _ringOpen.value = _approach(_ringOpen.value, _ringOpenTarget, 0.08);

    WidgetsBinding.instance.addPostFrameCallback(tick);
  }

  WidgetsBinding.instance.addPostFrameCallback(tick);
}

double _approach(double current, double target, double step) {
  final double diff = target - current;
  if (diff.abs() < 0.001) {
    return target;
  }
  if (diff > 0) {
    return current + step > target ? target : current + step;
  }
  return current - step < target ? target : current - step;
}

// Toggle targets - these are read by the frame loop above.
double _fanOpenTarget = 0.0;
double _radialOpenTarget = 0.0;
double _galleryOpenTarget = 0.0;
double _ringOpenTarget = 0.0;

// =============================================================================
// PALETTE
// -----------------------------------------------------------------------------
// Each section picks from this palette so the gallery has visual variety.
// =============================================================================
const Color _palette1Surface = Color(0xFFE8F1FE);
const Color _palette1Border = Color(0xFFB5D0F5);
const Color _palette1Tint = Color(0xFF1A73E8);

const Color _palette2Surface = Color(0xFFFFF3E0);
const Color _palette2Border = Color(0xFFFFCC80);
const Color _palette2Tint = Color(0xFFEF6C00);

const Color _palette3Surface = Color(0xFFE8F5E9);
const Color _palette3Border = Color(0xFFA5D6A7);
const Color _palette3Tint = Color(0xFF2E7D32);

const Color _palette4Surface = Color(0xFFF3E5F5);
const Color _palette4Border = Color(0xFFCE93D8);
const Color _palette4Tint = Color(0xFF6A1B9A);

const Color _palette5Surface = Color(0xFFFFEBEE);
const Color _palette5Border = Color(0xFFEF9A9A);
const Color _palette5Tint = Color(0xFFC62828);

const Color _palette6Surface = Color(0xFFE0F7FA);
const Color _palette6Border = Color(0xFF80DEEA);
const Color _palette6Tint = Color(0xFF00838F);

const Color _palette7Surface = Color(0xFFEDE7F6);
const Color _palette7Border = Color(0xFFB39DDB);
const Color _palette7Tint = Color(0xFF4527A0);

const Color _palette8Surface = Color(0xFFFFFDE7);
const Color _palette8Border = Color(0xFFFFE082);
const Color _palette8Tint = Color(0xFFF57F17);

const Color _palette9Surface = Color(0xFFE0F2F1);
const Color _palette9Border = Color(0xFF80CBC4);
const Color _palette9Tint = Color(0xFF00695C);

const Color _palette10Surface = Color(0xFFFCE4EC);
const Color _palette10Border = Color(0xFFF48FB1);
const Color _palette10Tint = Color(0xFFAD1457);

const Color _palette11Surface = Color(0xFFECEFF1);
const Color _palette11Border = Color(0xFFB0BEC5);
const Color _palette11Tint = Color(0xFF37474F);

const Color _palette12Surface = Color(0xFFF1F8E9);
const Color _palette12Border = Color(0xFFC5E1A5);
const Color _palette12Tint = Color(0xFF558B2F);

const Color _palette13Surface = Color(0xFFFFF8E1);
const Color _palette13Border = Color(0xFFFFD180);
const Color _palette13Tint = Color(0xFFE65100);

// =============================================================================
// FAN FLOW DELEGATE
// -----------------------------------------------------------------------------
// Children fan out from a shared origin along an arc. The `progress` value
// is in [0,1]; at 0 every child sits stacked at the origin, at 1 every
// child sits on the rim of an arc.
// =============================================================================
class _FanFlowDelegate extends FlowDelegate {
  _FanFlowDelegate({
    required this.openListenable,
    this.radius = 90.0,
    this.startAngle = -3.14159 / 2,
    this.sweepAngle = 3.14159,
  }) : super(repaint: openListenable);

  final ValueNotifier<double> openListenable;
  final double radius;
  final double startAngle;
  final double sweepAngle;

  @override
  void paintChildren(FlowPaintingContext context) {
    final int n = context.childCount;
    if (n == 0) {
      return;
    }
    final double t = openListenable.value.clamp(0.0, 1.0);
    final Size size = context.size;
    final double cx = size.width / 2;
    final double cy = size.height - 28.0;
    for (int i = 0; i < n; i++) {
      // Anchor button (the last child) stays put.
      final bool isAnchor = i == n - 1;
      double dx = 0.0;
      double dy = 0.0;
      if (!isAnchor) {
        final double frac = n <= 2 ? 0.5 : i / (n - 2).clamp(1, 9999);
        final double angle = startAngle + sweepAngle * frac;
        dx = radius * t * _cos(angle);
        dy = radius * t * _sin(angle);
      }
      final Size childSize = context.getChildSize(i) ?? Size.zero;
      final double childX = cx - childSize.width / 2 + dx;
      final double childY = cy - childSize.height / 2 + dy;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(childX, childY, 0.0),
        opacity: isAnchor ? 1.0 : (0.25 + 0.75 * t),
      );
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, 220.0);
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    // First children are small icon chips, the last is the anchor button.
    return const BoxConstraints.tightFor(width: 56.0, height: 56.0);
  }

  @override
  bool shouldRepaint(covariant _FanFlowDelegate oldDelegate) {
    return oldDelegate.openListenable != openListenable ||
        oldDelegate.radius != radius ||
        oldDelegate.startAngle != startAngle ||
        oldDelegate.sweepAngle != sweepAngle;
  }

  @override
  bool shouldRelayout(covariant _FanFlowDelegate oldDelegate) {
    return oldDelegate.radius != radius;
  }
}

// =============================================================================
// ORBIT FLOW DELEGATE
// -----------------------------------------------------------------------------
// Children orbit a center point at constant radius. The `phase` is the
// driver, in [0,1], and represents one full revolution. Each child sits at
// `phase + i / n` so they are evenly spaced.
// =============================================================================
class _OrbitFlowDelegate extends FlowDelegate {
  _OrbitFlowDelegate({
    required this.phase,
    this.radius = 70.0,
  }) : super(repaint: phase);

  final ValueNotifier<double> phase;
  final double radius;

  @override
  void paintChildren(FlowPaintingContext context) {
    final int n = context.childCount;
    if (n == 0) {
      return;
    }
    final Size size = context.size;
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double base = phase.value * 2 * 3.14159;
    for (int i = 0; i < n; i++) {
      final double a = base + (i / n) * 2 * 3.14159;
      final Size childSize = context.getChildSize(i) ?? Size.zero;
      final double dx = cx + radius * _cos(a) - childSize.width / 2;
      final double dy = cy + radius * _sin(a) - childSize.height / 2;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(dx, dy, 0.0),
      );
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, 200.0);
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return const BoxConstraints.tightFor(width: 36.0, height: 36.0);
  }

  @override
  bool shouldRepaint(covariant _OrbitFlowDelegate oldDelegate) {
    return oldDelegate.phase != phase || oldDelegate.radius != radius;
  }

  @override
  bool shouldRelayout(covariant _OrbitFlowDelegate oldDelegate) {
    return false;
  }
}

// =============================================================================
// STAGGERED FLOW DELEGATE
// -----------------------------------------------------------------------------
// Children drift across the canvas, each with a per-index phase offset.
// Used to demonstrate that `paintChildren` can produce wildly different
// transforms for each index off the same underlying `Listenable`.
// =============================================================================
class _StaggeredFlowDelegate extends FlowDelegate {
  _StaggeredFlowDelegate({required this.phase}) : super(repaint: phase);

  final ValueNotifier<double> phase;

  @override
  void paintChildren(FlowPaintingContext context) {
    final int n = context.childCount;
    if (n == 0) {
      return;
    }
    final Size size = context.size;
    final double laneHeight = size.height / n;
    for (int i = 0; i < n; i++) {
      final double offset = (phase.value + i * 0.13) % 1.0;
      final Size childSize = context.getChildSize(i) ?? Size.zero;
      final double maxX = size.width - childSize.width;
      // Triangular wave for back-and-forth motion.
      final double tri = offset < 0.5 ? offset * 2 : (1.0 - offset) * 2;
      final double dx = maxX * tri;
      final double dy = laneHeight * i + (laneHeight - childSize.height) / 2;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(dx, dy, 0.0),
      );
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, 200.0);
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    final double s = 24.0 + (i % 5) * 6.0;
    return BoxConstraints.tightFor(width: s, height: s);
  }

  @override
  bool shouldRepaint(covariant _StaggeredFlowDelegate oldDelegate) {
    return oldDelegate.phase != phase;
  }
}

// =============================================================================
// GRID SNAP FLOW DELEGATE
// -----------------------------------------------------------------------------
// Children snap to invisible grid cells. Demonstrates that `Flow` is a
// perfectly fine layout primitive even when no animation is involved -
// `shouldRepaint` returns false and the painter is essentially static.
// =============================================================================
class _GridSnapFlowDelegate extends FlowDelegate {
  _GridSnapFlowDelegate({this.columns = 5, this.cell = 56.0, this.gap = 6.0});

  final int columns;
  final double cell;
  final double gap;

  @override
  void paintChildren(FlowPaintingContext context) {
    for (int i = 0; i < context.childCount; i++) {
      final int col = i % columns;
      final int row = i ~/ columns;
      final double dx = col * (cell + gap);
      final double dy = row * (cell + gap);
      context.paintChild(
        i,
        transform: Matrix4.translationValues(dx, dy, 0.0),
      );
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    final double rows = 2.0;
    return Size(
      columns * (cell + gap),
      rows * (cell + gap),
    );
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(width: cell, height: cell);
  }

  @override
  bool shouldRepaint(covariant _GridSnapFlowDelegate oldDelegate) {
    return oldDelegate.columns != columns ||
        oldDelegate.cell != cell ||
        oldDelegate.gap != gap;
  }

  @override
  bool shouldRelayout(covariant _GridSnapFlowDelegate oldDelegate) {
    return oldDelegate.columns != columns ||
        oldDelegate.cell != cell ||
        oldDelegate.gap != gap;
  }
}

// =============================================================================
// ANIMATED EXPLODE FLOW DELEGATE
// -----------------------------------------------------------------------------
// Children explode outward from the center every cycle. Demonstrates that
// `paintChildren` can also rotate/scale via the `Matrix4` argument, not
// just translate.
// =============================================================================
class _AnimatedExplodeFlowDelegate extends FlowDelegate {
  _AnimatedExplodeFlowDelegate({required this.phase}) : super(repaint: phase);

  final ValueNotifier<double> phase;

  @override
  void paintChildren(FlowPaintingContext context) {
    final int n = context.childCount;
    if (n == 0) {
      return;
    }
    final Size size = context.size;
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double t = phase.value;
    // Pulse: 0->1->0
    final double pulse = t < 0.5 ? t * 2 : (1.0 - t) * 2;
    final double maxR = (size.shortestSide / 2) - 24.0;
    for (int i = 0; i < n; i++) {
      final double a = (i / n) * 2 * 3.14159;
      final double r = pulse * maxR;
      final Size childSize = context.getChildSize(i) ?? Size.zero;
      final double dx = cx + r * _cos(a) - childSize.width / 2;
      final double dy = cy + r * _sin(a) - childSize.height / 2;
      final Matrix4 m = Matrix4.identity()
        ..translate(dx, dy)
        ..translate(childSize.width / 2, childSize.height / 2)
        ..rotateZ(a + t * 6.28318)
        ..translate(-childSize.width / 2, -childSize.height / 2);
      context.paintChild(
        i,
        transform: m,
        opacity: 0.4 + 0.6 * (1.0 - pulse),
      );
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, 220.0);
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return const BoxConstraints.tightFor(width: 28.0, height: 28.0);
  }

  @override
  bool shouldRepaint(covariant _AnimatedExplodeFlowDelegate oldDelegate) {
    return oldDelegate.phase != phase;
  }
}

// =============================================================================
// RADIAL MENU FLOW DELEGATE
// -----------------------------------------------------------------------------
// FAB-style: a primary button is anchored bottom-right; tapping it expands a
// radial pop-up menu of child icons. Demonstrates a typical real-world use
// of `Flow` (it is the canonical example in the framework docs).
// =============================================================================
class _RadialMenuFlowDelegate extends FlowDelegate {
  _RadialMenuFlowDelegate({
    required this.openListenable,
    this.radius = 88.0,
  }) : super(repaint: openListenable);

  final ValueNotifier<double> openListenable;
  final double radius;

  @override
  void paintChildren(FlowPaintingContext context) {
    final int n = context.childCount;
    if (n == 0) {
      return;
    }
    final double t = openListenable.value.clamp(0.0, 1.0);
    final Size size = context.size;
    // Anchor pinned to bottom-right.
    final double cx = size.width - 36.0;
    final double cy = size.height - 36.0;
    for (int i = 0; i < n; i++) {
      final bool isAnchor = i == n - 1;
      double dx = 0.0;
      double dy = 0.0;
      if (!isAnchor) {
        final int leafCount = n - 1;
        final double frac = leafCount <= 1 ? 0.5 : i / (leafCount - 1);
        // Sweep from straight-up to straight-left, in 90 degrees of arc.
        final double angle = -3.14159 / 2 - frac * 3.14159 / 2;
        dx = radius * t * _cos(angle);
        dy = radius * t * _sin(angle);
      }
      final Size childSize = context.getChildSize(i) ?? Size.zero;
      final double childX = cx - childSize.width / 2 + dx;
      final double childY = cy - childSize.height / 2 + dy;
      final double scale = isAnchor ? 1.0 : (0.4 + 0.6 * t);
      final Matrix4 m = Matrix4.identity()
        ..translate(childX, childY)
        ..translate(childSize.width / 2, childSize.height / 2)
        ..scale(scale, scale)
        ..translate(-childSize.width / 2, -childSize.height / 2);
      context.paintChild(
        i,
        transform: m,
        opacity: isAnchor ? 1.0 : t,
      );
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, 200.0);
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return const BoxConstraints.tightFor(width: 56.0, height: 56.0);
  }

  @override
  bool shouldRepaint(covariant _RadialMenuFlowDelegate oldDelegate) {
    return oldDelegate.openListenable != openListenable ||
        oldDelegate.radius != radius;
  }
}

// =============================================================================
// MATH HELPERS
// -----------------------------------------------------------------------------
// Tiny, allocation-free trig used by the delegates. Calling `dart:math` from
// the harness is fine, but doing it inline here keeps the import list to
// just material.dart as the contract requires.
// =============================================================================
double _cos(double r) {
  // Truncated Taylor with periodic reduction; good enough for visuals.
  // Reduce r to [-pi, pi].
  const double pi = 3.141592653589793;
  double x = r;
  while (x > pi) {
    x -= 2 * pi;
  }
  while (x < -pi) {
    x += 2 * pi;
  }
  // Reduce to [-pi/2, pi/2] for accuracy.
  double sign = 1.0;
  if (x > pi / 2) {
    x = pi - x;
    sign = -1.0;
  } else if (x < -pi / 2) {
    x = -pi - x;
    sign = -1.0;
  }
  final double x2 = x * x;
  final double x4 = x2 * x2;
  final double x6 = x4 * x2;
  final double x8 = x4 * x4;
  return sign *
      (1.0 -
          x2 / 2.0 +
          x4 / 24.0 -
          x6 / 720.0 +
          x8 / 40320.0);
}

double _sin(double r) {
  const double pi = 3.141592653589793;
  return _cos(r - pi / 2);
}

// =============================================================================
// ENTRY POINT
// =============================================================================
dynamic build(BuildContext context) {
  _kickAnimationLoop();

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorSchemeSeed: _palette1Tint,
    ),
    home: Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _galleryHeader(),
              const SizedBox(height: 20.0),
              _section1IntroCard(),
              const SizedBox(height: 16.0),
              _section2FanShowcase(),
              const SizedBox(height: 16.0),
              _section3OrbitShowcase(),
              const SizedBox(height: 16.0),
              _section4StaggeredShowcase(),
              const SizedBox(height: 16.0),
              _section5GridSnapShowcase(),
              const SizedBox(height: 16.0),
              _section6AnimatedExplode(),
              const SizedBox(height: 16.0),
              _section7RadialMenu(),
              const SizedBox(height: 16.0),
              _section8PerformanceCard(),
              const SizedBox(height: 16.0),
              _section9ConstraintsShowcase(),
              const SizedBox(height: 16.0),
              _section10PhotoGalleryDock(),
              const SizedBox(height: 16.0),
              _section11OrbitNotificationRing(),
              const SizedBox(height: 16.0),
              _section12DecisionCard(),
              const SizedBox(height: 16.0),
              _section13ReferenceTable(),
              const SizedBox(height: 24.0),
              _galleryFooter(),
              const SizedBox(height: 12.0),
              const Center(
                child: Text(
                  'FlowDelegate - live deep demo gallery',
                  style: TextStyle(fontSize: 11.0, color: Color(0xFF8E8E93)),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// HEADER
// =============================================================================
Widget _galleryHeader() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [Color(0xFF1A73E8), Color(0xFF6A1B9A)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FlowDelegate',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFFFFF),
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'Flutter rendering: Flow + FlowDelegate paint-time transforms',
          style: TextStyle(fontSize: 14.0, color: Color(0xFFE5E5F0)),
        ),
        SizedBox(height: 4.0),
        Text(
          'Six hand-authored delegates, thirteen live sections',
          style: TextStyle(
            fontSize: 12.0,
            color: Color(0xFFEBE9F7),
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 1 - INTRO CARD
// =============================================================================
Widget _section1IntroCard() {
  return _sectionCard(
    surface: _palette1Surface,
    border: _palette1Border,
    tint: _palette1Tint,
    number: '1',
    title: 'What Flow and FlowDelegate are',
    description:
        '`Flow` is a multi-child widget whose entire visual layout is decided '
        'by a `FlowDelegate`. The delegate has four interesting overrides:\n'
        '  - `paintChildren(FlowPaintingContext)` - emit a transform per child\n'
        '  - `getSize(constraints)` - what size the Flow itself wants\n'
        '  - `getConstraintsForChild(i, constraints)` - per-child constraints\n'
        '  - `shouldRepaint` and `shouldRelayout` - cache invalidation hooks\n\n'
        'Layout happens once. Painting can happen many times per frame, very '
        'cheaply, because the only thing that changes is the Matrix4 emitted '
        'into `context.paintChild(i, transform: m)`.',
    caption:
        'API: Flow(delegate: FlowDelegate, children: [...])',
    body: const _StaticIconRow(
      icons: [
        Icons.widgets,
        Icons.arrow_forward,
        Icons.functions,
        Icons.arrow_forward,
        Icons.brush,
      ],
      tint: _palette1Tint,
    ),
  );
}

// =============================================================================
// SECTION 2 - FAN SHOWCASE
// -----------------------------------------------------------------------------
// Manual fan: two buttons toggle the open progress; the delegate animates
// children fanning outward from a center anchor.
// =============================================================================
Widget _section2FanShowcase() {
  return _sectionCard(
    surface: _palette2Surface,
    border: _palette2Border,
    tint: _palette2Tint,
    number: '2',
    title: '_FanFlowDelegate - radial fan-out',
    description:
        'Tap "Open" to fan five icon chips out from a center anchor along an '
        'arc. The delegate reads its open-progress from a `ValueNotifier<double>` '
        'passed via `super(repaint: ...)` so `Flow` repaints automatically '
        'whenever the value changes.',
    caption:
        'paintChildren places each leaf at radius * t * (cos a, sin a).',
    body: Column(
      children: [
        SizedBox(
          height: 230,
          child: Flow(
            delegate: _FanFlowDelegate(openListenable: _fanOpen),
            children: const [
              _Chip(color: Color(0xFFEF6C00), icon: Icons.image),
              _Chip(color: Color(0xFFEF6C00), icon: Icons.movie),
              _Chip(color: Color(0xFFEF6C00), icon: Icons.music_note),
              _Chip(color: Color(0xFFEF6C00), icon: Icons.mic),
              _Chip(color: Color(0xFFEF6C00), icon: Icons.share),
              _Chip(color: Color(0xFFEF6C00), icon: Icons.add, big: true),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                _fanOpenTarget = 1.0;
              },
              icon: const Icon(Icons.unfold_more),
              label: const Text('Open'),
            ),
            const SizedBox(width: 12),
            OutlinedButton.icon(
              onPressed: () {
                _fanOpenTarget = 0.0;
              },
              icon: const Icon(Icons.unfold_less),
              label: const Text('Close'),
            ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 3 - ORBIT SHOWCASE
// -----------------------------------------------------------------------------
// Three orbiting Flows, each driven by a different listenable: the
// auto-ticking `_orbitPhase`, plus a slider-driven `_manualOrbitAngle`.
// =============================================================================
Widget _section3OrbitShowcase() {
  return _sectionCard(
    surface: _palette3Surface,
    border: _palette3Border,
    tint: _palette3Tint,
    number: '3',
    title: '_OrbitFlowDelegate - children orbit a center',
    description:
        'The orbit delegate places children evenly around a circle, with a '
        'shared rotational phase. The first canvas auto-rotates via the frame '
        'loop. The second is steered by a slider (the slider value is the '
        'phase in [0,1]).',
    caption:
        'paintChildren: dx = cx + radius * cos(phase + i*2pi/n)',
    body: Column(
      children: [
        SizedBox(
          height: 200,
          child: Flow(
            delegate: _OrbitFlowDelegate(phase: _orbitPhase, radius: 70.0),
            children: const [
              _Chip(color: Color(0xFF2E7D32), icon: Icons.public, small: true),
              _Chip(color: Color(0xFF2E7D32), icon: Icons.eco, small: true),
              _Chip(color: Color(0xFF2E7D32), icon: Icons.spa, small: true),
              _Chip(color: Color(0xFF2E7D32), icon: Icons.park, small: true),
              _Chip(color: Color(0xFF2E7D32), icon: Icons.grass, small: true),
              _Chip(color: Color(0xFF2E7D32), icon: Icons.water, small: true),
            ],
          ),
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.only(top: 8.0, bottom: 4.0),
          child: Text(
            'Manual phase (slider drives the delegate):',
            style: TextStyle(fontSize: 12, color: Color(0xFF2E7D32)),
          ),
        ),
        StatefulBuilder(
          builder: (ctx, setState) {
            _manualOrbitAngle.addListener(() {
              if (ctx.mounted) {
                setState(() {});
              }
            });
            return Column(
              children: [
                SizedBox(
                  height: 200,
                  child: Flow(
                    delegate: _OrbitFlowDelegate(
                      phase: _manualOrbitAngle,
                      radius: 60.0,
                    ),
                    children: const [
                      _Chip(
                        color: Color(0xFF2E7D32),
                        icon: Icons.star,
                        small: true,
                      ),
                      _Chip(
                        color: Color(0xFF2E7D32),
                        icon: Icons.favorite,
                        small: true,
                      ),
                      _Chip(
                        color: Color(0xFF2E7D32),
                        icon: Icons.bolt,
                        small: true,
                      ),
                      _Chip(
                        color: Color(0xFF2E7D32),
                        icon: Icons.cloud,
                        small: true,
                      ),
                    ],
                  ),
                ),
                Slider(
                  value: _manualOrbitAngle.value.clamp(0.0, 1.0),
                  onChanged: (v) {
                    _manualOrbitAngle.value = v;
                  },
                  activeColor: _palette3Tint,
                ),
                Text(
                  'phase = ${_manualOrbitAngle.value.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 11, color: Color(0xFF558B2F)),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 4 - STAGGERED DRIFT
// =============================================================================
Widget _section4StaggeredShowcase() {
  return _sectionCard(
    surface: _palette4Surface,
    border: _palette4Border,
    tint: _palette4Tint,
    number: '4',
    title: '_StaggeredFlowDelegate - per-index drift',
    description:
        'Each child is in its own horizontal lane, oscillating with a '
        'per-index phase offset. The delegate also returns a different '
        '`getConstraintsForChild` per index, which is why the chips have '
        'different sizes.',
    caption:
        'getConstraintsForChild: 24 + (i % 5) * 6 px tight square',
    body: SizedBox(
      height: 220,
      child: Flow(
        delegate: _StaggeredFlowDelegate(phase: _driftPhase),
        children: const [
          _Chip(color: Color(0xFF6A1B9A), icon: Icons.circle, small: true),
          _Chip(color: Color(0xFF6A1B9A), icon: Icons.square, small: true),
          _Chip(color: Color(0xFF6A1B9A), icon: Icons.hexagon, small: true),
          _Chip(color: Color(0xFF6A1B9A), icon: Icons.pentagon, small: true),
          _Chip(color: Color(0xFF6A1B9A), icon: Icons.diamond, small: true),
        ],
      ),
    ),
  );
}

// =============================================================================
// SECTION 5 - GRID SNAP
// =============================================================================
Widget _section5GridSnapShowcase() {
  return _sectionCard(
    surface: _palette5Surface,
    border: _palette5Border,
    tint: _palette5Tint,
    number: '5',
    title: '_GridSnapFlowDelegate - static grid placement',
    description:
        '`Flow` is just as happy with a static layout. This delegate snaps '
        'children to a grid of cells, mirroring what `Wrap` would do but '
        'inside the same painting model. `shouldRepaint` returns false, so '
        'after the first paint the framework caches the layer.',
    caption:
        'col = i % 5, row = i ~/ 5, dx = col*(cell+gap), dy = row*(cell+gap)',
    body: SizedBox(
      height: 130,
      child: Flow(
        delegate: _GridSnapFlowDelegate(columns: 5, cell: 56.0, gap: 6.0),
        children: const [
          _Chip(color: Color(0xFFC62828), icon: Icons.looks_one),
          _Chip(color: Color(0xFFC62828), icon: Icons.looks_two),
          _Chip(color: Color(0xFFC62828), icon: Icons.looks_3),
          _Chip(color: Color(0xFFC62828), icon: Icons.looks_4),
          _Chip(color: Color(0xFFC62828), icon: Icons.looks_5),
          _Chip(color: Color(0xFFC62828), icon: Icons.looks_6),
          _Chip(color: Color(0xFFC62828), icon: Icons.exposure_plus_1),
          _Chip(color: Color(0xFFC62828), icon: Icons.exposure_plus_2),
          _Chip(color: Color(0xFFC62828), icon: Icons.filter_1),
          _Chip(color: Color(0xFFC62828), icon: Icons.filter_2),
        ],
      ),
    ),
  );
}

// =============================================================================
// SECTION 6 - ANIMATED EXPLODE
// =============================================================================
Widget _section6AnimatedExplode() {
  return _sectionCard(
    surface: _palette6Surface,
    border: _palette6Border,
    tint: _palette6Tint,
    number: '6',
    title: '_AnimatedExplodeFlowDelegate - rotate + translate + opacity',
    description:
        'Demonstrates the full power of the `Matrix4` argument to '
        '`paintChild`: each child is translated, rotated, and finally faded '
        'via the `opacity` argument. `shouldRepaint` returns true whenever '
        'the phase notifier identity changes; the `repaint:` listenable '
        'covers the per-frame case.',
    caption:
        'Matrix4..translate(...)..rotateZ(...) plus opacity in [0.4, 1.0]',
    body: SizedBox(
      height: 240,
      child: Flow(
        delegate: _AnimatedExplodeFlowDelegate(phase: _explodePhase),
        children: List<Widget>.generate(
          12,
          (i) => _Chip(
            color: const Color(0xFF00838F),
            icon: _kIcons[i % _kIcons.length],
            small: true,
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// SECTION 7 - RADIAL MENU
// =============================================================================
Widget _section7RadialMenu() {
  return _sectionCard(
    surface: _palette7Surface,
    border: _palette7Border,
    tint: _palette7Tint,
    number: '7',
    title: '_RadialMenuFlowDelegate - FAB-style pop-up menu',
    description:
        'The canonical `Flow` example from the Flutter docs: a primary FAB '
        'in the corner, plus N action buttons that fan out in a quarter-arc '
        'when opened. Closing the menu shrinks every leaf back into the '
        'anchor with a smooth scale-and-fade.',
    caption:
        'Anchor pinned to (size.width-36, size.height-36); leaves on a quarter-arc.',
    body: Column(
      children: [
        SizedBox(
          height: 220,
          child: Flow(
            delegate: _RadialMenuFlowDelegate(
              openListenable: _radialOpen,
              radius: 88.0,
            ),
            children: const [
              _Chip(color: Color(0xFF4527A0), icon: Icons.share),
              _Chip(color: Color(0xFF4527A0), icon: Icons.copy),
              _Chip(color: Color(0xFF4527A0), icon: Icons.print),
              _Chip(color: Color(0xFF4527A0), icon: Icons.email),
              _Chip(color: Color(0xFF4527A0), icon: Icons.menu, big: true),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                _radialOpenTarget = _radialOpenTarget > 0.5 ? 0.0 : 1.0;
              },
              icon: const Icon(Icons.menu_open),
              label: const Text('Toggle menu'),
            ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 8 - PERFORMANCE CARD
// =============================================================================
Widget _section8PerformanceCard() {
  return _sectionCard(
    surface: _palette8Surface,
    border: _palette8Border,
    tint: _palette8Tint,
    number: '8',
    title: 'Why Flow exists vs Stack + Positioned',
    description:
        'A `Stack` with N `Positioned` children rebuilds N widgets every '
        'frame the position changes, and may relayout. `Flow` skips both: '
        'children are laid out once, and `paintChildren` runs only the '
        'painter to emit a transform per child. This is the right tool when '
        'only the visual position changes per frame, e.g. for animated '
        'menus, particle effects or large grids.\n\n'
        'Cost model:\n'
        '  - Stack+Positioned animation = N widget rebuilds + N layouts + N paints\n'
        '  - Flow animation              = 0 rebuilds + 0 layouts + N paints',
    caption:
        'Rule of thumb: if only paint position changes, prefer Flow.',
    body: const _PerfTable(),
  );
}

// =============================================================================
// SECTION 9 - CONSTRAINTS SHOWCASE
// -----------------------------------------------------------------------------
// Per-child constraints can be different. The grid delegate already shows
// uniform constraints; the staggered delegate shows index-driven ones.
// Here we demonstrate the principle on its own.
// =============================================================================
Widget _section9ConstraintsShowcase() {
  return _sectionCard(
    surface: _palette9Surface,
    border: _palette9Border,
    tint: _palette9Tint,
    number: '9',
    title: 'getConstraintsForChild - per-child sizing',
    description:
        '`getConstraintsForChild(i, constraints)` is called once at layout '
        'time per child and decides what each child can fit into. The '
        'child does its normal layout under those constraints; the delegate '
        'then learns the actual size via `context.getChildSize(i)` inside '
        '`paintChildren`.',
    caption:
        'Below: each chip is sized 24 + (i*6) px, all the way to 78 px.',
    body: SizedBox(
      height: 110,
      child: Flow(
        delegate: _GrowingChipsDelegate(),
        children: const [
          _Chip(color: Color(0xFF00695C), icon: Icons.filter_1, small: true),
          _Chip(color: Color(0xFF00695C), icon: Icons.filter_2, small: true),
          _Chip(color: Color(0xFF00695C), icon: Icons.filter_3, small: true),
          _Chip(color: Color(0xFF00695C), icon: Icons.filter_4, small: true),
          _Chip(color: Color(0xFF00695C), icon: Icons.filter_5, small: true),
          _Chip(color: Color(0xFF00695C), icon: Icons.filter_6, small: true),
          _Chip(color: Color(0xFF00695C), icon: Icons.filter_7, small: true),
          _Chip(color: Color(0xFF00695C), icon: Icons.filter_8, small: true),
        ],
      ),
    ),
  );
}

class _GrowingChipsDelegate extends FlowDelegate {
  @override
  void paintChildren(FlowPaintingContext context) {
    double dx = 4.0;
    final double cy = context.size.height / 2;
    for (int i = 0; i < context.childCount; i++) {
      final Size s = context.getChildSize(i) ?? Size.zero;
      context.paintChild(
        i,
        transform: Matrix4.translationValues(dx, cy - s.height / 2, 0.0),
      );
      dx += s.width + 6.0;
    }
  }

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(constraints.maxWidth, 100.0);
  }

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    final double s = 24.0 + i * 6.0;
    return BoxConstraints.tightFor(width: s, height: s);
  }

  @override
  bool shouldRepaint(covariant _GrowingChipsDelegate oldDelegate) {
    return false;
  }

  @override
  bool shouldRelayout(covariant _GrowingChipsDelegate oldDelegate) {
    return false;
  }
}

// =============================================================================
// SECTION 10 - PHOTO GALLERY DOCK
// -----------------------------------------------------------------------------
// Real-world recipe. Tap the header to fan a row of preview thumbnails out
// from a docked center, like a fanned deck of cards.
// =============================================================================
Widget _section10PhotoGalleryDock() {
  return _sectionCard(
    surface: _palette10Surface,
    border: _palette10Border,
    tint: _palette10Tint,
    number: '10',
    title: 'Recipe: photo gallery dock',
    description:
        'Six photo thumbnails docked in a stack. Tap "Spread" and they fan '
        'out as if you were looking at a hand of cards. This pattern is '
        'used for image picker UIs, recent-photo trays, and chat sticker '
        'pickers.',
    caption:
        'Reuses _FanFlowDelegate with a wider sweep angle.',
    body: Column(
      children: [
        SizedBox(
          height: 220,
          child: Flow(
            delegate: _FanFlowDelegate(
              openListenable: _galleryOpen,
              radius: 110.0,
              startAngle: -3.14159,
              sweepAngle: 3.14159,
            ),
            children: List<Widget>.generate(
              6,
              (i) => _PhotoChip(index: i),
            )..add(
                const _Chip(
                  color: Color(0xFFAD1457),
                  icon: Icons.photo_library,
                  big: true,
                ),
              ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                _galleryOpenTarget =
                    _galleryOpenTarget > 0.5 ? 0.0 : 1.0;
              },
              icon: const Icon(Icons.fullscreen),
              label: const Text('Spread / collapse'),
            ),
          ],
        ),
      ],
    ),
  );
}

// =============================================================================
// SECTION 11 - ORBIT NOTIFICATION RING
// -----------------------------------------------------------------------------
// Real-world recipe. A central avatar with N small notification badges
// orbiting it slowly. Demonstrates `Flow` on top of an existing widget.
// =============================================================================
Widget _section11OrbitNotificationRing() {
  return _sectionCard(
    surface: _palette11Surface,
    border: _palette11Border,
    tint: _palette11Tint,
    number: '11',
    title: 'Recipe: orbit notification ring',
    description:
        'Six notification badges orbit a central avatar. The avatar is '
        'painted by a separate (non-Flow) widget; the badges are a Flow on '
        'top, with the same orbit phase the system already maintains. Tap '
        '"Pulse" to bump the orbit listenable and watch them re-shuffle.',
    caption:
        'Stack(children: [avatar, Flow(...)]) - Flow is fully composable.',
    body: SizedBox(
      height: 220,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF37474F),
            ),
            child: const Icon(
              Icons.person,
              color: Colors.white,
              size: 38,
            ),
          ),
          Flow(
            delegate: _OrbitFlowDelegate(phase: _orbitPhase, radius: 78.0),
            children: const [
              _Badge(text: '3'),
              _Badge(text: '!'),
              _Badge(text: '+'),
              _Badge(text: '?'),
              _Badge(text: 'i'),
              _Badge(text: '*'),
            ],
          ),
          Positioned(
            bottom: 8,
            child: ElevatedButton.icon(
              onPressed: () {
                _ringOpenTarget = _ringOpenTarget > 0.5 ? 0.0 : 1.0;
                // Bump the orbit phase to 0 to give a visible kick.
                _orbitPhase.value = 0.0;
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Pulse'),
            ),
          ),
        ],
      ),
    ),
  );
}

// =============================================================================
// SECTION 12 - DECISION CARD
// =============================================================================
Widget _section12DecisionCard() {
  return _sectionCard(
    surface: _palette12Surface,
    border: _palette12Border,
    tint: _palette12Tint,
    number: '12',
    title: 'Decision: Flow vs Stack vs Wrap vs CustomMultiChildLayout',
    description: 'Pick the simplest tool that does the job:\n'
        '\n'
        '- **Stack + Positioned**: a few children, position is essentially '
        'static or animated infrequently. Easiest to read.\n'
        '- **Wrap**: row/column of children that should soft-wrap. Pure '
        'layout, no painting tricks.\n'
        '- **Flow**: many children whose paint position changes every '
        'frame. Best for menus, particle effects, animated decorations.\n'
        '- **CustomMultiChildLayout**: like Flow, but also wants a custom '
        'LAYOUT pass each frame. Use when the position depends on each '
        'child\'s actual rendered size in a non-trivial way.',
    caption:
        'Flow wins when only the painted position is animated.',
    body: const _DecisionTable(),
  );
}

// =============================================================================
// SECTION 13 - REFERENCE TABLE
// =============================================================================
Widget _section13ReferenceTable() {
  return _sectionCard(
    surface: _palette13Surface,
    border: _palette13Border,
    tint: _palette13Tint,
    number: '13',
    title: 'Reference: delegate subclasses in this gallery',
    description:
        'Every delegate authored at file scope, what it does, and which '
        'overrides it implements.',
    caption: '6 delegates, 6 different shapes of motion.',
    body: const _DelegateRefTable(),
  );
}

// =============================================================================
// FOOTER
// =============================================================================
Widget _galleryFooter() {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: const Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: const Color(0xFFE0E0E0)),
    ),
    child: const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notes',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF424242),
          ),
        ),
        SizedBox(height: 6),
        Text(
          '- All delegates are file-scope private classes prefixed with _.\n'
          '- Animated delegates pass a Listenable to super(repaint: ...).\n'
          '- shouldRepaint returns true only when delegate identity changes.\n'
          '- shouldRelayout returns true only when getSize would change.\n'
          '- This file imports only package:flutter/material.dart.',
          style: TextStyle(fontSize: 12, color: Color(0xFF616161)),
        ),
      ],
    ),
  );
}

// =============================================================================
// SHARED CARD
// =============================================================================
Widget _sectionCard({
  required Color surface,
  required Color border,
  required Color tint,
  required String number,
  required String title,
  required String description,
  required String caption,
  required Widget body,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: surface,
      border: Border.all(color: border, width: 1.2),
      borderRadius: BorderRadius.circular(14.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tint,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: tint,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 12.5, color: Color(0xFF333333)),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: border),
            borderRadius: BorderRadius.circular(10),
          ),
          child: body,
        ),
        const SizedBox(height: 8),
        Text(
          caption,
          style: TextStyle(
            fontSize: 11,
            color: tint,
            fontStyle: FontStyle.italic,
          ),
        ),
      ],
    ),
  );
}

// =============================================================================
// REUSABLE TILES
// =============================================================================
class _Chip extends StatelessWidget {
  const _Chip({
    required this.color,
    required this.icon,
    this.big = false,
    this.small = false,
  });

  final Color color;
  final IconData icon;
  final bool big;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final double size = big ? 56.0 : (small ? 28.0 : 40.0);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.35),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: big ? 26 : (small ? 14 : 20),
      ),
    );
  }
}

class _PhotoChip extends StatelessWidget {
  const _PhotoChip({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final List<Color> palette = [
      const Color(0xFFAD1457),
      const Color(0xFFD81B60),
      const Color(0xFFE91E63),
      const Color(0xFFC2185B),
      const Color(0xFF880E4F),
      const Color(0xFFF06292),
    ];
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: palette[index % palette.length],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: const Icon(Icons.photo, color: Colors.white, size: 22),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFC62828),
        boxShadow: [
          BoxShadow(
            color: Color(0x55000000),
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _StaticIconRow extends StatelessWidget {
  const _StaticIconRow({required this.icons, required this.tint});

  final List<IconData> icons;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: icons.map((i) => Icon(i, color: tint, size: 26)).toList(),
    );
  }
}

class _PerfTable extends StatelessWidget {
  const _PerfTable();

  @override
  Widget build(BuildContext context) {
    final TextStyle h = const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: Color(0xFFF57F17),
    );
    final TextStyle c = const TextStyle(
      fontSize: 12,
      color: Color(0xFF424242),
    );
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(1),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      children: [
        TableRow(
          children: [
            Text('Per frame:', style: h),
            Text('rebuild', style: h),
            Text('layout', style: h),
            Text('paint', style: h),
          ],
        ),
        TableRow(children: [
          Text('Stack+Positioned (animated)', style: c),
          Text('N', style: c),
          Text('N', style: c),
          Text('N', style: c),
        ]),
        TableRow(children: [
          Text('Flow (animated)', style: c),
          Text('0', style: c),
          Text('0', style: c),
          Text('N', style: c),
        ]),
        TableRow(children: [
          Text('CustomMultiChildLayout (animated)', style: c),
          Text('0', style: c),
          Text('N', style: c),
          Text('N', style: c),
        ]),
      ],
    );
  }
}

class _DecisionTable extends StatelessWidget {
  const _DecisionTable();

  @override
  Widget build(BuildContext context) {
    const TextStyle h = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: Color(0xFF558B2F),
    );
    const TextStyle c = TextStyle(fontSize: 12, color: Color(0xFF424242));
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1.2),
        1: FlexColumnWidth(2),
      },
      children: const [
        TableRow(children: [
          Text('Stack', style: h),
          Text(
            'Few children, mostly static, occasional position change.',
            style: c,
          ),
        ]),
        TableRow(children: [
          Text('Wrap', style: h),
          Text('Soft-wrapping row/column. Pure layout.', style: c),
        ]),
        TableRow(children: [
          Text('Flow', style: h),
          Text(
            'Many children, position animates every frame.',
            style: c,
          ),
        ]),
        TableRow(children: [
          Text('CustomMultiChildLayout', style: h),
          Text(
            'Layout depends on each child\'s rendered size; full custom pass.',
            style: c,
          ),
        ]),
      ],
    );
  }
}

class _DelegateRefTable extends StatelessWidget {
  const _DelegateRefTable();

  @override
  Widget build(BuildContext context) {
    const TextStyle h = TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w700,
      color: Color(0xFFE65100),
    );
    const TextStyle c = TextStyle(fontSize: 12, color: Color(0xFF424242));
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(3),
      },
      children: const [
        TableRow(children: [
          Text('_FanFlowDelegate', style: h),
          Text(
            'Children fan along an arc; takes openListenable + radius + start/sweep angles.',
            style: c,
          ),
        ]),
        TableRow(children: [
          Text('_OrbitFlowDelegate', style: h),
          Text(
            'Children orbit a center; takes phase listenable + radius.',
            style: c,
          ),
        ]),
        TableRow(children: [
          Text('_StaggeredFlowDelegate', style: h),
          Text(
            'Per-index drift across lanes; per-index size via getConstraintsForChild.',
            style: c,
          ),
        ]),
        TableRow(children: [
          Text('_GridSnapFlowDelegate', style: h),
          Text(
            'Static grid snap; useful when the only goal is layout, not motion.',
            style: c,
          ),
        ]),
        TableRow(children: [
          Text('_AnimatedExplodeFlowDelegate', style: h),
          Text(
            'Translate+rotate+opacity pulse from center; full Matrix4 demo.',
            style: c,
          ),
        ]),
        TableRow(children: [
          Text('_RadialMenuFlowDelegate', style: h),
          Text(
            'FAB-style pop-up: anchor pinned to corner, leaves on a quarter-arc.',
            style: c,
          ),
        ]),
        TableRow(children: [
          Text('_GrowingChipsDelegate', style: h),
          Text(
            'Inline helper for the constraints showcase (per-index size).',
            style: c,
          ),
        ]),
      ],
    );
  }
}

// =============================================================================
// ICON CYCLE used by the explode showcase
// =============================================================================
const List<IconData> _kIcons = [
  Icons.star,
  Icons.favorite,
  Icons.bolt,
  Icons.cloud,
  Icons.ac_unit,
  Icons.flash_on,
  Icons.local_fire_department,
  Icons.eco,
];
