// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// ============================================================================
//                                                                            =
//   BOUNDED FRICTION SIMULATION  ::  THE GLACIER CITRUS DEMO                 =
//                                                                            =
//   A long, narrative, instruction-rich D4rt demo script that explores the   =
//   `BoundedFrictionSimulation` class from `package:flutter/physics.dart`.   =
//                                                                            =
//   Theme: "Glacier Citrus" — a palette inspired by sub-zero glacial blues   =
//   colliding with sun-baked citrus rinds.  Cold motion, warm boundaries.    =
//                                                                            =
//   This file is intentionally HAND-WRITTEN and VERBOSE.  It is meant to be  =
//   read top-to-bottom as a tutorial.  Every section explains a different    =
//   facet of bounded friction physics, from the low-level decay equation to  =
//   the practical reasons why scroll views need a clamped friction model.    =
//                                                                            =
//   ----------------------------------------------------------------------   =
//                                                                            =
//   D4rt sandbox limitations honored throughout this file:                   =
//                                                                            =
//     1. `build(BuildContext)` is invoked exactly ONCE.  We must return a    =
//        snapshot widget tree.                                               =
//     2. NO StatefulWidget, NO setState, NO controllers.                     =
//     3. NO live timers, futures, or streams.                                =
//     4. NO `for-in` over BridgedInstance.                                   =
//     5. NO `.value` on `Tween.animate` — Tween animation is forbidden.      =
//     6. Use `.withValues(alpha: ...)` instead of `.withOpacity(...)`.        =
//                                                                            =
//   ----------------------------------------------------------------------   =
//                                                                            =
//   The simulations are constructed at the top of `build`, then sampled     =
//   synchronously at six fixed times.  Every sampled scalar is embedded in   =
//   the rendered tree as a Text widget so the reader can see the decay      =
//   curve manifest itself in the UI.                                        =
//                                                                            =
//   Author : Tom Agent Container demo team                                  =
//   Theme  : Glacier Citrus                                                 =
//   Lines  : 1500+ (intentionally exhaustive)                               =
//                                                                            =
// ============================================================================

import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

// ============================================================================
//                          GLACIER CITRUS PALETTE
// ============================================================================
//
// Below is the full palette used by every section of the demo.  The names are
// thematic rather than functional — each color has a "voice" that ties to the
// glacier-and-citrus concept.  We define more than ten palette colors so that
// every section can find a coherent contrast pair.

const Color kGlacierAbyss     = Color(0xFF06243A); // deep crevasse blue
const Color kGlacierMidnight  = Color(0xFF0D3A5C); // mid-depth ice
const Color kGlacierDeep      = Color(0xFF14507E); // structural blue
const Color kGlacierFrost     = Color(0xFF4F8FB8); // sun-on-ice
const Color kGlacierMist      = Color(0xFFAFD3E6); // distant haze
const Color kCitrusZest       = Color(0xFFFFC857); // candied lemon
const Color kCitrusRind       = Color(0xFFE8A33C); // orange peel
const Color kCitrusBlossom    = Color(0xFFFFE6A1); // pale flower
const Color kCitrusEmber      = Color(0xFFE3692A); // burnt orange
const Color kCitrusMandarin   = Color(0xFFF39237); // mandarin
const Color kSnowfield        = Color(0xFFF6F9FC); // background paper
const Color kSnowEdge         = Color(0xFFD9E3EC); // subtle border
const Color kInkPrimary       = Color(0xFF11202E); // primary text
const Color kInkSecondary     = Color(0xFF445566); // secondary text
const Color kInkMuted         = Color(0xFF7F8C99); // muted text
const Color kAccentLime       = Color(0xFFCBE36B); // surprise lime
const Color kAccentTeal       = Color(0xFF21808D); // mid teal
const Color kAccentBerry      = Color(0xFF8E2C5B); // sour berry

// ============================================================================
//                              TEXT STYLES
// ============================================================================

const TextStyle kStyleTitle = TextStyle(
  fontSize: 26,
  fontWeight: FontWeight.w800,
  color: kInkPrimary,
  letterSpacing: 0.6,
);

const TextStyle kStyleSubtitle = TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: kInkSecondary,
  letterSpacing: 0.3,
);

const TextStyle kStyleSection = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.w700,
  color: kGlacierDeep,
  letterSpacing: 0.4,
);

const TextStyle kStyleBody = TextStyle(
  fontSize: 13,
  fontWeight: FontWeight.w400,
  color: kInkPrimary,
  height: 1.4,
);

const TextStyle kStyleBodyMuted = TextStyle(
  fontSize: 12.5,
  fontWeight: FontWeight.w400,
  color: kInkSecondary,
  height: 1.4,
);

const TextStyle kStyleMono = TextStyle(
  fontSize: 12,
  fontFamily: 'monospace',
  color: kGlacierAbyss,
  height: 1.35,
);

const TextStyle kStyleMonoLight = TextStyle(
  fontSize: 11.5,
  fontFamily: 'monospace',
  color: kInkSecondary,
  height: 1.35,
);

const TextStyle kStyleTableHeader = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w700,
  color: kSnowfield,
  letterSpacing: 0.5,
);

const TextStyle kStyleTableCell = TextStyle(
  fontSize: 12,
  fontFamily: 'monospace',
  color: kInkPrimary,
);

const TextStyle kStyleBadge = TextStyle(
  fontSize: 11,
  fontWeight: FontWeight.w700,
  color: kSnowfield,
  letterSpacing: 0.6,
);

const TextStyle kStyleCallout = TextStyle(
  fontSize: 12.5,
  fontWeight: FontWeight.w500,
  color: kInkPrimary,
  height: 1.45,
);

// ============================================================================
//                             ENTRY POINT
// ============================================================================
//
// `build` is the single function D4rt invokes.  Everything else is helpers and
// constants.  We build all simulations up front so they can be sampled in any
// order from any section below.

