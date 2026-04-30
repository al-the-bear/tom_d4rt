// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverAnimatedList
// Demonstrates SliverAnimatedList — a sliver that animates items when they
// are inserted into or removed from a list. Works inside CustomScrollView
// for animated linear content with per-item entry and exit transitions.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverAnimatedList Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.view_list,
      'title': 'Animated List as a Sliver',
      'body': 'SliverAnimatedList is the sliver variant of AnimatedList. '
          'It lives inside a CustomScrollView and participates in the '
          'sliver protocol, meaning it can coexist with SliverAppBar, '
          'SliverGrid, SliverToBoxAdapter, and other slivers.',
    },
    {
      'icon': Icons.swap_vert,
      'title': 'Insert & Remove with Transitions',
      'body': 'When you call insertItem() or removeItem() on the state, '
          'the list smoothly animates the new item in or the old item out. '
          'Each item\'s builder receives an Animation<double> to drive '
          'any transition widget (Fade, Scale, Slide, SizeTransition, etc.).',
    },
    {
      'icon': Icons.key,
      'title': 'State-Driven API',
      'body': 'Access the list\'s state via GlobalKey<SliverAnimatedListState>. '
          'The state exposes insertItem(), insertAllItems(), removeItem(), '
          'and removeAllItems() for programmatic control.',
    },
    {
      'icon': Icons.format_list_numbered,
      'title': 'Linear Layout',
      'body': 'Unlike SliverAnimatedGrid which arranges children in a grid, '
          'SliverAnimatedList arranges them in a single column (or row). '
          'Each item occupies the full cross-axis extent by default.',
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
          color: Colors.indigo.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.indigo.withValues(alpha: 0.12),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                p['icon'] as IconData,
                color: Colors.indigo,
                size: 22.0,
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    p['title'] as String,
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.indigo,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    p['body'] as String,
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.grey[700],
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

  final conceptTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo.withValues(alpha: 0.08),
                Colors.indigo.withValues(alpha: 0.02),
              ],
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              const Icon(Icons.view_list, size: 48.0, color: Colors.indigo),
              const SizedBox(height: 8.0),
              const Text(
                'SliverAnimatedList',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                'A sliver that animates list items during insertion and '
                'removal — the list counterpart to SliverAnimatedGrid.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.5,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        ...conceptCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Constructor
  // ============================================================
  print('=== Section 2: Constructor ===');

  final constructorParams = <Map<String, String>>[
    {
      'name': 'itemBuilder',
      'type': 'AnimatedItemBuilder',
      'required': 'Yes',
      'desc': 'Builder called for each item. Receives (context, index, '
          'animation). The Animation<double> drives the entry transition.',
    },
    {
      'name': 'initialItemCount',
      'type': 'int',
      'required': 'No',
      'desc': 'Number of items initially in the list. Defaults to 0. '
          'These items appear immediately without animation.',
    },
    {
      'name': 'findChildIndexCallback',
      'type': 'ChildIndexGetter?',
      'required': 'No',
      'desc': 'Callback to map a child\'s Key to its index. Helps '
          'preserve child state when items are inserted or removed.',
    },
  ];

  final paramRows = <Widget>[];
  for (final param in constructorParams) {
    print('  Constructor param: ${param['name']}');
    paramRows.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.indigo.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 3.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.indigo.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    param['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.0,
                      color: Colors.indigo,
                      fontFamily: 'monospace',
                    ),
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
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    param['type']!,
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey[600],
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6.0,
                    vertical: 2.0,
                  ),
                  decoration: BoxDecoration(
                    color: param['required'] == 'Yes'
                        ? Colors.red.withValues(alpha: 0.1)
                        : Colors.green.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    param['required'] == 'Yes' ? 'REQUIRED' : 'optional',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.w600,
                      color: param['required'] == 'Yes'
                          ? Colors.red[700]
                          : Colors.green[700],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              param['desc']!,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  final constructorTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSALSectionHeader('Constructor Parameters', Icons.code),
        const SizedBox(height: 12.0),
        ...paramRows,
        const SizedBox(height: 16.0),
        buildSALSectionHeader('Minimal Setup', Icons.text_snippet),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'final _listKey = GlobalKey<SliverAnimatedListState>();\n'
            'final _items = <String>[];\n\n'
            'CustomScrollView(\n'
            '  slivers: [\n'
            '    SliverAnimatedList(\n'
            '      key: _listKey,\n'
            '      initialItemCount: _items.length,\n'
            '      itemBuilder: (context, index, animation) {\n'
            '        return SizeTransition(\n'
            '          sizeFactor: animation,\n'
            '          child: ListTile(\n'
            '            title: Text(_items[index]),\n'
            '          ),\n'
            '        );\n'
            '      },\n'
            '    ),\n'
            '  ],\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.greenAccent,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        buildSALSectionHeader('State Methods', Icons.functions),
        const SizedBox(height: 8.0),
        _buildSALMethodCard(
          'insertItem(index, {duration})',
          'Insert a single item at the given index with entry animation.',
          Colors.green,
        ),
        _buildSALMethodCard(
          'insertAllItems(index, length, {duration})',
          'Insert multiple items starting at index. More efficient than '
          'multiple insertItem calls.',
          Colors.blue,
        ),
        _buildSALMethodCard(
          'removeItem(index, builder, {duration})',
          'Remove item at index. The builder provides the exit transition '
          'while the item animates out.',
          Colors.red,
        ),
        _buildSALMethodCard(
          'removeAllItems(builder, {duration})',
          'Remove all items with the same removal builder. Each item '
          'gets its own animation.',
          Colors.orange,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: vs AnimatedList
  // ============================================================
  print('=== Section 3: vs AnimatedList ===');

  final comparisonRows = <Map<String, dynamic>>[
    {
      'feature': 'Widget type',
      'animatedList': 'Box widget\n(RenderBox)',
      'sliverAnimatedList': 'Sliver widget\n(RenderSliver)',
      'colorAL': Colors.blue,
      'colorSAL': Colors.indigo,
    },
    {
      'feature': 'Standalone usage',
      'animatedList': 'Yes — can be used\nanywhere',
      'sliverAnimatedList': 'No — must be inside\nCustomScrollView',
      'colorAL': Colors.green,
      'colorSAL': Colors.orange,
    },
    {
      'feature': 'With other slivers',
      'animatedList': 'No — would need\nSliverToBoxAdapter',
      'sliverAnimatedList': 'Yes — works alongside\nSliverAppBar, SliverGrid, etc.',
      'colorAL': Colors.orange,
      'colorSAL': Colors.green,
    },
    {
      'feature': 'ScrollController',
      'animatedList': 'Has its own\nscroll behavior',
      'sliverAnimatedList': 'Shares parent\nCustomScrollView scroll',
      'colorAL': Colors.grey,
      'colorSAL': Colors.green,
    },
    {
      'feature': 'API surface',
      'animatedList': 'insertItem,\nremoveItem, etc.',
      'sliverAnimatedList': 'Identical API\n(same methods)',
      'colorAL': Colors.grey,
      'colorSAL': Colors.grey,
    },
  ];

  final comparisonWidgets = <Widget>[];
  for (final row in comparisonRows) {
    print('  Comparison: ${row['feature']}');
    comparisonWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          children: [
            SizedBox(
              width: 80.0,
              child: Text(
                row['feature'] as String,
                style: const TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 6.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: (row['colorAL'] as Color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    color: (row['colorAL'] as Color).withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  row['animatedList'] as String,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: Colors.grey[700],
                    height: 1.3,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: (row['colorSAL'] as Color).withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(4.0),
                  border: Border.all(
                    color: (row['colorSAL'] as Color).withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  row['sliverAnimatedList'] as String,
                  style: TextStyle(
                    fontSize: 10.5,
                    color: Colors.grey[700],
                    height: 1.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final vsTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSALSectionHeader('AnimatedList vs SliverAnimatedList', Icons.compare),
        const SizedBox(height: 8.0),
        Text(
          'The primary difference is the widget type: AnimatedList is a '
          'standalone scrolling widget, while SliverAnimatedList is a '
          'sliver that participates in CustomScrollView.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
        ),
        const SizedBox(height: 14.0),
        // Header
        Row(
          children: [
            const SizedBox(width: 86.0),
            Expanded(
              child: Text(
                'AnimatedList',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.blue[700],
                ),
              ),
            ),
            const SizedBox(width: 6.0),
            Expanded(
              child: Text(
                'SliverAnimatedList',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.indigo[700],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        ...comparisonWidgets,

        const SizedBox(height: 20.0),
        // Visual: widget tree comparison
        buildSALSectionHeader('Widget Tree Placement', Icons.account_tree),
        const SizedBox(height: 12.0),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.blue.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.blue.withValues(alpha: 0.15)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'AnimatedList',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    _buildSALTreeNode('Scaffold', 0, Colors.grey),
                    _buildSALTreeNode('└─ AnimatedList', 1, Colors.blue),
                    _buildSALTreeNode('   ├─ Item 0', 2, Colors.blue),
                    _buildSALTreeNode('   ├─ Item 1', 2, Colors.blue),
                    _buildSALTreeNode('   └─ Item 2', 2, Colors.blue),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.indigo.withValues(alpha: 0.04),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(
                    color: Colors.indigo.withValues(alpha: 0.15),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'SliverAnimatedList',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    _buildSALTreeNode('CustomScrollView', 0, Colors.grey),
                    _buildSALTreeNode('├─ SliverAppBar', 1, Colors.grey),
                    _buildSALTreeNode('├─ SliverAnimatedList', 1, Colors.indigo),
                    _buildSALTreeNode('│  ├─ Item 0', 2, Colors.indigo),
                    _buildSALTreeNode('│  └─ Item 1', 2, Colors.indigo),
                    _buildSALTreeNode('└─ SliverGrid', 1, Colors.grey),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Transition Gallery
  // ============================================================
  print('=== Section 4: Transition Gallery ===');

  final transitions = <Map<String, dynamic>>[
    {
      'name': 'SizeTransition',
      'desc': 'Item grows/shrinks in the main axis. Neighboring items '
          'smoothly push apart or come together. The most natural '
          'list transition — items "expand" into existence.',
      'icon': Icons.unfold_more,
      'color': Colors.blue,
      'visual': _SALSizeTransitionVisual(),
    },
    {
      'name': 'FadeTransition',
      'desc': 'Item fades in from transparent. Subtle but doesn\'t '
          'affect layout — the space is already allocated before '
          'the item becomes visible.',
      'icon': Icons.gradient,
      'color': Colors.orange,
      'visual': _SALFadeTransitionVisual(),
    },
    {
      'name': 'SlideTransition',
      'desc': 'Item slides in from a direction. Often combined with '
          'SizeTransition so the layout also animates.',
      'icon': Icons.arrow_forward,
      'color': Colors.green,
      'visual': _SALSlideTransitionVisual(),
    },
    {
      'name': 'Combined (Size + Fade)',
      'desc': 'The most polished effect: the item both grows into view '
          'AND fades in, creating a smooth, professional entry animation.',
      'icon': Icons.auto_awesome,
      'color': Colors.purple,
      'visual': _SALCombinedTransitionVisual(),
    },
  ];

  final transitionCards = <Widget>[];
  for (var i = 0; i < transitions.length; i++) {
    final t = transitions[i];
    print('  Transition: ${t['name']}');
    transitionCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 14.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: (t['color'] as Color).withValues(alpha: 0.2),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: (t['color'] as Color).withValues(alpha: 0.06),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    t['icon'] as IconData,
                    size: 20.0,
                    color: t['color'] as Color,
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    t['name'] as String,
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: t['color'] as Color,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                t['desc'] as String,
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 12.0,
                right: 12.0,
                bottom: 12.0,
              ),
              child: t['visual'] as Widget,
            ),
          ],
        ),
      ),
    );
  }

  final transitionTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSALSectionHeader('Transition Gallery', Icons.animation),
        const SizedBox(height: 8.0),
        Text(
          'Different transition widgets create different visual effects '
          'when items are inserted or removed.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
        ),
        const SizedBox(height: 14.0),
        ...transitionCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Live Demo
  // ============================================================
  print('=== Section 5: Live Demo ===');

  final liveTab = _SALLiveDemo();

  // ============================================================
  // SECTION 6: Mixed Slivers
  // ============================================================
  print('=== Section 6: Mixed Slivers ===');

  final mixedTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSALSectionHeader('Mixed Sliver Layouts', Icons.view_quilt),
        const SizedBox(height: 8.0),
        Text(
          'SliverAnimatedList shines in CustomScrollView layouts where '
          'it coexists with other slivers, sharing one scroll position.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
        ),
        const SizedBox(height: 14.0),

        // Example layout blueprint
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.indigo.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Typical Mixed Layout',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 12.0),
              // Visual layout scheme
              _buildSALLayoutBlock(
                'SliverAppBar',
                Colors.blue,
                'Collapsible app bar with image',
                48.0,
              ),
              _buildSALLayoutBlock(
                'SliverToBoxAdapter',
                Colors.grey,
                'Header section / search bar',
                30.0,
              ),
              _buildSALLayoutBlock(
                'SliverAnimatedList',
                Colors.indigo,
                'Animated items (add/remove)',
                90.0,
              ),
              _buildSALLayoutBlock(
                'SliverGrid',
                Colors.teal,
                'Static grid content',
                50.0,
              ),
              _buildSALLayoutBlock(
                'SliverToBoxAdapter',
                Colors.grey,
                'Footer',
                30.0,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),

        // Code example
        buildSALSectionHeader('Code Example', Icons.code),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'CustomScrollView(\n'
            '  slivers: [\n'
            '    SliverAppBar(\n'
            '      expandedHeight: 200,\n'
            '      pinned: true,\n'
            '      flexibleSpace: FlexibleSpaceBar(...),\n'
            '    ),\n'
            '    SliverToBoxAdapter(\n'
            '      child: SearchBar(...),\n'
            '    ),\n'
            '    SliverAnimatedList(\n'
            '      key: _listKey,\n'
            '      initialItemCount: items.length,\n'
            '      itemBuilder: (ctx, i, anim) {\n'
            '        return SizeTransition(\n'
            '          sizeFactor: anim,\n'
            '          child: _buildListItem(i),\n'
            '        );\n'
            '      },\n'
            '    ),\n'
            '    SliverGrid(...),\n'
            '  ],\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Colors.greenAccent,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16.0),

        // Key advantage
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.green.withValues(alpha: 0.15)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 20.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Key advantage: All slivers share one scroll position. '
                  'The user scrolls through the entire layout seamlessly, '
                  'and only the animated list section has item transitions.',
                  style: TextStyle(
                    fontSize: 12.5,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final patternsTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSALSectionHeader('Common Patterns', Icons.pattern),
        const SizedBox(height: 14.0),

        // Pattern 1: Undo Removal
        _buildSALPatternCard(
          'Undo Removal (Snackbar)',
          Icons.undo,
          Colors.orange,
          'When removing an item, show a Snackbar with an "Undo" button. '
          'Store the removed item and its index. If undo is tapped, '
          'reinsert the item at its original position with insertItem().',
          'void _removeWithUndo(int index) {\n'
          '  final item = _items.removeAt(index);\n'
          '  _listKey.currentState!.removeItem(\n'
          '    index,\n'
          '    (ctx, anim) => _buildRemoved(item, anim),\n'
          '  );\n'
          '  ScaffoldMessenger.of(context).showSnackBar(\n'
          '    SnackBar(\n'
          '      content: Text("Removed \${item.name}"),\n'
          '      action: SnackBarAction(\n'
          '        label: "UNDO",\n'
          '        onPressed: () {\n'
          '          _items.insert(index, item);\n'
          '          _listKey.currentState!\n'
          '            .insertItem(index);\n'
          '        },\n'
          '      ),\n'
          '    ),\n'
          '  );\n'
          '}',
        ),

        // Pattern 2: Batch Add
        _buildSALPatternCard(
          'Batch Insert (Load More)',
          Icons.add_circle,
          Colors.green,
          'When loading more items (infinite scroll, "Load More" button), '
          'use insertAllItems() for a single animation call rather than '
          'multiple individual insertItem() calls.',
          'void _loadMore(List<Item> newItems) {\n'
          '  final startIndex = _items.length;\n'
          '  _items.addAll(newItems);\n'
          '  _listKey.currentState!.insertAllItems(\n'
          '    startIndex,\n'
          '    newItems.length,\n'
          '    duration: Duration(milliseconds: 300),\n'
          '  );\n'
          '}',
        ),

        // Pattern 3: Dismiss-to-delete
        _buildSALPatternCard(
          'Swipe-to-Dismiss',
          Icons.swipe,
          Colors.red,
          'Wrap each list item in a Dismissible widget. On dismiss, '
          'call removeItem() on the state. The SliverAnimatedList handles '
          'the layout collapse animation.',
          'itemBuilder: (context, index, animation) {\n'
          '  return SizeTransition(\n'
          '    sizeFactor: animation,\n'
          '    child: Dismissible(\n'
          '      key: ValueKey(_items[index].id),\n'
          '      onDismissed: (_) {\n'
          '        final removed = _items.removeAt(index);\n'
          '        _listKey.currentState!.removeItem(\n'
          '          index,\n'
          '          (ctx, anim) => SizeTransition(\n'
          '            sizeFactor: anim,\n'
          '            child: _tile(removed),\n'
          '          ),\n'
          '        );\n'
          '      },\n'
          '      child: _tile(_items[index]),\n'
          '    ),\n'
          '  );\n'
          '}',
        ),

        // Pattern 4: Empty state
        _buildSALPatternCard(
          'Empty State Fallback',
          Icons.inbox,
          Colors.purple,
          'When the list is empty, show a placeholder. Use a '
          'SliverToBoxAdapter after the SliverAnimatedList that '
          'only shows when the item count is 0.',
          'CustomScrollView(\n'
          '  slivers: [\n'
          '    SliverAnimatedList(...),\n'
          '    if (_items.isEmpty)\n'
          '      SliverFillRemaining(\n'
          '        child: Center(\n'
          '          child: Text("No items yet"),\n'
          '        ),\n'
          '      ),\n'
          '  ],\n'
          ')',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryItems = <Map<String, dynamic>>[
    {
      'icon': Icons.view_list,
      'text': 'SliverAnimatedList is the sliver version of AnimatedList — '
          'use it inside CustomScrollView for animated list sections.',
    },
    {
      'icon': Icons.animation,
      'text': 'Each item gets an Animation<double>. Use SizeTransition for '
          'natural-feeling list animations, or combine with FadeTransition.',
    },
    {
      'icon': Icons.view_quilt,
      'text': 'Works alongside other slivers (SliverAppBar, SliverGrid, etc.) '
          'sharing a single scroll position for the entire view.',
    },
    {
      'icon': Icons.key,
      'text': 'Access state via GlobalKey<SliverAnimatedListState> for '
          'insertItem(), removeItem(), and batch operations.',
    },
    {
      'icon': Icons.sync,
      'text': 'Always synchronize your data model with the state operations. '
          'Insert into the list before calling insertItem(), and remove '
          'from the list when calling removeItem().',
    },
    {
      'icon': Icons.compare,
      'text': 'Use SliverAnimatedList instead of AnimatedList when your '
          'layout combines multiple scrolling sections in CustomScrollView.',
    },
  ];

  final summaryWidgets = <Widget>[];
  for (final item in summaryItems) {
    summaryWidgets.add(
      Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.indigo.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Icon(
                item['icon'] as IconData,
                size: 18.0,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Text(
                item['text'] as String,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey[800],
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final summaryTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.indigo.withValues(alpha: 0.1),
                Colors.indigo.withValues(alpha: 0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: const Column(
            children: [
              Icon(Icons.summarize, size: 40.0, color: Colors.indigo),
              SizedBox(height: 8.0),
              Text(
                'SliverAnimatedList — Key Takeaways',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        ...summaryWidgets,
      ],
    ),
  );

  // ============================================================
  // ASSEMBLE TABS
  // ============================================================
  print('Assembling SliverAnimatedList deep demo tabs');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.indigo,
      scaffoldBackgroundColor: Colors.grey[50],
    ),
    home: DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SliverAnimatedList Deep Demo'),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          elevation: 2.0,
          bottom: const TabBar(
            isScrollable: true,
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: [
              Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
              Tab(icon: Icon(Icons.code), text: 'Constructor'),
              Tab(icon: Icon(Icons.compare), text: 'vs AnimatedList'),
              Tab(icon: Icon(Icons.animation), text: 'Transitions'),
              Tab(icon: Icon(Icons.play_circle_outline), text: 'Live Demo'),
              Tab(icon: Icon(Icons.view_quilt), text: 'Mixed Slivers'),
              Tab(icon: Icon(Icons.pattern), text: 'Patterns'),
              Tab(icon: Icon(Icons.summarize), text: 'Summary'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            conceptTab,
            constructorTab,
            vsTab,
            transitionTab,
            liveTab,
            mixedTab,
            patternsTab,
            summaryTab,
          ],
        ),
      ),
    ),
  );
}

// ==================================================================
// Top-level helper functions
// ==================================================================

Widget buildSALSectionHeader(String title, IconData icon) {
  return Row(
    children: [
      Icon(icon, size: 20.0, color: Colors.indigo),
      const SizedBox(width: 8.0),
      Expanded(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: Colors.indigo,
          ),
        ),
      ),
    ],
  );
}

Widget buildSALBullet(String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6.0),
          width: 6.0,
          height: 6.0,
          decoration: const BoxDecoration(
            color: Colors.indigo,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSALMethodCard(String method, String desc, Color color) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          method,
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
            fontFamily: 'monospace',
            color: color,
          ),
        ),
        const SizedBox(height: 4.0),
        Text(
          desc,
          style: TextStyle(
            fontSize: 12.0,
            color: Colors.grey[600],
            height: 1.3,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSALTreeNode(String label, int depth, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 4.0, bottom: 3.0),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 11.0,
        fontFamily: 'monospace',
        color: color,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _buildSALLayoutBlock(
  String label,
  Color color,
  String desc,
  double height,
) {
  return Container(
    width: double.infinity,
    height: height,
    margin: const EdgeInsets.only(bottom: 4.0),
    padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
            color: color,
          ),
        ),
        Text(
          desc,
          style: TextStyle(
            fontSize: 10.0,
            color: color.withValues(alpha: 0.7),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSALPatternCard(
  String title,
  IconData icon,
  Color color,
  String desc,
  String code,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: color.withValues(alpha: 0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.06),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, size: 20.0, color: color),
              const SizedBox(width: 8.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: color,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            desc,
            style: TextStyle(
              fontSize: 12.5,
              color: Colors.grey[700],
              height: 1.4,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.greenAccent,
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}

// ==================================================================
// Transition Visuals
// ==================================================================

class _SALSizeTransitionVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (i) {
        final fraction = (i + 1) / 4.0;
        return Column(
          children: [
            Container(
              width: 50.0,
              height: 44.0 * fraction,
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.4)),
              ),
              child: Center(
                child: fraction >= 0.5
                    ? Text(
                        'Item',
                        style: TextStyle(
                          fontSize: 9.0,
                          color: Colors.blue[700],
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              '${(fraction * 100).toInt()}%',
              style: TextStyle(fontSize: 9.0, color: Colors.grey[600]),
            ),
          ],
        );
      }),
    );
  }
}

class _SALFadeTransitionVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (i) {
        final alpha = (i + 1) / 4.0;
        return Column(
          children: [
            Container(
              width: 50.0,
              height: 44.0,
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: alpha * 0.3),
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                  color: Colors.orange.withValues(alpha: alpha * 0.6),
                ),
              ),
              child: Center(
                child: Text(
                  'Item',
                  style: TextStyle(
                    fontSize: 9.0,
                    color: Colors.orange.withValues(alpha: alpha),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'α=${alpha.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 9.0, color: Colors.grey[600]),
            ),
          ],
        );
      }),
    );
  }
}

class _SALSlideTransitionVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (i) {
        final offset = 1.0 - (i / 3.0);
        return Column(
          children: [
            Container(
              width: 50.0,
              height: 56.0,
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: offset * 30,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 24.0,
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.2),
                        border: Border.all(
                          color: Colors.green.withValues(alpha: 0.4),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          'Item',
                          style: TextStyle(
                            fontSize: 8.0,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              '↓${(offset * 100).toInt()}%',
              style: TextStyle(fontSize: 9.0, color: Colors.grey[600]),
            ),
          ],
        );
      }),
    );
  }
}

class _SALCombinedTransitionVisual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (i) {
        final fraction = (i + 1) / 4.0;
        return Column(
          children: [
            Container(
              width: 50.0,
              height: 44.0 * fraction,
              decoration: BoxDecoration(
                color: Colors.purple.withValues(alpha: fraction * 0.25),
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                  color: Colors.purple.withValues(alpha: fraction * 0.5),
                ),
              ),
              child: Center(
                child: fraction >= 0.5
                    ? Text(
                        'Item',
                        style: TextStyle(
                          fontSize: 9.0,
                          color: Colors.purple.withValues(alpha: fraction),
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              '${(fraction * 100).toInt()}%',
              style: TextStyle(fontSize: 9.0, color: Colors.grey[600]),
            ),
          ],
        );
      }),
    );
  }
}

