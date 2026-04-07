// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — ReorderableList
// Demonstrates ReorderableList — the low-level Sliver-based widget that
// enables drag-and-drop reordering of list items. Unlike
// ReorderableListView which provides a complete scrollable list,
// ReorderableList is a SliverChildDelegate-based builder that can be
// embedded inside CustomScrollView alongside other slivers.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ReorderableList Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — ReorderableList as a Sliver
  // ============================================================
  print('=== Section 1: Concept ===');

  // ReorderableList is the underlying sliver that powers
  // ReorderableListView. It sits inside a CustomScrollView
  // and builds its children on demand using itemBuilder.
  //
  // Key properties:
  //   - itemCount (int): Number of items
  //   - itemBuilder (IndexedWidgetBuilder): Builds child at index
  //   - onReorder (ReorderCallback): Called when item moves
  //   - onReorderStart (void Function(int)): Drag started
  //   - onReorderEnd (void Function(int)): Drag ended
  //   - proxyDecorator: Customises the dragged item's appearance
  //
  // Since it's a sliver, it composes with SliverAppBar,
  // SliverList, SliverGrid, SliverPadding, etc.

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF283593), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.15),
          blurRadius: 12.0,
          offset: Offset(0, 6),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.reorder, size: 36.0, color: Color(0xFF283593)),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'ReorderableList',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A237E),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'A Sliver that enables drag-and-drop reordering of '
          'its children. Can be embedded inside CustomScrollView '
          'alongside other slivers like SliverAppBar, SliverGrid, '
          'and SliverToBoxAdapter.',
          style: TextStyle(fontSize: 14.0, color: Color(0xFF283593)),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'CustomScrollView(\n'
            '  slivers: [\n'
            '    SliverAppBar(title: ...),\n'
            '    SliverReorderableList(\n'
            '      itemCount: items.length,\n'
            '      itemBuilder: (ctx, i) => ...,\n'
            '      onReorder: (old, new_) => ...,\n'
            '    ),\n'
            '    SliverToBoxAdapter(child: footer),\n'
            '  ],\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Color(0xFF263238),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: ReorderableList vs ReorderableListView
  // ============================================================
  print('=== Section 2: List vs ListView ===');

  Widget buildCompareColumn(
    String title,
    String subtitle,
    Color color,
    List<Map<String, dynamic>> features,
  ) {
    return Container(
      width: 280.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color, width: 2.0),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 10.0, color: Colors.white70),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: features.map((f) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 3.0),
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: (f['positive'] as bool)
                        ? Color(0xFFE8F5E9)
                        : Color(0xFFFFF3E0),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        (f['positive'] as bool)
                            ? Icons.check_circle
                            : Icons.warning_amber,
                        color: (f['positive'] as bool)
                            ? Color(0xFF2E7D32)
                            : Color(0xFFF57C00),
                        size: 16.0,
                      ),
                      SizedBox(width: 6.0),
                      Expanded(
                        child: Text(
                          f['text'] as String,
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Colors.grey.shade700,
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
    );
  }

  final comparison = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text(
          'ReorderableList vs ReorderableListView',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            buildCompareColumn(
              'ReorderableList',
              'SliverReorderableList',
              Color(0xFF283593),
              [
                {
                  'text': 'Integrates with CustomScrollView',
                  'positive': true,
                },
                {
                  'text': 'Compose with other slivers',
                  'positive': true,
                },
                {
                  'text': 'Flexible layout control',
                  'positive': true,
                },
                {
                  'text': 'Requires manual scroll setup',
                  'positive': false,
                },
                {
                  'text': 'More boilerplate',
                  'positive': false,
                },
              ],
            ),
            buildCompareColumn(
              'ReorderableListView',
              'Convenience wrapper',
              Color(0xFF00695C),
              [
                {
                  'text': 'Ready-to-use scrollable list',
                  'positive': true,
                },
                {
                  'text': 'Simpler API',
                  'positive': true,
                },
                {
                  'text': 'Built-in header/footer',
                  'positive': true,
                },
                {
                  'text': 'Cannot mix with other slivers',
                  'positive': false,
                },
                {
                  'text': 'Less layout flexibility',
                  'positive': false,
                },
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Callback Lifecycle
  // ============================================================
  print('=== Section 3: Callback lifecycle ===');

  Widget buildCallbackCard(
    String name,
    String signature,
    String description,
    String timing,
    IconData icon,
    Color color,
  ) {
    return Container(
      width: 250.0,
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: color, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.1),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 24.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              signature,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 10.0,
                color: color,
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            description,
            style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
          ),
          SizedBox(height: 6.0),
          Row(
            children: [
              Icon(Icons.schedule, size: 14.0, color: Colors.grey.shade500),
              SizedBox(width: 4.0),
              Expanded(
                child: Text(
                  timing,
                  style: TextStyle(
                    fontSize: 10.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final callbackSection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Callback Lifecycle',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'ReorderableList fires callbacks at different stages of the drag.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            buildCallbackCard(
              'onReorderStart',
              'void Function(int index)',
              'Called when a drag operation begins. Use this '
                  'to show visual feedback like elevation or colour.',
              'Before any item movement',
              Icons.play_arrow,
              Color(0xFF4CAF50),
            ),
            buildCallbackCard(
              'onReorder',
              'void Function(int old, int new_)',
              'Called when the dragged item is dropped. Update '
                  'your data model here (removeAt + insert).',
              'After item is released',
              Icons.swap_vert,
              Color(0xFF2196F3),
            ),
            buildCallbackCard(
              'onReorderEnd',
              'void Function(int index)',
              'Called after the reorder animation completes. '
                  'Use for clean-up or analytics logging.',
              'After animation settles',
              Icons.stop,
              Color(0xFFF44336),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        // Direction arrow
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'onReorderStart',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 4.0),
              Icon(Icons.arrow_forward, size: 16.0, color: Colors.grey.shade600),
              SizedBox(width: 4.0),
              Text(
                'user drags...',
                style: TextStyle(
                  fontSize: 10.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey.shade500,
                ),
              ),
              SizedBox(width: 4.0),
              Icon(Icons.arrow_forward, size: 16.0, color: Colors.grey.shade600),
              SizedBox(width: 4.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'onReorder',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: 4.0),
              Icon(Icons.arrow_forward, size: 16.0, color: Colors.grey.shade600),
              SizedBox(width: 4.0),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Color(0xFFF44336),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  'onReorderEnd',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
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
  // SECTION 4: Multi-Sliver Layout Example
  // ============================================================
  print('=== Section 4: Multi-sliver layout ===');

  // Show how ReorderableList fits alongside other slivers
  // in a CustomScrollView. We simulate the layout visually.

  Widget buildSliverBlock(
    String name,
    String type,
    double height,
    Color color,
    bool isReorderable,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
      height: height,
      decoration: BoxDecoration(
        color: color.withValues(alpha: isReorderable ? 0.2 : 0.1),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: color,
          width: isReorderable ? 2.0 : 1.0,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 8.0,
            top: 6.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4.0),
              ),
              child: Text(
                type,
                style: TextStyle(
                  fontSize: 9.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isReorderable)
                  Icon(Icons.reorder, color: color, size: 20.0),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  final sliverLayout = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'Multi-Sliver CustomScrollView',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'ReorderableList fits naturally as one sliver among many.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        // Simulated scroll view
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Column(
            children: [
              buildSliverBlock(
                'App Bar',
                'SliverAppBar',
                50.0,
                Color(0xFF1976D2),
                false,
              ),
              buildSliverBlock(
                'Search / Filters',
                'SliverToBoxAdapter',
                40.0,
                Color(0xFF7B1FA2),
                false,
              ),
              buildSliverBlock(
                'Section: Pinned Items',
                'SliverList',
                45.0,
                Color(0xFF455A64),
                false,
              ),
              buildSliverBlock(
                'Section: Reorderable Tasks',
                'SliverReorderableList',
                80.0,
                Color(0xFFF57C00),
                true,
              ),
              buildSliverBlock(
                'Statistics Section',
                'SliverGrid',
                55.0,
                Color(0xFF00897B),
                false,
              ),
              buildSliverBlock(
                'Footer',
                'SliverToBoxAdapter',
                35.0,
                Color(0xFF5D4037),
                false,
              ),
            ],
          ),
        ),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Icon(Icons.lightbulb, color: Color(0xFFF57C00), size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Unlike ReorderableListView, ReorderableList '
                  'composes freely with SliverAppBar, SliverGrid, '
                  'and other sliver widgets in the same scroll view.',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Color(0xFFE65100),
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
  // SECTION 5: proxyDecorator — Custom Drag Appearance
  // ============================================================
  print('=== Section 5: proxyDecorator ===');

  // Show different proxyDecorator styles that change how the
  // dragged item looks while in flight.

  Widget buildProxyExample(
    String name,
    String description,
    Widget preview,
    Color accentColor,
  ) {
    return Container(
      width: 250.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accentColor.withValues(alpha: 0.5)),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.brush, color: accentColor, size: 18.0),
                SizedBox(width: 6.0),
                Text(
                  name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.0,
                    color: accentColor,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Text(
                  description,
                  style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
                ),
                SizedBox(height: 8.0),
                preview,
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Elevation shadow proxy
  final elevationProxy = Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.25),
          blurRadius: 16.0,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Row(
      children: [
        Icon(Icons.drag_indicator, color: Colors.grey.shade600, size: 18.0),
        SizedBox(width: 8.0),
        Text(
          'Elevated item',
          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );

  // Colored border proxy
  final colorBorderProxy = Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Color(0xFFE3F2FD),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: Color(0xFF1976D2), width: 3.0),
    ),
    child: Row(
      children: [
        Icon(Icons.open_with, color: Color(0xFF1976D2), size: 18.0),
        SizedBox(width: 8.0),
        Text(
          'Highlighted item',
          style: TextStyle(
            fontSize: 12.0,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1976D2),
          ),
        ),
      ],
    ),
  );

  // Scaled proxy
  final scaledProxy = Transform.scale(
    scale: 1.05,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Color(0xFFF3E5F5),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Color(0xFF7B1FA2), width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF7B1FA2).withValues(alpha: 0.2),
            blurRadius: 12.0,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.zoom_in, color: Color(0xFF7B1FA2), size: 18.0),
          SizedBox(width: 8.0),
          Text(
            'Scaled up item',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: Color(0xFF7B1FA2),
            ),
          ),
        ],
      ),
    ),
  );

  // Semi-transparent proxy
  final ghostProxy = Opacity(
    opacity: 0.6,
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Color(0xFFE8F5E9),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Color(0xFF388E3C).withValues(alpha: 0.5),
          width: 2.0,
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.opacity, color: Color(0xFF388E3C), size: 18.0),
          SizedBox(width: 8.0),
          Text(
            'Ghost item',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w500,
              color: Color(0xFF388E3C),
            ),
          ),
        ],
      ),
    ),
  );

  final proxySection = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFFAFAFA),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Text(
          'proxyDecorator — Drag Appearance',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Customise how the dragged item looks while in flight.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            buildProxyExample(
              'Elevation Shadow',
              'Default style — adds depth with shadow.',
              elevationProxy,
              Color(0xFF455A64),
            ),
            buildProxyExample(
              'Color Border',
              'Adds accent border to highlight drag state.',
              colorBorderProxy,
              Color(0xFF1976D2),
            ),
            buildProxyExample(
              'Scale Up',
              'Slightly enlarges the item during drag.',
              scaledProxy,
              Color(0xFF7B1FA2),
            ),
            buildProxyExample(
              'Ghost / Opacity',
              'Semi-transparent to see items beneath.',
              ghostProxy,
              Color(0xFF388E3C),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF263238),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'proxyDecorator: (child, index, animation) {\n'
            '  return AnimatedBuilder(\n'
            '    animation: animation,\n'
            '    builder: (ctx, child) {\n'
            '      final elevation =\n'
            '        lerpDouble(0, 6, animation.value);\n'
            '      return Material(\n'
            '        elevation: elevation ?? 0,\n'
            '        child: child,\n'
            '      );\n'
            '    },\n'
            '    child: child,\n'
            '  );\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Color(0xFF80CBC4),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Grocery List — Full Visual Example
  // ============================================================
  print('=== Section 6: Grocery list example ===');

  final groceryItems = <Map<String, dynamic>>[
    {'name': 'Avocados', 'qty': '3', 'icon': Icons.eco, 'color': Color(0xFF4CAF50), 'checked': false},
    {'name': 'Sourdough bread', 'qty': '1', 'icon': Icons.bakery_dining, 'color': Color(0xFF8D6E63), 'checked': true},
    {'name': 'Greek yogurt', 'qty': '2', 'icon': Icons.icecream, 'color': Color(0xFFE1F5FE), 'checked': false},
    {'name': 'Cherry tomatoes', 'qty': '1 box', 'icon': Icons.local_florist, 'color': Color(0xFFF44336), 'checked': false},
    {'name': 'Olive oil', 'qty': '500ml', 'icon': Icons.water_drop, 'color': Color(0xFFFFD54F), 'checked': true},
    {'name': 'Feta cheese', 'qty': '200g', 'icon': Icons.lunch_dining, 'color': Color(0xFFFFECB3), 'checked': false},
    {'name': 'Fresh basil', 'qty': '1 bunch', 'icon': Icons.grass, 'color': Color(0xFF66BB6A), 'checked': false},
    {'name': 'Lemons', 'qty': '4', 'icon': Icons.circle, 'color': Color(0xFFFFF176), 'checked': false},
  ];

  Widget buildGroceryItem(Map<String, dynamic> item, int index) {
    final checked = item['checked'] as bool;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: checked
            ? Colors.grey.shade100
            : Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: checked ? Colors.grey.shade300 : Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.drag_indicator,
            color: Colors.grey.shade400,
            size: 18.0,
          ),
          SizedBox(width: 8.0),
          Icon(
            checked ? Icons.check_box : Icons.check_box_outline_blank,
            color: checked ? Color(0xFF4CAF50) : Colors.grey.shade400,
            size: 20.0,
          ),
          SizedBox(width: 8.0),
          Icon(
            item['icon'] as IconData,
            color: checked ? Colors.grey.shade400 : (item['color'] as Color),
            size: 20.0,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              item['name'] as String,
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w500,
                decoration: checked ? TextDecoration.lineThrough : null,
                color: checked ? Colors.grey.shade400 : Colors.grey.shade800,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(4.0),
            ),
            child: Text(
              item['qty'] as String,
              style: TextStyle(
                fontSize: 10.0,
                fontFamily: 'monospace',
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  final groceryList = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Color(0xFF4CAF50),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0),
            ),
          ),
          child: Row(
            children: [
              Icon(Icons.shopping_cart, color: Colors.white, size: 22.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Grocery List',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Text(
                '${groceryItems.length} items',
                style: TextStyle(fontSize: 12.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Column(
            children: [
              for (var i = 0; i < groceryItems.length; i++)
                buildGroceryItem(groceryItems[i], i),
            ],
          ),
        ),
        SizedBox(height: 4.0),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Key and Index Requirements
  // ============================================================
  print('=== Section 7: Key and index requirements ===');

  final keyRequirements = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFC62828)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Color(0xFFC62828), size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Keys & Index — Common Pitfalls',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB71C1C),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildReorderableWarning(
          'Unique Keys required',
          'Every child in itemBuilder must have a unique Key. '
              'Without it, Flutter cannot track items during reorder '
              'and state may be lost.',
          Icons.vpn_key,
          Color(0xFFC62828),
        ),
        SizedBox(height: 8.0),
        _buildReorderableWarning(
          'Index must match data',
          'The index in the drag listener must correspond to '
              'the item\'s actual position in the data list. '
              'Mismatches cause wrong items to be reordered.',
          Icons.format_list_numbered,
          Color(0xFFE65100),
        ),
        SizedBox(height: 8.0),
        _buildReorderableWarning(
          'Adjust newIndex in onReorder',
          'When moving an item down, newIndex is one higher '
              'than expected because the source item still occupies '
              'its position. Adjust with:\n'
              'if (newIndex > oldIndex) newIndex--;',
          Icons.swap_vert,
          Color(0xFF4A148C),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFF1A237E),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'onReorder: (oldIndex, newIndex) {\n'
            '  // IMPORTANT: adjust index when moving down\n'
            '  if (newIndex > oldIndex) newIndex--;\n'
            '  final item = items.removeAt(oldIndex);\n'
            '  items.insert(newIndex, item);\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Color(0xFF90CAF9),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Summary
  // ============================================================
  print('=== Section 8: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFF283593), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Color(0xFF283593), size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildReorderableSummaryItem(
          Icons.view_stream,
          'Sliver-based',
          'Works inside CustomScrollView with other slivers',
          Color(0xFF283593),
        ),
        SizedBox(height: 8.0),
        _buildReorderableSummaryItem(
          Icons.swap_vert,
          'Three callbacks',
          'onReorderStart → onReorder → onReorderEnd',
          Color(0xFF4CAF50),
        ),
        SizedBox(height: 8.0),
        _buildReorderableSummaryItem(
          Icons.brush,
          'Customisable feedback',
          'proxyDecorator controls how dragged items look',
          Color(0xFF7B1FA2),
        ),
        SizedBox(height: 8.0),
        _buildReorderableSummaryItem(
          Icons.vpn_key,
          'Keys required',
          'Each child must have a unique Key for correct tracking',
          Color(0xFFF44336),
        ),
        SizedBox(height: 8.0),
        _buildReorderableSummaryItem(
          Icons.build,
          'Basis of ReorderableListView',
          'ReorderableListView is a convenience wrapper around this',
          Color(0xFFFF9800),
        ),
      ],
    ),
  );

  print('ReorderableList Deep Demo complete');

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Title bar
        Container(
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1A237E),
                Color(0xFF283593),
                Color(0xFF303F9F),
              ],
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.reorder, size: 48.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'ReorderableList',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Sliver-based drag-and-drop reordering',
                style: TextStyle(fontSize: 13.0, color: Colors.white70),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),

        conceptCard,
        SizedBox(height: 16.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '2. List vs ListView',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        comparison,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '3. Callback Lifecycle',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        callbackSection,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '4. Multi-Sliver Layout',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        sliverLayout,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '5. proxyDecorator Styles',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        proxySection,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '6. Grocery List Example',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        groceryList,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '7. Keys & Index Pitfalls',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        keyRequirements,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '8. Summary',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        summaryPanel,
        SizedBox(height: 40.0),
      ],
    ),
  );
}

// ================================================================
// Helpers
// ================================================================
Widget _buildReorderableWarning(
  String title,
  String description,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: color, size: 22.0),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color,
                ),
              ),
              SizedBox(height: 2.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 11.0,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildReorderableSummaryItem(
  IconData icon,
  String title,
  String desc,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(8.0),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 20.0),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold, color: color),
              ),
              Text(
                desc,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
