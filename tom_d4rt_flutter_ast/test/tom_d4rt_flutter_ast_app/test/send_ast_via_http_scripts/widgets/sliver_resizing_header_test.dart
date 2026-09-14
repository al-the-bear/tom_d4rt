// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverResizingHeader
// Demonstrates SliverResizingHeader — a sliver that smoothly resizes its child
// between a minimum and maximum extent as the user scrolls. Simpler than
// SliverPersistentHeader because it does not require a delegate class — you
// just provide a child widget and the framework handles the sizing.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverResizingHeader Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.height,
      'title': 'What Is SliverResizingHeader?',
      'body': 'SliverResizingHeader is a sliver that displays a single child '
          'widget which smoothly resizes between a minimum and maximum extent '
          'as the user scrolls. Unlike SliverPersistentHeader, it does not '
          'require a delegate — you just provide a child widget directly.',
      'accent': Colors.pink,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Simpler Than SliverPersistentHeader',
      'body': 'SliverPersistentHeader requires you to subclass '
          'SliverPersistentHeaderDelegate and override build(), minExtent, '
          'and maxExtent. SliverResizingHeader removes that boilerplate: '
          'pass a child and the extents are computed from the child itself.',
      'accent': Colors.indigo,
    },
    {
      'icon': Icons.animation,
      'title': 'Smooth Resizing',
      'body': 'As the user scrolls, the header smoothly shrinks from its '
          'natural size (max extent) to its minimum extent. The child is '
          'given the current available extent via layout constraints. '
          'The transition is continuous, not stepped.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.push_pin,
      'title': 'Pinning Behavior',
      'body': 'SliverResizingHeader always pins at the top of the viewport '
          'at its minimum extent. It never scrolls completely off-screen. '
          'This makes it ideal for collapsible headers that should always '
          'remain partially visible.',
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
      'param': 'child',
      'type': 'Widget',
      'desc': 'Required. The widget displayed in the header. It will be sized '
          'between its intrinsic min/max extents as the user scrolls. '
          'The child should be able to handle varying constraints.',
    },
    {
      'param': 'key',
      'type': 'Key?',
      'desc': 'Optional widget key for identification.',
    },
  ];

  final constructorNote = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.amber.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.amber.withOpacity(0.25)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, color: Colors.amber.shade700, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            'The min/max extents are determined by the child itself, not '
            'by explicit parameters. The child is first measured with '
            'unconstrained height to get the max extent, then with zero '
            'height to get the min extent. The header transitions between '
            'these two values as the user scrolls.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );

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
              ? Colors.pink.withOpacity(0.06)
              : Colors.grey.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.pink.withOpacity(0.15)),
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
                    color: Colors.pink.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    row['param']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.pink,
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

  // ============================================================
  // SECTION 3: Basic resizing header
  // ============================================================
  print('=== Section 3: Basic ===');

  final basicDemo = SizedBox(
    height: 450,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverResizingHeader(
          child: Container(
            color: Colors.pink.shade600,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.dashboard, color: Colors.white, size: 32),
                const SizedBox(height: 8),
                const Text(
                  'My Dashboard',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Scroll down to see this header shrink',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext ctx, int index) {
              final icons = [
                Icons.inbox,
                Icons.star,
                Icons.send,
                Icons.drafts,
                Icons.delete,
                Icons.label,
                Icons.folder,
                Icons.archive,
              ];
              return ListTile(
                leading: Icon(
                  icons[index % icons.length],
                  color: Colors.pink.shade300,
                ),
                title: Text('Dashboard item ${index + 1}'),
                subtitle: Text('Category ${(index % 4) + 1}'),
                trailing: const Icon(Icons.chevron_right),
              );
            },
            childCount: 25,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Styled resizing header
  // ============================================================
  print('=== Section 4: Styled ===');

  final styledDemo = SizedBox(
    height: 460,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverResizingHeader(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink.shade800, Colors.purple.shade600],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.music_note,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Now Playing',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Your favorite tracks',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '42 tracks in queue',
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext ctx, int index) {
              final tracks = [
                'Midnight Serenade',
                'Crystal Waves',
                'Electric Dreams',
                'Sunset Boulevard',
                'Ocean Breeze',
                'Mountain Echo',
                'City Lights',
                'Dancing Stars',
                'Velvet Moon',
                'Golden Hour',
              ];
              final artists = [
                'Luna',
                'Cascade',
                'Neon',
                'Azure',
                'Coral',
              ];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.pink.shade100,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: Colors.pink.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(tracks[index % tracks.length]),
                subtitle: Text(artists[index % artists.length]),
                trailing: Icon(Icons.play_circle_fill, color: Colors.pink.shade300),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Multiple resizing headers
  // ============================================================
  print('=== Section 5: Multi-header ===');

  final sectionData = <Map<String, dynamic>>[
    {
      'title': 'Recent',
      'icon': Icons.history,
      'color': Colors.pink,
      'items': ['Project Alpha', 'Design mockups', 'Budget spreadsheet'],
    },
    {
      'title': 'Starred',
      'icon': Icons.star,
      'color': Colors.amber,
      'items': ['Architecture doc', 'Team roster', 'Sprint plan'],
    },
    {
      'title': 'Shared With Me',
      'icon': Icons.people,
      'color': Colors.blue,
      'items': ['Q4 Report', 'Brand guidelines', 'Roadmap 2026'],
    },
  ];

  final multiSlices = <Widget>[];
  for (var s = 0; s < sectionData.length; s++) {
    final sec = sectionData[s];
    final sColor = sec['color'] as Color;
    final items = sec['items'] as List<String>;
    print('Multi-header section ${s + 1}: ${sec['title']}');

    multiSlices.add(
      SliverResizingHeader(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: sColor.withOpacity(0.1),
            border: Border(
              bottom: BorderSide(color: sColor.withOpacity(0.3)),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Icon(sec['icon'] as IconData, color: sColor, size: 24),
              const SizedBox(width: 10),
              Text(
                sec['title'] as String,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: sColor,
                ),
              ),
              const Spacer(),
              Text(
                '${items.length} files',
                style: TextStyle(
                  fontSize: 12,
                  color: sColor.withOpacity(0.7),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    multiSlices.add(
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext ctx, int index) {
            return ListTile(
              leading: Icon(Icons.insert_drive_file, color: sColor.withOpacity(0.6)),
              title: Text(items[index]),
              trailing: const Icon(Icons.more_vert, size: 18),
            );
          },
          childCount: items.length,
        ),
      ),
    );
  }

  final multiHeaderDemo = SizedBox(
    height: 440,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: const Text('My Files'),
          backgroundColor: Colors.pink.shade700,
          pinned: true,
        ),
        ...multiSlices,
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Comparison
  // ============================================================
  print('=== Section 6: Comparison ===');

  final comparisons = <Map<String, dynamic>>[
    {
      'name': 'SliverAppBar',
      'icon': Icons.web_asset,
      'color': Colors.blue,
      'simplicity': 'Medium — many parameters but no delegate',
      'flex': 'High — flexible space, actions, stretching',
      'pinning': 'Configurable (pinned, floating, snap)',
      'use': 'App bars with actions, search, flexible content',
    },
    {
      'name': 'SliverPersistentHeader',
      'icon': Icons.extension,
      'color': Colors.green,
      'simplicity': 'Low — requires a delegate subclass',
      'flex': 'Full — complete control over build/extent',
      'pinning': 'Configurable (pinned or not)',
      'use': 'Full custom headers with animation logic',
    },
    {
      'name': 'SliverResizingHeader',
      'icon': Icons.height,
      'color': Colors.pink,
      'simplicity': 'High — just pass a child widget',
      'flex': 'Medium — child controls min/max via intrinsic size',
      'pinning': 'Always pinned at minimum extent',
      'use': 'Simple collapsible headers without a delegate',
    },
  ];

  final comparisonCards = <Widget>[];
  for (var i = 0; i < comparisons.length; i++) {
    final comp = comparisons[i];
    final cColor = comp['color'] as Color;
    print('Comparison ${i + 1}: ${comp['name']}');
    comparisonCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: cColor.withOpacity(0.3),
            width: comp['name'] == 'SliverResizingHeader' ? 2 : 1,
          ),
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
                  Icon(comp['icon'] as IconData, color: cColor, size: 22),
                  const SizedBox(width: 10),
                  Text(
                    comp['name'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: cColor,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                children: [
                  _srhRefRow('Simplicity', comp['simplicity'] as String, cColor),
                  _srhRefRow('Flexibility', comp['flex'] as String, cColor),
                  _srhRefRow('Pinning', comp['pinning'] as String, cColor),
                  _srhRefRow('Use when', comp['use'] as String, cColor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: Behavior details
  // ============================================================
  print('=== Section 7: Behavior ===');

  final behaviorNotes = <Map<String, dynamic>>[
    {
      'title': 'Child-Driven Extents',
      'body': 'The min and max extents are derived from the child itself. '
          'The child is laid out once with unbounded constraints to find '
          'its natural (max) size, and once with zero height to find its '
          'minimum size. These become the resize bounds.',
      'icon': Icons.child_care,
      'color': Colors.pink,
    },
    {
      'title': 'Always Pinned',
      'body': 'Unlike SliverPersistentHeader (where pinning is optional), '
          'SliverResizingHeader always pins. It stays at the top of the '
          'viewport at its minimum extent as the user scrolls further.',
      'icon': Icons.push_pin,
      'color': Colors.orange,
    },
    {
      'title': 'Smooth Transition',
      'body': 'As the user scrolls, the header linearly interpolates '
          'between min and max extent. There is no snap or overshoot — '
          'just a continuous resize proportional to scroll offset. This '
          'gives a clean, predictable animation.',
      'icon': Icons.animation,
      'color': Colors.blue,
    },
    {
      'title': 'Layout Rebuild',
      'body': 'The child is re-laid-out when the available extent changes '
          'during scrolling. If the child uses its constraints (e.g., '
          'ConstrainedBox or Flexible), it will smoothly adapt its layout '
          'as the header resizes.',
      'icon': Icons.refresh,
      'color': Colors.green,
    },
    {
      'title': 'No Stretch Support',
      'body': 'SliverResizingHeader does not support the overscroll stretch '
          'effect that SliverAppBar provides via stretchModes. If you need '
          'the header to grow beyond its max extent on overscroll, use '
          'SliverAppBar instead.',
      'icon': Icons.do_not_disturb,
      'color': Colors.red,
    },
  ];

  final behaviorWidgets = <Widget>[];
  for (var i = 0; i < behaviorNotes.length; i++) {
    final note = behaviorNotes[i];
    final nColor = note['color'] as Color;
    print('Behavior ${i + 1}: ${note['title']}');
    behaviorWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: nColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: nColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: nColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(note['icon'] as IconData, color: nColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note['title'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: nColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    note['body'] as String,
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
      'icon': Icons.height,
      'text': 'SliverResizingHeader smoothly resizes its child between '
          'min and max extents as the user scrolls.',
    },
    {
      'icon': Icons.child_care,
      'text': 'Min/max extents are derived from the child widget itself — '
          'no explicit pixel values or delegate needed.',
    },
    {
      'icon': Icons.push_pin,
      'text': 'Always pins at the top of the viewport at its minimum '
          'extent; cannot be configured to not pin.',
    },
    {
      'icon': Icons.compare,
      'text': 'Simpler than SliverPersistentHeader (no delegate) and less '
          'feature-rich than SliverAppBar (no stretch, actions, etc.).',
    },
    {
      'icon': Icons.layers,
      'text': 'Multiple SliverResizingHeaders can coexist in one '
          'CustomScrollView, each pinning independently.',
    },
    {
      'icon': Icons.animation,
      'text': 'Resizing is continuous and proportional to scroll offset, '
          'giving a smooth, predictable visual effect.',
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
          color: Colors.pink.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.pink.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.pink.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.pink.shade700,
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
        title: const Text('SliverResizingHeader'),
        backgroundColor: Colors.pink.shade700,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.construction), text: 'Constructor'),
            Tab(icon: Icon(Icons.list), text: 'Basic'),
            Tab(icon: Icon(Icons.palette), text: 'Styled'),
            Tab(icon: Icon(Icons.layers), text: 'Multi'),
            Tab(icon: Icon(Icons.compare), text: 'Comparison'),
            Tab(icon: Icon(Icons.psychology), text: 'Behavior'),
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
                  color: Colors.pink.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'SliverResizingHeader is the simplest way to add a '
                  'collapsible, pinned header to a CustomScrollView. '
                  'Just pass a child — no delegate boilerplate needed.',
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
                  color: Colors.pink.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'One required parameter: child. The extents are derived '
                  'from the child widget automatically.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              constructorNote,
              ...constructorWidgets,
            ],
          ),

          // Tab 3: Basic
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.pink.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'A simple dashboard header that shrinks as the user '
                  'scrolls through the list items below it.',
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

          // Tab 4: Styled
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.pink.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'A music player header with gradient background, icon, '
                  'title, subtitle, and track count badge. Shows how any '
                  'complex child can be used with SliverResizingHeader.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: styledDemo,
                ),
              ),
            ],
          ),

          // Tab 5: Multi-header
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.pink.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Multiple SliverResizingHeaders as section headers in a '
                  'file manager. Each section has its own pinned header.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: multiHeaderDemo,
                ),
              ),
            ],
          ),

          // Tab 6: Comparison
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.pink.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'How SliverResizingHeader compares to other header slivers:',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...comparisonCards,
            ],
          ),

          // Tab 7: Behavior
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.pink.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Details on how SliverResizingHeader determines its '
                  'extents and behaves during scrolling.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...behaviorWidgets,
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
                      Colors.pink.withOpacity(0.12),
                      Colors.purple.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key points about SliverResizingHeader.',
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

// ============================================================
// HELPER: Reference row for comparison table
// ============================================================
Widget _srhRefRow(String label, String value, Color accent) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: accent,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
          ),
        ),
      ],
    ),
  );
}