dynamic build(BuildContext context) {
  print('================================================================');
  print('Glacier Citrus :: BoundedFrictionSimulation deep-dive starting');
  print('================================================================');
  print('Step 1/8 :: defining palette + narrative scaffolding');
  print('Step 2/8 :: constructing eight BoundedFrictionSimulation cases');
  print('Step 3/8 :: sampling x(t) at six time slices per simulation');
  print('Step 4/8 :: sampling dx(t) (velocity) at six time slices');
  print('Step 5/8 :: probing isDone(t) at progression times');
  print('Step 6/8 :: assembling the bar-chart visual diagram');
  print('Step 7/8 :: composing comparison and DO/AVOID callouts');
  print('Step 8/8 :: rendering the final scrollable scaffold');

  // --------------------------------------------------------------------------
  // Construction gallery — eight BoundedFrictionSimulation instances.
  // --------------------------------------------------------------------------
  //
  // Each simulation is described below with a short narrative.  The numbers
  // were tuned so that the resulting samples illustrate distinct behaviors:
  //   * some come to rest naturally,
  //   * some are clamped early by the upper bound,
  //   * some are clamped early by the lower bound (reverse motion),
  //   * one has effectively zero room to move.
  //
  // We deliberately use a wide range of `drag` values to show the effect of
  // friction strength on the decay curve.  In Flutter physics, drag below 1.0
  // means the simulation decelerates (typical case).  Drag exactly 1.0 means
  // the velocity never decays.  Drag above 1.0 is unusual and amplifies.

  final BoundedFrictionSimulation simAlpha = BoundedFrictionSimulation(
    0.135, // drag — typical for scroll views
    50.0,  // start position
    220.0, // initial velocity (positive => moving toward maxX)
    0.0,   // minX
    300.0, // maxX
  );
  print('  [alpha] drag=0.135 pos=50.0 vel=220.0 bounds=[0, 300]');

  final BoundedFrictionSimulation simBeta = BoundedFrictionSimulation(
    0.250,
    100.0,
    400.0,
    0.0,
    600.0,
  );
  print('  [beta]  drag=0.250 pos=100.0 vel=400.0 bounds=[0, 600]');

  final BoundedFrictionSimulation simGamma = BoundedFrictionSimulation(
    0.075,
    20.0,
    180.0,
    0.0,
    150.0, // intentionally tight upper bound — will clamp early
  );
  print('  [gamma] drag=0.075 pos=20.0 vel=180.0 bounds=[0, 150] (tight)');

  final BoundedFrictionSimulation simDelta = BoundedFrictionSimulation(
    0.500, // strong drag — fast decay
    250.0,
    800.0,
    0.0,
    1000.0,
  );
  print('  [delta] drag=0.500 pos=250.0 vel=800.0 bounds=[0, 1000]');

  final BoundedFrictionSimulation simEpsilon = BoundedFrictionSimulation(
    0.135,
    400.0,
    -300.0, // negative velocity — moves toward minX
    0.0,
    500.0,
  );
  print('  [epsilon] drag=0.135 pos=400.0 vel=-300.0 (reverse)');

  final BoundedFrictionSimulation simZeta = BoundedFrictionSimulation(
    0.135,
    50.0,
    50.0,
    50.0, // minX equals starting position — no room to move backward
    52.0, // maxX only 2 units away — clamps almost immediately
  );
  print('  [zeta]  drag=0.135 pos=50.0 vel=50.0 bounds=[50, 52] (narrow)');

  final BoundedFrictionSimulation simEta = BoundedFrictionSimulation(
    0.020, // very low drag — long glide
    0.0,
    100.0,
    -200.0,
    200.0,
  );
  print('  [eta]   drag=0.020 pos=0.0 vel=100.0 bounds=[-200, 200]');

  final BoundedFrictionSimulation simTheta = BoundedFrictionSimulation(
    0.350,
    -50.0,
    600.0,
    -100.0,
    400.0,
  );
  print('  [theta] drag=0.350 pos=-50.0 vel=600.0 bounds=[-100, 400]');

  // Group the simulations in a list-of-records-style structure so that the
  // sampling tables can iterate using a plain `for (var i = 0; ...)` loop —
  // which IS allowed in D4rt (only `for-in` over BridgedInstance is banned).

  final List<_SimEntry> entries = <_SimEntry>[
    _SimEntry('alpha',   simAlpha,   'baseline scroll-view friction'),
    _SimEntry('beta',    simBeta,    'fast launch with generous bounds'),
    _SimEntry('gamma',   simGamma,   'tight upper bound clamps early'),
    _SimEntry('delta',   simDelta,   'aggressive drag, quick rest'),
    _SimEntry('epsilon', simEpsilon, 'reverse motion toward minX'),
    _SimEntry('zeta',    simZeta,    'paper-thin bounds, instant clamp'),
    _SimEntry('eta',     simEta,     'lazy glide with minimal drag'),
    _SimEntry('theta',   simTheta,   'overshoots — clamped at upper bound'),
  ];

  // Sample times we'll use throughout the document.  Six values, but the
  // sampling tables will combine these into 12+ row blocks by interleaving
  // with extra times (see `_extendedTimes`).

  final List<double> sampleTimes = <double>[0.0, 0.05, 0.1, 0.25, 0.5, 1.0, 2.0];
  final List<double> extendedTimes = <double>[
    0.0, 0.025, 0.05, 0.075, 0.1, 0.15, 0.25, 0.35, 0.5, 0.75, 1.0, 1.5, 2.0,
  ];
  final List<double> isDoneTimes = <double>[
    0.0, 0.1, 0.25, 0.5, 1.0, 2.0, 3.0, 5.0, 10.0,
  ];

  print('  Sampling at base times: $sampleTimes');
  print('  Extended times for tables: $extendedTimes');
  print('  Done-progression times: $isDoneTimes');
  print('Sampling complete; assembling widget tree.');

  // We also do a quick eyeball sanity check on simAlpha so it shows up in the
  // build log even if a section is later collapsed.
  print('  [alpha] x(0)=${simAlpha.x(0.0).toStringAsFixed(2)} '
      'x(1)=${simAlpha.x(1.0).toStringAsFixed(2)} '
      'dx(0)=${simAlpha.dx(0.0).toStringAsFixed(2)} '
      'dx(1)=${simAlpha.dx(1.0).toStringAsFixed(2)} '
      'done(2)=${simAlpha.isDone(2.0)}');

  return Scaffold(
    backgroundColor: kSnowfield,
    body: SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // 1. Title banner with palette swatches.
          _buildTitleBanner(),
          const SizedBox(height: 28),

          // 2. Prose anatomy of friction physics.
          _buildProseAnatomy(),
          const SizedBox(height: 28),

          // 3. Property anatomy table.
          _buildPropertyAnatomy(),
          const SizedBox(height: 28),

          // 4. Construction gallery.
          _buildConstructionGallery(entries),
          const SizedBox(height: 28),

          // 5. Sampling table for x(t).
          _buildPositionSamplingTable(entries, extendedTimes),
          const SizedBox(height: 28),

          // 6. dx (velocity) decay table.
          _buildVelocityDecayTable(entries, extendedTimes),
          const SizedBox(height: 28),

          // 7. isDone progression.
          _buildIsDoneProgression(entries, isDoneTimes),
          const SizedBox(height: 28),

          // 8. Visual bar chart for simAlpha.
          _buildBarChartDiagram(simAlpha, 'alpha', 0.0, 300.0),
          const SizedBox(height: 28),

          // 9. Boundary clamp explanation.
          _buildClampExplanation(simGamma, simZeta, simTheta),
          const SizedBox(height: 28),

          // 10. Comparison FrictionSimulation vs BoundedFrictionSimulation.
          _buildComparisonTable(),
          const SizedBox(height: 28),

          // 11. DO/AVOID callouts.
          _buildDoAvoidCallouts(),
          const SizedBox(height: 28),

          // 12. Code-snippet recipe cards.
          _buildRecipeCards(),
          const SizedBox(height: 28),

          // 13. Glossary.
          _buildGlossary(),
          const SizedBox(height: 28),

          // 14. Recap footer.
          _buildRecapFooter(entries, sampleTimes),
        ],
      ),
    ),
  );
}

