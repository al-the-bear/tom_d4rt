// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt deep visual demo: ClampedSimulation showcase.
//
// Theme: "Pendulum Brass" — a warm parchment backdrop layered with brass,
// burnished copper, deep midnight, and verdigris band rails. The palette
// evokes a brass orrery: precise, mechanical, but bound by hand-tuned stops.
//
// Why a "pendulum" feel for ClampedSimulation? Because the wrapper's job is
// to take any swinging trajectory the underlying Simulation produces and to
// pin its excursion inside a band — the way a pendulum's clock case stops
// the bob from sweeping further than the chime allows. Every visual in this
// demo is built around that band metaphor: rails on either side, ghost
// curves that overshoot, and the clamped curve that hugs the rails when it
// would otherwise burst through.
//
// Section plan (use this as a reading map):
//   A. Header card                                    — title and theme
//   B. Palette table + swatches                       — Pendulum Brass hues
//   C. ClampedSimulation API surface                  — constructors, fields
//   D. The clamping arithmetic (clamp vs saturate)    — instructive prose
//   E. Trajectory strips for four base simulations    — gravity, friction,
//                                                       scrollspring, bouncing
//   F. Before-vs-after two-column comparison          — raw vs clamped bars
//   G. Clamp diagram                                  — band rails vs curves
//   H. isDone propagation rule card                   — propagation diagram
//   I. Tolerance accessor card                        — note on inheritance
//   J. Sampling table                                 — t in {0.0..2.0}
//   K. Pitfalls card                                  — 6 named pitfalls
//   L. Decision flowchart                             — when to reach for it
//   M. Code snippets card                             — 5 monospace snippets
//   N. Comparison vs alternative wrappers             — saturate, lerp, etc.
//   O. Glossary                                       — domain vocabulary
//   P. Footer recap                                   — counters and summary
//
// Strict snapshot rules: no setState, no controllers, no streams, no timers.
// All animations (none of which actually tick) would be Duration.zero or
// AlwaysStoppedAnimation. Imports are pinned to material.dart and
// physics.dart only. No top-level helper classes; data is inlined as const
// or local lists. Every visual is a Container/Row/Column/Text composition.

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

