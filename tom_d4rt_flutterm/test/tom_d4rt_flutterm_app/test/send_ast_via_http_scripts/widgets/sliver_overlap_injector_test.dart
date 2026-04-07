// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverOverlapInjector
// Demonstrates SliverOverlapInjector — the receiving end of the overlap
// compensation system. It reads the overlap value from a
// SliverOverlapAbsorberHandle and injects that much empty space at the top
// of an inner scroll view so that content is not hidden behind a pinned
// header. Typically placed as the first sliver in the body of NestedScrollView.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverOverlapInjector Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.vertical_align_top,
      'title': 'What Is SliverOverlapInjector?',
      'body': 'SliverOverlapInjector is a sliver that reads overlap data '
          'from a SliverOverlapAbsorberHandle and injects exactly that '
          'many pixels of empty space. It is invisible — no paint, no '
          'decoration — it only reserves layout space so that the first '
          'real content sliver starts below any overlapping header.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.architecture,
      'title': 'Role in the Trio',
      'body': 'The absorber measures and writes overlap to the handle. '
          'The injector reads the handle and compensates. Without the '
          'injector, the measured overlap value would go unused and '
          'content would still hide behind the header.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.sync,
      'title': 'Dynamic Compensation',
      'body': 'As the user scrolls and the header collapses, the absorber '
          'updates the handle. The injector listens to the handle and '
          'resizes on every frame. When the header is fully expanded, '
          'the injector is at maximum size. When the header is fully '
          'collapsed (pinned only), the injector shrinks to the pinned height.',
      'accent': Colors.orange,
    },
    {
      'icon': Icons.tab,
      'title': 'One Per Tab Body',
      'body': 'In a tabbed NestedScrollView, every tab body gets its own '
          'SliverOverlapInjector at the top of its CustomScrollView. '
          'All injectors share the same handle and thus all compensate '
          'equally, ensuring consistent scroll behavior across tabs.',
      'accent': Colors.purple,
    },
  ];

  final conceptCards = <Widget>[];
  for (var idx = 0; idx < conceptItems.length; idx++) {
    final e = conceptItems[idx];
    final accent = e['accent'] as Color;
    print('Concept ${idx + 1}: ${e['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.04)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(e['icon'] as IconData, color: accent, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      e['body'] as String,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade800,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 2: Constructor
  // ============================================================
  print('=== Section 2: Constructor ===');

  final constructorRows = <Map<String, String>>[
    {
      'param': 'handle',
      'type': 'SliverOverlapAbsorberHandle',
      'desc': 'Required. The same handle that the SliverOverlapAbsorber '
          'writes to. Obtain it with '
          'NestedScrollView.sliverOverlapAbsorberHandleFor(context).',
    },
    {
      'param': 'key',
      'type': 'Key?',
      'desc': 'Optional widget key. Rarely needed since there is typically '
          'only one injector per inner scroll view.',
    },
  ];

  final constructorWidgets = <Widget>[];
  for (var i = 0; i < constructorRows.length; i++) {
    final row = constructorRows[i];
    print('Constructor ${i + 1}: ${row['param']}');
    constructorWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.green.withOpacity(0.06)
              : Colors.grey.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    row['param']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    row['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              row['desc']!,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade700,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Behavior table
  final behaviorItems = <Map<String, String>>[
    {
      'prop': 'Paint',
      'val': 'Nothing — the injector is invisible.',
    },
    {
      'prop': 'Layout extent',
      'val': 'Equals handle.layoutExtent. Changes dynamically.',
    },
    {
      'prop': 'Hit testing',
      'val': 'None — it does not intercept taps or gestures.',
    },
    {
      'prop': 'Semantics',
      'val': 'None — invisible to accessibility tools.',
    },
    {
      'prop': 'Rebuild trigger',
      'val': 'Listens to handle (ChangeNotifier) and marks for relayout.',
    },
  ];

  final behaviorTable = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.green.withOpacity(0.2)),
    ),
    child: Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.green.withOpacity(0.08),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(9),
              topRight: Radius.circular(9),
            ),
          ),
          child: const Text(
            'Injector Behavior',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        ),
        ...behaviorItems.map((item) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.green.withOpacity(0.08)),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 110,
                  child: Text(
                    item['prop']!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade700,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    item['val']!,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Basic injection demo
  // ============================================================
  print('=== Section 3: Basic injection ===');

  final basicInjectionDemo = SizedBox(
    height: 480,
    child: NestedScrollView(
      headerSliverBuilder: (BuildContext ctx, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
            sliver: SliverAppBar(
              title: const Text('Basic Injection'),
              backgroundColor: Colors.green.shade700,
              expandedHeight: 150,
              pinned: true,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.green.shade800,
                        Colors.teal.shade600,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 60),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.vertical_align_top,
                            color: Colors.white70,
                            size: 36,
                          ),
                          SizedBox(height: 6),
                          Text(
                            'Injector pads content below this',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ];
      },
      body: Builder(
        builder: (BuildContext ctx) {
          return CustomScrollView(
            slivers: <Widget>[
              // THIS is the SliverOverlapInjector
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
              ),
              // Content comes after the injector
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext childCtx, int index) {
                    final taskIcons = [
                      Icons.check_circle,
                      Icons.radio_button_unchecked,
                      Icons.check_circle_outline,
                      Icons.radio_button_unchecked,
                      Icons.check_circle,
                    ];
                    final taskColors = [
                      Colors.green,
                      Colors.grey,
                      Colors.green.shade300,
                      Colors.grey,
                      Colors.green,
                    ];
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.green.withOpacity(0.15),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            taskIcons[index % taskIcons.length],
                            color: taskColors[index % taskColors.length],
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Task ${index + 1}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Injector ensures this starts below the '
                                  'pinned header — not behind it.',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: 25,
                ),
              ),
            ],
          );
        },
      ),
    ),
  );

  // ============================================================
  // SECTION 4: Dynamic padding visualization
  // ============================================================
  print('=== Section 4: Dynamic padding ===');

  // Explain what happens at different scroll positions
  final paddingStates = <Map<String, dynamic>>[
    {
      'state': 'Fully Expanded',
      'overlap': '~150 px',
      'desc': 'Header is at expandedHeight. The absorber reports full '
          'overlap. The injector reserves maximum space — content starts '
          'at the very bottom of the expanded header.',
      'color': Colors.green,
      'fraction': 1.0,
    },
    {
      'state': 'Partially Collapsed',
      'overlap': '~100 px',
      'desc': 'User has scrolled partway. The FlexibleSpaceBar is '
          'shrinking. The absorber updates the handle with the current '
          'overlap. The injector resizes in real time.',
      'fraction': 0.65,
      'color': Colors.orange,
    },
    {
      'state': 'Fully Collapsed (Pinned)',
      'overlap': '~56 px',
      'desc': 'The header has collapsed to its minimum (toolbar) height. '
          'The absorber reports just the pinned bar height. The injector '
          'shrinks to this minimum, maximizing content space.',
      'fraction': 0.35,
      'color': Colors.blue,
    },
    {
      'state': 'Scrolled Away (not pinned)',
      'overlap': '0 px',
      'desc': 'If the header is not pinned, once it scrolls out of view '
          'the overlap becomes zero. The injector contributes no space '
          'at all — content starts at the very top.',
      'fraction': 0.0,
      'color': Colors.grey,
    },
  ];

  final paddingViz = <Widget>[];
  for (var i = 0; i < paddingStates.length; i++) {
    final state = paddingStates[i];
    final stateColor = state['color'] as Color;
    final fraction = state['fraction'] as double;
    print('Padding state ${i + 1}: ${state['state']}');
    paddingViz.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: stateColor.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            // Visual bar showing injector size
            Container(
              width: 60,
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(11),
                  bottomLeft: Radius.circular(11),
                ),
              ),
              child: Column(
                children: [
                  // Header area
                  Container(
                    height: 30,
                    decoration: BoxDecoration(
                      color: stateColor.withOpacity(0.3),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(11),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'HDR',
                        style: TextStyle(fontSize: 9, color: Colors.white),
                      ),
                    ),
                  ),
                  // Injector (variable height)
                  Container(
                    height: 90 * fraction,
                    color: stateColor.withOpacity(0.15),
                    child: Center(
                      child: fraction > 0.2
                          ? Text(
                              'INJ',
                              style: TextStyle(
                                fontSize: 8,
                                color: stateColor,
                              ),
                            )
                          : null,
                    ),
                  ),
                  // Content fills the rest
                  Expanded(
                    child: Container(
                      color: Colors.blueGrey.withOpacity(0.1),
                      child: const Center(
                        child: Text(
                          '...',
                          style: TextStyle(fontSize: 9, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Description
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          state['state'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: stateColor,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: stateColor.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            state['overlap'] as String,
                            style: TextStyle(
                              fontFamily: 'monospace',
                              fontSize: 11,
                              color: stateColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      state['desc'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade700,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Multi-tab injection
  // ============================================================
  print('=== Section 5: Multi-tab injection ===');

  final tabData = <Map<String, dynamic>>[
    {
      'label': 'Inbox',
      'icon': Icons.inbox,
      'color': Colors.green,
      'items': [
        'Meeting notes from product sync',
        'Weekly standup summary',
        'Code review request: PR #421',
        'Customer feedback report Q1',
        'Infrastructure cost analysis',
        'New hire onboarding checklist',
        'Security audit findings',
        'Release schedule update',
      ],
    },
    {
      'label': 'Sent',
      'icon': Icons.send,
      'color': Colors.blue,
      'items': [
        'Re: Budget proposal for Q2',
        'Feature requirements document',
        'Team retrospective notes',
        'Re: Deployment timeline',
        'Architecture decision record',
        'Performance report March',
        'Re: Customer escalation',
        'Sprint planning outcomes',
      ],
    },
    {
      'label': 'Drafts',
      'icon': Icons.drafts,
      'color': Colors.amber,
      'items': [
        'RFC: Microservices migration',
        'Blog post: Flutter in production',
        'Hiring plan H2 2026',
        'Conference talk proposal',
        'Internal tool evaluation',
        'Vendor comparison matrix',
        'Training curriculum outline',
        'Team restructuring proposal',
      ],
    },
  ];

  final multiTabDemo = SizedBox(
    height: 500,
    child: DefaultTabController(
      length: tabData.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext ctx, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
              sliver: SliverAppBar(
                title: const Text('Email Client'),
                backgroundColor: Colors.green.shade800,
                pinned: true,
                expandedHeight: 130,
                forceElevated: innerBoxIsScrolled,
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: tabData.map((tab) {
                    return Tab(
                      icon: Icon(tab['icon'] as IconData),
                      text: tab['label'] as String,
                    );
                  }).toList(),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          children: tabData.map((tab) {
            return Builder(
              builder: (BuildContext ctx) {
                final items = tab['items'] as List<String>;
                final tabColor = tab['color'] as Color;
                return CustomScrollView(
                  slivers: <Widget>[
                    SliverOverlapInjector(
                      handle:
                          NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.all(10),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext childCtx, int index) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 6),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: tabColor.withOpacity(0.15),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: tabColor.withOpacity(0.05),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: tabColor.withOpacity(0.12),
                                  radius: 18,
                                  child: Icon(
                                    tab['icon'] as IconData,
                                    color: tabColor,
                                    size: 18,
                                  ),
                                ),
                                title: Text(
                                  items[index],
                                  style: const TextStyle(fontSize: 13),
                                ),
                                subtitle: Text(
                                  '${tab['label']} — injector compensates '
                                  'the overlapping header here too',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            );
                          },
                          childCount: items.length,
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }).toList(),
        ),
      ),
    ),
  );

  print('Multi-tab email demo: ${tabData.length} mailbox tabs');

  // ============================================================
  // SECTION 6: Without vs With injector
  // ============================================================
  print('=== Section 6: Without vs With injector ===');

  // Explanation cards
  final compCards = <Map<String, dynamic>>[
    {
      'title': 'Without SliverOverlapInjector',
      'icon': Icons.warning_amber,
      'color': Colors.red,
      'points': [
        'The first item in the inner scroll list starts at pixel 0',
        'If the header is pinned, it sits on top of those first items',
        'Items are technically in the scroll view but visually clipped',
        'User sees a "jump" when scrolling past the hidden items',
      ],
    },
    {
      'title': 'With SliverOverlapInjector',
      'icon': Icons.check_circle_outline,
      'color': Colors.green,
      'points': [
        'The injector occupies the first N pixels (N = handle.layoutExtent)',
        'Real content starts immediately after the injected space',
        'Content below aligns perfectly with header bottom edge',
        'Scrolling is smooth — no hidden items, no jumps',
      ],
    },
  ];

  final compWidgets = <Widget>[];
  for (final card in compCards) {
    final cColor = card['color'] as Color;
    final points = card['points'] as List<String>;
    print('Comparison: ${card['title']}');
    compWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: cColor.withOpacity(0.3), width: 2),
          color: cColor.withOpacity(0.03),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: cColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(11),
                  topRight: Radius.circular(11),
                ),
              ),
              child: Row(
                children: [
                  Icon(card['icon'] as IconData, color: cColor, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    card['title'] as String,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: cColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: points.asMap().entries.map((entry) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 3),
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: cColor.withOpacity(0.12),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${entry.key + 1}',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: cColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            entry.value,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade700,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Side-by-side visual showing the injector gap
  final injectorGapVisual = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.green.withOpacity(0.2)),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withOpacity(0.06),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        const Text(
          'Inner ScrollView Structure',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
        const SizedBox(height: 14),
        // The structure
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.green.withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.vertical_align_top,
                      color: Colors.green.shade600,
                      size: 18,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'SliverOverlapInjector',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.green.shade700,
                        fontFamily: 'monospace',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        'invisible gap',
                        style: TextStyle(fontSize: 10, color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                color: Colors.blueGrey.withOpacity(0.04),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.list, color: Colors.blueGrey, size: 18),
                    SizedBox(width: 6),
                    Text(
                      'SliverList (your content)',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'monospace',
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.04),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(6),
                    bottomRight: Radius.circular(6),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.grid_view, color: Colors.blueGrey, size: 18),
                    SizedBox(width: 6),
                    Text(
                      'SliverGrid (more content)',
                      style: TextStyle(
                        fontSize: 13,
                        fontFamily: 'monospace',
                        color: Colors.blueGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'The injector is always the FIRST sliver in the '
          'CustomScrollView inside the NestedScrollView body.',
          style: TextStyle(
            fontSize: 12,
            fontStyle: FontStyle.italic,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Best practices
  // ============================================================
  print('=== Section 7: Best practices ===');

  final practices = <Map<String, dynamic>>[
    {
      'title': 'Always Use Builder',
      'body': 'The context passed to headerSliverBuilder is different from '
          'the one inside the body. Use a Builder widget to get the correct '
          'context that has access to the InheritedWidget providing the handle.',
      'icon': Icons.build,
      'color': Colors.green,
    },
    {
      'title': 'Injector Must Be First Sliver',
      'body': 'Place SliverOverlapInjector as the very first sliver in '
          'the CustomScrollView. If other slivers come before it, content '
          'will still be pushed down but the injector space will be misaligned.',
      'icon': Icons.first_page,
      'color': Colors.blue,
    },
    {
      'title': 'Do Not Use SliverPadding Instead',
      'body': 'You might be tempted to add a hardcoded SliverPadding at the '
          'top instead. This breaks when the header height changes (e.g., '
          'expanding AppBar). The injector is dynamic — it adjusts frame by '
          'frame as the header collapses.',
      'icon': Icons.do_not_disturb,
      'color': Colors.red,
    },
    {
      'title': 'One Injector Per Inner ScrollView',
      'body': 'Each CustomScrollView in the body should have exactly one '
          'injector. In a TabBarView, that means one injector per tab body.',
      'icon': Icons.looks_one,
      'color': Colors.purple,
    },
    {
      'title': 'Do Not Wrap Injector in SliverPadding',
      'body': 'Wrapping the injector in SliverPadding adds extra space on '
          'top of the injected space. Use SliverPadding around your content '
          'slivers instead, not around the injector itself.',
      'icon': Icons.warning,
      'color': Colors.orange,
    },
    {
      'title': 'pinned: true Is The Main Use Case',
      'body': 'The injector is most critical when the header is pinned. '
          'If the header scrolls away entirely (pinned: false), the overlap '
          'eventually becomes zero and the injector contributes no space.',
      'icon': Icons.push_pin,
      'color': Colors.teal,
    },
  ];

  final practiceWidgets = <Widget>[];
  for (var i = 0; i < practices.length; i++) {
    final p = practices[i];
    final pColor = p['color'] as Color;
    print('Practice ${i + 1}: ${p['title']}');
    practiceWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: pColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: pColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: pColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                p['icon'] as IconData,
                color: pColor,
                size: 22,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: pColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    p['body'] as String,
                    style: TextStyle(
                      fontSize: 12,
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
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.vertical_align_top,
      'text': 'SliverOverlapInjector reads overlap from the handle and '
          'injects invisible space at the top of the inner scroll view.',
    },
    {
      'icon': Icons.straighten,
      'text': 'It sizes itself to handle.layoutExtent pixels — dynamically '
          'adjusting as the header expands or collapses.',
    },
    {
      'icon': Icons.visibility_off,
      'text': 'The injector is invisible — no paint, no hit testing, no '
          'semantics. It only contributes layout space.',
    },
    {
      'icon': Icons.first_page,
      'text': 'Must be the first sliver in the CustomScrollView inside '
          'the NestedScrollView body.',
    },
    {
      'icon': Icons.tab,
      'text': 'In tabbed layouts, every tab body needs its own injector, '
          'all sharing the same handle from the absorber.',
    },
    {
      'icon': Icons.sync,
      'text': 'Completes the absorber-handle-injector trio that solves '
          'the NestedScrollView overlap problem.',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (var i = 0; i < summaryPoints.length; i++) {
    final sp = summaryPoints[i];
    print('Summary ${i + 1}: ${(sp['text'] as String).substring(0, 40)}...');
    summaryWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.green.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.green.shade700,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                sp['text'] as String,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade800,
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
  // ASSEMBLE TABBED LAYOUT
  // ============================================================
  print('Assembling tabbed layout');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('SliverOverlapInjector'),
        backgroundColor: Colors.green.shade700,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.construction), text: 'Constructor'),
            Tab(icon: Icon(Icons.play_arrow), text: 'Basic'),
            Tab(icon: Icon(Icons.tune), text: 'Dynamic'),
            Tab(icon: Icon(Icons.tab), text: 'Multi-Tab'),
            Tab(icon: Icon(Icons.compare), text: 'Without vs With'),
            Tab(icon: Icon(Icons.star), text: 'Best Practices'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1: Concept
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'SliverOverlapInjector is the receiving end of the overlap '
                  'compensation system. It reads the overlap value from the '
                  'handle and injects invisible space so body content starts '
                  'below the pinned header.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),

          // Tab 2: Constructor
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'SliverOverlapInjector has a minimal API: just a required '
                  'handle parameter. Its behavior is fully driven by the '
                  'overlap value in the handle.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...constructorWidgets,
              behaviorTable,
            ],
          ),

          // Tab 3: Basic injection
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'A NestedScrollView with an expanding pinned header. '
                  'The injector is the first sliver in the inner '
                  'CustomScrollView, ensuring content appears below the header.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: basicInjectionDemo,
                ),
              ),
            ],
          ),

          // Tab 4: Dynamic padding
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'The injector dynamically adjusts its size as the header '
                  'collapses or expands. Here are the different states:',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...paddingViz,
            ],
          ),

          // Tab 5: Multi-tab
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'An email client with Inbox, Sent, and Drafts tabs. Each '
                  'tab body has its own SliverOverlapInjector sharing the '
                  'same handle.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: multiTabDemo,
                ),
              ),
            ],
          ),

          // Tab 6: Without vs With
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Understanding the visual difference when the injector is '
                  'present versus absent in the inner scroll view.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...compWidgets,
              injectorGapVisual,
            ],
          ),

          // Tab 7: Best practices
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Rules and tips for correct use of SliverOverlapInjector.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...practiceWidgets,
            ],
          ),

          // Tab 8: Summary
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.withOpacity(0.12),
                      Colors.teal.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about SliverOverlapInjector and its role '
                  'in the NestedScrollView overlap system.',
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.5,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ...summaryWidgets,
            ],
          ),
        ],
      ),
    ),
  );
}