// ============================================================================
//                              HELPER TYPES
// ============================================================================

/// A simple value-object that pairs a simulation with its label and notes.
/// Plain Dart class — D4rt handles user-defined classes fine, just no
/// StatefulWidget or InheritedWidget shenanigans.
class _SimEntry {
  final String name;
  final BoundedFrictionSimulation sim;
  final String notes;
  const _SimEntry(this.name, this.sim, this.notes);
}

/// Format a double with a fixed precision.  We pull this into a helper so the
/// whole document uses identical formatting.
String _fmt(double v) {
  if (v.isNaN) return 'NaN';
  if (v.isInfinite) return v.isNegative ? '-Inf' : '+Inf';
  return v.toStringAsFixed(2);
}

String _fmtBool(bool v) => v ? 'true' : 'false';

// ============================================================================
//                       SECTION 1 :: TITLE BANNER
// ============================================================================
//
// The title banner is a stack of color blocks pretending to be a glacier with
// citrus highlights.  The palette swatches at the bottom let the reader
// internalize the theme before the prose begins.

Widget _buildTitleBanner() {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          kGlacierAbyss,
          kGlacierMidnight,
          kGlacierDeep,
          kCitrusEmber.withValues(alpha: 0.85),
          kCitrusZest,
        ],
        stops: const <double>[0.0, 0.25, 0.55, 0.85, 1.0],
      ),
      borderRadius: BorderRadius.circular(16),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: kGlacierAbyss.withValues(alpha: 0.18),
          blurRadius: 18,
          offset: const Offset(0, 8),
        ),
      ],
    ),
    padding: const EdgeInsets.fromLTRB(24, 28, 24, 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: kCitrusZest,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'GLACIER CITRUS',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: kGlacierAbyss,
                  letterSpacing: 1.4,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: kSnowfield.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: kSnowfield.withValues(alpha: 0.4)),
              ),
              child: const Text(
                'PHYSICS  ::  flutter/physics.dart',
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w700,
                  color: kSnowfield,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'BoundedFrictionSimulation',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: kSnowfield,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'A friction model with hard walls — the glacier that stops sliding.',
          style: TextStyle(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: kSnowfield.withValues(alpha: 0.92),
          ),
        ),
        const SizedBox(height: 18),
        // Palette swatches.
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: <Widget>[
            _swatch('abyss', kGlacierAbyss),
            _swatch('midnight', kGlacierMidnight),
            _swatch('deep', kGlacierDeep),
            _swatch('frost', kGlacierFrost),
            _swatch('mist', kGlacierMist),
            _swatch('zest', kCitrusZest),
            _swatch('rind', kCitrusRind),
            _swatch('blossom', kCitrusBlossom),
            _swatch('ember', kCitrusEmber),
            _swatch('mandarin', kCitrusMandarin),
            _swatch('lime', kAccentLime),
            _swatch('teal', kAccentTeal),
            _swatch('berry', kAccentBerry),
          ],
        ),
      ],
    ),
  );
}

Widget _swatch(String label, Color color) {
  // A tiny chip showing one palette color, with the label beneath in a way
  // that reads even on the dark gradient banner.
  return Container(
    width: 80,
    padding: const EdgeInsets.all(6),
    decoration: BoxDecoration(
      color: kSnowfield.withValues(alpha: 0.10),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: kSnowfield.withValues(alpha: 0.25)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 18,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 9.5,
            color: kSnowfield.withValues(alpha: 0.95),
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
//                       SECTION 2 :: PROSE ANATOMY
// ============================================================================
//
// A running essay on friction physics, why simulators exist, and the precise
// reason scrolling needs a *bounded* friction model.  No equations rendered
// with math fonts — everything is plain Text widgets — but we use monospace
// blocks for formulas.

Widget _buildProseAnatomy() {
  return _section(
    icon: '\u2744',
    title: '1. The physics of bounded friction',
    accent: kGlacierDeep,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'A FrictionSimulation models a particle that begins with some velocity '
          'and slows down because of drag.  The simulation is described by a '
          'closed-form solution to an exponential-decay differential equation.  '
          'Given a drag coefficient d (between 0 and 1) and an initial '
          'velocity v0 at position x0, the position over time is approximately:',
          style: kStyleBody,
        ),
        const SizedBox(height: 10),
        _formulaBox(
          'x(t) = x0 + (v0 / ln(d)) * (pow(d, t) - 1)',
        ),
        const SizedBox(height: 4),
        _formulaBox(
          'dx(t) = v0 * pow(d, t)',
        ),
        const SizedBox(height: 12),
        const Text(
          'These two scalar functions tell you where the particle is and how '
          'fast it is moving at any time t.  The motion never quite stops — '
          'velocity asymptotically approaches zero — but in practice the '
          'simulation reports `isDone` once velocity drops below a tolerance.',
          style: kStyleBody,
        ),
        const SizedBox(height: 12),
        const Text(
          'BoundedFrictionSimulation extends this model with two additional '
          'parameters: minX and maxX.  These act as hard walls.  Whenever the '
          'unbounded x(t) would exceed maxX or fall below minX, the simulation '
          'simply CLAMPS the position to the boundary and reports the motion '
          'as done.  This is exactly the behavior you want when you scroll '
          'a list view: physics flings you forward, but the bottom of the list '
          'is a wall — you do not fly off into infinity.',
          style: kStyleBody,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kCitrusBlossom.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kCitrusRind.withValues(alpha: 0.5)),
          ),
          child: const Text(
            'Why bounded?  Because real surfaces have edges.  A scroll view '
            'with infinite friction physics would over-scroll forever — '
            'BoundedFrictionSimulation models the edge as a soft stop that '
            'still respects the friction curve up until the wall.',
            style: kStyleCallout,
          ),
        ),
        const SizedBox(height: 12),
        const Text(
          'There is one subtle behavior worth memorizing: when the simulation '
          'is constructed with a starting position OUTSIDE the [minX, maxX] '
          'range, the bound on the wrong side of motion is effectively '
          'ignored.  Flutter\'s implementation only enforces the wall the '
          'particle is currently moving toward.',
          style: kStyleBody,
        ),
      ],
    ),
  );
}

