// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors, unnecessary_cast
// D4rt test script: Deep Demo — BouncingScrollSimulation
// Demonstrates BouncingScrollSimulation, the physics simulation used
// by BouncingScrollPhysics to produce iOS-style scroll behaviour.
// When content overshoots the edges, the simulation creates a
// spring-back effect rather than a hard stop. Covers constructor
// parameters, spring mechanics, boundary behaviour, velocity decay,
// comparison with ClampingScrollSimulation, and real-world patterns.
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

dynamic build(BuildContext context) {
  print('BouncingScrollSimulation Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is BouncingScrollSimulation?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.phone_iphone,
      'title': 'iOS-Style Scroll Physics',
      'body': 'BouncingScrollSimulation models the scroll behaviour '
          'typical of iOS: when a fling carries the content past its '
          'edges the list doesn\'t stop abruptly — it overshoots, '
          'then springs back elastically to the boundary. This gives '
          'users a tactile, rubbery feel that signals "you\'ve reached '
          'the end". On Android, ClampingScrollSimulation provides an '
          'alternative hard-stop-with-glow approach.',
      'accent': Colors.orange[700]!,
    },
    {
      'icon': Icons.waves,
      'title': 'Simulation, Not Widget',
      'body': 'BouncingScrollSimulation is a Simulation — a pure math '
          'object that answers "where is the scroll at time t?" and '
          '"what is the velocity at time t?". It has no UI and no '
          'widget tree participation. It is created by '
          'BouncingScrollPhysics.createBallisticSimulation() and fed '
          'to a BallisticScrollActivity, which drives a Ticker and '
          'updates ScrollPosition on every frame.',
      'accent': Colors.deepOrange[600]!,
    },
    {
      'icon': Icons.straighten,
      'title': 'Two Phases: Friction & Spring',
      'body': 'Inside bounds the simulation uses a FrictionSimulation '
          'that decelerates smoothly (like a ball rolling on carpet). '
          'When the position reaches or starts beyond a boundary, the '
          'simulation switches to a SpringSimulation with a critically '
          'damped spring that pulls the content back to the boundary. '
          'This two-phase design produces the characteristic '
          '"overshoot-then-spring-back" of iOS lists.',
      'accent': Colors.orange[800]!,
    },
    {
      'icon': Icons.architecture,
      'title': 'Constructor Parameters',
      'body': 'The constructor takes:\n'
          '• position — current scroll offset (pixels)\n'
          '• velocity — current velocity (pixels/sec)\n'
          '• leadingExtent — minimum scroll extent (usually 0.0)\n'
          '• trailingExtent — maximum scroll extent\n'
          '• spring — a SpringDescription controlling bounce\n'
          'These five values fully determine the bounce curve.',
      'accent': Colors.amber[800]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Constructor & Parameters Deep Dive
  // ============================================================
  print('=== Section 2: Constructor & Parameters ===');

  // We'll demonstrate how different parameter combinations produce
  // different simulation behaviours by creating several simulations
  // and sampling their position at various times.

  final springDefault = SpringDescription(
    mass: 0.5,
    stiffness: 100.0,
    damping: 1.1,
  );

  // Scenario A: Moderate fling within bounds (no bounce needed)
  final simA = BouncingScrollSimulation(
    position: 200.0,
    velocity: -800.0, // scrolling up
    leadingExtent: 0.0,
    trailingExtent: 1000.0,
    spring: springDefault,
  );

  // Scenario B: Fling that overshoots the leading edge
  final simB = BouncingScrollSimulation(
    position: 50.0,
    velocity: -2000.0, // fast upward, will overshoot 0
    leadingExtent: 0.0,
    trailingExtent: 1000.0,
    spring: springDefault,
  );

  // Scenario C: Starting beyond trailing extent (overscrolled)
  final simC = BouncingScrollSimulation(
    position: 1050.0,
    velocity: 0.0, // released while overscrolled
    leadingExtent: 0.0,
    trailingExtent: 1000.0,
    spring: springDefault,
  );

  // Scenario D: High velocity toward trailing extent
  final simD = BouncingScrollSimulation(
    position: 900.0,
    velocity: 3000.0, // fast downward, will overshoot 1000
    leadingExtent: 0.0,
    trailingExtent: 1000.0,
    spring: springDefault,
  );

  // Sample positions at time steps
  final timeSteps = [0.0, 0.1, 0.2, 0.4, 0.6, 0.8, 1.0, 1.5, 2.0];

  String posAtTime(Simulation sim, double t) {
    try {
      return sim.x(t).toStringAsFixed(1);
    } catch (_) {
      return '—';
    }
  }

  final parameterRows = <Map<String, String>>[];
  for (final t in timeSteps) {
    parameterRows.add({
      'time': '${t}s',
      'posA': posAtTime(simA, t),
      'posB': posAtTime(simB, t),
      'posC': posAtTime(simC, t),
      'posD': posAtTime(simD, t),
    });
  }

  print('  Sampled ${parameterRows.length} time steps across 4 scenarios');

  // ============================================================
  // SECTION 3: SpringDescription — The Bounce Engine
  // ============================================================
  print('=== Section 3: SpringDescription ===');

  // Demonstrate how different spring descriptions affect bounce
  final springs = <Map<String, dynamic>>[
    {
      'label': 'Soft (low stiffness)',
      'spring': SpringDescription(mass: 0.5, stiffness: 50.0, damping: 1.1),
      'color': Colors.green[400]!,
      'description': 'Low stiffness means a gentle, slow pull-back. '
          'The content takes longer to settle at the boundary. '
          'Feels "mushy" and relaxed.',
    },
    {
      'label': 'Default (Flutter iOS)',
      'spring': SpringDescription(mass: 0.5, stiffness: 100.0, damping: 1.1),
      'color': Colors.orange[500]!,
      'description': 'Flutter\'s default for BouncingScrollPhysics. '
          'A balanced feel: responsive spring-back without '
          'being too snappy or too sluggish.',
    },
    {
      'label': 'Stiff (high stiffness)',
      'spring': SpringDescription(mass: 0.5, stiffness: 300.0, damping: 1.1),
      'color': Colors.red[500]!,
      'description': 'High stiffness means rapid pull-back. '
          'The content snaps quickly to the boundary. '
          'Can feel "tight" or "rigid".',
    },
    {
      'label': 'Heavy (high mass)',
      'spring': SpringDescription(mass: 2.0, stiffness: 100.0, damping: 1.1),
      'color': Colors.purple[500]!,
      'description': 'Higher mass adds inertia to the spring. '
          'The bounce is slower and the content may '
          'overshoot past the boundary before settling.',
    },
    {
      'label': 'Underdamped',
      'spring': SpringDescription(mass: 0.5, stiffness: 100.0, damping: 0.3),
      'color': Colors.cyan[400]!,
      'description': 'Low damping causes oscillation: the content '
          'bounces past the boundary multiple times before '
          'coming to rest. Springy and playful.',
    },
  ];

  // For each spring, create a bouncing simulation starting overscrolled
  // and sample the position to show how it settles
  final springCurves = <Map<String, dynamic>>[];
  for (final sp in springs) {
    final sim = BouncingScrollSimulation(
      position: 1100.0, // 100px past trailing extent
      velocity: 0.0,
      leadingExtent: 0.0,
      trailingExtent: 1000.0,
      spring: sp['spring'] as SpringDescription,
    );
    final positions = <double>[];
    for (double t = 0.0; t <= 2.0; t += 0.1) {
      try {
        positions.add(sim.x(t));
      } catch (_) {
        positions.add(1000.0);
      }
    }
    springCurves.add({
      'label': sp['label'],
      'color': sp['color'],
      'description': sp['description'],
      'positions': positions,
    });
  }

  print('  Computed ${springCurves.length} spring curve profiles');

  // ============================================================
  // SECTION 4: Boundary Behaviour — Where Bouncing Happens
  // ============================================================
  print('=== Section 4: Boundary Behaviour ===');

  final boundaryScenarios = <Map<String, dynamic>>[
    {
      'title': 'Within Bounds — Friction Only',
      'icon': Icons.linear_scale,
      'color': Colors.green[600]!,
      'position': 500.0,
      'velocity': -600.0,
      'description': 'When the fling starts within [leadingExtent, '
          'trailingExtent] and the velocity isn\'t large enough to '
          'overshoot, the simulation uses pure FrictionSimulation. '
          'No spring-back occurs — just smooth deceleration.',
    },
    {
      'title': 'Overshoots Leading Edge',
      'icon': Icons.first_page,
      'color': Colors.orange[600]!,
      'position': 30.0,
      'velocity': -2500.0,
      'description': 'A fast upward fling near the top overshoots '
          'past leadingExtent (position < 0). The simulation switches '
          'to a SpringSimulation that pulls back toward 0.0. The '
          'overshoot distance depends on velocity and spring stiffness.',
    },
    {
      'title': 'Overshoots Trailing Edge',
      'icon': Icons.last_page,
      'color': Colors.red[600]!,
      'position': 970.0,
      'velocity': 2500.0,
      'description': 'A fast downward fling near the bottom overshoots '
          'past trailingExtent (position > max). Same spring-back '
          'mechanism applies, pulling back toward trailingExtent.',
    },
    {
      'title': 'Released While Overscrolled',
      'icon': Icons.undo,
      'color': Colors.purple[600]!,
      'position': 1080.0,
      'velocity': 0.0,
      'description': 'If the user slowly drags past the edge and '
          'releases (velocity ≈ 0), the simulation is purely spring — '
          'no friction phase. The content snaps back with the '
          'characteristic elastic feel.',
    },
    {
      'title': 'Fling Away From Boundary',
      'icon': Icons.arrow_back,
      'color': Colors.teal[600]!,
      'position': 1050.0,
      'velocity': -500.0,
      'description': 'Released while overscrolled but flinging back '
          'toward content: the spring and friction work together. '
          'The content returns faster than a passive spring-back '
          'because the user gave it initial momentum.',
    },
  ];

  print('  Prepared ${boundaryScenarios.length} boundary scenarios');

  // ============================================================
  // SECTION 5: Simulation API & Methods
  // ============================================================
  print('=== Section 5: Simulation API ===');

  final apiMembers = <Map<String, String>>[
    {
      'member': 'x(double time)',
      'returns': 'double',
      'description': 'The scroll position at the given time in '
          'seconds since the simulation started. This is what '
          'BallisticScrollActivity reads each frame to update '
          'ScrollPosition.pixels.',
    },
    {
      'member': 'dx(double time)',
      'returns': 'double',
      'description': 'The velocity (pixels/sec) at the given time. '
          'Used to determine if the simulation should transition '
          'from friction to spring (when position crosses a boundary).',
    },
    {
      'member': 'isDone(double time)',
      'returns': 'bool',
      'description': 'Returns true when the simulation has settled: '
          'position is within bounds and velocity is below the '
          'tolerance threshold. The scroll activity then transitions '
          'to IdleScrollActivity.',
    },
    {
      'member': 'tolerance',
      'returns': 'Tolerance',
      'description': 'Inherited from Simulation. Defines the epsilon '
          'values for position and velocity below which the simulation '
          'is considered "done". Flutter defaults to ±0.1 pixels and '
          '±0.1 pixels/sec.',
    },
    {
      'member': 'toString()',
      'returns': 'String',
      'description': 'Returns a diagnostic string describing the '
          'simulation\'s internal state — useful for debugging scroll '
          'physics behaviour.',
    },
  ];

  print('  Documented ${apiMembers.length} API members');

  // ============================================================
  // SECTION 6: Bouncing vs Clamping — Side by Side
  // ============================================================
  print('=== Section 6: Bouncing vs Clamping Comparison ===');

  final comparisonAspects = <Map<String, String>>[
    {
      'aspect': 'Platform Feel',
      'bouncing': 'iOS-native. Content overshoots '
          'and springs back like a rubber band.',
      'clamping': 'Android-native. Content stops '
          'hard at the edge with a glow indicator.',
    },
    {
      'aspect': 'Edge Behaviour',
      'bouncing': 'Content moves past the boundary ('
          'negative or beyond-max positions). The '
          'spring pulls it back smoothly.',
      'clamping': 'Content never moves past the boundary. '
          'Position is mathematically clamped to '
          '[min, max].',
    },
    {
      'aspect': 'Internal Simulation',
      'bouncing': 'FrictionSimulation within bounds + '
          'SpringSimulation at/beyond boundaries.',
      'clamping': 'A single curve (inspired by Android '
          'OverScroller) that decelerates to zero '
          'exactly at the boundary.',
    },
    {
      'aspect': 'Overscroll Feedback',
      'bouncing': 'Visual: the content itself moves '
          'past the edge, showing a gap/stretch.',
      'clamping': 'Visual: a glow indicator (or stretch, '
          'on Android 12+) painted above the list '
          'without moving the content.',
    },
    {
      'aspect': 'Pull-to-Refresh',
      'bouncing': 'Natural fit: the overscroll region '
          'is where the refresh indicator lives.',
      'clamping': 'Requires special handling: the '
          'indicator sits atop the glow area.',
    },
    {
      'aspect': 'Custom Physics',
      'bouncing': 'Tweak SpringDescription (mass, stiffness, '
          'damping) in BouncingScrollPhysics subclass.',
      'clamping': 'Harder to customise: the friction '
          'curve is baked into the implementation.',
    },
    {
      'aspect': 'Simulation Class',
      'bouncing': 'BouncingScrollSimulation',
      'clamping': 'ClampingScrollSimulation',
    },
  ];

  print('  Prepared ${comparisonAspects.length} comparison aspects');

  // ============================================================
  // SECTION 7: Real-World Patterns
  // ============================================================
  print('=== Section 7: Real-World Patterns ===');

  final realWorldPatterns = <Map<String, dynamic>>[
    {
      'title': 'Cross-Platform Defaults',
      'icon': Icons.devices,
      'color': Colors.blue[600]!,
      'code': 'ScrollConfiguration.of(context)',
      'body': 'Flutter automatically selects the right simulation:\n'
          '• iOS/macOS → BouncingScrollPhysics → BouncingScrollSimulation\n'
          '• Android/Fuchsia → ClampingScrollPhysics → ClampingScrollSimulation\n'
          'You get platform-correct behaviour for free.',
    },
    {
      'title': 'Force Bounce Everywhere',
      'icon': Icons.phonelink,
      'color': Colors.indigo[500]!,
      'code': 'physics: BouncingScrollPhysics()',
      'body': 'To use iOS-style bounce on all platforms:\n'
          'ListView(\n'
          '  physics: const BouncingScrollPhysics(),\n'
          '  children: [...],\n'
          ')\n'
          'This forces BouncingScrollSimulation regardless of OS.',
    },
    {
      'title': 'Custom Spring Feel',
      'icon': Icons.tune,
      'color': Colors.deepPurple[500]!,
      'code': 'SpringDescription(mass:, stiffness:, damping:)',
      'body': 'Subclass BouncingScrollPhysics and override the spring:\n'
          'class SoftBouncePhysics extends BouncingScrollPhysics {\n'
          '  @override\n'
          '  SpringDescription get spring => SpringDescription(\n'
          '    mass: 0.5, stiffness: 50.0, damping: 1.1,\n'
          '  );\n'
          '}',
    },
    {
      'title': 'Pull-To-Refresh Overscroll',
      'icon': Icons.refresh,
      'color': Colors.green[600]!,
      'code': 'RefreshIndicator + BouncingScrollPhysics',
      'body': 'RefreshIndicator on iOS uses the bouncing overscroll '
          'region to show the spinner. The simulation\'s x(t) going '
          'negative (past leading extent) is what reveals the '
          'indicator. On Android, a separate mechanism is used.',
    },
    {
      'title': 'AlwaysScrollableScrollPhysics',
      'icon': Icons.swap_vert,
      'color': Colors.teal[500]!,
      'code': 'AlwaysScrollableScrollPhysics(parent: Bouncing…)',
      'body': 'When your list might be shorter than the viewport, '
          'wrap BouncingScrollPhysics with AlwaysScrollableScroll'
          'Physics to ensure the user can always pull to refresh:\n'
          'physics: AlwaysScrollableScrollPhysics(\n'
          '  parent: BouncingScrollPhysics(),\n'
          ')',
    },
  ];

  print('  Prepared ${realWorldPatterns.length} real-world patterns');

  // ============================================================
  // SECTION 8: Simulation Internals — FrictionSimulation
  // ============================================================
  print('=== Section 8: FrictionSimulation Internals ===');

  // The friction portion uses an exponential decay
  // position(t) = position + velocity * (1 - e^(-drag*t)) / drag
  // Let's visualise with actual FrictionSimulation objects

  final frictionExamples = <Map<String, dynamic>>[
    {
      'label': 'Low drag (0.01)',
      'drag': 0.01,
      'color': Colors.lightGreen[600]!,
      'description': 'Very low friction: content coasts a long '
          'distance before stopping. Like a marble on ice.',
    },
    {
      'label': 'Default drag (~0.135)',
      'drag': 0.135,
      'color': Colors.orange[600]!,
      'description': 'Flutter\'s typical drag coefficient for '
          'bouncing scroll. Feels natural — not too fast, '
          'not too slow.',
    },
    {
      'label': 'High drag (0.5)',
      'drag': 0.5,
      'color': Colors.red[700]!,
      'description': 'High friction: content stops quickly after '
          'release. Like dragging through honey.',
    },
  ];

  // Sample friction simulations
  final frictionCurves = <Map<String, dynamic>>[];
  for (final fe in frictionExamples) {
    final sim = FrictionSimulation(
      fe['drag'] as double,
      0.0, // start at 0
      1000.0, // 1000 px/sec initial velocity
    );
    final positions = <double>[];
    for (double t = 0.0; t <= 3.0; t += 0.15) {
      positions.add(sim.x(t));
    }
    frictionCurves.add({
      'label': fe['label'],
      'color': fe['color'],
      'description': fe['description'],
      'positions': positions,
      'finalPos': sim.finalX.toStringAsFixed(0),
    });
  }

  print('  Computed ${frictionCurves.length} friction profiles');

  // ============================================================
  // SECTION 9: Tips, Pitfalls & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Don\'t Instantiate Directly',
      'body': 'You almost never create BouncingScrollSimulation '
          'yourself. Let BouncingScrollPhysics.createBallistic'
          'Simulation() do it. Access the physics through '
          'ScrollConfiguration or the physics parameter on '
          'scrollable widgets.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'SpringDescription Matters',
      'body': 'A badly tuned spring can feel broken: underdamped '
          'springs oscillate visibly, overdamped springs feel '
          'sluggish. Always test on real devices — simulation '
          'timing feels different on 60Hz vs 120Hz displays.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Tolerance Controls "Done"',
      'body': 'The simulation\'s tolerance (Tolerance.distance and '
          'Tolerance.velocity) determines when isDone() returns '
          'true. Too tight and the scroll never settles; too '
          'loose and it snaps to rest while still visibly moving.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Time Argument Is Absolute',
      'body': 'x(t) and dx(t) use time in seconds since simulation '
          'start. The framework passes elapsed ticker time. If you '
          'sample these manually, remember that t=0 is the creation '
          'moment, not the current time.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Combining with NeverScrollable',
      'body': 'If you parent BouncingScrollPhysics with '
          'NeverScrollableScrollPhysics, the simulation is never '
          'created because scrolling is disabled. The parent '
          'physics wins the "should I scroll?" decision.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Test Spring Configurations',
      'body': 'Use BouncingScrollSimulation directly in unit tests '
          'to verify custom spring behaviour. Sample x() at known '
          'times and assert the values match expectations. This '
          'is faster than running a full widget test.',
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
      title: Text('BouncingScrollSimulation'),
      backgroundColor: Colors.orange[700],
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
                colors: [Colors.orange[700]!, Colors.deepOrange[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.phone_iphone, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'BouncingScrollSimulation',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The physics simulation behind iOS-style elastic '
                  'scrolling. Combines friction within bounds and '
                  'spring force at boundaries to produce the '
                  'characteristic overshoot-and-bounce-back effect.',
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

          // ── Section 1: Concept cards ──
          _sectionHeader('1', 'Concept — iOS-Style Scrolling'),
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
                        color: card['accent'] as Color,
                        width: 4,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 4,
                        offset: Offset(0, 2),
                      ),
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
                          child: Text(
                            card['title'] as String,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[900],
                            ),
                          ),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(
                        card['body'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Parameter scenarios table ──
          _sectionHeader('2', 'Position Over Time — Four Scenarios'),
          SizedBox(height: 8),
          Text(
            'Each column shows scroll position at time t for a '
            'different initial condition. Same spring, different '
            'starting position/velocity. Note how scenarios B and D '
            'overshoot edges and spring back.',
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
            child: Column(
              children: [
                // Header row
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.orange[700],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(children: [
                    _tableCell('Time', bold: true, white: true, flex: 1),
                    _tableCell('A: Mid\nv=-800', bold: true, white: true, flex: 2),
                    _tableCell('B: Top\nv=-2000', bold: true, white: true, flex: 2),
                    _tableCell('C: Over\nv=0', bold: true, white: true, flex: 2),
                    _tableCell('D: Bot\nv=3000', bold: true, white: true, flex: 2),
                  ]),
                ),
                // Data rows
                ...parameterRows.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final row = entry.value;
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    color: idx.isEven ? Colors.grey[50] : Colors.white,
                    child: Row(children: [
                      _tableCell(row['time']!, flex: 1),
                      _tableCell(row['posA']!, flex: 2),
                      _tableCell(row['posB']!, flex: 2),
                      _tableCell(row['posC']!, flex: 2),
                      _tableCell(row['posD']!, flex: 2),
                    ]),
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: 8),
          // Scenario legend
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Scenario Legend:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: Colors.orange[900])),
                SizedBox(height: 6),
                Text('A: Moderate fling within bounds (pos=200, v=-800)',
                    style: TextStyle(fontSize: 12, color: Colors.grey[800])),
                Text('B: Fast fling overshooting leading edge (pos=50, v=-2000)',
                    style: TextStyle(fontSize: 12, color: Colors.grey[800])),
                Text('C: Released while overscrolled past trailing (pos=1050, v=0)',
                    style: TextStyle(fontSize: 12, color: Colors.grey[800])),
                Text('D: Fast fling overshooting trailing edge (pos=900, v=3000)',
                    style: TextStyle(fontSize: 12, color: Colors.grey[800])),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 3: Spring Descriptions ──
          _sectionHeader('3', 'SpringDescription — The Bounce Engine'),
          SizedBox(height: 8),
          Text(
            'The spring controls how the content bounces back from '
            'edges. Below: five different spring configurations, all '
            'starting 100px past the trailing extent with zero velocity.',
            style: TextStyle(
                fontSize: 13, color: Colors.grey[600], height: 1.5),
          ),
          SizedBox(height: 12),
          ...springCurves.map((sc) {
            final positions = sc['positions'] as List<double>;
            final maxOvershoot = positions.fold<double>(
                1000.0, (prev, p) => p > prev ? p : prev);
            final range = maxOvershoot - 950.0; // visual range
            return Padding(
              padding: EdgeInsets.only(bottom: 16),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: (sc['color'] as Color).withOpacity(0.4)),
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
                      Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: sc['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(sc['label'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 14)),
                    ]),
                    SizedBox(height: 8),
                    Text(sc['description'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[700],
                            height: 1.4)),
                    SizedBox(height: 10),
                    // Visual curve: show position as horizontal bars
                    Container(
                      height: 60,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: CustomPaint(
                        painter: _SpringCurvePainter(
                          positions: positions,
                          color: sc['color'] as Color,
                          trailingExtent: 1000.0,
                          range: range > 10 ? range : 200.0,
                        ),
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('t=0s',
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey[500])),
                        Text('boundary: 1000px',
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey[500])),
                        Text('t=2s',
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey[500])),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 24),

          // ── Section 4: Boundary Behaviour ──
          _sectionHeader('4', 'Boundary Behaviour'),
          SizedBox(height: 12),
          ...boundaryScenarios.map((bs) => Padding(
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
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: (bs['color'] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(bs['icon'] as IconData,
                            color: bs['color'] as Color, size: 24),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(bs['title'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.grey[900])),
                            SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                'pos=${bs['position']}  vel=${bs['velocity']}',
                                style: TextStyle(
                                    fontSize: 11,
                                    fontFamily: 'monospace',
                                    color: Colors.grey[800]),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(bs['description'] as String,
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

          // ── Section 5: API Surface ──
          _sectionHeader('5', 'Simulation API Surface'),
          SizedBox(height: 12),
          ...apiMembers.map((m) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.orange[200]!),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.orange[100],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(m['member']!,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange[900])),
                        ),
                        SizedBox(width: 8),
                        Text('→ ${m['returns']}',
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[500],
                                fontStyle: FontStyle.italic)),
                      ]),
                      SizedBox(height: 8),
                      Text(m['description']!,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Bouncing vs Clamping ──
          _sectionHeader('6', 'Bouncing vs Clamping — Comparison'),
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
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.orange[700],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(children: [
                    _tableCell('Aspect', bold: true, white: true, flex: 2),
                    _tableCell('Bouncing\n(iOS)', bold: true, white: true, flex: 3),
                    _tableCell('Clamping\n(Android)', bold: true, white: true, flex: 3),
                  ]),
                ),
                ...comparisonAspects.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final row = entry.value;
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    color: idx.isEven ? Colors.grey[50] : Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _tableCell(row['aspect']!,
                            bold: true, flex: 2),
                        _tableCell(row['bouncing']!, flex: 3),
                        _tableCell(row['clamping']!, flex: 3),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 7: Real-World Patterns ──
          _sectionHeader('7', 'Real-World Patterns'),
          SizedBox(height: 12),
          ...realWorldPatterns.map((p) => Padding(
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
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(p['code'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.grey[800])),
                      ),
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

          // ── Section 8: Friction Internals ──
          _sectionHeader('8', 'FrictionSimulation Internals'),
          SizedBox(height: 8),
          Text(
            'Within bounds, BouncingScrollSimulation delegates to '
            'FrictionSimulation. The drag coefficient controls how '
            'quickly velocity decays. Below: same initial velocity '
            '(1000 px/s), different drag values.',
            style: TextStyle(
                fontSize: 13, color: Colors.grey[600], height: 1.5),
          ),
          SizedBox(height: 12),
          ...frictionCurves.map((fc) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: (fc['color'] as Color).withOpacity(0.3)),
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
                        Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: fc['color'] as Color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(fc['label'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13)),
                        Spacer(),
                        Text('Final: ${fc['finalPos']}px',
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[600],
                                fontStyle: FontStyle.italic)),
                      ]),
                      SizedBox(height: 6),
                      Text(fc['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 10),
                      _buildFrictionBar(
                        positions: fc['positions'] as List<double>,
                        color: fc['color'] as Color,
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips & Gotchas ──
          _sectionHeader('9', 'Tips, Pitfalls & Gotchas'),
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
              'End of BouncingScrollSimulation Deep Demo',
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
// Helper: Section header
// ──────────────────────────────────────────────────────────
Widget _sectionHeader(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.orange[700],
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
Widget _tableCell(String text,
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
// Helper: Friction bar visualization
// ──────────────────────────────────────────────────────────
Widget _buildFrictionBar({
  required List<double> positions,
  required Color color,
}) {
  if (positions.isEmpty) return SizedBox.shrink();
  final maxPos = positions.fold<double>(0.0, (a, b) => a > b ? a : b);
  final scale = maxPos > 0 ? maxPos : 1.0;

  return Column(
    children: [
      Container(
        height: 28,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: positions.asMap().entries.map((entry) {
            final fraction = entry.value / scale;
            return Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 0.5, vertical: 2),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2 + 0.8 * fraction),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }).toList(),
        ),
      ),
      SizedBox(height: 2),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('t=0', style: TextStyle(fontSize: 9, color: Colors.grey[500])),
          Text('intensity ∝ distance',
              style: TextStyle(fontSize: 9, color: Colors.grey[400])),
          Text('t=3s', style: TextStyle(fontSize: 9, color: Colors.grey[500])),
        ],
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// CustomPainter: Spring curve visualization
// ──────────────────────────────────────────────────────────
class _SpringCurvePainter extends CustomPainter {
  final List<double> positions;
  final Color color;
  final double trailingExtent;
  final double range;

  _SpringCurvePainter({
    required this.positions,
    required this.color,
    required this.trailingExtent,
    required this.range,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (positions.isEmpty) return;

    // Draw the boundary line
    final boundaryPaint = Paint()
      ..color = Colors.grey[400]!
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(0, size.height * 0.8),
      Offset(size.width, size.height * 0.8),
      boundaryPaint,
    );

    // Draw the curve
    final curvePaint = Paint()
      ..color = color
      ..strokeWidth = 2.5
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    for (int i = 0; i < positions.length; i++) {
      final x = (i / (positions.length - 1)) * size.width;
      final normalized = (positions[i] - trailingExtent + range) / range;
      final y = size.height - (normalized * size.height);
      if (i == 0) {
        path.moveTo(x, y.clamp(0.0, size.height));
      } else {
        path.lineTo(x, y.clamp(0.0, size.height));
      }
    }
    canvas.drawPath(path, curvePaint);

    // Draw dots at each sample point
    final dotPaint = Paint()..color = color;
    for (int i = 0; i < positions.length; i++) {
      final x = (i / (positions.length - 1)) * size.width;
      final normalized = (positions[i] - trailingExtent + range) / range;
      final y = (size.height - (normalized * size.height)).clamp(0.0, size.height);
      canvas.drawCircle(Offset(x, y), 2.5, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
