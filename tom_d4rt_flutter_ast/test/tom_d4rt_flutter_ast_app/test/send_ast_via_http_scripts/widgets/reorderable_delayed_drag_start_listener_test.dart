// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo — ReorderableDelayedDragStartListener
// Demonstrates ReorderableDelayedDragStartListener — a specialised drag
// recogniser that requires a sustained press (long-press) before the
// reorder operation begins. This prevents accidental reordering while
// the user is scrolling through a list. Contrast with
// ReorderableDragStartListener which starts immediately on drag.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ReorderableDelayedDragStartListener Deep Demo executing');

  // ============================================================
  // SECTION 1: Concept — Delayed Drag for Reorderable Lists
  // ============================================================
  print('=== Section 1: Concept ===');

  // ReorderableDelayedDragStartListener wraps a child widget and
  // tells the nearest ReorderableList (or ReorderableListView)
  // that reordering should only start after a long-press delay.
  //
  // This is the default behavior for ReorderableListView on
  // touch devices: users must long-press an item before they
  // can drag it. This prevents accidental reorders when the
  // user just wants to scroll.
  //
  // Key properties:
  //   - index (int): The item's position in the list.
  //   - child (Widget): The visual content of the list item.
  //   - enabled (bool): Whether drag is allowed (default: true).
  //
  // It inherits from ReorderableDragStartListener and adds a
  // DelayedMultiDragGestureRecognizer instead of the immediate
  // ImmediateMultiDragGestureRecognizer.

  final conceptCard = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8F5E9), Color(0xFFC8E6C9)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      border: Border.all(color: Color(0xFF2E7D32), width: 2.0),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.15),
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
            Icon(Icons.drag_handle, size: 36.0, color: Color(0xFF2E7D32)),
            SizedBox(width: 12.0),
            Expanded(
              child: Text(
                'ReorderableDelayedDragStartListener',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1B5E20),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Text(
          'A specialised listener that requires users to long-press '
          'before an item can be dragged for reordering. This '
          'prevents accidental reorder when just scrolling.',
          style: TextStyle(fontSize: 14.0, color: Color(0xFF2E7D32)),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'ReorderableDelayedDragStartListener(\n'
            '  index: 3,          // position in list\n'
            '  enabled: true,     // can be disabled\n'
            '  child: MyItem(),   // the visual content\n'
            ')\n\n'
            '// Uses DelayedMultiDragGestureRecognizer\n'
            '// internally — requires sustained press.',
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
  // SECTION 2: The Drag Lifecycle — Visual Timeline
  // ============================================================
  print('=== Section 2: Drag lifecycle ===');

  // Show the states a drag gesture goes through:
  //  1. Idle — finger is up, item at rest
  //  2. Press detected — finger down, waiting for delay
  //  3. Delay elapsed — long-press threshold met
  //  4. Dragging — item is being moved
  //  5. Drop — finger released, item snaps to new position

  Widget buildLifecycleStage(
    String number,
    String name,
    String description,
    IconData icon,
    Color color,
    bool isActive,
  ) {
    return Container(
      width: 160.0,
      margin: EdgeInsets.all(6.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: isActive ? color.withValues(alpha: 0.15) : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isActive ? color : Colors.grey.shade300,
          width: isActive ? 2.5 : 1.0,
        ),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.25),
                  blurRadius: 8.0,
                  offset: Offset(0, 4),
                ),
              ]
            : [],
      ),
      child: Column(
        children: [
          Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              color: color.withValues(alpha: isActive ? 0.3 : 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                number,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: color,
                ),
              ),
            ),
          ),
          SizedBox(height: 8.0),
          Icon(icon, color: color, size: 28.0),
          SizedBox(height: 6.0),
          Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13.0,
              color: color,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 4.0),
          Text(
            description,
            style: TextStyle(fontSize: 10.0, color: Colors.grey.shade600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  final lifecycleRow = Container(
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
          'Drag Lifecycle with Delay',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'The delayed listener adds a waiting stage between press and drag.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
        ),
        SizedBox(height: 12.0),
        Wrap(
          alignment: WrapAlignment.center,
          children: [
            buildLifecycleStage(
              '1',
              'Idle',
              'Item at rest, no touch input',
              Icons.touch_app,
              Color(0xFF9E9E9E),
              false,
            ),
            buildLifecycleStage(
              '2',
              'Press',
              'Finger down, delay timer starts',
              Icons.timer,
              Color(0xFFFF9800),
              true,
            ),
            buildLifecycleStage(
              '3',
              'Delay Met',
              'Hold exceeded threshold — haptic feedback',
              Icons.vibration,
              Color(0xFF4CAF50),
              true,
            ),
            buildLifecycleStage(
              '4',
              'Dragging',
              'Item lifted, moving with finger',
              Icons.open_with,
              Color(0xFF2196F3),
              true,
            ),
            buildLifecycleStage(
              '5',
              'Drop',
              'Item released, snaps to new position',
              Icons.place,
              Color(0xFF9C27B0),
              false,
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3: Delayed vs Immediate — Visual Comparison
  // ============================================================
  print('=== Section 3: Delayed vs Immediate comparison ===');

  // Show two "timeline" bars side by side:
  //   - Immediate: drag starts right away on finger down
  //   - Delayed: drag starts only after ~500ms hold

  Widget buildTimelineBar(
    String label,
    List<Map<String, dynamic>> segments,
    Color accentColor,
  ) {
    return Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accentColor, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.12),
            blurRadius: 8.0,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, color: accentColor, size: 22.0),
              SizedBox(width: 8.0),
              Text(
                label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: accentColor,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.0),
          // Timeline bar
          Container(
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Row(
              children: segments.map((seg) {
                return Expanded(
                  flex: seg['flex'] as int,
                  child: Container(
                    margin: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      color: (seg['color'] as Color).withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(6.0),
                      border: Border.all(
                        color: seg['color'] as Color,
                        width: 1.0,
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      seg['label'] as String,
                      style: TextStyle(
                        fontSize: 9.0,
                        fontWeight: FontWeight.bold,
                        color: seg['color'] as Color,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0ms',
                style: TextStyle(
                  fontSize: 9.0,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade500,
                ),
              ),
              Text(
                '500ms',
                style: TextStyle(
                  fontSize: 9.0,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade500,
                ),
              ),
              Text(
                '1000ms',
                style: TextStyle(
                  fontSize: 9.0,
                  fontFamily: 'monospace',
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  final timelineComparison = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      children: [
        Text(
          'Timing Comparison',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 8.0),
        buildTimelineBar(
          'Immediate Drag (ReorderableDragStartListener)',
          [
            {'label': 'Press', 'flex': 1, 'color': Color(0xFFFF5722)},
            {'label': 'Dragging →', 'flex': 5, 'color': Color(0xFF2196F3)},
          ],
          Color(0xFFFF5722),
        ),
        buildTimelineBar(
          'Delayed Drag (ReorderableDelayedDragStartListener)',
          [
            {'label': 'Press', 'flex': 1, 'color': Color(0xFFFF9800)},
            {'label': '⏱ Delay...', 'flex': 2, 'color': Color(0xFFFFC107)},
            {'label': 'Dragging →', 'flex': 3, 'color': Color(0xFF4CAF50)},
          ],
          Color(0xFF4CAF50),
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
              Icon(Icons.info_outline, color: Color(0xFFE65100), size: 20.0),
              SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  'The delay ensures that scrolling gestures are not '
                  'accidentally interpreted as reorder-drag gestures.',
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
  // SECTION 4: Reorderable List with Delayed Drag
  // ============================================================
  print('=== Section 4: Reorderable list visual ===');

  // Show a styled reorderable list. Each item uses
  // ReorderableDelayedDragStartListener semantics.
  // We display them in their "at rest" state plus a
  // "mid-drag" simulated state.

  final taskItems = <Map<String, dynamic>>[
    {
      'title': 'Morning standup',
      'subtitle': '9:00 AM · Team sync',
      'icon': Icons.groups,
      'color': Color(0xFF2196F3),
      'priority': 'High',
    },
    {
      'title': 'Code review PR #142',
      'subtitle': '10:30 AM · Backend',
      'icon': Icons.code,
      'color': Color(0xFF4CAF50),
      'priority': 'Medium',
    },
    {
      'title': 'Design system update',
      'subtitle': '11:00 AM · UI/UX',
      'icon': Icons.palette,
      'color': Color(0xFF9C27B0),
      'priority': 'Low',
    },
    {
      'title': 'Database migration',
      'subtitle': '1:00 PM · Infrastructure',
      'icon': Icons.storage,
      'color': Color(0xFFFF9800),
      'priority': 'High',
    },
    {
      'title': 'Write test cases',
      'subtitle': '2:30 PM · QA',
      'icon': Icons.check_circle,
      'color': Color(0xFFE91E63),
      'priority': 'Medium',
    },
    {
      'title': 'Deploy to staging',
      'subtitle': '4:00 PM · DevOps',
      'icon': Icons.cloud_upload,
      'color': Color(0xFF00BCD4),
      'priority': 'High',
    },
  ];

  Widget buildTaskItem(
    Map<String, dynamic> task,
    int index, {
    bool isDragging = false,
    bool isPlaceholder = false,
  }) {
    final color = task['color'] as Color;
    final priorityColor = task['priority'] == 'High'
        ? Color(0xFFF44336)
        : task['priority'] == 'Medium'
            ? Color(0xFFFF9800)
            : Color(0xFF4CAF50);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: isPlaceholder
            ? Colors.grey.shade200
            : isDragging
                ? Colors.white
                : Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(
          color: isPlaceholder
              ? Colors.grey.shade400
              : isDragging
                  ? color
                  : Colors.grey.shade200,
          width: isDragging ? 2.0 : 1.0,
        ),
        boxShadow: isDragging
            ? [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 12.0,
                  offset: Offset(0, 6),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 4.0,
                  offset: Offset(0, 2),
                ),
              ],
      ),
      child: isPlaceholder
          ? Container(
              height: 68.0,
              alignment: Alignment.center,
              child: Text(
                'Drop here',
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontStyle: FontStyle.italic,
                  fontSize: 12.0,
                ),
              ),
            )
          : ListTile(
              leading: Container(
                width: 42.0,
                height: 42.0,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Icon(task['icon'] as IconData, color: color, size: 22.0),
              ),
              title: Text(
                task['title'] as String,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.0,
                  color: isDragging ? color : Colors.grey.shade800,
                ),
              ),
              subtitle: Text(
                task['subtitle'] as String,
                style: TextStyle(fontSize: 11.0, color: Colors.grey.shade500),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 3.0,
                    ),
                    decoration: BoxDecoration(
                      color: priorityColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: Text(
                      task['priority'] as String,
                      style: TextStyle(
                        fontSize: 10.0,
                        fontWeight: FontWeight.bold,
                        color: priorityColor,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.0),
                  Icon(
                    Icons.drag_indicator,
                    color: isDragging ? color : Colors.grey.shade400,
                    size: 20.0,
                  ),
                ],
              ),
            ),
    );
  }

  // Build "at rest" list
  final atRestList = Column(
    children: [
      for (var i = 0; i < taskItems.length; i++)
        buildTaskItem(taskItems[i], i),
    ],
  );

  // Build "mid-drag" simulation: item 1 being dragged to position 3
  final midDragList = Column(
    children: [
      buildTaskItem(taskItems[0], 0),
      // Original position is now a placeholder
      buildTaskItem(taskItems[1], 1, isPlaceholder: true),
      buildTaskItem(taskItems[2], 2),
      // Show the dragged item elevated between 2 and 3
      Transform.translate(
        offset: Offset(8.0, 0.0),
        child: buildTaskItem(taskItems[1], 1, isDragging: true),
      ),
      buildTaskItem(taskItems[3], 3),
      buildTaskItem(taskItems[4], 4),
      buildTaskItem(taskItems[5], 5),
    ],
  );

  final reorderableListSection = Container(
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
          'Reorderable Task List',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Each item uses ReorderableDelayedDragStartListener.\n'
          'Long-press to begin reordering.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.0),

        // Two states side by side
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'At Rest',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  atRestList,
                ],
              ),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 6.0,
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      'Mid-Drag',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1565C0),
                        fontSize: 13.0,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  midDragList,
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5: Item Decoration Showcase
  // ============================================================
  print('=== Section 5: Item decoration styles ===');

  // Show different ways to style reorderable items that use
  // the delayed drag listener. Each has a distinct look.

  Widget buildStyleCard(
    String styleName,
    String description,
    Widget itemPreview,
    Color accentColor,
  ) {
    return Container(
      width: 280.0,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: accentColor.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.1),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Icon(Icons.style, color: accentColor, size: 20.0),
                SizedBox(width: 8.0),
                Text(
                  styleName,
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11.0,
                    color: Colors.grey.shade600,
                  ),
                ),
                SizedBox(height: 8.0),
                itemPreview,
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Style 1: Card with drag handle on the right
  final dragHandleStyle = Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Color(0xFFF5F5F5),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Row(
      children: [
        Container(
          width: 36.0,
          height: 36.0,
          decoration: BoxDecoration(
            color: Color(0xFFE3F2FD),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(Icons.image, color: Color(0xFF1976D2), size: 20.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Photo collection',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13.0,
                ),
              ),
              Text(
                '24 items',
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(6.0),
          ),
          child: Icon(
            Icons.drag_indicator,
            color: Colors.grey.shade600,
            size: 18.0,
          ),
        ),
      ],
    ),
  );

  // Style 2: Gradient item with left color stripe
  final gradientStripeStyle = Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Colors.grey.shade200),
    ),
    child: Row(
      children: [
        Container(
          width: 6.0,
          height: 56.0,
          decoration: BoxDecoration(
            color: Color(0xFF7B1FA2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFF3E5F5),
                  Colors.white,
                ],
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Design brief',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13.0,
                    ),
                  ),
                ),
                Icon(
                  Icons.swap_vert,
                  color: Color(0xFF7B1FA2),
                  size: 18.0,
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

  // Style 3: Compact chip-like style
  final chipStyle = Container(
    padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
    decoration: BoxDecoration(
      color: Color(0xFFE0F7FA),
      borderRadius: BorderRadius.circular(24.0),
      border: Border.all(color: Color(0xFF00ACC1)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.label, color: Color(0xFF00838F), size: 16.0),
        SizedBox(width: 8.0),
        Text(
          'flutter',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 13.0,
            color: Color(0xFF00838F),
          ),
        ),
        SizedBox(width: 8.0),
        Icon(
          Icons.unfold_more,
          color: Color(0xFF00ACC1),
          size: 16.0,
        ),
      ],
    ),
  );

  // Style 4: Number-indexed list item
  final numberedStyle = Container(
    padding: EdgeInsets.all(10.0),
    decoration: BoxDecoration(
      color: Color(0xFFFFF8E1),
      borderRadius: BorderRadius.circular(10.0),
      border: Border.all(color: Color(0xFFFFB300)),
    ),
    child: Row(
      children: [
        Container(
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: Color(0xFFFFB300),
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '3',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 14.0,
            ),
          ),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Text(
            'Step three: Verify configuration',
            style: TextStyle(fontSize: 13.0, fontWeight: FontWeight.w500),
          ),
        ),
        Icon(Icons.drag_handle, color: Color(0xFFFFB300), size: 20.0),
      ],
    ),
  );

  final styleGallery = Wrap(
    alignment: WrapAlignment.center,
    children: [
      buildStyleCard(
        'Drag Handle',
        'Explicit drag handle on the right side. '
            'User long-presses the handle to begin reorder.',
        dragHandleStyle,
        Color(0xFF1976D2),
      ),
      buildStyleCard(
        'Gradient Stripe',
        'Color stripe on the left indicates category. '
            'Long-press anywhere on item to reorder.',
        gradientStripeStyle,
        Color(0xFF7B1FA2),
      ),
      buildStyleCard(
        'Compact Chip',
        'Chip-like tag with reorder capability. '
            'Works well for tag or label ordering.',
        chipStyle,
        Color(0xFF00838F),
      ),
      buildStyleCard(
        'Numbered Steps',
        'Sequential steps with automatic renumbering '
            'after reorder. Shows index-awareness.',
        numberedStyle,
        Color(0xFFFFB300),
      ),
    ],
  );

  // ============================================================
  // SECTION 6: Scroll vs Drag Conflict Explanation
  // ============================================================
  print('=== Section 6: Scroll vs drag conflict ===');

  // The whole reason for the delayed variant: on touch devices,
  // vertical scroll and vertical drag reorder use the same gesture.

  final conflictExplanation = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFCE4EC), Color(0xFFF8BBD0)],
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFC62828), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Color(0xFFC62828), size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'The Scroll vs Drag Conflict',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFB71C1C),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),

        // Problem illustration
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The Problem:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFFC62828),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'On touch screens, both scrolling and drag-reordering '
                'use the same gesture: a vertical finger drag. Without '
                'a delay, every scroll attempt could accidentally '
                'start reordering an item.',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
        SizedBox(height: 10.0),

        // Solution illustration
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFFE8F5E9).withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The Solution:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Color(0xFF2E7D32),
                ),
              ),
              SizedBox(height: 4.0),
              Text(
                'ReorderableDelayedDragStartListener requires a '
                'sustained press (~500ms by default) before drag '
                'begins. Quick swipes scroll; long-press + drag '
                'reorders. This is the standard mobile pattern.',
                style: TextStyle(fontSize: 12.0, color: Colors.grey.shade700),
              ),
            ],
          ),
        ),
        SizedBox(height: 12.0),

        // Visual: two phone outlines showing scroll vs reorder
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Scroll gesture
            Column(
              children: [
                Container(
                  width: 120.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: Colors.grey.shade400, width: 2.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14.0),
                            topRight: Radius.circular(14.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            // List items
                            Column(
                              children: [
                                for (var i = 0; i < 4; i++)
                                  Container(
                                    height: 28.0,
                                    margin: EdgeInsets.symmetric(
                                      horizontal: 6.0,
                                      vertical: 3.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius:
                                          BorderRadius.circular(4.0),
                                    ),
                                  ),
                              ],
                            ),
                            // Scroll arrow
                            Positioned(
                              right: 8.0,
                              top: 30.0,
                              child: Icon(
                                Icons.swipe_up,
                                color: Color(0xFF2196F3),
                                size: 32.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Quick swipe → Scroll',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                ),
              ],
            ),
            // Reorder gesture
            Column(
              children: [
                Container(
                  width: 120.0,
                  height: 180.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16.0),
                    border: Border.all(color: Colors.grey.shade400, width: 2.0),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(14.0),
                            topRight: Radius.circular(14.0),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: 28.0,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                    vertical: 3.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius:
                                        BorderRadius.circular(4.0),
                                  ),
                                ),
                                // Placeholder where item was
                                Container(
                                  height: 28.0,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                    vertical: 3.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius:
                                        BorderRadius.circular(4.0),
                                    border: Border.all(
                                      color: Colors.grey.shade400,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 28.0,
                                  margin: EdgeInsets.symmetric(
                                    horizontal: 6.0,
                                    vertical: 3.0,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.blue.shade50,
                                    borderRadius:
                                        BorderRadius.circular(4.0),
                                  ),
                                ),
                              ],
                            ),
                            // Elevated dragged item
                            Positioned(
                              left: 10.0,
                              right: 10.0,
                              top: 55.0,
                              child: Container(
                                height: 28.0,
                                decoration: BoxDecoration(
                                  color: Color(0xFF4CAF50).withValues(
                                    alpha: 0.3,
                                  ),
                                  borderRadius:
                                      BorderRadius.circular(4.0),
                                  border: Border.all(
                                    color: Color(0xFF4CAF50),
                                    width: 2.0,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.green.withValues(
                                        alpha: 0.3,
                                      ),
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              right: 8.0,
                              top: 50.0,
                              child: Icon(
                                Icons.touch_app,
                                color: Color(0xFF4CAF50),
                                size: 24.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Long-press + drag → Reorder',
                  style: TextStyle(
                    fontSize: 11.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7: Code Integration Pattern
  // ============================================================
  print('=== Section 7: Integration code ===');

  final integrationCode = Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFE8EAF6), Color(0xFFC5CAE9)],
      ),
      borderRadius: BorderRadius.circular(12.0),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Integration with ReorderableListView',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Color(0xFF283593),
          ),
        ),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Color(0xFF1A237E),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// ReorderableListView uses\n'
            '// ReorderableDelayedDragStartListener\n'
            '// by default on mobile platforms.\n\n'
            'ReorderableListView(\n'
            '  onReorder: (oldIndex, newIndex) {\n'
            '    setState(() {\n'
            '      final item = items.removeAt(oldIndex);\n'
            '      items.insert(newIndex, item);\n'
            '    });\n'
            '  },\n'
            '  children: items.map((item) {\n'
            '    return ListTile(\n'
            '      key: ValueKey(item.id),\n'
            '      title: Text(item.title),\n'
            '    );\n'
            '  }).toList(),\n'
            ')\n\n'
            '// Explicit usage in custom builder:\n'
            'ReorderableDelayedDragStartListener(\n'
            '  index: index,\n'
            '  child: myCustomItemWidget,\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Color(0xFF90CAF9),
            ),
          ),
        ),
        SizedBox(height: 12.0),
        _buildDelayedCodeStep(
          '1',
          'Default for mobile',
          'ReorderableListView automatically uses delayed drag '
              'on touch platforms for scroll-drag conflict resolution.',
          Color(0xFF283593),
        ),
        SizedBox(height: 6.0),
        _buildDelayedCodeStep(
          '2',
          'Custom builders',
          'When using ReorderableList with a custom builder, wrap '
              'each item in ReorderableDelayedDragStartListener.',
          Color(0xFF283593),
        ),
        SizedBox(height: 6.0),
        _buildDelayedCodeStep(
          '3',
          'Index required',
          'The index parameter must match the item\'s position. '
              'This tells the framework which item is being dragged.',
          Color(0xFF283593),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8: Enabled/Disabled State
  // ============================================================
  print('=== Section 8: Enabled vs disabled ===');

  Widget buildEnabledItem(bool enabled, String label, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.0),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: enabled ? Colors.white : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: enabled ? color : Colors.grey.shade300,
          width: enabled ? 1.5 : 1.0,
        ),
      ),
      child: Row(
        children: [
          Icon(
            enabled ? Icons.lock_open : Icons.lock,
            color: enabled ? color : Colors.grey.shade400,
            size: 20.0,
          ),
          SizedBox(width: 10.0),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.0,
                color: enabled ? Colors.grey.shade800 : Colors.grey.shade400,
                decoration: enabled ? null : TextDecoration.lineThrough,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: enabled
                  ? Color(0xFFE8F5E9)
                  : Color(0xFFFBE9E7),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              enabled ? 'Draggable' : 'Locked',
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: enabled ? Color(0xFF2E7D32) : Color(0xFFD32F2F),
              ),
            ),
          ),
        ],
      ),
    );
  }

  final enabledSection = Container(
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
          'Enabled vs Disabled Items',
          style: TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.grey.shade800,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          'Set enabled: false to prevent dragging specific items.\n'
          'Useful for pinned headers or locked items.',
          style: TextStyle(fontSize: 11.0, color: Colors.grey.shade600),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12.0),
        buildEnabledItem(true, 'Inbox', Color(0xFF2196F3)),
        buildEnabledItem(true, 'Starred', Color(0xFFFFA000)),
        buildEnabledItem(false, 'Sent (locked)', Color(0xFF9E9E9E)),
        buildEnabledItem(true, 'Drafts', Color(0xFF4CAF50)),
        buildEnabledItem(false, 'Trash (locked)', Color(0xFF9E9E9E)),
        SizedBox(height: 8.0),
        Container(
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Color(0xFFF3E5F5),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            'ReorderableDelayedDragStartListener(\n'
            '  index: 2,\n'
            '  enabled: false, // prevents drag\n'
            '  child: lockedItem,\n'
            ')',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.0,
              color: Color(0xFF4A148C),
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9: Summary
  // ============================================================
  print('=== Section 9: Summary ===');

  final summaryPanel = Container(
    margin: EdgeInsets.all(16.0),
    padding: EdgeInsets.all(16.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFFFFF8E1), Color(0xFFFFECB3)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: Color(0xFFFFA000), width: 1.5),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.summarize, color: Color(0xFFFF8F00), size: 28.0),
            SizedBox(width: 8.0),
            Text(
              'Summary',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color(0xFFE65100),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.0),
        _buildDelayedSummaryItem(
          Icons.timer,
          'Long-press required',
          'Prevents accidental reordering during scroll',
          Color(0xFFFF9800),
        ),
        SizedBox(height: 8.0),
        _buildDelayedSummaryItem(
          Icons.smartphone,
          'Default for touch',
          'ReorderableListView uses delayed drag on mobile by default',
          Color(0xFF2196F3),
        ),
        SizedBox(height: 8.0),
        _buildDelayedSummaryItem(
          Icons.build,
          'Same API as immediate',
          'Drop-in replacement — only changes the gesture recognizer',
          Color(0xFF4CAF50),
        ),
        SizedBox(height: 8.0),
        _buildDelayedSummaryItem(
          Icons.lock,
          'Disable per-item',
          'Set enabled: false for items that should not be dragged',
          Color(0xFF9C27B0),
        ),
        SizedBox(height: 8.0),
        _buildDelayedSummaryItem(
          Icons.vibration,
          'Haptic feedback',
          'System provides feedback when the delay threshold is met',
          Color(0xFFE91E63),
        ),
      ],
    ),
  );

  print('ReorderableDelayedDragStartListener Deep Demo complete');

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
                Color(0xFF1B5E20),
                Color(0xFF2E7D32),
                Color(0xFF388E3C),
              ],
            ),
          ),
          child: Column(
            children: [
              Icon(Icons.drag_handle, size: 48.0, color: Colors.white),
              SizedBox(height: 8.0),
              Text(
                'ReorderableDelayedDragStartListener',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                'Long-press to reorder — prevents accidental drags',
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
            '2. Drag Lifecycle',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        lifecycleRow,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '3. Delayed vs Immediate Timing',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        timelineComparison,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '4. Reorderable Task List',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        reorderableListSection,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '5. Item Style Gallery',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 8.0),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: styleGallery,
        ),
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '6. Scroll vs Drag Conflict',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        conflictExplanation,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '7. Code Integration',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        integrationCode,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '8. Enabled / Disabled Items',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        enabledSection,
        SizedBox(height: 24.0),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            '9. Summary',
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
Widget _buildDelayedCodeStep(
  String number,
  String title,
  String description,
  Color color,
) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 24.0,
        height: 24.0,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text(
          number,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
          ),
        ),
      ),
      SizedBox(width: 8.0),
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
            Text(
              description,
              style: TextStyle(fontSize: 11.0, color: Colors.grey.shade700),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget _buildDelayedSummaryItem(
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
