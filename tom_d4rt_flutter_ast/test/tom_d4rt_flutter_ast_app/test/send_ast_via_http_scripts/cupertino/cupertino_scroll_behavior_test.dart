// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// =============================================================================
// CupertinoScrollBehavior — Visual Deep Demo
// -----------------------------------------------------------------------------
// This file is a hand-authored static visual reference for
// `CupertinoScrollBehavior`, the iOS-style scroll behavior used by
// `CupertinoApp` and `CupertinoScrollbar` defaults.
//
// It is rendered by the analyzer-free D4rt interpreter. The widget tree is
// fully static: no animation controllers, no setState, no timers, no streams.
// All "animated" feeling is achieved with carefully painted snapshots and
// arrow annotations.
//
// Sections (each its own private StatelessWidget):
//   1.  _HeroHeaderSection           — gradient banner / title / concept badges
//   2.  _ClassAnatomySection         — boxes & connectors showing inheritance
//   3.  _MethodShowcaseSection       — one card per overridden method
//   4.  _PhysicsComparisonSection    — Bouncing vs Clamping vs RangeMaintaining
//   5.  _ScrollbarPreviewSection     — painted scrollbar states
//   6.  _PropagationTreeSection      — ScrollConfiguration → descendants tree
//   7.  _SnippetGallerySection       — formatted code-style containers
//   8.  _PitfallsSection             — red / amber / green callouts
//   9.  _MigrationCheatSheetSection  — Material → Cupertino mapping
//   10. _FooterReferenceSection      — API reference summary
//
// Gradients (≥6, intentionally distinct angles & palettes):
//   G1 — hero banner (top-left → bottom-right, indigo→violet→rose)
//   G2 — anatomy backdrop (top-center → bottom-center, slate→navy)
//   G3 — methods strip (left → right, teal→cyan→sky)
//   G4 — physics panel (bottom-left → top-right, amber→orange→red)
//   G5 — scrollbar preview (top-right → bottom-left, graphite→silver→ink)
//   G6 — propagation tree (radial-ish via two-stop diagonal, emerald→jade)
//   G7 — pitfalls strip (left → right, rose→pink→fuchsia)
//   G8 — footer (top → bottom, midnight→indigo)
// =============================================================================

// -----------------------------------------------------------------------------
// Top-level entry point. The D4rt runner invokes this with a BuildContext.
// -----------------------------------------------------------------------------
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'CupertinoScrollBehavior — Deep Demo',
    theme: ThemeData(
      brightness: Brightness.light,
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: const Color(0xFFF6F7FB),
    ),
    home: const _ScrollBehaviorDemoHome(),
  );
}

// -----------------------------------------------------------------------------
// Home shell. Hosts the SingleChildScrollView with all sections.
// -----------------------------------------------------------------------------
class _ScrollBehaviorDemoHome extends StatelessWidget {
  const _ScrollBehaviorDemoHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _HeroHeaderSection(),
              SizedBox(height: 24),
              _ClassAnatomySection(),
              SizedBox(height: 24),
              _MethodShowcaseSection(),
              SizedBox(height: 24),
              _PhysicsComparisonSection(),
              SizedBox(height: 24),
              _ScrollbarPreviewSection(),
              SizedBox(height: 24),
              _PropagationTreeSection(),
              SizedBox(height: 24),
              _SnippetGallerySection(),
              SizedBox(height: 24),
              _PitfallsSection(),
              SizedBox(height: 24),
              _MigrationCheatSheetSection(),
              SizedBox(height: 24),
              _FooterReferenceSection(),
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 1 — Hero Header
// -----------------------------------------------------------------------------
// Sets the visual tone of the page. Uses gradient G1 (indigo → violet → rose)
// and surfaces the five core concepts as pill-shaped badges so the reader
// immediately has a mental map of what is coming.
// =============================================================================
class _HeroHeaderSection extends StatelessWidget {
  const _HeroHeaderSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      // G1 — hero banner gradient
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF3F3D9D),
            Color(0xFF7A4DB8),
            Color(0xFFC65DA0),
          ],
          stops: <double>[0.0, 0.55, 1.0],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0x553F3D9D),
            blurRadius: 22,
            offset: Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.35),
                    width: 1.2,
                  ),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  CupertinoIcons.arrow_up_arrow_down,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Text(
                      'CupertinoScrollBehavior',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'iOS-style scroll physics, scrollbar style and overscroll behavior',
                      style: TextStyle(
                        color: Color(0xFFF1E7FF),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.5),
                  ),
                ),
                child: const Text(
                  'flutter/cupertino.dart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const Text(
            'CupertinoScrollBehavior subclasses ScrollBehavior to deliver the\n'
            'native iOS feel: bouncing overscroll, no Material glow, and a\n'
            'CupertinoScrollbar instead of the default Material Scrollbar.',
            style: TextStyle(
              color: Color(0xFFF2EAFF),
              fontSize: 14,
              height: 1.45,
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: const <Widget>[
              _ConceptBadge(label: 'BouncingScrollPhysics', icon: CupertinoIcons.waveform_path),
              _ConceptBadge(label: 'CupertinoScrollbar', icon: CupertinoIcons.line_horizontal_3_decrease),
              _ConceptBadge(label: 'No Glow Overscroll', icon: CupertinoIcons.nosign),
              _ConceptBadge(label: 'Multitouch Drag', icon: CupertinoIcons.hand_draw),
              _ConceptBadge(label: 'ScrollConfiguration', icon: CupertinoIcons.tree),
            ],
          ),
        ],
      ),
    );
  }
}