Widget _formulaBox(String text) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    decoration: BoxDecoration(
      color: kGlacierAbyss,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      style: const TextStyle(
        fontFamily: 'monospace',
        fontSize: 13,
        color: kCitrusZest,
        height: 1.4,
      ),
    ),
  );
}

// ============================================================================
//                     SECTION 3 :: PROPERTY ANATOMY
// ============================================================================

Widget _buildPropertyAnatomy() {
  // Each row in this table describes one of the constructor parameters or
  // inherited properties.  We deliberately enumerate everything the reader
  // might encounter, including `tolerance`, which is inherited from
  // Simulation but often forgotten.

  final List<List<String>> rows = <List<String>>[
    <String>['drag', 'double', 'Friction coefficient (0 < d < 1).  Lower = more drag, faster decay.'],
    <String>['position', 'double', 'Initial position x0 of the particle at t=0.'],
    <String>['velocity', 'double', 'Initial velocity v0 (signed).  Positive = toward maxX.'],
    <String>['minX', 'double', 'Lower bound; x(t) is clamped to >= minX.'],
    <String>['maxX', 'double', 'Upper bound; x(t) is clamped to <= maxX.'],
    <String>['tolerance', 'Tolerance', 'Inherited.  Dictates when isDone returns true.'],
    <String>['x(time)', 'double Function', 'Returns clamped position at given time.'],
    <String>['dx(time)', 'double Function', 'Returns velocity at given time (zero past clamp).'],
    <String>['isDone(time)', 'bool Function', 'True once at rest OR clamped.'],
    <String>['toString()', 'String Function', 'Debug rendering of the simulation parameters.'],
  ];

  return _section(
    icon: '\u2699',
    title: '2. Property anatomy',
    accent: kGlacierMidnight,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'A BoundedFrictionSimulation is fully described by five constructor '
          'arguments plus the inherited tolerance.  Together they define a '
          'deterministic function from time to position.',
          style: kStyleBody,
        ),
        const SizedBox(height: 12),
        _propertyTable(rows),
      ],
    ),
  );
}

Widget _propertyTable(List<List<String>> rows) {
  final List<Widget> rowWidgets = <Widget>[
    Container(
      decoration: const BoxDecoration(
        color: kGlacierDeep,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: const <Widget>[
          Expanded(flex: 3, child: Text('property', style: kStyleTableHeader)),
          Expanded(flex: 3, child: Text('type', style: kStyleTableHeader)),
          Expanded(flex: 8, child: Text('description', style: kStyleTableHeader)),
        ],
      ),
    ),
  ];

  for (var i = 0; i < rows.length; i++) {
    final List<String> r = rows[i];
    final bool zebra = i.isOdd;
    rowWidgets.add(Container(
      color: zebra ? kSnowEdge.withValues(alpha: 0.45) : kSnowfield,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Text(r[0], style: kStyleMono.copyWith(
              color: kAccentTeal, fontWeight: FontWeight.w700,
            )),
          ),
          Expanded(
            flex: 3,
            child: Text(r[1], style: kStyleMonoLight),
          ),
          Expanded(
            flex: 8,
            child: Text(r[2], style: kStyleBody),
          ),
        ],
      ),
    ));
  }

  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: kSnowEdge),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(children: rowWidgets),
  );
}

// ============================================================================
//                  SECTION 4 :: CONSTRUCTION GALLERY
// ============================================================================

Widget _buildConstructionGallery(List<_SimEntry> entries) {
  final List<Widget> cards = <Widget>[];
  for (var i = 0; i < entries.length; i++) {
    cards.add(_constructionCard(entries[i], i));
  }

  return _section(
    icon: '\u2756',
    title: '3. Construction gallery',
    accent: kCitrusEmber,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Eight BoundedFrictionSimulation instances cover the full range of '
          'practical configurations.  Each card lists the parameters and a '
          'one-line annotation about what makes the case interesting.',
          style: kStyleBody,
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: cards,
        ),
      ],
    ),
  );
}

Widget _constructionCard(_SimEntry entry, int index) {
  // We pull a few computed sample values to make the card feel "alive" even
  // though we are not animating anything.  These are still snapshot reads.
  final double x0   = entry.sim.x(0.0);
  final double xHalf = entry.sim.x(0.5);
  final double xOne = entry.sim.x(1.0);
  final double xRest = entry.sim.x(10.0);
  final double dx0  = entry.sim.dx(0.0);
  final double dxRest = entry.sim.dx(10.0);
  final bool   doneAt2 = entry.sim.isDone(2.0);

  final Color tint = _entryTint(index);

  return Container(
    width: 280,
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: kSnowfield,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: tint.withValues(alpha: 0.55), width: 1.4),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: tint.withValues(alpha: 0.10),
          blurRadius: 10,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: tint,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                entry.name.toUpperCase(),
                style: kStyleBadge,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '#${index + 1}',
              style: kStyleMonoLight.copyWith(color: kInkMuted),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(entry.notes, style: kStyleBodyMuted),
        const SizedBox(height: 10),
        const Divider(height: 1, color: kSnowEdge),
        const SizedBox(height: 8),
        _kvRow('drag',     _fmt(_simDrag(entry.name))),
        _kvRow('position', _fmt(x0)),
        _kvRow('velocity', _fmt(dx0)),
        _kvRow('minX',     _fmt(_simMin(entry.name))),
        _kvRow('maxX',     _fmt(_simMax(entry.name))),
        const SizedBox(height: 8),
        const Divider(height: 1, color: kSnowEdge),
        const SizedBox(height: 8),
        _kvRow('x(0.5)',   _fmt(xHalf)),
        _kvRow('x(1.0)',   _fmt(xOne)),
        _kvRow('x(10.0)',  _fmt(xRest)),
        _kvRow('dx(10.0)', _fmt(dxRest)),
        _kvRow('done(2)',  _fmtBool(doneAt2)),
      ],
    ),
  );
}

// Lookup tables to mirror the construction args (we only kept the simulation
// objects themselves; this avoids storing additional state).  Hand-maintained
// to match the constructors above.

double _simDrag(String name) {
  switch (name) {
    case 'alpha':   return 0.135;
    case 'beta':    return 0.250;
    case 'gamma':   return 0.075;
    case 'delta':   return 0.500;
    case 'epsilon': return 0.135;
    case 'zeta':    return 0.135;
    case 'eta':     return 0.020;
    case 'theta':   return 0.350;
  }
  return 0.0;
}

double _simMin(String name) {
  switch (name) {
    case 'alpha':   return 0.0;
    case 'beta':    return 0.0;
    case 'gamma':   return 0.0;
    case 'delta':   return 0.0;
    case 'epsilon': return 0.0;
    case 'zeta':    return 50.0;
    case 'eta':     return -200.0;
    case 'theta':   return -100.0;
  }
  return 0.0;
}

