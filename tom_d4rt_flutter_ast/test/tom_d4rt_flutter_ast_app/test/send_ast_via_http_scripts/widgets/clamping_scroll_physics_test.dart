// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — ClampingScrollPhysics
// Demonstrates ClampingScrollPhysics, the Android-style scroll physics
// that hard-stops at content boundaries with a glow overscroll indicator.
// Covers clamp behavior, boundary conditions, fling deceleration,
// glow indicator, platform defaults, and real-world patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ClampingScrollPhysics Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is ClampingScrollPhysics?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.android,
      'title': 'Android-Style Scrolling',
      'body': 'ClampingScrollPhysics is the default scroll behavior '
          'on Android. When the user scrolls past the content edge, '
          'the scroll position is "clamped" — it refuses to go '
          'beyond the boundary. Instead, any excess energy is '
          'displayed as a glowing overscroll indicator at the edge.',
      'accent': Colors.green[700]!,
    },
    {
      'icon': Icons.block,
      'title': 'Hard Stop at Edges',
      'body': 'Unlike BouncingScrollPhysics (iOS) which rubber-bands '
          'past the edge, ClampingScrollPhysics creates a firm '
          'boundary. The scroll position will never be less than '
          'minScrollExtent or greater than maxScrollExtent. This '
          'is the "clamping" behavior — values are clamped to the '
          'valid range.',
      'accent': Colors.green[800]!,
    },
    {
      'icon': Icons.flash_on,
      'title': 'Overscroll Glow Indicator',
      'body': 'When the user drags or flings past the edge, an '
          'OverscrollIndicatorNotification is dispatched. The '
          'GlowingOverscrollIndicator (part of MaterialApp\'s '
          'ScrollBehavior) renders the characteristic blue/green '
          'glow at the edge. This is a visual feedback mechanism '
          'that replaces the bounce effect.',
      'accent': Colors.lightGreen[700]!,
    },
    {
      'icon': Icons.compare,
      'title': 'Clamp vs Bounce',
      'body': 'The fundamental difference: Clamping restricts the '
          'scroll position to valid bounds and uses a visual '
          'indicator for overscroll. Bouncing allows the position '
          'to exceed bounds temporarily and uses spring physics '
          'to pull it back. Each approach feels native on its '
          'respective platform.',
      'accent': Colors.green[600]!,
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
  // SECTION 2: API Surface
  // ============================================================
  print('=== Section 2: API Surface ===');

  final apiMembers = <Map<String, dynamic>>[
    {
      'name': 'ClampingScrollPhysics({parent})',
      'type': 'Constructor',
      'desc': 'Creates clamping scroll physics. The optional parent '
          'parameter allows chaining with another ScrollPhysics. '
          'Common: ClampingScrollPhysics(parent: '
          'AlwaysScrollableScrollPhysics()) for scrolling even '
          'when content fits.',
      'icon': Icons.build,
    },
    {
      'name': 'applyTo(ScrollPhysics? ancestor)',
      'type': 'ClampingScrollPhysics',
      'desc': 'Creates a copy of this physics combined with an '
          'ancestor physics. Used by the framework to compose '
          'physics chains during ScrollConfiguration resolution.',
      'icon': Icons.copy,
    },
    {
      'name': 'applyBoundaryConditions(pos, value)',
      'type': 'double',
      'desc': 'Returns the overscroll amount that should NOT be '
          'applied to the position. If scrolling past max, '
          'returns the excess. This is how clamping works — the '
          'excess is "rejected" and converted to an overscroll '
          'indicator glow.',
      'icon': Icons.border_all,
    },
    {
      'name': 'createBallisticSimulation(pos, velocity)',
      'type': 'Simulation?',
      'desc': 'Creates a ClampingScrollSimulation for fling gestures. '
          'The simulation decelerates with friction and hard stops '
          'at the content boundary. Returns null if velocity is '
          'below minFlingVelocity and position is at rest.',
      'icon': Icons.play_arrow,
    },
    {
      'name': 'minFlingVelocity',
      'type': 'double',
      'desc': 'The minimum velocity (in px/s) to trigger a ballistic '
          'fling scroll. Below this, the scroll stops immediately '
          'when the user lifts their finger.',
      'icon': Icons.speed,
    },
    {
      'name': 'maxFlingVelocity',
      'type': 'double',
      'desc': 'Maximum velocity cap for fling gestures. Prevents '
          'unreasonably fast scrolling from multi-touch artifacts '
          'or gesture detector edge cases.',
      'icon': Icons.trending_up,
    },
    {
      'name': 'minFlingDistance',
      'type': 'double',
      'desc': 'The minimum distance (in px) a fling must travel '
          'before being considered a fling. Helps filter out '
          'accidental micro-swipes.',
      'icon': Icons.straighten,
    },
  ];

  print('  Prepared ${apiMembers.length} API members');

  final apiWidgets = apiMembers.map<Widget>((m) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(m['icon'] as IconData, color: Colors.green[700], size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        m['name'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900],
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        m['type'] as String,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.green[800],
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  m['desc'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 3: Boundary Condition Scenarios
  // ============================================================
  print('=== Section 3: Boundary Conditions ===');

  final boundaries = <Map<String, dynamic>>[
    {
      'scenario': 'Scrolling within bounds',
      'position': 'min < pos < max',
      'result': 'Returns 0.0 — scroll freely',
      'detail': 'No boundary is approached. The position updates '
          'normally without any clamping.',
      'color': Colors.green[600]!,
    },
    {
      'scenario': 'Drag past top edge',
      'position': 'pos approaches < min',
      'result': 'Returns underscroll excess',
      'detail': 'The excess pixels are rejected. The position stays '
          'at min. Glow indicator appears at the top.',
      'color': Colors.orange[600]!,
    },
    {
      'scenario': 'Drag past bottom edge',
      'position': 'pos approaches > max',
      'result': 'Returns overscroll excess',
      'detail': 'The excess pixels are rejected. The position stays '
          'at max. Glow indicator appears at the bottom.',
      'color': Colors.orange[700]!,
    },
    {
      'scenario': 'Fling into top boundary',
      'position': 'velocity < 0, pos near min',
      'result': 'Simulation stops at min',
      'detail': 'ClampingScrollSimulation decelerates and hard-stops '
          'at the boundary. Remaining energy triggers glow.',
      'color': Colors.red[600]!,
    },
    {
      'scenario': 'Fling into bottom boundary',
      'position': 'velocity > 0, pos near max',
      'result': 'Simulation stops at max',
      'detail': 'ClampingScrollSimulation decelerates and hard-stops '
          'at the boundary. Remaining energy triggers glow.',
      'color': Colors.red[600]!,
    },
    {
      'scenario': 'Content fits in viewport',
      'position': 'max == min == 0',
      'result': 'No scrolling possible',
      'detail': 'With default physics, no scroll occurs. To force '
          'scrolling feedback, use AlwaysScrollableScrollPhysics.',
      'color': Colors.grey[600]!,
    },
  ];

  print('  Prepared ${boundaries.length} boundary scenarios');

  final boundaryWidgets = boundaries.map<Widget>((b) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (b['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (b['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  b['scenario'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: b['color'] as Color,
                  ),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: (b['color'] as Color).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  b['result'] as String,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: b['color'] as Color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            b['detail'] as String,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 4: Clamp vs Bounce Comparison
  // ============================================================
  print('=== Section 4: Clamp vs Bounce Comparison ===');

  final comparison = <Map<String, dynamic>>[
    {
      'aspect': 'Edge behavior',
      'clamping': 'Hard stop — position never exceeds bounds',
      'bouncing': 'Rubber-band — position stretches past bounds',
    },
    {
      'aspect': 'Visual feedback',
      'clamping': 'Glow indicator at the edge',
      'bouncing': 'Elastic stretch of content beyond edge',
    },
    {
      'aspect': 'Fling at boundary',
      'clamping': 'Simulation stops immediately at edge',
      'bouncing': 'Simulation overshoots then springs back',
    },
    {
      'aspect': 'Default platform',
      'clamping': 'Android, Fuchsia',
      'bouncing': 'iOS, macOS',
    },
    {
      'aspect': 'applyBoundaryConditions',
      'clamping': 'Returns excess (rejects overscroll)',
      'bouncing': 'Returns 0 (allows all values)',
    },
    {
      'aspect': 'Simulation type',
      'clamping': 'ClampingScrollSimulation',
      'bouncing': 'BouncingScrollSimulation + SpringSimulation',
    },
    {
      'aspect': 'Friction feel',
      'clamping': 'Lower friction — longer coast distance',
      'bouncing': 'Higher friction — shorter coast distance',
    },
  ];

  print('  Prepared ${comparison.length} comparison aspects');

  final compHeader = Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
    decoration: BoxDecoration(
      color: Colors.green[800],
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Row(
      children: const [
        Expanded(
            flex: 3,
            child: Text('Aspect',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12))),
        Expanded(
            flex: 4,
            child: Text('Clamping',
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center)),
        Expanded(
            flex: 4,
            child: Text('Bouncing',
                style: TextStyle(color: Colors.white, fontSize: 12),
                textAlign: TextAlign.center)),
      ],
    ),
  );

  final compRows = comparison.asMap().entries.map<Widget>((entry) {
    final i = entry.key;
    final row = entry.value;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: i.isEven ? Colors.green[50] : Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.green[100]!, width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: Text(
              row['aspect'] as String,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: Colors.green[900],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              row['clamping'] as String,
              style: const TextStyle(fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              row['bouncing'] as String,
              style: const TextStyle(fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 5: Glow Indicator Details
  // ============================================================
  print('=== Section 5: Glow Indicator ===');

  final glowDetails = <Map<String, dynamic>>[
    {
      'aspect': 'OverscrollIndicatorNotification',
      'icon': Icons.notifications,
      'detail': 'Dispatched when excess overscroll is generated. '
          'Contains the overscroll amount and the axis direction. '
          'GlowingOverscrollIndicator listens for these.',
    },
    {
      'aspect': 'GlowingOverscrollIndicator',
      'icon': Icons.blur_on,
      'detail': 'The widget that paints the edge glow. Automatically '
          'included by MaterialApp\'s ScrollBehavior. Renders a '
          'gradient arc at the overscrolled edge, sized '
          'proportional to the overscroll energy.',
    },
    {
      'aspect': 'Disabling the Glow',
      'icon': Icons.visibility_off,
      'detail': 'To suppress the glow, wrap the scrollable in a '
          'NotificationListener<OverscrollIndicatorNotification> '
          'and call notification.disallowIndicator(). Or use '
          'ScrollConfiguration with a custom ScrollBehavior.',
    },
    {
      'aspect': 'Customizing Glow Color',
      'icon': Icons.palette,
      'detail': 'The glow color defaults to ThemeData.colorScheme'
          '.secondary. Override it via ScrollConfiguration or '
          'by providing a custom GlowingOverscrollIndicator '
          'with the desired color.',
    },
    {
      'aspect': 'StretchingOverscrollIndicator',
      'icon': Icons.open_with,
      'detail': 'Android 12+ uses a stretch effect instead of glow. '
          'Flutter supports this via StretchingOverscrollIndicator '
          'in the ScrollBehavior. It stretches the content area '
          'instead of painting a glow arc.',
    },
  ];

  print('  Prepared ${glowDetails.length} glow details');

  final glowWidgets = glowDetails.map<Widget>((g) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(g['icon'] as IconData,
              color: Colors.green[700], size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  g['aspect'] as String,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.green[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  g['detail'] as String,
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
  // SECTION 6: Physics Chaining
  // ============================================================
  print('=== Section 6: Physics Chaining ===');

  final chains = <Map<String, dynamic>>[
    {
      'chain': 'ClampingScrollPhysics()',
      'desc': 'Default: clamp at edges, no scroll when content fits.',
      'icon': Icons.link,
      'color': Colors.green[600]!,
    },
    {
      'chain': 'ClampingScrollPhysics(\n'
          '  parent: AlwaysScrollableScrollPhysics()\n'
          ')',
      'desc': 'Clamp at edges, but allow scroll even when content '
          'fits. Useful for pull-to-refresh patterns on Android.',
      'icon': Icons.link,
      'color': Colors.green[700]!,
    },
    {
      'chain': 'PageScrollPhysics(\n'
          '  parent: ClampingScrollPhysics()\n'
          ')',
      'desc': 'Page snapping with clamping at the first and last '
          'page. Combines discrete page settling with Android-style '
          'edge behavior.',
      'icon': Icons.link,
      'color': Colors.green[800]!,
    },
    {
      'chain': 'CustomScrollPhysics(\n'
          '  parent: ClampingScrollPhysics()\n'
          ')',
      'desc': 'Your custom physics (e.g., different friction) '
          'with clamping as the fallback boundary behavior.',
      'icon': Icons.link,
      'color': Colors.teal[700]!,
    },
  ];

  print('  Prepared ${chains.length} physics chains');

  final chainWidgets = chains.map<Widget>((ch) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (ch['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (ch['color'] as Color).withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: (ch['color'] as Color).withOpacity(0.05),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              ch['chain'] as String,
              style: TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
                color: ch['color'] as Color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            ch['desc'] as String,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 7: Real-World Patterns
  // ============================================================
  print('=== Section 7: Real-World Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Android Chat App',
      'icon': Icons.chat,
      'scenario': 'A message list that uses ClampingScrollPhysics '
          'by default (since it\'s Android). Scrolling to the top '
          'shows the glow, indicating no older messages are loaded '
          'yet. Pull-to-refresh loads more history.',
      'color': Colors.green[600]!,
    },
    {
      'title': 'Settings Screen',
      'icon': Icons.settings,
      'scenario': 'A scrollable settings list. ClampingScrollPhysics '
          'provides familiar Android feel. The glow at bottom '
          'tells the user they\'ve seen all settings.',
      'color': Colors.green[700]!,
    },
    {
      'title': 'Cross-Platform Consistency',
      'icon': Icons.devices,
      'scenario': 'Force Android-style scrolling on all platforms '
          'by explicitly setting physics: ClampingScrollPhysics(). '
          'Useful for apps that want a uniform look regardless '
          'of the user\'s platform.',
      'color': Colors.teal[600]!,
    },
    {
      'title': 'Nested Scroll Views',
      'icon': Icons.view_agenda,
      'scenario': 'Inner scroll views in NestedScrollView. '
          'ClampingScrollPhysics prevents the inner view from '
          'overscrolling into the outer view\'s territory, '
          'keeping the scroll coordination clean.',
      'color': Colors.green[800]!,
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(p['icon'] as IconData,
              color: p['color'] as Color, size: 26),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  p['title'] as String,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: p['color'] as Color,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  p['scenario'] as String,
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
  // SECTION 8: Tips & Gotchas
  // ============================================================
  print('=== Section 8: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'tip': 'Don\'t Mix Clamping with RefreshIndicator Directly',
      'body': 'RefreshIndicator needs overscroll to trigger. With '
          'ClampingScrollPhysics the position is clamped, so the '
          'indicator works through OverscrollNotification, not '
          'actual over-position. Ensure '
          'AlwaysScrollableScrollPhysics is in the physics chain '
          'for pull-to-refresh to work when content fits.',
      'warning': true,
    },
    {
      'tip': 'Platform-Aware Defaults',
      'body': 'You rarely need to specify ClampingScrollPhysics '
          'explicitly. Flutter\'s ScrollConfiguration automatically '
          'picks clamping on Android and bouncing on iOS. Override '
          'only when you want a non-native feel.',
      'warning': false,
    },
    {
      'tip': 'Glow vs Stretch on Android 12+',
      'body': 'Flutter 3+ supports StretchingOverscrollIndicator '
          'for Android 12+ Material 3 stretch effect. If your app '
          'targets newer Android, consider using the stretch '
          'behavior via ScrollBehavior for a modern feel.',
      'warning': false,
    },
    {
      'tip': 'Performance with Overscroll',
      'body': 'The glow indicator is lightweight — it only paints '
          'when overscroll energy is non-zero. No performance '
          'concern here. The stretch indicator is slightly more '
          'expensive as it transforms the scroll area.',
      'warning': false,
    },
    {
      'tip': 'Testing Overscroll in Widget Tests',
      'body': 'In widget tests, tester.drag() past the boundary '
          'will trigger OverscrollIndicatorNotification. To verify '
          'the glow appears, check that a GlowingOverscrollIndicator '
          'widget is found and has a non-zero glow value.',
      'warning': false,
    },
  ];

  print('  Prepared ${tips.length} tips');

  final tipWidgets = tips.map<Widget>((t) {
    final isWarning = t['warning'] as bool;
    final color = isWarning ? Colors.orange[700]! : Colors.green[700]!;
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
            isWarning ? Icons.warning_amber : Icons.lightbulb_outline,
            color: color,
            size: 22,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        t['tip'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                    if (isWarning)
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.orange[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'GOTCHA',
                          style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[800],
                          ),
                        ),
                      ),
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
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  print('Assembling final layout...');

  Widget sectionHeader(String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 24, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.green[700]!, Colors.green[500]!],
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

  print('ClampingScrollPhysics Deep Demo complete — returning widget');

  return Scaffold(
    appBar: AppBar(
      title: const Text('ClampingScrollPhysics Deep Demo'),
      backgroundColor: Colors.green[700],
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
                colors: [Colors.green[800]!, Colors.lightGreen[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              children: [
                const Icon(Icons.android, color: Colors.white, size: 44),
                const SizedBox(height: 10),
                const Text(
                  'ClampingScrollPhysics',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Android-style scroll physics that hard-stops at '
                  'content boundaries with a glow overscroll indicator '
                  '— the default scrolling feel on Android.',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.green[100],
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

          // Section 2: API Surface
          sectionHeader('API Surface', Icons.api),
          ...apiWidgets,

          // Section 3: Boundary Conditions
          sectionHeader('Boundary Conditions', Icons.border_all),
          ...boundaryWidgets,

          // Section 4: Clamp vs Bounce Comparison
          sectionHeader('Clamp vs Bounce', Icons.compare),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green[200]!),
            ),
            child: Column(
              children: [
                compHeader,
                ...compRows,
              ],
            ),
          ),

          // Section 5: Glow Indicator
          sectionHeader('Glow Indicator', Icons.flash_on),
          ...glowWidgets,

          // Section 6: Physics Chaining
          sectionHeader('Physics Chaining', Icons.link),
          ...chainWidgets,

          // Section 7: Real-World Patterns
          sectionHeader('Real-World Patterns', Icons.apps),
          ...patternWidgets,

          // Section 8: Tips & Gotchas
          sectionHeader('Tips & Gotchas', Icons.tips_and_updates),
          ...tipWidgets,

          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}
