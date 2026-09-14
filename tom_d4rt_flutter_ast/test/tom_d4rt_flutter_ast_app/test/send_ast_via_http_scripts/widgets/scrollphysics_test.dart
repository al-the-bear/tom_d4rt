// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import
// D4rt test script: Deep Demo — The ScrollPhysics Family
// Hand-authored visual demonstration of the ScrollPhysics class hierarchy:
//   * ScrollPhysics (the abstract base)
//   * BouncingScrollPhysics (iOS-style rubber-band overscroll)
//   * ClampingScrollPhysics (Android-style hard-stop overscroll)
//   * AlwaysScrollableScrollPhysics (force scrollability)
//   * NeverScrollableScrollPhysics (lock the scrollable)
//   * PageScrollPhysics (snap to page boundaries)
//   * RangeMaintainingScrollPhysics (preserve scroll position across resizes)
//   * FixedExtentScrollPhysics (snap to item indices, used by wheel pickers)
//
// The file is structured as a long, walk-through dossier covering the anatomy
// of a ScrollPhysics implementation (applyBoundaryConditions,
// createBallisticSimulation, applyPhysicsToUserOffset, Tolerance), then
// live demos of each subclass embedded in small SizedBox containers, a
// side-by-side comparison panel for overscroll behavior, a set of common
// recipes (refresh-with-bouncing, snapping pages, locked panels, always-
// scrollable empty lists), an illustration of Tolerance values, a static
// "simulation curve" panel, a pitfalls section, a glossary, and a final
// recap. The whole composition is returned as a single ListView so it can
// be rendered by the AST runner without a StatefulWidget anywhere.
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

// ============================================================================
// SMALL STATELESS BUILDING BLOCKS
// ----------------------------------------------------------------------------
// The d4rt visual runner does not allow StatefulWidget, so all of the
// physics demos are encapsulated as StatelessWidget wrappers. Each wrapper
// renders a small fixed-size ListView with one specific ScrollPhysics
// applied, plus a label strip and a short description.
// ============================================================================