// A small pill badge surfacing one related concept. Used in the hero header.
class _ConceptBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  const _ConceptBadge({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 2 — Class Anatomy Diagram
// -----------------------------------------------------------------------------
// Draws the inheritance and override surface as a small node diagram:
//   ScrollBehavior  (parent)
//        ↓
//   CupertinoScrollBehavior  (focus)
//        ↓
//   [getScrollPhysics] [buildScrollbar] [buildOverscrollIndicator]
// =============================================================================
class _ClassAnatomySection extends StatelessWidget {
  const _ClassAnatomySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      // G2 — anatomy gradient (deep navy)
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFF1F2A44),
            Color(0xFF0E1422),
          ],
        ),
        border: Border.all(color: const Color(0xFF2D3A5A), width: 1),
      ),
      padding: const EdgeInsets.fromLTRB(22, 22, 22, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitleLine(
            number: '02',
            title: 'Class anatomy',
            subtitle: 'How CupertinoScrollBehavior fits into the framework',
            accent: Color(0xFF7CC0FF),
            textColor: Colors.white,
          ),
          const SizedBox(height: 18),
          // Parent box.
          Center(
            child: _AnatomyBox(
              label: 'ScrollBehavior',
              sub: 'flutter/widgets.dart',
              color: Color(0xFF324C7E),
              border: Color(0xFF6A8DCF),
              width: 240,
            ),
          ),
          const _AnatomyArrowDown(height: 30),
          // Mid box: the class we are documenting.
          Center(
            child: _AnatomyBox(
              label: 'CupertinoScrollBehavior',
              sub: 'extends ScrollBehavior',
              color: Color(0xFF4D3B7B),
              border: Color(0xFFB99CFB),
              width: 280,
              highlight: true,
            ),
          ),
          const _AnatomyArrowDown(height: 30),
          // Override leaves.
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _AnatomyLeaf(
                  title: 'getScrollPhysics',
                  sub: 'returns BouncingScrollPhysics',
                  color: Color(0xFF276E5C),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _AnatomyLeaf(
                  title: 'buildScrollbar',
                  sub: 'returns CupertinoScrollbar',
                  color: Color(0xFF6D4A1E),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _AnatomyLeaf(
                  title: 'buildOverscrollIndicator',
                  sub: 'returns child unchanged',
                  color: Color(0xFF7A2A4B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Icon(CupertinoIcons.info_circle_fill, color: Color(0xFF7CC0FF), size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'CupertinoApp installs a CupertinoScrollBehavior at the root through '
                    'ScrollConfiguration. You can override it locally by wrapping a subtree '
                    'in ScrollConfiguration with behavior: <your behavior>.',
                    style: TextStyle(
                      color: Color(0xFFC8D6F0),
                      fontSize: 13,
                      height: 1.4,
                    ),
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

// A box in the anatomy diagram; centered title + small sub-line.
class _AnatomyBox extends StatelessWidget {
  final String label;
  final String sub;
  final Color color;
  final Color border;
  final double width;
  final bool highlight;
  const _AnatomyBox({
    required this.label,
    required this.sub,
    required this.color,
    required this.border,
    required this.width,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border, width: highlight ? 2 : 1),
        boxShadow: highlight
            ? <BoxShadow>[
                BoxShadow(
                  color: border.withValues(alpha: 0.35),
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ]
            : const <BoxShadow>[],
      ),
      child: Column(
        children: <Widget>[
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            sub,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.75),
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// Leaf cell in the anatomy diagram: one override method.
class _AnatomyLeaf extends StatelessWidget {
  final String title;
  final String sub;
  final Color color;
  const _AnatomyLeaf({required this.title, required this.sub, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(height: 4),
          Text(
            sub,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.78),
              fontSize: 11,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

// Vertical connector arrow between anatomy boxes.
class _AnatomyArrowDown extends StatelessWidget {
  final double height;
  const _AnatomyArrowDown({required this.height});

  @override
  Widget build(BuildContext context) {
    // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #4, P2):
    // Icon(size: 14) reserves ~14 px and the Container previously took
    // (height - 10) px, totalling (height + 4) px inside a SizedBox of
    // `height` px — Flutter's RenderFlex asserts a 4.0 px bottom overflow.
    // Reduce the connector line so the Column fits in `height` without
    // overflow.
    return SizedBox(
      height: height,
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 2,
              height: height - 16,
              color: Colors.white.withValues(alpha: 0.4),
            ),
            Icon(
              CupertinoIcons.chevron_down,
              size: 14,
              color: Colors.white.withValues(alpha: 0.55),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 3 — Method Showcase
// -----------------------------------------------------------------------------
// One card per override (and a couple of inherited methods that are commonly
// confused). Each card shows: signature in a monospaced container, a return
// type chip, and a 1-2 sentence description.
// =============================================================================
class _MethodShowcaseSection extends StatelessWidget {
  const _MethodShowcaseSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      // G3 — methods strip (teal → cyan → sky)
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Color(0xFFE4FBFA),
            Color(0xFFD2F1FF),
            Color(0xFFC9DFFF),
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _SectionTitleLine(
            number: '03',
            title: 'Method showcase',
            subtitle: 'Each card shows signature, default behavior, and return type',
            accent: Color(0xFF1F8AA8),
            textColor: Color(0xFF0E2230),
          ),
          SizedBox(height: 16),
          _MethodCard(
            name: 'getScrollPhysics',
            signature: 'ScrollPhysics getScrollPhysics(BuildContext context)',
            description:
                'Returns the scroll physics for descendants. CupertinoScrollBehavior '
                'overrides this to return a BouncingScrollPhysics, regardless of host '
                'platform. The Material default returns ClampingScrollPhysics on Android.',
            returnLabel: 'BouncingScrollPhysics',
            returnColor: Color(0xFF1E7A6B),
          ),
          SizedBox(height: 12),
          _MethodCard(
            name: 'buildScrollbar',
            signature:
                'Widget buildScrollbar(BuildContext c, Widget child, ScrollableDetails d)',
            description:
                'Wraps the scrollable subtree with a scrollbar. The Cupertino implementation '
                'always uses a CupertinoScrollbar, which has the familiar iOS look and '
                'fades after scrolling stops.',
            returnLabel: 'CupertinoScrollbar',
            returnColor: Color(0xFF7B5524),
          ),
          SizedBox(height: 12),
          _MethodCard(
            name: 'buildOverscrollIndicator',
            signature:
                'Widget buildOverscrollIndicator(BuildContext c, Widget child, ScrollableDetails d)',
            description:
                'Material renders a GlowingOverscrollIndicator. Cupertino returns the '
                'child unchanged because iOS uses bounce, not glow. This is why the '
                'Android-style glow disappears under CupertinoApp.',
            returnLabel: 'child (no glow)',
            returnColor: Color(0xFF8A2D55),
          ),
          SizedBox(height: 12),
          _MethodCard(
            name: 'velocityTrackerBuilder',
            signature: 'GestureVelocityTrackerBuilder velocityTrackerBuilder(BuildContext)',
            description:
                'Picks the velocity tracker used to translate touch input into scroll '
                'fling velocity. For Cupertino this is an IOSScrollViewFlingVelocityTracker '
                'tuned for iOS-feel inertia.',
            returnLabel: 'IOSScrollViewFling…',
            returnColor: Color(0xFF374B95),
          ),
          SizedBox(height: 12),
          _MethodCard(
            name: 'getPlatform',
            signature: 'TargetPlatform getPlatform(BuildContext context)',
            description:
                'Returns the platform used to compute defaults. CupertinoScrollBehavior '
                'does NOT override this — it inherits from ScrollBehavior. The bouncing '
                'physics decision is made independently of the reported platform.',
            returnLabel: 'inherited',
            returnColor: Color(0xFF4E6275),
          ),
          SizedBox(height: 12),
          _MethodCard(
            name: 'copyWith',
            signature:
                'ScrollBehavior copyWith({scrollbars, overscroll, physics, platform, dragDevices})',
            description:
                'Builds a wrapper that toggles individual aspects on or off without '
                'subclassing. Useful when you want bouncing physics but no scrollbar, '
                'or to enable multitouch drag for trackpads on desktop.',
            returnLabel: '_WrappedScrollBehavior',
            returnColor: Color(0xFF565E78),
          ),
        ],
      ),
    );
  }
}

// A single method showcase card: signature pane + description + return chip.
class _MethodCard extends StatelessWidget {
  final String name;
  final String signature;
  final String description;
  final String returnLabel;
  final Color returnColor;
  const _MethodCard({
    required this.name,
    required this.signature,
    required this.description,
    required this.returnLabel,
    required this.returnColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFD7E2EE)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: returnColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF0E2230),
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: returnColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: returnColor.withValues(alpha: 0.5)),
                ),
                child: Text(
                  returnLabel,
                  style: TextStyle(
                    color: returnColor,
                    fontSize: 11.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5FB),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFE0E8F2)),
            ),
            child: Text(
              signature,
              style: const TextStyle(
                color: Color(0xFF26384B),
                fontSize: 12.5,
                fontFamily: 'monospace',
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: Color(0xFF2E465B),
              fontSize: 13,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 4 — Physics Comparison
// -----------------------------------------------------------------------------
// Shows three physics models side-by-side with a "ball position" indicator
// that visualizes overscroll. The Bouncing row pushes the ball past the right
// edge to suggest the rubber-band feel.
// =============================================================================
class _PhysicsComparisonSection extends StatelessWidget {
  const _PhysicsComparisonSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      // G4 — physics gradient (warm)
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: <Color>[
            Color(0xFFFFE9C2),
            Color(0xFFFFBE7A),
            Color(0xFFFF7E5C),
          ],
          stops: <double>[0.0, 0.55, 1.0],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitleLine(
            number: '04',
            title: 'Physics comparison',
            subtitle: 'Three scroll physics, side-by-side, with ball-position snapshots',
            accent: Color(0xFFB23A1C),
            textColor: Color(0xFF3A1404),
          ),
          const SizedBox(height: 16),
          const _PhysicsRow(
            label: 'BouncingScrollPhysics',
            tagline: 'iOS / Cupertino — overscrolls past edge, bounces back',
            bodyColor: Color(0xFFFFEEDD),
            barColor: Color(0xFFB23A1C),
            ballPosition: 1.18,
            note: 'CupertinoScrollBehavior.getScrollPhysics → returns this',
          ),
          const SizedBox(height: 10),
          const _PhysicsRow(
            label: 'ClampingScrollPhysics',
            tagline: 'Android / Material — stops hard at edge, no overscroll',
            bodyColor: Color(0xFFFFE6CB),
            barColor: Color(0xFF7C3B0E),
            ballPosition: 1.00,
            note: 'Default for Material on Android',
          ),
          const SizedBox(height: 10),
          const _PhysicsRow(
            label: 'RangeMaintainingScrollPhysics',
            tagline: 'Keeps relative position when content size changes',
            bodyColor: Color(0xFFFFE0BC),
            barColor: Color(0xFF5C2A0A),
            ballPosition: 0.68,
            note: 'Often combined with the platform default',
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFB23A1C).withValues(alpha: 0.35)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Icon(CupertinoIcons.exclamationmark_bubble, color: Color(0xFFB23A1C), size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'CupertinoScrollBehavior always returns BouncingScrollPhysics, '
                    'even on Android. If you want platform-aware behavior, use the '
                    'default ScrollBehavior or compose with ScrollConfiguration.',
                    style: TextStyle(
                      color: Color(0xFF3A1404),
                      fontSize: 13,
                      height: 1.4,
                    ),
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

// One row of the physics comparison table — header + track indicator + note.
class _PhysicsRow extends StatelessWidget {
  final String label;
  final String tagline;
  final Color bodyColor;
  final Color barColor;
  final double ballPosition; // 0..1.4 (>1 = overscroll)
  final String note;
  const _PhysicsRow({
    required this.label,
    required this.tagline,
    required this.bodyColor,
    required this.barColor,
    required this.ballPosition,
    required this.note,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: bodyColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: barColor.withValues(alpha: 0.5)),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  color: barColor,
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: const Icon(CupertinoIcons.arrow_down_circle, size: 16, color: Colors.white),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      label,
                      style: TextStyle(
                        color: barColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'monospace',
                      ),
                    ),
                    Text(
                      tagline,
                      style: const TextStyle(
                        color: Color(0xFF3A1404),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // The mini scroll-track visualization.
          _PhysicsTrack(barColor: barColor, ballPosition: ballPosition),
          const SizedBox(height: 8),
          Text(
            note,
            style: TextStyle(
              color: barColor.withValues(alpha: 0.85),
              fontSize: 11.5,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

// Track + ball visual. The ball is positioned with Flex flex-weights to avoid
// any need for animation. Values > 1.0 push it past the visible end of the
// track to suggest "rubber-band overscroll".
class _PhysicsTrack extends StatelessWidget {
  final Color barColor;
  final double ballPosition;
  const _PhysicsTrack({required this.barColor, required this.ballPosition});

  @override
  Widget build(BuildContext context) {
    final double clamped = ballPosition.clamp(0.0, 1.4);
    final int leftFlex = (clamped * 100).round();
    final int rightFlex = (140 - leftFlex).clamp(1, 140);
    final bool overscroll = clamped > 1.0;
    return Container(
      height: 30,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: barColor.withValues(alpha: 0.4)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 6),
      child: Row(
        children: <Widget>[
          Expanded(flex: leftFlex, child: const SizedBox()),
          Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: overscroll ? const Color(0xFFFF3D00) : barColor,
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: barColor.withValues(alpha: 0.3),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          Expanded(flex: rightFlex, child: const SizedBox()),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 5 — Scrollbar Style Preview
// -----------------------------------------------------------------------------
// Three "fake scrollable" panes painted in three states. We avoid any real
// scrolling and just draw the thumb at sizes corresponding to idle / hovered
// / dragged. Followed by a default-value reference table.
// =============================================================================
class _ScrollbarPreviewSection extends StatelessWidget {
  const _ScrollbarPreviewSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      // G5 — scrollbar gradient (graphite)
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[
            Color(0xFF2C2F36),
            Color(0xFF44474F),
            Color(0xFF1B1D22),
          ],
          stops: <double>[0.0, 0.55, 1.0],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitleLine(
            number: '05',
            title: 'Scrollbar style',
            subtitle: 'How CupertinoScrollbar looks in different states',
            accent: Color(0xFFE5E7EC),
            textColor: Colors.white,
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Expanded(
                child: _ScrollbarTrackPreview(
                  state: 'Idle',
                  description: 'Faded thumb, visible only after scroll activity',
                  thumbColor: Color(0x66FFFFFF),
                  thumbHeight: 60,
                  thumbWidth: 3,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _ScrollbarTrackPreview(
                  state: 'Hovered',
                  description: 'Thumb widens slightly for desktop pointer affordance',
                  thumbColor: Color(0xAAFFFFFF),
                  thumbHeight: 70,
                  thumbWidth: 5,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _ScrollbarTrackPreview(
                  state: 'Dragged',
                  description: 'Fully opaque thumb, follows pointer precisely',
                  thumbColor: Color(0xFFFFFFFF),
                  thumbHeight: 80,
                  thumbWidth: 7,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Row(
                  children: <Widget>[
                    Icon(CupertinoIcons.paintbrush, color: Color(0xFFE5E7EC), size: 16),
                    SizedBox(width: 8),
                    Text(
                      'CupertinoScrollbar defaults',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                _DefaultRow(label: 'thumbVisibility', value: 'false (auto-fade)'),
                _DefaultRow(label: 'thickness', value: '3.0 (resting)'),
                _DefaultRow(label: 'thicknessWhileDragging', value: '8.0'),
                _DefaultRow(label: 'radius', value: 'Radius.circular(1.5)'),
                _DefaultRow(label: 'radiusWhileDragging', value: 'Radius.circular(4.0)'),
                _DefaultRow(label: 'mainAxisMargin', value: '3.0'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// One "fake scrollable" pane. Contents are static colored bars, and a thumb
// is positioned in a vertical stack to suggest a scrollbar.
class _ScrollbarTrackPreview extends StatelessWidget {
  final String state;
  final String description;
  final Color thumbColor;
  final double thumbHeight;
  final double thumbWidth;
  const _ScrollbarTrackPreview({
    required this.state,
    required this.description,
    required this.thumbColor,
    required this.thumbHeight,
    required this.thumbWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 14, 12, 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            state,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 130,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 4, 22, 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const <Widget>[
                      _FakeContentLine(opacity: 0.18),
                      SizedBox(height: 6),
                      _FakeContentLine(opacity: 0.14),
                      SizedBox(height: 6),
                      _FakeContentLine(opacity: 0.10),
                      SizedBox(height: 6),
                      _FakeContentLine(opacity: 0.07),
                      SizedBox(height: 6),
                      _FakeContentLine(opacity: 0.05),
                    ],
                  ),
                ),
                Positioned(
                  right: 4,
                  top: 4,
                  bottom: 4,
                  child: SizedBox(
                    width: thumbWidth + 4,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: const EdgeInsets.only(top: 24),
                        width: thumbWidth,
                        height: thumbHeight,
                        decoration: BoxDecoration(
                          color: thumbColor,
                          borderRadius: BorderRadius.circular(thumbWidth),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 11.5,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

// Decorative line representing "content text" in the fake scrollables.
class _FakeContentLine extends StatelessWidget {
  final double opacity;
  const _FakeContentLine({required this.opacity});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: opacity),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}

// One row in the defaults reference table.
class _DefaultRow extends StatelessWidget {
  final String label;
  final String value;
  const _DefaultRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 200,
            child: Text(
              label,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.78),
                fontSize: 12,
                fontFamily: 'monospace',
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 6 — ScrollConfiguration Propagation Tree
// -----------------------------------------------------------------------------
// A static tree showing how CupertinoApp installs a ScrollConfiguration at
// the root, and how each descendant inherits the same CupertinoScrollBehavior.
// =============================================================================
class _PropagationTreeSection extends StatelessWidget {
  const _PropagationTreeSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      // G6 — propagation tree gradient (emerald diagonal)
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF0F4D40),
            Color(0xFF2DAA8A),
          ],
          stops: <double>[0.0, 1.0],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitleLine(
            number: '06',
            title: 'ScrollConfiguration propagation',
            subtitle: 'How CupertinoApp injects the behavior down the tree',
            accent: Color(0xFFB8FBE3),
            textColor: Colors.white,
          ),
          const SizedBox(height: 18),
          const _TreeNode(
            depth: 0,
            label: 'CupertinoApp',
            badge: 'root',
            badgeColor: Color(0xFF0E2D26),
            description: 'Installs CupertinoScrollBehavior in ScrollConfiguration',
          ),
          const _TreeNode(
            depth: 1,
            label: 'ScrollConfiguration',
            badge: 'behavior: CupertinoScrollBehavior',
            badgeColor: Color(0xFF166053),
            description: 'InheritedWidget that exposes the behavior to descendants',
          ),
          const _TreeNode(
            depth: 2,
            label: 'CupertinoPageScaffold',
            badge: 'scaffold',
            badgeColor: Color(0xFF1E7A6B),
            description: 'Standard Cupertino page container',
          ),
          const _TreeNode(
            depth: 3,
            label: 'CustomScrollView',
            badge: 'inherits physics',
            badgeColor: Color(0xFF258870),
            description: 'getScrollPhysics(context) returns BouncingScrollPhysics',
          ),
          const _TreeNode(
            depth: 4,
            label: 'SliverFillRemaining',
            badge: 'child',
            badgeColor: Color(0xFF2DAA8A),
            description: 'Inherits bouncing physics and the Cupertino scrollbar',
            isLast: true,
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Icon(CupertinoIcons.lightbulb, color: Color(0xFFB8FBE3), size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Any Scrollable in the subtree calls ScrollConfiguration.of(context) '
                    'to resolve its effective behavior. Wrap a subtree in another '
                    'ScrollConfiguration to override behavior for that region only.',
                    style: TextStyle(
                      color: Color(0xFFEAFBF3),
                      fontSize: 13,
                      height: 1.4,
                    ),
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

// One node in the propagation tree. Indentation = depth × 18.
class _TreeNode extends StatelessWidget {
  final int depth;
  final String label;
  final String badge;
  final Color badgeColor;
  final String description;
  final bool isLast;
  const _TreeNode({
    required this.depth,
    required this.label,
    required this.badge,
    required this.badgeColor,
    required this.description,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(depth * 18.0, 0, 0, isLast ? 0 : 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 8),
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.85),
              shape: BoxShape.circle,
              border: Border.all(color: badgeColor, width: 2),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          label,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          badge,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10.5,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.82),
                      fontSize: 12,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 7 — Snippet Gallery
// -----------------------------------------------------------------------------
// Five code-style panes showcasing the most common usage patterns. Rendered
// in a dark "editor" container with monospaced text — purely visual, no
// syntax highlighting.
// =============================================================================
class _SnippetGallerySection extends StatelessWidget {
  const _SnippetGallerySection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF0E1422),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFF1F2A44)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _SectionTitleLine(
            number: '07',
            title: 'Snippets',
            subtitle: 'Common usage patterns, ready to copy',
            accent: Color(0xFFFFD27A),
            textColor: Colors.white,
          ),
          SizedBox(height: 16),
          _CodeSnippet(
            title: 'Override scroll behavior for a subtree',
            code:
                'ScrollConfiguration(\n'
                '  behavior: const CupertinoScrollBehavior(),\n'
                '  child: ListView.builder(\n'
                '    itemCount: 200,\n'
                '    itemBuilder: (c, i) => ListTile(title: Text(\'Item \$i\')),\n'
                '  ),\n'
                ');',
          ),
          SizedBox(height: 12),
          _CodeSnippet(
            title: 'Disable the scrollbar globally with copyWith',
            code:
                'ScrollConfiguration(\n'
                '  behavior: const CupertinoScrollBehavior().copyWith(scrollbars: false),\n'
                '  child: MyHomePage(),\n'
                ');',
          ),
          SizedBox(height: 12),
          _CodeSnippet(
            title: 'Enable trackpad / mouse drag on desktop',
            code:
                'ScrollConfiguration(\n'
                '  behavior: const CupertinoScrollBehavior().copyWith(\n'
                '    dragDevices: {\n'
                '      PointerDeviceKind.touch,\n'
                '      PointerDeviceKind.mouse,\n'
                '      PointerDeviceKind.trackpad,\n'
                '    },\n'
                '  ),\n'
                '  child: const MyScrollableArea(),\n'
                ');',
          ),
          SizedBox(height: 12),
          _CodeSnippet(
            title: 'Force bouncing physics inside a MaterialApp',
            code:
                'MaterialApp(\n'
                '  scrollBehavior: const CupertinoScrollBehavior(),\n'
                '  home: MyHomePage(),\n'
                ');',
          ),
          SizedBox(height: 12),
          _CodeSnippet(
            title: 'Subclass for custom physics',
            code:
                'class MyBehavior extends CupertinoScrollBehavior {\n'
                '  const MyBehavior();\n'
                '  @override\n'
                '  ScrollPhysics getScrollPhysics(BuildContext context) {\n'
                '    return const BouncingScrollPhysics(\n'
                '      decelerationRate: ScrollDecelerationRate.fast,\n'
                '    );\n'
                '  }\n'
                '}',
          ),
        ],
      ),
    );
  }
}

// One code snippet pane.
class _CodeSnippet extends StatelessWidget {
  final String title;
  final String code;
  const _CodeSnippet({required this.title, required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF111A2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2A3A5C)),
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFD27A),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFFEDEFF5),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const Text(
                'dart',
                style: TextStyle(
                  color: Color(0xFF7C8DB5),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF0A1322),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF1B2842)),
            ),
            child: Text(
              code,
              style: const TextStyle(
                color: Color(0xFFD6E1F5),
                fontSize: 12.5,
                height: 1.45,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 8 — Pitfalls & Wisdom
// -----------------------------------------------------------------------------
// Five callout cards using a small severity enum: danger / warning / info /
// success. Each card has an icon, label, title, and body — and uses the
// severity color to tint the border, badge, and icon background.
// =============================================================================
class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      // G7 — pitfalls gradient (rose → pink → fuchsia)
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            Color(0xFFFFE3EC),
            Color(0xFFFFC4DA),
            Color(0xFFE57AB0),
          ],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _SectionTitleLine(
            number: '08',
            title: 'Pitfalls & wisdom',
            subtitle: 'Things developers commonly trip over',
            accent: Color(0xFF8A1B5A),
            textColor: Color(0xFF3A0A26),
          ),
          SizedBox(height: 16),
          _CalloutCard(
            severity: _CalloutSeverity.danger,
            title: 'Glow overscroll won\'t go away',
            body: 'Wrapping a ListView in CupertinoApp does NOT remove the Material glow '
                'if a MaterialApp ancestor is still in the tree (e.g. in tests). Use '
                'ScrollConfiguration explicitly when nesting both apps.',
          ),
          SizedBox(height: 10),
          _CalloutCard(
            severity: _CalloutSeverity.warning,
            title: 'Physics surprise on Android',
            body: 'CupertinoScrollBehavior returns BouncingScrollPhysics on EVERY platform. '
                'If your QA team tests on Android they may report unexpected overscroll. '
                'Either accept it or override getScrollPhysics in a subclass.',
          ),
          SizedBox(height: 10),
          _CalloutCard(
            severity: _CalloutSeverity.warning,
            title: 'CupertinoScrollbar duplication',
            body: 'Manually wrapping with CupertinoScrollbar inside CupertinoApp can cause '
                'two scrollbars to appear. The behavior already adds one; manual wrapping '
                'should only happen for advanced customization.',
          ),
          SizedBox(height: 10),
          _CalloutCard(
            severity: _CalloutSeverity.success,
            title: 'copyWith is your friend',
            body: 'You almost never need to subclass. Use copyWith(scrollbars: false, '
                'overscroll: false, dragDevices: {...}) to toggle individual behaviors '
                'without losing the iOS feel.',
          ),
          SizedBox(height: 10),
          _CalloutCard(
            severity: _CalloutSeverity.info,
            title: 'Test with bouncing physics in mind',
            body: 'When writing widget tests, scroll offsets can overshoot the actual '
                'content length because of bouncing. Use pumpAndSettle and avoid asserting '
                'exact pixel positions during bounce-back.',
          ),
        ],
      ),
    );
  }
}

// Severity used by _CalloutCard.
enum _CalloutSeverity { danger, warning, info, success }

// One severity-tinted callout. Computes the accent color and icon from the
// severity enum so each callout can be declared with one line.
class _CalloutCard extends StatelessWidget {
  final _CalloutSeverity severity;
  final String title;
  final String body;
  const _CalloutCard({
    required this.severity,
    required this.title,
    required this.body,
  });

  Color get _accentColor {
    switch (severity) {
      case _CalloutSeverity.danger:
        return const Color(0xFFC4274A);
      case _CalloutSeverity.warning:
        return const Color(0xFFCB8A19);
      case _CalloutSeverity.info:
        return const Color(0xFF1F6CB3);
      case _CalloutSeverity.success:
        return const Color(0xFF2C7B4A);
    }
  }

  IconData get _icon {
    switch (severity) {
      case _CalloutSeverity.danger:
        return CupertinoIcons.xmark_octagon_fill;
      case _CalloutSeverity.warning:
        return CupertinoIcons.exclamationmark_triangle_fill;
      case _CalloutSeverity.info:
        return CupertinoIcons.info_circle_fill;
      case _CalloutSeverity.success:
        return CupertinoIcons.checkmark_seal_fill;
    }
  }

  String get _label {
    switch (severity) {
      case _CalloutSeverity.danger:
        return 'DANGER';
      case _CalloutSeverity.warning:
        return 'WARNING';
      case _CalloutSeverity.info:
        return 'INFO';
      case _CalloutSeverity.success:
        return 'OK';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _accentColor.withValues(alpha: 0.5)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _accentColor.withValues(alpha: 0.18),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: _accentColor.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Icon(_icon, color: _accentColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Color(0xFF1E1326),
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: _accentColor,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        _label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: const TextStyle(
                    color: Color(0xFF3F2A3A),
                    fontSize: 12.5,
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
}

// =============================================================================
// SECTION 9 — Migration Cheat Sheet
// -----------------------------------------------------------------------------
// A two-column mapping from Material concepts (indigo pills) to Cupertino
// concepts (rose pills), with a short note explaining the relationship.
// =============================================================================
class _MigrationCheatSheetSection extends StatelessWidget {
  const _MigrationCheatSheetSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: const Color(0xFFE0E6F0)),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 14,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _SectionTitleLine(
            number: '09',
            title: 'Migration cheat sheet',
            subtitle: 'Material ↔ Cupertino mapping for scroll concerns',
            accent: Color(0xFF3F3D9D),
            textColor: Color(0xFF0E1422),
          ),
          SizedBox(height: 16),
          _MigrationRow(
            material: 'ScrollBehavior',
            cupertino: 'CupertinoScrollBehavior',
            note: 'Use directly via MaterialApp.scrollBehavior or ScrollConfiguration',
          ),
          _MigrationRow(
            material: 'ClampingScrollPhysics',
            cupertino: 'BouncingScrollPhysics',
            note: 'Returned from getScrollPhysics on all platforms',
          ),
          _MigrationRow(
            material: 'Scrollbar',
            cupertino: 'CupertinoScrollbar',
            note: 'Auto-installed by buildScrollbar',
          ),
          _MigrationRow(
            material: 'GlowingOverscrollIndicator',
            cupertino: '(none — child unchanged)',
            note: 'iOS uses bounce; no visual overscroll glow',
          ),
          _MigrationRow(
            material: 'Theme.of(context).scrollbarTheme',
            cupertino: 'CupertinoScrollbar.thickness*',
            note: 'Styling lives on the widget itself, not the theme',
          ),
          _MigrationRow(
            material: 'RawScrollbar',
            cupertino: 'CupertinoScrollbar (still uses RawScrollbar internally)',
            note: 'Cupertino is a styled subclass of RawScrollbar',
          ),
          _MigrationRow(
            material: 'AlwaysScrollableScrollPhysics',
            cupertino: 'AlwaysScrollable…applyTo(BouncingScrollPhysics())',
            note: 'Compose to get bouncy + always-scrollable',
            isLast: true,
          ),
        ],
      ),
    );
  }
}

// One row of the migration table.
class _MigrationRow extends StatelessWidget {
  final String material;
  final String cupertino;
  final String note;
  final bool isLast;
  const _MigrationRow({
    required this.material,
    required this.cupertino,
    required this.note,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isLast ? 0 : 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF6F7FB),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE5EAF3)),
      ),
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFECEAFB),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFB7B0E6)),
                  ),
                  child: Text(
                    material,
                    style: const TextStyle(
                      color: Color(0xFF3F3D9D),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Icon(CupertinoIcons.arrow_right_circle_fill,
                    color: Color(0xFF7A4DB8), size: 18),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFDE9F2),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: const Color(0xFFE9A6C7)),
                  ),
                  child: Text(
                    cupertino,
                    style: const TextStyle(
                      color: Color(0xFFA02567),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            note,
            style: const TextStyle(
              color: Color(0xFF4D5C73),
              fontSize: 12,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 10 — Footer reference summary
// -----------------------------------------------------------------------------
// Three columns of "see also" references: Types, Methods, See also. Each
// column is a static bullet list with monospaced text. The footer pill at
// the bottom identifies the demo file.
// =============================================================================
class _FooterReferenceSection extends StatelessWidget {
  const _FooterReferenceSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      // G8 — footer gradient (midnight → indigo)
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            Color(0xFF14172E),
            Color(0xFF1F2253),
            Color(0xFF131527),
          ],
          stops: <double>[0.0, 0.5, 1.0],
        ),
      ),
      padding: const EdgeInsets.fromLTRB(22, 24, 22, 26),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const _SectionTitleLine(
            number: '10',
            title: 'API reference summary',
            subtitle: 'Quick lookup of types, signatures, and defaults',
            accent: Color(0xFFB99CFB),
            textColor: Colors.white,
          ),
          const SizedBox(height: 18),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const <Widget>[
                    _FooterColumnTitle(label: 'Types'),
                    _FooterListItem(text: 'CupertinoScrollBehavior'),
                    _FooterListItem(text: 'ScrollBehavior'),
                    _FooterListItem(text: 'BouncingScrollPhysics'),
                    _FooterListItem(text: 'ClampingScrollPhysics'),
                    _FooterListItem(text: 'CupertinoScrollbar'),
                    _FooterListItem(text: 'ScrollConfiguration'),
                    _FooterListItem(text: 'ScrollableDetails'),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const <Widget>[
                    _FooterColumnTitle(label: 'Methods'),
                    _FooterListItem(text: 'getScrollPhysics(context)'),
                    _FooterListItem(text: 'buildScrollbar(c, child, details)'),
                    _FooterListItem(text: 'buildOverscrollIndicator(c, child, d)'),
                    _FooterListItem(text: 'velocityTrackerBuilder(context)'),
                    _FooterListItem(text: 'copyWith(...)'),
                    _FooterListItem(text: 'shouldNotify(other)'),
                    _FooterListItem(text: 'getPlatform(context)'),
                  ],
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: const <Widget>[
                    _FooterColumnTitle(label: 'See also'),
                    _FooterListItem(text: 'CupertinoApp.scrollBehavior'),
                    _FooterListItem(text: 'MaterialApp.scrollBehavior'),
                    _FooterListItem(text: 'ScrollConfiguration.of'),
                    _FooterListItem(text: 'PrimaryScrollController'),
                    _FooterListItem(text: 'ScrollDecelerationRate'),
                    _FooterListItem(text: 'PointerDeviceKind'),
                    _FooterListItem(text: 'GestureVelocityTrackerBuilder'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withValues(alpha: 0.14)),
            ),
            child: Row(
              children: const <Widget>[
                Icon(CupertinoIcons.book, color: Color(0xFFB99CFB), size: 18),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'CupertinoScrollBehavior is a small but high-impact class. Most apps '
                    'never instantiate it directly — CupertinoApp does — but understanding '
                    'its overrides is essential for cross-platform consistency tuning.',
                    style: TextStyle(
                      color: Color(0xFFE2DBFF),
                      fontSize: 13,
                      height: 1.45,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
              ),
              child: const Text(
                'tom_d4rt_flutter_ast • CupertinoScrollBehavior visual demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Title for one footer column ("TYPES", "METHODS", "SEE ALSO").
class _FooterColumnTitle extends StatelessWidget {
  final String label;
  const _FooterColumnTitle({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label.toUpperCase(),
        style: const TextStyle(
          color: Color(0xFFB99CFB),
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

// One bullet entry in a footer column.
class _FooterListItem extends StatelessWidget {
  final String text;
  const _FooterListItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          Container(
            width: 5,
            height: 5,
            margin: const EdgeInsets.only(right: 8),
            decoration: const BoxDecoration(
              color: Color(0xFFB99CFB),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFFE2DBFF),
                fontSize: 12.5,
                fontFamily: 'monospace',
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Shared section title (used by every section).
// -----------------------------------------------------------------------------
// A two-line header with a numbered accent square. Reused by all 10 sections
// so the page reads as a coherent guide rather than a collage.
// =============================================================================
class _SectionTitleLine extends StatelessWidget {
  final String number;
  final String title;
  final String subtitle;
  final Color accent;
  final Color textColor;
  const _SectionTitleLine({
    required this.number,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: accent.withValues(alpha: 0.6)),
          ),
          alignment: Alignment.center,
          child: Text(
            number,
            style: TextStyle(
              color: accent,
              fontSize: 16,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  color: textColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(
                  color: textColor.withValues(alpha: 0.78),
                  fontSize: 13,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// =============================================================================
// End of CupertinoScrollBehavior — Visual Deep Demo
// =============================================================================
