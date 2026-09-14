// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — ShrinkWrappingViewport
// Demonstrates ShrinkWrappingViewport — a viewport that sizes itself to the
// total extent of its slivers along the main axis, rather than expanding to
// fill the parent's constraints. Essential for embedding scrollable content
// inside a Column or other non-scrollable parent.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ShrinkWrappingViewport Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.wrap_text,
      'title': 'Content-Sized Viewport',
      'body': 'ShrinkWrappingViewport measures the total extent of all its '
          'slivers and sizes itself to exactly that height (or width for '
          'horizontal). Unlike Viewport which fills all available space, '
          'ShrinkWrappingViewport only takes what it needs.',
    },
    {
      'icon': Icons.view_column,
      'title': 'Column-Friendly Scrolling',
      'body': 'When you need a scrollable region inside a Column without an '
          'explicit height constraint, ShrinkWrappingViewport is the answer. '
          'ListView sets shrinkWrap=true to use this viewport internally.',
    },
    {
      'icon': Icons.speed,
      'title': 'Performance Trade-off',
      'body': 'Because it must measure all children to know its own size, '
          'ShrinkWrappingViewport cannot perform lazy loading as efficiently '
          'as a regular Viewport. It lays out every visible sliver to compute '
          'the total main axis extent.',
    },
    {
      'icon': Icons.layers,
      'title': 'Low-Level Building Block',
      'body': 'Most developers use ListView(shrinkWrap: true) which creates '
          'a ShrinkWrappingViewport internally. Direct usage is for custom '
          'scroll views built with CustomScrollView or manual Scrollable '
          'compositions.',
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < conceptPoints.length; i++) {
    final p = conceptPoints[i];
    print('Concept ${i + 1}: ${p['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 10.0),
        padding: const EdgeInsets.all(14.0),
        decoration: BoxDecoration(
          color: Colors.cyan.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.cyan.withValues(alpha: 0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(p['icon'] as IconData, color: Colors.cyan.shade700, size: 26.0),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w700,
                        color: Colors.cyan.shade700),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    p['body'] as String,
                    style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.4),
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

  final constructorParams = <Map<String, String>>[
    {
      'name': 'offset',
      'type': 'ViewportOffset (required)',
      'desc': 'The scroll position that controls the offset of slivers within '
          'the viewport. Typically provided by a ScrollController or Scrollable.',
    },
    {
      'name': 'axisDirection',
      'type': 'AxisDirection',
      'desc': 'The direction in which slivers are laid out. Defaults to '
          'AxisDirection.down (vertical top-to-bottom).',
    },
    {
      'name': 'crossAxisDirection',
      'type': 'AxisDirection?',
      'desc': 'The direction perpendicular to the main axis. If not specified, '
          'inferred from axisDirection and text direction.',
    },
    {
      'name': 'slivers',
      'type': 'List<Widget>',
      'desc': 'The sliver children that will be laid out. All slivers must '
          'have a finite extent — infinite slivers will cause errors.',
    },
    {
      'name': 'clipBehavior',
      'type': 'Clip',
      'desc': 'Controls clipping of sliver content that overflows the '
          'viewport bounds. Defaults to Clip.hardEdge.',
    },
  ];

  final paramRows = <Widget>[];
  for (var i = 0; i < constructorParams.length; i++) {
    final p = constructorParams[i];
    print('  Param: ${p['name']} — ${p['type']}');
    paramRows.add(
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 14.0),
        decoration: BoxDecoration(
          color: i.isEven
              ? Colors.cyan.withValues(alpha: 0.03)
              : Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.cyan.withValues(alpha: 0.15)),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 130.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['name']!,
                    style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                        color: Colors.cyan.shade800,
                        fontFamily: 'monospace'),
                  ),
                  const SizedBox(height: 2.0),
                  Text(
                    p['type']!,
                    style: TextStyle(fontSize: 10.0, color: Colors.cyan.shade400,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                p['desc']!,
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.35),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 3: Comparison — Viewport vs ShrinkWrappingViewport
  // ============================================================
  print('=== Section 3: Comparison ===');

  // Helper to build a mini viewport sample
  Widget buildViewportSample({
    required String label,
    required String description,
    required Color color,
    required double containerHeight,
    required int itemCount,
    required bool shrinkWrap,
  }) {
    final items = List.generate(itemCount, (i) {
      return Container(
        height: 36.0,
        margin: const EdgeInsets.only(bottom: 4.0),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.15 + (i * 0.08)),
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        alignment: Alignment.center,
        child: Text(
          'Item ${i + 1}',
          style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: color),
        ),
      );
    });

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8.0)),
            ),
            child: Column(
              children: [
                Text(label, style: TextStyle(fontSize: 12.0,
                    fontWeight: FontWeight.w700, color: color)),
                const SizedBox(height: 2.0),
                Text(description, style: TextStyle(fontSize: 10.0,
                    color: color.withValues(alpha: 0.7)),
                    textAlign: TextAlign.center),
              ],
            ),
          ),
          Container(
            height: containerHeight,
            decoration: BoxDecoration(
              border: Border.all(color: color.withValues(alpha: 0.25)),
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8.0)),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(6.0),
            child: ListView(
              shrinkWrap: shrinkWrap,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              children: items,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            shrinkWrap
                ? 'Height: content-sized\n(${itemCount * 40} px estimate)'
                : 'Height: fills ${containerHeight.toInt()} px\ncontainer',
            style: TextStyle(fontSize: 10.0, color: color.withValues(alpha: 0.6)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  print('  Building viewport comparison visuals');

  // ============================================================
  // SECTION 4: Axis Direction
  // ============================================================
  print('=== Section 4: Axis Direction ===');

  final axisDirections = <Map<String, dynamic>>[
    {
      'direction': 'AxisDirection.down',
      'icon': Icons.arrow_downward,
      'desc': 'Default: slivers flow from top to bottom.',
      'color': Colors.cyan.shade600,
      'isVertical': true,
    },
    {
      'direction': 'AxisDirection.up',
      'icon': Icons.arrow_upward,
      'desc': 'Reversed: slivers flow from bottom to top.',
      'color': Colors.teal.shade600,
      'isVertical': true,
    },
    {
      'direction': 'AxisDirection.right',
      'icon': Icons.arrow_forward,
      'desc': 'Horizontal: slivers flow left to right.',
      'color': Colors.blue.shade600,
      'isVertical': false,
    },
    {
      'direction': 'AxisDirection.left',
      'icon': Icons.arrow_back,
      'desc': 'Reversed horizontal: slivers right to left.',
      'color': Colors.indigo.shade600,
      'isVertical': false,
    },
  ];

  final axisCards = <Widget>[];
  for (var i = 0; i < axisDirections.length; i++) {
    final a = axisDirections[i];
    print('  Direction: ${a['direction']}');

    final bool isVert = a['isVertical'] as bool;
    final miniItems = List.generate(3, (j) {
      return Container(
        width: isVert ? double.infinity : 50.0,
        height: isVert ? 24.0 : double.infinity,
        margin: EdgeInsets.only(
          bottom: isVert ? 3.0 : 0.0,
          right: isVert ? 0.0 : 3.0,
        ),
        decoration: BoxDecoration(
          color: (a['color'] as Color).withValues(alpha: 0.15 + (j * 0.15)),
          borderRadius: BorderRadius.circular(4.0),
        ),
        alignment: Alignment.center,
        child: Text('${j + 1}', style: TextStyle(fontSize: 10.0, color: a['color'] as Color,
            fontWeight: FontWeight.bold)),
      );
    });

    axisCards.add(
      Container(
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: (a['color'] as Color).withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: (a['color'] as Color).withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Icon(a['icon'] as IconData, color: a['color'] as Color, size: 22.0),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    a['direction'] as String,
                    style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w700,
                        fontFamily: 'monospace', color: a['color'] as Color),
                  ),
                  const SizedBox(height: 2.0),
                  Text(a['desc'] as String,
                      style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700)),
                ],
              ),
            ),
            const SizedBox(width: 8.0),
            Container(
              width: isVert ? 60.0 : 170.0,
              height: isVert ? 84.0 : 36.0,
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: (a['color'] as Color).withValues(alpha: 0.25)),
              ),
              child: isVert
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: miniItems,
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: miniItems,
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // SECTION 5: Live Demo — Interactive sliver count
  // ============================================================
  print('=== Section 5: Live Demo ===');

  // ============================================================
  // SECTION 6: Nesting in Column
  // ============================================================
  print('=== Section 6: Nesting in Column ===');

  final nestingSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'Column with fixed header',
      'code': 'Column(\n  children: [\n    HeaderWidget(),\n    ...',
      'icon': Icons.view_agenda,
    },
    {
      'step': 2,
      'title': 'Expanded vs shrinkWrap ListView',
      'code': 'Expanded(\n  child: ListView(...)\n)',
      'icon': Icons.expand,
    },
    {
      'step': 3,
      'title': 'ShrinkWrapping for nested scroll',
      'code': 'ListView(\n  shrinkWrap: true,\n  physics: NeverScroll...\n)',
      'icon': Icons.wrap_text,
    },
    {
      'step': 4,
      'title': 'Footer after scrollable',
      'code': '    ...\n    FooterWidget(),\n  ],\n)',
      'icon': Icons.vertical_align_bottom,
    },
  ];

  final stepWidgets = <Widget>[];
  for (var i = 0; i < nestingSteps.length; i++) {
    final s = nestingSteps[i];
    print('  Nesting step ${s['step']}: ${s['title']}');
    stepWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32.0,
              height: 32.0,
              decoration: BoxDecoration(
                color: Colors.cyan.shade600,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text('${s['step']}',
                  style: const TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(s['icon'] as IconData, size: 16.0,
                          color: Colors.cyan.shade600),
                      const SizedBox(width: 6.0),
                      Text(s['title'] as String,
                          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600,
                              color: Colors.cyan.shade700)),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      s['code'] as String,
                      style: TextStyle(fontSize: 11.0, fontFamily: 'monospace',
                          color: Colors.grey.shade800, height: 1.3),
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

  // Build actual nested demo visual
  Widget buildNestedColumnDemo() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.cyan.withValues(alpha: 0.3)),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12.0),
            color: Colors.cyan.shade600,
            child: const Row(
              children: [
                Icon(Icons.menu, color: Colors.white, size: 20.0),
                SizedBox(width: 8.0),
                Text('App Header', style: TextStyle(color: Colors.white,
                    fontSize: 13.0, fontWeight: FontWeight.w600)),
                Spacer(),
                Icon(Icons.search, color: Colors.white, size: 20.0),
              ],
            ),
          ),
          // ShrinkWrap list
          Container(
            color: Colors.cyan.withValues(alpha: 0.03),
            child: ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8.0),
              children: List.generate(4, (i) {
                return Container(
                  height: 40.0,
                  margin: const EdgeInsets.only(bottom: 4.0),
                  decoration: BoxDecoration(
                    color: Colors.cyan.withValues(alpha: 0.08 + (i * 0.06)),
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(color: Colors.cyan.withValues(alpha: 0.2)),
                  ),
                  alignment: Alignment.center,
                  child: Text('List Item ${i + 1}',
                      style: TextStyle(fontSize: 11.5,
                          color: Colors.cyan.shade700, fontWeight: FontWeight.w500)),
                );
              }),
            ),
          ),
          // Footer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            color: Colors.cyan.shade50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, color: Colors.cyan.shade600, size: 16.0),
                const SizedBox(width: 6.0),
                Text('Footer — always visible below list',
                    style: TextStyle(fontSize: 11.0, color: Colors.cyan.shade600,
                        fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SECTION 7: Caveats & Limitations
  // ============================================================
  print('=== Section 7: Caveats ===');

  final caveats = <Map<String, dynamic>>[
    {
      'icon': Icons.warning_amber,
      'title': 'No Infinite Slivers',
      'body': 'Every sliver inside a ShrinkWrappingViewport must have a finite '
          'extent. Using SliverFillRemaining or infinite SliverLists will '
          'cause assertion errors.',
      'severity': 'error',
    },
    {
      'icon': Icons.speed,
      'title': 'Performance with Many Items',
      'body': 'All visible slivers are laid out to compute the total extent. '
          'With thousands of children, this eliminates the lazy-loading '
          'advantage of regular Viewports.',
      'severity': 'warning',
    },
    {
      'icon': Icons.layers_clear,
      'title': 'No Slivers That Fill Remaining Space',
      'body': 'SliverFillRemaining is incompatible because it would create a '
          'circular dependency — it needs to know remaining space, but the '
          'viewport size depends on all slivers.',
      'severity': 'error',
    },
    {
      'icon': Icons.swap_vert,
      'title': 'Scroll Offset Handling',
      'body': 'When offset is non-zero, ShrinkWrappingViewport still reports '
          'its full intrinsic height. It does not shrink as the user scrolls '
          'past the beginning of the content.',
      'severity': 'info',
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Nested Scrolling',
      'body': 'Using shrinkWrap in nested scroll views disables the inner '
          'viewport\'s scroll physics. Always pair with '
          'NeverScrollableScrollPhysics() to prevent conflicts.',
      'severity': 'warning',
    },
  ];

  final caveatWidgets = <Widget>[];
  for (var i = 0; i < caveats.length; i++) {
    final c = caveats[i];
    final String severity = c['severity'] as String;
    final Color severityColor = severity == 'error'
        ? Colors.red.shade600
        : severity == 'warning'
            ? Colors.orange.shade600
            : Colors.blue.shade600;
    print('  Caveat: ${c['title']} ($severity)');

    caveatWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: severityColor.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: severityColor.withValues(alpha: 0.25)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(c['icon'] as IconData, color: severityColor, size: 22.0),
            const SizedBox(width: 10.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(c['title'] as String,
                            style: TextStyle(fontSize: 12.5,
                                fontWeight: FontWeight.w700, color: severityColor)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: severityColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(severity.toUpperCase(),
                            style: TextStyle(fontSize: 9.0, fontWeight: FontWeight.bold,
                                color: severityColor)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Text(c['body'] as String,
                      style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700,
                          height: 1.35)),
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

  final summaryItems = <Map<String, dynamic>>[
    {'icon': Icons.wrap_text, 'text': 'ShrinkWrappingViewport sizes itself '
        'to the total extent of its slivers'},
    {'icon': Icons.view_column, 'text': 'Enables scrollable lists in Column/'
        'Row without explicit height constraints'},
    {'icon': Icons.warning, 'text': 'All slivers must have finite extent — '
        'no SliverFillRemaining allowed'},
    {'icon': Icons.speed, 'text': 'Less efficient than Viewport for large '
        'data sets due to measuring all children'},
    {'icon': Icons.auto_fix_high, 'text': 'ListView(shrinkWrap: true) uses '
        'ShrinkWrappingViewport internally'},
    {'icon': Icons.swap_vert, 'text': 'Pair with NeverScrollableScrollPhysics '
        'when nesting inside another scroll view'},
  ];

  final summaryBullets = <Widget>[];
  for (var i = 0; i < summaryItems.length; i++) {
    final s = summaryItems[i];
    print('Summary: ${s['text']}');
    summaryBullets.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(s['icon'] as IconData, size: 18.0, color: Colors.cyan.shade600),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(s['text'] as String,
                  style: TextStyle(fontSize: 12.5, color: Colors.grey.shade800, height: 1.35)),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // Build helper
  // ============================================================
  Widget buildSWVBullet(IconData icon, String text, {Color? color}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16.0, color: color ?? Colors.cyan.shade600),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(text,
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.3)),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // LIVE DEMO WIDGET
  // ============================================================

  print('Building live demo stateful widget');

  return DefaultTabController(
    length: 8,
    child: Scaffold(
      appBar: AppBar(
        title: const Text('ShrinkWrappingViewport Deep Demo'),
        backgroundColor: Colors.cyan.shade600,
        foregroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          labelStyle: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600),
          unselectedLabelStyle: const TextStyle(fontSize: 11.0),
          tabs: const [
            Tab(text: 'Concept'),
            Tab(text: 'Constructor'),
            Tab(text: 'Comparison'),
            Tab(text: 'Direction'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Nesting'),
            Tab(text: 'Caveats'),
            Tab(text: 'Summary'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          // --- TAB 1: Concept ---
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              buildSWVBullet(Icons.info_outline,
                  'ShrinkWrappingViewport is a RenderObjectWidget that creates '
                  'a RenderShrinkWrappingViewport — a viewport whose main axis '
                  'extent exactly matches its children\'s total extent.'),
              const SizedBox(height: 12.0),
              ...conceptCards,
              const SizedBox(height: 12.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.cyan.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('When to use', style: TextStyle(fontSize: 13.0,
                        fontWeight: FontWeight.w700, color: Colors.cyan.shade700)),
                    const SizedBox(height: 6.0),
                    buildSWVBullet(Icons.check, 'Short lists embedded in non-scrollable layouts'),
                    buildSWVBullet(Icons.check, 'Column > ListView > Column patterns'),
                    buildSWVBullet(Icons.check, 'Dialog/bottom-sheet with scrollable content'),
                    buildSWVBullet(Icons.close, 'Long lists with hundreds of items (use Expanded + regular Viewport)',
                        color: Colors.red.shade400),
                    buildSWVBullet(Icons.close, 'Main app scroll views (performance waste)',
                        color: Colors.red.shade400),
                  ],
                ),
              ),
            ],
          ),

          // --- TAB 2: Constructor ---
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Text(
                  'const ShrinkWrappingViewport({\n'
                  '  Key? key,\n'
                  '  AxisDirection axisDirection = AxisDirection.down,\n'
                  '  AxisDirection? crossAxisDirection,\n'
                  '  required ViewportOffset offset,\n'
                  '  Clip clipBehavior = Clip.hardEdge,\n'
                  '  List<Widget> slivers = const <Widget>[],\n'
                  '})',
                  style: TextStyle(fontSize: 12.0, fontFamily: 'monospace',
                      color: Colors.grey.shade800, height: 1.4),
                ),
              ),
              const SizedBox(height: 16.0),
              ...paramRows,
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.amber.withValues(alpha: 0.25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.lightbulb_outline, color: Colors.amber.shade700, size: 18.0),
                        const SizedBox(width: 6.0),
                        Text('Key Difference from Viewport',
                            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700,
                                color: Colors.amber.shade800)),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'Viewport extends to fill parent constraints. '
                      'ShrinkWrappingViewport only takes as much space as its '
                      'slivers need. Both share the same offset, axisDirection, '
                      'and slivers parameters.',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.35),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.cyan.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.cyan.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Inheritance Chain',
                        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700,
                            color: Colors.cyan.shade700)),
                    const SizedBox(height: 8.0),
                    ...[
                      'Widget',
                      '  └─ RenderObjectWidget',
                      '      └─ MultiChildRenderObjectWidget',
                      '          └─ ShrinkWrappingViewport',
                    ].map((line) => Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Text(line, style: TextStyle(fontSize: 11.5,
                          fontFamily: 'monospace', color: Colors.cyan.shade800, height: 1.3)),
                    )),
                    const SizedBox(height: 8.0),
                    Text('Creates: RenderShrinkWrappingViewport',
                        style: TextStyle(fontSize: 11.5, fontStyle: FontStyle.italic,
                            color: Colors.cyan.shade600)),
                  ],
                ),
              ),
            ],
          ),

          // --- TAB 3: Comparison ---
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              buildSWVBullet(Icons.compare_arrows,
                  'Regular Viewport fills all available space. '
                  'ShrinkWrappingViewport takes only as much as its children need.'),
              const SizedBox(height: 12.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildViewportSample(
                    label: 'Regular Viewport',
                    description: 'Fills 220px container',
                    color: Colors.grey.shade600,
                    containerHeight: 220.0,
                    itemCount: 3,
                    shrinkWrap: false,
                  ),
                  const SizedBox(width: 12.0),
                  buildViewportSample(
                    label: 'ShrinkWrapping',
                    description: 'Only as tall as items',
                    color: Colors.cyan.shade600,
                    containerHeight: 220.0,
                    itemCount: 3,
                    shrinkWrap: true,
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              // Comparison table
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.cyan.withValues(alpha: 0.25)),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      color: Colors.cyan.shade600,
                      child: const Row(
                        children: [
                          Expanded(flex: 2, child: Text('Feature',
                              style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                          Expanded(flex: 3, child: Text('Viewport',
                              style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center)),
                          Expanded(flex: 3, child: Text('ShrinkWrapping',
                              style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.bold,
                                  color: Colors.white),
                              textAlign: TextAlign.center)),
                        ],
                      ),
                    ),
                    ...<Map<String, String>>[
                      {'feature': 'Sizing', 'viewport': 'Fills parent',
                          'shrink': 'Fits content'},
                      {'feature': 'Lazy loading', 'viewport': 'Yes, efficient',
                          'shrink': 'Limited'},
                      {'feature': 'Infinite slivers', 'viewport': 'Supported',
                          'shrink': 'Not allowed'},
                      {'feature': 'Column friendly', 'viewport': 'Needs Expanded',
                          'shrink': 'Direct child OK'},
                      {'feature': 'SliverFillRemaining', 'viewport': 'Supported',
                          'shrink': 'Incompatible'},
                      {'feature': 'Memory usage', 'viewport': 'Low (lazy)',
                          'shrink': 'Higher (measures all)'},
                    ].asMap().entries.map((entry) {
                      final r = entry.value;
                      final isEven = entry.key.isEven;
                      return Container(
                        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
                        color: isEven ? Colors.cyan.withValues(alpha: 0.03) : Colors.white,
                        child: Row(
                          children: [
                            Expanded(flex: 2, child: Text(r['feature']!,
                                style: TextStyle(fontSize: 11.0,
                                    fontWeight: FontWeight.w600, color: Colors.grey.shade800))),
                            Expanded(flex: 3, child: Text(r['viewport']!,
                                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
                                textAlign: TextAlign.center)),
                            Expanded(flex: 3, child: Text(r['shrink']!,
                                style: TextStyle(fontSize: 11.0, color: Colors.cyan.shade700,
                                    fontWeight: FontWeight.w500),
                                textAlign: TextAlign.center)),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Visual explanation',
                        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700,
                            color: Colors.green.shade700)),
                    const SizedBox(height: 6.0),
                    Text('In the left example, the Viewport expands to fill the entire '
                        '220px container regardless of having only 3 items. In the right '
                        'example, ShrinkWrappingViewport only takes ~120px for 3 items. '
                        'The remaining ~100px is available for other widgets in the layout.',
                        style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700,
                            height: 1.35)),
                  ],
                ),
              ),
            ],
          ),

          // --- TAB 4: Direction ---
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              buildSWVBullet(Icons.explore,
                  'ShrinkWrappingViewport supports all four AxisDirection values, '
                  'allowing vertical or horizontal shrink-wrapped scrolling.'),
              const SizedBox(height: 12.0),
              ...axisCards,
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.cyan.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.cyan.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('crossAxisDirection',
                        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700,
                            fontFamily: 'monospace', color: Colors.cyan.shade700)),
                    const SizedBox(height: 6.0),
                    Text(
                      'If axisDirection is down or up, crossAxisDirection defaults to '
                      'right (LTR text) or left (RTL text). If axisDirection is right '
                      'or left, crossAxisDirection defaults to down. You can override '
                      'this for RTL layouts.',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.35),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
              // Horizontal ShrinkWrap example
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Horizontal shrink-wrap use case',
                        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700,
                            color: Colors.blue.shade700)),
                    const SizedBox(height: 8.0),
                    SizedBox(
                      height: 60.0,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Tags: ', style: TextStyle(fontSize: 12.0,
                              color: Colors.blue.shade600, fontWeight: FontWeight.w600)),
                          Expanded(
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children: ['Flutter', 'Dart', 'Viewport', 'Layout', 'UI'].map((tag) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 6.0),
                                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.withValues(alpha: 0.12),
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(tag, style: TextStyle(fontSize: 11.5,
                                      color: Colors.blue.shade700, fontWeight: FontWeight.w500)),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text('Horizontal tags in a Row — shrinkWrap ensures '
                        'the tags list doesn\'t expand beyond its content.',
                        style: TextStyle(fontSize: 11.0, color: Colors.blue.shade500,
                            fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
            ],
          ),

          // --- TAB 5: Live Demo ---
          _SWVLiveDemo(),

          // --- TAB 6: Nesting ---
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              buildSWVBullet(Icons.view_agenda,
                  'The most common use case: embedding a scrollable list inside '
                  'a Column with a fixed header and footer.'),
              const SizedBox(height: 12.0),
              Text('Building the pattern step-by-step:',
                  style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w600,
                      color: Colors.cyan.shade700)),
              const SizedBox(height: 12.0),
              ...stepWidgets,
              const SizedBox(height: 16.0),
              Text('Result:', style: TextStyle(fontSize: 13.0,
                  fontWeight: FontWeight.w700, color: Colors.cyan.shade700)),
              const SizedBox(height: 8.0),
              buildNestedColumnDemo(),
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.amber.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.amber.withValues(alpha: 0.25)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.warning_amber, color: Colors.amber.shade700, size: 18.0),
                        const SizedBox(width: 6.0),
                        Text('Common Mistake',
                            style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700,
                                color: Colors.amber.shade800)),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      'Using shrinkWrap: true without NeverScrollableScrollPhysics '
                      'in a nested scroll view causes both viewports to compete for '
                      'scroll events. Always combine them:\n\n'
                      'ListView(\n'
                      '  shrinkWrap: true,\n'
                      '  physics: NeverScrollableScrollPhysics(),\n'
                      '  ...\n'
                      ')',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700,
                          height: 1.35, fontFamily: 'monospace'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.green.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Alternative: Slivers in CustomScrollView',
                        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700,
                            color: Colors.green.shade700)),
                    const SizedBox(height: 6.0),
                    Text(
                      'Instead of Column + shrinkWrap ListView, consider:\n\n'
                      'CustomScrollView(\n'
                      '  slivers: [\n'
                      '    SliverToBoxAdapter(child: Header()),\n'
                      '    SliverList(delegate: ...),\n'
                      '    SliverToBoxAdapter(child: Footer()),\n'
                      '  ],\n'
                      ')\n\n'
                      'This avoids shrinkWrap entirely and uses a single Viewport '
                      'with full lazy-loading benefits.',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700,
                          height: 1.35, fontFamily: 'monospace'),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // --- TAB 7: Caveats ---
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              buildSWVBullet(Icons.warning,
                  'Important limitations and gotchas when using '
                  'ShrinkWrappingViewport.'),
              const SizedBox(height: 12.0),
              ...caveatWidgets,
              const SizedBox(height: 16.0),
              // Performance comparison visual
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.cyan.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.cyan.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Performance impact visualization',
                        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700,
                            color: Colors.cyan.shade700)),
                    const SizedBox(height: 10.0),
                    // Regular viewport bar
                    Row(
                      children: [
                        SizedBox(width: 80.0, child: Text('Viewport',
                            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600))),
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: 20.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.15,
                                child: Container(
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: Colors.green.shade400,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text('Fast',
                                      style: TextStyle(fontSize: 9.0, color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6.0),
                    // ShrinkWrap bar
                    Row(
                      children: [
                        SizedBox(width: 80.0, child: Text('ShrinkWrap',
                            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600))),
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: 20.0,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                              FractionallySizedBox(
                                widthFactor: 0.65,
                                child: Container(
                                  height: 20.0,
                                  decoration: BoxDecoration(
                                    color: Colors.orange.shade400,
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  alignment: Alignment.center,
                                  child: const Text('Measures all slivers',
                                      style: TextStyle(fontSize: 9.0, color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Text('Layout cost per frame (approximate, relative)',
                        style: TextStyle(fontSize: 10.0, color: Colors.grey.shade500,
                            fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
            ],
          ),

          // --- TAB 8: Summary ---
          ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.cyan.shade50, Colors.cyan.shade100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    Icon(Icons.wrap_text, size: 40.0, color: Colors.cyan.shade600),
                    const SizedBox(height: 8.0),
                    Text('ShrinkWrappingViewport',
                        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold,
                            color: Colors.cyan.shade800)),
                    const SizedBox(height: 4.0),
                    Text('Content-sized scrollable region',
                        style: TextStyle(fontSize: 12.5, color: Colors.cyan.shade600,
                            fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              ...summaryBullets,
              const SizedBox(height: 16.0),
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.cyan.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.cyan.withValues(alpha: 0.2)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Decision Guide',
                        style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                            color: Colors.cyan.shade700)),
                    const SizedBox(height: 8.0),
                    buildSWVBullet(Icons.check_circle,
                        'Use ShrinkWrapping when embedding short lists in Columns/Dialogs'),
                    buildSWVBullet(Icons.check_circle,
                        'Use ShrinkWrapping for nested scrollable sub-sections'),
                    buildSWVBullet(Icons.cancel,
                        'Avoid for primary scroll views with many items',
                        color: Colors.red.shade400),
                    buildSWVBullet(Icons.cancel,
                        'Avoid when slivers need SliverFillRemaining',
                        color: Colors.red.shade400),
                    buildSWVBullet(Icons.lightbulb,
                        'Consider CustomScrollView + Slivers as an alternative',
                        color: Colors.amber.shade600),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

// ============================================================
// _SWVLiveDemo — Interactive demo showing shrinkWrap behavior
// ============================================================
class _SWVLiveDemo extends StatefulWidget {
  @override
  State<_SWVLiveDemo> createState() => _SWVLiveDemoState();
}

class _SWVLiveDemoState extends State<_SWVLiveDemo> {
  int _itemCount = 3;
  bool _useShrinkWrap = true;
  bool _showBorder = true;
  double _itemHeight = 48.0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // Controls
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.cyan.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.cyan.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Controls', style: TextStyle(fontSize: 13.0,
                  fontWeight: FontWeight.w700, color: Colors.cyan.shade700)),
              const SizedBox(height: 10.0),
              // Item count
              Row(
                children: [
                  Text('Items: $_itemCount',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline, size: 22.0),
                    color: Colors.cyan.shade600,
                    onPressed: _itemCount > 1
                        ? () => setState(() => _itemCount--)
                        : null,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline, size: 22.0),
                    color: Colors.cyan.shade600,
                    onPressed: _itemCount < 12
                        ? () => setState(() => _itemCount++)
                        : null,
                  ),
                ],
              ),
              // Item height
              Row(
                children: [
                  Text('Item height: ${_itemHeight.toInt()}px',
                      style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
                  Expanded(
                    child: Slider(
                      value: _itemHeight,
                      min: 24.0,
                      max: 80.0,
                      divisions: 14,
                      activeColor: Colors.cyan.shade600,
                      onChanged: (v) => setState(() => _itemHeight = v),
                    ),
                  ),
                ],
              ),
              // Toggles
              Row(
                children: [
                  Expanded(
                    child: SwitchListTile(
                      title: Text('shrinkWrap',
                          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
                      value: _useShrinkWrap,
                      activeColor: Colors.cyan.shade600,
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (v) => setState(() => _useShrinkWrap = v),
                    ),
                  ),
                  Expanded(
                    child: SwitchListTile(
                      title: Text('Show border',
                          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700)),
                      value: _showBorder,
                      activeColor: Colors.cyan.shade600,
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      onChanged: (v) => setState(() => _showBorder = v),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        // Info bar
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: _useShrinkWrap
                ? Colors.green.withValues(alpha: 0.06)
                : Colors.orange.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: _useShrinkWrap
                  ? Colors.green.withValues(alpha: 0.25)
                  : Colors.orange.withValues(alpha: 0.25),
            ),
          ),
          child: Row(
            children: [
              Icon(
                _useShrinkWrap ? Icons.wrap_text : Icons.open_in_full,
                color: _useShrinkWrap ? Colors.green.shade600 : Colors.orange.shade600,
                size: 20.0,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  _useShrinkWrap
                      ? 'ShrinkWrapping: viewport height = $_itemCount × ${_itemHeight.toInt()}px + padding ≈ '
                          '${(_itemCount * (_itemHeight + 4)).toInt()}px'
                      : 'Expanding: viewport fills all available space regardless of content',
                  style: TextStyle(fontSize: 11.5,
                      color: _useShrinkWrap ? Colors.green.shade700 : Colors.orange.shade700),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
        // Label
        Text('Header (fixed)', style: TextStyle(fontSize: 11.0,
            color: Colors.grey.shade500, fontStyle: FontStyle.italic)),
        const SizedBox(height: 4.0),
        // The actual demo layout
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            border: _showBorder
                ? Border.all(color: Colors.cyan.withValues(alpha: 0.4), width: 2.0)
                : null,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                color: Colors.cyan.shade600,
                child: const Text('Fixed Header',
                    style: TextStyle(color: Colors.white, fontSize: 12.0,
                        fontWeight: FontWeight.w600)),
              ),
              // Viewport area
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                constraints: _useShrinkWrap
                    ? const BoxConstraints()
                    : const BoxConstraints(minHeight: 250.0, maxHeight: 250.0),
                color: Colors.cyan.withValues(alpha: 0.02),
                child: ListView(
                  shrinkWrap: _useShrinkWrap,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(6.0),
                  children: List.generate(_itemCount, (i) {
                    final fraction = (i + 1) / _itemCount;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: _itemHeight,
                      margin: const EdgeInsets.only(bottom: 4.0),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.cyan.withValues(alpha: 0.1 + (fraction * 0.2)),
                            Colors.cyan.withValues(alpha: 0.05 + (fraction * 0.1)),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.cyan.withValues(alpha: 0.25)),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inbox, size: 16.0,
                              color: Colors.cyan.shade600),
                          const SizedBox(width: 6.0),
                          Text('Sliver Item ${i + 1}',
                              style: TextStyle(fontSize: 12.0,
                                  color: Colors.cyan.shade700,
                                  fontWeight: FontWeight.w600)),
                          const SizedBox(width: 8.0),
                          Text('${_itemHeight.toInt()}px',
                              style: TextStyle(fontSize: 10.0,
                                  color: Colors.cyan.shade400)),
                        ],
                      ),
                    );
                  }),
                ),
              ),
              // Footer
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                color: Colors.cyan.shade50,
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 14.0,
                        color: Colors.cyan.shade600),
                    const SizedBox(width: 6.0),
                    Text('Footer — appears right after content',
                        style: TextStyle(fontSize: 11.0,
                            color: Colors.cyan.shade600)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        Text('↑ viewport boundary', style: TextStyle(fontSize: 11.0,
            color: Colors.grey.shade500, fontStyle: FontStyle.italic)),
        const SizedBox(height: 16.0),
        // Explanation
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.cyan.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.cyan.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('What to observe', style: TextStyle(fontSize: 12.5,
                  fontWeight: FontWeight.w700, color: Colors.cyan.shade700)),
              const SizedBox(height: 6.0),
              Text('• Toggle shrinkWrap on/off to see how the viewport height changes\n'
                  '• Add/remove items — with shrinkWrap, the viewport grows/shrinks\n'
                  '• Without shrinkWrap, the viewport stays at 250px regardless\n'
                  '• Adjust item height — shrinkWrap recalculates total extent\n'
                  '• Notice the footer: with shrinkWrap it hugs the content',
                  style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700, height: 1.4)),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================
// _SWVComparisonDemo — Side-by-side animated comparison
// ============================================================
class _SWVComparisonDemo extends StatefulWidget {
  @override
  State<_SWVComparisonDemo> createState() => _SWVComparisonDemoState();
}

class _SWVComparisonDemoState extends State<_SWVComparisonDemo> {
  int _compItemCount = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.cyan.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.cyan.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Animated comparison',
                  style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w700,
                      color: Colors.cyan.shade700)),
              const Spacer(),
              Text('$_compItemCount items',
                  style: TextStyle(fontSize: 11.0, color: Colors.cyan.shade500)),
              const SizedBox(width: 6.0),
              IconButton(
                icon: const Icon(Icons.remove, size: 18.0),
                color: Colors.cyan.shade600,
                onPressed: _compItemCount > 1
                    ? () => setState(() => _compItemCount--)
                    : null,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 28.0, minHeight: 28.0),
              ),
              IconButton(
                icon: const Icon(Icons.add, size: 18.0),
                color: Colors.cyan.shade600,
                onPressed: _compItemCount < 8
                    ? () => setState(() => _compItemCount++)
                    : null,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(minWidth: 28.0, minHeight: 28.0),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Regular viewport side
              Expanded(
                child: Column(
                  children: [
                    Text('Regular', style: TextStyle(fontSize: 11.0,
                        fontWeight: FontWeight.w600, color: Colors.grey.shade600)),
                    const SizedBox(height: 4.0),
                    Container(
                      height: 200.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(6.0),
                        color: Colors.grey.shade50,
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: ListView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(_compItemCount, (i) {
                          return Container(
                            height: 32.0,
                            margin: const EdgeInsets.only(bottom: 3.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            alignment: Alignment.center,
                            child: Text('${i + 1}', style: TextStyle(fontSize: 10.0,
                                color: Colors.grey.shade600)),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text('Always 200px', style: TextStyle(fontSize: 10.0,
                        color: Colors.grey.shade500)),
                  ],
                ),
              ),
              const SizedBox(width: 12.0),
              // ShrinkWrap side
              Expanded(
                child: Column(
                  children: [
                    Text('ShrinkWrap', style: TextStyle(fontSize: 11.0,
                        fontWeight: FontWeight.w600, color: Colors.cyan.shade700)),
                    const SizedBox(height: 4.0),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.cyan.shade400),
                        borderRadius: BorderRadius.circular(6.0),
                        color: Colors.cyan.shade50.withValues(alpha: 0.3),
                      ),
                      padding: const EdgeInsets.all(4.0),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(_compItemCount, (i) {
                          return Container(
                            height: 32.0,
                            margin: const EdgeInsets.only(bottom: 3.0),
                            decoration: BoxDecoration(
                              color: Colors.cyan.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            alignment: Alignment.center,
                            child: Text('${i + 1}', style: TextStyle(fontSize: 10.0,
                                color: Colors.cyan.shade700)),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    Text('~${_compItemCount * 35}px', style: TextStyle(fontSize: 10.0,
                        color: Colors.cyan.shade500)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
