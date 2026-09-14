// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — DragScrollActivity
// Demonstrates DragScrollActivity — the ScrollActivity subclass
// that is active while the user is physically dragging a
// scrollable widget.  It receives drag updates from the gesture
// detector and translates them into scroll offset changes.
// When the user lifts their finger, it transitions to either
// BallisticScrollActivity (fling) or IdleScrollActivity (stop).
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DragScrollActivity Deep Demo executing');

  // ============================================================
  // SECTION 1: What is DragScrollActivity?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.touch_app,
      'title': 'User-Driven Scrolling',
      'body': 'DragScrollActivity is the ScrollActivity subclass that '
          'represents user-initiated, touch-or-pointer-driven drag '
          'scrolling. It is created when the user puts their finger '
          'down on a scrollable and starts moving. It processes raw '
          'drag deltas and converts them to pixel offsets.',
      'accent': Colors.teal[600]!,
    },
    {
      'icon': Icons.swap_vert,
      'title': 'From Gesture to Pixels',
      'body': 'The Scrollable\'s gesture detector captures raw pointer '
          'events. When a drag is recognized, a DragScrollActivity is '
          'created and installed on the ScrollPosition. It receives '
          'update(delta) calls and applies the delta to the scroll '
          'offset via ScrollPosition.setPixels().',
      'accent': Colors.indigo[500]!,
    },
    {
      'icon': Icons.sync_alt,
      'title': 'Activity State Machine',
      'body': 'ScrollPosition maintains a current activity. DragScrollActivity '
          'is one of several states: Idle (no scrolling), Drag (user dragging), '
          'Ballistic (momentum after fling), Driven (programmatic animation). '
          'The transition Idle → Drag → Ballistic/Idle is the standard touch '
          'scroll lifecycle.',
      'accent': Colors.teal[500]!,
    },
    {
      'icon': Icons.speed,
      'title': 'Velocity Tracking',
      'body': 'DragScrollActivity tracks the velocity of the user\'s '
          'drag gesture. When the drag ends, this velocity is passed '
          'to the ScrollPhysics to determine if a ballistic (fling) '
          'animation should start and how fast it should be. This '
          'enables natural "flick to scroll" behavior.',
      'accent': Colors.indigo[400]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Activity State Machine
  // ============================================================
  print('=== Section 2: State Machine ===');

  final states = <Map<String, dynamic>>[
    {
      'name': 'IdleScrollActivity',
      'icon': Icons.pause_circle_outline,
      'color': Colors.grey[500]!,
      'desc': 'No scrolling happening. The default resting state. '
          'The ScrollPosition is at rest and not responding to '
          'any scroll input.',
      'transition': 'User touches → Drag',
    },
    {
      'name': 'DragScrollActivity',
      'icon': Icons.touch_app,
      'color': Colors.teal[600]!,
      'desc': 'User is actively dragging. Receives delta updates from '
          'the gesture detector. Tracks velocity. Applies pixels. '
          'THIS IS THE CLASS THIS DEMO IS ABOUT.',
      'transition': 'User lifts → Ballistic or Idle',
    },
    {
      'name': 'BallisticScrollActivity',
      'icon': Icons.trending_flat,
      'color': Colors.orange[500]!,
      'desc': 'Momentum scrolling after a fling gesture. Created with '
          'the velocity from DragScrollActivity\'s end event. Runs '
          'a simulation until friction stops it.',
      'transition': 'Simulation ends → Idle',
    },
    {
      'name': 'DrivenScrollActivity',
      'icon': Icons.code,
      'color': Colors.purple[400]!,
      'desc': 'Programmatic animated scrolling (e.g., animateTo()). '
          'Not user-initiated. Runs an explicit animation curve. '
          'Can be interrupted by user touch → Drag.',
      'transition': 'Animation completes → Idle',
    },
  ];

  print('  Prepared ${states.length} states');

  // ============================================================
  // SECTION 3: Inside DragScrollActivity
  // ============================================================
  print('=== Section 3: Internals ===');

  final internals = <Map<String, dynamic>>[
    {
      'name': 'ScrollDragController',
      'kind': 'Core Component',
      'color': Colors.teal[600]!,
      'desc': 'The actual drag logic is in ScrollDragController, '
          'which DragScrollActivity delegates to. It handles drag '
          'start, update, end, and cancel events. It also manages '
          'overscroll behavior by consulting ScrollPhysics.',
    },
    {
      'name': 'update(DragUpdateDetails)',
      'kind': 'Method',
      'color': Colors.indigo[500]!,
      'desc': 'Called on every drag update with the pixel delta. '
          'ScrollDragController applies the delta via '
          'ScrollPosition.applyUserOffset(). The physics may '
          'modify the delta (e.g., reduce for overscroll).',
    },
    {
      'name': 'end(DragEndDetails)',
      'kind': 'Method',
      'color': Colors.teal[500]!,
      'desc': 'Called when the user lifts their finger. Receives the '
          'velocity from the gesture detector. Passes velocity to '
          'ScrollPosition.goBallistic() which either starts a '
          'BallisticScrollActivity or goes idle.',
    },
    {
      'name': 'cancel()',
      'kind': 'Method',
      'color': Colors.indigo[400]!,
      'desc': 'Called when the drag is cancelled (e.g., by the system). '
          'Calls goBallistic(0.0) — zero velocity means no fling, so '
          'the scroll position typically goes idle.',
    },
    {
      'name': 'delegate (ScrollActivityDelegate)',
      'kind': 'Property',
      'color': Colors.teal[400]!,
      'desc': 'DragScrollActivity communicates with ScrollPosition '
          'through the ScrollActivityDelegate interface. Methods like '
          'setPixels(), applyUserOffset(), and goBallistic() are all '
          'on the delegate.',
    },
    {
      'name': 'dispatchScrollStartNotification()',
      'kind': 'Method',
      'color': Colors.indigo[500]!,
      'desc': 'When DragScrollActivity is installed, it dispatches a '
          'ScrollStartNotification. This notifies ancestors like '
          'NestedScrollView, RefreshIndicator, or custom listeners '
          'that the user is scrolling.',
    },
  ];

  print('  Prepared ${internals.length} internals');

  // ============================================================
  // SECTION 4: Drag-to-Scroll Flow
  // ============================================================
  print('=== Section 4: Flow ===');

  final flow = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'Pointer Down',
      'color': Colors.teal[600]!,
      'detail': 'User puts finger on screen. The Scrollable\'s gesture '
          'detector receives a PointerDownEvent. A VerticalDragGestureRecognizer '
          '(or Horizontal) starts tracking the pointer.',
    },
    {
      'step': 2,
      'title': 'Drag Recognized',
      'color': Colors.indigo[500]!,
      'detail': 'After the pointer moves past the drag threshold '
          '(kTouchSlop ≈ 18px by default), the gesture recognizer '
          'accepts the drag. It calls ScrollableState._handleDragStart().',
    },
    {
      'step': 3,
      'title': 'DragScrollActivity Created',
      'color': Colors.teal[500]!,
      'detail': 'ScrollPosition.drag() creates a new ScrollDragController '
          'and a DragScrollActivity. The activity is installed as the '
          'current activity. ScrollStartNotification is dispatched.',
    },
    {
      'step': 4,
      'title': 'Drag Updates',
      'color': Colors.indigo[400]!,
      'detail': 'Each pointer move generates a DragUpdateDetails. The '
          'delta is passed to ScrollDragController.update() which calls '
          'applyUserOffset(). ScrollPhysics decides how much of the '
          'delta is applied (e.g., dampened at edges).',
    },
    {
      'step': 5,
      'title': 'Overscroll Handling',
      'color': Colors.teal[400]!,
      'detail': 'If the user drags past the scroll extent, '
          'ScrollPhysics.applyPhysicsToUserOffset() reduces the '
          'applied delta. On Android, this feeds into the overscroll '
          'glow. On iOS, it gives the rubbery bounce effect.',
    },
    {
      'step': 6,
      'title': 'Pointer Up (Drag End)',
      'color': Colors.indigo[500]!,
      'detail': 'User lifts finger. The gesture detector calculates '
          'the final velocity. ScrollDragController.end() calls '
          'goBallistic(velocity). If velocity is significant, '
          'BallisticScrollActivity starts. Otherwise, goes idle.',
    },
    {
      'step': 7,
      'title': 'Transition',
      'color': Colors.teal[600]!,
      'detail': 'ScrollPosition.goBallistic() creates a simulation '
          'via ScrollPhysics.createBallisticSimulation(). If the '
          'simulation is non-null, a BallisticScrollActivity replaces '
          'the DragScrollActivity. If null, IdleScrollActivity takes over.',
    },
  ];

  print('  Prepared ${flow.length} flow steps');

  // ============================================================
  // SECTION 5: Physics Integration
  // ============================================================
  print('=== Section 5: Physics ===');

  final physicsCards = <Map<String, dynamic>>[
    {
      'title': 'BouncingScrollPhysics (iOS)',
      'icon': Icons.phone_iphone,
      'color': Colors.teal[500]!,
      'desc': 'During drag: allows overscroll with rubber-banding '
          'effect. applyPhysicsToUserOffset() returns a reduced '
          'delta when past bounds. At drag end: creates a '
          'simulation that bounces back to bounds.',
    },
    {
      'title': 'ClampingScrollPhysics (Android)',
      'icon': Icons.phone_android,
      'color': Colors.indigo[500]!,
      'desc': 'During drag: clamps to bounds, no overscroll. '
          'applyPhysicsToUserOffset() returns zero past bounds. '
          'Instead, overscroll amount triggers the OverscrollIndicator '
          'glow effect. At drag end: fling decelerates using '
          'Android-style friction.',
    },
    {
      'title': 'NeverScrollableScrollPhysics',
      'icon': Icons.block,
      'color': Colors.grey[500]!,
      'desc': 'Returns false from shouldAcceptUserOffset(). This '
          'prevents DragScrollActivity from being created at all. '
          'The Scrollable accepts the gesture but doesn\'t scroll. '
          'Used for PageView with controller-only scrolling.',
    },
    {
      'title': 'Custom ScrollPhysics',
      'icon': Icons.tune,
      'color': Colors.purple[400]!,
      'desc': 'You can create custom ScrollPhysics to modify drag '
          'behavior. Override applyPhysicsToUserOffset() to change '
          'how drags feel, or createBallisticSimulation() to change '
          'fling behavior. DragScrollActivity works with any physics.',
    },
  ];

  print('  Prepared ${physicsCards.length} physics cards');

  // ============================================================
  // SECTION 6: DragScrollActivity vs Siblings
  // ============================================================
  print('=== Section 6: Comparisons ===');

  final comparisons = <Map<String, dynamic>>[
    {
      'feature': 'Trigger',
      'drag': 'User finger/pointer drag',
      'ballistic': 'Fling velocity after drag end',
      'driven': 'animateTo() / jumpTo()',
    },
    {
      'feature': 'Duration',
      'drag': 'As long as finger is down',
      'ballistic': 'Until physics simulation settles',
      'driven': 'Explicit animation duration',
    },
    {
      'feature': 'Velocity Source',
      'drag': 'Live from pointer movement',
      'ballistic': 'Initial velocity from drag end',
      'driven': 'Animation curve determines velocity',
    },
    {
      'feature': 'User Can Interrupt',
      'drag': 'N/A (IS the user interaction)',
      'ballistic': 'Yes, new touch starts Drag',
      'driven': 'Yes, new touch starts Drag',
    },
    {
      'feature': 'Overscroll',
      'drag': 'Physics-dependent dampening',
      'ballistic': 'Bounce or clamp at edges',
      'driven': 'Clamped (animateTo respects bounds)',
    },
    {
      'feature': 'Notification',
      'drag': 'ScrollStartNotification',
      'ballistic': 'Continues from drag',
      'driven': 'ScrollStartNotification',
    },
  ];

  print('  Prepared ${comparisons.length} comparisons');

  // ============================================================
  // SECTION 7: Notifications During Drag
  // ============================================================
  print('=== Section 7: Notifications ===');

  final notifications = <Map<String, dynamic>>[
    {
      'title': 'ScrollStartNotification',
      'timing': 'When DragScrollActivity is installed',
      'color': Colors.teal[600]!,
      'desc': 'Dispatched immediately when the drag begins. Contains '
          'the DragStartDetails. Ancestors like NestedScrollView use '
          'this to coordinate nested scrolling.',
    },
    {
      'title': 'ScrollUpdateNotification',
      'timing': 'On every drag update',
      'color': Colors.indigo[500]!,
      'desc': 'Dispatched after each pixel change. Contains the scroll '
          'delta and overscroll amount (if any). Listeners use this '
          'for scroll-dependent animations (e.g., parallax).',
    },
    {
      'title': 'OverscrollNotification',
      'timing': 'When dragging past bounds',
      'color': Colors.teal[500]!,
      'desc': 'Dispatched when setPixels() returns non-zero overscroll. '
          'OverscrollIndicator listens for this to show the Android '
          'glow effect. Not dispatched with BouncingScrollPhysics.',
    },
    {
      'title': 'ScrollEndNotification',
      'timing': 'When drag activity is replaced',
      'color': Colors.indigo[400]!,
      'desc': 'Dispatched when DragScrollActivity.dispose() is called '
          '(i.e., when a new activity replaces it). Signals the end '
          'of the user\'s active drag.',
    },
    {
      'title': 'UserScrollNotification',
      'timing': 'On activity transitions',
      'color': Colors.teal[400]!,
      'desc': 'Dispatched with ScrollDirection.forward or .reverse '
          'to indicate the user\'s scroll direction. Sent during drag '
          'activity start and end. Used by SliverAppBar for show/hide.',
    },
  ];

  print('  Prepared ${notifications.length} notifications');

  // ============================================================
  // SECTION 8: Related Concepts
  // ============================================================
  print('=== Section 8: Related ===');

  final relatedConcepts = <Map<String, dynamic>>[
    {
      'name': 'ScrollPosition',
      'color': Colors.teal[600]!,
      'desc': 'The owning object. ScrollPosition creates and manages '
          'activities. DragScrollActivity is one of several potential '
          'currentActivity values. The position holds the actual '
          'pixel offset and min/max extents.',
    },
    {
      'name': 'ScrollPhysics',
      'color': Colors.indigo[500]!,
      'desc': 'Defines how drags feel. DragScrollActivity delegates '
          'physics decisions (dampening, clamping, overscroll) to '
          'the configured ScrollPhysics. Different physics give '
          'different drag behaviors.',
    },
    {
      'name': 'ScrollDragController',
      'color': Colors.teal[500]!,
      'desc': 'The actual Drag interface implementation. '
          'DragScrollActivity wraps a ScrollDragController which '
          'handles update/end/cancel. The drag controller calls '
          'back to ScrollPosition via the delegate.',
    },
    {
      'name': 'Scrollable',
      'color': Colors.indigo[400]!,
      'desc': 'The widget that hosts scrolling. Its ScrollableState '
          'creates the gesture detector that recognizes drags and '
          'calls ScrollPosition.drag() to start a DragScrollActivity.',
    },
    {
      'name': 'GestureDetector',
      'color': Colors.teal[400]!,
      'desc': 'Raw gesture recognition. Scrollable wraps its child in '
          'a RawGestureDetector with VerticalDragGestureRecognizer '
          'and/or HorizontalDragGestureRecognizer. These feed '
          'into DragScrollActivity.',
    },
  ];

  print('  Prepared ${relatedConcepts.length} concepts');

  // ============================================================
  // SECTION 9: Tips
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Customize Via Physics, Not Activity',
      'body': 'You almost never need to subclass DragScrollActivity. '
          'Instead, customize drag behavior through ScrollPhysics. '
          'Override applyPhysicsToUserOffset() for drag feel and '
          'createBallisticSimulation() for fling behavior.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Listen With NotificationListener',
      'body': 'To react to drag scrolling, wrap your widget in '
          'NotificationListener<ScrollUpdateNotification> or use '
          'ScrollController.addListener(). Don\'t try to intercept '
          'the Activity directly.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Drag Direction Matters',
      'body': 'Axis.vertical uses VerticalDragGestureRecognizer, '
          'Axis.horizontal uses HorizontalDragGestureRecognizer. '
          'Nested scrollables on the same axis compete for gestures. '
          'Use NestedScrollView for coordinated scrolling.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Interrupting Animations',
      'body': 'When a user touches during a BallisticScrollActivity '
          'or DrivenScrollActivity, the existing activity is replaced '
          'by a new HoldScrollActivity, then DragScrollActivity. '
          'User touch always takes priority.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Velocity Threshold',
      'body': 'DragEndDetails includes velocity. ScrollPhysics has '
          'a minFlingVelocity. If the drag end velocity is below '
          'this threshold, no BallisticScrollActivity is created '
          'and the position goes idle. Defaults to 50 px/s.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Don\'t Hold References',
      'body': 'DragScrollActivity is ephemeral. It exists only while '
          'the user is dragging. Don\'t try to store or cache it. '
          'Once the drag ends, a new activity replaces it and the '
          'DragScrollActivity is disposed.',
      'severity': 'warning',
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
      title: Text('DragScrollActivity'),
      backgroundColor: Colors.teal[600],
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header ──
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal[600]!, Colors.indigo[400]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.touch_app, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'DragScrollActivity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The ScrollActivity that manages user-driven drag scrolling. '
                  'Active from finger-down to finger-up, it converts pointer '
                  'deltas into scroll offset changes through ScrollPhysics, '
                  'tracks velocity for fling detection, and coordinates '
                  'notifications for the scroll ecosystem.',
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
          _dsHead('1', 'What is DragScrollActivity?'),
          SizedBox(height: 12),
          ...conceptCards.map((c) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: c['accent'] as Color, width: 4),
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
                        Icon(c['icon'] as IconData,
                            color: c['accent'] as Color, size: 22),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(c['title'] as String,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 10),
                      Text(c['body'] as String,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey[700],
                              height: 1.5)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 2: State Machine ──
          _dsHead('2', 'Activity State Machine'),
          SizedBox(height: 12),
          ...states.map((s) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: s['name'] == 'DragScrollActivity'
                        ? Colors.teal[50]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: s['color'] as Color, width: 4),
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
                        Icon(s['icon'] as IconData,
                            color: s['color'] as Color, size: 22),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(s['name'] as String,
                              style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.grey[900])),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(s['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                      SizedBox(height: 6),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: (s['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text('→ ${s['transition']}',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: s['color'] as Color)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: Internals ──
          _dsHead('3', 'Inside DragScrollActivity'),
          SizedBox(height: 12),
          ...internals.map((i) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: i['color'] as Color, width: 4),
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
                        _dsTag(i['kind'] as String,
                            i['color'] as Color),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(i['name'] as String,
                              style: TextStyle(
                                  fontFamily: 'monospace',
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800])),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(i['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: Flow ──
          _dsHead('4', 'Drag-to-Scroll Flow'),
          SizedBox(height: 12),
          ...flow.map((f) => Padding(
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
                        width: 26,
                        height: 26,
                        decoration: BoxDecoration(
                          color: f['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${f['step']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 11,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(f['title'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    fontFamily: 'monospace')),
                            SizedBox(height: 4),
                            Text(f['detail'] as String,
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Colors.grey[700],
                                    height: 1.3)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Physics ──
          _dsHead('5', 'Physics Integration'),
          SizedBox(height: 12),
          ...physicsCards.map((p) => Padding(
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
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(p['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Comparisons ──
          _dsHead('6', 'Activity Comparison'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 1))
              ],
            ),
            child: Column(
              children: [
                // Header row
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.teal[600],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                          width: 75,
                          child: Text('Feature',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text('Drag',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text('Ballistic',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold))),
                      Expanded(
                          child: Text('Driven',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                ),
                // Data rows
                ...comparisons.asMap().entries.map((entry) {
                  final c = entry.value;
                  final isEven = entry.key.isEven;
                  return Container(
                    padding: EdgeInsets.all(8),
                    color: isEven ? Colors.grey[50] : Colors.white,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 75,
                            child: Text(c['feature'] as String,
                                style: TextStyle(
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[800]))),
                        Expanded(
                            child: Text(c['drag'] as String,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.teal[700]))),
                        Expanded(
                            child: Text(c['ballistic'] as String,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.orange[700]))),
                        Expanded(
                            child: Text(c['driven'] as String,
                                style: TextStyle(
                                    fontSize: 8,
                                    color: Colors.purple[600]))),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),

          SizedBox(height: 24),

          // ── Section 7: Notifications ──
          _dsHead('7', 'Notifications During Drag'),
          SizedBox(height: 12),
          ...notifications.map((n) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: n['color'] as Color, width: 4),
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
                        _dsTag(n['title'] as String,
                            n['color'] as Color),
                      ]),
                      SizedBox(height: 4),
                      Text(n['timing'] as String,
                          style: TextStyle(
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey[500])),
                      SizedBox(height: 6),
                      Text(n['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Related ──
          _dsHead('8', 'Related Concepts'),
          SizedBox(height: 12),
          ...relatedConcepts.map((r) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: r['color'] as Color, width: 4),
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
                      _dsTag(r['name'] as String, r['color'] as Color),
                      SizedBox(height: 8),
                      Text(r['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 9: Tips ──
          _dsHead('9', 'Tips & Best Practices'),
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
          Center(
            child: Text(
              'End of DragScrollActivity Deep Demo',
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
// Helper: Section heading
// ──────────────────────────────────────────────────────────
Widget _dsHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.teal[600],
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
// Helper: Tag/label
// ──────────────────────────────────────────────────────────
Widget _dsTag(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.12),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(text,
        style: TextStyle(
            color: color,
            fontSize: 9,
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace')),
  );
}