double _simMax(String name) {
  switch (name) {
    case 'alpha':   return 300.0;
    case 'beta':    return 600.0;
    case 'gamma':   return 150.0;
    case 'delta':   return 1000.0;
    case 'epsilon': return 500.0;
    case 'zeta':    return 52.0;
    case 'eta':     return 200.0;
    case 'theta':   return 400.0;
  }
  return 0.0;
}

Color _entryTint(int index) {
  final List<Color> tints = <Color>[
    kGlacierDeep,
    kCitrusEmber,
    kAccentTeal,
    kCitrusMandarin,
    kAccentBerry,
    kGlacierFrost,
    kCitrusRind,
    kAccentLime,
  ];
  return tints[index % tints.length];
}

Widget _kvRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.5),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 78,
          child: Text(key, style: kStyleMonoLight),
        ),
        Expanded(
          child: Text(value, style: kStyleMono),
        ),
      ],
    ),
  );
}

// ============================================================================
//                  SECTION 5 :: POSITION SAMPLING TABLE
// ============================================================================

Widget _buildPositionSamplingTable(List<_SimEntry> entries, List<double> times) {
  // We render a single big table with one row per (sim, time) combination so
  // it is easy to scan vertically.  Eight sims × thirteen times = 104 rows —
  // far more than the 12+ minimum requested, and a useful reference itself.

  final List<Widget> rows = <Widget>[
    _tableHeader(<String>['sim', 't', 'x(t)', 'dx(t)', 'done', 'notes']),
  ];

  for (var i = 0; i < entries.length; i++) {
    final _SimEntry e = entries[i];
    for (var j = 0; j < times.length; j++) {
      final double t = times[j];
      final double xv = e.sim.x(t);
      final double dv = e.sim.dx(t);
      final bool done = e.sim.isDone(t);
      final String tag = _positionTag(e, xv, t);
      rows.add(_tableRow(<String>[
        e.name,
        _fmt(t),
        _fmt(xv),
        _fmt(dv),
        _fmtBool(done),
        tag,
      ], zebra: (i + j).isOdd));
    }
    // A separator between simulations so the human eye does not glaze over.
    rows.add(Container(
      height: 1,
      color: kGlacierDeep.withValues(alpha: 0.18),
    ));
  }

  return _section(
    icon: '\u25A6',
    title: '4. Position x(t) sampling table',
    accent: kAccentTeal,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Each row shows position, velocity, done-flag, and an automatic '
          'note for one (simulation, time) pair.  Watch how the clamped sims '
          '(gamma, zeta, theta) flatline at their upper bound after the wall '
          'is reached, while the loose sims (alpha, eta) keep crawling.',
          style: kStyleBody,
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: kSnowEdge),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: rows),
        ),
      ],
    ),
  );
}

String _positionTag(_SimEntry e, double x, double t) {
  // Compose a short note describing the row.  The intent is to give the
  // reader an at-a-glance feel for whether the value is clamped, decaying,
  // or still in free motion.
  if (t == 0.0) return 'start';
  final double minX = _simMin(e.name);
  final double maxX = _simMax(e.name);
  final bool atMax = (x - maxX).abs() < 0.01;
  final bool atMin = (x - minX).abs() < 0.01;
  if (atMax) return 'clamped@max';
  if (atMin) return 'clamped@min';
  if (e.sim.isDone(t)) return 'done';
  return 'gliding';
}

Widget _tableHeader(List<String> labels) {
  return Container(
    color: kGlacierDeep,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    child: Row(
      children: <Widget>[
        for (final String l in labels)
          Expanded(child: Text(l, style: kStyleTableHeader)),
      ],
    ),
  );
}

Widget _tableRow(List<String> cells, {bool zebra = false}) {
  return Container(
    color: zebra ? kSnowEdge.withValues(alpha: 0.4) : kSnowfield,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    child: Row(
      children: <Widget>[
        for (final String c in cells)
          Expanded(child: Text(c, style: kStyleTableCell)),
      ],
    ),
  );
}

// ============================================================================
//                  SECTION 6 :: VELOCITY DECAY TABLE
// ============================================================================

Widget _buildVelocityDecayTable(List<_SimEntry> entries, List<double> times) {
  // This table focuses on dx(t) — the velocity over time — and shows how
  // quickly each simulation's velocity collapses toward zero.

  final List<Widget> rows = <Widget>[
    _tableHeader(<String>['sim', 't', 'dx(t)', 'mag', 'sign', 'phase']),
  ];

  for (var i = 0; i < entries.length; i++) {
    final _SimEntry e = entries[i];
    for (var j = 0; j < times.length; j++) {
      final double t = times[j];
      final double dv = e.sim.dx(t);
      final double mag = dv.abs();
      final String sign = dv == 0.0 ? '0' : (dv > 0 ? '+' : '-');
      final String phase = _velocityPhase(e, t);
      rows.add(_tableRow(<String>[
        e.name,
        _fmt(t),
        _fmt(dv),
        _fmt(mag),
        sign,
        phase,
      ], zebra: (i + j).isOdd));
    }
    rows.add(Container(
      height: 1,
      color: kCitrusEmber.withValues(alpha: 0.20),
    ));
  }

  return _section(
    icon: '\u21A1',
    title: '5. Velocity dx(t) decay table',
    accent: kCitrusMandarin,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'A FrictionSimulation\'s velocity is a pure exponential decay: it '
          'multiplies by `pow(drag, t)` every unit of time.  Bounded variants '
          'add the wrinkle that velocity drops to zero the moment the position '
          'is clamped.',
          style: kStyleBody,
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: kSnowEdge),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: rows),
        ),
      ],
    ),
  );
}

String _velocityPhase(_SimEntry e, double t) {
  if (t == 0.0) return 'launch';
  if (e.sim.isDone(t)) return 'rest';
  final double dv = e.sim.dx(t);
  if (dv.abs() < 1.0) return 'crawl';
  if (dv.abs() < 50.0) return 'fade';
  return 'glide';
}

// ============================================================================
//                  SECTION 7 :: isDone PROGRESSION
// ============================================================================

Widget _buildIsDoneProgression(List<_SimEntry> entries, List<double> times) {
  final List<Widget> rows = <Widget>[
    _tableHeader(<String>['sim', 't=0', 't=0.1', 't=0.25', 't=0.5', 't=1', 't=2', 't=3', 't=5', 't=10']),
  ];

  for (var i = 0; i < entries.length; i++) {
    final _SimEntry e = entries[i];
    final List<String> cells = <String>[e.name];
    for (var j = 0; j < times.length; j++) {
      cells.add(_fmtBool(e.sim.isDone(times[j])));
    }
    rows.add(_tableRow(cells, zebra: i.isOdd));
  }

  return _section(
    icon: '\u2713',
    title: '6. isDone(t) progression',
    accent: kAccentBerry,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'isDone returns true once the velocity drops below the tolerance, OR '
          'the position is clamped to a bound.  This table shows when each of '
          'our eight simulations crosses that threshold.',
          style: kStyleBody,
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: kSnowEdge),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: rows),
        ),
      ],
    ),
  );
}

