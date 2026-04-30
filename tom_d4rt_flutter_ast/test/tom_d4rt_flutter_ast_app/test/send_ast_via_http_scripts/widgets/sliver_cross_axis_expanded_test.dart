// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverCrossAxisExpanded
// Demonstrates SliverCrossAxisExpanded — a sliver that expands to fill
// remaining cross-axis space within a SliverCrossAxisGroup. Works like
// Expanded for Row/Column but in the sliver cross-axis dimension.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverCrossAxisExpanded Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.expand,
      'title': 'What Is SliverCrossAxisExpanded?',
      'body': 'SliverCrossAxisExpanded is a sliver that fills the '
          'remaining cross-axis space within a SliverCrossAxisGroup. '
          'Think of it as the Expanded widget, but for slivers arranged '
          'side-by-side across the cross axis of a CustomScrollView.',
    },
    {
      'icon': Icons.view_column,
      'title': 'SliverCrossAxisGroup Context',
      'body': 'SliverCrossAxisExpanded must be used as a direct child of '
          'SliverCrossAxisGroup. The group arranges its children side by '
          'side on the cross axis. SliverCrossAxisExpanded children share '
          'the remaining space after fixed-width children are laid out.',
    },
    {
      'icon': Icons.aspect_ratio,
      'title': 'The flex Parameter',
      'body': 'Like Expanded, SliverCrossAxisExpanded accepts a flex value '
          '(default 1). When multiple expanded slivers share a group, '
          'they distribute remaining space proportionally to their flex. '
          'A flex of 2 gets twice the space of flex 1.',
    },
    {
      'icon': Icons.newspaper,
      'title': 'Multi-Column Layouts',
      'body': 'The primary use case is creating newspaper-style or '
          'dashboard layouts where different sliver columns scroll '
          'together but have different widths. Sidebars, main content '
          'areas, and tool panels become natural.',
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final item = conceptItems[i];
    print('Concept ${i + 1}: ${item['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.orange.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.orange.withValues(alpha: 0.12),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                item['icon'] as IconData,
                color: Colors.orange,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    item['body'] as String,
                    style: TextStyle(
                      fontSize: 12.5,
                      color: Colors.grey.shade700,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: Constructor
  // ============================================================
  print('=== Section 2: Constructor ===');

  Widget buildSCAEParam(
    String name,
    String type,
    String description,
    bool isRequired,
    String defaultVal,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 3.0,
            ),
            decoration: BoxDecoration(
              color: isRequired
                  ? Colors.red.withValues(alpha: 0.1)
                  : Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              isRequired ? 'REQUIRED' : 'OPTIONAL',
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: isRequired ? Colors.red : Colors.green.shade700,
              ),
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                        color: Colors.orange,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6.0,
                        vertical: 2.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(3.0),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          fontSize: 10.5,
                          fontFamily: 'monospace',
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                    if (defaultVal.isNotEmpty) ...[
                      const SizedBox(width: 6.0),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 2.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(3.0),
                        ),
                        child: Text(
                          '= $defaultVal',
                          style: const TextStyle(
                            fontSize: 10.0,
                            fontFamily: 'monospace',
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey.shade700,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final constructorParams = [
    buildSCAEParam(
      'flex',
      'int',
      'How much of the remaining cross-axis space this sliver should '
          'consume. Works identically to the flex parameter of Expanded.',
      false,
      '1',
    ),
    buildSCAEParam(
      'sliver',
      'Widget',
      'The child sliver to display in the expanded cross-axis region. '
          'Can be any sliver: SliverList, SliverGrid, SliverToBoxAdapter, etc.',
      true,
      '',
    ),
    buildSCAEParam(
      'key',
      'Key?',
      'Optional key for widget identification in the element tree.',
      false,
      '',
    ),
  ];

  // ============================================================
  // SECTION 3: Flex Distribution
  // ============================================================
  print('=== Section 3: Flex Distribution ===');

  Widget buildSCAEFlexDemo(
    String label,
    List<Map<String, dynamic>> columns,
    Color accent,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
                color: accent,
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          SizedBox(
            height: 80.0,
            child: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverCrossAxisGroup(
                  slivers: columns.map((col) {
                    final colColor = col['color'] as Color;
                    final colFlex = col['flex'] as int;
                    final colLabel = col['label'] as String;
                    return SliverCrossAxisExpanded(
                      flex: colFlex,
                      sliver: SliverToBoxAdapter(
                        child: Container(
                          height: 70.0,
                          margin: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: colColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: colColor.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'flex: $colFlex',
                                  style: TextStyle(
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.bold,
                                    color: colColor,
                                  ),
                                ),
                                const SizedBox(height: 2.0),
                                Text(
                                  colLabel,
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: colColor.withValues(alpha: 0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final flexDemos = [
    buildSCAEFlexDemo(
      'A) Equal Distribution — flex 1 : 1',
      [
        {'flex': 1, 'color': Colors.blue, 'label': '50%'},
        {'flex': 1, 'color': Colors.green, 'label': '50%'},
      ],
      Colors.blue,
    ),
    buildSCAEFlexDemo(
      'B) 1 : 2 Ratio — One-third / Two-thirds',
      [
        {'flex': 1, 'color': Colors.purple, 'label': '33%'},
        {'flex': 2, 'color': Colors.teal, 'label': '67%'},
      ],
      Colors.purple,
    ),
    buildSCAEFlexDemo(
      'C) 1 : 1 : 1 — Three Equal Columns',
      [
        {'flex': 1, 'color': Colors.red, 'label': '33%'},
        {'flex': 1, 'color': Colors.amber, 'label': '33%'},
        {'flex': 1, 'color': Colors.indigo, 'label': '33%'},
      ],
      Colors.red,
    ),
    buildSCAEFlexDemo(
      'D) 1 : 2 : 1 — Sidebar / Content / Sidebar',
      [
        {'flex': 1, 'color': Colors.grey, 'label': '25%'},
        {'flex': 2, 'color': Colors.blue, 'label': '50%'},
        {'flex': 1, 'color': Colors.grey, 'label': '25%'},
      ],
      Colors.grey,
    ),
    buildSCAEFlexDemo(
      'E) 1 : 3 — Narrow Nav / Wide Content',
      [
        {'flex': 1, 'color': Colors.deepOrange, 'label': '25%'},
        {'flex': 3, 'color': Colors.cyan, 'label': '75%'},
      ],
      Colors.deepOrange,
    ),
  ];

  print('Flex distribution demos built (5 variations)');

  // ============================================================
  // SECTION 4: Multiple Expanded
  // ============================================================
  print('=== Section 4: Multiple Expanded ===');

  // Show that all children in a group can be SliverCrossAxisExpanded
  final multiExpandedDemo = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: [
        SliverCrossAxisGroup(
          slivers: [
            // Column 1: Navigation sidebar (flex 1)
            SliverCrossAxisExpanded(
              flex: 1,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final items = [
                      {'icon': Icons.home, 'label': 'Home'},
                      {'icon': Icons.search, 'label': 'Search'},
                      {'icon': Icons.favorite, 'label': 'Favorites'},
                      {'icon': Icons.settings, 'label': 'Settings'},
                      {'icon': Icons.person, 'label': 'Profile'},
                      {'icon': Icons.help, 'label': 'Help'},
                    ];
                    if (index >= items.length) return null;
                    final item = items[index];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 10.0,
                      ),
                      margin: const EdgeInsets.only(bottom: 2.0, right: 2.0),
                      decoration: BoxDecoration(
                        color: index == 0
                            ? Colors.blue.withValues(alpha: 0.15)
                            : Colors.grey.withValues(alpha: 0.04),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            item['icon'] as IconData,
                            size: 16.0,
                            color: index == 0 ? Colors.blue : Colors.grey,
                          ),
                          const SizedBox(width: 6.0),
                          Expanded(
                            child: Text(
                              item['label'] as String,
                              style: TextStyle(
                                fontSize: 11.0,
                                fontWeight: index == 0
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                                color: index == 0
                                    ? Colors.blue
                                    : Colors.grey.shade700,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: 6,
                ),
              ),
            ),
            // Column 2: Main content (flex 3)
            SliverCrossAxisExpanded(
              flex: 3,
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final titles = [
                      'Welcome to the Dashboard',
                      'Recent Activity Feed',
                      'Performance Metrics',
                      'Upcoming Deadlines',
                      'Team Collaboration',
                      'Weekly Summary Report',
                    ];
                    if (index >= titles.length) return null;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 4.0, left: 2.0),
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(
                          alpha: 0.03 + (index * 0.01),
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: Colors.blue.withValues(alpha: 0.08),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titles[index],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.5,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          const SizedBox(height: 4.0),
                          Text(
                            'Content area with flex: 3 — takes 75% of '
                            'the available cross-axis space.',
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.grey.shade600,
                              height: 1.3,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: 6,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // Annotations for multi-expanded
  final multiAnnotations = <Map<String, dynamic>>[
    {
      'label': 'Column 1 (flex: 1)',
      'desc': 'Navigation sidebar — 25% width',
      'color': Colors.grey,
    },
    {
      'label': 'Column 2 (flex: 3)',
      'desc': 'Main content — 75% width',
      'color': Colors.blue,
    },
  ];

  // ============================================================
  // SECTION 5: Live Demo
  // ============================================================
  print('=== Section 5: Live Demo ===');

  final liveDemoWidget = _SCAELiveDemo();

  // ============================================================
  // SECTION 6: With Other Slivers
  // ============================================================
  print('=== Section 6: With Other Slivers ===');

  // Mix SliverCrossAxisExpanded with SliverConstrainedCrossAxis
  final mixedDemo = SizedBox(
    height: 200.0,
    child: CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverCrossAxisGroup(
          slivers: [
            // Left: fixed-width via SliverConstrainedCrossAxis
            SliverConstrainedCrossAxis(
              maxExtent: 100.0,
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: 180.0,
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: Colors.purple.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.purple.withValues(alpha: 0.3),
                    ),
                  ),
                  child: const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.menu, color: Colors.purple, size: 20.0),
                        SizedBox(height: 4.0),
                        Text(
                          'Fixed\n100px',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // Right: expanded fills remainder
            SliverCrossAxisExpanded(
              flex: 1,
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: 180.0,
                  margin: const EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    color: Colors.teal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.teal.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.expand,
                          color: Colors.teal,
                          size: 24.0,
                        ),
                        const SizedBox(height: 4.0),
                        const Text(
                          'Expanded (fills remaining)',
                          style: TextStyle(
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          'Takes all space after 100px sidebar',
                          style: TextStyle(
                            fontSize: 10.5,
                            color: Colors.teal.shade300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Holy Grail Layout',
      'icon': Icons.temple_buddhist,
      'desc': 'Left sidebar (flex 1) + Main content (flex 3) + Right sidebar '
          '(flex 1). The classic three-column layout where the center gets '
          'the most space.',
      'flexes': '1 : 3 : 1',
      'color': Colors.deepPurple,
    },
    {
      'title': 'Master-Detail',
      'icon': Icons.view_sidebar,
      'desc': 'Left master list (flex 1) + Right detail pane (flex 2). '
          'Common in email clients, file managers, and settings apps.',
      'flexes': '1 : 2',
      'color': Colors.blue,
    },
    {
      'title': 'Content + Aside',
      'icon': Icons.article,
      'desc': 'Wide main article (flex 3) + Narrow aside with table of '
          'contents or ads (flex 1). Standard blog/documentation layout.',
      'flexes': '3 : 1',
      'color': Colors.green,
    },
    {
      'title': 'Equal Columns',
      'icon': Icons.view_column,
      'desc': 'Two, three, or four equal columns (all flex 1). Used for '
          'comparison views, product grids, or dashboard cards.',
      'flexes': '1 : 1 : 1',
      'color': Colors.orange,
    },
    {
      'title': 'Golden Ratio',
      'icon': Icons.auto_awesome,
      'desc': 'Content (flex 8) + Sidebar (flex 5) — approximately 1.618:1. '
          'Creates a naturally pleasing proportion between sections.',
      'flexes': '8 : 5',
      'color': Colors.amber,
    },
  ];

  final patternCards = <Widget>[];
  for (var i = 0; i < patterns.length; i++) {
    final p = patterns[i];
    print('Pattern ${i + 1}: ${p['title']}');
    patternCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: (p['color'] as Color).withValues(alpha: 0.15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: (p['color'] as Color).withValues(alpha: 0.06),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(9.0),
                  topRight: Radius.circular(9.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    p['icon'] as IconData,
                    color: p['color'] as Color,
                    size: 22.0,
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      p['title'] as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.5,
                        color: p['color'] as Color,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 3.0,
                    ),
                    decoration: BoxDecoration(
                      color: (p['color'] as Color).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Text(
                      p['flexes'] as String,
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'monospace',
                        color: p['color'] as Color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                p['desc'] as String,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade700,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  Widget buildSCAEBullet(IconData icon, String text, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16.0, color: color),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade700,
                height: 1.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final summaryBullets = [
    buildSCAEBullet(
      Icons.check_circle_outline,
      'SliverCrossAxisExpanded fills remaining cross-axis space '
          'within a SliverCrossAxisGroup, like Expanded for Row.',
      Colors.green,
    ),
    buildSCAEBullet(
      Icons.check_circle_outline,
      'The flex parameter controls proportional space distribution. '
          'Higher flex values take more of the remaining space.',
      Colors.green,
    ),
    buildSCAEBullet(
      Icons.check_circle_outline,
      'Multiple SliverCrossAxisExpanded children share space '
          'proportionally, enabling multi-column scrollable layouts.',
      Colors.green,
    ),
    buildSCAEBullet(
      Icons.check_circle_outline,
      'Can be mixed with SliverConstrainedCrossAxis for fixed-width '
          'columns alongside flexible ones.',
      Colors.green,
    ),
    buildSCAEBullet(
      Icons.warning_amber,
      'Only works inside SliverCrossAxisGroup — using it '
          'elsewhere will cause assertion errors.',
      Colors.orange,
    ),
    buildSCAEBullet(
      Icons.warning_amber,
      'All children in a SliverCrossAxisGroup scroll together as '
          'one unit. For independent scrolling, use separate scrollviews.',
      Colors.orange,
    ),
    buildSCAEBullet(
      Icons.info_outline,
      'The child sliver can be any sliver type: SliverList, '
          'SliverGrid, SliverToBoxAdapter, etc.',
      Colors.blue,
    ),
  ];

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('=== Assembling tabbed layout ===');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SliverCrossAxisExpanded Deep Demo'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        elevation: 2.0,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 11.0),
          tabs: [
            Tab(text: 'Concept'),
            Tab(text: 'Constructor'),
            Tab(text: 'Flex Distribution'),
            Tab(text: 'Multi-Column'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Mixed Slivers'),
            Tab(text: 'Patterns'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // ===== TAB 1: Concept =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange.withValues(alpha: 0.12),
                        Colors.orange.withValues(alpha: 0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.orange.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.orange.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.expand,
                          color: Colors.orange,
                          size: 32.0,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      const Text(
                        'SliverCrossAxisExpanded',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'Fill remaining cross-axis space in a '
                        'SliverCrossAxisGroup — like Expanded for slivers.',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey.shade600,
                          height: 1.4,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...conceptCards,
                const SizedBox(height: 12.0),
                // Quick analogy
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.blue.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.compare_arrows, color: Colors.blue, size: 18.0),
                          SizedBox(width: 8.0),
                          Text(
                            'Analogy: Row vs SliverCrossAxisGroup',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      _buildAnalogyRow('Row', 'SliverCrossAxisGroup'),
                      _buildAnalogyRow('Expanded', 'SliverCrossAxisExpanded'),
                      _buildAnalogyRow('SizedBox(width:)', 'SliverConstrainedCrossAxis'),
                      _buildAnalogyRow('Container child', 'Sliver child'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===== TAB 2: Constructor =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.build_circle,
                        color: Colors.orange,
                        size: 28.0,
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Constructor',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Simple API: just a flex value and a sliver child.',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...constructorParams,
                const SizedBox(height: 12.0),
                // Code sample
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '// Two-column layout:',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 2.0),
                      Text(
                        'CustomScrollView(\n'
                        '  slivers: [\n'
                        '    SliverCrossAxisGroup(\n'
                        '      slivers: [\n'
                        '        SliverCrossAxisExpanded(\n'
                        '          flex: 1,\n'
                        '          sliver: sidebarSliver,\n'
                        '        ),\n'
                        '        SliverCrossAxisExpanded(\n'
                        '          flex: 3,\n'
                        '          sliver: contentSliver,\n'
                        '        ),\n'
                        '      ],\n'
                        '    ),\n'
                        '  ],\n'
                        ')',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontFamily: 'monospace',
                          color: Colors.white70,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                // Hierarchy
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.orange.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Widget Hierarchy',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      ..._buildHierarchyLines([
                        'Widget',
                        '  └─ RenderObjectWidget',
                        '      └─ SingleChildRenderObjectWidget',
                        '          └─ SliverCrossAxisExpanded',
                      ], 'SliverCrossAxisExpanded', Colors.orange),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===== TAB 3: Flex Distribution =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.tune,
                        color: Colors.orange,
                        size: 28.0,
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Flex Distribution',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'How different flex ratios divide the '
                        'cross-axis space between columns.',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...flexDemos,
                const SizedBox(height: 12.0),
                // Formula explanation
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.amber.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calculate,
                            color: Colors.amber,
                            size: 20.0,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'Space Distribution Formula',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.amber.shade800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: const Text(
                          'remaining = viewport.crossAxisExtent\n'
                          '          - sum(fixed slivers widths)\n\n'
                          'childWidth = remaining * (child.flex / totalFlex)',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontFamily: 'monospace',
                            color: Colors.white70,
                            height: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Fixed-width slivers (SliverConstrainedCrossAxis) '
                        'are subtracted first, then remaining space is '
                        'distributed proportionally among expanded slivers.',
                        style: TextStyle(
                          fontSize: 11.5,
                          color: Colors.grey.shade700,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===== TAB 4: Multi-Column =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.view_sidebar,
                        color: Colors.orange,
                        size: 28.0,
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Multi-Column Layout',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'A realistic sidebar + content layout using '
                        'SliverCrossAxisExpanded with flex 1 : 3.',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.orange.withValues(alpha: 0.2),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: multiExpandedDemo,
                ),
                const SizedBox(height: 12.0),
                // Legend
                ...multiAnnotations.map((ann) => Padding(
                      padding: const EdgeInsets.only(bottom: 6.0),
                      child: Row(
                        children: [
                          Container(
                            width: 14.0,
                            height: 14.0,
                            decoration: BoxDecoration(
                              color: (ann['color'] as Color)
                                  .withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(3.0),
                              border: Border.all(
                                color: (ann['color'] as Color)
                                    .withValues(alpha: 0.5),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8.0),
                          Expanded(
                            child: Text(
                              '${ann['label']}: ${ann['desc']}',
                              style: TextStyle(
                                fontSize: 11.5,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                const SizedBox(height: 16.0),
                // Widget tree
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Widget Tree:',
                        style: TextStyle(
                          fontSize: 11.0,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        'CustomScrollView\n'
                        '└── SliverCrossAxisGroup\n'
                        '    ├── SliverCrossAxisExpanded(flex: 1)\n'
                        '    │   └── SliverList  [Nav sidebar]\n'
                        '    │       ├── Home  ← selected\n'
                        '    │       ├── Search\n'
                        '    │       ├── Favorites\n'
                        '    │       └── ...\n'
                        '    └── SliverCrossAxisExpanded(flex: 3)\n'
                        '        └── SliverList  [Main content]\n'
                        '            ├── Dashboard card\n'
                        '            ├── Activity feed\n'
                        '            └── ...',
                        style: TextStyle(
                          fontSize: 10.5,
                          fontFamily: 'monospace',
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===== TAB 5: Live Demo =====
          liveDemoWidget,

          // ===== TAB 6: Mixed Slivers =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.layers,
                        color: Colors.orange,
                        size: 28.0,
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Mixing with Other Slivers',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'SliverCrossAxisExpanded works alongside '
                        'SliverConstrainedCrossAxis for fixed + flexible layouts.',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                // Demo with fixed + expanded
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.orange.withValues(alpha: 0.2),
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: mixedDemo,
                ),
                const SizedBox(height: 12.0),
                // Explanation
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.purple.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.purple.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.info, color: Colors.purple, size: 18.0),
                          SizedBox(width: 8.0),
                          Text(
                            'Fixed + Flexible Pattern',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13.0,
                              color: Colors.purple,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'In a SliverCrossAxisGroup, you can mix:\n'
                        '• SliverConstrainedCrossAxis — takes a fixed '
                        'maximum width\n'
                        '• SliverCrossAxisExpanded — fills the remaining '
                        'space after fixed slivers\n\n'
                        'The expanded sliver automatically adapts to any '
                        'viewport width, always filling whatever is left.',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade700,
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                // Comparison: all expanded vs fixed+expanded
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.teal.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.teal.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Choosing Between Fixed and Flexible',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      _buildChoiceRow(
                        'All SliverCrossAxisExpanded',
                        'Proportional columns that all resize '
                            'together when viewport changes',
                        Icons.view_column,
                        Colors.blue,
                      ),
                      const SizedBox(height: 8.0),
                      _buildChoiceRow(
                        'Fixed + Expanded',
                        'Sidebar stays constant width; main '
                            'content absorbs all viewport changes',
                        Icons.view_sidebar,
                        Colors.green,
                      ),
                      const SizedBox(height: 8.0),
                      _buildChoiceRow(
                        'All SliverConstrainedCrossAxis',
                        'All columns have max widths; excess space '
                            'is not allocated (may leave gaps)',
                        Icons.view_agenda,
                        Colors.orange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===== TAB 7: Patterns =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.dashboard_customize,
                        color: Colors.orange,
                        size: 28.0,
                      ),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Layout Patterns',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Common multi-column layout patterns achievable '
                        'with SliverCrossAxisExpanded and flex ratios.',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...patternCards,
              ],
            ),
          ),

          // ===== TAB 8: Summary =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.orange.withValues(alpha: 0.12),
                        Colors.orange.withValues(alpha: 0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.orange.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.check_circle,
                        color: Colors.orange,
                        size: 32.0,
                      ),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Summary',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'Key takeaways for SliverCrossAxisExpanded',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...summaryBullets,
                const SizedBox(height: 16.0),
                // Quick reference
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.orange.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.orange.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Quick Reference',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.0,
                          color: Colors.orange,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      _buildRefRow('Type', 'SingleChildRenderObjectWidget (sliver)'),
                      _buildRefRow('Key param', 'flex (int, default 1)'),
                      _buildRefRow('Parent', 'Must be in SliverCrossAxisGroup'),
                      _buildRefRow('Child', 'Any sliver widget'),
                      _buildRefRow('Distribution', 'Proportional to flex / totalFlex'),
                      _buildRefRow('Analogy', 'Expanded in Row/Column'),
                      _buildRefRow('Since', 'Flutter 3.7'),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 10.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Text(
                      'SliverCrossAxisExpanded — '
                      'Flexible multi-column sliver layouts.',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

// ================================================================
// LIVE DEMO (Stateful)
// ================================================================

class _SCAELiveDemo extends StatefulWidget {
  @override
  State<_SCAELiveDemo> createState() => _SCAELiveDemoState();
}

class _SCAELiveDemoState extends State<_SCAELiveDemo> {
  int _leftFlex = 1;
  int _rightFlex = 2;
  int _columns = 2;
  bool _showContent = true;

  @override
  Widget build(BuildContext context) {
    print('Live demo build: left=$_leftFlex, right=$_rightFlex, '
        'cols=$_columns, content=$_showContent');

    // Build the slivers based on column count
    List<Widget> columnSlivers;
    final columnColors = [
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.orange,
    ];
    final columnLabels = ['A', 'B', 'C', 'D'];
    final flexValues = [_leftFlex, _rightFlex, 1, 1];

    columnSlivers = List.generate(_columns, (colIndex) {
      final colColor = columnColors[colIndex % columnColors.length];
      final colFlex = flexValues[colIndex];
      return SliverCrossAxisExpanded(
        flex: colFlex,
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                margin: const EdgeInsets.all(2.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: colColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(
                    color: colColor.withValues(alpha: 0.3),
                  ),
                ),
                child: _showContent
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${columnLabels[colIndex]}${index + 1}',
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                              color: colColor,
                            ),
                          ),
                          Text(
                            'flex: $colFlex',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: colColor.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      )
                    : Container(
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: colColor.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
              );
            },
            childCount: 8,
          ),
        ),
      );
    });

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Controls
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.orange.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.orange.withValues(alpha: 0.12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Interactive Controls',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.orange,
                  ),
                ),
                const SizedBox(height: 12.0),
                // Column count
                Row(
                  children: [
                    SizedBox(
                      width: 80.0,
                      child: Text(
                        'Columns:',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    ...List.generate(4, (i) {
                      final val = i + 1;
                      final isActive = _columns == val;
                      return Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: InkWell(
                          onTap: () => setState(() => _columns = val),
                          borderRadius: BorderRadius.circular(6.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14.0,
                              vertical: 6.0,
                            ),
                            decoration: BoxDecoration(
                              color: (isActive
                                      ? Colors.orange
                                      : Colors.grey)
                                  .withValues(alpha: isActive ? 0.15 : 0.08),
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                color: (isActive
                                        ? Colors.orange
                                        : Colors.grey)
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              '$val',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: isActive
                                    ? Colors.orange
                                    : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 10.0),
                // Left flex
                Row(
                  children: [
                    SizedBox(
                      width: 80.0,
                      child: Text(
                        'Col A flex:',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: _leftFlex.toDouble(),
                        min: 1,
                        max: 5,
                        divisions: 4,
                        activeColor: Colors.blue,
                        label: '$_leftFlex',
                        onChanged: (v) =>
                            setState(() => _leftFlex = v.toInt()),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '$_leftFlex',
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                // Right flex
                Row(
                  children: [
                    SizedBox(
                      width: 80.0,
                      child: Text(
                        'Col B flex:',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: _rightFlex.toDouble(),
                        min: 1,
                        max: 5,
                        divisions: 4,
                        activeColor: Colors.green,
                        label: '$_rightFlex',
                        onChanged: (v) =>
                            setState(() => _rightFlex = v.toInt()),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '$_rightFlex',
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                // Show content toggle
                InkWell(
                  onTap: () =>
                      setState(() => _showContent = !_showContent),
                  borderRadius: BorderRadius.circular(6.0),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      color: (_showContent
                              ? Colors.orange
                              : Colors.grey)
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: (_showContent
                                ? Colors.orange
                                : Colors.grey)
                            .withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          _showContent
                              ? Icons.text_fields
                              : Icons.rectangle,
                          size: 16.0,
                          color: _showContent
                              ? Colors.orange
                              : Colors.grey.shade600,
                        ),
                        const SizedBox(width: 6.0),
                        Text(
                          _showContent ? 'Labels' : 'Blocks',
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                            color: _showContent
                                ? Colors.orange
                                : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          // Display area
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.orange.withValues(alpha: 0.2),
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: CustomScrollView(
                slivers: [
                  SliverCrossAxisGroup(
                    slivers: columnSlivers,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: Colors.amber.withValues(alpha: 0.15),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  size: 16.0,
                  color: Colors.amber,
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    'Adjust column count and flex values. Columns C and D '
                    'use flex 1. All columns scroll together as one unit.',
                    style: TextStyle(
                      fontSize: 10.5,
                      color: Colors.grey.shade600,
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

// ================================================================
// HELPER FUNCTIONS
// ================================================================

Widget _buildAnalogyRow(String boxSide, String sliverSide) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4.0),
    child: Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              boxSide,
              style: TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Icon(Icons.arrow_forward, size: 14.0, color: Colors.blue),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              sliverSide,
              style: const TextStyle(
                fontSize: 11.0,
                fontFamily: 'monospace',
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

List<Widget> _buildHierarchyLines(
  List<String> items,
  String highlight,
  Color color,
) {
  return items
      .map((item) => Padding(
            padding: const EdgeInsets.only(bottom: 2.0),
            child: Text(
              item,
              style: TextStyle(
                fontSize: 11.5,
                fontFamily: 'monospace',
                color: item.contains(highlight) ? color : Colors.grey.shade700,
                fontWeight: item.contains(highlight)
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ))
      .toList();
}

Widget _buildChoiceRow(
  String title,
  String desc,
  IconData icon,
  Color color,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: 18.0, color: color),
      const SizedBox(width: 8.0),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              desc,
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.grey.shade600,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildRefRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 11.5,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    ),
  );
}
