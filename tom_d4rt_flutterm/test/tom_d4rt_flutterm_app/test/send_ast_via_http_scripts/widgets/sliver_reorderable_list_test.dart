// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — SliverReorderableList
// Demonstrates SliverReorderableList — a sliver that lets the user reorder
// items by long-pressing and dragging them to a new position. Typically used
// inside a CustomScrollView alongside other slivers. The reorder callback
// receives oldIndex and newIndex so you can update the backing data.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SliverReorderableList Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptItems = <Map<String, dynamic>>[
    {
      'icon': Icons.swap_vert,
      'title': 'What Is SliverReorderableList?',
      'body': 'SliverReorderableList is a sliver that displays children '
          'the user can reorder by long-pressing and dragging. It functions '
          'identically to ReorderableListView but as a sliver, so it can '
          'be composed with SliverAppBar, SliverList, and other slivers '
          'inside a CustomScrollView.',
      'accent': Colors.cyan,
    },
    {
      'icon': Icons.touch_app,
      'title': 'Long-Press to Reorder',
      'body': 'By default, the user long-presses an item to start dragging. '
          'You can also provide a ReorderableDragStartListener (or wrap a '
          'child widget in one) that uses a drag handle icon, so the user '
          'can grab a handle instead of long-pressing.',
      'accent': Colors.orange,
    },
    {
      'icon': Icons.dataset,
      'title': 'Data-Driven Reordering',
      'body': 'When a drag completes, the onReorder callback fires with '
          'oldIndex and newIndex. You must update your data model and '
          'rebuild — the sliver does not reorder the data for you. '
          'Remember: if newIndex > oldIndex, subtract 1 because the '
          'dragged item vacates its old position first.',
      'accent': Colors.teal,
    },
    {
      'icon': Icons.view_day,
      'title': 'Sliver Composition',
      'body': 'Because it is a sliver, SliverReorderableList can coexist '
          'with SliverAppBar, SliverPadding, SliverToBoxAdapter, and any '
          'other sliver in a single CustomScrollView — something a '
          'standalone ReorderableListView cannot do.',
      'accent': Colors.deepPurple,
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
      'param': 'itemBuilder',
      'type': 'IndexedWidgetBuilder',
      'desc': 'Required. Builds each child at the given index. Each child '
          'must have a unique Key so the reorder animation knows which '
          'widget is being dragged. Without keys, reordering fails.',
    },
    {
      'param': 'itemCount',
      'type': 'int',
      'desc': 'Required. The number of items in the list.',
    },
    {
      'param': 'onReorder',
      'type': 'ReorderCallback',
      'desc': 'Required. Called when a drag completes. Receives (oldIndex, '
          'newIndex). You must update your backing data in this callback.',
    },
    {
      'param': 'onReorderStart',
      'type': 'void Function(int)?',
      'desc': 'Called when a reorder drag starts. Receives the index of '
          'the item being picked up. Useful for haptic feedback or UI state.',
    },
    {
      'param': 'onReorderEnd',
      'type': 'void Function(int)?',
      'desc': 'Called when a reorder drag ends, regardless of whether the '
          'item moved. Receives the final index.',
    },
    {
      'param': 'proxyDecorator',
      'type': 'ReorderItemProxyDecorator?',
      'desc': 'A builder that wraps the dragged item to customize its '
          'appearance while in flight. Receives (child, index, animation). '
          'Common patterns: elevation, scale, opacity changes.',
    },
  ];

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
              ? Colors.cyan.withOpacity(0.06)
              : Colors.grey.withOpacity(0.04),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.cyan.withOpacity(0.15)),
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
                    color: Colors.cyan.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    row['param']!,
                    style: const TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.cyan,
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
  // SECTION 3: Basic reorder demo (static visual)
  // ============================================================
  print('=== Section 3: Basic reorder ===');

  // Since d4rt scripts are stateless, we show the structural layout
  final basicTasks = <Map<String, dynamic>>[
    {'title': 'Review pull requests', 'icon': Icons.rate_review, 'priority': 'High'},
    {'title': 'Update documentation', 'icon': Icons.description, 'priority': 'Medium'},
    {'title': 'Fix login bug', 'icon': Icons.bug_report, 'priority': 'High'},
    {'title': 'Deploy staging build', 'icon': Icons.cloud_upload, 'priority': 'Low'},
    {'title': 'Write unit tests', 'icon': Icons.science, 'priority': 'Medium'},
    {'title': 'Refactor auth module', 'icon': Icons.code, 'priority': 'Medium'},
    {'title': 'Design API endpoints', 'icon': Icons.api, 'priority': 'High'},
    {'title': 'Optimize database queries', 'icon': Icons.storage, 'priority': 'Low'},
  ];

  final priorityColors = <String, Color>{
    'High': Colors.red,
    'Medium': Colors.orange,
    'Low': Colors.green,
  };

  final basicItems = <Widget>[];
  for (var i = 0; i < basicTasks.length; i++) {
    final task = basicTasks[i];
    final pColor = priorityColors[task['priority']]!;
    basicItems.add(
      Container(
        key: ValueKey<int>(i),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade200),
            left: BorderSide(color: pColor, width: 3),
          ),
          color: Colors.white,
        ),
        child: Row(
          children: [
            Icon(task['icon'] as IconData, color: Colors.cyan, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task['title'] as String,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: pColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      task['priority'] as String,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: pColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.drag_handle, color: Colors.grey.shade400, size: 22),
          ],
        ),
      ),
    );
  }

  final basicReorderDemo = SizedBox(
    height: 450,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: const Text('Task List'),
          backgroundColor: Colors.cyan.shade700,
          pinned: true,
        ),
        SliverReorderableList(
          itemBuilder: (BuildContext ctx, int index) {
            final task = basicTasks[index];
            final pColor = priorityColors[task['priority']]!;
            return ReorderableDragStartListener(
              key: ValueKey<int>(index),
              index: index,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade200),
                    left: BorderSide(color: pColor, width: 3),
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(
                      task['icon'] as IconData,
                      color: Colors.cyan,
                      size: 22,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task['title'] as String,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: pColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              task['priority'] as String,
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: pColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.drag_handle,
                      color: Colors.grey.shade400,
                      size: 22,
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: basicTasks.length,
          onReorder: (int oldIndex, int newIndex) {
            print('Reorder: $oldIndex -> $newIndex');
          },
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4: Drag handle patterns
  // ============================================================
  print('=== Section 4: Drag handles ===');

  final handlePatterns = <Map<String, dynamic>>[
    {
      'name': 'Long-Press Anywhere',
      'desc': 'Default behavior — long-press on any part of the item to '
          'start dragging. No special handle widget needed. Best for '
          'simple lists where the entire row is tappable.',
      'icon': Icons.touch_app,
      'color': Colors.cyan,
    },
    {
      'name': 'ReorderableDragStartListener',
      'desc': 'Wrap the item (or part of it) in ReorderableDragStartListener. '
          'The drag starts on pointer-down inside that listener — no '
          'long-press delay. Typically used to wrap a drag-handle icon.',
      'icon': Icons.drag_handle,
      'color': Colors.orange,
    },
    {
      'name': 'ReorderableDelayedDragStartListener',
      'desc': 'Similar to ReorderableDragStartListener but includes a '
          'configurable delay before the drag activates. Useful when the '
          'draggable area overlaps with other gesture detectors.',
      'icon': Icons.timer,
      'color': Colors.purple,
    },
    {
      'name': 'Custom Drag Handle',
      'desc': 'Place a drag-handle icon on one side of the item, wrap it in '
          'ReorderableDragStartListener, and keep the rest of the item free '
          'for taps. This is the most common pattern in production apps.',
      'icon': Icons.drag_indicator,
      'color': Colors.teal,
    },
  ];

  final handleCards = <Widget>[];
  for (var i = 0; i < handlePatterns.length; i++) {
    final p = handlePatterns[i];
    final hColor = p['color'] as Color;
    print('Handle ${i + 1}: ${p['name']}');
    handleCards.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: hColor.withOpacity(0.04),
          border: Border.all(color: hColor.withOpacity(0.2)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: hColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(p['icon'] as IconData, color: hColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      p['name'] as String,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: hColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      p['desc'] as String,
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
      ),
    );
  }

  // ============================================================
  // SECTION 5: Proxy decorator (drag appearance)
  // ============================================================
  print('=== Section 5: Proxy decorator ===');

  // Show what a dragged item looks like with a proxy decorator
  final decoratorNote = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: Colors.indigo.withOpacity(0.06),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.indigo.withOpacity(0.2)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Row(
          children: [
            Icon(Icons.brush, color: Colors.indigo, size: 20),
            SizedBox(width: 8),
            Text(
              'proxyDecorator Callback',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'The proxyDecorator callback lets you customize how the dragged '
          'item looks while in flight. It receives (child, index, animation) '
          'and returns a widget. Common patterns:',
          style: TextStyle(
            fontSize: 13,
            color: Colors.grey.shade700,
            height: 1.4,
          ),
        ),
      ],
    ),
  );

  final decoratorExamples = <Map<String, dynamic>>[
    {
      'name': 'Elevated Shadow',
      'desc': 'Wrap in Material with elevation: 6 for a floating effect.',
      'icon': Icons.layers,
      'color': Colors.blue,
    },
    {
      'name': 'Scale Up',
      'desc': 'Use ScaleTransition with the animation to grow slightly.',
      'icon': Icons.zoom_in,
      'color': Colors.green,
    },
    {
      'name': 'Opacity Change',
      'desc': 'Apply FadeTransition so the item becomes translucent.',
      'icon': Icons.opacity,
      'color': Colors.orange,
    },
    {
      'name': 'Color Highlight',
      'desc': 'Change background color to indicate the active item.',
      'icon': Icons.color_lens,
      'color': Colors.purple,
    },
    {
      'name': 'Rotation Tilt',
      'desc': 'Apply a subtle 2-3 degree rotation for a playful feel.',
      'icon': Icons.rotate_right,
      'color': Colors.red,
    },
  ];

  final decoratorWidgets = <Widget>[];
  for (var i = 0; i < decoratorExamples.length; i++) {
    final ex = decoratorExamples[i];
    final dColor = ex['color'] as Color;
    print('Decorator ${i + 1}: ${ex['name']}');
    decoratorWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: dColor.withOpacity(0.06),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: dColor.withOpacity(0.15)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: dColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(ex['icon'] as IconData, color: dColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ex['name'] as String,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: dColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    ex['desc'] as String,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
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

  // A visual example of the "before drag" vs "during drag" state
  final beforeDragItem = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        const Icon(Icons.task_alt, color: Colors.cyan, size: 22),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'Normal item (before drag)',
            style: TextStyle(fontSize: 14),
          ),
        ),
        Icon(Icons.drag_handle, color: Colors.grey.shade400),
      ],
    ),
  );

  final duringDragItem = Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.cyan.withOpacity(0.08),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.cyan.withOpacity(0.4), width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withOpacity(0.15),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      children: [
        const Icon(Icons.task_alt, color: Colors.cyan, size: 22),
        const SizedBox(width: 12),
        const Expanded(
          child: Text(
            'During drag (proxy decorated)',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.cyan,
            ),
          ),
        ),
        Icon(Icons.drag_handle, color: Colors.cyan.shade300),
      ],
    ),
  );

  // ============================================================
  // SECTION 6: Multi-section reorderable
  // ============================================================
  print('=== Section 6: Multi-section ===');

  // Show how SliverReorderableList can be one of several slivers
  final sections = <Map<String, dynamic>>[
    {
      'header': 'Today',
      'color': Colors.cyan,
      'items': ['Morning standup', 'Code review', 'Feature implementation'],
    },
    {
      'header': 'Tomorrow',
      'color': Colors.orange,
      'items': ['Sprint planning', 'Design review', 'Documentation'],
    },
    {
      'header': 'This Week',
      'color': Colors.green,
      'items': ['Release prep', 'Performance review', 'Team retrospective'],
    },
  ];

  final multiSectionSlices = <Widget>[];
  for (var s = 0; s < sections.length; s++) {
    final section = sections[s];
    final sColor = section['color'] as Color;
    final items = section['items'] as List<String>;
    print('Section ${s + 1}: ${section['header']} (${items.length} items)');

    // Section header (a SliverToBoxAdapter)
    multiSectionSlices.add(
      SliverToBoxAdapter(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          margin: EdgeInsets.only(top: s > 0 ? 8 : 0),
          color: sColor.withOpacity(0.08),
          child: Text(
            section['header'] as String,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: sColor,
            ),
          ),
        ),
      ),
    );

    // Section items (a SliverReorderableList)
    multiSectionSlices.add(
      SliverReorderableList(
        itemBuilder: (BuildContext ctx, int index) {
          return ReorderableDragStartListener(
            key: ValueKey<String>('${section['header']}_$index'),
            index: index,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.shade200),
                ),
                color: Colors.white,
              ),
              child: Row(
                children: [
                  Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: sColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      items[index],
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  Icon(
                    Icons.drag_handle,
                    color: Colors.grey.shade400,
                    size: 20,
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: items.length,
        onReorder: (int oldIndex, int newIndex) {
          print('${section['header']}: $oldIndex -> $newIndex');
        },
      ),
    );
  }

  final multiSectionDemo = SizedBox(
    height: 460,
    child: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          title: const Text('Multi-Section Schedule'),
          backgroundColor: Colors.cyan.shade800,
          pinned: true,
        ),
        ...multiSectionSlices,
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Best practices
  // ============================================================
  print('=== Section 7: Best practices ===');

  final practices = <Map<String, dynamic>>[
    {
      'title': 'Always Use Unique Keys',
      'body': 'Every child must have a unique Key (usually ValueKey with '
          'the item ID). The reorder animation uses keys to track which '
          'widget moved. Without keys, items will not animate correctly.',
      'icon': Icons.vpn_key,
      'color': Colors.red,
    },
    {
      'title': 'Handle newIndex Correctly',
      'body': 'When newIndex > oldIndex, the item at oldIndex has already '
          'been removed from its old position, so the effective insertion '
          'index is newIndex - 1. Most frameworks document this.',
      'icon': Icons.numbers,
      'color': Colors.orange,
    },
    {
      'title': 'Provide Haptic Feedback',
      'body': 'Use onReorderStart to trigger a light haptic vibration. '
          'This gives the user tactile confirmation that the drag has '
          'started. Use HapticFeedback.mediumImpact().',
      'icon': Icons.vibration,
      'color': Colors.purple,
    },
    {
      'title': 'Use proxyDecorator',
      'body': 'Add a subtle elevation or scale to the dragged item so '
          'the user can clearly see which item they are moving. A shadow '
          'effect works well.',
      'icon': Icons.layers,
      'color': Colors.blue,
    },
    {
      'title': 'Persist Reorder Results',
      'body': 'Save the new order to your data store (database, shared '
          'preferences, etc.) in onReorder. If the user closes the app '
          'before persisting, the reorder is lost.',
      'icon': Icons.save,
      'color': Colors.green,
    },
    {
      'title': 'Accessibility',
      'body': 'The drag handle should have a semantic label explaining '
          'its purpose. Users with assistive technology need to know they '
          'can press and hold to reorder.',
      'icon': Icons.accessibility,
      'color': Colors.teal,
    },
  ];

  final practiceWidgets = <Widget>[];
  for (var i = 0; i < practices.length; i++) {
    final pr = practices[i];
    final prColor = pr['color'] as Color;
    print('Practice ${i + 1}: ${pr['title']}');
    practiceWidgets.add(
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: prColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: prColor.withOpacity(0.2)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: prColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(pr['icon'] as IconData, color: prColor, size: 22),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pr['title'] as String,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: prColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    pr['body'] as String,
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
      'icon': Icons.swap_vert,
      'text': 'SliverReorderableList enables drag-to-reorder inside a '
          'CustomScrollView, composable with other slivers.',
    },
    {
      'icon': Icons.touch_app,
      'text': 'Long-press to drag by default, or use '
          'ReorderableDragStartListener for a dedicated drag handle.',
    },
    {
      'icon': Icons.vpn_key,
      'text': 'Every child must have a unique Key for reorder animation '
          'to work correctly.',
    },
    {
      'icon': Icons.dataset,
      'text': 'The onReorder callback provides (oldIndex, newIndex). You '
          'must update your data model — the sliver does not move data.',
    },
    {
      'icon': Icons.brush,
      'text': 'proxyDecorator customizes the look of the dragged item — '
          'add elevation, scale, or color changes.',
    },
    {
      'icon': Icons.view_day,
      'text': 'Multiple SliverReorderableList slivers can appear in one '
          'CustomScrollView for sectioned reorderable lists.',
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
          color: Colors.cyan.withOpacity(0.04 + (i % 3) * 0.02),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.cyan.withOpacity(0.12)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: Colors.cyan.withOpacity(0.12),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                sp['icon'] as IconData,
                color: Colors.cyan.shade700,
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
        title: const Text('SliverReorderableList'),
        backgroundColor: Colors.cyan.shade700,
        bottom: const TabBar(
          isScrollable: true,
          indicatorColor: Colors.white,
          tabs: [
            Tab(icon: Icon(Icons.info_outline), text: 'Concept'),
            Tab(icon: Icon(Icons.construction), text: 'Constructor'),
            Tab(icon: Icon(Icons.swap_vert), text: 'Basic'),
            Tab(icon: Icon(Icons.drag_handle), text: 'Handles'),
            Tab(icon: Icon(Icons.brush), text: 'Proxy'),
            Tab(icon: Icon(Icons.view_day), text: 'Multi-Section'),
            Tab(icon: Icon(Icons.check_circle), text: 'Practices'),
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
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'SliverReorderableList is the sliver version of '
                  'ReorderableListView. It allows users to long-press and '
                  'drag items to rearrange them, and it composes freely '
                  'with other slivers in a CustomScrollView.',
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
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Three required parameters: itemBuilder, itemCount, and '
                  'onReorder. Optional callbacks for reorder start/end '
                  'and a proxyDecorator for drag appearance.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...constructorWidgets,
            ],
          ),

          // Tab 3: Basic reorder
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'A task list with drag handles and priority indicators. '
                  'Long-press any item or grab the handle to reorder.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: basicReorderDemo,
                ),
              ),
            ],
          ),

          // Tab 4: Drag handles
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Different approaches for initiating the drag gesture:',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...handleCards,
            ],
          ),

          // Tab 5: Proxy decorator
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Customize the appearance of items while being dragged '
                  'using the proxyDecorator callback.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              decoratorNote,
              ...decoratorWidgets,
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'Visual comparison:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              beforeDragItem,
              duringDragItem,
            ],
          ),

          // Tab 6: Multi-section
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Multiple SliverReorderableList slivers with section '
                  'headers between them. Each section reorders '
                  'independently within its own sliver.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: multiSectionDemo,
                ),
              ),
            ],
          ),

          // Tab 7: Best practices
          ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.cyan.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Tips for building robust reorderable sliver lists.',
                  style: TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              ...practiceWidgets,
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
                      Colors.cyan.withOpacity(0.12),
                      Colors.teal.withOpacity(0.06),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Key points about SliverReorderableList.',
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