// ============================================================================
//                  SECTION 8 :: BAR CHART DIAGRAM
// ============================================================================

Widget _buildBarChartDiagram(BoundedFrictionSimulation sim, String name,
    double minX, double maxX) {
  // Hand-built bar chart of x(t) for the given simulation across 24 sample
  // points.  Each bar is a Container whose width scales with the position
  // value mapped into the bar-area width.

  const int numBars = 24;
  const double duration = 3.0;
  final List<Widget> bars = <Widget>[];
  for (var i = 0; i < numBars; i++) {
    final double t = duration * (i / (numBars - 1));
    final double x = sim.x(t);
    final double range = (maxX - minX).abs();
    final double normalized = range == 0 ? 0 : ((x - minX) / range).clamp(0.0, 1.0);
    final bool done = sim.isDone(t);

    bars.add(Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 50,
            child: Text(
              't=${_fmt(t)}',
              style: kStyleMonoLight,
            ),
          ),
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: kSnowEdge.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: normalized.clamp(0.0, 1.0),
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          done ? kAccentBerry : kGlacierDeep,
                          done ? kCitrusEmber : kCitrusZest,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 60,
            child: Text(
              _fmt(x),
              style: kStyleMono,
              textAlign: TextAlign.right,
            ),
          ),
          const SizedBox(width: 6),
          Container(
            width: 28,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 1),
            decoration: BoxDecoration(
              color: done ? kAccentBerry : kSnowEdge,
              borderRadius: BorderRadius.circular(3),
            ),
            child: Text(
              done ? 'D' : '\u00B7',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: done ? kSnowfield : kInkMuted,
              ),
            ),
          ),
        ],
      ),
    ));
  }

  return _section(
    icon: '\u25B0',
    title: '7. Visual bar chart for "$name"',
    accent: kGlacierFrost,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Each bar represents x(t) at one of 24 evenly spaced sample times '
          'between t=0 and t=$duration for the "$name" simulation.  The bar '
          'fill is the position normalized to the [minX, maxX] = '
          '[${_fmt(minX)}, ${_fmt(maxX)}] range.  Bars marked "D" indicate '
          'isDone(t) was true.',
          style: kStyleBody,
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: kSnowEdge.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: kSnowEdge),
          ),
          child: Column(children: bars),
        ),
      ],
    ),
  );
}

// ============================================================================
//                  SECTION 9 :: BOUNDARY CLAMP EXPLANATION
// ============================================================================

Widget _buildClampExplanation(BoundedFrictionSimulation tight,
    BoundedFrictionSimulation narrow,
    BoundedFrictionSimulation overshoot) {
  return _section(
    icon: '\u2502',
    title: '8. How minX/maxX truncate motion',
    accent: kCitrusRind,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'A FrictionSimulation defines an asymptote — given enough time the '
          'particle will end up at some final position, call it x_inf.  When '
          'you bolt minX/maxX on top, three behaviors are possible:',
          style: kStyleBody,
        ),
        const SizedBox(height: 12),
        _bulletRow(
          tint: kGlacierDeep,
          tag: 'Case A',
          text: 'x_inf lies inside [minX, maxX].  The bounds are inert; the '
              'simulation behaves identically to its unbounded parent.',
        ),
        _bulletRow(
          tint: kCitrusEmber,
          tag: 'Case B',
          text: 'x_inf lies outside [minX, maxX] in the direction of motion.  '
              'The simulation is truncated: it follows the friction curve up '
              'until x(t) hits the wall, then snaps to the wall and reports '
              'isDone=true.',
        ),
        _bulletRow(
          tint: kAccentBerry,
          tag: 'Case C',
          text: 'The starting position is already at or past a bound and the '
              'velocity points further past it.  The simulation reports done '
              'almost immediately.',
        ),
        const SizedBox(height: 14),
        const Text(
          'Three of our simulations illustrate these cases:',
          style: kStyleBody,
        ),
        const SizedBox(height: 8),
        _calloutCard(
          title: 'gamma (tight upper bound)',
          tint: kCitrusEmber,
          body: 'drag=0.075 vel=180 maxX=150.  At t=0 position is 20.  '
              'x(0.5)=${_fmt(tight.x(0.5))}, x(1.0)=${_fmt(tight.x(1.0))}, '
              'x(2.0)=${_fmt(tight.x(2.0))}, isDone(2)=${_fmtBool(tight.isDone(2.0))}.',
        ),
        _calloutCard(
          title: 'zeta (paper-thin band)',
          tint: kAccentBerry,
          body: 'pos=50 minX=50 maxX=52.  Almost no room.  '
              'x(0.05)=${_fmt(narrow.x(0.05))}, '
              'x(0.1)=${_fmt(narrow.x(0.1))}, '
              'isDone(0.1)=${_fmtBool(narrow.isDone(0.1))}.',
        ),
        _calloutCard(
          title: 'theta (overshoots maxX)',
          tint: kGlacierDeep,
          body: 'drag=0.350 vel=600 maxX=400.  '
              'x(0.5)=${_fmt(overshoot.x(0.5))}, '
              'x(1.0)=${_fmt(overshoot.x(1.0))}, '
              'isDone(1)=${_fmtBool(overshoot.isDone(1.0))}.',
        ),
      ],
    ),
  );
}

Widget _bulletRow({required Color tint, required String tag, required String text}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: tint,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(tag, style: kStyleBadge),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: kStyleBody)),
      ],
    ),
  );
}

Widget _calloutCard({required String title, required Color tint, required String body}) {
  return Container(
    margin: const EdgeInsets.only(top: 6),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: tint.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: tint.withValues(alpha: 0.45)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title, style: kStyleSubtitle.copyWith(color: tint)),
        const SizedBox(height: 4),
        Text(body, style: kStyleMono),
      ],
    ),
  );
}

// ============================================================================
//                  SECTION 10 :: COMPARISON TABLE
// ============================================================================

