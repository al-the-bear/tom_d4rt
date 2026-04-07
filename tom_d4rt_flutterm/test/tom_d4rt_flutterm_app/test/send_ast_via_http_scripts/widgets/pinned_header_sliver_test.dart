// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — PinnedHeaderSliver widget
// Demonstrates PinnedHeaderSliver: a sliver that pins its child at the
// top of the viewport as the user scrolls. Useful for persistent headers,
// sticky section titles, and mini toolbars inside scrollable areas.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PinnedHeaderSliver Deep Demo executing');

  // ============================================================
  // SECTION 1: What Is PinnedHeaderSliver?
  // ============================================================
  // PinnedHeaderSliver is a sliver widget that takes a single
  // (non-sliver) child and pins it at the top of the scroll view.
  // When the user scrolls down, the pinned header remains visible
  // at the top of the viewport. This is the simplest way to add
  // a sticky header to a CustomScrollView without building a
  // full SliverPersistentHeaderDelegate.
  //
  // Key difference from SliverAppBar:
  //   - No expand/collapse behavior
  //   - No floating or snap
  //   - Just pins a plain widget at the top
  //   - Much simpler to configure
  print('=== Section 1: PinnedHeaderSliver Basics ===');

  // Basic example: a simple pinned header with a list below it.
  final basicExample = SizedBox(
    height: 300.0,
    child: CustomScrollView(
      slivers: [
        PinnedHeaderSliver(
          child: Container(
            color: Colors.indigo.shade700,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Row(
              children: [
                Icon(Icons.push_pin, color: Colors.white, size: 20.0),
                SizedBox(width: 8.0),
                Text(
                  'Pinned Header — always visible',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36.0,
                      height: 36.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.indigo.shade100,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo.shade700,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Text(
                      'Scroll item ${index + 1} — the header stays pinned',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: 30,
          ),
        ),
      ],
    ),
  );

  print('Created basic PinnedHeaderSliver example with 30 list items');

  final section1 = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.push_pin, color: Colors.indigo, size: 28.0),
            SizedBox(width: 10.0),
            Text(
              'PinnedHeaderSliver Basics',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'PinnedHeaderSliver wraps a regular widget and pins it at the '
            'top of a CustomScrollView. Unlike SliverAppBar, it has no '
            'expand/collapse, floating, or snapping behavior — it simply '
            'keeps the child visible at the top while the rest scrolls.',
            style: TextStyle(fontSize: 12.0, color: Colors.indigo.shade700),
          ),
        ),
        SizedBox(height: 16.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: basicExample,
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'Usage:\n'
            '  CustomScrollView(\n'
            '    slivers: [\n'
            '      PinnedHeaderSliver(child: myHeader),\n'
            '      SliverList(...),\n'
            '    ],\n'
            '  )',
            style: TextStyle(
              fontSize: 11.0,
              fontFamily: 'monospace',
              color: Colors.grey.shade800,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Styled Pinned Headers
  // ============================================================
  print('=== Section 2: Styled Pinned Headers ===');

  // Gradient header with search bar look
  final gradientHeader = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: [
        PinnedHeaderSliver(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple.shade700, Colors.purple.shade500],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: Colors.white70, size: 20.0),
                SizedBox(width: 8.0),
                Expanded(
                  child: Container(
                    height: 32.0,
                    padding: EdgeInsets.symmetric(horizontal: 12.0),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Search items...',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Icon(Icons.filter_list, color: Colors.white70, size: 20.0),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final colors = [
                Colors.deepPurple, Colors.purple, Colors.indigo,
                Colors.blue, Colors.teal,
              ];
              final color = colors[index % colors.length];
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: color.shade50,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32.0,
                      height: 32.0,
                      decoration: BoxDecoration(
                        color: color.shade200,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Icon(Icons.star, size: 16.0, color: color.shade700),
                    ),
                    SizedBox(width: 12.0),
                    Text(
                      'Item ${index + 1}',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: color.shade800,
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
    ),
  );

  // Dark toolbar header
  final darkToolbarHeader = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: [
        PinnedHeaderSliver(
          child: Container(
            color: Color(0xFF212121),
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              children: [
                Icon(Icons.menu, color: Colors.white, size: 20.0),
                SizedBox(width: 12.0),
                Text(
                  'Dark Toolbar',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Icon(Icons.view_list, color: Colors.grey.shade400, size: 18.0),
                SizedBox(width: 12.0),
                Icon(Icons.grid_view, color: Colors.grey.shade400, size: 18.0),
                SizedBox(width: 12.0),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                  decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '24',
                    style: TextStyle(
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                color: Color(0xFF303030),
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  children: [
                    Icon(Icons.folder, color: Colors.amber.shade400, size: 20.0),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        'Document ${index + 1}.pdf',
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                    Text(
                      '${(index * 127 + 42) % 999} KB',
                      style: TextStyle(
                        fontSize: 11.0,
                        color: Colors.grey.shade600,
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
    ),
  );

  print('Created gradient search header and dark toolbar header');

  final section2 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.purple.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.style, color: Colors.deepPurple, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Styled Pinned Headers',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Since PinnedHeaderSliver accepts any widget as its child, '
          'you can style the header however you like — gradients, dark '
          'themes, search bars, toolbars, or any custom design.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        Text(
          'Gradient Search Bar:',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple.shade700,
          ),
        ),
        SizedBox(height: 8.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: gradientHeader,
        ),
        SizedBox(height: 20.0),
        Text(
          'Dark Toolbar:',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w600,
            color: Colors.deepPurple.shade700,
          ),
        ),
        SizedBox(height: 8.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: darkToolbarHeader,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Multiple Pinned + Non-Pinned Slivers
  // ============================================================
  print('=== Section 3: Multiple Slivers ===');

  // Shows combining PinnedHeaderSliver with other slivers:
  // pinned header → sliver grid → pinned sub-header → sliver list
  final multiSliverExample = SizedBox(
    height: 350.0,
    child: CustomScrollView(
      slivers: [
        // Top pinned header
        PinnedHeaderSliver(
          child: Container(
            color: Colors.teal.shade700,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              children: [
                Icon(Icons.dashboard, color: Colors.white, size: 20.0),
                SizedBox(width: 8.0),
                Text(
                  'Catalog Browser',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Spacer(),
                Text(
                  '48 items',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.teal.shade200,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Grid section for featured items
        SliverPadding(
          padding: EdgeInsets.all(12.0),
          sliver: SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final gridColors = [
                  Colors.teal, Colors.cyan, Colors.blue, Colors.indigo,
                  Colors.purple, Colors.pink,
                ];
                final c = gridColors[index % gridColors.length];
                return Container(
                  decoration: BoxDecoration(
                    color: c.shade100,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: c.shade300),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.image, color: c.shade600, size: 28.0),
                      SizedBox(height: 4.0),
                      Text(
                        'Item ${index + 1}',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.w600,
                          color: c.shade800,
                        ),
                      ),
                    ],
                  ),
                );
              },
              childCount: 6,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              childAspectRatio: 1.2,
            ),
          ),
        ),
        // Second pinned header
        PinnedHeaderSliver(
          child: Container(
            color: Colors.teal.shade600,
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Icon(Icons.list, color: Colors.white, size: 18.0),
                SizedBox(width: 8.0),
                Text(
                  'All Items',
                  style: TextStyle(
                    fontSize: 13.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        // List below second header
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.teal.shade100),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 28.0,
                      height: 28.0,
                      decoration: BoxDecoration(
                        color: Colors.teal.shade100,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 11.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal.shade700,
                        ),
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Text(
                      'List item ${index + 1}',
                      style: TextStyle(
                        fontSize: 13.0,
                        color: Colors.grey.shade800,
                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: 30,
          ),
        ),
      ],
    ),
  );

  print('Created multi-sliver example with 2 pinned headers, grid, and list');

  final section3 = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.view_agenda, color: Colors.teal, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Multiple Pinned & Non-Pinned Slivers',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'You can combine multiple PinnedHeaderSlivers with grids, lists, '
          'and other slivers. Each PinnedHeaderSliver independently pins at '
          'the top. When two pinned headers collide, the lower one pushes '
          'the upper one out of view.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: multiSliverExample,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Tab-Style Header
  // ============================================================
  print('=== Section 4: Tab-Style Header ===');

  // Demonstrates using a TabBar-like row as a pinned header
  final tabStyleExample = SizedBox(
    height: 280.0,
    child: CustomScrollView(
      slivers: [
        PinnedHeaderSliver(
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      _buildTabItem('All', true, Colors.blue),
                      _buildTabItem('Active', false, Colors.green),
                      _buildTabItem('Archived', false, Colors.grey),
                      _buildTabItem('Starred', false, Colors.amber),
                    ],
                  ),
                ),
                Container(
                  height: 1.0,
                  color: Colors.grey.shade300,
                ),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final isStarred = index % 3 == 0;
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: isStarred ? Colors.amber.shade50 : Colors.white,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      isStarred ? Icons.star : Icons.star_border,
                      color: isStarred ? Colors.amber.shade600 : Colors.grey.shade400,
                      size: 20.0,
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Task ${index + 1}',
                            style: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade800,
                            ),
                          ),
                          Text(
                            'Last modified ${index + 1} days ago',
                            style: TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.0,
                      ),
                      decoration: BoxDecoration(
                        color: index % 2 == 0
                            ? Colors.green.shade100
                            : Colors.orange.shade100,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        index % 2 == 0 ? 'Active' : 'Pending',
                        style: TextStyle(
                          fontSize: 9.0,
                          fontWeight: FontWeight.bold,
                          color: index % 2 == 0
                              ? Colors.green.shade700
                              : Colors.orange.shade700,
                        ),
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
    ),
  );

  print('Created tab-style pinned header example');

  final section4 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.blue.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tab, color: Colors.blue, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Tab-Style Pinned Header',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.blue.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'A pinned header can hold tab-like navigation that stays '
          'visible while the content scrolls. This pattern is common '
          'in messaging apps, file browsers, and task managers.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: tabStyleExample,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Rich Content Header
  // ============================================================
  print('=== Section 5: Rich Content Header ===');

  // A header with more complex content: icon, title, subtitle,
  // stats chips — demonstrates that any widget tree can be pinned.
  final richHeaderExample = SizedBox(
    height: 320.0,
    child: CustomScrollView(
      slivers: [
        PinnedHeaderSliver(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 4.0,
                  offset: Offset(0.0, 2.0),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 44.0,
                  height: 44.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.orange.shade400, Colors.red.shade400],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.analytics, color: Colors.white, size: 24.0),
                ),
                SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Analytics Dashboard',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade900,
                        ),
                      ),
                      Text(
                        'Updated 5 min ago',
                        style: TextStyle(
                          fontSize: 10.0,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
                _buildHeaderChip('Live', Colors.green),
                SizedBox(width: 6.0),
                _buildHeaderChip('v2.1', Colors.blue),
              ],
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final metrics = [
                {'label': 'Page Views', 'value': '${(index + 1) * 1247}', 'icon': Icons.visibility, 'color': Colors.blue},
                {'label': 'Conversions', 'value': '${(index + 1) * 89}', 'icon': Icons.trending_up, 'color': Colors.green},
                {'label': 'Bounce Rate', 'value': '${30 + index * 2}%', 'icon': Icons.trending_down, 'color': Colors.red},
                {'label': 'Sessions', 'value': '${(index + 1) * 456}', 'icon': Icons.people, 'color': Colors.purple},
              ];
              final metric = metrics[index % metrics.length];
              final color = metric['color'] as MaterialColor;
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
                padding: EdgeInsets.all(14.0),
                decoration: BoxDecoration(
                  color: color.shade50,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36.0,
                      height: 36.0,
                      decoration: BoxDecoration(
                        color: color.shade200,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        metric['icon'] as IconData,
                        size: 18.0,
                        color: color.shade700,
                      ),
                    ),
                    SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        metric['label'] as String,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    Text(
                      metric['value'] as String,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: color.shade800,
                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: 24,
          ),
        ),
      ],
    ),
  );

  print('Created rich content header example with analytics data');

  final section5 = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.grey.shade50,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.orange.shade200, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.widgets, color: Colors.orange.shade700, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'Rich Content Header',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'PinnedHeaderSliver accepts any widget, so you can build '
          'complex headers with icons, titles, subtitles, chips, '
          'action buttons, and shadows — all pinned at the top.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        ClipRRect(
          borderRadius: BorderRadius.circular(12.0),
          child: richHeaderExample,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Comparison — PinnedHeaderSliver vs SliverAppBar
  // ============================================================
  print('=== Section 6: PinnedHeaderSliver vs SliverAppBar ===');

  // Side by side: PinnedHeaderSliver (simple pin) vs SliverAppBar (full features)
  final pinnedVsAppBar = Row(
    children: [
      Expanded(
        child: Column(
          children: [
            Text(
              'PinnedHeaderSliver',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade700,
              ),
            ),
            SizedBox(height: 6.0),
            SizedBox(
              height: 200.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CustomScrollView(
                  slivers: [
                    PinnedHeaderSliver(
                      child: Container(
                        color: Colors.teal.shade600,
                        padding: EdgeInsets.all(10.0),
                        alignment: Alignment.center,
                        child: Text(
                          'Simple Pin',
                          style: TextStyle(
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.teal.shade100),
                            ),
                          ),
                          child: Text(
                            'Row ${index + 1}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        childCount: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(width: 12.0),
      Expanded(
        child: Column(
          children: [
            Text(
              'SliverAppBar (pinned)',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrange.shade700,
              ),
            ),
            SizedBox(height: 6.0),
            SizedBox(
              height: 200.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      expandedHeight: 80.0,
                      backgroundColor: Colors.deepOrange.shade600,
                      flexibleSpace: FlexibleSpaceBar(
                        title: Text(
                          'Expand + Pin',
                          style: TextStyle(fontSize: 13.0),
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Container(
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.deepOrange.shade100,
                              ),
                            ),
                          ),
                          child: Text(
                            'Row ${index + 1}',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey.shade700,
                            ),
                          ),
                        ),
                        childCount: 20,
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

  print('Created side-by-side comparison');

  final section6 = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Colors.grey.shade300, width: 1.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare, color: Colors.deepPurple, size: 24.0),
            SizedBox(width: 8.0),
            Text(
              'PinnedHeaderSliver vs SliverAppBar',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade800,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'PinnedHeaderSliver is for simple pinning only. SliverAppBar '
          'offers expand/collapse, floating, snapping, and FlexibleSpaceBar. '
          'Choose PinnedHeaderSliver when you just need a sticky widget '
          'without any fancy scroll effects.',
          style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
        ),
        SizedBox(height: 16.0),
        pinnedVsAppBar,
        SizedBox(height: 16.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'When to use which:',
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                '• PinnedHeaderSliver: Static sticky header, no expansion\n'
                '• SliverAppBar(pinned): Expandable, with FlexibleSpaceBar\n'
                '• SliverAppBar(floating): Reappears on scroll up\n'
                '• SliverAppBar(snap): Snaps open/closed on partial scroll',
                style: TextStyle(
                  fontSize: 11.0,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // Final Assembly
  // ============================================================
  print('=== Assembling final layout ===');

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title bar
        Container(
          padding: EdgeInsets.fromLTRB(20.0, 48.0, 20.0, 20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.teal.shade800, Colors.teal.shade500],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PinnedHeaderSliver',
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'Pins a child widget at the top of a CustomScrollView. '
                'The simplest way to create sticky headers without '
                'SliverPersistentHeaderDelegate complexity.',
                style: TextStyle(fontSize: 13.0, color: Colors.teal.shade100),
              ),
            ],
          ),
        ),
        section1,
        SizedBox(height: 8.0),
        section2,
        SizedBox(height: 8.0),
        section3,
        SizedBox(height: 8.0),
        section4,
        SizedBox(height: 8.0),
        section5,
        SizedBox(height: 8.0),
        section6,
        SizedBox(height: 32.0),
      ],
    ),
  );
}

// ========================================================================
// Helper Functions
// ========================================================================

Widget _buildTabItem(String label, bool isActive, Color color) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isActive ? color : Colors.transparent,
            width: 2.0,
          ),
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.0,
          fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
          color: isActive ? color : Colors.grey.shade500,
        ),
      ),
    ),
  );
}

Widget _buildHeaderChip(String label, MaterialColor color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
    decoration: BoxDecoration(
      color: color.shade100,
      borderRadius: BorderRadius.circular(8.0),
    ),
    child: Text(
      label,
      style: TextStyle(
        fontSize: 9.0,
        fontWeight: FontWeight.bold,
        color: color.shade700,
      ),
    ),
  );
}
