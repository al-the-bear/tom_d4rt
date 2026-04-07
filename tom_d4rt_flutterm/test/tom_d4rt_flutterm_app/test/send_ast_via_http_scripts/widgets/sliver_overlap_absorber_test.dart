// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverOverlapAbsorber
// Demonstrates SliverOverlapAbsorber — wraps a header sliver and measures how
// many pixels of it overlap an inner scroll region. Works with a
// SliverOverlapAbsorberHandle to communicate the overlap value to one or more
// SliverOverlapInjectors which compensate by adding padding. Essential for
// NestedScrollView when headers (like SliverAppBar) extend into the body.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverOverlapAbsorber Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.straighten,
      'title': 'What Is SliverOverlapAbsorber?',
      'body': 'SliverOverlapAbsorber is a sliver widget that wraps another '
          'sliver (typically a SliverAppBar) and measures how much of it '
          'overlaps the neighboring scroll region. It writes the measured '
          'overlap to a SliverOverlapAbsorberHandle so injectors can '
          'compensate with matching padding.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.layers,
      'title': 'Why Do We Need It?',
      'body': 'In NestedScrollView, the outer scroll view contains the '
          'header (SliverAppBar) and the inner scroll view contains body '
          'content. When the header is pinned, it physically sits on top of '
          'the inner scroll region. Without an absorber, the first items in '
          'the inner list would be hidden behind the header.',
      'accent': Colors.deepOrange,
    },
    {
      'icon': Icons.architecture,
      'title': 'Absorber–Handle–Injector Trio',
      'body': 'The absorber measures overlap and writes it to the handle. '
          'The injector reads the handle and inserts compensating space. '
          'Together they solve the overlap problem elegantly without '
          'hardcoded padding values — the system is fully dynamic.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.visibility,
      'title': 'What Gets "Absorbed"?',
      'body': 'The absorber does not change the visual appearance of its '
          'child sliver. It only measures the child\'s layout extent that '
          'overlaps the SliverOverlapInjector region. The child sliver '
          'renders exactly as it would without the absorber wrapping it.',
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
      'desc': 'Required. The handle to write overlap data to. Obtained '
          'via NestedScrollView.sliverOverlapAbsorberHandleFor(context) or '
          'created manually.',
    },
    {
      'param': 'sliver',
      'type': 'Widget?',
      'desc': 'The sliver child to wrap and measure. Typically a '
          'SliverAppBar, SliverPersistentHeader, or any header sliver '
          'that overlaps the body scroll region.',
    },
    {
      'param': 'key',
      'type': 'Key?',
      'desc': 'Optional widget key for identification in the widget tree.',
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
              ? Colors.indigo.withOpacity(0.06)
              : Colors.grey.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.15)),
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
                    color: Colors.indigo.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    row['param']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo,
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

  // Usage example box
  final usageExample = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.indigo.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.code, color: Colors.indigo.shade400, size: 18),
            const SizedBox(width: 8),
            Text(
              'Typical Usage',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade700,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            'SliverOverlapAbsorber(\n'
            '  handle: NestedScrollView\n'
            '    .sliverOverlapAbsorberHandleFor(context),\n'
            '  sliver: SliverAppBar(\n'
            '    pinned: true,\n'
            '    expandedHeight: 200,\n'
            '    flexibleSpace: FlexibleSpaceBar(...),\n'
            '  ),\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              color: Colors.grey.shade800,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Basic absorber with SliverAppBar
  // ============================================================
  print('=== Section 3: Basic absorber ===');

  final basicDemo = SizedBox(
    height: 450,
    child: NestedScrollView(
      headerSliverBuilder: (BuildContext ctx, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
            sliver: SliverAppBar(
              title: const Text('Basic Absorber'),
              backgroundColor: Colors.indigo.shade700,
              pinned: true,
              forceElevated: innerBoxIsScrolled,
            ),
          ),
        ];
      },
      body: Builder(
        builder: (BuildContext ctx) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext childCtx, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: index.isEven
                            ? Colors.indigo.shade50
                            : Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.indigo.withOpacity(0.12),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: Colors.indigo.shade200,
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Item ${index + 1} — properly positioned below '
                              'the pinned app bar thanks to the absorber.',
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: 20,
                ),
              ),
            ],
          );
        },
      ),
    ),
  );

  // ============================================================
  // SECTION 4: Expanding header with FlexibleSpaceBar
  // ============================================================
  print('=== Section 4: Expanding header ===');

  final expandingDemo = SizedBox(
    height: 500,
    child: NestedScrollView(
      headerSliverBuilder: (BuildContext ctx, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
            sliver: SliverAppBar(
              title: const Text('Expanding Header'),
              backgroundColor: Colors.deepPurple.shade700,
              expandedHeight: 200,
              pinned: true,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.deepPurple.shade900,
                        Colors.indigo.shade600,
                        Colors.blue.shade400,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 50),
                        Icon(
                          Icons.straighten,
                          color: Colors.white.withOpacity(0.7),
                          size: 44,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Absorber measures this overlap',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'expandedHeight: 200, pinned: true',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 12,
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
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
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
              ),
              SliverPadding(
                padding: const EdgeInsets.all(12),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.3,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext childCtx, int index) {
                      final gridColors = [
                        Colors.deepPurple.shade100,
                        Colors.indigo.shade100,
                        Colors.blue.shade100,
                        Colors.cyan.shade100,
                        Colors.teal.shade100,
                        Colors.green.shade100,
                      ];
                      final gridIcons = [
                        Icons.photo,
                        Icons.music_note,
                        Icons.videocam,
                        Icons.article,
                        Icons.folder,
                        Icons.bookmark,
                      ];
                      final gridLabels = [
                        'Photos',
                        'Music',
                        'Videos',
                        'Articles',
                        'Files',
                        'Bookmarks',
                      ];
                      return Container(
                        decoration: BoxDecoration(
                          color: gridColors[index % gridColors.length],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.indigo.withOpacity(0.15),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              gridIcons[index % gridIcons.length],
                              color: Colors.indigo.shade400,
                              size: 32,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              gridLabels[index % gridLabels.length],
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.indigo.shade700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Tile ${index + 1}',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    childCount: 18,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    ),
  );

  // ============================================================
  // SECTION 5: Pinned header — always overlapping
  // ============================================================
  print('=== Section 5: Pinned header ===');

  final pinnedItems = <Map<String, dynamic>>[
    {
      'title': 'pinned: true',
      'desc': 'The SliverAppBar stays visible at the top when scrolled. '
          'The absorber constantly measures the height of the pinned portion '
          'and writes it to the handle. The injector reads this value and '
          'offsets content by exactly that many pixels.',
      'icon': Icons.push_pin,
      'color': Colors.red,
    },
    {
      'title': 'pinned: false',
      'desc': 'The SliverAppBar scrolls completely out of view. Once scroll '
          'offset exceeds the header height, the overlap becomes zero. '
          'The absorber still measures, but writes 0 to the handle.',
      'icon': Icons.unfold_more,
      'color': Colors.orange,
    },
    {
      'title': 'floating: true',
      'desc': 'The header reappears whenever the user scrolls up, even '
          'mid-list. The absorber re-measures the overlap as the floating '
          'header animates back into view. The injector adjusts dynamically.',
      'icon': Icons.vertical_align_top,
      'color': Colors.blue,
    },
    {
      'title': 'snap: true (with floating)',
      'desc': 'The floating header either fully shows or fully hides — '
          'it snaps to one state. The absorber measures the full or zero '
          'overlap accordingly. Snap requires floating: true.',
      'icon': Icons.filter_center_focus,
      'color': Colors.green,
    },
  ];

  final pinnedDemo = SizedBox(
    height: 480,
    child: NestedScrollView(
      headerSliverBuilder: (BuildContext ctx, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
            sliver: SliverAppBar(
              title: const Text('Pinned Header Demo'),
              backgroundColor: Colors.red.shade700,
              expandedHeight: 160,
              pinned: true,
              forceElevated: innerBoxIsScrolled,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.red.shade900,
                        Colors.deepOrange.shade600,
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
                            Icons.push_pin,
                            color: Colors.white70,
                            size: 36,
                          ),
                          SizedBox(height: 6),
                          Text(
                            'This header is always pinned',
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
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(ctx),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  pinnedItems.map((item) {
                    final itemColor = item['color'] as Color;
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            itemColor.withOpacity(0.1),
                            itemColor.withOpacity(0.03),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: itemColor.withOpacity(0.25)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: itemColor.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              item['icon'] as IconData,
                              color: itemColor,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['title'] as String,
                                  style: TextStyle(
                                    fontFamily: 'monospace',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: itemColor,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item['desc'] as String,
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey.shade700,
                                    height: 1.4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext childCtx, int index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 3,
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: index.isEven
                            ? Colors.red.shade50
                            : Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Scroll item ${index + 1} — overlap is compensated '
                        'dynamically as header collapses',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    );
                  },
                  childCount: 20,
                ),
              ),
            ],
          );
        },
      ),
    ),
  );

  // ============================================================
  // SECTION 6: Without vs With Absorber comparison
  // ============================================================
  print('=== Section 6: Without vs With comparison ===');

  final comparisonNotes = <Map<String, dynamic>>[
    {
      'title': 'Without SliverOverlapAbsorber',
      'points': [
        'Content starts at the very top of the inner scroll region',
        'First items are hidden behind the pinned app bar',
        'User must scroll past the hidden area to see content',
        'Looks broken — content appears from behind the header',
      ],
      'color': Colors.red,
      'icon': Icons.warning,
    },
    {
      'title': 'With SliverOverlapAbsorber',
      'points': [
        'Absorber measures pinned header overlap',
        'Handle communicates the overlap value',
        'Injector adds compensating padding at the top',
        'Content starts exactly below the header — perfect alignment',
      ],
      'color': Colors.green,
      'icon': Icons.check_circle,
    },
  ];

  final comparisonWidgets = <Widget>[];
  for (final note in comparisonNotes) {
    final noteColor = note['color'] as Color;
    final points = note['points'] as List<String>;
    print('Comparison: ${note['title']}');
    comparisonWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: noteColor.withOpacity(0.3), width: 2),
          color: noteColor.withOpacity(0.04),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: noteColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(11),
                  topRight: Radius.circular(11),
                ),
              ),
              child: Row(
                children: [
                  Icon(note['icon'] as IconData, color: noteColor, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    note['title'] as String,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: noteColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: points.map((point) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 5),
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: noteColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            point,
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

  // Visual: Side-by-side broken vs fixed
  final sideBySide = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: Row(
      children: [
        // Broken (no absorber)
        Expanded(
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.red.withOpacity(0.4), width: 2),
            ),
            child: Column(
              children: [
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.red.shade700,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'No Absorber',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Simulate hidden content
                Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 8,
                        itemBuilder: (ctx, idx) {
                          return Container(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 3,
                            ),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              'Item ${idx + 1}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          );
                        },
                      ),
                      // Overlay showing "hidden" area
                      Container(
                        height: 56,
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.3),
                        ),
                        child: const Center(
                          child: Text(
                            'HIDDEN BEHIND HEADER',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
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
        ),
        const SizedBox(width: 12),
        // Fixed (with absorber)
        Expanded(
          child: Container(
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.green.withOpacity(0.4),
                width: 2,
              ),
            ),
            child: Column(
              children: [
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.green.shade700,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'With Absorber',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.only(top: 4),
                    itemCount: 8,
                    itemBuilder: (ctx, idx) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.green.shade50,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check,
                              color: Colors.green.shade400,
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              'Item ${idx + 1} — visible',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
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
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Architecture deep-dive
  // ============================================================
  print('=== Section 7: Architecture ===');

  final archSteps = <Map<String, dynamic>>[
    {
      'label': 'Outer ScrollView',
      'detail': 'Contains the header slivers. Managed by the outer '
          'ScrollController of NestedScrollView.',
      'color': Colors.blueGrey,
      'icon': Icons.view_agenda,
    },
    {
      'label': 'SliverOverlapAbsorber',
      'detail': 'Wraps SliverAppBar. During performLayout, computes '
          'overlap = childLayoutExtent that extends past the remaining '
          'paint extent. Writes to handle.',
      'color': Colors.indigo,
      'icon': Icons.straighten,
    },
    {
      'label': 'SliverAppBar (child)',
      'detail': 'The header sliver being measured. Renders normally. '
          'Its layout extent is what the absorber captures.',
      'color': Colors.deepPurple,
      'icon': Icons.web_asset,
    },
    {
      'label': 'Handle (bridge)',
      'detail': 'Stores layoutExtent and scrollExtent. Notifies '
          'all registered listeners when values change.',
      'color': Colors.teal,
      'icon': Icons.handshake,
    },
    {
      'label': 'Inner ScrollView',
      'detail': 'Contains the body content. Each tab has its own '
          'inner CustomScrollView with an injector at the top.',
      'color': Colors.blue,
      'icon': Icons.view_list,
    },
    {
      'label': 'SliverOverlapInjector',
      'detail': 'Reads handle.layoutExtent and sizes itself to exactly '
          'that many pixels. Pushes content down so nothing hides.',
      'color': Colors.green,
      'icon': Icons.vertical_align_top,
    },
  ];

  final archWidgets = <Widget>[];
  for (var i = 0; i < archSteps.length; i++) {
    final step = archSteps[i];
    final sColor = step['color'] as Color;
    print('Architecture ${i + 1}: ${step['label']}');
    archWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                width: 40,
                child: Column(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: sColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                        border: Border.all(color: sColor, width: 2),
                      ),
                      child: Icon(
                        step['icon'] as IconData,
                        color: sColor,
                        size: 16,
                      ),
                    ),
                    if (i < archSteps.length - 1)
                      Expanded(
                        child: Container(
                          width: 2,
                          color: sColor.withOpacity(0.25),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: sColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: sColor.withOpacity(0.15)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        step['label'] as String,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: sColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        step['detail'] as String,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
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
      ),
    );
  }

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.straighten,
      'text': 'SliverOverlapAbsorber wraps a header sliver and measures '
          'how much it overlaps the body scroll region.',
    },
    {
      'icon': Icons.handshake,
      'text': 'It writes the overlap (layoutExtent) to a '
          'SliverOverlapAbsorberHandle so injectors can read it.',
    },
    {
      'icon': Icons.push_pin,
      'text': 'Essential when using pinned SliverAppBars in NestedScrollView '
          '— prevents content from hiding behind the header.',
    },
    {
      'icon': Icons.visibility,
      'text': 'The absorber is transparent — it does not change how its '
          'child renders. It only measures and reports.',
    },
    {
      'icon': Icons.tab,
      'text': 'In tabbed layouts, one absorber serves all tabs through '
          'the shared handle — each tab body has an injector.',
    },
    {
      'icon': Icons.auto_awesome,
      'text': 'NestedScrollView creates the absorber automatically in '
          'headerSliverBuilder — just wrap your SliverAppBar.',
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
          color: Colors.indigo.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.indigo.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.indigo.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.indigo.shade700,
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
        title: const Text('SliverOverlapAbsorber'),
        backgroundColor: Colors.indigo.shade700,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.construction), text: 'Constructor'),
            Tab(icon: Icon(Icons.play_arrow), text: 'Basic'),
            Tab(icon: Icon(Icons.unfold_more), text: 'Expanding'),
            Tab(icon: Icon(Icons.push_pin), text: 'Pinned'),
            Tab(icon: Icon(Icons.compare), text: 'Without vs With'),
            Tab(icon: Icon(Icons.architecture), text: 'Architecture'),
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'SliverOverlapAbsorber wraps a header sliver and measures '
                  'overlap with the inner scroll body. It is the measurement '
                  'side of the absorber-handle-injector system used by '
                  'NestedScrollView.',
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'SliverOverlapAbsorber takes a required handle and an '
                  'optional sliver child. The handle is the bridge to '
                  'the injector side.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...constructorWidgets,
              usageExample,
            ],
          ),

          // Tab 3: Basic absorber demo
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'A basic NestedScrollView where SliverOverlapAbsorber '
                  'wraps a simple pinned SliverAppBar. The injector in '
                  'the body compensates so items appear below the header.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: basicDemo,
                ),
              ),
            ],
          ),

          // Tab 4: Expanding header
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'SliverAppBar with expandedHeight: 200 and FlexibleSpaceBar. '
                  'As you scroll, the header collapses and the absorber '
                  'dynamically updates the overlap measurement.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: expandingDemo,
                ),
              ),
            ],
          ),

          // Tab 5: Pinned header behaviors
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Different SliverAppBar modes affect how the absorber '
                  'measures overlap. Scroll to see the behavior with a '
                  'pinned, expanding header.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: pinnedDemo,
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
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Compare what happens when NestedScrollView content '
                  'does not have overlap compensation versus when it does.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...comparisonWidgets,
              sideBySide,
            ],
          ),

          // Tab 7: Architecture
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.indigo.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How SliverOverlapAbsorber fits into the NestedScrollView '
                  'architecture, from outer scroll view down to inner lists.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...archWidgets,
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
                      Colors.indigo.withOpacity(0.12),
                      Colors.blue.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key points about SliverOverlapAbsorber and its role '
                  'in NestedScrollView overlap compensation.',
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