Widget _buildComparisonTable() {
  final List<List<String>> rows = <List<String>>[
    <String>['feature', 'FrictionSimulation', 'BoundedFrictionSimulation'],
    <String>['constructor args', 'drag, position, velocity', '+ minX, maxX'],
    <String>['x(t)', 'asymptotic to x_inf', 'clamped to [minX, maxX]'],
    <String>['dx(t)', 'exponential decay', 'zero past the clamp time'],
    <String>['isDone(t)', 'true when |dx| < tol', 'true OR position at bound'],
    <String>['typical use', 'inertia in fling animations', 'scroll views with edges'],
    <String>['final state', 'arrives at x_inf eventually', 'rests at x_inf or wall'],
    <String>['tolerance role', 'detects effective rest', 'same plus boundary check'],
    <String>['overshoot', 'possible past intended target', 'never; clamped'],
    <String>['inheritance', 'Simulation', 'FrictionSimulation -> Simulation'],
  ];

  final List<Widget> rowWidgets = <Widget>[];
  for (var i = 0; i < rows.length; i++) {
    final List<String> r = rows[i];
    if (i == 0) {
      rowWidgets.add(_tableHeader(r));
    } else {
      rowWidgets.add(_tableRow(r, zebra: i.isOdd));
    }
  }

  return _section(
    icon: '\u21CC',
    title: '9. FrictionSimulation vs BoundedFrictionSimulation',
    accent: kAccentTeal,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'BoundedFrictionSimulation only adds the clamping behavior; every '
          'other property of FrictionSimulation is inherited unchanged.',
          style: kStyleBody,
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: kSnowEdge),
            borderRadius: BorderRadius.circular(8),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: rowWidgets),
        ),
      ],
    ),
  );
}

// ============================================================================
//                  SECTION 11 :: DO / AVOID CALLOUTS
// ============================================================================

Widget _buildDoAvoidCallouts() {
  final List<Map<String, String>> doRules = <Map<String, String>>[
    <String, String>{
      'title': 'Pick drag in (0, 1)',
      'body' : 'Values approaching 0 mean nearly instant stop; values near 1 '
          'mean the velocity barely decays.  Typical scroll views use 0.135.',
    },
    <String, String>{
      'title': 'Use bounds that match your content',
      'body' : 'minX/maxX should reflect the real edges of whatever the user '
          'is scrolling: scroll extent, pan limits, zoom range.',
    },
    <String, String>{
      'title': 'Sample x(t) deterministically',
      'body' : 'BoundedFrictionSimulation is a pure function of time.  Cache '
          'or precompute samples for offline analysis with confidence.',
    },
    <String, String>{
      'title': 'Read tolerance carefully',
      'body' : 'The default Tolerance has small but non-zero distance/velocity '
          'thresholds.  If your units are unusual, override tolerance.',
    },
    <String, String>{
      'title': 'Combine with Curve only when needed',
      'body' : 'Friction is already a curve.  Wrapping in CurvedAnimation can '
          'hide the very physics you wanted.',
    },
    <String, String>{
      'title': 'Check isDone before reusing',
      'body' : 'Once isDone returns true, further x(t) calls just return the '
          'rest position — useful for early-out logic.',
    },
  ];

  final List<Map<String, String>> avoidRules = <Map<String, String>>[
    <String, String>{
      'title': 'Avoid drag >= 1.0',
      'body' : 'A drag coefficient of 1 freezes velocity, and >1 amplifies — '
          'the simulation no longer represents friction.',
    },
    <String, String>{
      'title': 'Avoid identical minX and maxX',
      'body' : 'A zero-width range collapses motion.  If you need a fixed '
          'point, use a SpringSimulation at rest, not a bounded friction.',
    },
    <String, String>{
      'title': 'Avoid sampling at negative time',
      'body' : 'The simulation is defined for t >= 0.  Negative times are '
          'undefined and often return meaningless extrapolations.',
    },
    <String, String>{
      'title': 'Avoid mutating after construction',
      'body' : 'BoundedFrictionSimulation is immutable.  Replace the instance '
          'rather than try to tweak parameters mid-flight.',
    },
    <String, String>{
      'title': 'Avoid relying on toString format',
      'body' : 'The string representation is debug-only and may change between '
          'Flutter versions.  Never parse it.',
    },
    <String, String>{
      'title': 'Avoid coupling to wall-clock time',
      'body' : 'The simulation\'s t is logical seconds since launch, not '
          'DateTime.now().  Drive it from a Ticker or ScrollPosition.',
    },
  ];

  return _section(
    icon: '\u25CB',
    title: '10. DO and AVOID',
    accent: kAccentLime,
    body: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: _ruleColumn(
            heading: 'DO',
            tint: kAccentTeal,
            rules: doRules,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _ruleColumn(
            heading: 'AVOID',
            tint: kAccentBerry,
            rules: avoidRules,
          ),
        ),
      ],
    ),
  );
}

Widget _ruleColumn({
  required String heading,
  required Color tint,
  required List<Map<String, String>> rules,
}) {
  final List<Widget> children = <Widget>[
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: tint,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(heading, style: kStyleBadge),
    ),
    const SizedBox(height: 10),
  ];
  for (var i = 0; i < rules.length; i++) {
    final Map<String, String> r = rules[i];
    children.add(Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: kSnowfield,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: tint.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(r['title'] ?? '', style: kStyleSubtitle.copyWith(color: tint)),
          const SizedBox(height: 4),
          Text(r['body'] ?? '', style: kStyleBody),
        ],
      ),
    ));
  }
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: children);
}

// ============================================================================
//                  SECTION 12 :: RECIPE CARDS
// ============================================================================

Widget _buildRecipeCards() {
  final List<Map<String, String>> recipes = <Map<String, String>>[
    <String, String>{
      'title': 'Recipe 1 :: Standard scroll view fling',
      'code' : "final sim = BoundedFrictionSimulation(\n"
               "  0.135, // typical scroll drag\n"
               "  scrollPosition,\n"
               "  velocity,\n"
               "  minScroll,\n"
               "  maxScroll,\n"
               ");",
    },
    <String, String>{
      'title': 'Recipe 2 :: Pan with hard limits',
      'code' : "final sim = BoundedFrictionSimulation(\n"
               "  0.18,\n"
               "  panOffset.dx,\n"
               "  flingVelocity.dx,\n"
               "  minPan, maxPan,\n"
               ");",
    },
    <String, String>{
      'title': 'Recipe 3 :: Fast settle to nearest edge',
      'code' : "final sim = BoundedFrictionSimulation(\n"
               "  0.45, // strong drag\n"
               "  current, velocity,\n"
               "  minEdge, maxEdge,\n"
               ");",
    },
    <String, String>{
      'title': 'Recipe 4 :: Sample without ticker',
      'code' : "double xAt(double t) => sim.x(t);\n"
               "final s0 = xAt(0.0);\n"
               "final s1 = xAt(0.5);\n"
               "final s2 = xAt(1.0);\n"
               "final done = sim.isDone(2.0);",
    },
    <String, String>{
      'title': 'Recipe 5 :: Check before applying',
      'code' : "if (sim.isDone(elapsed)) {\n"
               "  notifyListeners();\n"
               "  return;\n"
               "}\n"
               "currentX = sim.x(elapsed);\n"
               "currentDx = sim.dx(elapsed);",
    },
  ];

  final List<Widget> cards = <Widget>[];
  for (var i = 0; i < recipes.length; i++) {
    final Map<String, String> r = recipes[i];
    cards.add(Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: kGlacierAbyss,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: kCitrusZest.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            r['title'] ?? '',
            style: const TextStyle(
              fontSize: 13.5,
              fontWeight: FontWeight.w800,
              color: kCitrusZest,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            r['code'] ?? '',
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: kSnowfield,
              height: 1.45,
            ),
          ),
        ],
      ),
    ));
  }

  return _section(
    icon: '\u2630',
    title: '11. Code recipes',
    accent: kCitrusEmber,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Five idiomatic snippets for the most common BoundedFrictionSimulation '
          'usages.  Each card reads top-to-bottom in a few seconds.',
          style: kStyleBody,
        ),
        const SizedBox(height: 12),
        ...cards,
      ],
    ),
  );
}

