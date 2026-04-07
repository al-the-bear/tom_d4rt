// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — AnimatedListState
// Demonstrates AnimatedListState, the State object for AnimatedList.
// Covers insertItem / removeItem with animated transitions, item builder
// patterns, separated list variant, reorder strategies, batch operations,
// and practical patterns for animated linear collections.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AnimatedListState Deep Demo executing');

  // ============================================================
  // SECTION 1: What is AnimatedList / AnimatedListState?
  // ============================================================
  print('=== Section 1: Core Concepts ===');

  final concepts = <Map<String, dynamic>>[
    {
      'icon': Icons.list_alt,
      'title': 'AnimatedList Overview',
      'body': 'AnimatedList is a scrollable list that animates items '
          'on insertion and removal. Items can fade, slide, scale, '
          'or use any combination of transitions. It replaces '
          'ListView when you need visual feedback for list changes.',
      'color': Colors.cyan,
    },
    {
      'icon': Icons.key,
      'title': 'AnimatedListState',
      'body': 'AnimatedListState is the State class behind AnimatedList. '
          'You access it via a GlobalKey<AnimatedListState> to call '
          'insertItem(), removeItem(), and insertAllItems(). These '
          'trigger the entrance/exit animations automatically.',
      'color': Colors.teal,
    },
    {
      'icon': Icons.swap_vert,
      'title': 'Insert vs Remove Flow',
      'body': 'insertItem(index) creates an AnimationController and '
          'drives its value from 0→1, passing the Animation to your '
          'itemBuilder. removeItem(index, builder) drives 1→0 and '
          'uses the special builder for the departing widget.',
      'color': Colors.orange,
    },
    {
      'icon': Icons.compare,
      'title': 'AnimatedList vs ListView',
      'body': 'ListView rebuilds instantly when its children change. '
          'AnimatedList adds a temporal dimension — items transition '
          'smoothly. Use AnimatedList for dynamic collections '
          '(chat, todo, shopping cart) where users expect feedback.',
      'color': Colors.deepPurple,
    },
  ];

  final conceptCards = <Widget>[];
  for (var i = 0; i < concepts.length; i++) {
    final c = concepts[i];
    final color = c['color'] as Color;
    print('  Concept: ${c['title']}');
    conceptCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.12), color.withOpacity(0.02)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(c['icon'] as IconData, color: color, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      c['title'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      c['body'] as String,
                      style: TextStyle(
                        fontSize: 11.5,
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
  // SECTION 2: API Methods
  // ============================================================
  print('=== Section 2: API Methods ===');

  final apiEntries = <Map<String, dynamic>>[
    {
      'method': 'insertItem(int index, {Duration duration})',
      'desc': 'Insert an item at index. The animation controller runs '
          'from 0→1 over the given duration (default 300ms). Your '
          'itemBuilder receives the animation to drive transitions.',
      'icon': Icons.add,
      'color': Colors.green,
    },
    {
      'method': 'insertAllItems(int index, int length, {Duration duration})',
      'desc': 'Insert multiple items starting at index. Items animate '
          'in staggered sequence for a flowing cascade.',
      'icon': Icons.playlist_add,
      'color': Colors.blue,
    },
    {
      'method': 'removeItem(int index, AnimatedRemovedItemBuilder, {Duration})',
      'desc': 'Remove item at index. The builder gets the reverse '
          'animation (1→0) so you can fade/slide out. List '
          'compression happens automatically as the animation plays.',
      'icon': Icons.remove,
      'color': Colors.red,
    },
    {
      'method': 'removeAllItems(AnimatedRemovedItemBuilder, {Duration})',
      'desc': 'Remove all items with the provided removal builder. '
          'Useful for a "clear all" with visual feedback.',
      'icon': Icons.clear_all,
      'color': Colors.orange,
    },
  ];

  final apiCards = <Widget>[];
  for (var api in apiEntries) {
    final color = api['color'] as Color;
    print('  API: ${api['method'].toString().split('(').first}');
    apiCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(api['icon'] as IconData, color: color, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
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
                      api['desc'] as String,
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
      ),
    );
  }

  final apiPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.api, color: Colors.cyan.shade700, size: 22),
            const SizedBox(width: 10),
            Text(
              'AnimatedListState — API Surface',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade800,
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
  // SECTION 3: Live AnimatedList Demo
  // ============================================================
  print('=== Section 3: Live AnimatedList ===');

  final listKey = GlobalKey<AnimatedListState>();
  final listItems = <String>[
    'Buy groceries',
    'Review pull request',
    'Deploy to staging',
    'Write documentation',
    'Run test suite',
    'Schedule meeting',
    'Update dependencies',
  ];

  final itemColors = [
    Colors.red,
    Colors.orange,
    Colors.amber,
    Colors.green,
    Colors.teal,
    Colors.blue,
    Colors.indigo,
  ];

  print('  List items: ${listItems.length}');

  final liveListWidget = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.cyan.shade200),
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
                  color: Colors.cyan,
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
                  'Todo List — AnimatedList',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan.shade800,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Each todo slides in from the left with a fade. '
            'Completed items slide out to the right.',
            style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 380,
          child: AnimatedList(
            key: listKey,
            initialItemCount: listItems.length,
            itemBuilder: (context, index, animation) {
              final color = itemColors[index % itemColors.length];
              return SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(-1, 0),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                )),
                child: FadeTransition(
                  opacity: animation,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 4,
                    ),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: color.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.15),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: color,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            listItems[index < listItems.length
                                ? index
                                : listItems.length - 1],
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade800,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: Colors.grey.shade400,
                          size: 20,
                        ),
                      ],
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
  // SECTION 4: Transition Catalog
  // ============================================================
  print('=== Section 4: Transition Catalog ===');

  final transitions = <Map<String, dynamic>>[
    {
      'name': 'Slide from Left',
      'code': 'SlideTransition(\n'
          '  position: Tween<Offset>(\n'
          '    begin: Offset(-1, 0),\n'
          '    end: Offset.zero,\n'
          '  ).animate(animation),\n'
          '  child: child,\n'
          ')',
      'color': Colors.blue,
      'icon': Icons.arrow_forward,
      'useCase': 'Chat messages, timeline entries',
    },
    {
      'name': 'Slide from Bottom',
      'code': 'SlideTransition(\n'
          '  position: Tween<Offset>(\n'
          '    begin: Offset(0, 1),\n'
          '    end: Offset.zero,\n'
          '  ).animate(animation),\n'
          '  child: child,\n'
          ')',
      'color': Colors.purple,
      'icon': Icons.arrow_upward,
      'useCase': 'Notifications, card feeds',
    },
    {
      'name': 'Scale with Bounce',
      'code': 'ScaleTransition(\n'
          '  scale: CurvedAnimation(\n'
          '    parent: animation,\n'
          '    curve: Curves.elasticOut,\n'
          '  ),\n'
          '  child: child,\n'
          ')',
      'color': Colors.pink,
      'icon': Icons.zoom_in,
      'useCase': 'Bubble messages, badges',
    },
    {
      'name': 'Size Expand',
      'code': 'SizeTransition(\n'
          '  sizeFactor: animation,\n'
          '  axisAlignment: -1.0,\n'
          '  child: child,\n'
          ')',
      'color': Colors.green,
      'icon': Icons.expand,
      'useCase': 'Expanding lists, collapsible groups',
    },
    {
      'name': 'Rotation + Fade',
      'code': 'RotationTransition(\n'
          '  turns: Tween(begin: 0.05, end: 0.0)\n'
          '    .animate(animation),\n'
          '  child: FadeTransition(\n'
          '    opacity: animation,\n'
          '    child: child,\n'
          '  ),\n'
          ')',
      'color': Colors.orange,
      'icon': Icons.rotate_right,
      'useCase': 'Playful UIs, card stacks',
    },
  ];

  final transitionCards = <Widget>[];
  for (var t in transitions) {
    final color = t['color'] as Color;
    print('  Transition: ${t['name']}');
    transitionCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 6),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [color, color.withOpacity(0.6)],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      t['icon'] as IconData,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t['name'] as String,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        Text(
                          'Use: ${t['useCase']}',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.shade500,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(14, 0, 14, 12),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                t['code'] as String,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 10,
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

  final transitionPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.animation, color: Colors.cyan.shade700, size: 22),
            const SizedBox(width: 10),
            Text(
              'Transition Catalog',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.cyan.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...transitionCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Remove Item Builder Pattern
  // ============================================================
  print('=== Section 5: Remove Item Builder ===');

  final removePatternPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.white],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.delete_outline, color: Colors.red, size: 22),
            const SizedBox(width: 10),
            Text(
              'removeItem — The Builder Pattern',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.red.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text(
          'removeItem() takes a special AnimatedRemovedItemBuilder '
          'that defines what the departing item looks like during '
          'the exit animation:',
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
            'void _removeTodo(int index) {\n'
            '  // 1. Capture the item BEFORE removing\n'
            '  final removedItem = _items[index];\n'
            '  // 2. Remove from data model\n'
            '  _items.removeAt(index);\n'
            '  // 3. Tell AnimatedList to remove (plays animation)\n'
            '  _listKey.currentState!.removeItem(\n'
            '    index,\n'
            '    (BuildContext ctx, Animation<double> anim) {\n'
            '      // Build the departing widget\n'
            '      return SlideTransition(\n'
            '        position: Tween<Offset>(\n'
            '          begin: Offset.zero,\n'
            '          end: const Offset(1, 0), // slide right\n'
            '        ).animate(anim),\n'
            '        child: _buildTodoTile(removedItem),\n'
            '      );\n'
            '    },\n'
            '    duration: const Duration(milliseconds: 400),\n'
            '  );\n'
            '}',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              height: 1.5,
              color: Colors.greenAccent,
            ),
          ),
        ),
        const SizedBox(height: 14),
        // Key points
        ...['Capture the item data before removing from your list',
            'Remove from your data model first',
            'The builder closure "remembers" the removed item via closure',
            'The animation drives from 1 → 0 (reverse of insert)'].map(
          (point) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.check_circle, color: Colors.red.shade400, size: 16),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    point,
                    style: TextStyle(
                      fontSize: 11.5,
                      height: 1.3,
                      color: Colors.grey.shade700,
                    ),
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
  // SECTION 6: Common Pitfalls
  // ============================================================
  print('=== Section 6: Common Pitfalls ===');

  final pitfalls = <Map<String, dynamic>>[
    {
      'title': 'Index Out of Sync',
      'problem': 'Calling insertItem() before adding to your data list, '
          'or removeItem() after removing from data.',
      'solution': 'For insert: add to data first, then call insertItem(). '
          'For remove: capture item, remove from data, then call '
          'removeItem() with the captured item in its builder.',
      'icon': Icons.sync_problem,
      'severity': 'high',
    },
    {
      'title': 'Wrong initialItemCount',
      'problem': 'Setting initialItemCount to 0 when data already exists, '
          'causing an empty list despite having items.',
      'solution': 'Always set initialItemCount to match your data list '
          'length at widget creation time.',
      'icon': Icons.format_list_numbered,
      'severity': 'medium',
    },
    {
      'title': 'Missing GlobalKey',
      'problem': 'Creating the GlobalKey inside build(), causing it to be '
          'recreated on every rebuild.',
      'solution': 'Declare the GlobalKey as a field on your State class, '
          'not inside build(). final _key = GlobalKey<AnimatedListState>();',
      'icon': Icons.vpn_key_off,
      'severity': 'high',
    },
    {
      'title': 'Not Disposing Animations',
      'problem': 'Rapid add/remove calls can stack up animations and '
          'cause jank or memory issues.',
      'solution': 'Use reasonable animation durations (200-500ms). '
          'For batch operations, use insertAllItems() or debounce '
          'individual calls.',
      'icon': Icons.speed,
      'severity': 'low',
    },
  ];

  final pitfallCards = <Widget>[];
  for (var pitfall in pitfalls) {
    final severity = pitfall['severity'] as String;
    final severityColor = severity == 'high'
        ? Colors.red
        : severity == 'medium'
            ? Colors.orange
            : Colors.yellow.shade700;
    print('  Pitfall: ${pitfall['title']} ($severity)');

    pitfallCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: severityColor.withOpacity(0.35)),
          color: severityColor.withOpacity(0.04),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(pitfall['icon'] as IconData, color: severityColor, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    pitfall['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: severityColor,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: severityColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    severity.toUpperCase(),
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: severityColor,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Problem: ',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    )),
                Expanded(
                  child: Text(
                    pitfall['problem'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.3,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Fix: ',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade600,
                    )),
                Expanded(
                  child: Text(
                    pitfall['solution'] as String,
                    style: TextStyle(
                      fontSize: 11,
                      height: 1.3,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  final pitfallPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Colors.orange.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.orange, size: 22),
            const SizedBox(width: 10),
            Text(
              'Common Pitfalls',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.orange.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...pitfallCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 7: AnimatedList vs AnimatedGrid vs SliverAnimatedList
  // ============================================================
  print('=== Section 7: Family Comparison ===');

  final family = <Map<String, dynamic>>[
    {
      'name': 'AnimatedList',
      'layout': 'Linear (vertical or horizontal)',
      'delegate': 'None — single axis',
      'state': 'AnimatedListState',
      'sliver': 'No (box widget)',
      'color': Colors.cyan,
    },
    {
      'name': 'SliverAnimatedList',
      'layout': 'Linear (in CustomScrollView)',
      'delegate': 'None — single axis',
      'state': 'SliverAnimatedListState',
      'sliver': 'Yes — composable with other slivers',
      'color': Colors.teal,
    },
    {
      'name': 'AnimatedGrid',
      'layout': '2D (fixed or max extent)',
      'delegate': 'SliverGridDelegate',
      'state': 'AnimatedGridState',
      'sliver': 'No (box widget)',
      'color': Colors.amber,
    },
    {
      'name': 'SliverAnimatedGrid',
      'layout': '2D (in CustomScrollView)',
      'delegate': 'SliverGridDelegate',
      'state': 'SliverAnimatedGridState',
      'sliver': 'Yes — composable',
      'color': Colors.orange,
    },
  ];

  final familyRows = <Widget>[];
  // Header
  familyRows.add(
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.cyan.shade100,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text('Widget',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.cyan.shade900)),
          ),
          Expanded(
            flex: 3,
            child: Text('Layout',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.cyan.shade900)),
          ),
          Expanded(
            flex: 2,
            child: Text('Sliver?',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 10,
                    color: Colors.cyan.shade900)),
          ),
        ],
      ),
    ),
  );

  for (var i = 0; i < family.length; i++) {
    final f = family[i];
    final color = f['color'] as Color;
    print('  Family: ${f['name']}');
    familyRows.add(
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: i.isEven ? Colors.grey.shade50 : Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                f['name'] as String,
                style: TextStyle(
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Text(
                f['layout'] as String,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                f['sliver'] as String,
                style: TextStyle(fontSize: 10, color: Colors.grey.shade700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final familyPanel = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.cyan.shade200),
    ),
    child: Column(children: familyRows),
  );

  // ============================================================
  // SECTION 8: Real-World Usage Patterns
  // ============================================================
  print('=== Section 8: Real-World Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Chat Message Feed',
      'desc': 'New messages slide up from the bottom. The list auto-scrolls '
          'to newest. Deleted messages fade out smoothly.',
      'icon': Icons.chat_bubble,
      'color': Colors.blue,
    },
    {
      'title': 'Todo / Task List',
      'desc': 'New tasks slide in from the left. Completing a task adds '
          'a strikethrough animation, then slides it off to the right.',
      'icon': Icons.checklist,
      'color': Colors.green,
    },
    {
      'title': 'Shopping Cart',
      'desc': 'Added products scale in with a bounce. Removing items '
          'plays a shrink animation and updates the total smoothly.',
      'icon': Icons.shopping_bag,
      'color': Colors.orange,
    },
    {
      'title': 'Notification Center',
      'desc': 'Notifications drop in from the top with a slide. '
          'Swiping dismisses with a slide-out. "Clear All" uses '
          'removeAllItems for a cascade effect.',
      'icon': Icons.notifications,
      'color': Colors.purple,
    },
    {
      'title': 'Search Results',
      'desc': 'Results animate in one by one as they load from API. '
          'Staggered delays create a waterfall appearance. Clearing '
          'search collapses all items.',
      'icon': Icons.search,
      'color': Colors.teal,
    },
  ];

  final patternCards = <Widget>[];
  for (var pattern in patterns) {
    final color = pattern['color'] as Color;
    print('  Pattern: ${pattern['title']}');

    patternCards.add(
      Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: color.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color, color.withOpacity(0.6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Icon(pattern['icon'] as IconData, color: Colors.white, size: 24),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pattern['title'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pattern['desc'] as String,
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

  final patternPanel = Container(
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
            Icon(Icons.lightbulb, color: Colors.teal, size: 22),
            const SizedBox(width: 10),
            Text(
              'Real-World Usage Patterns',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade800,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...patternCards,
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Summary Dashboard
  // ============================================================
  print('=== Section 9: Summary ===');

  final stats = [
    {'label': 'List Items', 'value': '${listItems.length}', 'color': Colors.cyan},
    {'label': 'API Methods', 'value': '${apiEntries.length}', 'color': Colors.teal},
    {'label': 'Transitions', 'value': '${transitions.length}', 'color': Colors.blue},
    {'label': 'Pitfalls', 'value': '${pitfalls.length}', 'color': Colors.orange},
    {'label': 'Patterns', 'value': '${patterns.length}', 'color': Colors.purple},
  ];

  final statTiles = <Widget>[];
  for (var stat in stats) {
    final color = stat['color'] as Color;
    statTiles.add(
      Container(
        width: 88,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.25)),
        ),
        child: Column(
          children: [
            Text(
              stat['value'] as String,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              stat['label'] as String,
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
        colors: [Colors.cyan.shade50, Colors.white],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Colors.cyan.shade200, width: 2),
    ),
    child: Column(
      children: [
        Text(
          'AnimatedListState — Summary',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade800,
          ),
        ),
        const SizedBox(height: 14),
        Wrap(alignment: WrapAlignment.center, children: statTiles),
      ],
    ),
  );

  // ============================================================
  // ASSEMBLE FINAL LAYOUT
  // ============================================================
  print('=== Assembling final layout ===');

  return Scaffold(
    appBar: AppBar(
      title: const Text('AnimatedListState Deep Demo'),
      backgroundColor: Colors.cyan.shade700,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero header
          Container(
            padding: const EdgeInsets.all(20),
            color: Colors.cyan.shade50,
            child: Column(
              children: [
                Icon(Icons.list_alt, size: 48, color: Colors.cyan.shade700),
                const SizedBox(height: 10),
                Text(
                  'AnimatedListState',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.cyan.shade800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'State object for AnimatedList — animated insertions '
                  'and removals in a scrollable linear list.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.cyan.shade600,
                  ),
                ),
              ],
            ),
          ),
          _listSectionHeader('1. Core Concepts'),
          ...conceptCards,
          _listSectionHeader('2. API Methods'),
          apiPanel,
          _listSectionHeader('3. Live AnimatedList'),
          liveListWidget,
          _listSectionHeader('4. Transition Catalog'),
          transitionPanel,
          _listSectionHeader('5. Remove Builder Pattern'),
          removePatternPanel,
          _listSectionHeader('6. Common Pitfalls'),
          pitfallPanel,
          _listSectionHeader('7. Animated List Family'),
          familyPanel,
          _listSectionHeader('8. Real-World Patterns'),
          patternPanel,
          _listSectionHeader('9. Summary'),
          summaryPanel,
          const SizedBox(height: 40),
        ],
      ),
    ),
  );
}

Widget _listSectionHeader(String title) {
  return Container(
    margin: const EdgeInsets.fromLTRB(16, 20, 16, 4),
    child: Row(
      children: [
        Container(
          width: 4,
          height: 22,
          decoration: BoxDecoration(
            color: Colors.cyan.shade700,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.cyan.shade800,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}
