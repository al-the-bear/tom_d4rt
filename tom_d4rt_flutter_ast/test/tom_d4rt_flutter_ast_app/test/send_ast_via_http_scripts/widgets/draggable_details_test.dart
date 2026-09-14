// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — DraggableDetails
// Demonstrates DraggableDetails, the data class returned by
// Draggable.onDragEnd that records the final state of a drag:
// whether it was accepted by a target, the release velocity,
// and the final screen offset. Covers property anatomy,
// drag lifecycle, visual outcome scenarios, velocity
// interpretation, and the broader Draggable/DragTarget ecosystem.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DraggableDetails Deep Demo executing');

  // ============================================================
  // SECTION 1: What is DraggableDetails?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.pan_tool,
      'title': 'End-of-Drag Report',
      'body': 'DraggableDetails is a small immutable data class '
          'provided to Draggable\'s onDragEnd callback. When the '
          'user lifts their finger after dragging, Flutter creates '
          'a DraggableDetails describing exactly what happened: '
          'where the drag ended, how fast it was moving, and '
          'whether a DragTarget accepted it.',
      'accent': Colors.lightBlue[700]!,
    },
    {
      'icon': Icons.check_circle,
      'title': 'wasAccepted — Did a Target Take It?',
      'body': 'The boolean wasAccepted is true if the drag was '
          'released over a DragTarget that returned true from its '
          'onWillAcceptWithDetails callback (or the older '
          'onWillAccept). If the user dropped it in empty space '
          'or over a rejecting target, wasAccepted is false.',
      'accent': Colors.green[600]!,
    },
    {
      'icon': Icons.speed,
      'title': 'velocity — Release Speed & Direction',
      'body': 'Velocity records the speed (in pixels per second) '
          'and direction at the moment the user released. This is '
          'the same Velocity class from dart:ui — it has '
          'pixelsPerSecond (an Offset with dx/dy components). '
          'Useful for throw-to-dismiss or momentum effects.',
      'accent': Colors.blue[600]!,
    },
    {
      'icon': Icons.place,
      'title': 'offset — Final Screen Position',
      'body': 'The offset is the Offset (in global coordinates) '
          'where the feedback widget ended up when the drag was '
          'released. Combined with velocity and wasAccepted, '
          'you have complete information to animate the aftermath '
          '(snap back, fly away, settle into target, etc.).',
      'accent': Colors.lightBlue[800]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: The Three Properties
  // ============================================================
  print('=== Section 2: Properties ===');

  final properties = <Map<String, dynamic>>[
    {
      'name': 'wasAccepted',
      'type': 'bool',
      'icon': Icons.verified,
      'color': Colors.green[600]!,
      'bgColor': Colors.green[50]!,
      'description': 'True if a DragTarget accepted this drag. '
          'The acceptance is determined by DragTarget.onWillAccept'
          'WithDetails returning true. If the drag was released '
          'outside any target, or if all targets rejected, this '
          'is false.',
      'example': 'DraggableDetails(\n'
          '  wasAccepted: true,\n'
          '  velocity: Velocity.zero,\n'
          '  offset: Offset(200, 400),\n'
          ')',
    },
    {
      'name': 'velocity',
      'type': 'Velocity',
      'icon': Icons.trending_up,
      'color': Colors.blue[600]!,
      'bgColor': Colors.blue[50]!,
      'description': 'The velocity at release, in pixels per second. '
          'Velocity has a single property: pixelsPerSecond (Offset). '
          'A slow, careful drop gives nearly zero velocity. A fast '
          'fling gives high velocity in the swipe direction.',
      'example': 'details.velocity.pixelsPerSecond.dx  // horizontal\n'
          'details.velocity.pixelsPerSecond.dy  // vertical\n'
          'details.velocity.pixelsPerSecond.distance  // speed',
    },
    {
      'name': 'offset',
      'type': 'Offset',
      'icon': Icons.control_camera,
      'color': Colors.lightBlue[700]!,
      'bgColor': Colors.lightBlue[50]!,
      'description': 'The global screen offset where the feedback '
          'widget was when the drag ended. This is the top-left '
          'corner of the feedback widget, in screen coordinates. '
          'Useful for animating the return or snap animation.',
      'example': 'details.offset.dx  // x position (from left)\n'
          'details.offset.dy  // y position (from top)',
    },
  ];

  print('  Prepared ${properties.length} property descriptions');

  // ============================================================
  // SECTION 3: Drag Outcome Scenarios
  // ============================================================
  print('=== Section 3: Drag Outcome Scenarios ===');

  final outcomes = <Map<String, dynamic>>[
    {
      'title': 'Accepted — Dropped on Target',
      'icon': Icons.check_circle,
      'color': Colors.green[600]!,
      'bgColor': Colors.green[50]!,
      'wasAccepted': true,
      'velocityLabel': 'Low (~50 px/s)',
      'offsetLabel': 'Over target center',
      'description': 'The most common success case: user carefully '
          'drags an item and drops it on a valid target. Low '
          'velocity (gentle release), offset is within the '
          'target\'s bounds. The target\'s onAcceptWithDetails '
          'fires after this.',
    },
    {
      'title': 'Rejected — Target Said No',
      'icon': Icons.cancel,
      'color': Colors.red[500]!,
      'bgColor': Colors.red[50]!,
      'wasAccepted': false,
      'velocityLabel': 'Low (~30 px/s)',
      'offsetLabel': 'Over rejecting target',
      'description': 'The user dropped over a DragTarget, but '
          'onWillAcceptWithDetails returned false (e.g., wrong '
          'data type, target full, business rule violation). '
          'The feedback widget animates back to origin.',
    },
    {
      'title': 'Missed — Dropped in Empty Space',
      'icon': Icons.location_off,
      'color': Colors.orange[600]!,
      'bgColor': Colors.orange[50]!,
      'wasAccepted': false,
      'velocityLabel': 'Medium (~200 px/s)',
      'offsetLabel': 'Outside any target',
      'description': 'The user released while not over any '
          'DragTarget. wasAccepted is false. The Draggable\'s '
          'feedback snaps back to origin. This feels like a '
          '"cancelled" drag to the user.',
    },
    {
      'title': 'Flung — Fast Release',
      'icon': Icons.swipe,
      'color': Colors.purple[600]!,
      'bgColor': Colors.purple[50]!,
      'wasAccepted': false,
      'velocityLabel': 'High (~2000 px/s)',
      'offsetLabel': 'Far from origin',
      'description': 'A fast swipe released mid-flight. High '
          'velocity means the user was moving quickly. Even if '
          'the offset passes over a target, acceptance depends '
          'on where the drag ends, not the path. Custom logic '
          'can use the velocity for throw-dismiss effects.',
    },
    {
      'title': 'Accepted with Velocity',
      'icon': Icons.rocket_launch,
      'color': Colors.teal[600]!,
      'bgColor': Colors.teal[50]!,
      'wasAccepted': true,
      'velocityLabel': 'High (~1500 px/s)',
      'offsetLabel': 'Over target',
      'description': 'Dropped onto a target while still moving '
          'fast. wasAccepted is true AND velocity is high. This '
          'combination can trigger a special "flung into place" '
          'animation rather than a gentle settle.',
    },
  ];

  print('  Prepared ${outcomes.length} outcome scenarios');

  // ============================================================
  // SECTION 4: Velocity Visualization
  // ============================================================
  print('=== Section 4: Velocity Visualization ===');

  final velocityExamples = <Map<String, dynamic>>[
    {
      'label': 'Stationary drop',
      'dx': 0.0,
      'dy': 0.0,
      'speed': '0 px/s',
      'color': Colors.grey[500]!,
      'barFraction': 0.02,
    },
    {
      'label': 'Gentle rightward',
      'dx': 150.0,
      'dy': -20.0,
      'speed': '151 px/s',
      'color': Colors.lightBlue[400]!,
      'barFraction': 0.08,
    },
    {
      'label': 'Moderate downward',
      'dx': 30.0,
      'dy': 500.0,
      'speed': '501 px/s',
      'color': Colors.blue[500]!,
      'barFraction': 0.25,
    },
    {
      'label': 'Fast diagonal',
      'dx': 800.0,
      'dy': -600.0,
      'speed': '1000 px/s',
      'color': Colors.blue[700]!,
      'barFraction': 0.5,
    },
    {
      'label': 'Maximum fling',
      'dx': 1400.0,
      'dy': -1400.0,
      'speed': '1980 px/s',
      'color': Colors.blue[900]!,
      'barFraction': 1.0,
    },
  ];

  print('  Prepared ${velocityExamples.length} velocity examples');

  // ============================================================
  // SECTION 5: DraggableDetails in the Drag Lifecycle
  // ============================================================
  print('=== Section 5: Drag Lifecycle ===');

  final lifecycleSteps = <Map<String, dynamic>>[
    {
      'step': '1',
      'label': 'Drag Starts',
      'participant': 'Draggable',
      'color': Colors.lightBlue[500]!,
      'detail': 'User presses and starts dragging. onDragStarted '
          'fires (no DraggableDetails yet). The feedback widget '
          'appears under the finger. childWhenDragging replaces '
          'the original widget.',
    },
    {
      'step': '2',
      'label': 'Drag Moves',
      'participant': 'Framework',
      'color': Colors.lightBlue[600]!,
      'detail': 'As the finger moves, the feedback follows. '
          'DragTargets receive onMove callbacks when the drag '
          'enters their hit-test area. Still no DraggableDetails.',
    },
    {
      'step': '3',
      'label': 'Over a Target',
      'participant': 'DragTarget',
      'color': Colors.green[500]!,
      'detail': 'When the feedback overlaps a DragTarget, '
          'onWillAcceptWithDetails is called. The target returns '
          'true/false to indicate acceptance. This decision is '
          'stored for when the drag ends.',
    },
    {
      'step': '4',
      'label': 'Drag Ends',
      'participant': 'Framework',
      'color': Colors.blue[700]!,
      'detail': 'User lifts finger. Framework creates DraggableDetails '
          'with wasAccepted (from step 3), the current Velocity, '
          'and the final Offset. If accepted, DragTarget.onAccept'
          'WithDetails fires with a DragTargetDetails.',
    },
    {
      'step': '5',
      'label': 'onDragEnd Called',
      'participant': 'Draggable',
      'color': Colors.lightBlue[800]!,
      'detail': 'Draggable.onDragEnd(DraggableDetails details) fires. '
          'Your callback receives the DraggableDetails. Use it to '
          'update state, trigger animations, log analytics, or '
          'decide what happens next.',
    },
    {
      'step': '6',
      'label': 'Feedback Animates',
      'participant': 'Framework',
      'color': Colors.grey[600]!,
      'detail': 'If wasAccepted is false, the feedback widget '
          'animates back to its origin position. If true, the '
          'feedback disappears and the target arranges the '
          'received data.',
    },
  ];

  print('  Prepared ${lifecycleSteps.length} lifecycle steps');

  // ============================================================
  // SECTION 6: DraggableDetails vs DragTargetDetails
  // ============================================================
  print('=== Section 6: Comparison ===');

  final comparison = <Map<String, String>>[
    {
      'aspect': 'Who receives it',
      'draggableD': 'Draggable.onDragEnd',
      'targetD': 'DragTarget.onAcceptWithDetails',
    },
    {
      'aspect': 'When created',
      'draggableD': 'Every time a drag ends '
          '(accepted or rejected)',
      'targetD': 'Only when accepted',
    },
    {
      'aspect': 'Key property',
      'draggableD': 'wasAccepted (bool)',
      'targetD': 'data (T — the payload)',
    },
    {
      'aspect': 'velocity',
      'draggableD': 'Yes — release velocity',
      'targetD': 'No',
    },
    {
      'aspect': 'offset',
      'draggableD': 'Yes — global screen offset',
      'targetD': 'Yes — local to target',
    },
    {
      'aspect': 'Purpose',
      'draggableD': 'Source decides what to do '
          'after drag',
      'targetD': 'Target receives and processes '
          'the dragged data',
    },
  ];

  print('  Prepared ${comparison.length} comparison rows');

  // ============================================================
  // SECTION 7: The Draggable Family
  // ============================================================
  print('=== Section 7: Draggable Family ===');

  final family = <Map<String, dynamic>>[
    {
      'name': 'Draggable<T>',
      'icon': Icons.open_with,
      'color': Colors.lightBlue[600]!,
      'description': 'Base class. Starts dragging immediately on '
          'pan gesture. Provides onDragEnd(DraggableDetails).',
    },
    {
      'name': 'LongPressDraggable<T>',
      'icon': Icons.touch_app,
      'color': Colors.indigo[500]!,
      'description': 'Starts dragging only after a long press. '
          'Also provides onDragEnd(DraggableDetails). Better for '
          'lists where scroll conflicts with drag.',
    },
    {
      'name': 'DragTarget<T>',
      'icon': Icons.crop_free,
      'color': Colors.green[600]!,
      'description': 'The receiver. Uses onWillAcceptWithDetails '
          'to decide, onAcceptWithDetails to process. Receives '
          'DragTargetDetails (not DraggableDetails).',
    },
    {
      'name': 'DraggableScrollableSheet',
      'icon': Icons.vertical_align_bottom,
      'color': Colors.purple[500]!,
      'description': 'A different concept — a scrollable sheet that '
          'can be dragged. Not related to drag-and-drop; does NOT '
          'produce DraggableDetails.',
    },
  ];

  print('  Prepared ${family.length} family members');

  // ============================================================
  // SECTION 8: Real-World Patterns
  // ============================================================
  print('=== Section 8: Real-World Patterns ===');

  final patterns = <Map<String, dynamic>>[
    {
      'title': 'Snap-Back Animation',
      'icon': Icons.undo,
      'color': Colors.lightBlue[600]!,
      'body': 'When wasAccepted is false, use the offset to animate '
          'the item back to its original position. The default '
          'Draggable does this automatically, but custom feedback '
          'widgets may need manual animation using the offset.',
    },
    {
      'title': 'Throw-to-Delete',
      'icon': Icons.delete_sweep,
      'color': Colors.red[500]!,
      'body': 'Use velocity.pixelsPerSecond.distance to detect '
          'a fast fling. If the speed exceeds a threshold (e.g., '
          '1000 px/s), treat it as a "throw away" gesture and '
          'delete the item — even without a formal DragTarget.',
    },
    {
      'title': 'Kanban Board',
      'icon': Icons.view_column,
      'color': Colors.blue[600]!,
      'body': 'In a Kanban-style board, onDragEnd tells the source '
          'column whether the card was accepted by another column. '
          'If wasAccepted is true, remove from source. If false, '
          'the card stays (user cancelled).',
    },
    {
      'title': 'Reorderable Grid',
      'icon': Icons.grid_view,
      'color': Colors.teal[600]!,
      'body': 'Combine wasAccepted + offset to determine the final '
          'grid position. If the drop was accepted, rearrange '
          'items. Use offset to calculate which cell the item '
          'landed in for smooth placement.',
    },
    {
      'title': 'Analytics & Logging',
      'icon': Icons.analytics,
      'color': Colors.deepPurple[500]!,
      'body': 'Log every DraggableDetails for UX analytics: how '
          'often users drag successfully, average velocity, '
          'common drop locations. This data reveals interaction '
          'patterns and usability issues.',
    },
  ];

  print('  Prepared ${patterns.length} real-world patterns');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.warning_amber,
      'title': 'onDragEnd Fires for ALL Drags',
      'body': 'Even if the drag was rejected or dropped in empty '
          'space, onDragEnd fires. Always check wasAccepted '
          'before taking acceptance-specific actions like '
          'removing the item from a list.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Velocity Can Be Zero',
      'body': 'If the user holds the drag still for a moment before '
          'releasing, the velocity is Velocity.zero. Don\'t divide '
          'by velocity.pixelsPerSecond.distance without checking '
          'for zero first.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Offset Is Global',
      'body': 'DraggableDetails.offset is in the global screen '
          'coordinate system (from top-left of screen). If you '
          'need local coordinates relative to a specific widget, '
          'use RenderBox.globalToLocal() to convert.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'No Data Property',
      'body': 'Unlike DragTargetDetails, DraggableDetails does '
          'NOT carry the data payload. The Draggable already '
          'knows its own data. If you need to reference it in '
          'onDragEnd, capture it in a closure or use the widget '
          'state.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Feedback Widget Cleanup',
      'body': 'After onDragEnd, the feedback widget is removed '
          'from the overlay. If your feedback widget manages '
          'resources (controllers, streams), dispose them in '
          'the widget\'s dispose method, not in onDragEnd.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Combine with onDragCompleted',
      'body': 'Draggable also has onDragCompleted (no parameters) '
          'that fires only when accepted. If you only need the '
          '"was it accepted?" signal without velocity/offset, '
          'use that simpler callback instead.',
      'severity': 'tip',
    },
  ];

  print('  Prepared ${tips.length} tips');

  // ============================================================
  // BUILD THE VISUAL LAYOUT
  // ============================================================
  print('=== Building visual layout ===');

  return Scaffold(
    backgroundColor: Colors.grey[50],
    appBar: AppBar(
      title: Text('DraggableDetails'),
      backgroundColor: Colors.lightBlue[700],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header banner ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.lightBlue[700]!, Colors.blue[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.pan_tool, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'DraggableDetails',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The end-of-drag report: wasAccepted, velocity, '
                  'and offset — everything you need to know about '
                  'what happened when the user finished dragging.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 1: Concept ──
          _sectionHeading('1', 'What is DraggableDetails?'),
          SizedBox(height: 12),
          ...conceptCards.map((card) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: card['accent'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(card['icon'] as IconData,
                            color: card['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(card['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(card['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: Properties ──
          _sectionHeading('2', 'The Three Properties'),
          SizedBox(height: 12),
          ...properties.map((prop) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: prop['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: (prop['color'] as Color).withOpacity(0.4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: prop['color'] as Color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(prop['icon'] as IconData,
                              color: Colors.white, size: 20),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('.${prop['name']}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'monospace',
                                      color: prop['color'] as Color)),
                              Text(prop['type'] as String,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.grey[600])),
                            ],
                          ),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(prop['description'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[800],
                              height: 1.4)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(prop['example'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'monospace',
                                color: Colors.grey[700],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Outcome Scenarios ──
          _sectionHeading('3', 'Drag Outcome Scenarios'),
          SizedBox(height: 12),
          ...outcomes.map((o) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: o['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: (o['color'] as Color).withOpacity(0.4)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(o['icon'] as IconData,
                            color: o['color'] as Color, size: 22),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(o['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Row(children: [
                        _detailChip('accepted', '${o['wasAccepted']}',
                            (o['wasAccepted'] as bool)
                                ? Colors.green[600]!
                                : Colors.red[500]!),
                        SizedBox(width: 6),
                        _detailChip(
                            'velocity',
                            o['velocityLabel'] as String,
                            Colors.blue[500]!),
                        SizedBox(width: 6),
                        _detailChip(
                            'offset',
                            o['offsetLabel'] as String,
                            Colors.grey[600]!),
                      ]),
                      SizedBox(height: 10),
                      Text(o['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Velocity Visualization ──
          _sectionHeading('4', 'Velocity at Release'),
          SizedBox(height: 8),
          Text(
            'The velocity\'s pixelsPerSecond has dx (horizontal) '
            'and dy (vertical) components. The total speed is '
            'the distance: sqrt(dx² + dy²).',
            style: TextStyle(
                fontSize: 13, color: Colors.grey[600], height: 1.5),
          ),
          SizedBox(height: 12),
          ...velocityExamples.map((ve) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: (ve['color'] as Color).withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: ve['color'] as Color,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(ve['label'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13)),
                        Spacer(),
                        Text(
                          'dx=${(ve['dx'] as double).toStringAsFixed(0)}, '
                          'dy=${(ve['dy'] as double).toStringAsFixed(0)} '
                          '→ ${ve['speed']}',
                          style: TextStyle(
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: Colors.grey[600]),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        height: 14,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor:
                              (ve['barFraction'] as double).clamp(0.02, 1.0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  (ve['color'] as Color).withOpacity(0.6),
                                  ve['color'] as Color,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Lifecycle ──
          _sectionHeading('5', 'Drag Lifecycle — When DraggableDetails Appears'),
          SizedBox(height: 12),
          ...lifecycleSteps.map((step) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: step['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(step['step'] as String,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ),
                      Container(
                          width: 2, height: 28, color: Colors.grey[300]),
                    ]),
                    SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 2,
                                offset: Offset(0, 1))
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text(step['label'] as String,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13)),
                              Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: (step['color'] as Color)
                                      .withOpacity(0.15),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(step['participant'] as String,
                                    style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: step['color'] as Color)),
                              ),
                            ]),
                            SizedBox(height: 6),
                            Text(step['detail'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    height: 1.4)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Comparison Table ──
          _sectionHeading('6', 'DraggableDetails vs DragTargetDetails'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2))
              ],
            ),
            child: Column(children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.lightBlue[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  _tCell('Aspect', bold: true, white: true, flex: 2),
                  _tCell('DraggableDetails', bold: true, white: true, flex: 3),
                  _tCell('DragTargetDetails', bold: true, white: true, flex: 3),
                ]),
              ),
              ...comparison.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _tCell(row['aspect']!, bold: true, flex: 2),
                      _tCell(row['draggableD']!, flex: 3),
                      _tCell(row['targetD']!, flex: 3),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 7: Draggable Family ──
          _sectionHeading('7', 'The Draggable / DragTarget Family'),
          SizedBox(height: 12),
          ...family.map((f) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: f['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (f['color'] as Color).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(f['icon'] as IconData,
                            color: f['color'] as Color, size: 22),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(f['name'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    fontFamily: 'monospace')),
                            SizedBox(height: 4),
                            Text(f['description'] as String,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                    height: 1.4)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Real-World Patterns ──
          _sectionHeading('8', 'Real-World Patterns'),
          SizedBox(height: 12),
          ...patterns.map((p) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: p['color'] as Color, width: 4),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 3,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(p['icon'] as IconData,
                            color: p['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(p['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(p['body'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips & Gotchas ──
          _sectionHeading('9', 'Tips, Pitfalls & Gotchas'),
          SizedBox(height: 12),
          ...tips.map((tip) {
            Color bgColor;
            Color borderColor;
            switch (tip['severity']) {
              case 'warning':
                bgColor = Colors.amber[50]!;
                borderColor = Colors.amber[400]!;
                break;
              case 'tip':
                bgColor = Colors.green[50]!;
                borderColor = Colors.green[400]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
                borderColor = Colors.blue[300]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border(
                      left: BorderSide(color: borderColor, width: 4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(tip['icon'] as IconData,
                          color: borderColor, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(tip['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: Colors.grey[900])),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(tip['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

          SizedBox(height: 32),

          // ── Footer ──
          Center(
            child: Text(
              'End of DraggableDetails Deep Demo',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Section heading with numbered badge
// ──────────────────────────────────────────────────────────
Widget _sectionHeading(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.lightBlue[700],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(number,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14)),
        ),
      ),
      SizedBox(width: 10),
      Expanded(
        child: Text(title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[900])),
      ),
    ],
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Table cell
// ──────────────────────────────────────────────────────────
Widget _tCell(String text,
    {bool bold = false, bool white = false, int flex = 1}) {
  return Expanded(
    flex: flex,
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        color: white ? Colors.white : Colors.grey[800],
        height: 1.3,
      ),
    ),
  );
}

// ──────────────────────────────────────────────────────────
// Helper: Small detail chip for scenario cards
// ──────────────────────────────────────────────────────────
Widget _detailChip(String label, String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(6),
      border: Border.all(color: color.withOpacity(0.3)),
    ),
    child: Text(
      '$label: $value',
      style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.w600),
    ),
  );
}
