// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverLayoutBuilder
// Demonstrates SliverLayoutBuilder — a sliver that defers its child sliver
// construction to a callback which receives SliverConstraints. This is the
// sliver equivalent of LayoutBuilder, enabling constraint-driven decisions
// such as responsive grids, scroll-position-aware headers, and adaptive
// content layouts.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverLayoutBuilder Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.architecture,
      'title': 'What Is SliverLayoutBuilder?',
      'body': 'SliverLayoutBuilder calls a builder function during layout, '
          'passing the current SliverConstraints. You return a sliver that '
          'fits those constraints. This lets you make decisions about what '
          'to display based on viewport dimensions, scroll offset, and more.',
      'accent': Colors.deepPurple,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'LayoutBuilder vs SliverLayoutBuilder',
      'body': 'LayoutBuilder receives BoxConstraints (maxWidth, maxHeight) '
          'and returns a box widget. SliverLayoutBuilder receives '
          'SliverConstraints (crossAxisExtent, viewportMainAxisExtent, '
          'scrollOffset, overlap, etc.) and must return a sliver widget.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.grid_view,
      'title': 'Responsive Slivers',
      'body': 'Use crossAxisExtent to determine how wide the scroll area is '
          'and adjust column counts, card sizes, or layout modes. Unlike '
          'MediaQuery, this responds to the actual sliver viewport width, '
          'which is correct even inside nested scroll views.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.swap_vert,
      'title': 'Scroll-Aware Content',
      'body': 'The scrollOffset in SliverConstraints tells you how far this '
          'sliver\'s start has been scrolled past. Combined with '
          'viewportMainAxisExtent and remainingPaintExtent, you can build '
          'content that changes as the user scrolls.',
      'accent': Colors.orange,
    },
  ];

  final conceptCards = <Widget>[];
  for (var idx = 0; idx < conceptItems.length; idx++) {
    final e = conceptItems[idx];
    final accent = e['accent'] as Color;
    print('Concept ${idx + 1}: ${e['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: accent.withValues(alpha: 0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(e['icon'] as IconData, color: accent, size: 26.0),
            ),
            const SizedBox(width: 14.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    e['title'] as String,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.5,
                      color: accent,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  Text(
                    e['body'] as String,
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
  // SECTION 2: Constructor & SliverConstraints
  // ============================================================
  print('=== Section 2: Constructor ===');

  final constraintProps = <Map<String, String>>[
    {
      'name': 'crossAxisExtent',
      'type': 'double',
      'desc': 'Width available perpendicular to scroll axis (e.g., viewport width for vertical scroll)',
    },
    {
      'name': 'viewportMainAxisExtent',
      'type': 'double',
      'desc': 'Height of the visible viewport along the scroll axis',
    },
    {
      'name': 'scrollOffset',
      'type': 'double',
      'desc': 'How far this sliver\'s leading edge has been scrolled out of view',
    },
    {
      'name': 'remainingPaintExtent',
      'type': 'double',
      'desc': 'Remaining pixels of viewport that can be painted by this and later slivers',
    },
    {
      'name': 'overlap',
      'type': 'double',
      'desc': 'Amount of overlap from previous slivers still covering this sliver\'s area',
    },
    {
      'name': 'precedingScrollExtent',
      'type': 'double',
      'desc': 'Total scroll extent of all slivers before this one',
    },
    {
      'name': 'cacheOrigin',
      'type': 'double',
      'desc': 'Where the cache area begins relative to this sliver\'s origin',
    },
    {
      'name': 'remainingCacheExtent',
      'type': 'double',
      'desc': 'Cache extent still available for preloading beyond visible area',
    },
    {
      'name': 'axisDirection',
      'type': 'AxisDirection',
      'desc': 'Direction the sliver is laid out (down, up, right, left)',
    },
    {
      'name': 'growthDirection',
      'type': 'GrowthDirection',
      'desc': 'Whether new slivers are added going forward or reverse',
    },
    {
      'name': 'userScrollDirection',
      'type': 'ScrollDirection',
      'desc': 'The direction the user is currently scrolling (idle, forward, reverse)',
    },
  ];

  final propWidgets = <Widget>[];
  for (var i = 0; i < constraintProps.length; i++) {
    final p = constraintProps[i];
    final isEven = i % 2 == 0;
    propWidgets.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        color: isEven ? Colors.deepPurple.withValues(alpha: 0.03) : Colors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 140.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0,
                      fontFamily: 'monospace',
                      color: Colors.deepPurple,
                    ),
                  ),
                  Text(
                    p['type']!,
                    style: TextStyle(
                      fontSize: 10.0,
                      fontFamily: 'monospace',
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Text(
                p['desc']!,
                style: TextStyle(
                  fontSize: 11.5,
                  color: Colors.grey.shade700,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final builderSignature = Container(
    margin: const EdgeInsets.only(top: 14.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade900,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Builder Signature',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.bold,
            color: Colors.purple.shade200,
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          'SliverLayoutBuilder(\n'
          '  builder: (BuildContext context,\n'
          '            SliverConstraints constraints) {\n'
          '    // Access constraints.crossAxisExtent,\n'
          '    // constraints.viewportMainAxisExtent, etc.\n'
          '    return SliverList(...);\n'
          '  },\n'
          ')',
          style: TextStyle(
            fontSize: 11.5,
            fontFamily: 'monospace',
            color: Colors.green.shade300,
            height: 1.45,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Constraint Explorer
  // ============================================================
  print('=== Section 3: Constraint Explorer ===');

  // A live scrollview that uses SliverLayoutBuilder to display
  // the constraint values in real-time as the user scrolls
  final constraintExplorer = CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.deepPurple.withValues(alpha: 0.06),
          child: Row(
            children: [
              const Icon(Icons.explore, color: Colors.deepPurple, size: 20.0),
              const SizedBox(width: 10.0),
              Expanded(
                child: Text(
                  'Scroll this view and watch the constraint values update '
                  'in real-time below.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.deepPurple.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Some content before the builder to generate scrollOffset
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 14.0, vertical: 3.0,
              ),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                'Spacer item ${index + 1} — scroll past me',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade500),
              ),
            );
          },
          childCount: 5,
        ),
      ),
      // The SliverLayoutBuilder that reveals its constraints
      SliverLayoutBuilder(
        builder: (context, constraints) {
          print('Constraint explorer — '
              'crossAxis=${constraints.crossAxisExtent.toStringAsFixed(0)}, '
              'viewport=${constraints.viewportMainAxisExtent.toStringAsFixed(0)}, '
              'scroll=${constraints.scrollOffset.toStringAsFixed(1)}');
          return SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(14.0),
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: Colors.deepPurple.withValues(alpha: 0.2),
                  width: 2.0,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.data_exploration,
                        color: Colors.deepPurple,
                        size: 22.0,
                      ),
                      const SizedBox(width: 8.0),
                      Text(
                        'Live SliverConstraints',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple.shade700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  _slbConstraintRow(
                    'crossAxisExtent',
                    constraints.crossAxisExtent.toStringAsFixed(1),
                    Colors.blue,
                  ),
                  _slbConstraintRow(
                    'viewportMainAxisExtent',
                    constraints.viewportMainAxisExtent.toStringAsFixed(1),
                    Colors.teal,
                  ),
                  _slbConstraintRow(
                    'scrollOffset',
                    constraints.scrollOffset.toStringAsFixed(1),
                    Colors.orange,
                  ),
                  _slbConstraintRow(
                    'remainingPaintExtent',
                    constraints.remainingPaintExtent.toStringAsFixed(1),
                    Colors.green,
                  ),
                  _slbConstraintRow(
                    'overlap',
                    constraints.overlap.toStringAsFixed(1),
                    Colors.red,
                  ),
                  _slbConstraintRow(
                    'precedingScrollExtent',
                    constraints.precedingScrollExtent.toStringAsFixed(1),
                    Colors.indigo,
                  ),
                  _slbConstraintRow(
                    'axisDirection',
                    constraints.axisDirection.toString(),
                    Colors.purple,
                  ),
                  _slbConstraintRow(
                    'growthDirection',
                    constraints.growthDirection.toString(),
                    Colors.brown,
                  ),
                  _slbConstraintRow(
                    'userScrollDirection',
                    constraints.userScrollDirection.toString(),
                    Colors.cyan,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // More content after to allow scrolling
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 14.0, vertical: 3.0,
              ),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                'Trailing item ${index + 1}',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade500),
              ),
            );
          },
          childCount: 10,
        ),
      ),
    ],
  );

  // ============================================================
  // SECTION 4: Responsive Grid
  // ============================================================
  print('=== Section 4: Responsive Grid ===');

  final productNames = [
    'Headphones', 'Keyboard', 'Mouse', 'Monitor', 'Webcam',
    'Microphone', 'Speaker', 'USB Hub', 'Desk Lamp', 'Cable Kit',
    'Stand', 'Chair',
  ];
  final productIcons = [
    Icons.headphones, Icons.keyboard, Icons.mouse, Icons.monitor,
    Icons.videocam, Icons.mic, Icons.speaker, Icons.usb, Icons.light,
    Icons.cable, Icons.desktop_mac, Icons.chair,
  ];
  final productColors = [
    Colors.blue, Colors.green, Colors.orange, Colors.purple,
    Colors.red, Colors.teal, Colors.indigo, Colors.amber,
    Colors.cyan, Colors.pink, Colors.brown, Colors.deepOrange,
  ];

  final responsiveGrid = CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.indigo.withValues(alpha: 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.grid_view, color: Colors.indigo, size: 20.0),
                  const SizedBox(width: 8.0),
                  Text(
                    'Responsive Product Grid',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.indigo.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(
                'SliverLayoutBuilder reads crossAxisExtent to choose the '
                'number of grid columns. Narrow viewports get 2 columns, '
                'medium get 3, wide get 4.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
      SliverLayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.crossAxisExtent;
          int cols;
          if (width < 400) {
            cols = 2;
          } else if (width < 600) {
            cols = 3;
          } else {
            cols = 4;
          }
          print('Responsive grid: width=$width, cols=$cols');
          return SliverPadding(
            padding: const EdgeInsets.all(12.0),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final color = productColors[index];
                  return Container(
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: color.withValues(alpha: 0.15)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 44.0,
                          height: 44.0,
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            productIcons[index],
                            color: color,
                            size: 22.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          productNames[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: Colors.grey.shade800,
                          ),
                        ),
                        const SizedBox(height: 2.0),
                        Text(
                          '\$${(index + 1) * 29}.99',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                childCount: productNames.length,
              ),
            ),
          );
        },
      ),
    ],
  );

  // ============================================================
  // SECTION 5: Scroll-Aware Header
  // ============================================================
  print('=== Section 5: Scroll-Aware Header ===');

  final scrollAwareDemo = CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.orange.withValues(alpha: 0.06),
          child: Text(
            'The header below changes color and size as you scroll '
            'using constraints.scrollOffset.',
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.orange.shade700,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      ),
      SliverLayoutBuilder(
        builder: (context, constraints) {
          final offset = constraints.scrollOffset;
          // Interpolate header height from 120 down to 60
          final maxH = 120.0;
          final minH = 60.0;
          final t = (offset / 200.0).clamp(0.0, 1.0);
          final headerH = maxH - (maxH - minH) * t;
          final fontSize = 22.0 - 8.0 * t;
          final bgColor = Color.lerp(
            Colors.orange.shade100,
            Colors.deepOrange.shade400,
            t,
          )!;
          final textColor = Color.lerp(
            Colors.orange.shade900,
            Colors.white,
            t,
          )!;
          return SliverToBoxAdapter(
            child: Container(
              height: headerH,
              color: bgColor,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Icon(
                    Icons.trending_up,
                    color: textColor,
                    size: 20.0 + 6.0 * (1 - t),
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    'Scroll-Aware Header',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'offset: ${offset.toStringAsFixed(0)}',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontFamily: 'monospace',
                      color: textColor.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final messageTypes = [
              'Design review meeting notes',
              'Q3 roadmap status update',
              'Bug fix PR merged: #1234',
              'New feature spec uploaded',
              'Sprint retrospective takeaways',
              'Security audit results ready',
              'Backend server migration plan',
              'Customer feedback summary',
              'Performance benchmark results',
              'Release notes draft v2.5',
              'Team lunch poll — vote now',
              'Onboarding doc revision',
              'Infrastructure cost analysis',
              'API deprecation timeline',
              'Holiday schedule for next month',
            ];
            final msgIcons = [
              Icons.event_note, Icons.map, Icons.bug_report, Icons.note_add,
              Icons.replay, Icons.security, Icons.cloud, Icons.feedback,
              Icons.speed, Icons.description, Icons.poll, Icons.person_add,
              Icons.account_balance, Icons.api, Icons.calendar_today,
            ];
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 14.0, vertical: 3.0,
              ),
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Row(
                children: [
                  Icon(
                    msgIcons[index],
                    color: Colors.orange.shade400,
                    size: 20.0,
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      messageTypes[index],
                      style: const TextStyle(fontSize: 13.0),
                    ),
                  ),
                  Text(
                    '${index + 1}m ago',
                    style: TextStyle(
                      fontSize: 10.5,
                      color: Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            );
          },
          childCount: 15,
        ),
      ),
    ],
  );

  // ============================================================
  // SECTION 6: Remaining Paint Extent
  // ============================================================
  print('=== Section 6: Remaining Paint Extent ===');

  final remainingDemo = CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.green.withValues(alpha: 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.height, color: Colors.green, size: 20.0),
                  const SizedBox(width: 8.0),
                  Text(
                    'remainingPaintExtent Demo',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(
                'The SliverLayoutBuilder below checks how much space remains '
                'in the viewport. When there\'s lots of room it shows a full '
                'card; when space is limited, a compact version.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
      // Push the builder down with preceding slivers
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 14.0, vertical: 3.0,
              ),
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                'Content row ${index + 1}',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade500),
              ),
            );
          },
          childCount: 8,
        ),
      ),
      SliverLayoutBuilder(
        builder: (context, constraints) {
          final remaining = constraints.remainingPaintExtent;
          final isFull = remaining > 200;
          print('Remaining paint: ${remaining.toStringAsFixed(0)}, '
              'showing ${isFull ? "full" : "compact"} card');
          if (isFull) {
            return SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(14.0),
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.withValues(alpha: 0.12),
                      Colors.teal.withValues(alpha: 0.08),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14.0),
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.2),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                            color: Colors.green.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.expand,
                            color: Colors.green,
                            size: 28.0,
                          ),
                        ),
                        const SizedBox(width: 14.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Full Card Mode',
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green.shade700,
                                ),
                              ),
                              Text(
                                'Remaining: ${remaining.toStringAsFixed(0)}px — plenty of space',
                                style: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14.0),
                    Text(
                      'When remainingPaintExtent is large, display a rich '
                      'card with icon, description, and details.',
                      style: TextStyle(
                        fontSize: 12.5,
                        color: Colors.grey.shade700,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 14.0, vertical: 4.0,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 14.0, vertical: 10.0,
              ),
              decoration: BoxDecoration(
                color: Colors.teal.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(color: Colors.teal.withValues(alpha: 0.2)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.compress, color: Colors.teal, size: 18.0),
                  const SizedBox(width: 10.0),
                  Expanded(
                    child: Text(
                      'Compact mode — ${remaining.toStringAsFixed(0)}px left',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.teal.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      // Trailing content
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 14.0, vertical: 3.0,
              ),
              height: 50.0,
              decoration: BoxDecoration(
                color: Colors.grey.withValues(alpha: 0.04),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: Colors.grey.shade200),
              ),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                'Trailing row ${index + 1}',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade500),
              ),
            );
          },
          childCount: 10,
        ),
      ),
    ],
  );

  // ============================================================
  // SECTION 7: Adaptive Section Pattern
  // ============================================================
  print('=== Section 7: Adaptive Section ===');

  // Scenario: A real-world dashboard that uses SliverLayoutBuilder
  // to adapt between wide and narrow layouts
  final dashWidgets = <Map<String, dynamic>>[
    {
      'title': 'Revenue',
      'value': '\$142,580',
      'change': '+12.5%',
      'icon': Icons.attach_money,
      'color': Colors.green,
      'trend': Icons.trending_up,
    },
    {
      'title': 'Users',
      'value': '38,294',
      'change': '+8.2%',
      'icon': Icons.people,
      'color': Colors.blue,
      'trend': Icons.trending_up,
    },
    {
      'title': 'Orders',
      'value': '6,841',
      'change': '-2.1%',
      'icon': Icons.shopping_cart,
      'color': Colors.orange,
      'trend': Icons.trending_down,
    },
    {
      'title': 'Tickets',
      'value': '247',
      'change': '+5.7%',
      'icon': Icons.confirmation_number,
      'color': Colors.purple,
      'trend': Icons.trending_up,
    },
  ];

  final adaptiveSection = CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          color: Colors.indigo.withValues(alpha: 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.dashboard, color: Colors.indigo, size: 20.0),
                  const SizedBox(width: 8.0),
                  Text(
                    'Adaptive Dashboard',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                      color: Colors.indigo.shade700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6.0),
              Text(
                'Uses SliverLayoutBuilder to switch between a 2-column '
                'grid (wide) and a single-column list (narrow) for stats cards.',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
      SliverLayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.crossAxisExtent >= 400;
          print('Adaptive: width=${constraints.crossAxisExtent.toStringAsFixed(0)}, '
              'mode=${wide ? "grid" : "list"}');
          if (wide) {
            // Grid layout: 2 columns for stats
            return SliverPadding(
              padding: const EdgeInsets.all(12.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1.8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final d = dashWidgets[index];
                    final color = d['color'] as Color;
                    return Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: color.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                d['icon'] as IconData,
                                color: color,
                                size: 20.0,
                              ),
                              const Spacer(),
                              Icon(
                                d['trend'] as IconData,
                                color: (d['change'] as String).startsWith('+')
                                    ? Colors.green
                                    : Colors.red,
                                size: 16.0,
                              ),
                              const SizedBox(width: 4.0),
                              Text(
                                d['change'] as String,
                                style: TextStyle(
                                  fontSize: 11.0,
                                  fontWeight: FontWeight.bold,
                                  color: (d['change'] as String).startsWith('+')
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6.0),
                          Text(
                            d['value'] as String,
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          Text(
                            d['title'] as String,
                            style: TextStyle(
                              fontSize: 11.0,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: dashWidgets.length,
                ),
              ),
            );
          }
          // List layout: single column compact cards
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final d = dashWidgets[index];
                final color = d['color'] as Color;
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 14.0, vertical: 4.0,
                  ),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: color.withValues(alpha: 0.12),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(d['icon'] as IconData, color: color, size: 24.0),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              d['title'] as String,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                                color: Colors.grey.shade800,
                              ),
                            ),
                            Text(
                              d['value'] as String,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: color,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        d['trend'] as IconData,
                        color: (d['change'] as String).startsWith('+')
                            ? Colors.green
                            : Colors.red,
                        size: 16.0,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        d['change'] as String,
                        style: TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: (d['change'] as String).startsWith('+')
                              ? Colors.green
                              : Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: dashWidgets.length,
            ),
          );
        },
      ),
      // Additional dashboard content
      SliverToBoxAdapter(
        child: Container(
          margin: const EdgeInsets.all(14.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.grey.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 8.0),
              ..._slbBuildActivityRows(),
            ],
          ),
        ),
      ),
    ],
  );

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final keyPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.check_circle,
      'text': 'SliverLayoutBuilder provides SliverConstraints at build time',
      'color': Colors.green,
    },
    {
      'icon': Icons.check_circle,
      'text': 'Use crossAxisExtent for responsive column counts',
      'color': Colors.green,
    },
    {
      'icon': Icons.check_circle,
      'text': 'scrollOffset enables scroll-position-aware styling',
      'color': Colors.green,
    },
    {
      'icon': Icons.check_circle,
      'text': 'remainingPaintExtent helps decide full vs compact layouts',
      'color': Colors.green,
    },
    {
      'icon': Icons.lightbulb_outline,
      'text': 'More precise than MediaQuery — uses actual sliver viewport size',
      'color': Colors.amber,
    },
    {
      'icon': Icons.lightbulb_outline,
      'text': 'Must return a sliver widget (SliverList, SliverGrid, SliverToBoxAdapter...)',
      'color': Colors.amber,
    },
    {
      'icon': Icons.warning_amber,
      'text': 'Builder is called during layout — avoid expensive work inside it',
      'color': Colors.orange,
    },
  ];

  final summaryPoints = <Widget>[];
  for (final kp in keyPoints) {
    final color = kp['color'] as Color;
    summaryPoints.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(kp['icon'] as IconData, color: color, size: 18.0),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                kp['text'] as String,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey.shade800,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final refTable = Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _slbRefRow('Widget', 'SliverLayoutBuilder'),
      _slbRefRow('Library', 'package:flutter/widgets.dart'),
      _slbRefRow('Parent', 'CustomScrollView.slivers'),
      _slbRefRow('Builder', '(BuildContext, SliverConstraints) → Widget'),
      _slbRefRow('Returns', 'Must return a Sliver widget'),
      _slbRefRow('Box equiv', 'LayoutBuilder'),
      _slbRefRow('Use case', 'Responsive grids, scroll-aware headers'),
    ],
  );

  // ============================================================
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('=== Assembling tabbed layout ===');
  print('SliverLayoutBuilder Deep Demo complete');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SliverLayoutBuilder Deep Demo'),
        backgroundColor: Colors.deepPurple.shade700,
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
            Tab(text: 'Constraints'),
            Tab(text: 'Explorer'),
            Tab(text: 'Responsive'),
            Tab(text: 'Scroll-Aware'),
            Tab(text: 'Remaining'),
            Tab(text: 'Adaptive'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
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
                        Colors.deepPurple.withValues(alpha: 0.1),
                        Colors.deepPurple.withValues(alpha: 0.03),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.architecture,
                        size: 48.0,
                        color: Colors.deepPurple,
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        'SliverLayoutBuilder',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple.shade700,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'Build slivers that adapt to their constraints — '
                        'viewport size, scroll offset, and layout direction.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...conceptCards,
              ],
            ),
          ),
          // Tab 2: Constraints reference
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SliverConstraints Properties',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade700,
                  ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  'The builder callback receives these constraint values:',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.deepPurple.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(children: propWidgets),
                ),
                builderSignature,
              ],
            ),
          ),
          // Tab 3: Live constraint explorer
          constraintExplorer,
          // Tab 4: Responsive grid
          responsiveGrid,
          // Tab 5: Scroll-aware header
          scrollAwareDemo,
          // Tab 6: Remaining paint extent
          remainingDemo,
          // Tab 7: Adaptive section
          adaptiveSection,
          // Tab 8: Summary
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Key Takeaways',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade700,
                  ),
                ),
                const SizedBox(height: 16.0),
                ...summaryPoints,
                const SizedBox(height: 24.0),
                Text(
                  'Quick Reference',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade700,
                  ),
                ),
                const SizedBox(height: 12.0),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.deepPurple.withValues(alpha: 0.1),
                    ),
                  ),
                  child: refTable,
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
// HELPER: Constraint display row
// ============================================================
Widget _slbConstraintRow(String label, String value, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8.0),
        SizedBox(
          width: 160.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 11.5,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.0,
              fontFamily: 'monospace',
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HELPER: Reference row
// ============================================================
Widget _slbRefRow(String label, String value) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90.0,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.grey.shade600,
            ),
          ),
        ),
      ],
    ),
  );
}