dynamic build(BuildContext context) {
  print('ClampedSimulation deep visual demo executing');

  // ============================================================
  // A. Palette: "Pendulum Brass"
  // ============================================================
  // Backdrops are warm-parchment and deep midnight. Brass and copper carry
  // the actionable lines (the inner simulation, the clamped output).
  // Verdigris marks the band rails. Ink-text on parchment, gold-text on
  // midnight panels — both legible.
  final Color parchment = Color(0xFFF4E7C9);
  final Color parchmentDeep = Color(0xFFE9D6A6);
  final Color midnight = Color(0xFF1A1722);
  final Color midnightSoft = Color(0xFF2A2434);
  final Color brass = Color(0xFFC9A45C);
  final Color brassBright = Color(0xFFE6C271);
  final Color copper = Color(0xFFB46A3C);
  final Color copperGlow = Color(0xFFD68A55);
  final Color verdigris = Color(0xFF4F8B7A);
  final Color verdigrisSoft = Color(0xFF7FB1A2);
  final Color carmineWarn = Color(0xFFB2424A);
  final Color inkText = Color(0xFF1F1A12);
  final Color inkMuted = Color(0xFF5C4A2C);
  final Color goldText = Color(0xFFF1DDA8);
  final Color goldMuted = Color(0xFFB59C68);

  print('Palette assembled: 14 hues for Pendulum Brass.');

  // ============================================================
  // The four base simulations we'll wrap with ClampedSimulation.
  // ============================================================

  // 1) Gravity — particle with constant acceleration. Will overshoot the
  //    upper rail in our chosen band. Good "rises high" demo.
  final GravitySimulation gravity = GravitySimulation(
    18.0, // acceleration (pixels per second per second)
    0.0, // initial position
    400.0, // end-distance threshold
    8.0, // initial velocity (upward in math sense, positive)
  );

  // 2) Friction — drag-decelerated particle. Asymptotes at finalX.
  final FrictionSimulation friction = FrictionSimulation(
    0.135, // drag coefficient (similar to UIKit defaults)
    20.0, // initial position
    180.0, // initial velocity
  );

  // 3) ScrollSpringSimulation — critically damped scroll snap.
  final SpringDescription scrollSpring = SpringDescription(
    mass: 0.5,
    stiffness: 100.0,
    damping: 1.0,
  );
  final ScrollSpringSimulation scrollSimulation = ScrollSpringSimulation(
    scrollSpring,
    0.0, // start
    300.0, // end (above clamp band)
    0.0, // velocity
  );

  // 4) BouncingScrollSimulation — iOS-style overscroll bounce.
  final SpringDescription bounceSpring = SpringDescription.withDampingRatio(
    mass: 0.5,
    stiffness: 100.0,
    ratio: 1.1,
  );
  final BouncingScrollSimulation bouncing = BouncingScrollSimulation(
    position: 0.0,
    velocity: 200.0,
    leadingExtent: -100.0,
    trailingExtent: 250.0,
    spring: bounceSpring,
  );

  // ============================================================
  // The four ClampedSimulation wrappers. Each pins x to a different band
  // and most pin dx to a band as well, to demonstrate the full surface.
  // ============================================================
  final ClampedSimulation clampedGravity = ClampedSimulation(
    gravity,
    xMin: -50.0,
    xMax: 60.0,
    dxMin: -200.0,
    dxMax: 50.0,
  );
  final ClampedSimulation clampedFriction = ClampedSimulation(
    friction,
    xMin: 0.0,
    xMax: 120.0,
    dxMin: 0.0,
    dxMax: 200.0,
  );
  final ClampedSimulation clampedScroll = ClampedSimulation(
    scrollSimulation,
    xMin: 0.0,
    xMax: 200.0,
  );
  final ClampedSimulation clampedBouncing = ClampedSimulation(
    bouncing,
    xMin: 0.0,
    xMax: 220.0,
    dxMin: -300.0,
    dxMax: 300.0,
  );

  // ============================================================
  // The sample times across which we'll probe each simulation.
  // ============================================================
  final List<double> sampleTimes = <double>[0.0, 0.1, 0.25, 0.5, 1.0, 2.0];

  // ============================================================
  // Helper: produce a "trajectory strip" — a Row of cells, each cell's
  // width based on x(t) and color based on |dx(t)|. We inline this rather
  // than declaring a top-level helper.
  // ============================================================
  // (Defined as a local lambda via a List<Widget> constructor below.)

  // ============================================================
  // A. Header card
  // ============================================================
  final Widget headerCard = Container(
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[midnight, midnightSoft, copper],
      ),
      border: Border.all(color: brass, width: 1.6),
      borderRadius: BorderRadius.all(Radius.circular(14.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'ClampedSimulation — Pendulum Brass edition',
          style: TextStyle(
            color: goldText,
            fontSize: 22.0,
            fontWeight: FontWeight.w800,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'A hand-painted snapshot tour of ClampedSimulation. We wrap four '
          'base simulations — GravitySimulation, FrictionSimulation, '
          'ScrollSpringSimulation, BouncingScrollSimulation — sample x(t) '
          'and dx(t) at six time points each, and render the band-pinned '
          'trajectories beside their unclamped originals. No tickers, no '
          'futures, no controllers; only physics.',
          style: TextStyle(
            color: goldMuted,
            fontSize: 13.5,
            height: 1.45,
          ),
        ),
        SizedBox(height: 14.0),
        Row(
          children: <Widget>[
            Container(width: 14.0, height: 14.0, color: brassBright),
            SizedBox(width: 8.0),
            Text('Brass = inner simulation x(t)',
                style: TextStyle(color: goldText, fontSize: 12.0)),
            SizedBox(width: 18.0),
            Container(width: 14.0, height: 14.0, color: copperGlow),
            SizedBox(width: 8.0),
            Text('Copper = clamped output',
                style: TextStyle(color: goldText, fontSize: 12.0)),
            SizedBox(width: 18.0),
            Container(width: 14.0, height: 14.0, color: verdigrisSoft),
            SizedBox(width: 8.0),
            Text('Verdigris = band rails',
                style: TextStyle(color: goldText, fontSize: 12.0)),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // B. Palette table + swatches
  // ============================================================
  final List<List<String>> paletteRows = <List<String>>[
    <String>['Parchment',      '#F4E7C9', 'page backdrop'],
    <String>['Parchment Deep', '#E9D6A6', 'alternating row'],
    <String>['Midnight',       '#1A1722', 'panel void'],
    <String>['Midnight Soft',  '#2A2434', 'panel body'],
    <String>['Brass',          '#C9A45C', 'inner curve'],
    <String>['Brass Bright',   '#E6C271', 'inner highlight'],
    <String>['Copper',         '#B46A3C', 'clamped curve'],
    <String>['Copper Glow',    '#D68A55', 'clamped highlight'],
    <String>['Verdigris',      '#4F8B7A', 'band rail'],
    <String>['Verdigris Soft', '#7FB1A2', 'band fill'],
    <String>['Carmine Warn',   '#B2424A', 'pitfall accent'],
    <String>['Ink Text',       '#1F1A12', 'parchment text'],
    <String>['Ink Muted',      '#5C4A2C', 'parchment caption'],
    <String>['Gold Text',      '#F1DDA8', 'midnight text'],
  ];
  final List<Color> paletteHues = <Color>[
    parchment,
    parchmentDeep,
    midnight,
    midnightSoft,
    brass,
    brassBright,
    copper,
    copperGlow,
    verdigris,
    verdigrisSoft,
    carmineWarn,
    inkText,
    inkMuted,
    goldText,
  ];
  final List<Widget> paletteTableRows = <Widget>[];
  paletteTableRows.add(
    Row(
      children: <Widget>[
        SizedBox(width: 36.0),
        SizedBox(
          width: 150.0,
          child: Text(
            'Name',
            style: TextStyle(color: inkText, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          width: 90.0,
          child: Text(
            'Hex',
            style: TextStyle(color: inkText, fontWeight: FontWeight.w700),
          ),
        ),
        Expanded(
          child: Text(
            'Role',
            style: TextStyle(color: inkText, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    ),
  );
  paletteTableRows.add(SizedBox(height: 6.0));
  for (int i = 0; i < paletteRows.length; i++) {
    paletteTableRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 2.0),
        padding: EdgeInsets.all(6.0),
        color: i.isEven
            ? parchment.withValues(alpha: 0.55)
            : parchmentDeep.withValues(alpha: 0.55),
        child: Row(
          children: <Widget>[
            Container(
              width: 28.0,
              height: 18.0,
              decoration: BoxDecoration(
                color: paletteHues[i],
                border: Border.all(color: inkMuted, width: 0.6),
              ),
            ),
            SizedBox(width: 8.0),
            SizedBox(
              width: 150.0,
              child: Text(
                paletteRows[i][0],
                style: TextStyle(color: inkText, fontSize: 12.0),
              ),
            ),
            SizedBox(
              width: 90.0,
              child: Text(
                paletteRows[i][1],
                style: TextStyle(
                  color: inkMuted,
                  fontSize: 12.0,
                  fontFamily: 'monospace',
                ),
              ),
            ),
            Expanded(
              child: Text(
                paletteRows[i][2],
                style: TextStyle(color: inkMuted, fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget paletteCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: parchment,
      border: Border.all(color: brass, width: 1.4),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Palette: Pendulum Brass',
          style: TextStyle(
            color: inkText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Fourteen hues, organised so band-rails (verdigris) read cooly '
          'against brass and copper while ink stays legible on parchment.',
          style: TextStyle(color: inkMuted, fontSize: 12.0),
        ),
        SizedBox(height: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: paletteTableRows,
        ),
      ],
    ),
  );

  final List<Widget> swatchTiles = <Widget>[];
  for (int i = 0; i < paletteHues.length; i++) {
    swatchTiles.add(
      Container(
        margin: EdgeInsets.only(right: 6.0, bottom: 6.0),
        width: 70.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 70.0,
              height: 28.0,
              decoration: BoxDecoration(
                color: paletteHues[i],
                border: Border.all(color: inkMuted, width: 0.5),
              ),
            ),
            SizedBox(height: 3.0),
            Text(
              paletteRows[i][0],
              style: TextStyle(color: inkMuted, fontSize: 9.0),
            ),
            Text(
              paletteRows[i][1],
              style: TextStyle(
                color: inkMuted,
                fontSize: 9.0,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget swatchCard = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: parchmentDeep,
      border: Border.all(color: brass, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Swatches',
          style: TextStyle(
            color: inkText,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.0),
        Wrap(children: swatchTiles),
      ],
    ),
  );

  // ============================================================
  // C. ClampedSimulation API surface
  // ============================================================
  final List<List<String>> apiRows = <List<String>>[
    <String>[
      'ClampedSimulation(simulation, {xMin, xMax, dxMin, dxMax})',
      'ClampedSimulation',
      'Wraps any Simulation with optional position/velocity rails.',
    ],
    <String>[
      'simulation',
      'Simulation',
      'The wrapped, "inner" simulation. x/dx/isDone forward to it.',
    ],
    <String>[
      'xMin',
      'double',
      'Lower rail for x(t). Defaults to double.negativeInfinity.',
    ],
    <String>[
      'xMax',
      'double',
      'Upper rail for x(t). Defaults to double.infinity.',
    ],
    <String>[
      'dxMin',
      'double',
      'Lower rail for dx(t). Defaults to double.negativeInfinity.',
    ],
    <String>[
      'dxMax',
      'double',
      'Upper rail for dx(t). Defaults to double.infinity.',
    ],
    <String>[
      'x(double t)',
      'double',
      'clampDouble(simulation.x(t), xMin, xMax).',
    ],
    <String>[
      'dx(double t)',
      'double',
      'clampDouble(simulation.dx(t), dxMin, dxMax).',
    ],
    <String>[
      'isDone(double t)',
      'bool',
      'Forwarded unchanged from the inner simulation.',
    ],
    <String>[
      'tolerance',
      'Tolerance',
      'Inherited from Simulation; not overridden by the wrapper.',
    ],
    <String>[
      'toString()',
      'String',
      'Reports the inner simulation, x range, and dx range.',
    ],
  ];
  final List<Widget> apiTableChildren = <Widget>[];
  apiTableChildren.add(
    Container(
      padding: EdgeInsets.all(8.0),
      color: midnightSoft,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 280.0,
            child: Text(
              'Member',
              style: TextStyle(color: goldText, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            width: 160.0,
            child: Text(
              'Returns',
              style: TextStyle(color: goldText, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            child: Text(
              'Notes',
              style: TextStyle(color: goldText, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    ),
  );
  for (int i = 0; i < apiRows.length; i++) {
    apiTableChildren.add(
      Container(
        padding: EdgeInsets.all(8.0),
        color: i.isEven ? midnight : midnightSoft.withValues(alpha: 0.7),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 280.0,
              child: Text(
                apiRows[i][0],
                style: TextStyle(
                  color: brassBright,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(
              width: 160.0,
              child: Text(
                apiRows[i][1],
                style: TextStyle(
                  color: goldText,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                apiRows[i][2],
                style: TextStyle(color: goldMuted, fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget apiCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: midnight,
      border: Border.all(color: brass, width: 1.4),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'API surface: ClampedSimulation members',
          style: TextStyle(
            color: goldText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'The whole class is little more than four numeric rails plus three '
          'forwarding methods. The simplicity is the point — every clamp '
          'happens at output time, never at construction time.',
          style: TextStyle(color: goldMuted, fontSize: 12.0),
        ),
        SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: apiTableChildren,
        ),
      ],
    ),
  );

  // ============================================================
  // D. The clamping arithmetic — instructive prose
  // ============================================================
  const String prose1 =
      'Clamping, in the strict mathematical sense, is the function clamp(v, '
      'lo, hi) = min(hi, max(lo, v)). It bounds a value into a closed '
      'interval. ClampedSimulation applies this at every call to x(t) and '
      'dx(t), using xMin/xMax for position and dxMin/dxMax for velocity. '
      'The wrapped simulation is never modified — its own state evolves as '
      'if no clamp existed; only the *reported* values are cropped at the '
      'rail.';
  const String prose2 =
      'This means the velocity dx(t) reported by ClampedSimulation can be '
      'inconsistent with the rate of change of x(t) — for the duration of a '
      'clamp event, x sits pinned to xMax while the inner velocity might '
      'still be reported as positive. The Flutter docs call this out '
      'explicitly: "the x value will change at a rate that does not match '
      'the reported dx value while one or the other is being clamped". If '
      'consistency is needed, post-process dx yourself; the wrapper does '
      'not enforce coherence between the two.';
  const String prose3 =
      'Clamp differs from saturate. Saturation wraps with a soft, often '
      'sigmoidal shoulder: as the input approaches the rail, the output '
      'curves to meet it. Clamp is hard-edged: the output equals the input '
      'until the input crosses the rail, then equals the rail exactly. '
      'Clamp also differs from modulus (which wraps round) and from '
      'reflection (which bounces). Pick clamp when you want a guarantee, '
      'and want it without easing.';
  const String prose4 =
      'Reach for ClampedSimulation when you have a perfectly good inner '
      'simulation that you can\'t modify in place, but you must guarantee '
      'safe ranges — usually because of UI constraints (a scroll position '
      'cannot exceed the content extent), accessibility (an opacity must '
      'never exceed a max-brightness setting), or hardware limits (a haptic '
      'amplitude cannot push past the actuator\'s rated peak).';
  final Widget proseCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: parchment,
      border: Border.all(color: brass, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'The arithmetic of clamping',
          style: TextStyle(
            color: inkText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.0),
        Text(prose1,
            style: TextStyle(color: inkText, fontSize: 13.0, height: 1.45)),
        SizedBox(height: 10.0),
        Text(prose2,
            style: TextStyle(color: inkText, fontSize: 13.0, height: 1.45)),
        SizedBox(height: 10.0),
        Text(prose3,
            style: TextStyle(color: inkText, fontSize: 13.0, height: 1.45)),
        SizedBox(height: 10.0),
        Text(prose4,
            style: TextStyle(
              color: copper,
              fontSize: 13.0,
              height: 1.45,
              fontStyle: FontStyle.italic,
            )),
      ],
    ),
  );

  // ============================================================
  // E. Trajectory strips for four base simulations.
  // For each (label, inner, clamped) we render a Row of cells where each
  // cell width corresponds to abs(x(t)) and color depth to abs(dx(t)).
  // ============================================================
  final List<List<dynamic>> trajectoryDefs = <List<dynamic>>[
    <dynamic>['Gravity (raw)',          gravity,         brass,       false],
    <dynamic>['Gravity (clamped)',      clampedGravity,  copperGlow,  true],
    <dynamic>['Friction (raw)',         friction,        brass,       false],
    <dynamic>['Friction (clamped)',     clampedFriction, copperGlow,  true],
    <dynamic>['ScrollSpring (raw)',     scrollSimulation, brass,      false],
    <dynamic>['ScrollSpring (clamped)', clampedScroll,   copperGlow,  true],
    <dynamic>['Bouncing (raw)',         bouncing,        brass,       false],
    <dynamic>['Bouncing (clamped)',     clampedBouncing, copperGlow,  true],
  ];

  // Compute the max absolute x across all sims and times so cell widths
  // share a single scale.
  double maxAbsX = 1.0;
  double maxAbsDx = 1.0;
  for (int s = 0; s < trajectoryDefs.length; s++) {
    final Simulation sim = trajectoryDefs[s][1] as Simulation;
    for (int ti = 0; ti < sampleTimes.length; ti++) {
      final double t = sampleTimes[ti];
      final double xv = sim.x(t).abs();
      final double dxv = sim.dx(t).abs();
      if (xv > maxAbsX) maxAbsX = xv;
      if (dxv > maxAbsDx) maxAbsDx = dxv;
    }
  }
  print('Trajectory scale: maxAbsX=$maxAbsX maxAbsDx=$maxAbsDx');

  final List<Widget> trajectoryWidgets = <Widget>[];
  for (int s = 0; s < trajectoryDefs.length; s++) {
    final String label = trajectoryDefs[s][0] as String;
    final Simulation sim = trajectoryDefs[s][1] as Simulation;
    final Color baseHue = trajectoryDefs[s][2] as Color;
    final bool isClamped = trajectoryDefs[s][3] as bool;

    final List<Widget> cells = <Widget>[];
    for (int ti = 0; ti < sampleTimes.length; ti++) {
      final double t = sampleTimes[ti];
      double xv;
      double dxv;
      bool done;
      try {
        xv = sim.x(t);
        dxv = sim.dx(t);
        done = sim.isDone(t);
      } catch (e) {
        print('Sim probe error at t=$t for "$label": $e');
        xv = 0.0;
        dxv = 0.0;
        done = false;
      }
      // Cell width from |x|. Clamp the displayed width so a single unruly
      // sim doesn't blow out the layout.
      final double widthScale = (xv.abs() / maxAbsX).clamp(0.04, 1.0);
      final double cellWidth = 12.0 + 56.0 * widthScale;
      // Color saturation from |dx|: deeper color = faster.
      final double speedScale = (dxv.abs() / maxAbsDx).clamp(0.0, 1.0);
      final Color cellHue = Color.lerp(
        baseHue.withValues(alpha: 0.30),
        baseHue,
        speedScale,
      )!;
      cells.add(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: cellWidth,
                height: 28.0,
                decoration: BoxDecoration(
                  color: cellHue,
                  border: Border.all(
                    color: done ? carmineWarn : inkMuted.withValues(alpha: 0.4),
                    width: done ? 1.4 : 0.6,
                  ),
                ),
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text(
                  't=${t.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: inkText,
                    fontSize: 9.0,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                'x=${xv.toStringAsFixed(1)}',
                style: TextStyle(
                  color: inkText,
                  fontSize: 9.0,
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                'dx=${dxv.toStringAsFixed(1)}',
                style: TextStyle(
                  color: inkMuted,
                  fontSize: 9.0,
                  fontFamily: 'monospace',
                ),
              ),
              if (done)
                Text(
                  'done',
                  style: TextStyle(
                    color: carmineWarn,
                    fontSize: 9.0,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
        ),
      );
    }

    trajectoryWidgets.add(
      Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: isClamped
              ? parchmentDeep
              : parchment.withValues(alpha: 0.85),
          border: Border.all(
            color: isClamped ? copper : brass,
            width: isClamped ? 1.4 : 1.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 10.0,
                  height: 10.0,
                  color: isClamped ? copper : brass,
                ),
                SizedBox(width: 8.0),
                Text(
                  label,
                  style: TextStyle(
                    color: inkText,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.0,
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: cells,
            ),
          ],
        ),
      ),
    );
  }
  final Widget trajectoryCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: parchment,
      border: Border.all(color: brass, width: 1.4),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Trajectory strips: four base sims, raw and clamped',
          style: TextStyle(
            color: inkText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each cell\'s width tracks |x(t)|; deeper colour means a larger '
          '|dx(t)|. A carmine outline marks isDone(t) == true. Compare each '
          '"raw" row with the "clamped" row directly beneath to see where '
          'the rails take effect.',
          style: TextStyle(color: inkMuted, fontSize: 12.0),
        ),
        SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: trajectoryWidgets,
        ),
      ],
    ),
  );

  // ============================================================
  // F. Before-vs-after two-column comparison.
  // For each base sim, two side-by-side bars whose lengths show actual x(t).
  // ============================================================
  final List<List<dynamic>> compareDefs = <List<dynamic>>[
    <dynamic>['Gravity',         gravity,          clampedGravity,
              -50.0, 60.0],
    <dynamic>['Friction',        friction,         clampedFriction,
              0.0,   120.0],
    <dynamic>['ScrollSpring',    scrollSimulation, clampedScroll,
              0.0,   200.0],
    <dynamic>['Bouncing',        bouncing,         clampedBouncing,
              0.0,   220.0],
  ];
  // Common bar scale: a logical 220px wide region per column.
  const double barColWidth = 220.0;
  // Pick a global x-window for visual scaling.
  final double globalXSpan = 400.0;

  final List<Widget> compareWidgets = <Widget>[];
  // Header row.
  compareWidgets.add(
    Padding(
      padding: EdgeInsets.only(bottom: 6.0),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 90.0,
            child: Text(
              'Sim',
              style: TextStyle(color: inkText, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            width: 36.0,
            child: Text(
              't',
              style: TextStyle(color: inkText, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            width: barColWidth,
            child: Text(
              'raw x(t)',
              style: TextStyle(color: inkText, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(width: 8.0),
          SizedBox(
            width: barColWidth,
            child: Text(
              'clamped x(t)',
              style: TextStyle(color: inkText, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    ),
  );
  for (int c = 0; c < compareDefs.length; c++) {
    final String label = compareDefs[c][0] as String;
    final Simulation rawSim = compareDefs[c][1] as Simulation;
    final Simulation clampedSim = compareDefs[c][2] as Simulation;
    final double xMin = compareDefs[c][3] as double;
    final double xMax = compareDefs[c][4] as double;
    for (int ti = 0; ti < sampleTimes.length; ti++) {
      final double t = sampleTimes[ti];
      double rawX = 0.0;
      double clampedX = 0.0;
      try {
        rawX = rawSim.x(t);
        clampedX = clampedSim.x(t);
      } catch (e) {
        print('Compare-row probe error at t=$t for $label: $e');
      }
      // Centred bar: zero is the midline.
      final double centerOffset = barColWidth / 2.0;
      final double rawBarWidth =
          (rawX.abs() / globalXSpan * (barColWidth / 2.0))
              .clamp(0.0, barColWidth / 2.0 - 1.0);
      final double clampedBarWidth =
          (clampedX.abs() / globalXSpan * (barColWidth / 2.0))
              .clamp(0.0, barColWidth / 2.0 - 1.0);
      final bool aboveMaxRaw = rawX > xMax;
      final bool belowMinRaw = rawX < xMin;
      final bool clipped = aboveMaxRaw || belowMinRaw;
      compareWidgets.add(
        Container(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: inkMuted.withValues(alpha: 0.2),
                width: 0.6,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 90.0,
                child: Text(
                  label,
                  style: TextStyle(color: inkText, fontSize: 11.0),
                ),
              ),
              SizedBox(
                width: 36.0,
                child: Text(
                  t.toStringAsFixed(2),
                  style: TextStyle(
                    color: inkMuted,
                    fontSize: 11.0,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              // raw column with centred axis
              Container(
                width: barColWidth,
                height: 18.0,
                color: parchment,
                child: Stack(
                  children: <Widget>[
                    // axis tick
                    Positioned(
                      left: centerOffset - 0.5,
                      top: 0.0,
                      bottom: 0.0,
                      width: 1.0,
                      child: Container(color: inkMuted),
                    ),
                    // bar
                    Positioned(
                      left: rawX >= 0
                          ? centerOffset
                          : centerOffset - rawBarWidth,
                      top: 3.0,
                      width: rawBarWidth,
                      height: 12.0,
                      child: Container(
                        color: clipped
                            ? brass.withValues(alpha: 0.5)
                            : brass,
                      ),
                    ),
                    if (clipped)
                      Positioned(
                        right: 4.0,
                        top: 2.0,
                        child: Text(
                          rawX > xMax ? '>xMax' : '<xMin',
                          style: TextStyle(
                            color: carmineWarn,
                            fontSize: 9.0,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(width: 8.0),
              // clamped column with centred axis
              Container(
                width: barColWidth,
                height: 18.0,
                color: parchmentDeep,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: centerOffset - 0.5,
                      top: 0.0,
                      bottom: 0.0,
                      width: 1.0,
                      child: Container(color: inkMuted),
                    ),
                    // band rails
                    Positioned(
                      left: centerOffset +
                          (xMin / globalXSpan * (barColWidth / 2.0)),
                      top: 0.0,
                      bottom: 0.0,
                      width: 1.0,
                      child: Container(color: verdigris),
                    ),
                    Positioned(
                      left: centerOffset +
                          (xMax / globalXSpan * (barColWidth / 2.0)),
                      top: 0.0,
                      bottom: 0.0,
                      width: 1.0,
                      child: Container(color: verdigris),
                    ),
                    // bar
                    Positioned(
                      left: clampedX >= 0
                          ? centerOffset
                          : centerOffset - clampedBarWidth,
                      top: 3.0,
                      width: clampedBarWidth,
                      height: 12.0,
                      child: Container(color: copper),
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
  final Widget compareCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: parchment,
      border: Border.all(color: copper, width: 1.4),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Before vs after clamping',
          style: TextStyle(
            color: inkText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Left column: raw inner-simulation x(t). Right column: clamped '
          'x(t), with verdigris ticks at the band rails. When the raw bar '
          'fades and a "<xMin" or ">xMax" tag appears, the rail had to do '
          'work to bring the value back inside.',
          style: TextStyle(color: inkMuted, fontSize: 12.0),
        ),
        SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: compareWidgets,
        ),
      ],
    ),
  );

  // ============================================================
  // G. Clamp diagram — a static graph rendered with stacked Containers
  // ============================================================
  // We build a simple band: a 30-cell wide row, with verdigris rails at
  // y = clampMin and y = clampMax. The unclamped curve is a triangle that
  // peaks above the upper rail; the clamped curve is the same, capped.
  // Each column is a stack of three colored cells:
  //   - top region: empty parchmentDeep
  //   - "raw above-rail" segment: brass with low alpha
  //   - band region: verdigrisSoft fill
  //   - clamped curve: copperGlow strip
  //
  // The values are pre-baked so the diagram is purely visual.
  const int diagramCols = 30;
  const double diagramHeight = 160.0;
  const double diagramRailMin = 0.20;
  const double diagramRailMax = 0.65;
  // raw curve: an asymmetric mound that runs from low, rises to peak ~0.95,
  // and falls back into the lower rail.
  final List<double> rawCurve = <double>[
    0.05, 0.07, 0.12, 0.18, 0.26, 0.36, 0.46, 0.56, 0.66, 0.74,
    0.82, 0.88, 0.92, 0.95, 0.96, 0.95, 0.92, 0.88, 0.82, 0.74,
    0.66, 0.58, 0.50, 0.43, 0.36, 0.30, 0.25, 0.20, 0.16, 0.12,
  ];
  // clamped curve: clamp(rawCurve, diagramRailMin, diagramRailMax).
  final List<double> clampedCurve = <double>[];
  for (int i = 0; i < rawCurve.length; i++) {
    final double v = rawCurve[i];
    if (v < diagramRailMin) {
      clampedCurve.add(diagramRailMin);
    } else if (v > diagramRailMax) {
      clampedCurve.add(diagramRailMax);
    } else {
      clampedCurve.add(v);
    }
  }

  final List<Widget> diagramColumns = <Widget>[];
  for (int i = 0; i < diagramCols; i++) {
    final double raw = rawCurve[i];
    final double clamped = clampedCurve[i];
    final bool aboveMax = raw > diagramRailMax;
    final bool belowMin = raw < diagramRailMin;
    diagramColumns.add(
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 1.0),
        child: SizedBox(
          width: 14.0,
          height: diagramHeight,
          child: Stack(
            children: <Widget>[
              // Background panel
              Positioned.fill(
                child: Container(color: parchmentDeep),
              ),
              // Band fill between rails
              Positioned(
                left: 0.0,
                right: 0.0,
                top: diagramHeight * (1.0 - diagramRailMax),
                height: diagramHeight * (diagramRailMax - diagramRailMin),
                child: Container(
                  color: verdigrisSoft.withValues(alpha: 0.35),
                ),
              ),
              // Upper rail line
              Positioned(
                left: 0.0,
                right: 0.0,
                top: diagramHeight * (1.0 - diagramRailMax),
                height: 1.5,
                child: Container(color: verdigris),
              ),
              // Lower rail line
              Positioned(
                left: 0.0,
                right: 0.0,
                top: diagramHeight * (1.0 - diagramRailMin),
                height: 1.5,
                child: Container(color: verdigris),
              ),
              // Raw curve dot (ghosted)
              Positioned(
                left: 4.0,
                top: diagramHeight * (1.0 - raw) - 2.0,
                width: 6.0,
                height: 4.0,
                child: Container(
                  color: aboveMax || belowMin
                      ? brass.withValues(alpha: 0.85)
                      : brass.withValues(alpha: 0.45),
                ),
              ),
              // Clamped curve dot (solid)
              Positioned(
                left: 4.0,
                top: diagramHeight * (1.0 - clamped) - 1.0,
                width: 6.0,
                height: 3.0,
                child: Container(color: copperGlow),
              ),
            ],
          ),
        ),
      ),
    );
  }
  final Widget diagramCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: parchment,
      border: Border.all(color: verdigris, width: 1.4),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Clamp diagram: raw curve crossing the band, clamped curve pinned',
          style: TextStyle(
            color: inkText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'The verdigris band marks [xMin, xMax]. The brass dots trace the '
          'unclamped raw curve — note the dots that drift outside the band '
          'on the rise and fall. The copper dots trace the ClampedSimulation '
          'output, pinned to the rail whenever the raw value strays.',
          style: TextStyle(color: inkMuted, fontSize: 12.0),
        ),
        SizedBox(height: 10.0),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: diagramColumns,
        ),
        SizedBox(height: 8.0),
        Row(
          children: <Widget>[
            Container(width: 10.0, height: 10.0, color: brass),
            SizedBox(width: 6.0),
            Text('raw (ghost)',
                style: TextStyle(color: inkText, fontSize: 11.0)),
            SizedBox(width: 18.0),
            Container(width: 10.0, height: 10.0, color: copperGlow),
            SizedBox(width: 6.0),
            Text('clamped',
                style: TextStyle(color: inkText, fontSize: 11.0)),
            SizedBox(width: 18.0),
            Container(width: 10.0, height: 10.0, color: verdigris),
            SizedBox(width: 6.0),
            Text('rail',
                style: TextStyle(color: inkText, fontSize: 11.0)),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // H. isDone propagation rule card
  // ============================================================
  final List<List<String>> isDoneCases = <List<String>>[
    <String>['raw isDone(t) == false', 'clamped isDone(t) == false',
             'No clamp affects done-ness; both report not-done.'],
    <String>['raw isDone(t) == true (x past end-distance)',
             'clamped isDone(t) == true',
             'Even though x is pinned to xMax, isDone forwards through.'],
    <String>['raw isDone(t) == true (velocity in tolerance)',
             'clamped isDone(t) == true',
             'Tolerance-driven done-ness is also forwarded unchanged.'],
    <String>['raw never finishes (e.g. unbounded gravity)',
             'clamped never finishes',
             'Clamping x or dx does not by itself end the simulation.'],
  ];
  final List<Widget> isDoneRows = <Widget>[];
  for (int i = 0; i < isDoneCases.length; i++) {
    isDoneRows.add(
      Container(
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: i.isEven ? midnightSoft : midnight,
          border: Border.all(
            color: copper.withValues(alpha: 0.5),
            width: 0.8,
          ),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 240.0,
              child: Text(
                isDoneCases[i][0],
                style: TextStyle(
                  color: brassBright,
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('->',
                  style: TextStyle(color: copperGlow, fontSize: 14.0)),
            ),
            SizedBox(
              width: 240.0,
              child: Text(
                isDoneCases[i][1],
                style: TextStyle(
                  color: copperGlow,
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                ),
              ),
            ),
            Expanded(
              child: Text(
                isDoneCases[i][2],
                style: TextStyle(color: goldMuted, fontSize: 11.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget isDoneCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: midnight,
      border: Border.all(color: copper, width: 1.4),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'isDone propagation rule',
          style: TextStyle(
            color: goldText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'ClampedSimulation forwards isDone(t) directly to the inner '
          'simulation. The wrapper never invents new done-ness. This means '
          'a gravity simulation that "ends" when x exceeds 400 still ends '
          'on schedule even if you clamp x to 60 — the underlying x has '
          'still travelled past 400, the wrapper only hides that fact in '
          'the reported value.',
          style: TextStyle(color: goldMuted, fontSize: 12.0),
        ),
        SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: isDoneRows,
        ),
      ],
    ),
  );

  // ============================================================
  // I. Tolerance accessor card
  // ============================================================
  // Snapshot the tolerance from one of our clamped sims to demonstrate.
  Tolerance? toleranceSnapshot;
  try {
    toleranceSnapshot = clampedScroll.tolerance;
  } catch (e) {
    print('Tolerance probe error: $e');
    toleranceSnapshot = null;
  }
  final Widget toleranceCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: parchment,
      border: Border.all(color: brass, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Tolerance accessor',
          style: TextStyle(
            color: inkText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'ClampedSimulation does not introduce its own Tolerance; it '
          'inherits the field from Simulation. Reading clamped.tolerance '
          'returns the tolerance the wrapper itself was constructed with — '
          'which is Tolerance.defaultTolerance unless you passed one in. '
          'It is *not* a passthrough to simulation.tolerance.',
          style: TextStyle(color: inkText, fontSize: 13.0, height: 1.45),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          color: parchmentDeep,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Snapshot from clampedScroll.tolerance:',
                style: TextStyle(
                  color: inkMuted,
                  fontSize: 11.0,
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                toleranceSnapshot == null
                    ? '(unavailable)'
                    : 'distance=${toleranceSnapshot.distance}, '
                        'velocity=${toleranceSnapshot.velocity}, '
                        'time=${toleranceSnapshot.time}',
                style: TextStyle(
                  color: copper,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // J. Sampling table — exact numerical readouts for the four sims.
  // ============================================================
  final List<Widget> samplingTableRows = <Widget>[];
  samplingTableRows.add(
    Container(
      padding: EdgeInsets.all(8.0),
      color: midnightSoft,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 130.0,
            child: Text('sim',
                style: TextStyle(
                    color: goldText, fontWeight: FontWeight.w700)),
          ),
          SizedBox(
            width: 60.0,
            child: Text('t',
                style: TextStyle(
                    color: goldText, fontWeight: FontWeight.w700)),
          ),
          SizedBox(
            width: 80.0,
            child: Text('raw x',
                style: TextStyle(
                    color: goldText, fontWeight: FontWeight.w700)),
          ),
          SizedBox(
            width: 90.0,
            child: Text('clamped x',
                style: TextStyle(
                    color: goldText, fontWeight: FontWeight.w700)),
          ),
          SizedBox(
            width: 80.0,
            child: Text('raw dx',
                style: TextStyle(
                    color: goldText, fontWeight: FontWeight.w700)),
          ),
          SizedBox(
            width: 90.0,
            child: Text('clamped dx',
                style: TextStyle(
                    color: goldText, fontWeight: FontWeight.w700)),
          ),
          SizedBox(
            width: 60.0,
            child: Text('done',
                style: TextStyle(
                    color: goldText, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    ),
  );
  final List<List<dynamic>> samplePairs = <List<dynamic>>[
    <dynamic>['Gravity',      gravity,         clampedGravity],
    <dynamic>['Friction',     friction,        clampedFriction],
    <dynamic>['ScrollSpring', scrollSimulation, clampedScroll],
    <dynamic>['Bouncing',     bouncing,        clampedBouncing],
  ];
  int rowIdx = 0;
  for (int s = 0; s < samplePairs.length; s++) {
    final String label = samplePairs[s][0] as String;
    final Simulation raw = samplePairs[s][1] as Simulation;
    final Simulation cl = samplePairs[s][2] as Simulation;
    for (int ti = 0; ti < sampleTimes.length; ti++) {
      final double t = sampleTimes[ti];
      double rx, cx, rdx, cdx;
      bool done;
      try {
        rx = raw.x(t);
        cx = cl.x(t);
        rdx = raw.dx(t);
        cdx = cl.dx(t);
        done = cl.isDone(t);
      } catch (e) {
        print('Sampling row error at $label t=$t: $e');
        rx = 0.0;
        cx = 0.0;
        rdx = 0.0;
        cdx = 0.0;
        done = false;
      }
      samplingTableRows.add(
        Container(
          padding: EdgeInsets.all(6.0),
          color: rowIdx.isEven ? midnight : midnightSoft.withValues(alpha: 0.6),
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 130.0,
                child: Text(
                  label,
                  style: TextStyle(color: goldText, fontSize: 11.0),
                ),
              ),
              SizedBox(
                width: 60.0,
                child: Text(
                  t.toStringAsFixed(2),
                  style: TextStyle(
                    color: goldMuted,
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                  ),
                ),
              ),
              SizedBox(
                width: 80.0,
                child: Text(
                  rx.toStringAsFixed(2),
                  style: TextStyle(
                    color: brassBright,
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                  ),
                ),
              ),
              SizedBox(
                width: 90.0,
                child: Text(
                  cx.toStringAsFixed(2),
                  style: TextStyle(
                    color: copperGlow,
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                  ),
                ),
              ),
              SizedBox(
                width: 80.0,
                child: Text(
                  rdx.toStringAsFixed(2),
                  style: TextStyle(
                    color: brassBright,
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                  ),
                ),
              ),
              SizedBox(
                width: 90.0,
                child: Text(
                  cdx.toStringAsFixed(2),
                  style: TextStyle(
                    color: copperGlow,
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                  ),
                ),
              ),
              SizedBox(
                width: 60.0,
                child: Text(
                  done ? 'yes' : 'no',
                  style: TextStyle(
                    color: done ? carmineWarn : goldMuted,
                    fontFamily: 'monospace',
                    fontSize: 11.0,
                    fontWeight:
                        done ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
      rowIdx++;
    }
  }
  final Widget samplingCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: midnight,
      border: Border.all(color: copper, width: 1.4),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Numerical sampling: x(t), dx(t), isDone(t)',
          style: TextStyle(
            color: goldText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'For each base simulation, the precise scalar values at the six '
          'time samples. Brass = raw, copper = clamped. Discrepancies '
          'between rx and cx mark a clamping event.',
          style: TextStyle(color: goldMuted, fontSize: 12.0),
        ),
        SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: samplingTableRows,
        ),
      ],
    ),
  );

  // ============================================================
  // K. Pitfalls
  // ============================================================
  final List<List<String>> pitfalls = <List<String>>[
    <String>[
      'dx and x become inconsistent',
      'When the rail is active, x is pinned but dx still reports the '
          'inner velocity. Code that integrates dx assuming x = ∫dx will '
          'desynchronise during clamp events.',
    ],
    <String>[
      'isDone is not influenced by clamping',
      'Clamping x to a tiny band does not stop the simulation; the inner '
          'sim still ticks. If your "done" criterion depends on the visible '
          'x, write a separate predicate.',
    ],
    <String>[
      'The wrapped sim is not mutated',
      'ClampedSimulation does not modify simulation.x; it only crops the '
          'output. If the inner sim has hidden state (BouncingScrollSimulation '
          'has phase transitions), your clamps will not influence those.',
    ],
    <String>[
      'asserts on rail order',
      'xMax must be >= xMin and dxMax must be >= dxMin. Reversed rails '
          'trip an assert in debug and produce undefined values in release. '
          'Pass them in canonical order.',
    ],
    <String>[
      'Constructor does not accept tolerance directly',
      'Unlike most Simulation subclasses, ClampedSimulation does not '
          'forward tolerance to its constructor. The wrapper uses the '
          'default tolerance regardless of the inner sim\'s tolerance.',
    ],
    <String>[
      'Negative-direction surprises',
      'For sims that swing both ways (gravity-up, friction in reverse), '
          'remember xMin clamps the lower extreme — it is not a soft floor. '
          'A particle accelerating downward will sit at xMin until the inner '
          'sim turns around.',
    ],
  ];
  final List<Widget> pitfallWidgets = <Widget>[];
  for (int i = 0; i < pitfalls.length; i++) {
    pitfallWidgets.add(
      Container(
        margin: EdgeInsets.only(bottom: 10.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: midnight,
          border: Border.all(color: carmineWarn, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: 22.0,
                  height: 22.0,
                  color: carmineWarn,
                  alignment: Alignment.center,
                  child: Text(
                    '!',
                    style: TextStyle(
                      color: goldText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    pitfalls[i][0],
                    style: TextStyle(
                      color: copperGlow,
                      fontWeight: FontWeight.w700,
                      fontSize: 13.5,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.0),
            Text(
              pitfalls[i][1],
              style: TextStyle(
                color: goldMuted,
                fontSize: 12.5,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget pitfallsCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: midnightSoft,
      border: Border.all(color: carmineWarn, width: 1.4),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Pitfalls',
          style: TextStyle(
            color: copperGlow,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: pitfallWidgets,
        ),
      ],
    ),
  );

  // ============================================================
  // L. Decision flowchart
  // ============================================================
  const String flowchart = ''
      'Q1. Do you control the inner Simulation\'s construction?\n'
      '     YES -> can you pass the limit directly into the inner sim?\n'
      '            YES -> do that. ClampedSimulation is unnecessary.\n'
      '            NO  -> wrap with ClampedSimulation. Continue Q2.\n'
      '     NO  -> wrap with ClampedSimulation. Continue Q2.\n'
      '\n'
      'Q2. Are you bounding x, dx, or both?\n'
      '     x      -> set xMin/xMax, leave dx rails at +/- infinity.\n'
      '     dx     -> set dxMin/dxMax, leave x rails at +/- infinity.\n'
      '     both   -> set all four rails.\n'
      '\n'
      'Q3. Do you need x and dx to stay coherent (x == integral of dx)?\n'
      '     YES -> ClampedSimulation alone is NOT enough. Either modify '
      'the inner sim or recompute dx from a finite difference of clamped x.\n'
      '     NO  -> ClampedSimulation suffices.\n'
      '\n'
      'Q4. Does the simulation need a different end condition because of '
      'clamping?\n'
      '     YES -> wrap again, with a custom Simulation overriding isDone.\n'
      '     NO  -> stop here.\n'
      '\n'
      'Q5. Is your range time-varying (e.g. a moving content extent)?\n'
      '     YES -> ClampedSimulation\'s rails are immutable after '
      'construction. Build a fresh wrapper per frame, or write a custom '
      'Simulation.\n'
      '     NO  -> ClampedSimulation\'s constant rails are a perfect fit.\n'
      '';
  final Widget flowchartCard = Container(
    padding: EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: midnight,
      border: Border.all(color: brass, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Decision flowchart: when to reach for ClampedSimulation',
          style: TextStyle(
            color: goldText,
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          flowchart,
          style: TextStyle(
            color: brassBright,
            fontFamily: 'monospace',
            fontSize: 11.5,
            height: 1.45,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // M. Code snippets
  // ============================================================
  const String snippet1 = ''
      '// Simplest case: clamp position only.\n'
      'final inner = GravitySimulation(10.0, 0.0, 400.0, 0.0);\n'
      'final clamped = ClampedSimulation(\n'
      '  inner,\n'
      '  xMin: 0.0,\n'
      '  xMax: 200.0,\n'
      ');\n'
      '// clamped.x(t) is in [0, 200] for every t.\n'
      '';
  const String snippet2 = ''
      '// Clamp position AND velocity.\n'
      'final wrapped = ClampedSimulation(\n'
      '  FrictionSimulation(0.135, 20.0, 180.0),\n'
      '  xMin: 0.0,\n'
      '  xMax: 120.0,\n'
      '  dxMin: 0.0,\n'
      '  dxMax: 200.0,\n'
      ');\n'
      '';
  const String snippet3 = ''
      '// Use with AnimationController.animateWith — the controller treats\n'
      '// ClampedSimulation just like any other Simulation.\n'
      'controller.animateWith(ClampedSimulation(\n'
      '  ScrollSpringSimulation(\n'
      '    SpringDescription(mass: 0.5, stiffness: 100.0, damping: 1.0),\n'
      '    0.0, 300.0, 0.0,\n'
      '  ),\n'
      '  xMin: 0.0,\n'
      '  xMax: 200.0,\n'
      '));\n'
      '';
  const String snippet4 = ''
      '// Defensive snapshot probe — script-friendly, returns 0 on error.\n'
      'double safeClampedX(ClampedSimulation s, double t) {\n'
      '  try {\n'
      '    return s.x(t);\n'
      '  } catch (e) {\n'
      '    return 0.0;\n'
      '  }\n'
      '}\n'
      '';
  const String snippet5 = ''
      '// Reading the rails back out for a debugger overlay.\n'
      'String railSummary(ClampedSimulation s) {\n'
      '  return \'x in [\${s.xMin}, \${s.xMax}], \'\n'
      '      \'dx in [\${s.dxMin}, \${s.dxMax}]\';\n'
      '}\n'
      '';
  final List<List<String>> snippets = <List<String>>[
    <String>['1. Position-only clamp', snippet1],
    <String>['2. Position + velocity clamp', snippet2],
    <String>['3. With AnimationController.animateWith', snippet3],
    <String>['4. Defensive probe', snippet4],
    <String>['5. Rail summary', snippet5],
  ];
  final List<Widget> snippetWidgets = <Widget>[];
  for (int i = 0; i < snippets.length; i++) {
    snippetWidgets.add(
      Container(
        margin: EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          color: midnight,
          border: Border.all(color: brass, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: 10.0, vertical: 6.0),
              color: midnightSoft,
              width: double.infinity,
              child: Text(
                snippets[i][0],
                style: TextStyle(
                  color: goldText,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                snippets[i][1],
                style: TextStyle(
                  color: brassBright,
                  fontFamily: 'monospace',
                  fontSize: 11.5,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget snippetsCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: midnightSoft,
      border: Border.all(color: brass, width: 1.4),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Code snippets',
          style: TextStyle(
            color: goldText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: snippetWidgets,
        ),
      ],
    ),
  );

  // ============================================================
  // N. Comparison vs alternative wrappers
  // ============================================================
  final List<List<String>> comparisonRows = <List<String>>[
    <String>[
      'ClampedSimulation',
      'Hard rails on x and dx; isDone forwarded.',
      'When the inner sim must be left intact and you need a guaranteed '
          'output band.',
    ],
    <String>[
      'Custom saturating wrapper',
      'Soft, sigmoidal approach to a rail.',
      'When you want a smoothed approach instead of a hard pin.',
    ],
    <String>[
      'lerpDouble post-process',
      'Manual interpolation of x against a guide curve.',
      'When you want crossfade behaviour, not clamping.',
    ],
    <String>[
      'Modify the inner sim',
      'Pass a smaller endDistance, or a tighter spring.',
      'When you control construction and want consistent x/dx coherence.',
    ],
    <String>[
      'BouncingScrollSimulation\'s extents',
      'Built-in leadingExtent / trailingExtent + bounce.',
      'When you specifically want overshoot-with-bounce, not a pin.',
    ],
    <String>[
      'ClampingScrollSimulation',
      'A purpose-built ballistic scroll with a hard end.',
      'When the use-case is specifically Android-style scroll fling, '
          'not arbitrary clamping.',
    ],
  ];
  final List<Widget> comparisonChildren = <Widget>[];
  comparisonChildren.add(
    Container(
      padding: EdgeInsets.all(8.0),
      color: parchmentDeep,
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 220.0,
            child: Text('Approach',
                style: TextStyle(
                    color: inkText, fontWeight: FontWeight.w700)),
          ),
          SizedBox(
            width: 240.0,
            child: Text('Behaviour',
                style: TextStyle(
                    color: inkText, fontWeight: FontWeight.w700)),
          ),
          Expanded(
            child: Text('When to use',
                style: TextStyle(
                    color: inkText, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    ),
  );
  for (int i = 0; i < comparisonRows.length; i++) {
    comparisonChildren.add(
      Container(
        padding: EdgeInsets.all(8.0),
        color: i.isEven
            ? parchment
            : parchmentDeep.withValues(alpha: 0.55),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 220.0,
              child: Text(
                comparisonRows[i][0],
                style: TextStyle(
                  color: copper,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ),
            SizedBox(
              width: 240.0,
              child: Text(
                comparisonRows[i][1],
                style: TextStyle(color: inkText, fontSize: 12.0),
              ),
            ),
            Expanded(
              child: Text(
                comparisonRows[i][2],
                style: TextStyle(color: inkMuted, fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget comparisonCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: parchment,
      border: Border.all(color: brass, width: 1.4),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Alternatives: ClampedSimulation vs neighbours',
          style: TextStyle(
            color: inkText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Six neighbouring approaches in the same problem space. Choose '
          'ClampedSimulation when you need hard rails and an unmodified '
          'inner simulation; reach for the others for softer, smoother, or '
          'more domain-specific behaviour.',
          style: TextStyle(color: inkMuted, fontSize: 12.0),
        ),
        SizedBox(height: 10.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: comparisonChildren,
        ),
      ],
    ),
  );

  // ============================================================
  // O. Glossary
  // ============================================================
  final List<List<String>> glossary = <List<String>>[
    <String>[
      'Simulation',
      'The abstract base; exposes x(t), dx(t), isDone(t), tolerance.',
    ],
    <String>[
      'ClampedSimulation',
      'Wrapper that crops x and dx into closed intervals.',
    ],
    <String>[
      'GravitySimulation',
      'Newtonian particle: x = x0 + v*t + 0.5*a*t^2.',
    ],
    <String>[
      'FrictionSimulation',
      'Drag-decelerated particle; asymptotes at finalX.',
    ],
    <String>[
      'SpringSimulation',
      'Mass-spring-damper governed by SpringDescription.',
    ],
    <String>[
      'ScrollSpringSimulation',
      'Subclass of SpringSimulation that pins to end once isDone.',
    ],
    <String>[
      'BouncingScrollSimulation',
      'Composite friction + spring; iOS-style overscroll bounce.',
    ],
    <String>[
      'Tolerance',
      'distance/velocity/time epsilons used to decide isDone.',
    ],
    <String>[
      'clampDouble',
      'Foundation helper: clamp(v, lo, hi) for doubles.',
    ],
    <String>[
      'rail',
      'Informal term for one of xMin/xMax/dxMin/dxMax.',
    ],
    <String>[
      'band',
      'The region [xMin, xMax] (or [dxMin, dxMax]) the output is held in.',
    ],
    <String>[
      'pinning',
      'A clamp event where x sits exactly on a rail.',
    ],
  ];
  final List<Widget> glossaryRows = <Widget>[];
  for (int i = 0; i < glossary.length; i++) {
    glossaryRows.add(
      Container(
        padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
        color: i.isEven
            ? parchment.withValues(alpha: 0.85)
            : parchmentDeep.withValues(alpha: 0.6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 200.0,
              child: Text(
                glossary[i][0],
                style: TextStyle(
                  color: copper,
                  fontFamily: 'monospace',
                  fontSize: 12.0,
                ),
              ),
            ),
            Expanded(
              child: Text(
                glossary[i][1],
                style: TextStyle(color: inkText, fontSize: 12.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
  final Widget glossaryCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: parchment,
      border: Border.all(color: brass, width: 1.2),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Glossary',
          style: TextStyle(
            color: inkText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: glossaryRows,
        ),
      ],
    ),
  );

  // ============================================================
  // P. Footer recap
  // ============================================================
  final Widget footerCard = Container(
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[parchmentDeep, parchment],
      ),
      border: Border.all(color: brass, width: 1.0),
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          'Recap',
          style: TextStyle(
            color: inkText,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6.0),
        Text(
          'ClampedSimulation pins the reported x(t) and dx(t) of any '
          'Simulation into closed bands while leaving isDone(t) and '
          'the inner state untouched. It is the precise tool when you '
          'need a guarantee, not a smoothing — pick it for hard rails, '
          'pick a saturating wrapper for soft rails, pick a custom '
          'Simulation when you need to recompute dx from clamped x.',
          style: TextStyle(
            color: inkText,
            fontSize: 13.0,
            height: 1.45,
          ),
        ),
        SizedBox(height: 8.0),
        Text(
          'Base sims demonstrated: ${samplePairs.length}    '
          'Sample times per sim: ${sampleTimes.length}    '
          'Diagram columns: $diagramCols',
          style: TextStyle(
            color: inkMuted,
            fontSize: 12.0,
            fontFamily: 'monospace',
          ),
        ),
      ],
    ),
  );

  print('ClampedSimulation deep visual demo build complete.');

  return Scaffold(
    backgroundColor: parchment,
    body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            headerCard,
            SizedBox(height: 16.0),
            paletteCard,
            SizedBox(height: 16.0),
            swatchCard,
            SizedBox(height: 16.0),
            apiCard,
            SizedBox(height: 16.0),
            proseCard,
            SizedBox(height: 16.0),
            trajectoryCard,
            SizedBox(height: 16.0),
            compareCard,
            SizedBox(height: 16.0),
            diagramCard,
            SizedBox(height: 16.0),
            isDoneCard,
            SizedBox(height: 16.0),
            toleranceCard,
            SizedBox(height: 16.0),
            samplingCard,
            SizedBox(height: 16.0),
            pitfallsCard,
            SizedBox(height: 16.0),
            flowchartCard,
            SizedBox(height: 16.0),
            snippetsCard,
            SizedBox(height: 16.0),
            comparisonCard,
            SizedBox(height: 16.0),
            glossaryCard,
            SizedBox(height: 16.0),
            footerCard,
          ],
        ),
      ),
    ),
  );
}
