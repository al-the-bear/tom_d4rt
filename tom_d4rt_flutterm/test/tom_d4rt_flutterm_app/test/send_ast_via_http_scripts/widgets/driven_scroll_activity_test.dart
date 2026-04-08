// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, prefer_const_constructors
// D4rt test script: Deep Demo — DrivenScrollActivity
// Demonstrates DrivenScrollActivity — a ScrollActivity that drives
// the scroll position to a target offset using an AnimationController
// (Simulation-based tween).  Created by ScrollPosition.animateTo()
// and moveTo().  It is the mechanism behind smooth programmatic
// scrolling in Flutter.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DrivenScrollActivity Deep Demo executing');

  // ============================================================
  // SECTION 1: What is DrivenScrollActivity?
  // ============================================================
  print('=== Section 1: Concept ===');

  final conceptCards = <Map<String, dynamic>>[
    {
      'icon': Icons.animation,
      'title': 'Programmatic Scroll Animation',
      'body': 'DrivenScrollActivity is a ScrollActivity that animates '
          'the scroll position from its current offset to a target '
          'offset. It\'s created when you call scrollController.'
          'animateTo(offset, duration, curve). The animation is '
          'powered by an AnimationController under the hood.',
      'accent': Colors.cyan[700]!,
    },
    {
      'icon': Icons.compare_arrows,
      'title': 'Activity-Based Scroll System',
      'body': 'Flutter\'s scroll system uses an activity model — '
          'each ScrollPosition has exactly one active ScrollActivity '
          'at a time. Activities include: IdleScrollActivity (at rest), '
          'DragScrollActivity (user dragging), BallisticScrollActivity '
          '(fling), and DrivenScrollActivity (programmatic animation).',
      'accent': Colors.teal[600]!,
    },
    {
      'icon': Icons.linear_scale,
      'title': 'Tween + Curve Animation',
      'body': 'DrivenScrollActivity uses an AnimationController that '
          'tweens from the starting offset to the target offset, '
          'applying the specified Curve for easing. Each tick of '
          'the animation sets the scroll position via the delegate '
          '(ScrollPosition), which triggers a rebuild of the '
          'scrollable viewport.',
      'accent': Colors.cyan[600]!,
    },
    {
      'icon': Icons.stop_circle_outlined,
      'title': 'Interruptible by User Input',
      'body': 'If the user touches the scrollable while a '
          'DrivenScrollActivity is running, the activity is '
          'cancelled and replaced with a DragScrollActivity. '
          'This ensures user input always takes priority over '
          'programmatic scrolling. The cancellation is immediate.',
      'accent': Colors.teal[500]!,
    },
  ];

  print('  Prepared ${conceptCards.length} concept cards');

  // ============================================================
  // SECTION 2: ScrollActivity Hierarchy
  // ============================================================
  print('=== Section 2: Hierarchy ===');

  final hierarchy = <Map<String, dynamic>>[
    {
      'name': 'ScrollActivity',
      'depth': 0,
      'color': Colors.grey[600]!,
      'note': 'Abstract base: delegate, dispose, velocity, isScrolling',
    },
    {
      'name': 'IdleScrollActivity',
      'depth': 1,
      'color': Colors.grey[500]!,
      'note': 'No scrolling: isScrolling=false, velocity=0',
    },
    {
      'name': 'DragScrollActivity',
      'depth': 1,
      'color': Colors.blue[400]!,
      'note': 'User-driven drag: tracks pointer movement',
    },
    {
      'name': 'BallisticScrollActivity',
      'depth': 1,
      'color': Colors.orange[400]!,
      'note': 'Physics simulation: fling, overscroll bounce-back',
    },
    {
      'name': 'DrivenScrollActivity',
      'depth': 1,
      'color': Colors.cyan[700]!,
      'note': 'Programmatic: animateTo() with duration and curve',
    },
    {
      'name': 'HoldScrollActivity',
      'depth': 1,
      'color': Colors.grey[400]!,
      'note': 'Hold: user pressing but not yet dragging',
    },
  ];

  print('  Prepared ${hierarchy.length} hierarchy items');

  // ============================================================
  // SECTION 3: How It Is Created
  // ============================================================
  print('=== Section 3: Creation ===');

  final creationSteps = <Map<String, dynamic>>[
    {
      'step': 1,
      'title': 'You call scrollController.animateTo()',
      'color': Colors.cyan[700]!,
      'detail': 'Your code calls scrollController.animateTo(offset, '
          'duration: Duration(...), curve: Curves.easeOut). This '
          'method is defined on ScrollController and delegates to '
          'ScrollPosition.animateTo().',
    },
    {
      'step': 2,
      'title': 'ScrollPosition creates DrivenScrollActivity',
      'color': Colors.teal[600]!,
      'detail': 'ScrollPosition.animateTo() creates a new '
          'DrivenScrollActivity with: delegate = this (the '
          'ScrollPosition), from = current pixels, to = target '
          'offset, duration, curve, and vsync (the TickerProvider).',
    },
    {
      'step': 3,
      'title': 'AnimationController initialized',
      'color': Colors.cyan[600]!,
      'detail': 'Inside DrivenScrollActivity\'s constructor, an '
          'AnimationController is created and configured with the '
          'duration. A Tween(begin: from, end: to) is applied '
          'with the curve. The animation starts immediately.',
    },
    {
      'step': 4,
      'title': 'Each tick updates scroll position',
      'color': Colors.teal[500]!,
      'detail': 'The AnimationController ticks via the vsync ticker. '
          'On each tick, the animated value (current offset) is '
          'computed and passed to delegate.setPixels(). This is '
          'the ScrollPosition, which updates the viewport.',
    },
    {
      'step': 5,
      'title': 'Animation completes or is cancelled',
      'color': Colors.cyan[500]!,
      'detail': 'When the animation reaches the target, the '
          'DrivenScrollActivity calls delegate.goBallistic(0.0) '
          'which replaces it with an IdleScrollActivity (velocity='
          '0). If interrupted by user drag, it\'s cancelled and '
          'replaced with a DragScrollActivity.',
    },
  ];

  print('  Prepared ${creationSteps.length} creation steps');

  // ============================================================
  // SECTION 4: animateTo() vs moveTo()
  // ============================================================
  print('=== Section 4: animateTo vs moveTo ===');

  final comparison = <Map<String, dynamic>>[
    {
      'method': 'animateTo()',
      'color': Colors.cyan[700]!,
      'icon': Icons.slow_motion_video,
      'sig': 'Future<void> animateTo(\n'
          '  double to, {\n'
          '  required Duration duration,\n'
          '  required Curve curve,\n'
          '})',
      'desc': 'Creates a DrivenScrollActivity with the specified '
          'duration and curve. The returned Future completes when '
          'the animation finishes (or when it\'s cancelled by '
          'user interaction). You specify exactly how long the '
          'animation takes.',
    },
    {
      'method': 'moveTo()',
      'color': Colors.teal[600]!,
      'icon': Icons.fast_forward,
      'sig': 'void moveTo(\n'
          '  double to, {\n'
          '  Duration? duration,\n'
          '  Curve? curve,\n'
          '  bool? clamp,\n'
          '})',
      'desc': 'If duration is null, jumps instantly (setPixels). '
          'If duration is provided, creates a DrivenScrollActivity '
          'like animateTo() but does NOT return a Future. The '
          'clamp parameter controls whether the target is clamped '
          'to scroll extent bounds.',
    },
    {
      'method': 'jumpTo()',
      'color': Colors.grey[500]!,
      'icon': Icons.skip_next,
      'sig': 'void jumpTo(double value)',
      'desc': 'Instantly sets the scroll offset — no animation, '
          'no DrivenScrollActivity. Sets IdleScrollActivity after '
          'the jump. Use when you want instant repositioning.',
    },
  ];

  print('  Prepared ${comparison.length} methods');

  // ============================================================
  // SECTION 5: Internal Architecture
  // ============================================================
  print('=== Section 5: Internals ===');

  final internals = <Map<String, dynamic>>[
    {
      'title': 'Constructor & Animation Setup',
      'color': Colors.cyan[700]!,
      'code': '// DrivenScrollActivity({\n'
          '//   required ScrollActivityDelegate delegate,\n'
          '//   required double from,\n'
          '//   required double to,\n'
          '//   required Duration duration,\n'
          '//   required Curve curve,\n'
          '//   required TickerProvider vsync,\n'
          '// })\n'
          '//\n'
          '// Creates AnimationController(duration, vsync)\n'
          '// Applies Tween(begin: from, end: to)\n'
          '// Applies CurveTween(curve: curve)\n'
          '// Adds listener → delegate.setPixels(value)\n'
          '// Adds status listener → done → goBallistic(0)\n'
          '// Starts the animation: controller.forward()',
    },
    {
      'title': 'velocity Property',
      'color': Colors.teal[600]!,
      'code': '// @override\n'
          '// double get velocity {\n'
          '//   return _controller.velocity;\n'
          '// }\n'
          '//\n'
          '// Returns the AnimationController\'s velocity.\n'
          '// During the animation this is non-zero.\n'
          '// Used by overscroll indicators and\n'
          '// viewport behavior decisions.',
    },
    {
      'title': 'dispose() Cleanup',
      'color': Colors.cyan[600]!,
      'code': '// @override\n'
          '// void dispose() {\n'
          '//   _completer.complete();\n'
          '//   _controller.dispose();\n'
          '//   super.dispose();\n'
          '// }\n'
          '//\n'
          '// Completes the Future from animateTo(),\n'
          '// disposes the AnimationController,\n'
          '// calls super.dispose() for base cleanup.',
    },
    {
      'title': 'The Completer Pattern',
      'color': Colors.teal[500]!,
      'code': '// DrivenScrollActivity holds a Completer<void>.\n'
          '// animateTo() returns completer.future.\n'
          '//\n'
          '// The Completer resolves when:\n'
          '//  1) Animation completes naturally\n'
          '//  2) Activity is cancelled (user drag)\n'
          '//  3) dispose() is called\n'
          '//\n'
          '// This lets you await scroll animations:\n'
          '//   await controller.animateTo(500);\n'
          '//   print(\'scroll complete\');',
    },
  ];

  print('  Prepared ${internals.length} internals');

  // ============================================================
  // SECTION 6: Interaction With Other Activities
  // ============================================================
  print('=== Section 6: Interactions ===');

  final interactions = <Map<String, dynamic>>[
    {
      'from': 'DrivenScrollActivity',
      'to': 'DragScrollActivity',
      'trigger': 'User touches the scrollable',
      'color': Colors.blue[500]!,
      'detail': 'Pointer-down on the scrollable cancels the driven '
          'animation immediately. The DrivenScrollActivity is '
          'disposed and replaced with a HoldScrollActivity, which '
          'transitions to DragScrollActivity if the user moves.',
    },
    {
      'from': 'DrivenScrollActivity',
      'to': 'IdleScrollActivity',
      'trigger': 'Animation completes',
      'color': Colors.green[500]!,
      'detail': 'When the AnimationController status = completed, '
          'goBallistic(0.0) is called. With zero velocity, the '
          'physics simulation immediately settles to idle. The '
          'DrivenScrollActivity is replaced with IdleScrollActivity.',
    },
    {
      'from': 'DrivenScrollActivity',
      'to': 'BallisticScrollActivity',
      'trigger': 'Target out of bounds',
      'color': Colors.orange[500]!,
      'detail': 'If the driven target exceeds maxScrollExtent, the '
          'animation hits the edge. On completion, goBallistic '
          'may create a BallisticScrollActivity to bounce back '
          'under overscroll physics (e.g., BouncingScrollPhysics).',
    },
    {
      'from': 'DrivenScrollActivity',
      'to': 'DrivenScrollActivity',
      'trigger': 'Another animateTo() call',
      'color': Colors.cyan[600]!,
      'detail': 'If animateTo() is called while a DrivenScrollActivity '
          'is running, the current one is disposed and a new '
          'DrivenScrollActivity takes over. The first animation\'s '
          'Future completes immediately (cancelled).',
    },
  ];

  print('  Prepared ${interactions.length} interactions');

  // ============================================================
  // SECTION 7: Code Patterns
  // ============================================================
  print('=== Section 7: Patterns ===');

  final codePatterns = <Map<String, dynamic>>[
    {
      'title': 'Basic animateTo',
      'color': Colors.cyan[700]!,
      'code': '// final controller = ScrollController();\n'
          '//\n'
          '// // Smooth scroll to offset 500:\n'
          '// await controller.animateTo(\n'
          '//   500.0,\n'
          '//   duration: Duration(milliseconds: 300),\n'
          '//   curve: Curves.easeOut,\n'
          '// );\n'
          '// // Completes when animation finishes or\n'
          '// // is cancelled by user interaction.',
    },
    {
      'title': 'Scroll to Top',
      'color': Colors.teal[600]!,
      'code': '// // Scroll to the very top:\n'
          '// await controller.animateTo(\n'
          '//   0.0,\n'
          '//   duration: Duration(milliseconds: 500),\n'
          '//   curve: Curves.easeInOut,\n'
          '// );',
    },
    {
      'title': 'Scroll to Bottom',
      'color': Colors.cyan[600]!,
      'code': '// // Scroll to the very bottom:\n'
          '// await controller.animateTo(\n'
          '//   controller.position.maxScrollExtent,\n'
          '//   duration: Duration(milliseconds: 500),\n'
          '//   curve: Curves.easeInOut,\n'
          '// );',
    },
    {
      'title': 'Chained Scroll Animations',
      'color': Colors.teal[500]!,
      'code': '// // Sequential scroll stops:\n'
          '// await controller.animateTo(200,\n'
          '//   duration: Duration(ms: 200),\n'
          '//   curve: Curves.easeOut);\n'
          '// await Future.delayed(Duration(ms: 100));\n'
          '// await controller.animateTo(500,\n'
          '//   duration: Duration(ms: 300),\n'
          '//   curve: Curves.easeIn);',
    },
    {
      'title': 'Page-by-Page Scroll',
      'color': Colors.cyan[500]!,
      'code': '// // Scroll exactly one viewport height:\n'
          '// final viewportH =\n'
          '//   controller.position.viewportDimension;\n'
          '// final current = controller.offset;\n'
          '// final target = (current + viewportH)\n'
          '//   .clamp(0.0,\n'
          '//     controller.position.maxScrollExtent);\n'
          '// await controller.animateTo(target,\n'
          '//   duration: Duration(ms: 300),\n'
          '//   curve: Curves.easeOut);',
    },
  ];

  print('  Prepared ${codePatterns.length} patterns');

  // ============================================================
  // SECTION 8: Common Mistakes
  // ============================================================
  print('=== Section 8: Common Mistakes ===');

  final mistakes = <Map<String, dynamic>>[
    {
      'title': 'Using animateTo Without Mounting',
      'severity': 'error',
      'color': Colors.red[600]!,
      'icon': Icons.error,
      'body': 'Calling scrollController.animateTo() before the '
          'ScrollController is attached to a Scrollable (e.g., in '
          'initState before build) throws "ScrollController not '
          'attached to any scroll views". Use addPostFrameCallback '
          'or wait until after the first build.',
    },
    {
      'title': 'Ignoring the Returned Future',
      'severity': 'tip',
      'color': Colors.blue[500]!,
      'icon': Icons.info,
      'body': 'animateTo() returns a Future<void> that completes '
          'when the animation finishes. If you need to run code '
          'after scrolling completes, await the future. Don\'t '
          'assume it\'s instant.',
    },
    {
      'title': 'Conflicting Simultaneous Animations',
      'severity': 'warning',
      'color': Colors.amber[600]!,
      'icon': Icons.warning,
      'body': 'Calling animateTo() while a previous animateTo() is '
          'still running cancels the first. If you fire multiple '
          'animateTo calls rapidly (e.g., in a listener), you get '
          'jerky motion. Debounce or cancel explicitly.',
    },
    {
      'title': 'Target Beyond maxScrollExtent',
      'severity': 'warning',
      'color': Colors.orange[500]!,
      'icon': Icons.warning,
      'body': 'If the target offset exceeds maxScrollExtent, the '
          'animation will overshoot. With ClampingScrollPhysics, '
          'it clamps at the edge. With BouncingScrollPhysics, it '
          'bounces back. This can look unintended if your content '
          'hasn\'t been laid out yet when you call animateTo().',
    },
    {
      'title': 'Not Disposing ScrollController',
      'severity': 'error',
      'color': Colors.red[500]!,
      'icon': Icons.error,
      'body': 'If the widget that owns the ScrollController is '
          'disposed while a DrivenScrollActivity is running, the '
          'animation may call methods on a disposed object. Always '
          'dispose the ScrollController in the State.dispose() '
          'method to clean up properly.',
    },
  ];

  print('  Prepared ${mistakes.length} mistakes');

  // ============================================================
  // SECTION 9: Tips
  // ============================================================
  print('=== Section 9: Tips ===');

  final tips = <Map<String, dynamic>>[
    {
      'icon': Icons.lightbulb_outline,
      'title': 'User Input Always Wins',
      'body': 'A DrivenScrollActivity is always interruptible by user '
          'touch. This is by design: user gestures should never be '
          'blocked by programmatic animations. The Future from '
          'animateTo() completes immediately on interruption.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Choose the Right Curve',
      'body': 'Curves.easeOut feels natural for "scroll to item" UX. '
          'Curves.linear is good for following a progress indicator. '
          'Curves.easeInOut works well for page transitions. The '
          'Curve directly controls how the DrivenScrollActivity '
          'interpolates between start and end offsets.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'Avoid Very Long Durations',
      'body': 'A long DrivenScrollActivity (e.g., 5 seconds) keeps '
          'the scroll "busy" and can feel unresponsive. Keep '
          'programmatic scroll durations under 1 second for most '
          'use cases. For very long scrolls, consider jumpTo() '
          'plus a short animateTo() for the final approach.',
      'severity': 'warning',
    },
    {
      'icon': Icons.lightbulb_outline,
      'title': 'Await for Sequential Logic',
      'body': 'Use "await controller.animateTo()" when you need to '
          'perform an action after scrolling completes (e.g., '
          'focusing a text field, showing a snackbar). The Future '
          'resolves whether the animation completes normally or '
          'is cancelled.',
      'severity': 'info',
    },
    {
      'icon': Icons.check_circle_outline,
      'title': 'Use With ensureVisible',
      'body': 'Scrollable.ensureVisible(context) internally uses '
          'animateTo() if the target widget is offscreen. Under '
          'the hood, it creates a DrivenScrollActivity. You don\'t '
          'need to calculate offsets manually.',
      'severity': 'tip',
    },
    {
      'icon': Icons.warning_amber,
      'title': 'TickerProvider Requirement',
      'body': 'DrivenScrollActivity needs a TickerProvider (vsync). '
          'If the widget tree doesn\'t have one, animateTo() will '
          'throw. Ensure the nearest Scrollable has a valid '
          'TickerProvider (usually provided by the framework).',
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
      title: Text('DrivenScrollActivity'),
      backgroundColor: Colors.cyan[700],
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
                colors: [Colors.cyan[700]!, Colors.teal[500]!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.animation, color: Colors.white, size: 40),
                SizedBox(height: 12),
                Text(
                  'DrivenScrollActivity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'A ScrollActivity that animates the scroll position to '
                  'a target offset using an AnimationController. Created '
                  'by ScrollPosition.animateTo() — the workhorse behind '
                  'every programmatic scroll animation in Flutter.',
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
          _dsHead('1', 'What is DrivenScrollActivity?'),
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

          // ── Section 2: Hierarchy ──
          _dsHead('2', 'ScrollActivity Hierarchy'),
          SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(14),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: hierarchy.map((h) {
                final depth = h['depth'] as int;
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: 8, left: depth * 20.0),
                  child: Row(children: [
                    if (depth > 0)
                      Padding(
                        padding: EdgeInsets.only(right: 6),
                        child: Text('└─',
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 10,
                                color: Colors.grey[400])),
                      ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: (h['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: h['color'] as Color),
                      ),
                      child: Text(h['name'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              fontFamily: 'monospace',
                              color: h['color'] as Color)),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(h['note'] as String,
                          style: TextStyle(
                              fontSize: 9,
                              color: Colors.grey[600])),
                    ),
                  ]),
                );
              }).toList(),
            ),
          ),

          SizedBox(height: 24),

          // ── Section 3: Creation ──
          _dsHead('3', 'How It Is Created'),
          SizedBox(height: 12),
          ...creationSteps.map((cs) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cs['color'] as Color, width: 4),
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
                          color: cs['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text('${cs['step']}',
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
                            Text(cs['title'] as String,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                            SizedBox(height: 4),
                            Text(cs['detail'] as String,
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

          // ── Section 4: Comparison ──
          _dsHead('4', 'animateTo() vs moveTo() vs jumpTo()'),
          SizedBox(height: 12),
          ...comparison.map((cm) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cm['color'] as Color, width: 4),
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
                        Icon(cm['icon'] as IconData,
                            color: cm['color'] as Color, size: 20),
                        SizedBox(width: 8),
                        _dsTag(cm['method'] as String,
                            cm['color'] as Color),
                      ]),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(cm['sig'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.cyan[200],
                                height: 1.4)),
                      ),
                      SizedBox(height: 8),
                      Text(cm['desc'] as String,
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[700],
                              height: 1.4)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 5: Internals ──
          _dsHead('5', 'Internal Architecture'),
          SizedBox(height: 12),
          ...internals.map((ic) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ic['color'] as Color, width: 4),
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
                      Text(ic['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(ic['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.cyan[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 6: Interactions ──
          _dsHead('6', 'Activity Transitions'),
          SizedBox(height: 12),
          ...interactions.map((ia) => Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: ia['color'] as Color, width: 4),
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
                        _dsTag(ia['from'] as String,
                            Colors.cyan[700]!),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 6),
                          child: Icon(Icons.arrow_forward,
                              size: 14, color: Colors.grey[400]),
                        ),
                        _dsTag(ia['to'] as String,
                            ia['color'] as Color),
                      ]),
                      SizedBox(height: 6),
                      Text('Trigger: ${ia['trigger']}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 11,
                              color: ia['color'] as Color)),
                      SizedBox(height: 4),
                      Text(ia['detail'] as String,
                          style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey[700],
                              height: 1.3)),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 7: Code Patterns ──
          _dsHead('7', 'Code Patterns'),
          SizedBox(height: 12),
          ...codePatterns.map((cp) => Padding(
                padding: EdgeInsets.only(bottom: 14),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border(
                      left: BorderSide(
                          color: cp['color'] as Color, width: 4),
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
                      Text(cp['title'] as String,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13)),
                      SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey[900],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(cp['code'] as String,
                            style: TextStyle(
                                fontFamily: 'monospace',
                                fontSize: 9,
                                color: Colors.cyan[200],
                                height: 1.4)),
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 24),

          // ── Section 8: Common Mistakes ──
          _dsHead('8', 'Common Mistakes'),
          SizedBox(height: 12),
          ...mistakes.map((m) {
            Color bgColor;
            switch (m['severity']) {
              case 'error':
                bgColor = Colors.red[50]!;
                break;
              case 'warning':
                bgColor = Colors.amber[50]!;
                break;
              default:
                bgColor = Colors.blue[50]!;
            }
            return Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border(
                    left: BorderSide(
                        color: m['color'] as Color, width: 4),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(children: [
                      Icon(m['icon'] as IconData,
                          color: m['color'] as Color, size: 20),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(m['title'] as String,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                                color: m['color'] as Color)),
                      ),
                    ]),
                    SizedBox(height: 6),
                    Text(m['body'] as String,
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[800],
                            height: 1.4)),
                  ],
                ),
              ),
            );
          }),

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
              'End of DrivenScrollActivity Deep Demo',
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
          color: Colors.cyan[700],
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