// ============================================================
// HELPER: Activity rows for adaptive dashboard
// ============================================================
List<Widget> _slbBuildActivityRows() {
  final activities = <Map<String, dynamic>>[
    {
      'action': 'New user signed up',
      'time': '2 min ago',
      'icon': Icons.person_add,
      'color': Colors.blue,
    },
    {
      'action': 'Order #7892 completed',
      'time': '5 min ago',
      'icon': Icons.check_circle,
      'color': Colors.green,
    },
    {
      'action': 'Support ticket opened',
      'time': '12 min ago',
      'icon': Icons.bug_report,
      'color': Colors.orange,
    },
    {
      'action': 'Payment processed',
      'time': '18 min ago',
      'icon': Icons.payment,
      'color': Colors.purple,
    },
    {
      'action': 'Server alert resolved',
      'time': '30 min ago',
      'icon': Icons.dns,
      'color': Colors.teal,
    },
  ];

  return activities.map((a) {
    final color = a['color'] as Color;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Container(
            width: 30.0,
            height: 30.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              a['icon'] as IconData,
              color: color,
              size: 15.0,
            ),
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Text(
              a['action'] as String,
              style: TextStyle(
                fontSize: 12.0,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Text(
            a['time'] as String,
            style: TextStyle(
              fontSize: 10.5,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }).toList();
}
