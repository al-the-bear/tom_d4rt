// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ClampingScrollSimulation
// Demonstrates ClampingScrollSimulation, the physics simulation used
// by ClampingScrollPhysics to produce Android-style scroll behaviour.
// Content decelerates to a stop exactly at the edge — never
// overshooting. Covers the friction curve, constructor parameters,
// deceleration math, comparison with BouncingScrollSimulation,
// glow indicator relationship, and real-world patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ClampingScrollSimulation Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is ClampingScrollSimulation?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.android,
      'title': 'Android-Style Scroll Deceleration',
      'body': 'ClampingScrollSimulation models the fling deceleration '
          'used by Android\'s OverScroller class. When the user lifts '
          'their finger while scrolling, this simulation computes a '
          'smooth deceleration curve that brings the content to a '
          'complete stop. If the content reaches an edge, it stops '
          'there — clamped, with no overshoot.',
      'accent': Colors.green[700]!,
    },
    {
      'icon': Icons.block,
      'title': 'Hard Stop at Boundaries',
      'body': 'Unlike BouncingScrollSimulation (iOS), clamping never '
          'lets the position go past min/max. The position is '
          'mathematically clamped: if the simulation curve would '
          'exceed the boundary, it is truncated right at the edge. '
          'This is why Android lists don\'t show overscroll content.',
      'accent': Colors.green[800]!,
    },
    {
      'icon': Icons.show_chart,
      'title': 'The Friction Curve',
      'body': 'The deceleration is NOT a simple exponential decay. '
          'Flutter\'s implementation mirrors Android\'s spline-based '
          'fling curve, which decelerates non-linearly: fast at first, '
          'then gradually slower. The total distance and duration '
          'depend on the initial velocity and a friction factor '
          'derived from the device\'s physical DPI.',
      'accent': Colors.teal[700]!,
    },
    {
      'icon': Icons.construction,
      'title': 'Constructor Parameters',
      'body': 'The constructor takes:\n'
          '• position — current scroll offset (pixels)\n'
          '• velocity — fling velocity (pixels/sec)\n'
          '• friction — drag coefficient (default ~0.015)\n'
          '• tolerance — when to consider motion stopped\n'
          'These determine the shape and duration of the fling.',
      'accent': Colors.teal[800]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Velocity & Distance Relationship
  // ============================================================
  print('=== Section 2: Velocity & Distance ===');

  // Create several simulations with different velocities to show
  // how initial velocity maps to travel distance
  final velocityTests = <Map<String, dynamic>>[
    {'velocity': 500.0, 'label': 'Gentle flick', 'color': Colors.green[300]!},
    {'velocity': 1000.0, 'label': 'Normal fling', 'color': Colors.green[500]!},
    {'velocity': 2000.0, 'label': 'Fast swipe', 'color': Colors.green[700]!},
    {'velocity': 4000.0, 'label': 'Very fast', 'color': Colors.teal[600]!},
    {'velocity': 8000.0, 'label': 'Maximum effort', 'color': Colors.teal[800]!},
  ];

  final velocityData = <Map<String, dynamic>>[];
  for (final vt in velocityTests) {
    final sim = ClampingScrollSimulation(
      position: 0.0,
      velocity: vt['velocity'] as double,
    );
    // Sample positions at regular intervals
    final positions = <double>[];
    double lastPos = 0.0;
    for (double t = 0.0; t <= 4.0; t += 0.05) {
      final pos = sim.x(t);
      positions.add(pos);
      if (pos > lastPos) lastPos = pos;
      if (sim.isDone(t)) break;
    }
    velocityData.add({
      'label': vt['label'],
      'velocity': vt['velocity'],
      'color': vt['color'],
      'distance': lastPos.toStringAsFixed(0),
      'positions': positions,
    });
  }

  print('  Computed ${velocityData.length} velocity→distance profiles');

  // ============================================================
  // SECTION 3: Position Over Time Sampling
  // ============================================================
  print('=== Section 3: Position Over Time ===');

  // Detailed time-series for three representative simulations
  final simSlow = ClampingScrollSimulation(
    position: 0.0,
    velocity: 800.0,
  );
  final simMed = ClampingScrollSimulation(
    position: 0.0,
    velocity: 2000.0,
  );
  final simFast = ClampingScrollSimulation(
    position: 0.0,
    velocity: 5000.0,
  );

  final timePoints = [0.0, 0.05, 0.1, 0.2, 0.3, 0.5, 0.7, 1.0, 1.5, 2.0, 3.0];
  final timeRows = <Map<String, String>>[];
  for (final t in timePoints) {
    timeRows.add({
      'time': '${t}s',
      'slow': simSlow.x(t).toStringAsFixed(0),
      'med': simMed.x(t).toStringAsFixed(0),
      'fast': simFast.x(t).toStringAsFixed(0),
      'velSlow': simSlow.dx(t).toStringAsFixed(0),
      'velMed': simMed.dx(t).toStringAsFixed(0),
      'velFast': simFast.dx(t).toStringAsFixed(0),
    });
  }

  print('  Sampled ${timeRows.length} time points across 3 velocities');

  // ============================================================
  // SECTION 4: The Deceleration Curve
  // ============================================================
  print('=== Section 4: Deceleration Curve ===');

  final curveFeatures = <Map<String, dynamic>>[
    {
      'title': 'Non-Linear Deceleration',
      'icon': Icons.trending_down,
      'color': Colors.green[600]!,
      'body': 'The velocity does not decay at a constant rate. '
          'Early frames lose velocity quickly (high deceleration), '
          'while later frames barely change (low deceleration). '
          'This produces the distinctive Android "ease-out" feel '
          'where fast flings seem to glide gracefully to a stop.',
    },
    {
      'title': 'Android OverScroller Heritage',
      'icon': Icons.history,
      'color': Colors.teal[600]!,
      'body': 'Flutter\'s curve closely mirrors Android\'s native '
          'OverScroller.fling() which uses a spline interpolation '
          'table. The total duration is computed from initial '
          'velocity using: duration = log(0.35 * |velocity| / '
          'friction) / log(friction_per_frame).',
    },
    {
      'title': 'Friction Factor',
      'icon': Icons.speed,
      'color': Colors.green[700]!,
      'body': 'The friction parameter (default ~0.015) controls how '
          'quickly the simulation decelerates. Lower friction means '
          'longer coasting; higher friction means quicker stops. '
          'The default value was tuned to match the feel of physical '
          'Android devices.',
    },
    {
      'title': 'Duration Is Pre-Computed',
      'icon': Icons.timer,
      'color': Colors.teal[700]!,
      'body': 'Unlike BouncingScrollSimulation, which can run '
          'indefinitely (oscillating springs), ClampingScroll'
          'Simulation has a finite duration computed at construction. '
          'After that time, isDone() returns true and the scroll '
          'activity transitions to idle.',
    },
  ];

  print('  Prepared ${curveFeatures.length} curve feature cards');

  // ============================================================
  // SECTION 5: Boundary Clamping Behaviour
  // ============================================================
  print('=== Section 5: Boundary Clamping ===');

  final clampScenarios = <Map<String, dynamic>>[
    {
      'title': 'Mid-Content Fling',
      'icon': Icons.swap_vert,
      'scenario': 'pos=500, vel=1500, range=[0, 2000]',
      'color': Colors.green[500]!,
      'description': 'The fling starts well within bounds and the '
          'velocity is not enough to reach either edge. The '
          'simulation runs its full deceleration curve. No '
          'clamping occurs.',
    },
    {
      'title': 'Fling Toward Bottom Edge',
      'icon': Icons.vertical_align_bottom,
      'scenario': 'pos=1800, vel=2000, range=[0, 2000]',
      'color': Colors.orange[600]!,
      'description': 'The fling would carry the position past 2000. '
          'ClampingScrollSimulation detects this and terminates '
          'the simulation exactly at 2000. The remaining velocity '
          'is absorbed — no bounce, no overshoot.',
    },
    {
      'title': 'Fling Toward Top Edge',
      'icon': Icons.vertical_align_top,
      'scenario': 'pos=200, vel=-3000, range=[0, 2000]',
      'color': Colors.red[500]!,
      'description': 'A fast upward fling would go past 0. The '
          'simulation clamps at 0 and stops. The overscroll event '
          'is communicated to the glow indicator system separately.',
    },
    {
      'title': 'Already at Edge, Zero Velocity',
      'icon': Icons.pan_tool,
      'scenario': 'pos=0, vel=0, range=[0, 2000]',
      'color': Colors.grey[600]!,
      'description': 'If the position is already at the edge with no '
          'velocity, the simulation is immediately done. isDone(0) '
          'returns true. No visual motion occurs.',
    },
  ];

  print('  Prepared ${clampScenarios.length} clamping scenarios');

  // ============================================================
  // SECTION 6: Glow Indicator Integration
  // ============================================================
  print('=== Section 6: Glow Indicator ===');

  final glowDetails = <Map<String, dynamic>>[
    {
      'title': 'Why a Glow Instead of Bounce?',
      'icon': Icons.lightbulb,
      'color': Colors.amber[700]!,
      'body': 'Since clamping prevents the content from moving past '
          'edges, the user needs another visual signal that they\'ve '
          'reached the end. Android\'s answer: a glowing arc painted '
          'at the list edge (GlowingOverscrollIndicator). Flutter '
          'replicates this by default on Android.',
    },
    {
      'title': 'OverscrollNotification',
      'icon': Icons.notifications_active,
      'color': Colors.orange[600]!,
      'body': 'When ClampingScrollSimulation hits a boundary, the '
          'remaining velocity is reported via OverscrollNotification. '
          'GlowingOverscrollIndicator listens for this notification '
          'and calculates the glow intensity from the overscroll '
          'amount.',
    },
    {
      'title': 'StretchingOverscrollIndicator',
      'icon': Icons.open_with,
      'color': Colors.teal[600]!,
      'body': 'From Android 12 (S), the stretch overscroll replaces '
          'the glow. Flutter provides StretchingOverscrollIndicator '
          'for this. It works with the same notification mechanism '
          'but applies a horizontal/vertical stretch transform.',
    },
    {
      'title': 'Disabling the Indicator',
      'icon': Icons.do_not_disturb,
      'color': Colors.red[400]!,
      'body': 'Wrap your scrollable in NotificationListener<Overscroll'
          'Notification> and return true to suppress the glow:\n\n'
          'NotificationListener<OverscrollNotification>(\n'
          '  onNotification: (_) => true, // absorb\n'
          '  child: ListView(...),\n'
          ')',
    },
  ];

  print('  Listed ${glowDetails.length} glow indicator details');

  // ============================================================
  // SECTION 7: Bouncing vs Clamping — Simulation Internals
  // ============================================================
  print('=== Section 7: Simulation Internals Comparison ===');

  final internalComparison = <Map<String, String>>[
    {
      'aspect': 'Math Model',
      'clamping': 'Spline-based curve modeled after '
          'Android OverScroller. Duration and '
          'distance pre-computed from velocity.',
      'bouncing': 'FrictionSimulation (exponential '
          'decay) + SpringSimulation at '
          'boundaries. Duration emergent.',
    },
    {
      'aspect': 'Duration',
      'clamping': 'Finite and known at construction. '
          'Typically 0.3–2.5 seconds for '
          'normal fling velocities.',
      'bouncing': 'Theoretically infinite (spring '
          'oscillation), practically ended '
          'by tolerance threshold.',
    },
    {
      'aspect': 'Position Range',
      'clamping': 'Always within [position, boundary]. '
          'Never exceeds the scroll extent.',
      'bouncing': 'Can exceed scroll extent. Springs '
          'back, but momentarily overshoots.',
    },
    {
      'aspect': 'Velocity at End',
      'clamping': 'Approaches zero asymptotically or '
          'hits boundary with remaining '
          'velocity (overscroll notification).',
      'bouncing': 'Zero when friction stops. Non-zero '
          'at boundary → spring takes over.',
    },
    {
      'aspect': 'Customization',
      'clamping': 'Friction parameter only. Hard to '
          'customize the curve shape further.',
      'bouncing': 'SpringDescription (mass, stiffness, '
          'damping) + drag coefficient. Very '
          'tunable.',
    },
    {
      'aspect': 'User Feedback',
      'clamping': 'Glow/stretch indicator painted '
          'above the list content.',
      'bouncing': 'Content itself overshoots, revealing '
          'empty space or background.',
    },
  ];

  print('  Prepared ${internalComparison.length} comparison rows');

  // ============================================================
  // SECTION 8: Real-World Patterns
  // ============================================================
  print('=== Section 8: Real-World Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Default Android Behaviour',
      'icon': Icons.android,
      'color': Colors.green[600]!,
      'body': 'On Android, ScrollConfiguration injects Clamping'
          'ScrollPhysics by default. Every ListView, GridView, '
          'CustomScrollView automatically uses ClampingScroll'
          'Simulation for flings. No explicit setup needed.',
    },
    {
      'title': 'Force Clamping on iOS',
      'icon': Icons.phonelink,
      'color': Colors.teal[600]!,
      'body': 'To use Android-style scrolling on all platforms:\n'
          'ListView(\n'
          '  physics: ClampingScrollPhysics(),\n'
          '  ...\n'
          ')\n'
          'This produces ClampingScrollSimulation on iOS too, '
          'giving a hard stop instead of bounce.',
    },
    {
      'title': 'PageView Scrolling',
      'icon': Icons.view_carousel,
      'color': Colors.indigo[500]!,
      'body': 'PageView uses PageScrollPhysics, which creates its '
          'own simulation to snap to pages. However, the deceleration '
          'model is similar to clamping: the simulation calculates '
          'which page to stop at and drives toward it.',
    },
    {
      'title': 'Custom Friction',
      'icon': Icons.tune,
      'color': Colors.deepPurple[500]!,
      'body': 'Subclass ClampingScrollPhysics and override '
          'createBallisticSimulation to pass a custom friction:\n'
          'ClampingScrollSimulation(\n'
          '  position: pos, velocity: vel,\n'
          '  friction: 0.005, // lower = longer coast\n'
          ')',
    },
    {
      'title': 'Infinite Scroll Lists',
      'icon': Icons.all_inclusive,
      'color': Colors.blue[600]!,
      'body': 'Infinite lists (loading more items on scroll) pair '
          'well with clamping physics. The hard stop at the bottom '
          'triggers the load-more callback, and the glow indicator '
          'signals to the user that data is being fetched.',
    },
  ];

  print('  Prepared ${patterns.length} real-world patterns');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Clamping Doesn\'t Mean No Overscroll',
      'body': 'The simulation itself doesn\'t overscroll, but the '
          'user can still drag past the edge (held drag). The '
          'clamping only applies to the ballistic phase after '
          'release. During drag, BouncingScrollPhysics-style '
          'overscroll may still show depending on config.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Velocity Sent to Glow',
      'body': 'When the simulation hits a boundary, the remaining '
          'velocity is consumed by the glow indicator. A faster '
          'fling into the edge produces a brighter, larger glow. '
          'This velocity is NOT available for continued scrolling.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'isDone() Timing',
      'body': 'ClampingScrollSimulation\'s isDone() returns true when '
          'either the velocity drops below tolerance OR the position '
          'reaches the boundary. Check isDone() at each tick to know '
          'when to transition to idle.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Friction on Different Devices',
      'body': 'The default friction factor produces a scroll feel '
          'tuned for typical phone DPIs. On tablets or desktop, the '
          'same friction may feel different because the physical '
          'pixel distance is larger. Consider per-platform friction.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Combining Physics',
      'body': 'ClampingScrollPhysics can be parented with '
          'AlwaysScrollableScrollPhysics to allow bouncing beyond '
          'edges while still using clamping deceleration. The parent '
          'physics controls the "can I scroll?" decision.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Testing Deceleration',
      'body': 'Create ClampingScrollSimulation with known velocity '
          'and sample x() at increments. The position should increase '
          'monotonically and converge. Good for regression tests '
          'on scroll behaviour.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('ClampingScrollSimulation'),
      backgroundColor: Colors.green[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header banner ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.green[700]!, Colors.teal[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.android, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'ClampingScrollSimulation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Android-style scroll physics simulation. '
                  'Content decelerates along a spline-based '
                  'friction curve and stops precisely at the '
                  'edge — never overshooting, never bouncing.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _heading('1', 'Concept — Android Scroll Deceleration'),
          SizedBox(height: 12),
          ...conceptCards.map((card) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: card['accent'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(card['icon'] as IconData,
                            color: card['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(card['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(card['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Velocity → Distance ──
          _heading('2', 'Velocity → Distance Relationship'),
          SizedBox(height: 8),
          Text(
            'Same starting position (0), same friction, different '
            'initial velocities. Higher velocity = more distance '
            'traveled before stopping. The relationship is non-linear.',
            style: TextStyle(
                fontSize: 13, color: Colors.grey[600], height: 1.5),
          ),
          SizedBox(height: 12),
          ...velocityData.map((vd) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: (vd['color'] as Color).withOpacity(0.4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: vd['color'] as Color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(vd['label'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                        Spacer(),
                        Text(
                          'v=${(vd['velocity'] as double).toStringAsFixed(0)} → '
                          '${vd['distance']}px',
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                              color: Colors.grey[600]),
                        ),
                      ]),
                      SizedBox(height: 8),
                      // Distance bar
                      _buildDistanceBar(
                        positions: vd['positions'] as List<double>,
                        color: vd['color'] as Color,
                        maxDistance: 8000.0,
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Time-Series Table ──
          _heading('3', 'Position & Velocity Over Time'),
          SizedBox(height: 8),
          Text(
            'Three simulations at different velocities. Position '
            'increases monotonically (never overshoots). Velocity '
            'decreases to zero.',
            style: TextStyle(
                fontSize: 13, color: Colors.grey[600], height: 1.5),
          ),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  _cell('Time', bold: true, white: true, flex: 1),
                  _cell('Slow\npos', bold: true, white: true, flex: 1),
                  _cell('Med\npos', bold: true, white: true, flex: 1),
                  _cell('Fast\npos', bold: true, white: true, flex: 1),
                  _cell('Slow\nvel', bold: true, white: true, flex: 1),
                  _cell('Med\nvel', bold: true, white: true, flex: 1),
                  _cell('Fast\nvel', bold: true, white: true, flex: 1),
                ]),
              ),
              ...timeRows.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(children: [
                    _cell(row['time']!, flex: 1),
                    _cell(row['slow']!, flex: 1),
                    _cell(row['med']!, flex: 1),
                    _cell(row['fast']!, flex: 1),
                    _cell(row['velSlow']!, flex: 1),
                    _cell(row['velMed']!, flex: 1),
                    _cell(row['velFast']!, flex: 1),
                  ]),
                );
              }),
            ]),
          ),

          SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Slow: v=800 px/s  •  Medium: v=2000 px/s  •  Fast: v=5000 px/s',
              style: TextStyle(
                  fontSize: 12,
                  color: Colors.green[900],
                  fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(height: 24),

          // ── Section 4: Deceleration Curve ──
          _heading('4', 'The Deceleration Curve'),
          SizedBox(height: 12),
          ...curveFeatures.map((cf) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 42,
                        height: 42,
                        decoration: BoxDecoration(
                          color: (cf['color'] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(cf['icon'] as IconData,
                            color: cf['color'] as Color, size: 22),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(cf['title'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                            SizedBox(height: 6),
                            Text(cf['body'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    height: 1.4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Boundary Clamping ──
          _heading('5', 'Boundary Clamping Behaviour'),
          SizedBox(height: 12),
          ...clampScenarios.map((cs) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cs['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(cs['icon'] as IconData,
                            color: cs['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Text(cs['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.grey[900])),
                      ]),
                      SizedBox(height: 6),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(cs['scenario'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.grey[800])),
                      ),
                      SizedBox(height: 8),
                      Text(cs['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Glow Indicator ──
          _heading('6', 'Glow Indicator Integration'),
          SizedBox(height: 12),
          ...glowDetails.map((gd) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (gd['color'] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(gd['icon'] as IconData,
                            color: gd['color'] as Color, size: 22),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(gd['title'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14)),
                            SizedBox(height: 6),
                            Text(gd['body'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    height: 1.4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Comparison Table ──
          _heading('7', 'Clamping vs Bouncing — Internals'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.green[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  _cell('Aspect', bold: true, white: true, flex: 2),
                  _cell('Clamping', bold: true, white: true, flex: 3),
                  _cell('Bouncing', bold: true, white: true, flex: 3),
                ]),
              ),
              ...internalComparison.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _cell(row['aspect']!, bold: true, flex: 2),
                      _cell(row['clamping']!, flex: 3),
                      _cell(row['bouncing']!, flex: 3),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 8: Real-World Patterns ──
          _heading('8', 'Real-World Patterns'),
          SizedBox(height: 12),
          ...patterns.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['body'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips & Gotchas ──
          _heading('9', 'Tips, Pitfalls & Gotchas'),
          SizedBox(height: 12),
          ...tips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),

          // ── Footer ──
          Center(
            child: Text(
              'End of ClampingScrollSimulation Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section heading
// ──────────────────────────────────────────────────────────
Widget _heading(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.green[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Table cell
// ──────────────────────────────────────────────────────────
Widget _cell(String text,
    {bool bold = false, bool white = false, int flex = 1}) {
  return Expanded(
    flex: flex,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: white ? Colors.white : Colors.grey[800],
        height: 1.3,
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Distance bar showing position progression
// ──────────────────────────────────────────────────────────
Widget _buildDistanceBar({
  required List<double> positions,
  required Color color,
  required double maxDistance,
}) {
  return Container(
    height: 20,
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(10),
    ),
    child: FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: positions.isNotEmpty
          ? (positions.last / maxDistance).clamp(0.0, 1.0)
          : 0.0,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.7), color],
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
  );
}
