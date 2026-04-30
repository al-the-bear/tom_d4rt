// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverAnimatedGrid
// Demonstrates SliverAnimatedGrid — a sliver that animates items as they are
// inserted into or removed from a grid. Used inside CustomScrollView for
// animated grid content with entry/exit transitions.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverAnimatedGrid Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptPoints = <Map<String, dynamic>>[
    {
      'icon': Icons.grid_view,
      'title': 'Animated Grid in Slivers',
      'body': 'SliverAnimatedGrid combines SliverGrid with automatic '
          'animation when items are inserted or removed. Each item can '
          'have a custom entry and exit transition, providing smooth '
          'visual updates to grid content.',
    },
    {
      'icon': Icons.animation,
      'title': 'Per-Item Transitions',
      'body': 'The itemBuilder receives an Animation<double> that drives '
          'the item\'s entry transition. When removing, you provide a '
          'separate builder with its own animation for the exit. This '
          'allows fade-in/out, scale, slide, or custom transitions.',
    },
    {
      'icon': Icons.view_quilt,
      'title': 'CustomScrollView Integration',
      'body': 'As a Sliver widget, SliverAnimatedGrid works inside '
          'CustomScrollView alongside other slivers (SliverAppBar, '
          'SliverList, SliverToBoxAdapter). Ideal for mixed-sliver '
          'layouts where one section is an animated grid.',
    },
    {
      'icon': Icons.key,
      'title': 'Programmatic Control',
      'body': 'Use a GlobalKey<SliverAnimatedGridState> to access '
          'insertItem(), removeItem(), and insertAllItems() methods. '
          'These methods trigger the animations and update the grid.',
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
          color: Colors.teal.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.teal.withValues(alpha: 0.12),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.teal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Icon(
                p['icon'] as IconData,
                color: Colors.teal,
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
                      color: Colors.teal,
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
                Colors.teal.withValues(alpha: 0.08),
                Colors.teal.withValues(alpha: 0.02),
              ],
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              const Icon(Icons.grid_view, size: 48.0, color: Colors.teal),
              const SizedBox(height: 8.0),
              const Text(
                'SliverAnimatedGrid',
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 6.0),
              Text(
                'A sliver that animates grid items as they are inserted '
                'or removed, with per-item entry and exit transitions.',
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
        const SizedBox(height: 16.0),
        buildSAGSectionHeader('Widget Hierarchy', Icons.account_tree),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSAGTreeNode('CustomScrollView', 0, Colors.blue),
              _buildSAGTreeNode('├─ SliverAppBar', 1, Colors.indigo),
              _buildSAGTreeNode('├─ SliverAnimatedGrid', 1, Colors.teal),
              _buildSAGTreeNode('│  ├─ gridDelegate', 2, Colors.orange),
              _buildSAGTreeNode('│  ├─ itemBuilder (with Animation)', 2, Colors.green),
              _buildSAGTreeNode('│  └─ initialItemCount', 2, Colors.purple),
              _buildSAGTreeNode('└─ SliverToBoxAdapter', 1, Colors.grey),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2: Constructor
  // ============================================================
  print('=== Section 2: Constructor ===');

  final constructorParams = <Map<String, String>>[
    {
      'name': 'gridDelegate',
      'type': 'SliverGridDelegate',
      'required': 'Yes',
      'desc': 'Controls the layout of children in the grid. Use '
          'SliverGridDelegateWithFixedCrossAxisCount for a fixed number '
          'of columns, or SliverGridDelegateWithMaxCrossAxisExtent for '
          'adaptive column widths.',
    },
    {
      'name': 'itemBuilder',
      'type': 'AnimatedItemBuilder',
      'required': 'Yes',
      'desc': 'Builder called for each item, receiving (context, index, '
          'animation). The Animation<double> drives the entry transition '
          '— use it with FadeTransition, ScaleTransition, etc.',
    },
    {
      'name': 'initialItemCount',
      'type': 'int',
      'required': 'No',
      'desc': 'Number of items initially in the grid. Defaults to 0. '
          'These items appear immediately without animation.',
    },
    {
      'name': 'findChildIndexCallback',
      'type': 'ChildIndexGetter?',
      'required': 'No',
      'desc': 'Callback to find the index of a child based on its key. '
          'Helps preserve state when items are reordered.',
    },
  ];

  final paramWidgets = <Widget>[];
  for (final param in constructorParams) {
    print('  Constructor param: ${param['name']}');
    paramWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.teal.withValues(alpha: 0.15)),
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
                    color: Colors.teal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4.0),
                  ),
                  child: Text(
                    param['name']!,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.0,
                      color: Colors.teal,
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
        buildSAGSectionHeader('Constructor Parameters', Icons.code),
        const SizedBox(height: 12.0),
        ...paramWidgets,
        const SizedBox(height: 16.0),
        buildSAGSectionHeader('Constructor Signature', Icons.text_snippet),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'const SliverAnimatedGrid({\n'
            '  Key? key,\n'
            '  required this.itemBuilder,\n'
            '  required this.gridDelegate,\n'
            '  this.findChildIndexCallback,\n'
            '  int initialItemCount = 0,\n'
            '})',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              color: Colors.greenAccent,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        buildSAGSectionHeader('itemBuilder Signature', Icons.build),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            'Widget Function(\n'
            '  BuildContext context,\n'
            '  int index,\n'
            '  Animation<double> animation,\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 13.0,
              color: Colors.cyanAccent,
              height: 1.5,
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        buildSAGBullet(
          'The animation parameter goes from 0.0 (fully hidden) to 1.0 '
          '(fully visible) during the entry transition.',
        ),
        buildSAGBullet(
          'For removal, you provide a separate builder via removeItem() '
          'that receives its own animation counting down from 1.0 to 0.0.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Insert Animation
  // ============================================================
  print('=== Section 3: Insert Animation ===');

  final insertTransitions = <Map<String, dynamic>>[
    {
      'name': 'FadeTransition',
      'desc': 'Items fade in from transparent to opaque. The most subtle '
          'insertion animation. Works well for content-heavy grids.',
      'icon': Icons.gradient,
      'color': Colors.blue,
      'stages': ['α=0.0', 'α=0.3', 'α=0.6', 'α=1.0'],
    },
    {
      'name': 'ScaleTransition',
      'desc': 'Items grow from a point. Creates a "pop" effect that draws '
          'attention to newly inserted items.',
      'icon': Icons.zoom_in,
      'color': Colors.orange,
      'stages': ['10%', '40%', '70%', '100%'],
    },
    {
      'name': 'SlideTransition',
      'desc': 'Items slide in from a direction. Good for sequential insertion '
          'where items appear to flow in from an edge.',
      'icon': Icons.arrow_forward,
      'color': Colors.green,
      'stages': ['↓100%', '↓66%', '↓33%', '↓0%'],
    },
    {
      'name': 'Combined (Fade + Scale)',
      'desc': 'Combining multiple transitions creates a richer effect. '
          'Items fade in while growing, a polished entry animation.',
      'icon': Icons.auto_awesome,
      'color': Colors.purple,
      'stages': ['tiny+α0', 'med+α.3', 'big+α.7', 'full+α1'],
    },
  ];

  final insertCards = <Widget>[];
  for (var i = 0; i < insertTransitions.length; i++) {
    final t = insertTransitions[i];
    print('  Insert transition: ${t['name']}');
    final stages = t['stages'] as List<String>;
    final clr = t['color'] as Color;

    insertCards.add(
      Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: clr.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(t['icon'] as IconData, size: 20.0, color: clr),
                const SizedBox(width: 8.0),
                Text(
                  t['name'] as String,
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w700,
                    color: clr,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              t['desc'] as String,
              style: TextStyle(
                fontSize: 12.5,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),
            const SizedBox(height: 10.0),
            Row(
              children: List.generate(stages.length, (si) {
                final fraction = (si + 1) / stages.length;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: si < stages.length - 1 ? 6.0 : 0.0,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: clr.withValues(
                              alpha: t['name'] == 'FadeTransition'
                                  ? fraction
                                  : 0.15,
                            ),
                            borderRadius: BorderRadius.circular(6.0),
                            border: Border.all(
                              color: clr.withValues(alpha: 0.4),
                            ),
                          ),
                          child: Center(
                            child: t['name'] == 'ScaleTransition'
                                ? Transform.scale(
                                    scale: fraction,
                                    child: Container(
                                      width: 30.0,
                                      height: 30.0,
                                      decoration: BoxDecoration(
                                        color: clr.withValues(alpha: 0.4),
                                        borderRadius:
                                            BorderRadius.circular(4.0),
                                      ),
                                    ),
                                  )
                                : Icon(
                                    Icons.widgets,
                                    size: 18.0 * fraction,
                                    color: clr,
                                  ),
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          stages[si],
                          style: TextStyle(
                            fontSize: 10.0,
                            color: Colors.grey[600],
                            fontFamily: 'monospace',
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 6.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_forward, size: 14.0, color: Colors.grey[400]),
                const SizedBox(width: 4.0),
                Text(
                  'animation: 0.0 → 1.0',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final insertTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSAGSectionHeader('Insert Transitions', Icons.add_circle_outline),
        const SizedBox(height: 8.0),
        Text(
          'When insertItem() is called, the itemBuilder receives an '
          'Animation<double> that transitions from 0.0 to 1.0. Use '
          'this with any transition widget.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
        ),
        const SizedBox(height: 14.0),
        ...insertCards,
        const SizedBox(height: 16.0),
        buildSAGSectionHeader('Code Pattern', Icons.code),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            '// Insert an item at index 2\n'
            'gridKey.currentState!.insertItem(\n'
            '  2,\n'
            '  duration: Duration(milliseconds: 300),\n'
            ');\n\n'
            '// itemBuilder receives the animation:\n'
            'itemBuilder: (context, index, animation) {\n'
            '  return FadeTransition(\n'
            '    opacity: animation,\n'
            '    child: _buildGridTile(index),\n'
            '  );\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.greenAccent,
              height: 1.5,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Remove Animation
  // ============================================================
  print('=== Section 4: Remove Animation ===');

  final removeTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSAGSectionHeader('Remove Transitions', Icons.remove_circle_outline),
        const SizedBox(height: 8.0),
        Text(
          'Removal uses a separate builder. When removeItem() is called, '
          'the removed item continues to display using the removal builder '
          'while the animation counts down from 1.0 to 0.0.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
        ),
        const SizedBox(height: 14.0),

        // Removal flow visualization
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Removal Flow',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 12.0),
              // Step-by-step flow
              _buildSAGRemovalStep(
                1,
                'Call removeItem(index, builder)',
                'You call removeItem on SliverAnimatedGridState, '
                'passing the index and a builder that describes how '
                'the item should look while being removed.',
                Colors.red,
              ),
              _buildSAGRemovalStep(
                2,
                'Item removed from data model',
                'Your data model (list) has the item removed. The '
                'remaining items shift. The grid updates accordingly.',
                Colors.orange,
              ),
              _buildSAGRemovalStep(
                3,
                'Removal builder animates',
                'The removal builder receives Animation<double> counting '
                'down from 1.0 to 0.0. Use FadeTransition, ScaleTransition, '
                'etc. to animate the exit.',
                Colors.amber,
              ),
              _buildSAGRemovalStep(
                4,
                'Item fully hidden, removed from tree',
                'When the animation completes, the removed item\'s widget '
                'is disposed and removed from the widget tree entirely.',
                Colors.green,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),

        // Visual of grid removal
        buildSAGSectionHeader('Before → After Removal', Icons.grid_on),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'Before',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  _buildSAGMiniGrid(
                    ['A', 'B', 'C', 'D', 'E', 'F'],
                    highlightIndex: 2,
                    highlightColor: Colors.red,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.grey[400],
                size: 24.0,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'Removing C',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  _buildSAGMiniGrid(
                    ['A', 'B', '·', 'D', 'E', 'F'],
                    highlightIndex: 2,
                    highlightColor: Colors.red.withValues(alpha: 0.3),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.arrow_forward,
                color: Colors.grey[400],
                size: 24.0,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  const Text(
                    'After',
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  _buildSAGMiniGrid(
                    ['A', 'B', 'D', 'E', 'F', ''],
                    highlightIndex: -1,
                    highlightColor: Colors.grey,
                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 16.0),
        buildSAGSectionHeader('Code Pattern', Icons.code),
        const SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            '// Remove item at index 2\n'
            'final removedItem = _items.removeAt(2);\n\n'
            'gridKey.currentState!.removeItem(\n'
            '  2,\n'
            '  (context, animation) {\n'
            '    // animation goes from 1.0 → 0.0\n'
            '    return FadeTransition(\n'
            '      opacity: animation,\n'
            '      child: _buildGridTile(removedItem),\n'
            '    );\n'
            '  },\n'
            '  duration: Duration(milliseconds: 300),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.greenAccent,
              height: 1.5,
            ),
          ),
        ),

        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.2)),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.warning_amber, color: Colors.amber, size: 20.0),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'Important: Remove the item from your data model BEFORE '
                  'calling removeItem() on the state. The removal builder '
                  'should use the captured removed item data, not an index '
                  'into the modified list.',
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
  // SECTION 5: Live Demo
  // ============================================================
  print('=== Section 5: Live Demo ===');

  final liveTab = _SAGLiveDemo();

  // ============================================================
  // SECTION 6: Grid Delegates
  // ============================================================
  print('=== Section 6: Grid Delegates ===');

  final delegateTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSAGSectionHeader('Grid Delegate Types', Icons.dashboard),
        const SizedBox(height: 8.0),
        Text(
          'SliverAnimatedGrid uses SliverGridDelegate to control the '
          'layout of grid cells. Two built-in delegates cover most use cases.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
        ),
        const SizedBox(height: 14.0),

        // Fixed Cross Axis Count
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.blue.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.grid_on, size: 20.0, color: Colors.blue),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'SliverGridDelegateWithFixedCrossAxisCount',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                'Creates a grid with a fixed number of columns (crossAxisCount). '
                'Each tile stretches to fill the available width divided by '
                'the column count.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10.0),
              _buildSAGMiniGridVisual(3, Colors.blue, 'crossAxisCount: 3'),
              const SizedBox(height: 8.0),
              _buildSAGMiniGridVisual(4, Colors.blue, 'crossAxisCount: 4'),
            ],
          ),
        ),
        const SizedBox(height: 12.0),

        // Max Cross Axis Extent
        Container(
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.04),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.orange.withValues(alpha: 0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.view_module, size: 20.0, color: Colors.orange),
                  SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'SliverGridDelegateWithMaxCrossAxisExtent',
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.orange,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                'Creates a grid where tiles have a maximum width. Calculates '
                'the number of columns automatically based on available space. '
                'Responsive-friendly.',
                style: TextStyle(
                  fontSize: 12.5,
                  color: Colors.grey[700],
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'maxCrossAxisExtent: 150.0',
                      style: TextStyle(
                        fontSize: 11.0,
                        fontFamily: 'monospace',
                        color: Colors.orange[700],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      '• On 320px screen → 2 columns (160px each)\n'
                      '• On 480px screen → 3 columns (160px each)\n'
                      '• On 768px screen → 5 columns (153px each)',
                      style: TextStyle(
                        fontSize: 11.5,
                        color: Colors.grey[700],
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),

        // Spacing parameters
        buildSAGSectionHeader('Spacing Parameters', Icons.space_bar),
        const SizedBox(height: 8.0),
        _buildSAGSpacingVisual(),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: State Key
  // ============================================================
  print('=== Section 7: State Key ===');

  final stateKeyMethods = <Map<String, String>>[
    {
      'method': 'insertItem(int index, {Duration duration})',
      'desc': 'Inserts a single item at the given index. Triggers the '
          'itemBuilder for the new item with an entry animation.',
    },
    {
      'method': 'insertAllItems(int index, int length, {Duration duration})',
      'desc': 'Inserts multiple items starting at the given index. More '
          'efficient than calling insertItem multiple times.',
    },
    {
      'method': 'removeItem(int index, AnimatedRemovedItemBuilder, {Duration})',
      'desc': 'Removes the item at the given index. The builder receives '
          'an animation for the exit transition.',
    },
    {
      'method': 'removeAllItems(AnimatedRemovedItemBuilder, {Duration})',
      'desc': 'Removes all items with the provided removal builder. '
          'Each item gets its own exit animation.',
    },
  ];

  final methodWidgets = <Widget>[];
  for (var i = 0; i < stateKeyMethods.length; i++) {
    final m = stateKeyMethods[i];
    print('  State method: ${m['method']}');
    methodWidgets.add(
      Container(
        margin: const EdgeInsets.only(bottom: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.teal.withValues(alpha: 0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    color: Colors.teal.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Center(
                    child: Text(
                      '${i + 1}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    m['method']!,
                    style: const TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'monospace',
                      color: Colors.teal,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.only(left: 32.0),
              child: Text(
                m['desc']!,
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
    );
  }

  final stateKeyTab = SingleChildScrollView(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildSAGSectionHeader('State Key & Methods', Icons.vpn_key),
        const SizedBox(height: 8.0),
        Text(
          'Use a GlobalKey<SliverAnimatedGridState> to access the grid\'s '
          'state object for programmatic insertion and removal.',
          style: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
        ),
        const SizedBox(height: 14.0),

        // Key setup code
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.grey[900],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: const Text(
            '// Create the key\n'
            'final _gridKey = GlobalKey<SliverAnimatedGridState>();\n\n'
            '// Assign to widget\n'
            'SliverAnimatedGrid(\n'
            '  key: _gridKey,\n'
            '  gridDelegate: ...,\n'
            '  itemBuilder: ...,\n'
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

        buildSAGSectionHeader('Available Methods', Icons.functions),
        const SizedBox(height: 12.0),
        ...methodWidgets,

        const SizedBox(height: 16.0),
        // Pattern: insert/remove with state sync
        Container(
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
                  Icon(Icons.sync, size: 20.0, color: Colors.teal),
                  SizedBox(width: 8.0),
                  Text(
                    'State Synchronization Pattern',
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              buildSAGBullet(
                'Always keep your data model in sync with the grid state. '
                'Insert into the list THEN call insertItem().',
              ),
              buildSAGBullet(
                'For removal, remove from the list and call removeItem() in '
                'the same setState(). Capture the removed item before deletion.',
              ),
              buildSAGBullet(
                'The itemBuilder should read from your data list by index, '
                'so the grid always reflects the current list state.',
              ),
            ],
          ),
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
      'icon': Icons.grid_view,
      'text': 'SliverAnimatedGrid is the sliver variant of AnimatedGrid — '
          'use it inside CustomScrollView for animated grid sections.',
    },
    {
      'icon': Icons.animation,
      'text': 'Each item gets an Animation<double> in its builder, enabling '
          'FadeTransition, ScaleTransition, SlideTransition, or custom combos.',
    },
    {
      'icon': Icons.remove_circle_outline,
      'text': 'Removal requires a separate builder — the removed item continues '
          'to display during the exit animation before being disposed.',
    },
    {
      'icon': Icons.vpn_key,
      'text': 'Use GlobalKey<SliverAnimatedGridState> for insertItem(), '
          'removeItem(), insertAllItems(), and removeAllItems().',
    },
    {
      'icon': Icons.dashboard,
      'text': 'Works with any SliverGridDelegate — fixed cross-axis count '
          'or max cross-axis extent. Choose based on your layout needs.',
    },
    {
      'icon': Icons.sync,
      'text': 'Always keep your data model synchronized with grid operations. '
          'Insert into the list first, then call insertItem() on the state.',
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
                color: Colors.teal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Icon(
                item['icon'] as IconData,
                size: 18.0,
                color: Colors.teal,
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
                Colors.teal.withValues(alpha: 0.1),
                Colors.teal.withValues(alpha: 0.03),
              ],
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: const Column(
            children: [
              Icon(Icons.summarize, size: 40.0, color: Colors.teal),
              SizedBox(height: 8.0),
              Text(
                'SliverAnimatedGrid — Key Takeaways',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16.0),
        ...summaryWidgets,
        const SizedBox(height: 20.0),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.teal.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.teal.withValues(alpha: 0.15)),
          ),
          child: Column(
            children: [
              const Text(
                'When To Use',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                'Use SliverAnimatedGrid when you have a grid of items that '
                'changes dynamically (add/remove) and you want smooth '
                'transitions. For static grids, use SliverGrid. For animated '
                'lists (not grids), use SliverAnimatedList.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.0,
                  color: Colors.grey[700],
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // ASSEMBLE TABS
  // ============================================================
  print('Assembling SliverAnimatedGrid deep demo tabs');

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.teal,
      scaffoldBackgroundColor: Colors.grey[50],
    ),
    home: DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('SliverAnimatedGrid Deep Demo'),
          backgroundColor: Colors.teal,
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
              Tab(icon: Icon(Icons.add_circle_outline), text: 'Insert'),
              Tab(icon: Icon(Icons.remove_circle_outline), text: 'Remove'),
              Tab(icon: Icon(Icons.play_circle_outline), text: 'Live Demo'),
              Tab(icon: Icon(Icons.dashboard), text: 'Delegates'),
              Tab(icon: Icon(Icons.vpn_key), text: 'State Key'),
              Tab(icon: Icon(Icons.summarize), text: 'Summary'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            conceptTab,
            constructorTab,
            insertTab,
            removeTab,
            liveTab,
            delegateTab,
            stateKeyTab,
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

Widget buildSAGSectionHeader(String title, IconData icon) {
  return Row(
    children: [
      Icon(icon, size: 20.0, color: Colors.teal),
      const SizedBox(width: 8.0),
      Expanded(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
            color: Colors.teal,
          ),
        ),
      ),
    ],
  );
}

Widget buildSAGBullet(String text) {
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
            color: Colors.teal,
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

Widget _buildSAGTreeNode(String label, int depth, Color color) {
  return Padding(
    padding: EdgeInsets.only(left: depth * 16.0, bottom: 4.0),
    child: Row(
      children: [
        Container(
          width: 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2.0),
          ),
        ),
        const SizedBox(width: 6.0),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.0,
            fontFamily: 'monospace',
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  );
}

Widget _buildSAGRemovalStep(
  int step,
  String title,
  String desc,
  Color color,
) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(14.0),
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                fontSize: 13.0,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              const SizedBox(height: 3.0),
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
        ),
      ],
    ),
  );
}

Widget _buildSAGMiniGrid(
  List<String> labels, {
  required int highlightIndex,
  required Color highlightColor,
}) {
  return Container(
    padding: const EdgeInsets.all(4.0),
    decoration: BoxDecoration(
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: Colors.grey[300]!),
    ),
    child: Wrap(
      spacing: 3.0,
      runSpacing: 3.0,
      children: List.generate(labels.length, (i) {
        final isHighlight = i == highlightIndex;
        return Container(
          width: 28.0,
          height: 28.0,
          decoration: BoxDecoration(
            color: isHighlight
                ? highlightColor
                : (labels[i].isEmpty
                    ? Colors.transparent
                    : Colors.teal.withValues(alpha: 0.15)),
            borderRadius: BorderRadius.circular(3.0),
            border: labels[i].isNotEmpty
                ? Border.all(
                    color: isHighlight
                        ? highlightColor
                        : Colors.teal.withValues(alpha: 0.3),
                  )
                : null,
          ),
          child: Center(
            child: Text(
              labels[i],
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.w600,
                color: isHighlight ? Colors.white : Colors.teal,
              ),
            ),
          ),
        );
      }),
    ),
  );
}

Widget _buildSAGMiniGridVisual(
  int columns,
  Color color,
  String label,
) {
  return Container(
    margin: const EdgeInsets.only(bottom: 6.0),
    padding: const EdgeInsets.all(8.0),
    decoration: BoxDecoration(
      color: Colors.grey[50],
      borderRadius: BorderRadius.circular(6.0),
      border: Border.all(color: Colors.grey[300]!),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.0,
            fontFamily: 'monospace',
            color: color,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 6.0),
        Wrap(
          spacing: 4.0,
          runSpacing: 4.0,
          children: List.generate(columns * 2, (i) {
            return Container(
              width: (280 / columns) - 8,
              height: 24.0,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(3.0),
                border: Border.all(color: color.withValues(alpha: 0.3)),
              ),
              child: Center(
                child: Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    ),
  );
}

Widget _buildSAGSpacingVisual() {
  return Container(
    padding: const EdgeInsets.all(14.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.teal.withValues(alpha: 0.15)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Spacing Parameters in Grid Delegates',
          style: TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.w700,
            color: Colors.teal,
          ),
        ),
        const SizedBox(height: 10.0),
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(3.0),
                            color: Colors.teal.withValues(alpha: 0.2),
                          ),
                        ),
                        Container(
                          width: 12.0,
                          color: Colors.orange.withValues(alpha: 0.3),
                          child: const Center(
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: Text(
                                'mainSpacing',
                                style: TextStyle(
                                  fontSize: 7.0,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(3.0),
                            color: Colors.teal.withValues(alpha: 0.2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'mainAxisSpacing',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.orange[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 80.0,
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(3.0),
                            color: Colors.teal.withValues(alpha: 0.2),
                          ),
                        ),
                        Container(
                          height: 12.0,
                          color: Colors.purple.withValues(alpha: 0.3),
                          child: const Center(
                            child: Text(
                              'crossAxisSpacing',
                              style: TextStyle(
                                fontSize: 7.0,
                                color: Colors.purple,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.all(3.0),
                            color: Colors.teal.withValues(alpha: 0.2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'crossAxisSpacing',
                    style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.purple[700],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

// ==================================================================
// Live Demo — Interactive SliverAnimatedGrid
// ==================================================================
class _SAGLiveDemo extends StatefulWidget {
  @override
  State<_SAGLiveDemo> createState() => _SAGLiveDemoState();
}

class _SAGLiveDemoState extends State<_SAGLiveDemo> {
  final _gridKey = GlobalKey<SliverAnimatedGridState>();
  final _items = <_SAGItem>[];
  int _nextId = 1;
  int _crossAxisCount = 3;
  String _transitionType = 'Fade';

  static const _colors = [
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

  void _addItem() {
    final color = _colors[_nextId % _colors.length];
    final item = _SAGItem(
      id: _nextId,
      label: 'Item $_nextId',
      color: color,
    );
    _nextId++;
    final insertIndex = _items.length;
    _items.add(item);
    _gridKey.currentState?.insertItem(
      insertIndex,
      duration: const Duration(milliseconds: 400),
    );
    setState(() {});
  }

  void _removeLastItem() {
    if (_items.isEmpty) return;
    final index = _items.length - 1;
    final removed = _items.removeAt(index);
    _gridKey.currentState?.removeItem(
      index,
      (context, animation) => _buildRemovedTile(removed, animation),
      duration: const Duration(milliseconds: 400),
    );
    setState(() {});
  }

  void _removeRandomItem() {
    if (_items.isEmpty) return;
    final index = (_items.length ~/ 2).clamp(0, _items.length - 1);
    final removed = _items.removeAt(index);
    _gridKey.currentState?.removeItem(
      index,
      (context, animation) => _buildRemovedTile(removed, animation),
      duration: const Duration(milliseconds: 400),
    );
    setState(() {});
  }

  void _clearAll() {
    if (_items.isEmpty) return;
    while (_items.isNotEmpty) {
      final removed = _items.removeAt(0);
      _gridKey.currentState?.removeItem(
        0,
        (context, animation) => _buildRemovedTile(removed, animation),
        duration: const Duration(milliseconds: 300),
      );
    }
    setState(() {});
  }

  Widget _buildTile(_SAGItem item, Animation<double> animation) {
    Widget child = Container(
      decoration: BoxDecoration(
        color: item.color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: item.color.withValues(alpha: 0.4)),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.widgets, color: item.color, size: 20.0),
            const SizedBox(height: 4.0),
            Text(
              item.label,
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.w600,
                color: item.color,
              ),
            ),
            Text(
              '#${item.id}',
              style: TextStyle(
                fontSize: 9.0,
                color: item.color.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );

    switch (_transitionType) {
      case 'Scale':
        return ScaleTransition(scale: animation, child: child);
      case 'Slide':
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      case 'Rotation':
        return RotationTransition(turns: animation, child: child);
      default:
        return FadeTransition(opacity: animation, child: child);
    }
  }

  Widget _buildRemovedTile(_SAGItem item, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.red.withValues(alpha: 0.4)),
          ),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.delete_outline, color: Colors.red, size: 18.0),
                Text(
                  item.label,
                  style: const TextStyle(fontSize: 10.0, color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Controls bar
        Container(
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.teal.withValues(alpha: 0.04),
            border: Border(
              bottom: BorderSide(color: Colors.teal.withValues(alpha: 0.1)),
            ),
          ),
          child: Column(
            children: [
              // Action buttons
              Row(
                children: [
                  _buildActionBtn('+ Add', Icons.add, Colors.green, _addItem),
                  const SizedBox(width: 6.0),
                  _buildActionBtn(
                    '- Last',
                    Icons.remove,
                    Colors.orange,
                    _removeLastItem,
                  ),
                  const SizedBox(width: 6.0),
                  _buildActionBtn(
                    '- Middle',
                    Icons.remove_circle_outline,
                    Colors.red,
                    _removeRandomItem,
                  ),
                  const SizedBox(width: 6.0),
                  _buildActionBtn(
                    'Clear',
                    Icons.clear_all,
                    Colors.grey,
                    _clearAll,
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              // Transition type selector
              Row(
                children: [
                  Text(
                    'Entry:',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ...['Fade', 'Scale', 'Slide', 'Rotation'].map((type) {
                    final isSelected = type == _transitionType;
                    return GestureDetector(
                      onTap: () => setState(() => _transitionType = type),
                      child: Container(
                        margin: const EdgeInsets.only(right: 4.0),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.teal
                              : Colors.teal.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Text(
                          type,
                          style: TextStyle(
                            fontSize: 11.0,
                            color: isSelected ? Colors.white : Colors.teal,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
              const SizedBox(height: 8.0),
              // Column count
              Row(
                children: [
                  Text(
                    'Columns:',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  ...[2, 3, 4, 5].map((count) {
                    final isSelected = count == _crossAxisCount;
                    return GestureDetector(
                      onTap: () => setState(() => _crossAxisCount = count),
                      child: Container(
                        margin: const EdgeInsets.only(right: 4.0),
                        width: 32.0,
                        height: 28.0,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.teal
                              : Colors.teal.withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        child: Center(
                          child: Text(
                            '$count',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: isSelected ? Colors.white : Colors.teal,
                              fontWeight: FontWeight.w700,
                            ),
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
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        // Grid content
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverAnimatedGrid(
                key: _gridKey,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _crossAxisCount,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index, animation) {
                  if (index < _items.length) {
                    return _buildTile(_items[index], animation);
                  }
                  return const SizedBox.shrink();
                },
                initialItemCount: _items.length,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _items.isEmpty
                        ? 'Tap "+ Add" to insert items into the animated grid'
                        : 'Try adding and removing items with different transitions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[500],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionBtn(
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
              Icon(icon, size: 14.0, color: color),
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

class _SAGItem {
  final int id;
  final String label;
  final Color color;
  const _SAGItem({required this.id, required this.label, required this.color});
}