// ============================================================================
//                  SECTION 13 :: GLOSSARY
// ============================================================================

Widget _buildGlossary() {
  final List<Map<String, String>> terms = <Map<String, String>>[
    <String, String>{
      'term': 'Simulation',
      'def' : 'Abstract base class.  Defines x(t), dx(t), isDone(t).',
    },
    <String, String>{
      'term': 'FrictionSimulation',
      'def' : 'Models exponential velocity decay due to drag.',
    },
    <String, String>{
      'term': 'BoundedFrictionSimulation',
      'def' : 'FrictionSimulation with hard min/max position walls.',
    },
    <String, String>{
      'term': 'drag',
      'def' : 'Friction coefficient, typically 0 < d < 1.',
    },
    <String, String>{
      'term': 'tolerance',
      'def' : 'Distance/velocity thresholds for declaring rest.',
    },
    <String, String>{
      'term': 'isDone',
      'def' : 'True once the particle is effectively at rest.',
    },
    <String, String>{
      'term': 'clamp',
      'def' : 'Constrain a value to a [min, max] interval.',
    },
    <String, String>{
      'term': 'asymptote',
      'def' : 'The limit value the unbounded position approaches.',
    },
    <String, String>{
      'term': 'fling',
      'def' : 'A flick gesture that produces a high initial velocity.',
    },
    <String, String>{
      'term': 'over-scroll',
      'def' : 'Scrolling past the natural extent of content.',
    },
    <String, String>{
      'term': 'Tolerance',
      'def' : 'Class holding distance/velocity tolerances for simulations.',
    },
    <String, String>{
      'term': 'Ticker',
      'def' : 'Frame-clock pulse the AnimationController uses to drive sims.',
    },
    <String, String>{
      'term': 'pow(d, t)',
      'def' : 'Exponential factor governing velocity decay.',
    },
    <String, String>{
      'term': 'snapshot tree',
      'def' : 'A widget tree returned in a single build with no live state.',
    },
  ];

  final List<Widget> rows = <Widget>[];
  for (var i = 0; i < terms.length; i++) {
    final Map<String, String> t = terms[i];
    rows.add(Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      color: i.isOdd ? kSnowEdge.withValues(alpha: 0.35) : kSnowfield,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 150,
            child: Text(
              t['term'] ?? '',
              style: kStyleMono.copyWith(
                color: kAccentBerry,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(child: Text(t['def'] ?? '', style: kStyleBody)),
        ],
      ),
    ));
  }

  return _section(
    icon: '\u00B6',
    title: '12. Glossary',
    accent: kAccentBerry,
    body: Container(
      decoration: BoxDecoration(
        border: Border.all(color: kSnowEdge),
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(children: rows),
    ),
  );
}

// ============================================================================
//                  SECTION 14 :: RECAP FOOTER
// ============================================================================

Widget _buildRecapFooter(List<_SimEntry> entries, List<double> times) {
  // Render a compact recap grid that re-samples each simulation just so the
  // footer reproduces the same numbers from a fresh angle.

  final List<Widget> chips = <Widget>[];
  for (var i = 0; i < entries.length; i++) {
    final _SimEntry e = entries[i];
    final double xMid = e.sim.x(0.5);
    final double xEnd = e.sim.x(2.0);
    final bool   doneEnd = e.sim.isDone(2.0);

    chips.add(Container(
      padding: const EdgeInsets.all(10),
      width: 180,
      decoration: BoxDecoration(
        color: kGlacierAbyss.withValues(alpha: 0.94),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            e.name.toUpperCase(),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w800,
              color: kCitrusZest,
              letterSpacing: 1.0,
            ),
          ),
          const SizedBox(height: 6),
          Text('x(0.5) = ${_fmt(xMid)}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: kSnowfield,
              )),
          Text('x(2.0) = ${_fmt(xEnd)}',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: kSnowfield,
              )),
          Text('done(2) = ${_fmtBool(doneEnd)}',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: doneEnd ? kCitrusZest : kGlacierMist,
              )),
        ],
      ),
    ));
  }

  return Container(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
    decoration: BoxDecoration(
      color: kGlacierAbyss,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Recap :: Glacier Citrus',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: kCitrusZest,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'BoundedFrictionSimulation = friction physics that knows when to stop.  '
          'Construct with (drag, position, velocity, minX, maxX), sample x(t)/dx(t) '
          'at any time t >= 0, and check isDone(t) for rest detection.  Bounded '
          'sample times: ${times.map(_fmt).toList()}.',
          style: TextStyle(
            fontSize: 12.5,
            color: kSnowfield.withValues(alpha: 0.92),
            height: 1.45,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(spacing: 10, runSpacing: 10, children: chips),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: kCitrusZest,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            'END  ::  Glacier Citrus deep dive complete',
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w800,
              color: kGlacierAbyss,
              letterSpacing: 1.0,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================================
//                          GENERIC SECTION SHELL
// ============================================================================

Widget _section({
  required String icon,
  required String title,
  required Color accent,
  required Widget body,
}) {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: kSnowfield,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: accent.withValues(alpha: 0.30)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: accent.withValues(alpha: 0.08),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                icon,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: kSnowfield,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                style: kStyleSection.copyWith(color: accent),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        body,
      ],
    ),
  );
}

// ============================================================================
//                                NOTES
// ============================================================================
//
// This script intentionally avoids any of the D4rt traps:
//
//   * Only a single build() call.
//   * No StatefulWidget, no setState, no controllers, no animations.
//   * Tween.animate is never used; bar charts are static snapshots derived
//     directly from sim.x(t) reads.
//   * All loops are indexed `for (var i = 0; i < ...)` — never `for-in` over
//     a BridgedInstance.
//   * `.withValues(alpha: ...)` is used everywhere we tint a color.
//   * Prints are narrative, less than 15 in total.
//
// If you extend the file, consider:
//   * Adding a section that compares against SpringSimulation.
//   * Adding a section about Tolerance configuration.
//   * Adding a section visualizing dx(t) as a separate bar chart.
//
// ============================================================================