// ==================================================================
// Live Demo — Interactive SliverAnimatedList
// ==================================================================
class _SALLiveDemo extends StatefulWidget {
  @override
  State<_SALLiveDemo> createState() => _SALLiveDemoState();
}

class _SALLiveDemoState extends State<_SALLiveDemo> {
  final _listKey = GlobalKey<SliverAnimatedListState>();
  final _items = <_SALItem>[];
  int _nextId = 1;
  String _transition = 'Size';
  final _eventLog = <String>[];

  static const _icons = [
    Icons.star,
    Icons.favorite,
    Icons.bolt,
    Icons.emoji_nature,
    Icons.palette,
    Icons.music_note,
    Icons.sports_soccer,
    Icons.rocket_launch,
    Icons.diamond,
    Icons.local_fire_department,
  ];

  static const _itemColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.teal,
    Colors.pink,
    Colors.indigo,
    Colors.amber,
    Colors.cyan,
  ];

  void _addToEnd() {
    final item = _SALItem(
      id: _nextId,
      label: 'Item $_nextId',
      icon: _icons[_nextId % _icons.length],
      color: _itemColors[_nextId % _itemColors.length],
    );
    _nextId++;
    _items.add(item);
    _listKey.currentState?.insertItem(
      _items.length - 1,
      duration: const Duration(milliseconds: 350),
    );
    _eventLog.insert(0, '+ Added ${item.label} at end');
    setState(() {});
  }

  void _addToBeginning() {
    final item = _SALItem(
      id: _nextId,
      label: 'Item $_nextId',
      icon: _icons[_nextId % _icons.length],
      color: _itemColors[_nextId % _itemColors.length],
    );
    _nextId++;
    _items.insert(0, item);
    _listKey.currentState?.insertItem(
      0,
      duration: const Duration(milliseconds: 350),
    );
    _eventLog.insert(0, '+ Added ${item.label} at beginning');
    setState(() {});
  }

  void _removeFirst() {
    if (_items.isEmpty) return;
    final removed = _items.removeAt(0);
    _listKey.currentState?.removeItem(
      0,
      (context, animation) => _buildRemovedTile(removed, animation),
      duration: const Duration(milliseconds: 350),
    );
    _eventLog.insert(0, '- Removed ${removed.label} from beginning');
    setState(() {});
  }

  void _removeLast() {
    if (_items.isEmpty) return;
    final index = _items.length - 1;
    final removed = _items.removeAt(index);
    _listKey.currentState?.removeItem(
      index,
      (context, animation) => _buildRemovedTile(removed, animation),
      duration: const Duration(milliseconds: 350),
    );
    _eventLog.insert(0, '- Removed ${removed.label} from end');
    setState(() {});
  }

  Widget _buildTile(_SALItem item, Animation<double> animation) {
    final tile = Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: item.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: item.color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 36.0,
            height: 36.0,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(item.icon, color: item.color, size: 20.0),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.label,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                    color: item.color,
                  ),
                ),
                Text(
                  'ID: ${item.id}',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.drag_handle, color: Colors.grey[400], size: 20.0),
        ],
      ),
    );

    switch (_transition) {
      case 'Fade':
        return FadeTransition(opacity: animation, child: tile);
      case 'Slide':
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(animation),
          child: tile,
        );
      case 'Scale':
        return ScaleTransition(scale: animation, child: tile);
      default:
        return SizeTransition(sizeFactor: animation, child: tile);
    }
  }

  Widget _buildRemovedTile(_SALItem item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.red.withValues(alpha: 0.25)),
          ),
          child: Row(
            children: [
              const Icon(Icons.delete_outline, color: Colors.red, size: 20.0),
              const SizedBox(width: 12.0),
              Text(
                item.label,
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Colors.red,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Controls
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.indigo.withValues(alpha: 0.04),
            border: Border(
              bottom: BorderSide(color: Colors.indigo.withValues(alpha: 0.1)),
            ),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  _buildSALBtn('+ End', Icons.arrow_downward, Colors.green, _addToEnd),
                  const SizedBox(width: 4.0),
                  _buildSALBtn('+ Start', Icons.arrow_upward, Colors.blue, _addToBeginning),
                  const SizedBox(width: 4.0),
                  _buildSALBtn('- First', Icons.remove, Colors.orange, _removeFirst),
                  const SizedBox(width: 4.0),
                  _buildSALBtn('- Last', Icons.remove_circle_outline, Colors.red, _removeLast),
                ],
              ),
              const SizedBox(height: 8.0),
              Row(
                children: [
                  Text(
                    'Transition:',
                    style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ...['Size', 'Fade', 'Slide', 'Scale'].map((t) {
                    final isSelected = t == _transition;
                    return GestureDetector(
                      onTap: () => setState(() => _transition = t),
                      child: Container(
                        margin: const EdgeInsets.only(right: 4.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.indigo
                              : Colors.indigo.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          t,
                          style: TextStyle(
                            fontSize: 11.0,
                            color: isSelected ? Colors.white : Colors.indigo,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }),
                  const Spacer(),
                  Text(
                    '${_items.length} items',
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // List
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverAnimatedList(
                key: _listKey,
                initialItemCount: _items.length,
                itemBuilder: (context, index, animation) {
                  if (index < _items.length) {
                    return _buildTile(_items[index], animation);
                  }
                  return const SizedBox.shrink();
                },
              ),
              SliverToBoxAdapter(
                child: _items.isEmpty
                    ? Container(
                        padding: const EdgeInsets.all(40.0),
                        child: Column(
                          children: [
                            Icon(
                              Icons.inbox,
                              size: 48.0,
                              color: Colors.grey[300],
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              'Empty list — tap "+ End" or "+ Start" to add items',
                              style: TextStyle(
                                fontSize: 13.0,
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      )
                    : null,
              ),
              // Event log
              if (_eventLog.isNotEmpty)
                SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.all(12.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Event Log (last ${_eventLog.length > 5 ? 5 : _eventLog.length})',
                          style: TextStyle(
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        ...(_eventLog.length > 5
                                ? _eventLog.sublist(0, 5)
                                : _eventLog)
                            .map(
                          (e) => Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: Text(
                              e,
                              style: TextStyle(
                                fontSize: 10.0,
                                fontFamily: 'monospace',
                                color: e.startsWith('+')
                                    ? Colors.green[700]
                                    : Colors.red[700],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSALBtn(
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6.0),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 13.0, color: color),
              const SizedBox(width: 3.0),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SALItem {
  final int id;
  final String label;
  final IconData icon;
  final Color color;
  const _SALItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
  });
}
