// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — Viewport
// Demonstrates Viewport, the core rendering widget that displays a subset
// of its children based on a scroll offset. Covers slivers, layout protocol,
// cacheExtent, axis direction, anchor, and the rendering pipeline.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Viewport Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.crop_free,
      'title': 'What is Viewport?',
      'body': 'Viewport is a render object widget that displays a '
          'subset of its children in a scrollable region. Only '
          'the visible portion plus a cache extent is laid out '
          'and painted. It is the core of ListView, GridView, '
          'CustomScrollView and every scrollable in Flutter.',
      'accent': Colors.brown,
    },
    {
      'icon': Icons.view_list,
      'title': 'Sliver Protocol',
      'body': 'Viewport\u0027s children are not regular widgets — they '
          'are slivers. Slivers use a special layout protocol '
          '(SliverConstraints / SliverGeometry) optimized for '
          'lazy, scroll-aware layout. Each sliver reports how '
          'much space it consumed and how much it can scroll.',
      'accent': Colors.blue,
    },
    {
      'icon': Icons.memory,
      'title': 'Efficient Rendering',
      'body': 'The viewport only builds, lays out, and paints slivers '
          'that are visible or within the cacheExtent. Off-screen '
          'slivers are garbage collected. This makes lists of '
          'thousands of items performant.',
      'accent': Colors.green,
    },
    {
      'icon': Icons.swap_vert,
      'title': 'Scroll Offset',
      'body': 'The viewport receives its current scroll position from '
          'a ViewportOffset (usually a ScrollPosition). As the '
          'user scrolls, the offset changes and the viewport '
          're-lays out slivers that enter or leave the visible '
          'area.',
      'accent': Colors.orange,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptItems.length; i++) {
    final c = conceptItems[i];
    final accent = c['accent'] as Color;
    print('Concept ${i + 1}: ${c['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.12), accent.withOpacity(0.03)],
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
                child: Icon(c['icon'] as IconData, color: accent, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title'] as String,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      c['body'] as String,
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
  // SECTION 2: API
  // ============================================================
  print('=== Section 2: API ===');

  final apiEntries = <Map<String, String>>[
    {
      'name': 'axisDirection',
      'type': 'AxisDirection',
      'desc': 'The direction in which slivers are laid out. Typically '
          'AxisDirection.down for vertical scrolling or '
          'AxisDirection.right for horizontal.',
    },
    {
      'name': 'offset',
      'type': 'ViewportOffset',
      'desc': 'The scroll position that determines which portion of '
          'the sliver list is visible. Usually comes from a '
          'ScrollController\u0027s ScrollPosition.',
    },
    {
      'name': 'anchor',
      'type': 'double',
      'desc': 'A value between 0.0 and 1.0 that determines where the '
          'zero scroll offset sits. 0.0 means the start, 0.5 '
          'means the center, 1.0 means the end of the viewport.',
    },
    {
      'name': 'center',
      'type': 'Key?',
      'desc': 'The key of the sliver that sits at the anchor point '
          'when the scroll offset is zero. Slivers before center '
          'grow in the reverse direction.',
    },
    {
      'name': 'cacheExtent',
      'type': 'double?',
      'desc': 'The distance beyond the visible area for which slivers '
          'are pre-built. Defaults to 250 logical pixels. Larger '
          'values reduce jank but increase memory use.',
    },
    {
      'name': 'cacheExtentStyle',
      'type': 'CacheExtentStyle',
      'desc': 'Whether cacheExtent is measured in pixels or as a '
          'viewport fraction. Default is pixel-based.',
    },
    {
      'name': 'slivers',
      'type': 'List<Widget>',
      'desc': 'The sliver children inside the viewport. Each must be '
          'a RenderSliver (SliverList, SliverGrid, SliverAppBar, '
          'SliverToBoxAdapter, etc.).',
    },
    {
      'name': 'clipBehavior',
      'type': 'Clip',
      'desc': 'How to clip content that overflows the viewport bounds. '
          'Defaults to Clip.hardEdge. Use Clip.none for debugging.',
    },
  ];

  final apiWidgets = <Widget>[];
  for (var i = 0; i < apiEntries.length; i++) {
    final ae = apiEntries[i];
    print('API ${i + 1}: ${ae['name']}');
    apiWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.brown.withOpacity(0.06)
              : Colors.grey.withOpacity(0.03),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.brown.withOpacity(0.25)),
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
                    color: Colors.brown.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    ae['name']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.brown.shade800,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    ae['type']!,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 10,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              ae['desc']!,
              style: TextStyle(
                fontSize: 12,
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
  // SECTION 3: Layout Protocol
  // ============================================================
  print('=== Section 3: Layout ===');

  final layoutSteps = <Map<String, dynamic>>[
    {
      'step': '1. Receive Constraints',
      'desc': 'The viewport receives BoxConstraints from its parent. '
          'It uses these to determine its own size (the visible '
          'scrollable area).',
      'icon': Icons.settings_overscan,
      'color': Colors.brown,
    },
    {
      'step': '2. Create SliverConstraints',
      'desc': 'For each sliver child, the viewport creates '
          'SliverConstraints with: scrollOffset, remainingPaintExtent, '
          'crossAxisExtent, overlap, and cacheExtent.',
      'icon': Icons.rule,
      'color': Colors.blue,
    },
    {
      'step': '3. Layout Slivers',
      'desc': 'Slivers are laid out in order. Each returns '
          'SliverGeometry with: scrollExtent (total size), '
          'paintExtent (visible portion), layoutExtent, '
          'maxPaintExtent, and cacheExtent consumed.',
      'icon': Icons.view_column,
      'color': Colors.green,
    },
    {
      'step': '4. Accumulate Offsets',
      'desc': 'The viewport tracks remaining paint extent. After each '
          'sliver\u0027s paintExtent, remaining is reduced. When '
          'remaining hits zero, further slivers get zero paint '
          'extent (off-screen).',
      'icon': Icons.add,
      'color': Colors.orange,
    },
    {
      'step': '5. Report to Offset',
      'desc': 'The viewport reports total scrollExtent and viewport '
          'dimension to the ViewportOffset. This allows the '
          'scroll position to know min/max scroll range.',
      'icon': Icons.straighten,
      'color': Colors.red,
    },
    {
      'step': '6. Paint Visible',
      'desc': 'During paint, only slivers with non-zero paintExtent '
          'are painted. They are clipped to the viewport bounds '
          'based on clipBehavior.',
      'icon': Icons.brush,
      'color': Colors.purple,
    },
  ];

  final layoutWidgets = <Widget>[];
  for (var i = 0; i < layoutSteps.length; i++) {
    final ls = layoutSteps[i];
    final lsColor = ls['color'] as Color;
    print('Layout ${i + 1}: ${ls['step']}');
    layoutWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    color: lsColor.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    ls['icon'] as IconData,
                    color: lsColor,
                    size: 18,
                  ),
                ),
                if (i < layoutSteps.length - 1)
                  Container(
                    width: 2,
                    height: 24,
                    color: lsColor.withOpacity(0.2),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: lsColor.withOpacity(0.04),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: lsColor.withOpacity(0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ls['step'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: lsColor,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      ls['desc'] as String,
                      style: TextStyle(
                        fontSize: 11,
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
  // SECTION 4: Slivers
  // ============================================================
  print('=== Section 4: Slivers ===');

  final sliverTypes = <Map<String, dynamic>>[
    {
      'name': 'SliverList',
      'desc': 'A sliver that places children in a linear list along '
          'the main axis. Supports delegates for lazy building.',
      'icon': Icons.list,
      'color': Colors.brown,
    },
    {
      'name': 'SliverGrid',
      'desc': 'A sliver that places children in a 2D grid. Uses grid '
          'delegates to determine column count and aspect ratio.',
      'icon': Icons.grid_view,
      'color': Colors.blue,
    },
    {
      'name': 'SliverAppBar',
      'desc': 'A Material Design app bar that integrates with '
          'CustomScrollView. Supports floating, pinned, and snap '
          'behaviors.',
      'icon': Icons.web_asset,
      'color': Colors.green,
    },
    {
      'name': 'SliverToBoxAdapter',
      'desc': 'Wraps a regular box widget as a sliver. Use for fixed '
          'headers, banners, or any non-scrollable content inside '
          'a CustomScrollView.',
      'icon': Icons.transform,
      'color': Colors.orange,
    },
    {
      'name': 'SliverFillRemaining',
      'desc': 'A sliver that fills the remaining space in the viewport. '
          'Useful for making content expand to fill the screen.',
      'icon': Icons.fullscreen,
      'color': Colors.red,
    },
    {
      'name': 'SliverPersistentHeader',
      'desc': 'A sliver with a header that shrinks/grows as the user '
          'scrolls. Can be pinned to stay visible or floating.',
      'icon': Icons.vertical_align_top,
      'color': Colors.purple,
    },
  ];

  final sliverWidgets = <Widget>[];
  for (var i = 0; i < sliverTypes.length; i++) {
    final st = sliverTypes[i];
    final stColor = st['color'] as Color;
    print('Sliver ${i + 1}: ${st['name']}');
    sliverWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: stColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: stColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: stColor.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(st['icon'] as IconData, color: stColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    st['name'] as String,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: stColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    st['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade700,
                      height: 1.35,
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
  // SECTION 5: Anchor & Center
  // ============================================================
  print('=== Section 5: Anchor ===');

  final anchorDemos = <Map<String, dynamic>>[
    {
      'anchor': 0.0,
      'center': 'None',
      'desc': 'Default. Zero scroll offset is at the start edge. All '
          'slivers grow downward (or rightward). Standard '
          'scrolling behavior.',
      'diagram': '[ Start ]\n'
          '  sliver0\n'
          '  sliver1\n'
          '  sliver2\n'
          '  ... (scroll down)',
      'color': Colors.brown,
    },
    {
      'anchor': 0.5,
      'center': 'Key(center)',
      'desc': 'Zero scroll offset is in the middle. The center sliver '
          'sits at 50% of the viewport. Slivers before it grow '
          'upward (reverse), slivers after grow downward.',
      'diagram': '  ... (scroll up)\n'
          '  sliver_before_2\n'
          '  sliver_before_1\n'
          '[ Center sliver at 50% ]\n'
          '  sliver_after_1\n'
          '  sliver_after_2\n'
          '  ... (scroll down)',
      'color': Colors.blue,
    },
    {
      'anchor': 1.0,
      'center': 'Key(center)',
      'desc': 'Zero scroll offset at the end. Content grows upward. '
          'Used for chat-like interfaces where new content '
          'appears at the bottom.',
      'diagram': '  ... (scroll up)\n'
          '  sliver2\n'
          '  sliver1\n'
          '  sliver0\n'
          '[ End ]',
      'color': Colors.green,
    },
  ];

  final anchorWidgets = <Widget>[];
  for (var i = 0; i < anchorDemos.length; i++) {
    final ad = anchorDemos[i];
    final adColor = ad['color'] as Color;
    print('Anchor ${i + 1}: ${ad['anchor']}');
    anchorWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: adColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: adColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: adColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      'anchor: ${ad['anchor']}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: adColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'center: ${ad['center']}',
                      style: TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                ad['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ad['diagram'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFCDD6F4),
                    height: 1.5,
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
  // SECTION 6: CacheExtent
  // ============================================================
  print('=== Section 6: CacheExtent ===');

  final cacheRows = <Map<String, dynamic>>[
    {
      'value': 'Default (250px)',
      'desc': 'Slivers within 250 logical pixels of the visible area '
          'are built. Provides smooth scrolling for most cases.',
      'pros': 'Good balance of performance and smoothness.',
      'cons': 'May have brief jank on very fast scrolling.',
      'color': Colors.brown,
    },
    {
      'value': 'Large (1000px)',
      'desc': 'Pre-builds a larger area. Reduces jank when scrolling '
          'quickly through complex item widgets.',
      'pros': 'Very smooth scrolling, fewer rebuilds.',
      'cons': 'Higher memory usage, longer initial layout.',
      'color': Colors.blue,
    },
    {
      'value': 'Zero (0px)',
      'desc': 'Only the visible area is built. Items appear the '
          'instant they enter the viewport.',
      'pros': 'Minimum memory usage.',
      'cons': 'Visible pop-in, janky scrolling on complex items.',
      'color': Colors.orange,
    },
    {
      'value': 'Double.infinity',
      'desc': 'All slivers are always built. The viewport is not lazy. '
          'Only use for short lists where all items fit in memory.',
      'pros': 'No rebuilds, instant scroll to any position.',
      'cons': 'All items in memory. Defeats purpose of viewport.',
      'color': Colors.red,
    },
  ];

  final cacheWidgets = <Widget>[];
  for (var i = 0; i < cacheRows.length; i++) {
    final cr = cacheRows[i];
    final crColor = cr['color'] as Color;
    print('Cache ${i + 1}: ${cr['value']}');
    cacheWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: crColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: crColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: crColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  cr['value'] as String,
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: crColor,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                cr['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pros',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            cr['pros'] as String,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Cons',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Colors.red.shade700,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            cr['cons'] as String,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 7: CustomScrollView
  // ============================================================
  print('=== Section 7: CustomScrollView ===');

  final csvExamples = <Map<String, dynamic>>[
    {
      'title': 'Basic List',
      'desc': 'A CustomScrollView with a single SliverList. Equivalent '
          'to a basic ListView but using the sliver protocol.',
      'diagram': 'CustomScrollView(\n'
          '  slivers: [\n'
          '    SliverList(\n'
          '      delegate: SliverChildBuilderDelegate(\n'
          '        (ctx, i) => ListTile(title: Text("Item \$i")),\n'
          '        childCount: 100,\n'
          '      ),\n'
          '    ),\n'
          '  ],\n'
          ')',
      'color': Colors.brown,
    },
    {
      'title': 'AppBar + List + Grid',
      'desc': 'Combines multiple sliver types in one scrollable: a '
          'collapsing app bar, a list section, and a grid section.',
      'diagram': 'CustomScrollView(\n'
          '  slivers: [\n'
          '    SliverAppBar(\n'
          '      expandedHeight: 200,\n'
          '      floating: true,\n'
          '    ),\n'
          '    SliverList(...),\n'
          '    SliverGrid(...),\n'
          '  ],\n'
          ')',
      'color': Colors.blue,
    },
    {
      'title': 'Fill Remaining',
      'desc': 'A sliver that expands to fill all remaining space. '
          'Useful for "no results" messages that should center.',
      'diagram': 'CustomScrollView(\n'
          '  slivers: [\n'
          '    SliverAppBar(...),\n'
          '    SliverFillRemaining(\n'
          '      hasScrollBody: false,\n'
          '      child: Center(\n'
          '        child: Text("No items"),\n'
          '      ),\n'
          '    ),\n'
          '  ],\n'
          ')',
      'color': Colors.green,
    },
    {
      'title': 'Persistent Header',
      'desc': 'Section headers that stick to the top as the user '
          'scrolls past them. Classic "contact list" pattern.',
      'diagram': 'CustomScrollView(\n'
          '  slivers: [\n'
          '    SliverPersistentHeader(\n'
          '      pinned: true,\n'
          '      delegate: MySectionHeader("A"),\n'
          '    ),\n'
          '    SliverList(/* A items */),\n'
          '    SliverPersistentHeader(\n'
          '      pinned: true,\n'
          '      delegate: MySectionHeader("B"),\n'
          '    ),\n'
          '    SliverList(/* B items */),\n'
          '  ],\n'
          ')',
      'color': Colors.orange,
    },
  ];

  final csvWidgets = <Widget>[];
  for (var i = 0; i < csvExamples.length; i++) {
    final ce = csvExamples[i];
    final ceColor = ce['color'] as Color;
    print('CSV ${i + 1}: ${ce['title']}');
    csvWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: ceColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ceColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ce['title'] as String,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: ceColor,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                ce['desc'] as String,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade700,
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E2E),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  ce['diagram'] as String,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 10,
                    color: Color(0xFFCDD6F4),
                    height: 1.5,
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
      'icon': Icons.crop_free,
      'text': 'Viewport displays a subset of sliver children based on '
          'a scroll offset. It is the core of all scrollable widgets.',
    },
    {
      'icon': Icons.view_list,
      'text': 'Children use the sliver protocol (SliverConstraints / '
          'SliverGeometry), not box layout.',
    },
    {
      'icon': Icons.memory,
      'text': 'Only visible slivers plus cacheExtent are built. '
          'Off-screen slivers are garbage collected for efficiency.',
    },
    {
      'icon': Icons.anchor,
      'text': 'The anchor property controls where scroll offset zero '
          'sits. Combined with center for bidirectional scrolling.',
    },
    {
      'icon': Icons.speed,
      'text': 'cacheExtent trades memory for scroll smoothness. Default '
          '250px suits most cases; tune for your content.',
    },
    {
      'icon': Icons.dashboard_customize,
      'text': 'CustomScrollView wraps Viewport with ScrollController. '
          'Combine SliverList, SliverGrid, SliverAppBar freely.',
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
          color: Colors.brown.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.brown.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.brown.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.brown.shade800,
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
        title: const Text('Viewport'),
        backgroundColor: Colors.brown.shade700,
        foregroundColor: Colors.white,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.api), text: 'API'),
            Tab(icon: Icon(Icons.view_column), text: 'Layout'),
            Tab(icon: Icon(Icons.view_list), text: 'Slivers'),
            Tab(icon: Icon(Icons.anchor), text: 'Anchor'),
            Tab(icon: Icon(Icons.cached), text: 'Cache'),
            Tab(icon: Icon(Icons.dashboard), text: 'Scroll View'),
            Tab(icon: Icon(Icons.summarize), text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // Tab 1
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Viewport: the core rendering widget behind all '
                  'scrollable widgets in Flutter.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...conceptCards,
            ],
          ),
          // Tab 2
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Viewport constructor parameters and configuration.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...apiWidgets,
            ],
          ),
          // Tab 3
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'The viewport-to-sliver layout protocol, step by step.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...layoutWidgets,
            ],
          ),
          // Tab 4
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Common sliver types used inside viewports.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...sliverWidgets,
            ],
          ),
          // Tab 5
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Anchor and center for bidirectional scrolling.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...anchorWidgets,
            ],
          ),
          // Tab 6
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Cache extent: tuning the trade-off between memory '
                  'and scroll smoothness.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...cacheWidgets,
            ],
          ),
          // Tab 7
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.brown.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'CustomScrollView compositions using Viewport.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...csvWidgets,
            ],
          ),
          // Tab 8
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.brown.withOpacity(0.12),
                      Colors.brown.withOpacity(0.04),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key takeaways about Viewport.',
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
