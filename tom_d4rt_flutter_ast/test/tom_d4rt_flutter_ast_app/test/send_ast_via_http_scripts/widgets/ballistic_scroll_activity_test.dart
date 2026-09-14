// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — BallisticScrollActivity
// Demonstrates BallisticScrollActivity, the scroll activity created
// when the user releases a scroll with velocity (a fling). The
// framework runs a ballistic simulation (deceleration curve) that
// gradually brings the scroll to a stop. Covers fling mechanics,
// simulation types, velocity thresholds, and real-world patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BallisticScrollActivity Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is BallisticScrollActivity?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.swipe,
      'title': 'Scroll Activities in Flutter',
      'body': 'Every Scrollable has a current ScrollActivity that '
          'describes what the scroll position is doing right now. '
          'Activities include IdleScrollActivity (at rest), '
          'DragScrollActivity (finger on screen), and '
          'BallisticScrollActivity (coasting after a fling). '
          'The framework transitions between these as the user '
          'interacts with scrollable content.',
      'accent': Colors.blue[700]!,
    },
    {
      'icon': Icons.speed,
      'title': 'The Fling Gesture',
      'body': 'A fling occurs when the user lifts their finger while '
          'moving. The gesture detector measures the release velocity '
          'in pixels per second. If this velocity exceeds the minimum '
          'fling threshold defined by ScrollPhysics, the framework '
          'creates a BallisticScrollActivity with a physics simulation '
          'that decelerates the scroll naturally.',
      'accent': Colors.blue[800]!,
    },
    {
      'icon': Icons.show_chart,
      'title': 'Ballistic Simulation',
      'body': 'The word "ballistic" means moving under its own '
          'momentum — like a thrown ball after leaving your hand. '
          'BallisticScrollActivity runs a Simulation that computes '
          'the scroll position at each frame, applying friction to '
          'decelerate. The simulation type depends on ScrollPhysics: '
          'ClampingScrollSimulation for Android feel, or '
          'BouncingScrollSimulation for iOS-style bounce.',
      'accent': Colors.lightBlue[700]!,
    },
    {
      'icon': Icons.timer,
      'title': 'Activity Lifecycle',
      'body': 'When a fling starts, ScrollPhysics.createBallistic'
          'Simulation() is called with the current position and '
          'velocity. If it returns a simulation, BallisticScroll'
          'Activity drives it via a Ticker. Each tick updates the '
          'scroll position. When the simulation reports isDone, '
          'the activity transitions to idle. If the user touches '
          'the screen during a fling, the ballistic activity is '
          'cancelled and replaced by a drag activity.',
      'accent': Colors.blue[600]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  final conceptWidgets = conceptCards.map<Widget>((card) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (card['accent'] as Color).withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (card['accent'] as Color).withOpacity(0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(card['icon'] as IconData,
              color: card['accent'] as Color, size: 32),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  card['title'] as String,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: card['accent'] as Color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  card['body'] as String,
                  style: const TextStyle(fontSize: 13, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 2: Activity State Machine
  // ============================================================
  print('=== Section 2: Activity State Machine ===');

  final stateTransitions = <Map<String, dynamic>>[
    {
      'from': 'Idle',
      'event': 'User touches',
      'to': 'Hold',
      'detail': 'Finger down on a scrollable creates a hold activity '
          'that waits to see if the touch becomes a drag.',
      'color': Colors.grey[600]!,
    },
    {
      'from': 'Hold',
      'event': 'User drags',
      'to': 'Drag',
      'detail': 'Movement exceeds touch slop threshold. The scroll '
          'position now tracks the finger position directly.',
      'color': Colors.blue[600]!,
    },
    {
      'from': 'Drag',
      'event': 'User flings',
      'to': 'Ballistic',
      'detail': 'Finger lifts with velocity above minFlingVelocity. '
          'A ballistic simulation begins, decelerating the scroll.',
      'color': Colors.blue[800]!,
    },
    {
      'from': 'Ballistic',
      'event': 'Simulation ends',
      'to': 'Idle',
      'detail': 'The simulation reports isDone when velocity drops '
          'below tolerance. The scroll comes to rest.',
      'color': Colors.green[700]!,
    },
    {
      'from': 'Ballistic',
      'event': 'User touches',
      'to': 'Hold',
      'detail': 'A touch during a fling cancels the ballistic '
          'activity immediately and starts a new hold.',
      'color': Colors.orange[700]!,
    },
    {
      'from': 'Drag',
      'event': 'User lifts (slow)',
      'to': 'Idle or Ballistic',
      'detail': 'If release velocity is below minFlingVelocity, '
          'the scroll may settle to idle. If overscrolled, a '
          'bounce-back simulation starts a ballistic activity.',
      'color': Colors.purple[600]!,
    },
  ];

  print('  Prepared ${stateTransitions.length} state transitions');

  final stateWidgets = stateTransitions.map<Widget>((t) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (t['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (t['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (t['color'] as Color).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  t['from'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: t['color'] as Color,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.arrow_forward,
                    size: 18, color: t['color'] as Color),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (t['color'] as Color).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  t['to'] as String,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: t['color'] as Color,
                  ),
                ),
              ),
              const Spacer(),
              Text(
                '⟵ ${t['event']}',
                style: TextStyle(
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                  color: (t['color'] as Color).withOpacity(0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            t['detail'] as String,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 3: Simulation Types
  // ============================================================
  print('=== Section 3: Simulation Types ===');

  final simulations = <Map<String, dynamic>>[
    {
      'name': 'ClampingScrollSimulation',
      'physics': 'ClampingScrollPhysics',
      'platform': 'Android',
      'icon': Icons.android,
      'behavior': 'Friction-based deceleration that hard-stops at '
          'content boundaries. The scroll position never exceeds '
          'min/max extents. An overscroll glow indicator shows '
          'the excess energy visually.',
      'color': Colors.green[700]!,
    },
    {
      'name': 'BouncingScrollSimulation',
      'physics': 'BouncingScrollPhysics',
      'platform': 'iOS / macOS',
      'icon': Icons.phone_iphone,
      'behavior': 'Spring-based simulation that allows overscroll '
          'past boundaries with elastic rubber-banding. When '
          'released while overscrolled, a spring pulls the content '
          'back to the edge with a natural bounce feel.',
      'color': Colors.blue[700]!,
    },
    {
      'name': 'SpringSimulation',
      'physics': 'Various',
      'platform': 'Cross-platform',
      'icon': Icons.settings_ethernet,
      'behavior': 'Used when the scroll position needs to settle '
          'to a specific value (e.g., page snapping, bounce-back '
          'from overscroll). Spring parameters (stiffness, damping) '
          'control how fast and how bouncy the settle is.',
      'color': Colors.purple[600]!,
    },
    {
      'name': 'FrictionSimulation',
      'physics': 'Custom',
      'platform': 'Cross-platform',
      'icon': Icons.settings,
      'behavior': 'Simple friction deceleration without boundary '
          'awareness. The velocity decays exponentially based on '
          'the friction coefficient. Used as a building block by '
          'higher-level simulations.',
      'color': Colors.orange[700]!,
    },
  ];

  print('  Prepared ${simulations.length} simulation types');

  final simWidgets = simulations.map<Widget>((sim) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: (sim['color'] as Color).withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (sim['color'] as Color).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(sim['icon'] as IconData,
                  color: sim['color'] as Color, size: 28),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      sim['name'] as String,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: sim['color'] as Color,
                      ),
                    ),
                    Text(
                      '${sim['physics']}  •  ${sim['platform']}',
                      style: TextStyle(
                        fontSize: 11,
                        color: (sim['color'] as Color).withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            sim['behavior'] as String,
            style: const TextStyle(fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 4: Velocity & Threshold Reference
  // ============================================================
  print('=== Section 4: Velocity & Threshold Reference ===');

  final velocityData = <Map<String, dynamic>>[
    {
      'label': 'minFlingVelocity',
      'bouncing': '50 px/s',
      'clamping': '50 px/s',
      'note': 'Minimum release speed to trigger a fling. Below this, '
          'the scroll settles immediately (no ballistic activity).',
    },
    {
      'label': 'maxFlingVelocity',
      'bouncing': '8000 px/s',
      'clamping': '8000 px/s',
      'note': 'Maximum velocity capped by the framework. Prevents '
          'unreasonably fast scrolling from multi-touch artifacts.',
    },
    {
      'label': 'Tolerance (distance)',
      'bouncing': '±0.1 px',
      'clamping': '±0.1 px',
      'note': 'When the simulation position is within tolerance of '
          'the target, the simulation reports isDone and the '
          'ballistic activity ends.',
    },
    {
      'label': 'Tolerance (velocity)',
      'bouncing': '±0.1 px/s',
      'clamping': '±0.1 px/s',
      'note': 'When simulation velocity drops below this threshold, '
          'the deceleration is considered complete.',
    },
    {
      'label': 'Friction coefficient',
      'bouncing': '0.135',
      'clamping': '0.015',
      'note': 'Controls deceleration rate. Lower friction means '
          'longer coast distance. Clamping uses less friction, '
          'so Android flings travel farther.',
    },
  ];

  print('  Prepared ${velocityData.length} velocity reference rows');

  final velocityHeader = Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
    decoration: BoxDecoration(
      color: Colors.blue[800],
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Row(
      children: const [
        Expanded(
            flex: 3,
            child: Text('Parameter',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12))),
        Expanded(
            flex: 2,
            child: Text('Bouncing',
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center)),
        Expanded(
            flex: 2,
            child: Text('Clamping',
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center)),
      ],
    ),
  );

  final velocityRows = velocityData.asMap().entries.map<Widget>((entry) {
    final i = entry.key;
    final row = entry.value;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: i.isEven ? Colors.blue[50] : Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.blue[100]!, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  row['label'] as String,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[900],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  row['bouncing'] as String,
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                  row['clamping'] as String,
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            row['note'] as String,
            style: TextStyle(
              fontSize: 11,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 5: Real-World Patterns
  // ============================================================
  print('=== Section 5: Real-World Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Social Media Feed',
      'icon': Icons.dynamic_feed,
      'scenario': 'A social media timeline where the user flicks '
          'through posts rapidly. The fling carries the scroll '
          'naturally, and touching the screen catches the scroll '
          'mid-flight for precise positioning.',
      'physics': 'BouncingScrollPhysics',
      'color': Colors.blue[600]!,
    },
    {
      'title': 'Page Snapping Gallery',
      'icon': Icons.photo_library,
      'scenario': 'An image gallery with PageView. After a fling, '
          'the ballistic simulation settles to the nearest page '
          'boundary. PageScrollPhysics overrides the simulation '
          'to target discrete page positions.',
      'physics': 'PageScrollPhysics',
      'color': Colors.indigo[600]!,
    },
    {
      'title': 'List with Fixed-Extent Items',
      'icon': Icons.list,
      'scenario': 'A picker or date wheel using FixedExtentScroll'
          'Physics. The fling decelerates and snaps to the '
          'nearest item center. The ballistic simulation is a '
          'spring targeting the closest snap point.',
      'physics': 'FixedExtentScrollPhysics',
      'color': Colors.teal[600]!,
    },
    {
      'title': 'Custom Deceleration',
      'icon': Icons.tune,
      'scenario': 'A map or canvas where scrolling should feel '
          'heavier. Custom ScrollPhysics overrides '
          'createBallisticSimulation to use a higher friction '
          'coefficient, making flings decelerate faster than '
          'the default.',
      'physics': 'CustomScrollPhysics',
      'color': Colors.deepPurple[600]!,
    },
    {
      'title': 'Never-Scrollable Content',
      'icon': Icons.block,
      'scenario': 'A scroll view that should not fling. '
          'NeverScrollableScrollPhysics returns null from '
          'createBallisticSimulation, so no ballistic activity '
          'is ever created. The scroll only moves programmatically.',
      'physics': 'NeverScrollableScrollPhysics',
      'color': Colors.red[600]!,
    },
  ];

  print('  Prepared ${patterns.length} real-world patterns');

  final patternWidgets = patterns.map<Widget>((p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            (p['color'] as Color).withOpacity(0.08),
            (p['color'] as Color).withOpacity(0.02),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: (p['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(p['icon'] as IconData,
                  color: p['color'] as Color, size: 26),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  p['title'] as String,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: p['color'] as Color,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: (p['color'] as Color).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  p['physics'] as String,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: p['color'] as Color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            p['scenario'] as String,
            style: const TextStyle(fontSize: 13, height: 1.5),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 6: BallisticScrollActivity Internals
  // ============================================================
  print('=== Section 6: Activity Internals ===');

  final internals = <Map<String, dynamic>>[
    {
      'aspect': 'Ticker-Driven',
      'icon': Icons.access_time,
      'detail': 'BallisticScrollActivity creates a Ticker that fires '
          'on every animation frame (~60fps). On each tick, it '
          'queries the Simulation for the position and velocity '
          'at the current elapsed time.',
    },
    {
      'aspect': 'Position Update',
      'icon': Icons.edit_location,
      'detail': 'Each frame, the activity calls '
          'ScrollActivityDelegate.setPixels() with the new position '
          'from the simulation. This triggers rebuild of the '
          'scrollable viewport and updates the scroll bar.',
    },
    {
      'aspect': 'Overscroll Handling',
      'icon': Icons.warning_amber,
      'detail': 'If setPixels returns a non-zero overscroll (because '
          'the position was clamped at a boundary), the activity '
          'calls applyNewDimensions, which may restart the '
          'simulation to handle the bounce-back.',
    },
    {
      'aspect': 'Cancellation',
      'icon': Icons.cancel,
      'detail': 'When the user touches the screen during a fling, '
          'or when dispose() is called, the Ticker is stopped '
          'and the simulation is abandoned. This is immediate — '
          'no gradual slowdown.',
    },
    {
      'aspect': 'Completion',
      'icon': Icons.check_circle,
      'detail': 'When simulation.isDone(time) returns true, the '
          'activity calls delegate.goBallistic(0.0) which '
          'transitions to IdleScrollActivity. The scroll position '
          'is now at rest.',
    },
    {
      'aspect': 'isScrolling Property',
      'icon': Icons.info,
      'detail': 'BallisticScrollActivity reports isScrolling = true, '
          'so ScrollNotification listeners see the scroll as '
          'active. This affects features like hiding/showing '
          'FABs or collapsing app bars during scroll.',
    },
  ];

  print('  Prepared ${internals.length} internal aspects');

  final internalWidgets = internals.map<Widget>((item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(item['icon'] as IconData,
              color: Colors.blue[700], size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['aspect'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item['detail'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 7: Common Pitfalls & Tips
  // ============================================================
  print('=== Section 7: Pitfalls & Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'tip': 'Don\'t Fight the Physics',
      'icon': Icons.warning,
      'body': 'Avoid animating the scroll position manually while '
          'a ballistic activity is running. Instead, cancel the '
          'fling by calling ScrollController.jumpTo() or '
          'animateTo(), which properly transitions the activity.',
      'bad': true,
    },
    {
      'tip': 'Use ScrollNotification for Fling Detection',
      'icon': Icons.notifications_active,
      'body': 'To detect when a fling starts, listen for '
          'ScrollUpdateNotification and check if the drag detail '
          'is null (ballistic) vs non-null (user drag). This '
          'lets you respond differently to flings vs drags.',
      'bad': false,
    },
    {
      'tip': 'Respect minFlingVelocity',
      'icon': Icons.speed,
      'body': 'When creating custom ScrollPhysics, be careful '
          'with minFlingVelocity. Setting it too low makes the '
          'scroll feel twitchy. Setting it too high makes it '
          'hard to trigger a fling. The default 50 px/s works '
          'well for most cases.',
      'bad': false,
    },
    {
      'tip': 'Heavy createBallisticSimulation',
      'icon': Icons.memory,
      'body': 'The createBallisticSimulation method is called on '
          'the UI thread. If your custom simulation constructor '
          'does heavy computation (complex spring parameters, '
          'path calculations), it can cause a jank frame at '
          'the start of the fling. Keep it lightweight.',
      'bad': true,
    },
    {
      'tip': 'Testing Fling Behavior',
      'icon': Icons.science,
      'body': 'In widget tests, use tester.fling() to simulate '
          'a fling gesture. Follow with tester.pumpAndSettle() '
          'to let the ballistic simulation run to completion. '
          'Use tester.pump(duration) to inspect intermediate '
          'positions during the fling.',
      'bad': false,
    },
  ];

  print('  Prepared ${tips.length} tips');

  final tipWidgets = tips.map<Widget>((t) {
    final isBad = t['bad'] as bool;
    final color = isBad ? Colors.red[700]! : Colors.blue[700]!;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            isBad ? Icons.error_outline : Icons.lightbulb_outline,
            color: color,
            size: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      t['tip'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    if (isBad) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'PITFALL',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[800],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  t['body'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 8: Visual Demonstration
  // ============================================================
  print('=== Section 8: Visual Demonstration ===');

  // Build a fling velocity visualization showing how different
  // velocities produce different scroll distances
  final velocityExamples = <Map<String, dynamic>>[
    {
      'label': 'Light flick',
      'velocity': 200,
      'distance': '~80 px',
      'fraction': 0.10,
    },
    {
      'label': 'Normal swipe',
      'velocity': 1000,
      'distance': '~400 px',
      'fraction': 0.35,
    },
    {
      'label': 'Fast fling',
      'velocity': 3000,
      'distance': '~1200 px',
      'fraction': 0.65,
    },
    {
      'label': 'Maximum fling',
      'velocity': 8000,
      'distance': '~3200 px',
      'fraction': 1.0,
    },
  ];

  final velocityViz = velocityExamples.map<Widget>((v) {
    final fraction = v['fraction'] as double;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                v['label'] as String,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue[800],
                ),
              ),
              Text(
                '${v['velocity']} px/s → ${v['distance']}',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: fraction,
              minHeight: 12,
              backgroundColor: Colors.blue[100],
              valueColor: AlwaysStoppedAnimation<Color>(
                Color.lerp(Colors.lightBlue, Colors.blue[900], fraction)!,
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();

  print('  Built velocity visualization with '
      '${velocityExamples.length} examples');

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  print('Assembling final layout...');

  Widget sectionHeader(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[700]!, Colors.blue[500]!],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  print('BallisticScrollActivity Deep Demo complete — returning widget');

  return Scaffold(
    appBar: AppBar(
      title: const Text('BallisticScrollActivity Deep Demo'),
      backgroundColor: Colors.blue[700],
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue[800]!, Colors.lightBlue[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                const Icon(Icons.swipe, color: Colors.white, size: 44),
                const SizedBox(height: 10),
                const Text(
                  'BallisticScrollActivity',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'The scroll activity that coasts under momentum '
                  'after a fling gesture — running a physics '
                  'simulation on every frame until the scroll '
                  'comes to rest.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.blue[100],
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          // Section 1: Concept
          sectionHeader('Concept', Icons.school),
          ...conceptWidgets,

          // Section 2: Activity State Machine
          sectionHeader('Activity State Machine', Icons.account_tree),
          ...stateWidgets,

          // Section 3: Simulation Types
          sectionHeader('Simulation Types', Icons.science),
          ...simWidgets,

          // Section 4: Velocity & Thresholds
          sectionHeader('Velocity & Thresholds', Icons.straighten),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Column(
              children: [
                velocityHeader,
                ...velocityRows,
              ],
            ),
          ),

          // Section 5: Real-World Patterns
          sectionHeader('Real-World Patterns', Icons.apps),
          ...patternWidgets,

          // Section 6: Activity Internals
          sectionHeader('Activity Internals', Icons.developer_mode),
          ...internalWidgets,

          // Section 7: Pitfalls & Tips
          sectionHeader('Pitfalls & Tips', Icons.tips_and_updates),
          ...tipWidgets,

          // Section 8: Visual Demonstration
          sectionHeader('Fling Velocity → Distance', Icons.bar_chart),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue[200]!),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How fling velocity translates to scroll distance '
                  '(approximate, with default friction):',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.blue[800],
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 12),
                ...velocityViz,
              ],
            ),
          ),

          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}
