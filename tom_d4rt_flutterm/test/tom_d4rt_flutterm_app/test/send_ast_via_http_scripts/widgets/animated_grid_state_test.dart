// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — AnimatedGridState
// Demonstrates AnimatedGridState, the State object for AnimatedGrid.
// Covers insertItem / removeItem with smooth transitions, grid layout
// delegates, comparison with regular GridView, batch operations,
// and practical patterns for animated 2D collections.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedGridState Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — What is AnimatedGrid / AnimatedGridState?
  // ============================================================
  print('=== Section 1: Concept ===');

  final concepts = <Map<String, dynamic>>[
    {
      'icon': Icons.grid_view,
      'title': 'What is AnimatedGrid?',
      'body': 'AnimatedGrid is a scrollable 2D grid that animates '
          'items as they are inserted or removed. It is the grid '
          'counterpart of AnimatedList. Items slide, fade, or '
          'scale in/out automatically when the collection changes.',
      'accent': Colors.amber,
    },
    {
      'icon': Icons.settings_suggest,
      'title': 'AnimatedGridState',
      'body': 'AnimatedGridState is the State object behind '
          'AnimatedGrid. You access it via a GlobalKey to call '
          'insertItem() and removeItem(). These methods trigger '
          'the animation and rebuild the affected grid cells.',
      'accent': Colors.orange,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Grid vs List',
      'body': 'AnimatedGrid lays out children in a 2D grid using a '
          'SliverGridDelegate, while AnimatedList uses a single '
          'axis. Use AnimatedGrid when your items should wrap '
          'into multiple columns — photo galleries, dashboards, '
          'icon grids, product catalogs.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.animation,
      'title': 'Animation Model',
      'body': 'When you call insertItem(index), AnimatedGrid creates '
          'an AnimationController for that slot and passes an '
          'Animation<double> (0 → 1) to your itemBuilder. '
          'When you call removeItem(), it plays the reverse '
          'animation and then removes the slot.',
      'accent': Colors.deepPurple,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < concepts.length; i++) {
    final c = concepts[i];
    final accent = c['accent'] as Color;
    print('  Concept ${i + 1}: ${c['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [accent.withOpacity(0.14), accent.withOpacity(0.03)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: accent.withOpacity(0.35)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(c['icon'] as IconData, color: accent, size: 28),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title'] as String,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: accent,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      c['body'] as String,
                      style: TextStyle(
                        fontSize: 12,
                        height: 1.4,
                        color: Colors.grey.shade800,
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
  // SECTION 2: Key API Surface
  // ============================================================
  print('=== Section 2: API Surface ===');

  final apiMethods = <Map<String, dynamic>>[
    {
      'method': 'insertItem(int index, {Duration duration})',
      'description': 'Inserts an item at the given index and starts the '
          'entrance animation. The duration defaults to 300ms.',
      'icon': Icons.add_box,
      'color': Colors.green,
    },
    {
      'method': 'insertAllItems(int index, int length, {Duration duration})',
      'description': 'Inserts multiple items starting at index. Each item '
          'animates in sequence with a slight stagger.',
      'icon': Icons.library_add,
      'color': Colors.blue,
    },
    {
      'method': 'removeItem(int index, AnimatedRemovedItemBuilder, {Duration})',
      'description': 'Removes the item at index. The builder is called with '
          'the departing animation (1 → 0) so you can fade/shrink it out.',
      'icon': Icons.remove_circle,
      'color': Colors.red,
    },
    {
      'method': 'removeAllItems(AnimatedRemovedItemBuilder, {Duration})',
      'description': 'Removes all items with the given animation builder. '
          'Useful for clearing the entire grid with a sweep effect.',
      'icon': Icons.delete_sweep,
      'color': Colors.orange,
    },
  ];

  final apiCards = <Widget>[];
  for (var api in apiMethods) {
    final color = api['color'] as Color;
    print('  API: ${api['method'].toString().split('(').first}');
    apiCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(api['icon'] as IconData, color: color, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade900,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      api['method'] as String,
                      style: const TextStyle(
                        fontFamily: 'monospace',
                        fontSize: 10,
                        color: Colors.greenAccent,
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    api['description'] as String,
                    style: TextStyle(
                      fontSize: 11.5,
                      height: 1.4,
                      color: Colors.grey.shade700,
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

  final apiPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.api, color: Colors.amber.shade700, size: 22),
            const SizedBox(width: 10),
            Text(
              'AnimatedGridState — Key Methods',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...apiCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Live AnimatedGrid — Static Snapshot
  // ============================================================
  print('=== Section 3: AnimatedGrid Static Snapshot ===');

  // We create the AnimatedGrid with initial items to show
  // the grid layout and item builder pattern.

  final gridKey = GlobalKey<AnimatedGridState>();
  final gridItems = List.generate(12, (i) => 'Item ${i + 1}');

  final gridColors = [
    Colors.red.shade200,
    Colors.orange.shade200,
    Colors.amber.shade200,
    Colors.green.shade200,
    Colors.teal.shade200,
    Colors.blue.shade200,
    Colors.indigo.shade200,
    Colors.purple.shade200,
    Colors.pink.shade200,
    Colors.cyan.shade200,
    Colors.lime.shade200,
    Colors.brown.shade200,
  ];

  print('  Grid items: ${gridItems.length}');

  final animatedGridWidget = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'LIVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'AnimatedGrid with 12 Items',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'A grid with SliverGridDelegateWithFixedCrossAxisCount '
            '(3 columns). Each cell animates on insert/remove.',
            style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 380,
          child: AnimatedGrid(
            key: gridKey,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1.0,
            ),
            padding: const EdgeInsets.all(12),
            initialItemCount: gridItems.length,
            itemBuilder: (context, index, animation) {
              final color = gridColors[index % gridColors.length];
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation,
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: color.withOpacity(0.4),
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.widgets,
                            color: Colors.white.withOpacity(0.8),
                            size: 28,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            gridItems[index < gridItems.length
                                ? index
                                : gridItems.length - 1],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Insert Animation Patterns
  // ============================================================
  print('=== Section 4: Insert Animation Patterns ===');

  final insertPatterns = <Map<String, dynamic>>[
    {
      'name': 'Fade In',
      'description': 'Items appear by fading from transparent to opaque. '
          'Subtle and professional. Use FadeTransition wrapping '
          'your item widget.',
      'icon': Icons.opacity,
      'color': Colors.blue,
      'code': 'FadeTransition(\n'
          '  opacity: animation,\n'
          '  child: itemWidget,\n'
          ')',
    },
    {
      'name': 'Scale Up',
      'description': 'Items grow from zero to full size. Eye-catching '
          'for card-based layouts. Use ScaleTransition.',
      'icon': Icons.zoom_in,
      'color': Colors.green,
      'code': 'ScaleTransition(\n'
          '  scale: animation,\n'
          '  child: itemWidget,\n'
          ')',
    },
    {
      'name': 'Slide + Fade',
      'description': 'Items slide in from a direction while fading. '
          'Combine SlideTransition with FadeTransition for '
          'a polished effect.',
      'icon': Icons.swipe,
      'color': Colors.orange,
      'code': 'SlideTransition(\n'
          '  position: Tween<Offset>(\n'
          '    begin: Offset(0, 0.3),\n'
          '    end: Offset.zero,\n'
          '  ).animate(animation),\n'
          '  child: FadeTransition(\n'
          '    opacity: animation,\n'
          '    child: itemWidget,\n'
          '  ),\n'
          ')',
    },
    {
      'name': 'Size + Fade',
      'description': 'Items expand from zero height while fading in. '
          'Good for dense grids. Use SizeTransition with a '
          'vertical or horizontal axis.',
      'icon': Icons.expand,
      'color': Colors.purple,
      'code': 'SizeTransition(\n'
          '  sizeFactor: animation,\n'
          '  child: FadeTransition(\n'
          '    opacity: animation,\n'
          '    child: itemWidget,\n'
          '  ),\n'
          ')',
    },
  ];

  final insertWidgets = <Widget>[];
  for (var pattern in insertPatterns) {
    final color = pattern['color'] as Color;
    print('  Insert pattern: ${pattern['name']}');

    insertWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, color.withOpacity(0.6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      pattern['icon'] as IconData,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pattern['name'] as String,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          pattern['description'] as String,
                          style: TextStyle(
                            fontSize: 11.5,
                            height: 1.4,
                            color: Colors.grey.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                pattern['code'] as String,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10.5,
                  height: 1.5,
                  color: Colors.greenAccent,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final insertPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.add_circle, color: Colors.green, size: 22),
            const SizedBox(width: 10),
            Text(
              'Insert Animation Patterns',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...insertWidgets,
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Remove Animation Patterns
  // ============================================================
  print('=== Section 5: Remove Animation Patterns ===');

  final removePatterns = <Map<String, dynamic>>[
    {
      'name': 'Shrink & Fade',
      'description': 'The removed item shrinks to nothing while fading '
          'out. The surrounding items smoothly fill the gap.',
      'visual': Colors.red.shade100,
      'icon': Icons.close_fullscreen,
    },
    {
      'name': 'Fly Away',
      'description': 'The item slides off-screen to the side or bottom. '
          'Creates a dynamic, physical feeling of removal.',
      'visual': Colors.orange.shade100,
      'icon': Icons.flight_takeoff,
    },
    {
      'name': 'Collapse',
      'description': 'The item collapses its height to zero using '
          'SizeTransition. Grid reflows smoothly around it.',
      'visual': Colors.purple.shade100,
      'icon': Icons.unfold_less,
    },
  ];

  final removeCards = <Widget>[];
  for (var rem in removePatterns) {
    print('  Remove pattern: ${rem['name']}');

    removeCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            // "Before" state
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: rem['visual'] as Color,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red.shade300),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(rem['icon'] as IconData, color: Colors.red, size: 24),
                  const SizedBox(height: 4),
                  Text(
                    rem['name'] as String,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: Colors.red.shade700,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 16, color: Colors.grey.shade400),
            const SizedBox(width: 8),
            // "After" state — item gone
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.grey.shade300,
                  style: BorderStyle.solid,
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.layers_clear,
                  color: Colors.grey.shade300,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                rem['description'] as String,
                style: TextStyle(
                  fontSize: 11,
                  height: 1.4,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final removePanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.remove_circle, color: Colors.red, size: 22),
            const SizedBox(width: 10),
            Text(
              'Remove Animation Patterns',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'removeItem() takes an AnimatedRemovedItemBuilder that '
          'receives the reverse animation (1 → 0):',
          style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 12),
        ...removeCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Grid Delegate Comparison
  // ============================================================
  print('=== Section 6: Grid Delegates ===');

  // Show different grid delegate configurations visually

  Widget buildMiniGrid(int crossAxisCount, double aspect, Color color, String label) {
    final cells = <Widget>[];
    for (var i = 0; i < crossAxisCount * 3; i++) {
      cells.add(
        Container(
          decoration: BoxDecoration(
            color: color.withOpacity(0.3 + (i % 3) * 0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Text(
              '${i + 1}',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ),
        ),
      );
    }
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.25)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 100 * (3 / crossAxisCount) * aspect,
            child: GridView.count(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              childAspectRatio: aspect,
              physics: const NeverScrollableScrollPhysics(),
              children: cells,
            ),
          ),
        ],
      ),
    );
  }

  final delegatePanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.dashboard, color: Colors.teal, size: 22),
            const SizedBox(width: 10),
            Text(
              'SliverGridDelegate Configurations',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'AnimatedGrid accepts any SliverGridDelegate. Here are '
          'common layouts you can pass to the gridDelegate parameter:',
          style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 12),
        buildMiniGrid(2, 1.2, Colors.teal, '2 Columns (aspect 1.2)'),
        buildMiniGrid(3, 1.0, Colors.blue, '3 Columns (aspect 1.0)'),
        buildMiniGrid(4, 0.8, Colors.purple, '4 Columns (aspect 0.8)'),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Comparison — AnimatedGrid vs GridView
  // ============================================================
  print('=== Section 7: AnimatedGrid vs GridView ===');

  final comparisons = <Map<String, dynamic>>[
    {
      'feature': 'Item Insertion',
      'animated': 'Smooth animation (fade, scale, slide)',
      'regular': 'Instant — items just appear',
      'winner': 'animated',
    },
    {
      'feature': 'Item Removal',
      'animated': 'Animated departure + gap closing',
      'regular': 'Instant — items disappear, grid jumps',
      'winner': 'animated',
    },
    {
      'feature': 'Performance',
      'animated': 'Each item has its own AnimationController',
      'regular': 'Lightweight — no animation overhead',
      'winner': 'regular',
    },
    {
      'feature': 'GlobalKey Required',
      'animated': 'Yes — need to access AnimatedGridState',
      'regular': 'No — data-driven via builder or children',
      'winner': 'regular',
    },
    {
      'feature': 'Use Case',
      'animated': 'Dynamic collections with user feedback',
      'regular': 'Static or rarely-changing grids',
      'winner': 'tie',
    },
  ];

  final compRows = <Widget>[];
  // Table header
  compRows.add(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.amber.shade100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              'Feature',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
                color: Colors.amber.shade900,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'AnimatedGrid',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
                color: Colors.amber.shade900,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              'GridView',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 11,
                color: Colors.amber.shade900,
              ),
            ),
          ),
        ],
      ),
    ),
  );

  for (var i = 0; i < comparisons.length; i++) {
    final comp = comparisons[i];
    final isAnimWinner = comp['winner'] == 'animated';
    final isRegWinner = comp['winner'] == 'regular';
    print('  Compare: ${comp['feature']}');

    compRows.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: i.isEven ? Colors.grey.shade50 : Colors.white,
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                comp['feature'] as String,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isAnimWinner ? Colors.green.withOpacity(0.08) : null,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  comp['animated'] as String,
                  style: TextStyle(
                    fontSize: 10,
                    color: isAnimWinner ? Colors.green.shade700 : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isRegWinner ? Colors.green.withOpacity(0.08) : null,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  comp['regular'] as String,
                  style: TextStyle(
                    fontSize: 10,
                    color: isRegWinner ? Colors.green.shade700 : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final compPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: compRows,
    ),
  );

  // ============================================================
  // SECTION 8: GlobalKey Pattern
  // ============================================================
  print('=== Section 8: GlobalKey Pattern ===');

  final gkPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.indigo.shade50, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.indigo.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.vpn_key, color: Colors.indigo, size: 22),
            const SizedBox(width: 10),
            Text(
              'GlobalKey<AnimatedGridState>',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'To call insertItem() / removeItem(), you need a reference '
          'to the AnimatedGridState. The standard pattern is:',
          style: TextStyle(fontSize: 12, height: 1.4, color: Colors.grey.shade700),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            '// 1. Create the key\n'
            'final _gridKey = GlobalKey<AnimatedGridState>();\n\n'
            '// 2. Pass it to AnimatedGrid\n'
            'AnimatedGrid(\n'
            '  key: _gridKey,\n'
            '  gridDelegate: delegate,\n'
            '  itemBuilder: _buildItem,\n'
            '  initialItemCount: items.length,\n'
            ')\n\n'
            '// 3. Access state for operations\n'
            '_gridKey.currentState!.insertItem(items.length - 1);\n'
            '_gridKey.currentState!.removeItem(\n'
            '  index,\n'
            '  (ctx, anim) => _buildRemovedItem(ctx, anim),\n'
            ');',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              height: 1.5,
              color: Colors.greenAccent,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.amber.shade300),
          ),
          child: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: Colors.amber.shade700, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Keep your data list and the AnimatedGrid in sync! '
                  'Insert into your list BEFORE calling insertItem(). '
                  'Remove from your list AFTER the removal animation '
                  'completes (inside removeItem\'s builder).',
                  style: TextStyle(
                    fontSize: 11,
                    height: 1.4,
                    color: Colors.amber.shade800,
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
  // SECTION 9: Real-World Scenarios
  // ============================================================
  print('=== Section 9: Real-World Scenarios ===');

  final scenarios = <Map<String, dynamic>>[
    {
      'title': 'Photo Gallery',
      'description': 'User adds photos from camera or gallery. Each new '
          'photo scales in with a bounce effect. Deleting a photo '
          'shrinks it out and the remaining photos reflow.',
      'icon': Icons.photo_library,
      'color': Colors.pink,
      'gridColor': Colors.pink.shade200,
    },
    {
      'title': 'Dashboard Tiles',
      'description': 'A configurable dashboard where widgets can be '
          'added or removed. New tiles slide in from the bottom. '
          'Removing a tile causes it to fly away to the right.',
      'icon': Icons.dashboard_customize,
      'color': Colors.blue,
      'gridColor': Colors.blue.shade200,
    },
    {
      'title': 'Shopping Cart',
      'description': 'Products displayed in a grid. Adding to cart '
          'triggers a scale-down animation on the product card. '
          'Removing from cart reverses the effect.',
      'icon': Icons.shopping_cart,
      'color': Colors.green,
      'gridColor': Colors.green.shade200,
    },
    {
      'title': 'Tag / Chip Selection',
      'description': 'A wrap-like grid of selectable tags. Selected '
          'tags animate with a color transition and check mark. '
          'Deselected tags fade their check mark out.',
      'icon': Icons.label,
      'color': Colors.purple,
      'gridColor': Colors.purple.shade200,
    },
  ];

  final scenarioWidgets = <Widget>[];
  for (var scenario in scenarios) {
    final color = scenario['color'] as Color;
    final gridColor = scenario['gridColor'] as Color;
    print('  Scenario: ${scenario['title']}');

    // Build a mini preview grid for this scenario
    final previewCells = <Widget>[];
    for (var j = 0; j < 6; j++) {
      previewCells.add(
        Container(
          decoration: BoxDecoration(
            color: gridColor.withOpacity(0.5 + (j % 3) * 0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Center(
            child: Icon(
              scenario['icon'] as IconData,
              size: 16,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ),
      );
    }

    scenarioWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.04),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mini grid preview
            SizedBox(
              width: 80,
              height: 80,
              child: GridView.count(
                crossAxisCount: 3,
                mainAxisSpacing: 3,
                crossAxisSpacing: 3,
                physics: const NeverScrollableScrollPhysics(),
                children: previewCells,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(scenario['icon'] as IconData, size: 18, color: color),
                      const SizedBox(width: 8),
                      Text(
                        scenario['title'] as String,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    scenario['description'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.4,
                      color: Colors.grey.shade700,
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

  final scenarioPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.amber.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.lightbulb, color: Colors.amber.shade700, size: 22),
            const SizedBox(width: 10),
            Text(
              'Real-World Use Cases',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.amber.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...scenarioWidgets,
      ],
    ),
  );

  // ============================================================
  // SECTION 10: Summary
  // ============================================================
  print('=== Section 10: Summary ===');

  final summaryTiles = <Widget>[];
  final summaryData = [
    {'label': 'Grid Items', 'value': '${gridItems.length}', 'color': Colors.amber},
    {'label': 'API Methods', 'value': '${apiMethods.length}', 'color': Colors.green},
    {'label': 'Insert Patterns', 'value': '${insertPatterns.length}', 'color': Colors.blue},
    {'label': 'Remove Patterns', 'value': '${removePatterns.length}', 'color': Colors.red},
    {'label': 'Scenarios', 'value': '${scenarios.length}', 'color': Colors.purple},
  ];

  for (var item in summaryData) {
    final color = item['color'] as Color;
    summaryTiles.add(
      Container(
        width: 90,
        margin: const EdgeInsets.all(6),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Column(
          children: [
            Text(
              item['value'] as String,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              item['label'] as String,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    );
  }

  final summaryPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.amber.shade200, width: 2),
    ),
    child: Column(
      children: [
        Text(
          'AnimatedGridState — Summary',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.amber.shade800,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(alignment: WrapAlignment.center, children: summaryTiles),
      ],
    ),
  );

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  print('=== Assembling final layout ===');

  return Scaffold(
    appBar: AppBar(
      title: const Text('AnimatedGridState Deep Demo'),
      backgroundColor: Colors.amber.shade700,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.amber.shade50,
            child: Column(
              children: [
                Icon(Icons.grid_view, size: 48, color: Colors.amber.shade700),
                const SizedBox(height: 10),
                Text(
                  'AnimatedGridState',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'State object for AnimatedGrid — animated insertions '
                  'and removals in a scrollable 2D grid.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.amber.shade600,
                  ),
                ),
              ],
            ),
          ),
          _gridSectionHeader('1. Core Concepts'),
          ...conceptCards,
          _gridSectionHeader('2. Key API'),
          apiPanel,
          _gridSectionHeader('3. Live Grid'),
          animatedGridWidget,
          _gridSectionHeader('4. Insert Patterns'),
          insertPanel,
          _gridSectionHeader('5. Remove Patterns'),
          removePanel,
          _gridSectionHeader('6. Grid Delegates'),
          delegatePanel,
          _gridSectionHeader('7. AnimatedGrid vs GridView'),
          compPanel,
          _gridSectionHeader('8. GlobalKey Pattern'),
          gkPanel,
          _gridSectionHeader('9. Real-World Scenarios'),
          scenarioPanel,
          _gridSectionHeader('10. Summary'),
          summaryPanel,
          const SizedBox(height: 40),
        ],
      ),
    ),
  );
}

Widget _gridSectionHeader(String title) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 20, 16, 4),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: Colors.amber.shade700,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.amber.shade800,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}