class _SectionTitle extends StatelessWidget {
  final String label;
  final String? subtitle;
  final IconData icon;
  final Color color;
  const _SectionTitle({
    required this.label,
    required this.icon,
    required this.color,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(0, 24, 0, 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[color.withOpacity(0.85), color.withOpacity(0.55)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, color: Colors.white, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.4,
                  ),
                ),
                if (subtitle != null) ...<Widget>[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.95),
                      fontSize: 12.5,
                      height: 1.3,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LabeledCard extends StatelessWidget {
  final String title;
  final String body;
  final IconData icon;
  final Color accent;
  const _LabeledCard({
    required this.title,
    required this.body,
    required this.icon,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: accent.withOpacity(0.45), width: 1.2),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withOpacity(0.10),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: accent, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: accent.withOpacity(0.95),
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  body,
                  style: const TextStyle(
                    color: Color(0xFF333333),
                    fontSize: 12.5,
                    height: 1.35,
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

class _MonoLine extends StatelessWidget {
  final String text;
  final Color color;
  const _MonoLine({required this.text, this.color = const Color(0xFF1B5E20)});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.5),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
          color: color,
          height: 1.35,
        ),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String title;
  final String code;
  final Color tint;
  const _CodeBlock({
    required this.title,
    required this.code,
    this.tint = const Color(0xFF263238),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.35),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.4,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              code,
              style: const TextStyle(
                color: Color(0xFFB2DFDB),
                fontFamily: 'monospace',
                fontSize: 11.8,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// _PhysicsDemoBox — fixed-size visual demo for one ScrollPhysics instance.
// ----------------------------------------------------------------------------
class _PhysicsDemoBox extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color accent;
  final ScrollPhysics? physics;
  final int itemCount;
  final double itemExtent;
  final double height;
  final bool horizontal;
  final IconData icon;
  const _PhysicsDemoBox({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.physics,
    required this.icon,
    this.itemCount = 14,
    this.itemExtent = 44,
    this.height = 180,
    this.horizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    final Axis axis = horizontal ? Axis.horizontal : Axis.vertical;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: accent.withOpacity(0.55), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: accent.withOpacity(0.12),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Row(
              children: <Widget>[
                Icon(icon, color: accent, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        style: TextStyle(
                          color: accent,
                          fontSize: 13.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: accent.withOpacity(0.85),
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height,
            child: ListView.builder(
              scrollDirection: axis,
              physics: physics,
              padding: const EdgeInsets.all(8),
              itemCount: itemCount,
              itemBuilder: (BuildContext ctx, int index) {
                final Color tile =
                    HSLColor.fromAHSL(1.0, (index * 28) % 360, 0.55, 0.62)
                        .toColor();
                if (horizontal) {
                  return Container(
                    width: itemExtent,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: tile,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '#$index',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  );
                }
                return Container(
                  height: itemExtent,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: tile,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Row $index',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------------------------------
// _OverscrollSimGraph — purely visual, static sketch of "what the overscroll
// curve looks like" for a given physics class. We do not run a real
// simulation; we just paint static bars so the reader gets a feel for the
// shape (bouncy, clamped, none).
// ----------------------------------------------------------------------------
class _OverscrollSimGraph extends StatelessWidget {
  final String label;
  final Color color;
  final List<double> points;
  final String caption;
  const _OverscrollSimGraph({
    required this.label,
    required this.color,
    required this.points,
    required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: color,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: points.map<Widget>((double v) {
                final double h = v.abs() * 50.0 + 4.0;
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 1.5),
                    height: h,
                    decoration: BoxDecoration(
                      color: v >= 0 ? color : color.withOpacity(0.45),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            caption,
            style: const TextStyle(
              color: Color(0xFF555555),
              fontSize: 11.5,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// build() — the entry point for the d4rt AST runner.
// ============================================================================
dynamic build(BuildContext context) {
  print('=============================================================');
  print('  ScrollPhysics Family — Deep Visual Demo');
  print('=============================================================');

  // --------------------------------------------------------------------------
  // SECTION 1 — Dossier (purpose of ScrollPhysics)
  // --------------------------------------------------------------------------
  print('=== Section 1: Dossier ===');

  final List<Widget> dossier = <Widget>[
    const _SectionTitle(
      label: 'Dossier: What ScrollPhysics actually is',
      subtitle:
          'A small, pure-Dart class hierarchy that tells a Scrollable how to '
          'translate user gestures and momentum into scroll positions.',
      icon: Icons.menu_book,
      color: Color(0xFF5E35B1),
    ),
    const _LabeledCard(
      title: 'Purpose',
      icon: Icons.flag,
      accent: Color(0xFF5E35B1),
      body:
          'ScrollPhysics is the policy object of every Scrollable. Whenever '
          'the user drags, flings, or releases a list, Flutter asks the '
          'physics instance four questions: should I accept this offset, '
          'how much of the user offset should I apply, what happens if the '
          'list is pulled past its limits, and what ballistic simulation '
          'should run after the finger lifts?',
    ),
    const _LabeledCard(
      title: 'Hierarchy at a glance',
      icon: Icons.account_tree,
      accent: Color(0xFF512DA8),
      body:
          'ScrollPhysics (abstract)\n'
          '  - BouncingScrollPhysics       (iOS rubber band)\n'
          '  - ClampingScrollPhysics       (Android hard stop + glow)\n'
          '  - AlwaysScrollableScrollPhysics (force scrollability)\n'
          '  - NeverScrollableScrollPhysics  (lock it down)\n'
          '  - PageScrollPhysics             (snap to page boundaries)\n'
          '  - RangeMaintainingScrollPhysics (preserve position on resize)\n'
          '  - FixedExtentScrollPhysics      (snap to item indices)',
    ),
    const _LabeledCard(
      title: 'Where it lives',
      icon: Icons.location_on,
      accent: Color(0xFF4527A0),
      body:
          'Every Scrollable (ListView, GridView, CustomScrollView, '
          'PageView, ListWheelScrollView, NestedScrollView...) takes a '
          'physics parameter. If you pass null, the framework derives a '
          'default from ScrollConfiguration.of(context), which is platform '
          '-aware (Bouncing on iOS/macOS, Clamping on Android/Fuchsia, '
          'Bouncing-with-clamping for desktops in newer Flutter).',
    ),
    const _LabeledCard(
      title: 'Why it is a "policy" not a "controller"',
      icon: Icons.policy,
      accent: Color(0xFF311B92),
      body:
          'ScrollPhysics is stateless and immutable. The actual position '
          'lives in ScrollPosition, the controller in ScrollController. '
          'ScrollPhysics is a pure decision function: given a context, '
          'what should the next offset be? This is what allows arbitrary '
          'chaining via the parent field — the responsibility is uniform.',
    ),
  ];

  // --------------------------------------------------------------------------
  // SECTION 2 — Anatomy of a ScrollPhysics implementation.
  // --------------------------------------------------------------------------
  print('=== Section 2: Anatomy ===');

  final List<Widget> anatomy = <Widget>[
    const _SectionTitle(
      label: 'Anatomy of a ScrollPhysics',
      subtitle:
          'The four methods and one Tolerance value that every subclass '
          'either inherits, overrides, or carefully delegates.',
      icon: Icons.biotech,
      color: Color(0xFF00838F),
    ),
    const _LabeledCard(
      title: 'applyBoundaryConditions(position, value)',
      icon: Icons.fence,
      accent: Color(0xFF006064),
      body:
          'Called when the scrollable would move to value. Returns the '
          'overscroll that should be REJECTED. Returning 0 means "the move '
          'is fully allowed". Returning value-minScroll means "snap back to '
          'minScroll, no overscroll permitted" — this is how Clamping '
          'physics produce a hard stop. Bouncing returns 0 here and instead '
          'applies friction in applyPhysicsToUserOffset.',
    ),
    const _LabeledCard(
      title: 'applyPhysicsToUserOffset(position, offset)',
      icon: Icons.touch_app,
      accent: Color(0xFF00838F),
      body:
          'Called while the user is actively dragging. Receives the raw '
          'pixel offset from the gesture and returns the transformed offset '
          'that will be applied to the scroll position. BouncingScrollPhysics '
          'multiplies this by a friction factor when the position is out of '
          'range, which is the source of the rubber-band feel.',
    ),
    const _LabeledCard(
      title: 'createBallisticSimulation(position, velocity)',
      icon: Icons.rocket_launch,
      accent: Color(0xFF00ACC1),
      body:
          'Called when the user releases a fling. Returns a Simulation '
          'whose x(t) and dx(t) drive the position forward over time. '
          'BouncingScrollPhysics returns a BouncingScrollSimulation, '
          'ClampingScrollPhysics returns a ClampingScrollSimulation, '
          'FixedExtentScrollPhysics returns a custom simulation that lands '
          'exactly on an integer item index.',
    ),
    const _LabeledCard(
      title: 'Tolerance (velocity, distance, time)',
      icon: Icons.tune,
      accent: Color(0xFF26C6DA),
      body:
          'A Tolerance value defines when the ballistic simulation is '
          '"close enough" to its target to be considered complete. Tiny '
          'numbers (e.g. velocity 0.05, distance 0.01 in logical pixels). '
          'Override the tolerance getter if your physics needs different '
          'rest thresholds — fixed-extent pickers, for instance, want a '
          'lower distance tolerance for snappy alignment.',
    ),
    const _CodeBlock(
      title: 'Skeleton of a custom ScrollPhysics',
      code: 'class MyPhysics extends ScrollPhysics {\n'
          '  const MyPhysics({super.parent});\n'
          '\n'
          '  @override\n'
          '  MyPhysics applyTo(ScrollPhysics? ancestor) =>\n'
          '      MyPhysics(parent: buildParent(ancestor));\n'
          '\n'
          '  @override\n'
          '  double applyBoundaryConditions(\n'
          '      ScrollMetrics position, double value) {\n'
          '    if (value < position.minScrollExtent) {\n'
          '      return value - position.minScrollExtent;\n'
          '    }\n'
          '    if (value > position.maxScrollExtent) {\n'
          '      return value - position.maxScrollExtent;\n'
          '    }\n'
          '    return 0.0;\n'
          '  }\n'
          '\n'
          '  @override\n'
          '  Simulation? createBallisticSimulation(\n'
          '      ScrollMetrics position, double velocity) {\n'
          '    if (velocity.abs() < tolerance.velocity) return null;\n'
          '    return ClampingScrollSimulation(\n'
          '      position: position.pixels,\n'
          '      velocity: velocity,\n'
          '      tolerance: tolerance,\n'
          '    );\n'
          '  }\n'
          '}',
    ),
  ];

  // --------------------------------------------------------------------------
  // SECTION 3 — Live demos for each physics class.
  // Each is wrapped in a SizedBox to keep the layout predictable.
  // --------------------------------------------------------------------------
  print('=== Section 3: Live demos ===');

  // 3.1 ScrollPhysics (the base — used as default ScrollPhysics()).
  final Widget demoBase = const _PhysicsDemoBox(
    title: 'ScrollPhysics() — the base',
    subtitle:
        'Generic. Scrollable only when content overflows the viewport. '
        'Overscroll allowed unless the platform default chains in a clamp.',
    accent: Color(0xFF5E35B1),
    physics: ScrollPhysics(),
    icon: Icons.layers,
  );

  // 3.2 BouncingScrollPhysics.
  final Widget demoBouncing = const _PhysicsDemoBox(
    title: 'BouncingScrollPhysics — iOS rubber band',
    subtitle:
        'Overscroll allowed with friction, then a spring snaps the list '
        'back. Used as default on iOS and (chained) on macOS.',
    accent: Color(0xFFD81B60),
    physics: BouncingScrollPhysics(),
    icon: Icons.waves,
  );

  // 3.3 ClampingScrollPhysics.
  final Widget demoClamping = const _PhysicsDemoBox(
    title: 'ClampingScrollPhysics — Android hard stop',
    subtitle:
        'No overscroll past the edges; the platform draws a glow indicator '
        'instead. Default on Android and Fuchsia.',
    accent: Color(0xFF2E7D32),
    physics: ClampingScrollPhysics(),
    icon: Icons.stop_circle,
  );

  // 3.4 AlwaysScrollableScrollPhysics.
  final Widget demoAlways = const _PhysicsDemoBox(
    title: 'AlwaysScrollableScrollPhysics — force scrollability',
    subtitle:
        'Wraps a parent. Even a 1-item list becomes scrollable, enabling '
        'pull-to-refresh and overscroll indicators on short content.',
    accent: Color(0xFFEF6C00),
    physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
    icon: Icons.swap_vert,
    itemCount: 3,
  );

  // 3.5 NeverScrollableScrollPhysics.
  final Widget demoNever = const _PhysicsDemoBox(
    title: 'NeverScrollableScrollPhysics — lock the panel',
    subtitle:
        'Rejects all user offsets. The list is rendered, but the user '
        'cannot scroll it. Common inside SingleChildScrollView wrappers '
        'or when the outer scrollable should own all gestures.',
    accent: Color(0xFFC62828),
    physics: NeverScrollableScrollPhysics(),
    icon: Icons.lock,
  );

  // 3.6 PageScrollPhysics (horizontal demo).
  final Widget demoPage = const _PhysicsDemoBox(
    title: 'PageScrollPhysics — snap to page boundaries',
    subtitle:
        'Used by PageView. After a fling, the simulation lands exactly on '
        'a viewport-sized page boundary. Demonstrated horizontally.',
    accent: Color(0xFF1565C0),
    physics: PageScrollPhysics(),
    icon: Icons.swipe,
    horizontal: true,
    itemCount: 10,
    itemExtent: 120,
    height: 110,
  );

  // 3.7 RangeMaintainingScrollPhysics.
  final Widget demoRange = const _PhysicsDemoBox(
    title: 'RangeMaintainingScrollPhysics — keep position on resize',
    subtitle:
        'If maxScrollExtent shrinks (e.g. content removed), this physics '
        'preserves the relative scroll position instead of clamping the '
        'user to the new end. Subtle but crucial for chat lists.',
    accent: Color(0xFF6A1B9A),
    physics: RangeMaintainingScrollPhysics(),
    icon: Icons.straighten,
  );

  // 3.8 FixedExtentScrollPhysics.
  // (We render it inside a ListWheelScrollView to make sense of the physics.)
  final Widget demoFixed = Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFF00695C), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF00695C).withOpacity(0.12),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            children: const <Widget>[
              Icon(Icons.casino, color: Color(0xFF00695C), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'FixedExtentScrollPhysics — wheel-picker snapping',
                      style: TextStyle(
                        color: Color(0xFF00695C),
                        fontSize: 13.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'Snaps to an integer item index. Used by '
                      'ListWheelScrollView and CupertinoPicker.',
                      style: TextStyle(
                        color: Color(0xFF00695C),
                        fontSize: 11.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 180,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 44,
            physics: const FixedExtentScrollPhysics(),
            perspective: 0.003,
            diameterRatio: 1.8,
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: 24,
              builder: (BuildContext ctx, int index) {
                return Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00695C).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  margin: const EdgeInsets.symmetric(
                      vertical: 2, horizontal: 24),
                  child: Text(
                    'Item $index',
                    style: const TextStyle(
                      color: Color(0xFF00695C),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    ),
  );

  final List<Widget> liveDemos = <Widget>[
    const _SectionTitle(
      label: 'Live demos — one box per physics class',
      subtitle: 'Each ListView below uses a different ScrollPhysics. The '
          'shapes are identical so any visible difference is the physics.',
      icon: Icons.visibility,
      color: Color(0xFF00695C),
    ),
    demoBase,
    demoBouncing,
    demoClamping,
    demoAlways,
    demoNever,
    demoPage,
    demoRange,
    demoFixed,
  ];

  // --------------------------------------------------------------------------
  // SECTION 4 — Comparison panel: overscroll behaviour at a glance.
  // --------------------------------------------------------------------------
  print('=== Section 4: Comparison panel ===');

  final List<Widget> comparison = <Widget>[
    const _SectionTitle(
      label: 'Comparison: overscroll behavior',
      subtitle: 'How each physics responds when the user tries to scroll '
          'past the edges of the content.',
      icon: Icons.compare_arrows,
      color: Color(0xFFFF6F00),
    ),
    const _OverscrollSimGraph(
      label: 'BouncingScrollPhysics — rubber band',
      color: Color(0xFFD81B60),
      points: <double>[
        0.0, 0.1, 0.3, 0.55, 0.8, 0.95, 0.9, 0.65, 0.35, 0.1, 0.0, 0.0
      ],
      caption:
          'Overscroll permitted with progressive friction (~0.52). The '
          'spring then returns the list to its bound. The exact curve is '
          'BouncingScrollSimulation, modeled with a SpringSimulation tuned '
          'to feel like UIScrollView.',
    ),
    const _OverscrollSimGraph(
      label: 'ClampingScrollPhysics — hard stop',
      color: Color(0xFF2E7D32),
      points: <double>[
        0.0, 0.1, 0.3, 0.5, 0.5, 0.5, 0.5, 0.5, 0.4, 0.25, 0.1, 0.0
      ],
      caption:
          'Overscroll is rejected at the boundary; the position never goes '
          'past minScrollExtent or maxScrollExtent. On Android the platform '
          'paints a glow to indicate the rejected impulse. The ballistic '
          'simulation here is ClampingScrollSimulation (a friction model).',
    ),
    const _OverscrollSimGraph(
      label: 'NeverScrollableScrollPhysics — flat',
      color: Color(0xFFC62828),
      points: <double>[
        0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0
      ],
      caption:
          'shouldAcceptUserOffset() always returns false. No simulation, no '
          'overscroll, no movement. Useful when an outer scrollable should '
          'completely own the gesture.',
    ),
    const _OverscrollSimGraph(
      label: 'AlwaysScrollableScrollPhysics(parent: Bouncing)',
      color: Color(0xFFEF6C00),
      points: <double>[
        0.0, 0.05, 0.2, 0.4, 0.7, 0.85, 0.85, 0.6, 0.3, 0.1, 0.0, 0.0
      ],
      caption:
          'Same shape as Bouncing — Always merely toggles the '
          'shouldAcceptUserOffset gate to true. The parent supplies all '
          'the actual behaviour. Pair with RefreshIndicator when the '
          'content does not exceed the viewport.',
    ),
    const _LabeledCard(
      title: 'Reading the graphs',
      icon: Icons.psychology,
      accent: Color(0xFFFF6F00),
      body:
          'Each bar is a snapshot of overscroll amplitude over time after a '
          'release. Tall bars mean the position moved further past the '
          'bound; the trailing tail represents the simulation returning to '
          'rest. The flat-zero row for Never makes the difference obvious.',
    ),
  ];

  // --------------------------------------------------------------------------
  // SECTION 5 — Recipes (real-world patterns).
  // --------------------------------------------------------------------------
  print('=== Section 5: Recipes ===');

  // Recipe 5a: refresh-with-bouncing.
  final Widget recipeRefresh = Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFF1565C0), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF1565C0).withOpacity(0.12),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Row(
            children: const <Widget>[
              Icon(Icons.refresh, color: Color(0xFF1565C0), size: 18),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Recipe: refresh-with-bouncing on a short list',
                  style: TextStyle(
                    color: Color(0xFF1565C0),
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 170,
          child: RefreshIndicator(
            onRefresh: () async {
              await Future<void>.delayed(const Duration(milliseconds: 1));
            },
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              padding: const EdgeInsets.all(8),
              itemCount: 3,
              itemBuilder: (BuildContext ctx, int index) {
                return Container(
                  height: 44,
                  margin: const EdgeInsets.symmetric(vertical: 3),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1565C0).withOpacity(0.20),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Short row $index — pull down to refresh',
                    style: const TextStyle(
                      color: Color(0xFF0D47A1),
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()) '
            'lets RefreshIndicator detect the pull gesture even when the '
            'list has too few items to overflow its viewport. Without '
            'Always, RefreshIndicator would never fire.',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 12.5,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );

  // Recipe 5b: fixed-extent snapping page.
  final Widget recipeSnap = Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFF00695C), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Recipe: month picker with FixedExtentScrollPhysics',
          style: TextStyle(
            color: Color(0xFF00695C),
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 140,
          child: ListWheelScrollView(
            itemExtent: 38,
            physics: const FixedExtentScrollPhysics(),
            diameterRatio: 1.5,
            children: <Widget>[
              for (final String m in const <String>[
                'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
                'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
              ])
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00695C).withOpacity(0.08),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    m,
                    style: const TextStyle(
                      color: Color(0xFF00695C),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'A wheel picker is just a ListWheelScrollView with '
          'FixedExtentScrollPhysics. The physics ballistic simulation ends '
          'on an integer item index — every fling settles on Jan, Feb, ...',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 12.5,
            height: 1.35,
          ),
        ),
      ],
    ),
  );

  // Recipe 5c: locked panel via Never.
  final Widget recipeLocked = Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFC62828), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Recipe: locked inner panel (NeverScrollableScrollPhysics)',
          style: TextStyle(
            color: Color(0xFFC62828),
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 160,
          child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 6,
            itemBuilder: (BuildContext ctx, int index) {
              return Container(
                height: 24,
                margin: const EdgeInsets.symmetric(vertical: 2),
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFC62828).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(4),
                ),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Locked row $index',
                  style: const TextStyle(
                    color: Color(0xFFB71C1C),
                    fontWeight: FontWeight.w700,
                    fontSize: 12,
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Place a NeverScrollableScrollPhysics list inside a '
          'SingleChildScrollView when you want the outer scrollable to be '
          'the only one consuming vertical gestures. Combine with '
          'shrinkWrap: true so the inner list reports its full intrinsic '
          'height.',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 12.5,
            height: 1.35,
          ),
        ),
      ],
    ),
  );

  // Recipe 5d: always-scrollable empty list (Always without parent).
  final Widget recipeEmpty = Container(
    margin: const EdgeInsets.symmetric(vertical: 8),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: const Color(0xFFEF6C00), width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Text(
          'Recipe: always-scrollable empty list',
          style: TextStyle(
            color: Color(0xFFEF6C00),
            fontSize: 13.5,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 130,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(8),
            children: const <Widget>[
              SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    'No data yet — pull to refresh',
                    style: TextStyle(
                      color: Color(0xFFEF6C00),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'AlwaysScrollableScrollPhysics with no parent inherits the '
          'platform default via ScrollConfiguration. The empty-state list '
          'remains scrollable so the user can still pull to refresh.',
          style: TextStyle(
            color: Color(0xFF333333),
            fontSize: 12.5,
            height: 1.35,
          ),
        ),
      ],
    ),
  );

  final List<Widget> recipes = <Widget>[
    const _SectionTitle(
      label: 'Recipes — proven physics combinations',
      subtitle:
          'Patterns that appear in production apps and would be hard to '
          'reinvent from scratch.',
      icon: Icons.menu_book_outlined,
      color: Color(0xFF1565C0),
    ),
    recipeRefresh,
    recipeSnap,
    recipeLocked,
    recipeEmpty,
  ];

  // --------------------------------------------------------------------------
  // SECTION 6 — Tolerance illustration.
  // --------------------------------------------------------------------------
  print('=== Section 6: Tolerance ===');

  final List<Widget> toleranceSection = <Widget>[
    const _SectionTitle(
      label: 'Tolerance — when is "close enough"?',
      subtitle:
          'The thresholds used to decide that a simulation has come to '
          'rest. Subclasses override tolerance when their behaviour needs '
          'a different feel.',
      icon: Icons.precision_manufacturing,
      color: Color(0xFF455A64),
    ),
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF455A64).withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF455A64).withOpacity(0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          _MonoLine(
            text: 'Tolerance.defaultTolerance ~ Tolerance(',
            color: Color(0xFF263238),
          ),
          _MonoLine(
            text: '  velocity: 1 / (0.050 * physicalPixelsPerLogicalPixel),',
            color: Color(0xFF263238),
          ),
          _MonoLine(
            text: '  distance: 1 / physicalPixelsPerLogicalPixel,',
            color: Color(0xFF263238),
          ),
          _MonoLine(
            text: '  time:     0.001,',
            color: Color(0xFF263238),
          ),
          _MonoLine(
            text: ')',
            color: Color(0xFF263238),
          ),
        ],
      ),
    ),
    const _LabeledCard(
      title: 'velocity threshold',
      icon: Icons.speed,
      accent: Color(0xFF455A64),
      body:
          'If |dx/dt| < tolerance.velocity, the simulation is considered '
          'stopped. About 0.05 logical pixels per millisecond on a 1x '
          'device — small enough that the user sees a smooth halt but '
          'large enough that the simulation does not run forever.',
    ),
    const _LabeledCard(
      title: 'distance threshold',
      icon: Icons.straighten,
      accent: Color(0xFF607D8B),
      body:
          'If the remaining distance to the target is below '
          'tolerance.distance the simulation is done. Wheel pickers '
          'tighten this to land cleanly on an item index, while bouncy '
          'physics often relax it slightly to avoid jitter at rest.',
    ),
    const _LabeledCard(
      title: 'time threshold',
      icon: Icons.timer,
      accent: Color(0xFF78909C),
      body:
          'A guard against infinite-loop simulations. 0.001 seconds is the '
          'practical lower bound for ticker time deltas.',
    ),
  ];

  // --------------------------------------------------------------------------
  // SECTION 7 — Simulation curve panel.
  // --------------------------------------------------------------------------
  print('=== Section 7: Simulation curves ===');

  // We construct real Simulation objects here to show their declared
  // tolerance values, but we do not animate them — we render the values
  // as text so the file stays Stateless and analyzer-clean.
  final ClampingScrollSimulation clampSim = ClampingScrollSimulation(
    position: 0.0,
    velocity: 600.0,
    tolerance: const Tolerance(
      velocity: 0.05,
      distance: 0.01,
      time: 0.001,
    ),
  );

  final BouncingScrollSimulation bounceSim = BouncingScrollSimulation(
    position: 0.0,
    velocity: 600.0,
    leadingExtent: 0.0,
    trailingExtent: 1000.0,
    spring: SpringDescription.withDampingRatio(
      mass: 0.5,
      stiffness: 100.0,
      ratio: 1.1,
    ),
    tolerance: const Tolerance(
      velocity: 0.05,
      distance: 0.01,
      time: 0.001,
    ),
  );

  final List<Widget> simulationSection = <Widget>[
    const _SectionTitle(
      label: 'Simulation curves',
      subtitle:
          'The simulations returned by createBallisticSimulation. We show '
          'the constructor parameters; the AST runner does not animate, '
          'so the visualisation here is a static breakdown.',
      icon: Icons.show_chart,
      color: Color(0xFF6D4C41),
    ),
    Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3E0),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF6D4C41).withOpacity(0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'ClampingScrollSimulation',
            style: TextStyle(
              color: Color(0xFF6D4C41),
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          _MonoLine(
            text: 'position : ${clampSim.x(0.0).toStringAsFixed(2)}',
          ),
          _MonoLine(
            text: 'velocity : ${clampSim.dx(0.0).toStringAsFixed(2)}',
          ),
          _MonoLine(
            text: 'tolerance.velocity : '
                '${clampSim.tolerance.velocity.toStringAsFixed(3)}',
          ),
          _MonoLine(
            text: 'tolerance.distance : '
                '${clampSim.tolerance.distance.toStringAsFixed(3)}',
          ),
          const SizedBox(height: 6),
          const Text(
            'Models friction-decelerated motion: x(t) decays from the '
            'initial velocity toward zero. Used by Android-style '
            'ClampingScrollPhysics.',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 12.5,
              height: 1.35,
            ),
          ),
        ],
      ),
    ),
    Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFFCE4EC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFAD1457).withOpacity(0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'BouncingScrollSimulation',
            style: TextStyle(
              color: Color(0xFFAD1457),
              fontSize: 13.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          _MonoLine(
            text: 'position : ${bounceSim.x(0.0).toStringAsFixed(2)}',
            color: const Color(0xFFAD1457),
          ),
          _MonoLine(
            text: 'velocity : ${bounceSim.dx(0.0).toStringAsFixed(2)}',
            color: const Color(0xFFAD1457),
          ),
          _MonoLine(
            text: 'tolerance.velocity : '
                '${bounceSim.tolerance.velocity.toStringAsFixed(3)}',
            color: const Color(0xFFAD1457),
          ),
          _MonoLine(
            text: 'tolerance.distance : '
                '${bounceSim.tolerance.distance.toStringAsFixed(3)}',
            color: const Color(0xFFAD1457),
          ),
          const SizedBox(height: 6),
          const Text(
            'Internally switches between a FrictionSimulation (inside the '
            'scroll range) and a SpringSimulation (when the user pulls past '
            'the bound). This is what produces the iOS rubber-band feel.',
            style: TextStyle(
              color: Color(0xFF333333),
              fontSize: 12.5,
              height: 1.35,
            ),
          ),
        ],
      ),
    ),
    const _LabeledCard(
      title: 'SpringDescription',
      icon: Icons.linear_scale,
      accent: Color(0xFF6D4C41),
      body:
          'BouncingScrollSimulation needs a SpringDescription to model the '
          'return motion. mass / stiffness / damping ratio map directly to '
          'a critically-damped, under-damped, or over-damped system. '
          'Flutter uses a slightly over-damped spring (ratio ~ 1.1) so the '
          'bounce never overshoots in a distracting way.',
    ),
  ];

  // --------------------------------------------------------------------------
  // SECTION 8 — Pitfalls.
  // --------------------------------------------------------------------------
  print('=== Section 8: Pitfalls ===');

  final List<Widget> pitfalls = <Widget>[
    const _SectionTitle(
      label: 'Pitfalls — the easy mistakes',
      subtitle: 'Real bugs that show up in code reviews and never reproduce '
          'until somebody changes platform or content size.',
      icon: Icons.warning_amber,
      color: Color(0xFFEF6C00),
    ),
    const _LabeledCard(
      title: 'AlwaysScrollableScrollPhysics() alone is rarely correct',
      icon: Icons.error_outline,
      accent: Color(0xFFEF6C00),
      body:
          'On its own, Always supplies only the "shouldAcceptUserOffset -> '
          'true" behaviour and otherwise falls back to ScrollPhysics() '
          'defaults. The result is a scrollable that allows overscroll in '
          'a way that does not match the platform. Wrap it with a real '
          'parent: AlwaysScrollableScrollPhysics(parent: '
          'BouncingScrollPhysics()) — or ClampingScrollPhysics on Android.',
    ),
    const _LabeledCard(
      title: 'NeverScrollableScrollPhysics is final',
      icon: Icons.block,
      accent: Color(0xFFEF6C00),
      body:
          'Never is not just "currently disabled". It rejects ALL user '
          'offsets, regardless of parent. There is no way to "toggle it on" '
          'via the parent chain. To enable/disable scrolling dynamically '
          'you must rebuild with a different physics instance — but that '
          'requires a Stateful host. For static lock-down, Never is the '
          'right choice.',
    ),
    const _LabeledCard(
      title: 'ClampingScrollPhysics + RefreshIndicator on a short list',
      icon: Icons.report_problem,
      accent: Color(0xFFFF8F00),
      body:
          'If your list is shorter than the viewport and you use '
          'ClampingScrollPhysics directly, RefreshIndicator never fires '
          'because the list refuses to overscroll. Wrap with '
          'AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()).',
    ),
    const _LabeledCard(
      title: 'FixedExtentScrollPhysics requires fixed-extent children',
      icon: Icons.straighten,
      accent: Color(0xFFFFA000),
      body:
          'FixedExtentScrollPhysics divides the offset by an item extent. '
          'If your items have variable heights, snapping math breaks. '
          'Reserved for ListWheelScrollView and similar widgets that '
          'declare a single itemExtent.',
    ),
    const _LabeledCard(
      title: 'PageScrollPhysics does not control the page extent',
      icon: Icons.swipe,
      accent: Color(0xFFEF6C00),
      body:
          'PageScrollPhysics decides where to snap, but the page width '
          'comes from the PageView viewport (or the PageController '
          'viewportFraction). Forgetting that, developers sometimes assume '
          'changing the physics will resize the page — it will not.',
    ),
    const _LabeledCard(
      title: 'RangeMaintainingScrollPhysics needs a stable position',
      icon: Icons.architecture,
      accent: Color(0xFFFF6F00),
      body:
          'It only "maintains" if the scroll position survives the rebuild. '
          'If you also recreate the ScrollController on every build, you '
          'will reset the position before the physics can preserve it.',
    ),
  ];

  // --------------------------------------------------------------------------
  // SECTION 9 — Glossary.
  // --------------------------------------------------------------------------
  print('=== Section 9: Glossary ===');

  final List<Widget> glossary = <Widget>[
    const _SectionTitle(
      label: 'Glossary',
      subtitle: 'Vocabulary you will see in the ScrollPhysics source.',
      icon: Icons.translate,
      color: Color(0xFF455A64),
    ),
    const _LabeledCard(
      title: 'Scrollable',
      icon: Icons.list,
      accent: Color(0xFF455A64),
      body:
          'The widget that hosts a scroll view. Owns a ScrollPosition and '
          'consults its ScrollPhysics for every gesture.',
    ),
    const _LabeledCard(
      title: 'ScrollPosition',
      icon: Icons.linear_scale,
      accent: Color(0xFF607D8B),
      body:
          'The mutable state for a scroll view. Holds pixels, '
          'minScrollExtent, maxScrollExtent, viewportDimension, and '
          'userScrollDirection. ScrollPhysics methods receive a snapshot '
          'of this via the ScrollMetrics interface.',
    ),
    const _LabeledCard(
      title: 'ScrollMetrics',
      icon: Icons.straighten,
      accent: Color(0xFF78909C),
      body:
          'Read-only view of a ScrollPosition. Passed to ScrollPhysics '
          'methods so they cannot accidentally mutate the position.',
    ),
    const _LabeledCard(
      title: 'Simulation',
      icon: Icons.timeline,
      accent: Color(0xFF455A64),
      body:
          'An object with x(t), dx(t), and isDone(t). Drives the post-fling '
          'motion of a Scrollable. ScrollPhysics produces one via '
          'createBallisticSimulation.',
    ),
    const _LabeledCard(
      title: 'ScrollConfiguration',
      icon: Icons.settings_applications,
      accent: Color(0xFF607D8B),
      body:
          'InheritedWidget that supplies platform-aware defaults: physics, '
          'glow color, scrollbar visibility. ScrollPhysics() with no '
          'platform-specific parent will be wrapped by this configuration '
          'when null is passed to a Scrollable.',
    ),
    const _LabeledCard(
      title: 'parent (in ScrollPhysics)',
      icon: Icons.account_tree,
      accent: Color(0xFF78909C),
      body:
          'Each ScrollPhysics may wrap another. Methods are usually '
          'delegated up the chain unless the subclass overrides the '
          'specific decision. applyTo() is the canonical way to chain.',
    ),
    const _LabeledCard(
      title: 'overscroll',
      icon: Icons.unfold_more,
      accent: Color(0xFF455A64),
      body:
          'The portion of a drag that would take the position outside '
          '[minScrollExtent, maxScrollExtent]. How a physics class handles '
          'overscroll is what makes it Bouncing vs Clamping vs Never.',
    ),
    const _LabeledCard(
      title: 'fling',
      icon: Icons.swipe,
      accent: Color(0xFF607D8B),
      body:
          'A drag that ends with non-zero velocity. ScrollPhysics responds '
          'by creating a ballistic simulation that carries the position '
          'forward under inertia (and possibly bounce).',
    ),
  ];

  // --------------------------------------------------------------------------
  // SECTION 10 — Recap.
  // --------------------------------------------------------------------------
  print('=== Section 10: Recap ===');

  final List<Widget> recap = <Widget>[
    const _SectionTitle(
      label: 'Recap',
      subtitle: 'The single take-home table for the whole family.',
      icon: Icons.summarize,
      color: Color(0xFF3949AB),
    ),
    Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF3949AB).withOpacity(0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'Choosing a ScrollPhysics',
            style: TextStyle(
              color: Color(0xFF3949AB),
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 8),
          _MonoLine(
            text: 'BouncingScrollPhysics       -> iOS look + feel',
            color: Color(0xFFAD1457),
          ),
          _MonoLine(
            text: 'ClampingScrollPhysics       -> Android look + feel',
            color: Color(0xFF2E7D32),
          ),
          _MonoLine(
            text: 'AlwaysScrollableScrollPhysics(parent: ...) -> refresh',
            color: Color(0xFFEF6C00),
          ),
          _MonoLine(
            text: 'NeverScrollableScrollPhysics -> fully lock a panel',
            color: Color(0xFFC62828),
          ),
          _MonoLine(
            text: 'PageScrollPhysics           -> PageView snap',
            color: Color(0xFF1565C0),
          ),
          _MonoLine(
            text: 'RangeMaintainingScrollPhysics -> preserve on resize',
            color: Color(0xFF6A1B9A),
          ),
          _MonoLine(
            text: 'FixedExtentScrollPhysics    -> ListWheelScrollView snap',
            color: Color(0xFF00695C),
          ),
        ],
      ),
    ),
    const _LabeledCard(
      title: 'Rule of thumb',
      icon: Icons.lightbulb,
      accent: Color(0xFF3949AB),
      body:
          'Reach for ScrollConfiguration defaults first. Wrap with '
          'AlwaysScrollableScrollPhysics(parent: ...) when you need '
          'pull-to-refresh on short content. Reach for NeverScrollable '
          'only for permanently locked panels. Custom subclasses are '
          'rarely needed — composition via parent is almost always '
          'enough.',
    ),
    const _LabeledCard(
      title: 'How to think about the family',
      icon: Icons.psychology_alt,
      accent: Color(0xFF1A237E),
      body:
          'BouncingScrollPhysics and ClampingScrollPhysics define the FEEL. '
          'AlwaysScrollableScrollPhysics and NeverScrollableScrollPhysics '
          'define the GATE. PageScrollPhysics, FixedExtentScrollPhysics, '
          'and RangeMaintainingScrollPhysics define a TARGET — where the '
          'position should land. Compose feel x gate x target via the '
          'parent chain.',
    ),
  ];

  // --------------------------------------------------------------------------
  // FINAL ASSEMBLY
  // --------------------------------------------------------------------------
  print('=== Final assembly ===');

  final List<Widget> all = <Widget>[
    Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: <Color>[Color(0xFF1A237E), Color(0xFF3949AB)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF1A237E).withOpacity(0.35),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text(
            'ScrollPhysics — Deep Visual Demo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.4,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'A hand-authored, analyzer-clean walkthrough of the '
            'ScrollPhysics class hierarchy: anatomy, live demos for each '
            'subclass, an overscroll comparison panel, recipes, a '
            'Tolerance illustration, simulation curves, pitfalls, a '
            'glossary, and a recap.',
            style: TextStyle(
              color: Colors.white,
              fontSize: 13.5,
              height: 1.4,
            ),
          ),
        ],
      ),
    ),
    ...dossier,
    ...anatomy,
    ...liveDemos,
    ...comparison,
    ...recipes,
    ...toleranceSection,
    ...simulationSection,
    ...pitfalls,
    ...glossary,
    ...recap,
    Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 18, bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8EAF6),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF3949AB).withOpacity(0.55)),
      ),
      child: const Text(
        'End of demo. The ScrollPhysics family is small but composable: '
        'feel x gate x target. Master the parent chain and you can build '
        'every standard scroll behaviour in Flutter without ever writing '
        'a custom subclass.',
        style: TextStyle(
          color: Color(0xFF1A237E),
          fontSize: 13,
          height: 1.4,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ];

  // Sanity print for the AST runner trail.
  print('Sections rendered: dossier=${dossier.length}, '
      'anatomy=${anatomy.length}, demos=${liveDemos.length}, '
      'comparison=${comparison.length}, recipes=${recipes.length}, '
      'tolerance=${toleranceSection.length}, '
      'simulation=${simulationSection.length}, '
      'pitfalls=${pitfalls.length}, glossary=${glossary.length}, '
      'recap=${recap.length}, total=${all.length}');

  // Touch the math import so it is not unused even if the
  // unnecessary_import lint flips on us.
  final double safeReference = math.pi * 0.0; // referenced; always 0.
  if (safeReference > 1.0) {
    print('Impossible branch — math reference only.');
  }

  // Touch the foundation import so it is not unused either.
  final TargetPlatform platform = defaultTargetPlatform;
  if (platform == TargetPlatform.fuchsia &&
      platform == TargetPlatform.iOS) {
    print('Impossible branch — platform reference only.');
  }

  return ListView(
    padding: const EdgeInsets.all(16),
    physics: const AlwaysScrollableScrollPhysics(
      parent: BouncingScrollPhysics(),
    ),
    children: all,
  );
}
