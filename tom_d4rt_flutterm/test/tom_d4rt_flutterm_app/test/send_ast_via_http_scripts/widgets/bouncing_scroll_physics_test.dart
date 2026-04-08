// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — BouncingScrollPhysics
// Demonstrates BouncingScrollPhysics, the iOS-style scroll physics
// that allows overscroll with a rubber-band bounce effect. Covers
// bounce vs clamp comparison, platform defaults, physics chaining,
// compatible widgets, and real-world patterns.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('BouncingScrollPhysics Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is BouncingScrollPhysics?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.swipe_vertical,
      'title': 'Scroll Physics in Flutter',
      'body': 'Scroll physics control HOW scrolling behaves — not '
          'what scrolls, but the feel of the scroll. They determine '
          'what happens when you scroll past the edge, how fast '
          'flick-scrolling decelerates, and whether rubber-banding '
          'occurs. Every scrollable widget accepts a physics parameter.',
      'accent': Colors.deepOrange[700]!,
    },
    {
      'icon': Icons.sports_basketball,
      'title': 'The Bounce Effect',
      'body': 'BouncingScrollPhysics creates an iOS-style overscroll: '
          'when you scroll past the content boundary, the list '
          'stretches elastically then bounces back. This provides '
          'a visual signal that you\'ve reached the edge and feels '
          'natural on touch devices.',
      'accent': Colors.orange[800]!,
    },
    {
      'icon': Icons.compare,
      'title': 'Bounce vs Clamp',
      'body': 'The two main physics types: BouncingScrollPhysics '
          '(bounce/rubber-band past edges — iOS default) and '
          'ClampingScrollPhysics (hard stop at edges with glow '
          'overscroll indicator — Android default). Choosing between '
          'them is a UX decision tied to platform conventions.',
      'accent': Colors.deepOrange[800]!,
    },
    {
      'icon': Icons.phone_iphone,
      'title': 'Platform Defaults',
      'body': 'By default, Flutter uses BouncingScrollPhysics on iOS '
          'and macOS, and ClampingScrollPhysics on Android. This is '
          'handled by ScrollConfiguration, which picks the right '
          'physics automatically. You override this per-widget by '
          'setting the physics parameter explicitly.',
      'accent': Colors.orange[700]!,
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
      'name': 'BouncingScrollPhysics({parent})',
      'type': 'Constructor',
      'desc': 'Creates bouncing scroll physics. The optional parent '
          'parameter allows chaining with another ScrollPhysics (e.g., '
          'AlwaysScrollableScrollPhysics as parent to ensure bounce '
          'even when content fits).',
      'icon': Icons.build,
    },
    {
      'name': 'applyTo(ScrollPhysics? ancestor)',
      'type': 'BouncingScrollPhysics',
      'desc': 'Creates a copy of this physics combined with an ancestor '
          'physics. Used by the framework to compose physics chains.',
      'icon': Icons.copy,
    },
    {
      'name': 'applyPhysicsToUserOffset(pos, offset)',
      'type': 'double',
      'desc': 'Applies the rubber-band effect to user drag offsets. '
          'When overscrolled, the drag offset is dampened (moves less '
          'per pixel dragged), creating the elastic feel.',
      'icon': Icons.drag_handle,
    },
    {
      'name': 'applyBoundaryConditions(pos, value)',
      'type': 'double',
      'desc': 'Returns 0.0, allowing all scroll values (including '
          'overscroll). Unlike ClampingScrollPhysics which returns '
          'the excess to clamp, bouncing allows overshooting.',
      'icon': Icons.border_all,
    },
    {
      'name': 'createBallisticSimulation(pos, velocity)',
      'type': 'Simulation?',
      'desc': 'Creates a spring simulation to bounce back when the '
          'user releases while overscrolled. Also creates deceleration '
          'simulation for fling gestures within bounds.',
      'icon': Icons.play_arrow,
    },
    {
      'name': 'minFlingVelocity',
      'type': 'double',
      'desc': 'The minimum velocity needed to trigger a fling scroll. '
          'BouncingScrollPhysics uses a very small threshold, making '
          'it responsive to light flicks.',
      'icon': Icons.speed,
    },
    {
      'name': 'frictionFactor(overscrollFraction)',
      'type': 'double',
      'desc': 'Returns the friction factor for the given overscroll '
          'amount. As overscroll increases, friction increases, making '
          'it progressively harder to overscroll further.',
      'icon': Icons.show_chart,
    },
  ];

  final apiWidgets = apiMembers.map<Widget>((m) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.deepOrange.withOpacity(0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: Colors.deepOrange[600]!, width: 3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(m['icon'] as IconData,
              color: Colors.deepOrange[600], size: 20),
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
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.bold,
                          color: Colors.deepOrange[700],
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 1),
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        m['type'] as String,
                        style: TextStyle(
                          fontSize: 9,
                          color: Colors.deepOrange[400],
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  m['desc'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 3: Live Bounce Demo
  // ============================================================
  print('=== Section 3: Live Bounce Demo ===');

  final bouncingList = Container(
    height: 220,
    decoration: BoxDecoration(
      border: Border.all(color: Colors.deepOrange.withOpacity(0.3)),
      borderRadius: BorderRadius.circular(12),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          color: Colors.deepOrange[600],
          child: const Text(
            'BouncingScrollPhysics — Drag to see bounce',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 15,
            itemBuilder: (context, index) {
              final colors = [
                Colors.deepOrange[50],
                Colors.orange[50],
                Colors.amber[50],
              ];
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: colors[index % 3],
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.deepOrange.withOpacity(0.1)),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.deepOrange.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.deepOrange[700],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'Bouncing item ${index + 1}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Bounce vs Clamp Comparison
  // ============================================================
  print('=== Section 4: Bounce vs Clamp ===');

  Widget buildComparisonList({
    required String title,
    required ScrollPhysics physics,
    required Color accent,
    required String physicsName,
  }) {
    return Expanded(
      child: Container(
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          border: Border.all(color: accent.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(10),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              color: accent,
              child: Column(
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    physicsName,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontFamily: 'monospace',
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                physics: physics,
                itemCount: 12,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: index.isEven
                          ? accent.withOpacity(0.04)
                          : accent.withOpacity(0.08),
                    ),
                    child: Text(
                      'Item ${index + 1}',
                      style: TextStyle(
                          fontSize: 12, color: Colors.grey[700]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  final comparisonRow = Row(
    children: [
      buildComparisonList(
        title: 'Bouncing',
        physics: const BouncingScrollPhysics(),
        accent: Colors.deepOrange[600]!,
        physicsName: 'BouncingScrollPhysics',
      ),
      buildComparisonList(
        title: 'Clamping',
        physics: const ClampingScrollPhysics(),
        accent: Colors.blueGrey[600]!,
        physicsName: 'ClampingScrollPhysics',
      ),
    ],
  );

  // Behavior comparison table
  final compData = <Map<String, String>>[
    {
      'aspect': 'Overscroll',
      'bouncing': 'Elastic rubber-band',
      'clamping': 'Hard stop + glow',
    },
    {
      'aspect': 'Release behavior',
      'bouncing': 'Spring bounce back',
      'clamping': 'Immediate stop',
    },
    {
      'aspect': 'Visual indicator',
      'bouncing': 'Content stretches',
      'clamping': 'Edge glow effect',
    },
    {
      'aspect': 'Platform default',
      'bouncing': 'iOS, macOS',
      'clamping': 'Android',
    },
    {
      'aspect': 'Feel',
      'bouncing': 'Elastic, playful',
      'clamping': 'Rigid, controlled',
    },
  ];

  final compTableHeader = Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    decoration: BoxDecoration(
      color: Colors.deepOrange[700],
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    child: Row(
      children: const [
        SizedBox(
            width: 90,
            child: Text('Aspect',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11))),
        Expanded(
            child: Text('Bouncing',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11))),
        Expanded(
            child: Text('Clamping',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11))),
      ],
    ),
  );

  final compTableRows = compData.asMap().entries.map<Widget>((entry) {
    final i = entry.key;
    final row = entry.value;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      color: i.isEven
          ? Colors.deepOrange.withOpacity(0.03)
          : Colors.deepOrange.withOpacity(0.07),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(row['aspect']!,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 11)),
          ),
          Expanded(
            child: Text(row['bouncing']!,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 11, color: Colors.deepOrange[700])),
          ),
          Expanded(
            child: Text(row['clamping']!,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: Colors.blueGrey[600])),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 5: Platform Defaults
  // ============================================================
  print('=== Section 5: Platform Defaults ===');

  final platformData = <Map<String, dynamic>>[
    {
      'platform': 'iOS',
      'icon': Icons.phone_iphone,
      'physics': 'BouncingScrollPhysics',
      'color': Colors.deepOrange[600]!,
      'desc': 'iOS uses bounce by default. Users expect the elastic '
          'rubber-band effect. Not using bounce on iOS feels foreign.',
    },
    {
      'platform': 'macOS',
      'icon': Icons.laptop_mac,
      'physics': 'BouncingScrollPhysics',
      'color': Colors.orange[700]!,
      'desc': 'macOS also uses bounce, consistent with its scroll '
          'behavior in native apps (Safari, Finder, etc.).',
    },
    {
      'platform': 'Android',
      'icon': Icons.phone_android,
      'physics': 'ClampingScrollPhysics',
      'color': Colors.blueGrey[600]!,
      'desc': 'Android uses clamping with a glow overscroll indicator. '
          'Some Android apps (e.g., Telegram) use bounce instead '
          'for a more fluid feel — it\'s a design choice.',
    },
    {
      'platform': 'Web',
      'icon': Icons.web,
      'physics': 'ClampingScrollPhysics',
      'color': Colors.grey[700]!,
      'desc': 'Web defaults to clamping. Bounce can feel odd with '
          'mouse wheel scrolling but works well with touch input.',
    },
    {
      'platform': 'Windows / Linux',
      'icon': Icons.desktop_windows,
      'physics': 'ClampingScrollPhysics',
      'color': Colors.blueGrey[500]!,
      'desc': 'Desktop platforms default to clamping. Mouse and '
          'touchpad scrolling typically expect rigid bounds.',
    },
  ];

  final platformWidgets = platformData.map<Widget>((p) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (p['color'] as Color).withOpacity(0.06),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: p['color'] as Color, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(p['icon'] as IconData,
              color: p['color'] as Color, size: 24),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      p['platform'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: p['color'] as Color,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: (p['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        p['physics'] as String,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 9,
                          color: p['color'] as Color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  p['desc'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.3),
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

  final chainExamples = <Map<String, dynamic>>[
    {
      'title': 'BouncingScrollPhysics (standalone)',
      'code': 'physics: const BouncingScrollPhysics()',
      'desc': 'Basic usage. Provides bounce but if content doesn\'t '
          'exceed viewport, scrolling is disabled (no bounce on empty '
          'lists or short content).',
      'icon': Icons.sports_basketball,
      'color': Colors.deepOrange[600]!,
    },
    {
      'title': 'Always Scrollable + Bouncing',
      'code': 'physics: const BouncingScrollPhysics(\n'
          '  parent: AlwaysScrollableScrollPhysics(),\n'
          ')',
      'desc': 'Chaining with AlwaysScrollableScrollPhysics ensures '
          'bounce works even when content fits in the viewport. '
          'This is the most common combination for pull-to-refresh.',
      'icon': Icons.refresh,
      'color': Colors.orange[700]!,
    },
    {
      'title': 'Never Scrollable + Bouncing',
      'code': 'physics: const BouncingScrollPhysics(\n'
          '  parent: NeverScrollableScrollPhysics(),\n'
          ')',
      'desc': 'Disables scrolling entirely. The bouncing physics is '
          'there but NeverScrollable prevents any scroll input. '
          'Useful for programmatic-only scrolling with bounce feel.',
      'icon': Icons.block,
      'color': Colors.grey[600]!,
    },
    {
      'title': 'Custom Chaining',
      'code': 'physics: const BouncingScrollPhysics(\n'
          '  parent: PageScrollPhysics(),\n'
          ')',
      'desc': 'Advanced: combine bouncing with page snap physics. '
          'Pages snap to boundaries but bounce at the very start '
          'and end of the page list.',
      'icon': Icons.auto_stories,
      'color': Colors.deepPurple[500]!,
    },
  ];

  final chainWidgets = chainExamples.map<Widget>((ch) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: (ch['color'] as Color).withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: (ch['color'] as Color).withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(ch['icon'] as IconData,
                  color: ch['color'] as Color, size: 22),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  ch['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: ch['color'] as Color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            ch['desc'] as String,
            style: const TextStyle(fontSize: 12, height: 1.4),
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[900],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              ch['code'] as String,
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 11,
                color: Colors.greenAccent,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 7: Compatible Widgets
  // ============================================================
  print('=== Section 7: Compatible Widgets ===');

  final compatibleWidgets = <Map<String, dynamic>>[
    {
      'widget': 'ListView',
      'desc': 'Vertical or horizontal list. Most common use case for '
          'BouncingScrollPhysics.',
      'icon': Icons.view_list,
    },
    {
      'widget': 'GridView',
      'desc': 'Grid layout with scrollable content. Bounce works on '
          'the scroll direction.',
      'icon': Icons.grid_view,
    },
    {
      'widget': 'SingleChildScrollView',
      'desc': 'Wraps a single child in a scrollable area. Good for '
          'forms or long content.',
      'icon': Icons.vertical_align_center,
    },
    {
      'widget': 'CustomScrollView',
      'desc': 'Slivers-based scrollable. Combine with SliverAppBar '
          'for collapsing headers with bounce.',
      'icon': Icons.view_day,
    },
    {
      'widget': 'PageView',
      'desc': 'Paginated swiping. Bounce at the first and last page.',
      'icon': Icons.auto_stories,
    },
    {
      'widget': 'NestedScrollView',
      'desc': 'Nested scrolling areas. Outer and inner can each have '
          'different physics.',
      'icon': Icons.layers,
    },
    {
      'widget': 'ReorderableListView',
      'desc': 'Drag-to-reorder list. Bounce physics affects normal '
          'scrolling between reorder operations.',
      'icon': Icons.swap_vert,
    },
    {
      'widget': 'TabBarView',
      'desc': 'Horizontal page swiping for tabs. Bounce at first '
          'and last tab.',
      'icon': Icons.tab,
    },
  ];

  final compatGrid = Wrap(
    spacing: 8,
    runSpacing: 8,
    children: compatibleWidgets.map<Widget>((w) {
      return Container(
        width: 155,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.deepOrange.withOpacity(0.04),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
              color: Colors.deepOrange.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(w['icon'] as IconData,
                    color: Colors.deepOrange[600], size: 18),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    w['widget'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                      color: Colors.deepOrange[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              w['desc'] as String,
              style: TextStyle(fontSize: 10, color: Colors.grey[700], height: 1.3),
            ),
          ],
        ),
      );
    }).toList(),
  );

  // ============================================================
  // SECTION 8: Patterns & Pitfalls
  // ============================================================
  print('=== Section 8: Patterns & Pitfalls ===');

  final tips = <Map<String, dynamic>>[
    {
      'type': 'pattern',
      'title': 'Pull-to-refresh with bounce',
      'detail': 'RefreshIndicator + BouncingScrollPhysics(parent: '
          'AlwaysScrollableScrollPhysics()) gives a natural pull-to-'
          'refresh. The bounce makes the pull gesture feel connected.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pattern',
      'title': 'Consistent cross-platform bounce',
      'detail': 'To enforce iOS-style bounce on Android, explicitly set '
          'physics: const BouncingScrollPhysics() on your scrollable '
          'widgets. This overrides the platform default.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pattern',
      'title': 'Always scrollable for empty states',
      'detail': 'If your list might be empty, chain with '
          'AlwaysScrollableScrollPhysics so users can still pull-to-'
          'refresh to load content.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pattern',
      'title': 'SliverAppBar + bounce for collapsible headers',
      'detail': 'BouncingScrollPhysics with CustomScrollView and '
          'SliverAppBar creates a beautiful stretching effect when '
          'overscrolling at the top — the app bar stretches.',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'type': 'pitfall',
      'title': 'Bounce on non-scrollable content',
      'detail': 'Without AlwaysScrollableScrollPhysics parent, if content '
          'fits in the viewport, bounce doesn\'t work — the list is '
          'not scrollable. This is a very common surprise.',
      'icon': Icons.warning_amber,
      'color': Colors.orange,
    },
    {
      'type': 'pitfall',
      'title': 'Bounce may confuse mouse wheel users',
      'detail': 'On desktop, mouse wheel scrolling with bounce can feel '
          'strange. Consider using ClampingScrollPhysics on desktop and '
          'bounce only on touch platforms.',
      'icon': Icons.error_outline,
      'color': Colors.red,
    },
    {
      'type': 'pitfall',
      'title': 'Performance with heavy list items',
      'detail': 'Bounce causes overscroll + return animation, rebuilding '
          'visible items. If list items are expensive to build, the bounce-'
          'back animation can stutter. Use const widgets and caching.',
      'icon': Icons.warning_amber,
      'color': Colors.orange,
    },
  ];

  final tipWidgets = tips.map<Widget>((tip) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: (tip['color'] as Color).withOpacity(0.07),
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: tip['color'] as Color, width: 4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(tip['icon'] as IconData,
              color: tip['color'] as Color, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: (tip['color'] as Color).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        (tip['type'] as String).toUpperCase(),
                        style: TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: tip['color'] as Color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        tip['title'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: tip['color'] as Color,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  tip['detail'] as String,
                  style: const TextStyle(fontSize: 12, height: 1.3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }).toList();

  // ============================================================
  // SECTION 9: Summary Dashboard
  // ============================================================
  print('=== Section 9: Summary Dashboard ===');

  final summaryItems = <Map<String, dynamic>>[
    {'label': 'API members', 'value': '${apiMembers.length}', 'icon': Icons.code},
    {'label': 'Platform defaults', 'value': '${platformData.length}', 'icon': Icons.devices},
    {'label': 'Chain patterns', 'value': '${chainExamples.length}', 'icon': Icons.link},
    {'label': 'Compatible widgets', 'value': '${compatibleWidgets.length}', 'icon': Icons.widgets},
    {'label': 'Comparison rows', 'value': '${compData.length}', 'icon': Icons.compare},
    {'label': 'Tips & pitfalls', 'value': '${tips.length}', 'icon': Icons.lightbulb},
  ];

  final summaryGrid = Wrap(
    spacing: 10,
    runSpacing: 10,
    children: summaryItems.map<Widget>((item) {
      return Container(
        width: 155,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.deepOrange.withOpacity(0.15),
              Colors.deepOrange.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
          border:
              Border.all(color: Colors.deepOrange.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Icon(item['icon'] as IconData,
                color: Colors.deepOrange[700], size: 24),
            const SizedBox(height: 6),
            Text(
              item['value'] as String,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange[900],
              ),
            ),
            const SizedBox(height: 2),
            Text(
              item['label'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }).toList(),
  );

  // ============================================================
  // Helper: Section header
  // ============================================================
  Widget bspSectionHeader(String number, String title, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(top: 28, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.deepOrange[800]!, Colors.deepOrange[400]!],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Icon(icon, color: Colors.white, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  print('BouncingScrollPhysics Deep Demo — building final layout');

  // ============================================================
  // FINAL LAYOUT
  // ============================================================
  return Scaffold(
    appBar: AppBar(
      title: const Text('BouncingScrollPhysics'),
      backgroundColor: Colors.deepOrange[700],
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepOrange[800]!,
                  Colors.deepOrange[400]!,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(Icons.sports_basketball,
                    color: Colors.white, size: 40),
                const SizedBox(height: 10),
                const Text(
                  'BouncingScrollPhysics',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'iOS-style scroll physics that allows overscroll with '
                  'an elastic rubber-band effect. When you drag past the '
                  'content boundary, it stretches and bounces back. The '
                  'default on iOS and macOS; optional on Android.',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.9),
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          // Section 1
          bspSectionHeader('1', 'Concept', Icons.lightbulb),
          ...conceptWidgets,

          // Section 2
          bspSectionHeader('2', 'API Surface', Icons.code),
          ...apiWidgets,

          // Section 3
          bspSectionHeader('3', 'Live Bounce Demo', Icons.touch_app),
          bouncingList,

          // Section 4
          bspSectionHeader('4', 'Bounce vs Clamp', Icons.compare),
          comparisonRow,
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  color: Colors.deepOrange.withOpacity(0.2)),
            ),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                compTableHeader,
                ...compTableRows,
              ],
            ),
          ),

          // Section 5
          bspSectionHeader('5', 'Platform Defaults', Icons.devices),
          ...platformWidgets,

          // Section 6
          bspSectionHeader('6', 'Physics Chaining', Icons.link),
          ...chainWidgets,

          // Section 7
          bspSectionHeader('7', 'Compatible Widgets', Icons.widgets),
          compatGrid,

          // Section 8
          bspSectionHeader(
              '8', 'Patterns & Pitfalls', Icons.lightbulb_outline),
          ...tipWidgets,

          // Section 9
          bspSectionHeader('9', 'Summary Dashboard', Icons.dashboard),
          summaryGrid,
          const SizedBox(height: 30),
        ],
      ),
    ),
  );
}
