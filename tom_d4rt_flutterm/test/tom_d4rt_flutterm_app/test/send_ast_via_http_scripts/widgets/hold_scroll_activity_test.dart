// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — HoldScrollActivity
// Demonstrates HoldScrollActivity — the scroll activity that fires
// when a user touches the screen during a ballistic scroll. Covers
// scroll activity lifecycle, ScrollPosition activity management,
// the hold-cancel-idle cycle, integration with physics, and
// real-world implications for custom scroll views.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('HoldScrollActivity Deep Demo executing');

  // ============================================================
  // SECTION 1: What is HoldScrollActivity?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.pan_tool,
      'title': 'Stopping a Scroll in Progress',
      'body': 'HoldScrollActivity is the ScrollActivity that '
          'takes over when a user places their finger on a '
          'scrollable that is currently animating (flinging). '
          'Touching the screen during a fling cancels the ballistic '
          'animation and creates a HoldScrollActivity — the scroll '
          'is "held" still at the current position.',
      'accent': Colors.red[700]!,
    },
    {
      'icon': Icons.touch_app,
      'title': 'Between Fling and Drag',
      'body': 'HoldScrollActivity is a transitional state. It '
          'exists in the gap between "the fling just stopped" and '
          '"the user starts a new drag". If the user lifts their '
          'finger without dragging, the hold is cancelled and the '
          'scroll returns to idle. If they drag, a new '
          'DragScrollActivity takes over.',
      'accent': Colors.pink[600]!,
    },
    {
      'icon': Icons.memory,
      'title': 'ScrollActivity Subclass',
      'body': 'HoldScrollActivity extends ScrollActivity and '
          'implements ScrollHoldController. It\'s part of the '
          'scroll activity system that manages how a ScrollPosition '
          'changes over time — idle, drag, ballistic, or hold. '
          'Each activity represents a distinct phase of user '
          'interaction with a scrollable widget.',
      'accent': Colors.red[600]!,
    },
    {
      'icon': Icons.stacked_line_chart,
      'title': 'How It\'s Created',
      'body': 'When ScrollPositionWithSingleContext detects a '
          'pointer-down during a ballistic animation, it calls '
          'hold(). This method creates a HoldScrollActivity, calls '
          'beginActivity() to swap from BallisticScrollActivity, '
          'and returns a ScrollHoldController to the gesture system '
          'so it can cancel or convert the hold to a drag.',
      'accent': Colors.pink[700]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: Scroll Activity Types
  // ============================================================
  print('=== Section 2: Activity Types ===');

  final activityTypes = <Map<String, dynamic>>[
    {
      'name': 'IdleScrollActivity',
      'icon': Icons.pause_circle_outline,
      'color': Colors.grey[500]!,
      'isSubject': false,
      'description': 'The scroll position is at rest. No animation, '
          'no user gesture. This is the default state when nothing '
          'is happening with the scrollable.',
    },
    {
      'name': 'DragScrollActivity',
      'icon': Icons.swipe,
      'color': Colors.blue[600]!,
      'isSubject': false,
      'description': 'The user is actively dragging their finger. '
          'ScrollPosition updates frame-by-frame based on the '
          'drag delta. Pixels moved = pointer delta * physics factor.',
    },
    {
      'name': 'BallisticScrollActivity',
      'icon': Icons.speed,
      'color': Colors.orange[600]!,
      'isSubject': false,
      'description': 'The user has released their finger with velocity. '
          'A simulation (ClampingScrollSimulation or '
          'BouncingScrollSimulation) drives the position with '
          'deceleration until it stops.',
    },
    {
      'name': 'HoldScrollActivity',
      'icon': Icons.pan_tool,
      'color': Colors.red[700]!,
      'isSubject': true,
      'description': 'The user placed their finger on a scrollable '
          'that was flinging. The ballistic animation is cancelled. '
          'The position is "held" at the current offset until the '
          'user lifts or starts dragging.',
    },
    {
      'name': 'DrivenScrollActivity',
      'icon': Icons.code,
      'color': Colors.purple[600]!,
      'isSubject': false,
      'description': 'A programmatic animation drives the scroll '
          'position. Created by ScrollPosition.animateTo(). Uses '
          'an AnimationController with the specified duration and '
          'curve. The user cannot interrupt it by default.',
    },
  ];

  print('  Prepared ${activityTypes.length} activity types');

  // ============================================================
  // SECTION 3: State Machine
  // ============================================================
  print('=== Section 3: State Machine ===');

  final transitions = <Map<String, dynamic>>[
    {
      'from': 'Idle',
      'fromColor': Colors.grey[500]!,
      'to': 'Drag',
      'toColor': Colors.blue[600]!,
      'trigger': 'User starts dragging',
      'icon': Icons.touch_app,
    },
    {
      'from': 'Drag',
      'fromColor': Colors.blue[600]!,
      'to': 'Ballistic',
      'toColor': Colors.orange[600]!,
      'trigger': 'User releases with velocity',
      'icon': Icons.swipe_up,
    },
    {
      'from': 'Drag',
      'fromColor': Colors.blue[600]!,
      'to': 'Idle',
      'toColor': Colors.grey[500]!,
      'trigger': 'User releases without velocity',
      'icon': Icons.stop_circle,
    },
    {
      'from': 'Ballistic',
      'fromColor': Colors.orange[600]!,
      'to': 'Hold',
      'toColor': Colors.red[700]!,
      'trigger': 'User touches during fling',
      'icon': Icons.pan_tool,
    },
    {
      'from': 'Ballistic',
      'fromColor': Colors.orange[600]!,
      'to': 'Idle',
      'toColor': Colors.grey[500]!,
      'trigger': 'Simulation completes (velocity → 0)',
      'icon': Icons.stop,
    },
    {
      'from': 'Hold',
      'fromColor': Colors.red[700]!,
      'to': 'Drag',
      'toColor': Colors.blue[600]!,
      'trigger': 'User starts dragging from hold',
      'icon': Icons.swipe,
    },
    {
      'from': 'Hold',
      'fromColor': Colors.red[700]!,
      'to': 'Idle',
      'toColor': Colors.grey[500]!,
      'trigger': 'User lifts finger (hold cancelled)',
      'icon': Icons.touch_app,
    },
    {
      'from': 'Idle',
      'fromColor': Colors.grey[500]!,
      'to': 'Driven',
      'toColor': Colors.purple[600]!,
      'trigger': 'animateTo() called programmatically',
      'icon': Icons.code,
    },
    {
      'from': 'Driven',
      'fromColor': Colors.purple[600]!,
      'to': 'Idle',
      'toColor': Colors.grey[500]!,
      'trigger': 'Animation completes',
      'icon': Icons.check_circle,
    },
  ];

  print('  Prepared ${transitions.length} transitions');

  // ============================================================
  // SECTION 4: HoldScrollActivity API
  // ============================================================
  print('=== Section 4: API ===');

  final apiMembers = <Map<String, dynamic>>[
    {
      'name': 'HoldScrollActivity({required delegate, onHoldCanceled})',
      'kind': 'constructor',
      'icon': Icons.build,
      'color': Colors.red[700]!,
      'description': 'Creates a hold activity. The delegate is the '
          'ScrollActivityDelegate (typically ScrollPosition). '
          'onHoldCanceled is a VoidCallback invoked when the hold '
          'ends — either by starting a drag or by lifting the finger.',
    },
    {
      'name': 'cancel()',
      'kind': 'method',
      'icon': Icons.cancel,
      'color': Colors.pink[600]!,
      'description': 'Cancels the hold. Called when the user starts '
          'a new drag gesture. Invokes the onHoldCanceled callback '
          'passed to the constructor. After this, a new '
          'DragScrollActivity takes over.',
    },
    {
      'name': 'dispose()',
      'kind': 'method',
      'icon': Icons.delete,
      'color': Colors.red[600]!,
      'description': 'Cleans up the activity. Calls onHoldCanceled '
          'if it hasn\'t been called yet (i.e., if dispose is called '
          'without cancel). This ensures the callback always fires.',
    },
    {
      'name': 'shouldIgnorePointer',
      'kind': 'property',
      'icon': Icons.visibility_off,
      'color': Colors.pink[500]!,
      'description': 'Returns false — during a hold, the scrollable '
          'should NOT ignore pointer events. The user\'s finger is '
          'on the screen and future gestures (drag, lift) need to '
          'be recognized.',
    },
    {
      'name': 'isScrolling',
      'kind': 'property',
      'icon': Icons.speed,
      'color': Colors.red[500]!,
      'description': 'Returns false — the scroll is held still, not '
          'actively moving. This distinguishes hold from ballistic '
          'and drag (which return true).',
    },
    {
      'name': 'velocity',
      'kind': 'property',
      'icon': Icons.speed,
      'color': Colors.pink[700]!,
      'description': 'Returns 0.0 — the held position has zero '
          'velocity. Contrast with BallisticScrollActivity which '
          'reports the current simulation velocity.',
    },
  ];

  print('  Prepared ${apiMembers.length} API members');

  // ============================================================
  // SECTION 5: ScrollHoldController Interface
  // ============================================================
  print('=== Section 5: ScrollHoldController ===');

  final holdController = <Map<String, dynamic>>[
    {
      'name': 'cancel()',
      'icon': Icons.cancel,
      'color': Colors.red[700]!,
      'description': 'Signals the hold to cancel. The user started '
          'a drag gesture and the hold is no longer needed. The '
          'gesture recognizer calls this when transitioning from '
          'hold to drag.',
    },
    {
      'name': 'Purpose',
      'icon': Icons.architecture,
      'color': Colors.pink[600]!,
      'description': 'ScrollHoldController is the interface that '
          'the gesture system uses to communicate with the hold '
          'activity. When ScrollPosition.hold() returns, it returns '
          'a ScrollHoldController. The Scrollable\'s gesture layer '
          'stores this reference and calls cancel() when ready.',
    },
    {
      'name': 'Lifecycle',
      'icon': Icons.loop,
      'color': Colors.red[600]!,
      'description': '1. User touches → Scrollable calls '
          'position.hold() → returns ScrollHoldController. '
          '2. If user drags → gesture system calls controller.cancel(). '
          '3. If user lifts without dragging → hold activity is '
          'disposed, transitioning to idle.',
    },
  ];

  print('  Prepared ${holdController.length} controller items');

  // ============================================================
  // SECTION 6: Physics Integration
  // ============================================================
  print('=== Section 6: Physics Integration ===');

  final physicsDetails = <Map<String, dynamic>>[
    {
      'title': 'Clamping vs Bouncing',
      'icon': Icons.compare_arrows,
      'color': Colors.red[700]!,
      'bgColor': Colors.red[50]!,
      'body': 'ClampingScrollPhysics (Android-style) and '
          'BouncingScrollPhysics (iOS-style) both support hold. '
          'On Android, touching a flinging list immediately stops '
          'it. On iOS, touching stops the fling but may allow a '
          'short deceleration if the finger stays still.',
    },
    {
      'title': 'How Physics Creates the Simulation',
      'icon': Icons.science,
      'color': Colors.pink[600]!,
      'bgColor': Colors.pink[50]!,
      'body': 'When a drag ends with velocity, ScrollPosition calls '
          'physics.createBallisticSimulation(). This returns a '
          'Simulation that drives BallisticScrollActivity. When '
          'the user then touches, HoldScrollActivity replaces it. '
          'The physics are NOT involved in the hold itself — hold '
          'has no simulation.',
    },
    {
      'title': 'Overscroll and Hold',
      'icon': Icons.warning_amber,
      'color': Colors.red[600]!,
      'bgColor': Colors.red[50]!,
      'body': 'If a ballistic fling overshoots (iOS bounce), '
          'touching during the bounce-back creates a hold at the '
          'overscrolled position. The physics will NOT snap it back '
          'during the hold. Only when the hold ends and a new '
          'ballistic activity starts will the bounce-back resume.',
    },
    {
      'title': 'Custom ScrollPhysics',
      'icon': Icons.tune,
      'color': Colors.pink[700]!,
      'bgColor': Colors.pink[50]!,
      'body': 'If you implement custom ScrollPhysics, the hold '
          'mechanism works unchanged — it\'s handled by '
          'ScrollPosition, not by ScrollPhysics. Your custom '
          'physics only affect how the fling simulation behaves '
          'before and after the hold.',
    },
  ];

  print('  Prepared ${physicsDetails.length} physics details');

  // ============================================================
  // SECTION 7: Comparison Table
  // ============================================================
  print('=== Section 7: Activity Comparison ===');

  final actComparison = <Map<String, String>>[
    {
      'aspect': 'isScrolling',
      'idle': 'false',
      'drag': 'true',
      'ballistic': 'true',
      'hold': 'false',
    },
    {
      'aspect': 'velocity',
      'idle': '0.0',
      'drag': 'varies',
      'ballistic': 'varies',
      'hold': '0.0',
    },
    {
      'aspect': 'shouldIgnorePointer',
      'idle': 'false',
      'drag': 'true',
      'ballistic': 'true',
      'hold': 'false',
    },
    {
      'aspect': 'User input',
      'idle': 'None',
      'drag': 'Finger dragging',
      'ballistic': 'None (auto)',
      'hold': 'Finger down (still)',
    },
    {
      'aspect': 'Duration',
      'idle': 'Indefinite',
      'drag': 'While touching',
      'ballistic': 'Until vel=0',
      'hold': 'Until lift/drag',
    },
    {
      'aspect': 'Created by',
      'idle': 'goIdle()',
      'drag': 'drag()',
      'ballistic': 'goBallistic()',
      'hold': 'hold()',
    },
  ];

  print('  Prepared ${actComparison.length} comparison rows');

  // ============================================================
  // SECTION 8: Real-World Implications
  // ============================================================
  print('=== Section 8: Real-World Use ===');

  final realWorld = <Map<String, dynamic>>[
    {
      'name': 'Stopping a Fast Fling',
      'icon': Icons.pan_tool,
      'color': Colors.red[700]!,
      'description': 'When a user flings a long list and then taps '
          'to stop, the hold activity is what makes it stop instantly. '
          'Without it, the fling would continue under the finger. '
          'This behavior is familiar to all mobile users and happens '
          'automatically with standard scrollables.',
    },
    {
      'name': 'Scroll-to-Stop-to-Drag Pattern',
      'icon': Icons.touch_app,
      'color': Colors.pink[600]!,
      'description': 'Users often: (1) fling to scroll quickly, '
          '(2) tap to stop at interesting content, (3) start a new '
          'slow drag to fine-tune position. The hold activity bridges '
          'steps 2 and 3. Without it, the transition from ballistic '
          'to drag would be jarring.',
    },
    {
      'name': 'Custom ScrollPosition',
      'icon': Icons.code,
      'color': Colors.red[600]!,
      'description': 'If you implement a custom ScrollPosition and '
          'override hold(), you can customize what happens when the '
          'user touches during a fling. You might add haptic '
          'feedback, trigger an animation, or log analytics. The '
          'default hold() creates HoldScrollActivity and returns '
          'it as the ScrollHoldController.',
    },
    {
      'name': 'Refreshing During Scroll',
      'icon': Icons.refresh,
      'color': Colors.pink[700]!,
      'description': 'Some apps let users tap-to-stop a scroll and '
          'then pull to refresh. The hold activity is the state '
          'between the fling stopping and the pull gesture starting. '
          'Without correct hold handling, RefreshIndicator might '
          'not activate properly.',
    },
  ];

  print('  Prepared ${realWorld.length} real-world items');

  // ============================================================
  // SECTION 9: Tips & Gotchas
  // ============================================================
  print('=== Section 9: Tips & Gotchas ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Hold Is Usually Transparent',
      'body': 'Most developers never interact with HoldScrollActivity '
          'directly. It\'s managed internally by ScrollPosition '
          'and Scrollable. You only need to know about it when '
          'implementing custom scroll physics or custom '
          'ScrollPosition subclasses.',
      'severity': 'info',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'onHoldCanceled Fires Once',
      'body': 'The onHoldCanceled callback fires exactly once — '
          'either via cancel() (user started dragging) or via '
          'dispose() (hold activity replaced). It will NOT fire '
          'twice. If you depend on this callback, know that it\'s '
          'guaranteed to fire but only once.',
      'severity': 'warning',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'isScrolling=false During Hold',
      'body': 'Notification listeners checking if scrolling is '
          'happening will see isScrolling=false during a hold. '
          'This is correct — the user has stopped the scroll. '
          'If you\'re building a "scroll to hide" toolbar, it '
          'should remain visible during hold.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Don\'t Create HoldScrollActivity Manually',
      'body': 'HoldScrollActivity is designed to be created by '
          'ScrollPosition.hold(). Don\'t instantiate it yourself '
          'unless you\'re building a fully custom scroll system. '
          'The constructor requires a proper ScrollActivityDelegate.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Hold Duration Is Typically Very Short',
      'body': 'In practice, HoldScrollActivity lasts milliseconds '
          'to a few hundred ms. The user either starts dragging '
          '(replacing hold with drag) or lifts their finger '
          '(replacing hold with idle). It\'s a transient state, '
          'not a long-lived one.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Debugging Scroll Activities',
      'body': 'To see activity transitions, listen to '
          'ScrollPosition\'s notifyListeners and check '
          'position.activity.runtimeType. Or use '
          'debugPrintScrollNotifications to log all scroll '
          'notifications including UserScrollNotification which '
          'reports direction changes.',
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
      title: Text('HoldScrollActivity'),
      backgroundColor: Colors.red[700],
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
                colors: [Colors.red[700]!, Colors.pink[600]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: [
                  Icon(Icons.pan_tool, color: Colors.white, size: 36),
                  SizedBox(width: 12),
                  Icon(Icons.speed, color: Colors.white70, size: 24),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward,
                      color: Colors.white54, size: 16),
                  SizedBox(width: 4),
                  Icon(Icons.stop_circle,
                      color: Colors.white70, size: 24),
                ]),
                SizedBox(height: 14),
                Text(
                  'HoldScrollActivity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'The scroll activity that fires when a user '
                  'touches the screen to stop a ballistic fling — '
                  'the transitional state between momentum scrolling '
                  'and the next user gesture.',
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
          _scrollHead('1', 'What is HoldScrollActivity?'),
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

          // ── Section 2: Activity Types ──
          _scrollHead('2', 'Scroll Activity Types'),
          SizedBox(height: 12),
          ...activityTypes.map((at) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: at['isSubject'] == true
                        ? Colors.red[50]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: at['color'] as Color, width: 4),
                    ),
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
                        Icon(at['icon'] as IconData,
                            color: at['color'] as Color, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(at['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  fontFamily: 'monospace',
                                  color: at['color'] as Color)),
                        ),
                        if (at['isSubject'] == true)
                          _actBadge('THIS DEMO', Colors.red[700]!),
                      ]),
                      SizedBox(height: 4),
                      Text(at['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 3: State Machine ──
          _scrollHead('3', 'Activity State Transitions'),
          SizedBox(height: 12),
          ...transitions.map((tr) => Padding(
                padding: EdgeInsets.only(bottom: 6),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: (tr['to'] == 'Hold' || tr['from'] == 'Hold')
                        ? Colors.red[50]
                        : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 2,
                          offset: Offset(0, 1))
                    ],
                  ),
                  child: Row(
                    children: [
                      _actBadge(
                          tr['from'] as String, tr['fromColor'] as Color),
                      SizedBox(width: 6),
                      Icon(Icons.arrow_forward,
                          size: 14, color: Colors.grey[400]),
                      SizedBox(width: 6),
                      _actBadge(
                          tr['to'] as String, tr['toColor'] as Color),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(tr['trigger'] as String,
                            style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey[700])),
                      ),
                      Icon(tr['icon'] as IconData,
                          size: 14, color: Colors.grey[500]),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 4: API ──
          _scrollHead('4', 'HoldScrollActivity API'),
          SizedBox(height: 12),
          ...apiMembers.map((api) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                      left: BorderSide(
                          color: api['color'] as Color, width: 4),
                    ),
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
                        Icon(api['icon'] as IconData,
                            color: api['color'] as Color, size: 16),
                        SizedBox(width: 6),
                        Expanded(
                          child: Text(api['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'monospace',
                                  fontSize: 11,
                                  color: api['color'] as Color)),
                        ),
                        _actBadge(
                            api['kind'] as String, Colors.grey[500]!),
                      ]),
                      SizedBox(height: 4),
                      Text(api['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: ScrollHoldController ──
          _scrollHead('5', 'ScrollHoldController Interface'),
          SizedBox(height: 12),
          ...holdController.map((hc) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color: (hc['color'] as Color).withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(hc['icon'] as IconData,
                            color: hc['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(hc['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: hc['color'] as Color)),
                        ),
                      ]),
                      SizedBox(height: 6),
                      Text(hc['description'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Physics Integration ──
          _scrollHead('6', 'Physics Integration'),
          SizedBox(height: 12),
          ...physicsDetails.map((pd) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: pd['bgColor'] as Color,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        color:
                            (pd['color'] as Color).withOpacity(0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        Icon(pd['icon'] as IconData,
                            color: pd['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(pd['title'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: pd['color'] as Color)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(pd['body'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Comparison Table ──
          _scrollHead('7', 'Activity Comparison Table'),
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
                padding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                decoration: BoxDecoration(
                  color: Colors.red[700],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Row(children: [
                  Expanded(
                      flex: 3,
                      child: Text('Aspect',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 2,
                      child: Text('Idle',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 2,
                      child: Text('Drag',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 2,
                      child: Text('Ballistic',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                  Expanded(
                      flex: 2,
                      child: Text('Hold',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 10))),
                ]),
              ),
              ...actComparison.asMap().entries.map((entry) {
                final idx = entry.key;
                final row = entry.value;
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 6, horizontal: 8),
                  color: idx.isEven ? Colors.grey[50] : Colors.white,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          flex: 3,
                          child: Text(row['aspect']!,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10))),
                      Expanded(
                          flex: 2,
                          child: Text(row['idle']!,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[700]))),
                      Expanded(
                          flex: 2,
                          child: Text(row['drag']!,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[700]))),
                      Expanded(
                          flex: 2,
                          child: Text(row['ballistic']!,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey[700]))),
                      Expanded(
                          flex: 2,
                          child: Text(row['hold']!,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.red[800],
                                  fontWeight: FontWeight.bold))),
                    ],
                  ),
                );
              }),
            ]),
          ),

          SizedBox(height: 24),

          // ── Section 8: Real-World ──
          _scrollHead('8', 'Real-World Implications'),
          SizedBox(height: 12),
          ...realWorld.map((rw) => Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: rw['color'] as Color, width: 4),
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
                        Icon(rw['icon'] as IconData,
                            color: rw['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(rw['name'] as String,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13)),
                        ),
                      ]),
                      SizedBox(height: 8),
                      Text(rw['description'] as String,
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
          _scrollHead('9', 'Tips, Pitfalls & Gotchas'),
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
              'End of HoldScrollActivity Deep Demo',
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
Widget _scrollHead(String number, String title) {
  return Row(
    children: [
      Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: Colors.red[700],
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
// Helper: Small badge chip for activity names/kinds
// ──────────────────────────────────────────────────────────
Widget _actBadge(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(text,
        style: TextStyle(
            color: Colors.white,
            fontSize: 9,
            fontWeight: FontWeight.bold)),
  );
}
