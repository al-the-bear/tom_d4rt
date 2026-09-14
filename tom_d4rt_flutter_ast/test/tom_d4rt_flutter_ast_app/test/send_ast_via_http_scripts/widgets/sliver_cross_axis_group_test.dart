// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverCrossAxisGroup
// Demonstrates SliverCrossAxisGroup — a sliver that arranges multiple
// child slivers side-by-side along the cross axis inside a
// CustomScrollView. Creates multi-column scrollable layouts where
// all columns scroll together in lockstep.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverCrossAxisGroup Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.view_column,
      'title': 'What Is SliverCrossAxisGroup?',
      'body': 'SliverCrossAxisGroup arranges multiple child slivers '
          'side-by-side along the cross axis. In a vertical '
          'CustomScrollView, this creates columns. All children scroll '
          'together as a single unit — there is one scroll position '
          'shared by all columns.',
    },
    {
      'icon': Icons.child_care,
      'title': 'Required Child Types',
      'body': 'Each child must be either a SliverCrossAxisExpanded (which '
          'takes a flex factor like Expanded in a Row) or a '
          'SliverConstrainedCrossAxis (which takes a fixed maxExtent). '
          'You cannot put raw slivers directly as children.',
    },
    {
      'icon': Icons.sync,
      'title': 'Synchronized Scrolling',
      'body': 'Unlike having separate ScrollViews side-by-side (which '
          'scroll independently), SliverCrossAxisGroup ensures all '
          'columns share a single scroll offset. Scrolling the '
          'viewport moves all columns simultaneously.',
    },
    {
      'icon': Icons.dashboard,
      'title': 'Common Use Cases',
      'body': 'Multi-column layouts in scrollable content: sidebar + '
          'content, newspaper-style columns, dashboard grids, split '
          'data views. Especially useful on tablets and desktops '
          'where horizontal space is abundant.',
    },
    {
      'icon': Icons.compare,
      'title': 'vs Row of ScrollViews',
      'body': 'Row with independent ScrollViews: each scrolls separately. '
          'SliverCrossAxisGroup in CustomScrollView: all columns share '
          'ONE scroll position. The group approach is what you want '
          'for coherent multi-column content.',
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
          color: Colors.pink.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.pink.withValues(alpha: 0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.pink.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                item['icon'] as IconData,
                color: Colors.pink,
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
                      color: Colors.pink,
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

  Widget buildSCAGParam(
    String name,
    String type,
    String desc,
    bool required,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.pink.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.pink.withValues(alpha: 0.12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: required
                  ? Colors.red.withValues(alpha: 0.1)
                  : Colors.green.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              required ? 'REQUIRED' : 'OPTIONAL',
              style: TextStyle(
                fontSize: 9.0,
                fontWeight: FontWeight.bold,
                color: required ? Colors.red : Colors.green.shade700,
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
                        color: Colors.pink,
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
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  desc,
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

  final constructorWidgets = [
    buildSCAGParam(
      'slivers',
      'List<Widget>',
      'The list of child slivers. Each child must be either a '
          'SliverCrossAxisExpanded (flex-based) or a '
          'SliverConstrainedCrossAxis (fixed maxExtent). This is '
          'enforced at runtime.',
      true,
    ),
    buildSCAGParam(
      'key',
      'Key?',
      'An optional key for this widget in the element tree.',
      false,
    ),
  ];

  // Valid children diagram
  final validChildrenCard = Container(
    margin: const EdgeInsets.only(top: 12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.teal.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.teal.withValues(alpha: 0.12)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.account_tree, color: Colors.teal, size: 20.0),
            SizedBox(width: 8.0),
            Text(
              'Valid Child Types',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: Colors.teal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        _buildChildTypeRow(
          'SliverCrossAxisExpanded',
          'flex: int',
          'Fills remaining cross-axis space proportionally',
          Colors.blue,
        ),
        const SizedBox(height: 6.0),
        _buildChildTypeRow(
          'SliverConstrainedCrossAxis',
          'maxExtent: double',
          'Fixed maximum cross-axis extent (e.g. 200px)',
          Colors.orange,
        ),
      ],
    ),
  );

  // Code sample
  final codeCard = Container(
    margin: const EdgeInsets.only(top: 12.0),
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
            fontSize: 11.5,
            fontFamily: 'monospace',
            color: Colors.green,
          ),
        ),
        SizedBox(height: 2.0),
        Text(
          'SliverCrossAxisGroup(\n'
          '  slivers: [\n'
          '    SliverCrossAxisExpanded(\n'
          '      flex: 1,\n'
          '      sliver: sidebarSliver,\n'
          '    ),\n'
          '    SliverCrossAxisExpanded(\n'
          '      flex: 2,\n'
          '      sliver: contentSliver,\n'
          '    ),\n'
          '  ],\n'
          ')',
          style: TextStyle(
            fontSize: 11.5,
            fontFamily: 'monospace',
            color: Colors.white70,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Two Columns
  // ============================================================
  print('=== Section 3: Two Columns ===');

  // Classic sidebar + content two-column demo
  Widget buildTwoColumnDemo(
    String label,
    int leftFlex,
    int rightFlex,
    Color leftColor,
    Color rightColor,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.pink.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              '$label (flex $leftFlex : $rightFlex)',
              style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
          ),
          const SizedBox(height: 6.0),
          SizedBox(
            height: 160.0,
            child: CustomScrollView(
              physics: const NeverScrollableScrollPhysics(),
              slivers: [
                SliverCrossAxisGroup(
                  slivers: [
                    SliverCrossAxisExpanded(
                      flex: leftFlex,
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, index) => Container(
                            margin: const EdgeInsets.all(3.0),
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              color: leftColor.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                color: leftColor.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.menu,
                                  size: 14.0,
                                  color: leftColor,
                                ),
                                const SizedBox(width: 6.0),
                                Text(
                                  'Nav ${index + 1}',
                                  style: TextStyle(
                                    fontSize: 11.0,
                                    fontWeight: FontWeight.bold,
                                    color: leftColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          childCount: 5,
                        ),
                      ),
                    ),
                    SliverCrossAxisExpanded(
                      flex: rightFlex,
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (ctx, index) => Container(
                            margin: const EdgeInsets.all(3.0),
                            padding: const EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: rightColor.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                color: rightColor.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.article,
                                  size: 14.0,
                                  color: rightColor,
                                ),
                                const SizedBox(width: 6.0),
                                Expanded(
                                  child: Text(
                                    'Content item ${index + 1}',
                                    style: TextStyle(
                                      fontSize: 11.0,
                                      color: rightColor,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          childCount: 5,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final twoColDemos = [
    buildTwoColumnDemo('A) Equal Split', 1, 1, Colors.indigo, Colors.teal),
    buildTwoColumnDemo('B) Sidebar + Content', 1, 3, Colors.purple, Colors.blue),
    buildTwoColumnDemo('C) Wide Sidebar', 2, 3, Colors.orange, Colors.green),
  ];

  print('Two-column demos built (3 variations)');

  // ============================================================
  // SECTION 4: Three Columns
  // ============================================================
  print('=== Section 4: Three Columns ===');

  // Dashboard-style three-column layout
  final threeColDemo = SizedBox(
    height: 220.0,
    child: CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverCrossAxisGroup(
          slivers: [
            // Left panel - navigation
            SliverCrossAxisExpanded(
              flex: 1,
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildColumnHeader('Navigation', Icons.menu, Colors.indigo),
                  _buildColumnItem('Dashboard', Icons.dashboard, Colors.indigo),
                  _buildColumnItem('Analytics', Icons.analytics, Colors.indigo),
                  _buildColumnItem('Reports', Icons.bar_chart, Colors.indigo),
                  _buildColumnItem('Settings', Icons.settings, Colors.indigo),
                ]),
              ),
            ),
            // Center panel - content
            SliverCrossAxisExpanded(
              flex: 2,
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildColumnHeader('Content', Icons.article, Colors.teal),
                  Container(
                    margin: const EdgeInsets.all(4.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.teal.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: Colors.teal.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Main content area',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'This column takes 2x the space of the navigation '
                          'and details panels. Perfect for the primary content.',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.grey.shade600,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(4.0),
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      color: Colors.teal.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.info_outline, size: 16.0, color: Colors.teal.shade300),
                        const SizedBox(width: 6.0),
                        const Expanded(
                          child: Text(
                            'Secondary content item',
                            style: TextStyle(fontSize: 11.0, color: Colors.teal),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
            // Right panel - details
            SliverCrossAxisExpanded(
              flex: 1,
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  _buildColumnHeader('Details', Icons.info, Colors.deepOrange),
                  _buildColumnItem('Status: Active', Icons.circle, Colors.deepOrange),
                  _buildColumnItem('Priority: High', Icons.flag, Colors.deepOrange),
                  _buildColumnItem('Tags: UI, Core', Icons.label, Colors.deepOrange),
                ]),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // Three-column annotations
  final threeColAnnotations = <Widget>[
    _buildAnnotationRow('Left (flex: 1)', 'Navigation sidebar', Colors.indigo),
    _buildAnnotationRow('Center (flex: 2)', 'Primary content area', Colors.teal),
    _buildAnnotationRow('Right (flex: 1)', 'Details / inspector panel', Colors.deepOrange),
  ];

  print('Three-column demo built');

  // ============================================================
  // SECTION 5: Live Demo
  // ============================================================
  print('=== Section 5: Live Demo ===');

  final liveWidget = _SCAGLiveDemo();

  // ============================================================
  // SECTION 6: Mixed Children
  // ============================================================
  print('=== Section 6: Mixed Children ===');

  // Combining SliverCrossAxisExpanded and SliverConstrainedCrossAxis
  final mixedDemo = SizedBox(
    height: 200.0,
    child: CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: [
        SliverCrossAxisGroup(
          slivers: [
            // Fixed-width sidebar
            SliverConstrainedCrossAxis(
              maxExtent: 100.0,
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(8.0),
                    color: Colors.purple.withValues(alpha: 0.1),
                    child: Column(
                      children: [
                        const Icon(Icons.bookmark, color: Colors.purple, size: 20.0),
                        const SizedBox(height: 4.0),
                        Text(
                          'Fixed\n100px',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.purple.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...[1, 2, 3].map((n) => Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(6.0),
                    color: Colors.purple.withValues(alpha: 0.06),
                    child: Center(
                      child: Text(
                        'Item $n',
                        style: const TextStyle(fontSize: 10.0, color: Colors.purple),
                      ),
                    ),
                  )),
                ]),
              ),
            ),
            // Flexible content
            SliverCrossAxisExpanded(
              flex: 1,
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: Colors.blue.withValues(alpha: 0.15),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.expand, color: Colors.blue, size: 18.0),
                            SizedBox(width: 6.0),
                            Text(
                              'Flexible (flex: 1)',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'This column expands to fill all remaining space '
                          'after the fixed 100px sidebar is allocated.',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.grey.shade600,
                            height: 1.3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...[1, 2, 3].map((n) => Container(
                    margin: const EdgeInsets.all(3.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Text(
                      'Content row $n — this area gets the remaining space',
                      style: const TextStyle(fontSize: 11.0, color: Colors.blue),
                    ),
                  )),
                ]),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // Mixed children explanation
  final mixedExplanation = Container(
    margin: const EdgeInsets.only(top: 12.0),
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.amber.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.amber.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.lightbulb_outline, color: Colors.amber, size: 20.0),
            const SizedBox(width: 8.0),
            Text(
              'How Mixed Children Work',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: Colors.amber.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8.0),
        Text(
          '1. SliverConstrainedCrossAxis children claim their fixed maxExtent first\n'
          '2. Remaining cross-axis space is divided among SliverCrossAxisExpanded children\n'
          '3. Expanded children share the remainder proportionally by flex factor\n\n'
          'Example: viewport=400px, one Constrained(100px), one Expanded(flex:1)\n'
          '→ Constrained gets 100px, Expanded gets 300px',
          style: TextStyle(
            fontSize: 11.5,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  print('Mixed children demo built');

  // ============================================================
  // SECTION 7: Scroll Synchronization
  // ============================================================
  print('=== Section 7: Scroll Synchronization ===');

  // Demonstrate how columns scroll together
  final scrollSyncWidget = _SCAGScrollSync();

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  Widget buildSCAGBullet(IconData icon, String text, Color color) {
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
    buildSCAGBullet(
      Icons.check_circle_outline,
      'SliverCrossAxisGroup places multiple slivers side-by-side on '
          'the cross axis within a single CustomScrollView.',
      Colors.green,
    ),
    buildSCAGBullet(
      Icons.check_circle_outline,
      'Children must be SliverCrossAxisExpanded or '
          'SliverConstrainedCrossAxis — no raw slivers.',
      Colors.green,
    ),
    buildSCAGBullet(
      Icons.check_circle_outline,
      'All columns scroll together — one scroll position for the '
          'entire group. No manual scroll synchronization needed.',
      Colors.green,
    ),
    buildSCAGBullet(
      Icons.check_circle_outline,
      'Mix fixed-width (Constrained) and flexible (Expanded) columns '
          'for sidebar-plus-content patterns.',
      Colors.green,
    ),
    buildSCAGBullet(
      Icons.check_circle_outline,
      'Use flex ratios to distribute space: flex 1:2:1 creates a '
          'narrow-wide-narrow three-column layout.',
      Colors.green,
    ),
    buildSCAGBullet(
      Icons.warning_amber,
      'Each column contributes to the overall scroll extent. The '
          'group uses the MAXIMUM scroll extent of all children.',
      Colors.orange,
    ),
    buildSCAGBullet(
      Icons.warning_amber,
      'Adding many columns on a narrow viewport can lead to unusable '
          'column widths. Consider responsive breakpoints.',
      Colors.orange,
    ),
    buildSCAGBullet(
      Icons.info_outline,
      'Combine with SliverMainAxisGroup for both cross-axis and main-axis '
          'sliver grouping in complex layouts.',
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
        title: const Text('SliverCrossAxisGroup Deep Demo'),
        backgroundColor: Colors.pink,
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
            Tab(text: 'Two Columns'),
            Tab(text: 'Three Columns'),
            Tab(text: 'Live Demo'),
            Tab(text: 'Mixed Children'),
            Tab(text: 'Scroll Sync'),
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
                        Colors.pink.withValues(alpha: 0.12),
                        Colors.pink.withValues(alpha: 0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.pink.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.pink.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.view_column,
                          color: Colors.pink,
                          size: 32.0,
                        ),
                      ),
                      const SizedBox(height: 12.0),
                      const Text(
                        'SliverCrossAxisGroup',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'Arrange multiple slivers side-by-side for '
                        'advanced multi-column scrollable layouts.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.grey.shade600,
                          height: 1.4,
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
                    color: Colors.pink.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.build_circle, color: Colors.pink, size: 28.0),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Constructor & Child Types',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'SliverCrossAxisGroup accepts a list of slivers, '
                        'each wrapped in a cross-axis allocation widget.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...constructorWidgets,
                validChildrenCard,
                codeCard,
                const SizedBox(height: 16.0),
                // Class hierarchy
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.pink.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: Colors.pink.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Class Hierarchy',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: Colors.pink,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      ...['Widget', '  └─ RenderObjectWidget',
                          '      └─ MultiChildRenderObjectWidget',
                          '          └─ SliverCrossAxisGroup']
                          .map((line) => Padding(
                            padding: const EdgeInsets.only(bottom: 2.0),
                            child: Text(
                              line,
                              style: TextStyle(
                                fontSize: 11.5,
                                fontFamily: 'monospace',
                                color: line.contains('SliverCrossAxisGroup')
                                    ? Colors.pink
                                    : Colors.grey.shade700,
                                fontWeight: line.contains('SliverCrossAxisGroup')
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          )),
                      const SizedBox(height: 6.0),
                      Text(
                        'Unlike most slivers (single child), SliverCrossAxisGroup '
                        'extends MultiChildRenderObjectWidget because it manages '
                        'multiple child slivers arranged on the cross axis.',
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
            ),
          ),

          // ===== TAB 3: Two Columns =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.pink.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.splitscreen, color: Colors.pink, size: 28.0),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Two-Column Layouts',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Different flex ratios produce different column widths. '
                        'Compare equal, sidebar+content, and wide sidebar layouts.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                ...twoColDemos,
              ],
            ),
          ),

          // ===== TAB 4: Three Columns =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.pink.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.view_week, color: Colors.pink, size: 28.0),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Three-Column Dashboard',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Navigation + Content + Details — a classic '
                        'desktop application layout using flex 1:2:1.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.pink.withValues(alpha: 0.2)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: threeColDemo,
                ),
                const SizedBox(height: 12.0),
                const Text(
                  'Column Layout:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: Colors.pink,
                  ),
                ),
                const SizedBox(height: 8.0),
                ...threeColAnnotations,
                const SizedBox(height: 16.0),
                // Widget tree
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: const Text(
                    'CustomScrollView\n'
                    '└── SliverCrossAxisGroup\n'
                    '    ├── SliverCrossAxisExpanded(flex: 1)\n'
                    '    │   └── SliverList [Navigation]\n'
                    '    ├── SliverCrossAxisExpanded(flex: 2)\n'
                    '    │   └── SliverList [Content]\n'
                    '    └── SliverCrossAxisExpanded(flex: 1)\n'
                    '        └── SliverList [Details]',
                    style: TextStyle(
                      fontSize: 10.5,
                      fontFamily: 'monospace',
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ===== TAB 5: Live Demo =====
          liveWidget,

          // ===== TAB 6: Mixed Children =====
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.pink.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.compare_arrows, color: Colors.pink, size: 28.0),
                      const SizedBox(height: 8.0),
                      const Text(
                        'Mixed Child Types',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        'Combine fixed-width SliverConstrainedCrossAxis with '
                        'flexible SliverCrossAxisExpanded children.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: Colors.pink.withValues(alpha: 0.2)),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: mixedDemo,
                ),
                mixedExplanation,
                const SizedBox(height: 16.0),
                // Pattern gallery
                Container(
                  padding: const EdgeInsets.all(14.0),
                  decoration: BoxDecoration(
                    color: Colors.pink.withValues(alpha: 0.03),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.pink.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Common Mixed Patterns',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: Colors.pink,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      _buildMixedPattern(
                        'Fixed Sidebar + Flexible',
                        'Constrained(200px) + Expanded(flex:1)',
                        Icons.view_sidebar,
                        Colors.purple,
                      ),
                      _buildMixedPattern(
                        'Three Panels (Fixed Sides)',
                        'Constrained(150px) + Expanded(flex:1) + Constrained(200px)',
                        Icons.view_column,
                        Colors.indigo,
                      ),
                      _buildMixedPattern(
                        'Icon Rail + Content',
                        'Constrained(56px) + Expanded(flex:1)',
                        Icons.vertical_split,
                        Colors.teal,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // ===== TAB 7: Scroll Sync =====
          scrollSyncWidget,

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
                        Colors.pink.withValues(alpha: 0.12),
                        Colors.pink.withValues(alpha: 0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12.0),
                    border: Border.all(
                      color: Colors.pink.withValues(alpha: 0.15),
                    ),
                  ),
                  child: Column(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.pink, size: 32.0),
                      const SizedBox(height: 10.0),
                      const Text(
                        'Summary',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      const SizedBox(height: 6.0),
                      Text(
                        'Key takeaways for SliverCrossAxisGroup',
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
                    color: Colors.pink.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: Colors.pink.withValues(alpha: 0.12),
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
                          color: Colors.pink,
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      _buildRefItem('Type', 'MultiChildRenderObjectWidget (sliver)'),
                      _buildRefItem('Key param', 'slivers (list of children)'),
                      _buildRefItem('Children', 'SliverCrossAxisExpanded or SliverConstrainedCrossAxis'),
                      _buildRefItem('Layout', 'Columns arranged on cross axis'),
                      _buildRefItem('Scrolling', 'All columns share one scroll offset'),
                      _buildRefItem('Scroll extent', 'Maximum of all children'),
                      _buildRefItem('Partner', 'SliverMainAxisGroup (main-axis grouping)'),
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
                      color: Colors.pink.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Text(
                      'SliverCrossAxisGroup — Multi-column slivers, one scroll.',
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink,
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
// LIVE DEMO (Interactive)
// ================================================================

class _SCAGLiveDemo extends StatefulWidget {
  @override
  State<_SCAGLiveDemo> createState() => _SCAGLiveDemoState();
}

class _SCAGLiveDemoState extends State<_SCAGLiveDemo> {
  int _columnCount = 2;
  final _flexValues = [1, 2, 1, 1];
  int _itemsPerColumn = 6;

  @override
  Widget build(BuildContext context) {
    print('Live demo: columns=$_columnCount, items=$_itemsPerColumn');

    final columnColors = [Colors.blue, Colors.teal, Colors.orange, Colors.purple];
    final columnIcons = [Icons.looks_one, Icons.looks_two, Icons.looks_3, Icons.looks_4];

    // Build column slivers
    final slivers = <Widget>[];
    for (var c = 0; c < _columnCount; c++) {
      final color = columnColors[c % columnColors.length];
      slivers.add(
        SliverCrossAxisExpanded(
          flex: _flexValues[c],
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (ctx, index) => Container(
                margin: const EdgeInsets.all(3.0),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: color.withValues(alpha: 0.25)),
                ),
                child: Row(
                  children: [
                    Icon(columnIcons[c % columnIcons.length],
                        size: 14.0, color: color),
                    const SizedBox(width: 4.0),
                    Expanded(
                      child: Text(
                        'C${c + 1} item ${index + 1}',
                        style: TextStyle(
                          fontSize: 10.5,
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              childCount: _itemsPerColumn,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Controls
          Container(
            padding: const EdgeInsets.all(14.0),
            decoration: BoxDecoration(
              color: Colors.pink.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.pink.withValues(alpha: 0.12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Interactive Controls',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.pink,
                  ),
                ),
                const SizedBox(height: 10.0),
                // Column count
                Row(
                  children: [
                    SizedBox(
                      width: 90.0,
                      child: Text(
                        'Columns:',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    ...List.generate(3, (i) {
                      final count = i + 2;
                      final selected = _columnCount == count;
                      return Padding(
                        padding: const EdgeInsets.only(right: 6.0),
                        child: InkWell(
                          onTap: () => setState(() => _columnCount = count),
                          borderRadius: BorderRadius.circular(6.0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14.0,
                              vertical: 6.0,
                            ),
                            decoration: BoxDecoration(
                              color: (selected ? Colors.pink : Colors.grey)
                                  .withValues(alpha: selected ? 0.15 : 0.08),
                              borderRadius: BorderRadius.circular(6.0),
                              border: Border.all(
                                color: (selected ? Colors.pink : Colors.grey)
                                    .withValues(alpha: 0.3),
                              ),
                            ),
                            child: Text(
                              '$count',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: selected ? Colors.pink : Colors.grey.shade600,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 8.0),
                // Items per column
                Row(
                  children: [
                    SizedBox(
                      width: 90.0,
                      child: Text(
                        'Items:',
                        style: TextStyle(
                          fontSize: 11.5,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: _itemsPerColumn.toDouble(),
                        min: 2.0,
                        max: 12.0,
                        divisions: 10,
                        activeColor: Colors.pink,
                        label: '$_itemsPerColumn',
                        onChanged: (v) =>
                            setState(() => _itemsPerColumn = v.toInt()),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 3.0,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.pink.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      child: Text(
                        '$_itemsPerColumn',
                        style: const TextStyle(
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                // Flex adjustments
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: List.generate(_columnCount, (i) {
                    final color = columnColors[i % columnColors.length];
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(6.0),
                        border: Border.all(color: color.withValues(alpha: 0.2)),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'C${i + 1} flex:',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                              color: color,
                            ),
                          ),
                          const SizedBox(width: 4.0),
                          InkWell(
                            onTap: _flexValues[i] > 1
                                ? () => setState(() => _flexValues[i]--)
                                : null,
                            child: Icon(Icons.remove_circle_outline,
                                size: 16.0, color: color),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Text(
                              '${_flexValues[i]}',
                              style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                                color: color,
                                fontFamily: 'monospace',
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: _flexValues[i] < 5
                                ? () => setState(() => _flexValues[i]++)
                                : null,
                            child: Icon(Icons.add_circle_outline,
                                size: 16.0, color: color),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          // Scrollable area
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.pink.withValues(alpha: 0.2)),
              ),
              clipBehavior: Clip.antiAlias,
              child: CustomScrollView(
                slivers: [
                  SliverCrossAxisGroup(slivers: slivers),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Colors.amber.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, size: 14.0, color: Colors.amber),
                const SizedBox(width: 6.0),
                Expanded(
                  child: Text(
                    'Adjust columns, items, and flex values. '
                    'All columns scroll together as one unit.',
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
// SCROLL SYNC DEMO
// ================================================================

class _SCAGScrollSync extends StatefulWidget {
  @override
  State<_SCAGScrollSync> createState() => _SCAGScrollSyncState();
}

class _SCAGScrollSyncState extends State<_SCAGScrollSync> {
  final _scrollController = ScrollController();
  double _scrollOffset = 0.0;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollOffset = _scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Scroll sync demo: offset=$_scrollOffset');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.pink.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                const Icon(Icons.sync, color: Colors.pink, size: 28.0),
                const SizedBox(height: 8.0),
                const Text(
                  'Synchronized Scrolling',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  'All columns share a single scroll offset. '
                  'Scroll to see both columns move in lockstep.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          // Scroll offset indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.straighten, size: 16.0, color: Colors.pink),
                    const SizedBox(width: 6.0),
                    Text(
                      'Scroll offset:',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.pink.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    '${_scrollOffset.toStringAsFixed(1)}px',
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.pink,
                      fontFamily: 'monospace',
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          // Scrollable columns
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(color: Colors.pink.withValues(alpha: 0.2)),
              ),
              clipBehavior: Clip.antiAlias,
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverCrossAxisGroup(
                    slivers: [
                      // Left: numbered items
                      SliverCrossAxisExpanded(
                        flex: 1,
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (ctx, index) => Container(
                              height: 50.0,
                              margin: const EdgeInsets.all(2.0),
                              decoration: BoxDecoration(
                                color: Colors.indigo.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  color: Colors.indigo.withValues(alpha: 0.2),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Left #${index + 1}',
                                  style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ),
                            ),
                            childCount: 20,
                          ),
                        ),
                      ),
                      // Right: colored tiles
                      SliverCrossAxisExpanded(
                        flex: 1,
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (ctx, index) {
                              final hue = (index * 18.0) % 360.0;
                              final c = HSVColor.fromAHSV(
                                1.0, hue, 0.35, 0.85,
                              ).toColor();
                              return Container(
                                height: 50.0,
                                margin: const EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  color: c.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(4.0),
                                  border: Border.all(
                                    color: c.withValues(alpha: 0.4),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Right #${index + 1}',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                      color: c,
                                    ),
                                  ),
                                ),
                              );
                            },
                            childCount: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.teal.withValues(alpha: 0.04),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.teal.withValues(alpha: 0.12)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.compare_arrows, color: Colors.teal, size: 16.0),
                    SizedBox(width: 6.0),
                    Text(
                      'Key Observation',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                        color: Colors.teal,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4.0),
                Text(
                  'Both columns have 20 items at 50px each. Both share the '
                  'same scroll offset displayed above. Scrolling anywhere on the '
                  'viewport moves ALL columns simultaneously.',
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
      ),
    );
  }
}

// ================================================================
// HELPER FUNCTIONS
// ================================================================

Widget _buildChildTypeRow(
  String name,
  String param,
  String desc,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.15)),
    ),
    child: Row(
      children: [
        Icon(Icons.widgets, size: 16.0, color: color),
        const SizedBox(width: 8.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 11.5,
                      fontWeight: FontWeight.bold,
                      color: color,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(width: 6.0),
                  Text(
                    param,
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.grey.shade500,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 10.5,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildColumnHeader(String title, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.all(3.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    color: color.withValues(alpha: 0.15),
    child: Row(
      children: [
        Icon(icon, size: 16.0, color: color),
        const SizedBox(width: 6.0),
        Text(
          title,
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    ),
  );
}

Widget _buildColumnItem(String label, IconData icon, Color color) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 2.0),
    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(4.0),
    ),
    child: Row(
      children: [
        Icon(icon, size: 13.0, color: color.withValues(alpha: 0.6)),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(fontSize: 10.5, color: color),
        ),
      ],
    ),
  );
}

Widget _buildAnnotationRow(String label, String desc, Color color) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 6.0),
    child: Row(
      children: [
        Container(
          width: 12.0,
          height: 12.0,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(3.0),
            border: Border.all(color: color.withValues(alpha: 0.5)),
          ),
        ),
        const SizedBox(width: 8.0),
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Expanded(
          child: Text(
            desc,
            style: TextStyle(fontSize: 10.5, color: Colors.grey.shade600),
          ),
        ),
      ],
    ),
  );
}

Widget _buildMixedPattern(
  String title,
  String code,
  IconData icon,
  Color color,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 8.0),
    padding: const EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.04),
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: color.withValues(alpha: 0.12)),
    ),
    child: Row(
      children: [
        Icon(icon, size: 18.0, color: color),
        const SizedBox(width: 10.0),
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
                code,
                style: TextStyle(
                  fontSize: 10.5,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildRefItem(String label, String value) {
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
            style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
          ),
        ),
      ],
    ),
  );
}
